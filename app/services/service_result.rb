#-- encoding: UTF-8

#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2017 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

class ServiceResult
  attr_accessor :success,
                :errors,
                :result

  def initialize(success: false,
                 errors: ActiveModel::Errors.new(self),
                 result: nil)
    self.success = success
    self.errors = errors
    self.result = result
  end

  alias success? :success

  def failure?
    !success?
  end

  def merge!(other)
    merge_success!(other)
    merge_errors!(other)
    merge_result!(other)
  end

  private

  def merge_success!(other)
    self.success &&= other.success
  end

  def merge_result!(other)
    if other.result.is_a?(Array)
      self.result += other.result
    else
      self.result << other.result
    end
  end

  def merge_errors!(other)
    if other.errors.is_a?(Array)
      self.errors += other.errors
    else
      self.errors << other.errors
    end
  end
end
