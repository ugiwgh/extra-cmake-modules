# Once done this will define
#
#  NEPOMUK_FOUND - system has Nepomuk
#  NEPOMUK_INCLUDE_DIR - the Nepomuk include directory
#  NEPOMUK_LIBRARIES - Link these to use Nepomuk
#  NEPOMUK_QUERY_LIBRARIES - Link these to use Nepomuk query
#  NEPOMUK_UTILS_LIBRARIES - Link these to use Nepomuk utils
#  NEPOMUK_DEFINITIONS - Compiler switches required for using Nepomuk
#
# Nepomuk requires Soprano, so this module checks for Soprano too.
#


# Copyright (c) 2008-2009, Sebastian Trueg, <sebastian@trueg.de>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.


if (NOT DEFINED Soprano_FOUND)
  find_package(Soprano ${SOPRANO_MIN_VERSION})
  include(MacroLogFeature)
  macro_log_feature(Soprano_FOUND "Soprano" "Support for the Nepomuk semantic desktop system" "http://soprano.sourceforge.net" FALSE "" "")
endif (NOT DEFINED Soprano_FOUND)

if (NOT DEFINED SHAREDDESKTOPONTOLOGIES_FOUND)
  find_package(SharedDesktopOntologies)
  include(MacroLogFeature)
  macro_log_feature(SHAREDDESKTOPONTOLOGIES_FOUND "Shared desktop ontologies" "Support for the Nepomuk semantic desktop system" "http://oscaf.sourceforge.net" FALSE "" "")
endif (NOT DEFINED SHAREDDESKTOPONTOLOGIES_FOUND)

# Check for the following stuff independent from whether soprano has been found
# or not. This will give a better error message at the end.
find_path(NEPOMUK_INCLUDE_DIR
  NAMES
  nepomuk/resource.h
  HINTS
  ${KDE4_INCLUDE_DIR}
  ${INCLUDE_INSTALL_DIR}
  )

find_library(NEPOMUK_LIBRARIES
  NAMES
  nepomuk
  HINTS
  ${KDE4_LIB_DIR}
  ${LIB_INSTALL_DIR}
  )

find_library(NEPOMUK_QUERY_LIBRARIES
  NAMES
  nepomukquery
  HINTS
  ${KDE4_LIB_DIR}
  ${LIB_INSTALL_DIR}
  )

find_library(NEPOMUK_UTILS_LIBRARIES
  NAMES
  nepomukutils
  HINTS
  ${KDE4_LIB_DIR}
  ${LIB_INSTALL_DIR}
)

find_file(NEPOMUK_ADDONTOLOGYCLASSES_FILE NepomukAddOntologyClasses.cmake
          HINTS ${KDE4_DATA_INSTALL_DIR}/cmake/modules/
          PATH_SUFFIXES share/apps/cmake/modules/
         )

include("${NEPOMUK_ADDONTOLOGYCLASSES_FILE}" OPTIONAL)

mark_as_advanced(NEPOMUK_INCLUDE_DIR NEPOMUK_LIBRARIES NEPOMUK_QUERY_LIBRARIES NEPOMUK_UTILS_LIBRARIES NEPOMUK_ADDONTOLOGIES_FILE)

include(FindPackageHandleStandardArgs)
# List all nepomuk and also all necessary soprano variables here, to make it
# easier for the user to see what was missing:
if(NOT WINCE)
find_package_handle_standard_args(Nepomuk  DEFAULT_MSG
                                  NEPOMUK_LIBRARIES NEPOMUK_INCLUDE_DIR NEPOMUK_ADDONTOLOGYCLASSES_FILE
                                  Soprano_FOUND SOPRANO_PLUGIN_RAPTORPARSER_FOUND SOPRANO_PLUGIN_REDLANDBACKEND_FOUND
                                  SHAREDDESKTOPONTOLOGIES_FOUND
                                  )
else()
#FIXME: There are no backends at this time
find_package_handle_standard_args(Nepomuk  DEFAULT_MSG
                                  NEPOMUK_LIBRARIES NEPOMUK_INCLUDE_DIR NEPOMUK_ADDONTOLOGYCLASSES_FILE
                                  Soprano_FOUND
                                  SHAREDDESKTOPONTOLOGIES_FOUND
                                  )
endif()

#to retain backward compatibility
set (Nepomuk_FOUND ${NEPOMUK_FOUND})

