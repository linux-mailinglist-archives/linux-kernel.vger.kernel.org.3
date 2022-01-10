Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90ADF489668
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbiAJKcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243970AbiAJKbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641810709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+0A/scVt6c932wkM7KxVkqVlEAj02fsE05rjd7ec6IU=;
        b=OPS1Zyvjr2HibMCvIENGh3hSjnLgmF1GjSbhl401u+siQsvmpCyC3Sve2qsg8aVK0KoBp7
        EU6IHzfAHtVpU/BB9p2XS8hdqnNy8uzJokPuYTbLDtFl/GtpEUZpKWnnW4zZKBHF/hHZ0x
        QeLhs6n2J1KrjrAT4KX2zf3Dft32i+Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-NP9qpaczNJas2jFmSNxAZw-1; Mon, 10 Jan 2022 05:31:48 -0500
X-MC-Unique: NP9qpaczNJas2jFmSNxAZw-1
Received: by mail-ed1-f69.google.com with SMTP id z8-20020a056402274800b003f8580bfb99so9757428edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 02:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=+0A/scVt6c932wkM7KxVkqVlEAj02fsE05rjd7ec6IU=;
        b=wGE2cPX/wNzoYTZSU4PiRx9bqdRebLuG9MJKbXe0pJY2YKz8zQPU2xuOg5ewdtR9FT
         4YqK7ImXfEogyI9HuGQLFwBYEE9+B0HiSvlNZnq+IwaV8rtoNFlAtacol5wMNTgvpBtT
         w+ac1CbkJqrJeV35kdQp5vzODYtK8cEKa5LWP9D1AxVLGbrwpHKz/bMr1VMDWrfODFFl
         MDV1wKA+lZF+UcnTcRuy09snnQA3zVAHYnl4pf6gmlSTxvwau5wK4GNKkpe7+BLZPZjM
         YxFJm10N5riFBReuRT29A0PrFI8sYMgAw9+ZhITsfyBkz5R966kjPGpQbzdqciYdljzL
         tz3Q==
X-Gm-Message-State: AOAM532SJyuPby7e/uDFqmD5RwVBrhXldehH26ppw9DhnnY+ReZb/DW7
        kySdtEz2KQa4aWe5vtyuFXBaBiNBRx64fWfjx0skNl1cflguSQf+6I9lsF5mVnu+FfQXazuUUCI
        MG34MTA4NP8x7FkrWEvFHMbuw
X-Received: by 2002:a05:6402:120e:: with SMTP id c14mr18521666edw.40.1641810706548;
        Mon, 10 Jan 2022 02:31:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzskptq1tATHZmSnIs0f0jv3peR3H69UmufnwZNlIhty/Mhko7eZQc44VvYgfI2qZkdjIv6Mg==
X-Received: by 2002:a05:6402:120e:: with SMTP id c14mr18521649edw.40.1641810706319;
        Mon, 10 Jan 2022 02:31:46 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id c9sm2308972ejf.10.2022.01.10.02.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 02:31:45 -0800 (PST)
Message-ID: <aea4c26b-25a1-9480-f780-7eb3502a4ce4@redhat.com>
Date:   Mon, 10 Jan 2022 11:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.17-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for v5.17.

Note this includes some ACPI and power-supply core changes which
are deps of some of the pdx86 changes. These were merged through
the pdx86 tree with Acks from their subsys maintainers.

Highlights:
 - new drivers:
   - asus-tf103c-dock
   - intel_crystal_cove_charger
   - lenovo-yogabook-wmi
   - simatic-ipc platform-code + led driver + watchdog driver
   - x86-android-tablets (kernel module to workaround DSDT bugs on these)
 - amd-pmc:
   - bug-fixes
   - smart trace buffer support
 - asus-wmi: support for custom fan curves
 - int3472 (camera info ACPI object for Intel IPU3/SkyCam cameras):
   - ACPI core + int3472 changes to delay enumeration of camera sensor I2C
     clients until the PMIC for the sensor has been fully probed
   - Add support for board data (DSDT info is incomplete) for setting up
     the tps68470 PMIC used on some boards with these cameras
   - Add board data for the Microsoft Surface Go (original, v2 and v3)
 - thinkpad_acpi:
   - various cleanups
   - support for forced battery discharging (for battery calibration)
   - support to inhibit battery charging
   - this includes power_supply core changes to add new APIs for this
 - think_lmi: enhanced BIOS password support
 - various other small fixes and hardware-id additions

