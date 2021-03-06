# == Schema Information
#
# Table name: messages
#
#  id             :uuid             not null, primary key
#  content        :text
#  location       :string(255)
#  password       :string(255)
#  latitude       :float
#  longitude      :float
#  created_at     :datetime
#  updated_at     :datetime
#  encryption_key :string(255)
#  salt           :string(255)
#

class Message < ActiveRecord::Base
  validates :content, presence: true

  geocoded_by :location
  after_validation :geocode, :check_geocode

  attr_accessor :gen_password, :pre_encryption

  def check_geocode
    if self.location != "" && self.latitude == nil
      errors.add(:location, "couldn't be found. Please try something else.")
    end
  end
end
