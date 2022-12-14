# frozen_string_literal: true

require_relative "version"

# Sample input
# customer=
# {
#   name: "martin",
#   rentals: [
#     { movie_id: "F001", days: 3 },
#     { movie_id: "F002", days: 1 }
#   ]
# }

# movies=
# {
#   "F001" => { title: "Ran",                     code: "regular" },
#   "F002" => { title: "Trois Couleurs: Bleu",     code: "regular" }
# }

# Expected output
# "Rental Record for martin\n\tRan\t3.5\n\tTrois Couleurs: Bleu\t2\nAmount owed is 5.5\nYou earned 2 frequent renter points\n"

module MovieRental
  def self.statement(customer, movies)
    total_amount = 0
    frequent_renter_points = 0
    result = "Rental Record for #{customer[:name]}\n"

    customer[:rentals].each do |r|
      movie = movies[r[:movie_id]]
      this_amount = 0

      case movie[:code]
      when "regular"
        this_amount = 2
        if r[:days] > 2
          this_amount += (r[:days] - 2) * 1.5
        end
      when "new"
        this_amount = r[:days] * 3
      when "childrens"
        this_amount = 1.5
        if r[:days] > 3
          this_amount += (r[:days] - 3) * 1.5
        end
      end

      frequent_renter_points += 1
      if movie[:code] == "new" && r[:days] > 2
        frequent_renter_points += 1
      end

      result += "\t#{movie[:title]}\t#{this_amount}\n"
      total_amount += this_amount
    end

    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points\n"

    result
  end
end