Regards,

Hans



The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.17-1

for you to fetch changes up to 3367d1bd738c01b2737eaab7d922bfe5f1a41f38:

  power: supply: Provide stubs for charge_behaviour helpers (2022-01-08 16:56:01 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.17-1

Highlights:
 - new drivers:
   - asus-tf103c-dock
   - intel_crystal_cove_charger
   - lenovo-yogabook-wmi
   - simatic-ipc platform-code + led driver + watchdog driver
   - x86-android-tablets (kernel module to workaround DSDT bugs on these)
 - amd-pmc:
   - bug-fixes
   - smar trace buffer support
 - asus-wmi: support for custom fan curves
 - int3472 (camera info ACPI object for Intel IPU3/SkyCam cameras):
   - ACPI core + int3472 changes to delay enumeration of camera sensor I2C
     clients until the PMIC for the sensor has been fully probed
   - Add support for board data (DSDT info is incomplete) for setting up
     the tps68470 PMIC used on some boards with these cameras
   - Add board data for the Microsoft Surface Go (original, v2 and v3)
 - thinkpad_acpi:
   - various cleanups
   - support for forced battery discharging (for battery calibration)
   - support to inhibit battery charging
   - this includes power_supply core changes to add new APIs for this
 - think_lmi: enhanced BIOS password support
 - various other small fixes and hardware-id additions

The following is an automated git shortlog grouped by driver:

ACPI:
 -  delay enumeration of devices with a _DEP pointing to an INT3472 device

Add Asus TF103C dock driver:
 - Add Asus TF103C dock driver

Add intel_crystal_cove_charger driver:
 - Add intel_crystal_cove_charger driver

Documentation:
 -  syfs-class-firmware-attributes: Lenovo Opcode support

Merge tag 'platform-drivers-x86-int3472-1' into review-hans:
 - Merge tag 'platform-drivers-x86-int3472-1' into review-hans

amd-pmc:
 -  only use callbacks for suspend
 -  Add support for AMD Smart Trace Buffer
 -  Simplify error handling and store the pci_dev in amd_pmc_dev structure
 -  Fix s2idle failures on certain AMD laptops
 -  Make CONFIG_AMD_PMC depend on RTC_CLASS

apple-gmux:
 -  use resource_size() with res

asus-wmi:
 -  Reshuffle headers for better maintenance
 -  Split MODULE_AUTHOR() on per author basis
 -  Join string literals back
 -  remove unneeded semicolon
 -  Add support for custom fan curves

dell-wmi-descriptor:
 -  disable by default

hp_accel:
 -  Use SIMPLE_DEV_PM_OPS() for PM ops
 -  Fix an error handling path in 'lis3lv02d_probe()'

i2c:
 -  acpi: Add i2c_acpi_new_device_by_fwnode() function
 -  acpi: Use acpi_dev_ready_for_enumeration() helper

int3472:
 -  Add board data for Surface Go 3
 -  Deal with probe ordering issues
 -  Pass tps68470_regulator_platform_data to the tps68470-regulator MFD-cell
 -  Pass tps68470_clk_platform_data to the tps68470-regulator MFD-cell
 -  Add get_sensor_adev_and_name() helper
 -  Split into 2 drivers

intel-uncore-frequency:
 -  use default_groups in kobj_type

intel_pmc_core:
 -  fix memleak on registration failure

leds:
 -  simatic-ipc-leds: add new driver for Siemens Industial PCs

lenovo-yogabook-wmi:
 -  Add support for hall sensor on the back
 -  Add driver for Lenovo Yoga Book

lg-laptop:
 -  Recognize more models

platform:
 -  surface: Propagate ACPI Dependency

platform/mellanox:
 -  mlxbf-pmc: Fix an IS_ERR() vs NULL bug in mlxbf_pmc_map_counters
 -  mlxreg-lc: fix error code in mlxreg_lc_create_static_devices()

platform/surface:
 -  aggregator_registry: Rename device registration function
 -  aggregator_registry: Use generic client removal function
 -  aggregator: Make client device removal more generic

platform/x86/intel:
 -  Remove X86_PLATFORM_DRIVERS_INTEL
 -  hid: add quirk to support Surface Go 3

platform_data:
 -  Add linux/platform_data/tps68470.h file

pmc_atom:
 -  improve critclk_systems matching for Siemens PCs

power:
 -  supply: Provide stubs for charge_behaviour helpers
 -  supply: fix charge_behaviour attribute initialization
 -  supply: add helpers for charge_behaviour sysfs
 -  supply: add charge_behaviour attributes

samsung-laptop:
 -  Fix typo in a comment

simatic-ipc:
 -  add main driver for Siemens devices

system76_acpi:
 -  Guard System76 EC specific functionality

think-lmi:
 -  Prevent underflow in index_store()
 -  Simplify tlmi_analyze() error handling a bit
 -  Move kobject_init() call into tlmi_create_auth()
 -  Opcode support
 -  Abort probe on analyze failure

thinkpad_acpi:
 -  support inhibit-charge
 -  support force-discharge
 -  Add lid_logo_dot to the list of safe LEDs
 -  Add LED_RETAIN_AT_SHUTDOWN to led_class_devs
 -  Remove unused sensors_pdev_attrs_registered flag
 -  Fix the hwmon sysfs-attr showing up in the wrong place
 -  tpacpi_attr_group contains driver attributes not device attrs
 -  Register tpacpi_pdriver after subdriver init
 -  Restore missing hotkey_tablet_mode and hotkey_radio_sw sysfs-attr
 -  Fix thermal_temp_input_attr sorting
 -  Remove "goto err_exit" from hotkey_init()
 -  Properly indent code in tpacpi_dytc_profile_init()
 -  Cleanup dytc_profile_available
 -  Simplify dytc_version handling
 -  Make *_init() functions return -ENODEV instead of 1
 -  Accept ibm_init_struct.init() returning -ENODEV
 -  Convert platform driver to use dev_groups
 -  fix documentation for adaptive keyboard
 -  Fix WWAN device disabled issue after S3 deep
 -  Add support for dual fan control

tools/power/x86/intel-speed-select:
 -  v1.11 release
 -  Update max frequency

touchscreen_dmi:
 -  Remove the Glavey TM800A550L entry
 -  Enable pen support on the Chuwi Hi10 Plus and Pro
 -  Correct min/max values for Chuwi Hi10 Pro (CWI529) tablet
 -  Add TrekStor SurfTab duo W1 touchscreen info

watchdog:
 -  simatic-ipc-wdt: add new driver for Siemens Industrial PCs

wmi:
 -  Add no_notify_data flag to struct wmi_driver
 -  Fix driver->notify() vs ->probe() race
 -  Replace read_takes_no_args with a flags field

x86-android-tablets:
 -  Fix GPIO lookup leak on error-exit
 -  Add TM800A550L data
 -  Add Asus MeMO Pad 7 ME176C data
 -  Add Asus TF103C data
 -  Add support for preloading modules
 -  Add support for registering GPIO lookup tables
 -  Add support for instantiating serdevs
 -  Add support for instantiating platform-devs
 -  Add support for PMIC interrupts
 -  Don't return -EPROBE_DEFER from a non probe() function
 -  New driver for x86 Android tablets

x86/platform/uv:
 -  use default_groups in kobj_type

----------------------------------------------------------------
Alex Hung (1):
      platform/x86/intel: hid: add quirk to support Surface Go 3

Alex Williamson (1):
      platform/x86: think-lmi: Abort probe on analyze failure

Andy Shevchenko (5):
      platform/x86: hp_accel: Use SIMPLE_DEV_PM_OPS() for PM ops
      platform/x86: asus-wmi: Join string literals back
      platform/x86: asus-wmi: Split MODULE_AUTHOR() on per author basis
      platform/x86: asus-wmi: Reshuffle headers for better maintenance
      platform/x86/intel: Remove X86_PLATFORM_DRIVERS_INTEL

Christophe JAILLET (1):
      platform/x86: hp_accel: Fix an error handling path in 'lis3lv02d_probe()'

Dan Carpenter (2):
      platform/mellanox: mlxreg-lc: fix error code in mlxreg_lc_create_static_devices()
      platform/x86: think-lmi: Prevent underflow in index_store()

Daniel Scally (1):
      platform/x86: int3472: Add board data for Surface Go 3

Fabrizio Bertocci (1):
      platform/x86: amd-pmc: Fix s2idle failures on certain AMD laptops

Greg Kroah-Hartman (2):
      x86/platform/uv: use default_groups in kobj_type
      platform/x86: intel-uncore-frequency: use default_groups in kobj_type

Hans de Goede (48):
      platform/x86: amd-pmc: Make CONFIG_AMD_PMC depend on RTC_CLASS
      platform/x86: think-lmi: Move kobject_init() call into tlmi_create_auth()
      platform/x86: think-lmi: Simplify tlmi_analyze() error handling a bit
      platform/x86: thinkpad_acpi: Accept ibm_init_struct.init() returning -ENODEV
      platform/x86: thinkpad_acpi: Make *_init() functions return -ENODEV instead of 1
      platform/x86: thinkpad_acpi: Simplify dytc_version handling
      platform/x86: thinkpad_acpi: Cleanup dytc_profile_available
      platform/x86: thinkpad_acpi: Properly indent code in tpacpi_dytc_profile_init()
      platform/x86: thinkpad_acpi: Remove "goto err_exit" from hotkey_init()
      platform/x86: thinkpad_acpi: Fix thermal_temp_input_attr sorting
      platform/x86: thinkpad_acpi: Restore missing hotkey_tablet_mode and hotkey_radio_sw sysfs-attr
      platform/x86: thinkpad_acpi: Register tpacpi_pdriver after subdriver init
      platform/x86: thinkpad_acpi: tpacpi_attr_group contains driver attributes not device attrs
      platform/x86: thinkpad_acpi: Fix the hwmon sysfs-attr showing up in the wrong place
      platform/x86: thinkpad_acpi: Remove unused sensors_pdev_attrs_registered flag
      platform/x86: thinkpad_acpi: Add LED_RETAIN_AT_SHUTDOWN to led_class_devs
      platform/x86: thinkpad_acpi: Add lid_logo_dot to the list of safe LEDs
      platform/x86: touchscreen_dmi: Add TrekStor SurfTab duo W1 touchscreen info
      platform/x86: wmi: Replace read_takes_no_args with a flags field
      platform/x86: wmi: Fix driver->notify() vs ->probe() race
      platform/x86: wmi: Add no_notify_data flag to struct wmi_driver
      platform/x86: lenovo-yogabook-wmi: Add support for hall sensor on the back
      ACPI: delay enumeration of devices with a _DEP pointing to an INT3472 device
      i2c: acpi: Use acpi_dev_ready_for_enumeration() helper
      i2c: acpi: Add i2c_acpi_new_device_by_fwnode() function
      platform_data: Add linux/platform_data/tps68470.h file
      platform/x86: int3472: Split into 2 drivers
      platform/x86: int3472: Add get_sensor_adev_and_name() helper
      platform/x86: int3472: Pass tps68470_clk_platform_data to the tps68470-regulator MFD-cell
      platform/x86: int3472: Pass tps68470_regulator_platform_data to the tps68470-regulator MFD-cell
      platform/x86: int3472: Deal with probe ordering issues
      Merge tag 'platform-drivers-x86-int3472-1' into review-hans
      platform/x86: x86-android-tablets: New driver for x86 Android tablets
      platform/x86: Add intel_crystal_cove_charger driver
      platform/x86: touchscreen_dmi: Correct min/max values for Chuwi Hi10 Pro (CWI529) tablet
      platform/x86: touchscreen_dmi: Enable pen support on the Chuwi Hi10 Plus and Pro
      platform/x86: touchscreen_dmi: Remove the Glavey TM800A550L entry
      platform/x86: x86-android-tablets: Don't return -EPROBE_DEFER from a non probe() function
      platform/x86: x86-android-tablets: Add support for PMIC interrupts
      platform/x86: x86-android-tablets: Add support for instantiating platform-devs
      platform/x86: x86-android-tablets: Add support for instantiating serdevs
      platform/x86: x86-android-tablets: Add support for registering GPIO lookup tables
      platform/x86: x86-android-tablets: Add support for preloading modules
      platform/x86: x86-android-tablets: Add Asus TF103C data
      platform/x86: x86-android-tablets: Add Asus MeMO Pad 7 ME176C data
      platform/x86: x86-android-tablets: Add TM800A550L data
      platform/x86: Add Asus TF103C dock driver
      platform/x86: x86-android-tablets: Fix GPIO lookup leak on error-exit

Henning Schild (4):
      platform/x86: simatic-ipc: add main driver for Siemens devices
      leds: simatic-ipc-leds: add new driver for Siemens Industial PCs
      watchdog: simatic-ipc-wdt: add new driver for Siemens Industrial PCs
      platform/x86: pmc_atom: improve critclk_systems matching for Siemens PCs

Jarrett Schultz (1):
      platform: surface: Propagate ACPI Dependency

Jason Wang (1):
      platform/x86: samsung-laptop: Fix typo in a comment

Jimmy Wang (1):
      platform/x86: thinkpad_acpi: Add support for dual fan control

Johan Hovold (1):
      platform/x86: intel_pmc_core: fix memleak on registration failure

Len Baker (1):
      platform/x86: thinkpad_acpi: Convert platform driver to use dev_groups

Luke D. Jones (1):
      platform/x86: asus-wmi: Add support for custom fan curves

Mario Limonciello (1):
      platform/x86: amd-pmc: only use callbacks for suspend

Mark Pearson (2):
      Documentation: syfs-class-firmware-attributes: Lenovo Opcode support
      platform/x86: think-lmi: Opcode support

Matan Ziv-Av (1):
      platform/x86: lg-laptop: Recognize more models

Maximilian Luz (3):
      platform/surface: aggregator: Make client device removal more generic
      platform/surface: aggregator_registry: Use generic client removal function
      platform/surface: aggregator_registry: Rename device registration function

Miaoqian Lin (1):
      platform/mellanox: mlxbf-pmc: Fix an IS_ERR() vs NULL bug in mlxbf_pmc_map_counters

Sanket Goswami (2):
      platform/x86: amd-pmc: Simplify error handling and store the pci_dev in amd_pmc_dev structure
      platform/x86: amd-pmc: Add support for AMD Smart Trace Buffer

Slark Xiao (1):
      platform/x86: thinkpad_acpi: Fix WWAN device disabled issue after S3 deep

Srinivas Pandruvada (2):
      tools/power/x86/intel-speed-select: Update max frequency
      tools/power/x86/intel-speed-select: v1.11 release

Thomas Weißschuh (7):
      platform/x86: dell-wmi-descriptor: disable by default
      power: supply: add charge_behaviour attributes
      power: supply: add helpers for charge_behaviour sysfs
      platform/x86: thinkpad_acpi: support force-discharge
      platform/x86: thinkpad_acpi: support inhibit-charge
      power: supply: fix charge_behaviour attribute initialization
      power: supply: Provide stubs for charge_behaviour helpers

Tim Crawford (1):
      platform/x86: system76_acpi: Guard System76 EC specific functionality

Vincent Bernat (1):
      platform/x86: thinkpad_acpi: fix documentation for adaptive keyboard

Wang Qing (1):
      platform/x86: apple-gmux: use resource_size() with res

Yang Li (1):
      platform/x86: asus-wmi: remove unneeded semicolon

Yauhen Kharuzhy (1):
      platform/x86: lenovo-yogabook-wmi: Add driver for Lenovo Yoga Book

 .../ABI/testing/sysfs-class-firmware-attributes    |   32 +
 Documentation/ABI/testing/sysfs-class-power        |   14 +
 .../admin-guide/laptops/thinkpad-acpi.rst          |   12 +-
 MAINTAINERS                                        |   14 +
 drivers/acpi/scan.c                                |   37 +-
 drivers/i2c/i2c-core-acpi.c                        |   22 +-
 drivers/leds/Kconfig                               |    3 +
 drivers/leds/Makefile                              |    3 +
 drivers/leds/simple/Kconfig                        |   11 +
 drivers/leds/simple/Makefile                       |    2 +
 drivers/leds/simple/simatic-ipc-leds.c             |  202 ++++
 drivers/platform/mellanox/mlxbf-pmc.c              |    4 +-
 drivers/platform/mellanox/mlxreg-lc.c              |    5 +-
 drivers/platform/surface/Kconfig                   |    7 +-
 drivers/platform/surface/aggregator/Kconfig        |    1 +
 drivers/platform/surface/aggregator/bus.c          |   24 +-
 drivers/platform/surface/aggregator/bus.h          |    3 -
 drivers/platform/surface/aggregator/core.c         |    3 +-
 .../platform/surface/surface_aggregator_registry.c |   32 +-
 drivers/platform/x86/Kconfig                       |   63 +-
 drivers/platform/x86/Makefile                      |    8 +-
 drivers/platform/x86/amd-pmc.c                     |  165 +++-
 drivers/platform/x86/apple-gmux.c                  |    2 +-
 drivers/platform/x86/asus-tf103c-dock.c            |  945 ++++++++++++++++++
 drivers/platform/x86/asus-wmi.c                    |  605 +++++++++++-
 drivers/platform/x86/dell/Kconfig                  |    2 +-
 drivers/platform/x86/hp_accel.c                    |   29 +-
 drivers/platform/x86/intel/Kconfig                 |   15 -
 drivers/platform/x86/intel/Makefile                |    2 +
 drivers/platform/x86/intel/crystal_cove_charger.c  |  153 +++
 drivers/platform/x86/intel/hid.c                   |    7 +
 drivers/platform/x86/intel/int3472/Makefile        |    9 +-
 ...472_clk_and_regulator.c => clk_and_regulator.c} |    2 +-
 drivers/platform/x86/intel/int3472/common.c        |   82 ++
 .../{intel_skl_int3472_common.h => common.h}       |    6 +-
 .../{intel_skl_int3472_discrete.c => discrete.c}   |   51 +-
 .../x86/intel/int3472/intel_skl_int3472_common.c   |  106 --
 .../{intel_skl_int3472_tps68470.c => tps68470.c}   |   92 +-
 drivers/platform/x86/intel/int3472/tps68470.h      |   25 +
 .../x86/intel/int3472/tps68470_board_data.c        |  158 +++
 drivers/platform/x86/intel/pmc/pltdrv.c            |    2 +-
 drivers/platform/x86/intel/uncore-frequency.c      |    3 +-
 drivers/platform/x86/lenovo-yogabook-wmi.c         |  408 ++++++++
 drivers/platform/x86/lg-laptop.c                   |   12 +
 drivers/platform/x86/pmc_atom.c                    |   54 +-
 drivers/platform/x86/samsung-laptop.c              |    2 +-
 drivers/platform/x86/simatic-ipc.c                 |  176 ++++
 drivers/platform/x86/system76_acpi.c               |   58 +-
 drivers/platform/x86/think-lmi.c                   |  340 ++++++-
 drivers/platform/x86/think-lmi.h                   |   29 +-
 drivers/platform/x86/thinkpad_acpi.c               | 1019 +++++++++++---------
 drivers/platform/x86/touchscreen_dmi.c             |   56 +-
 drivers/platform/x86/uv_sysfs.c                    |    6 +-
 drivers/platform/x86/wmi.c                         |   27 +-
 drivers/platform/x86/x86-android-tablets.c         |  870 +++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c          |   56 ++
 drivers/watchdog/Kconfig                           |   11 +
 drivers/watchdog/Makefile                          |    1 +
 drivers/watchdog/simatic-ipc-wdt.c                 |  228 +++++
 include/acpi/acpi_bus.h                            |    5 +-
 include/linux/i2c.h                                |   17 +-
 include/linux/platform_data/tps68470.h             |   35 +
 include/linux/platform_data/x86/asus-wmi.h         |    2 +
 include/linux/platform_data/x86/simatic-ipc-base.h |   29 +
 include/linux/platform_data/x86/simatic-ipc.h      |   72 ++
 include/linux/power_supply.h                       |   31 +
 include/linux/surface_aggregator/device.h          |    9 +
 include/linux/wmi.h                                |    1 +
 tools/power/x86/intel-speed-select/isst-config.c   |    4 +-
 69 files changed, 5619 insertions(+), 902 deletions(-)
 create mode 100644 drivers/leds/simple/Kconfig
 create mode 100644 drivers/leds/simple/Makefile
 create mode 100644 drivers/leds/simple/simatic-ipc-leds.c
 create mode 100644 drivers/platform/x86/asus-tf103c-dock.c
 create mode 100644 drivers/platform/x86/intel/crystal_cove_charger.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_clk_and_regulator.c => clk_and_regulator.c} (99%)
 create mode 100644 drivers/platform/x86/intel/int3472/common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_common.h => common.h} (94%)
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_discrete.c => discrete.c} (91%)
 delete mode 100644 drivers/platform/x86/intel/int3472/intel_skl_int3472_common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_tps68470.c => tps68470.c} (56%)
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470.h
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470_board_data.c
 create mode 100644 drivers/platform/x86/lenovo-yogabook-wmi.c
 create mode 100644 drivers/platform/x86/simatic-ipc.c
 create mode 100644 drivers/platform/x86/x86-android-tablets.c
 create mode 100644 drivers/watchdog/simatic-ipc-wdt.c
 create mode 100644 include/linux/platform_data/tps68470.h
 create mode 100644 include/linux/platform_data/x86/simatic-ipc-base.h
 create mode 100644 include/linux/platform_data/x86/simatic-ipc.h

