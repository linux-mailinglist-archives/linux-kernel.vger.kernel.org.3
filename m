Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C894E61FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349531AbiCXKv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242718AbiCXKv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E747547046
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648118993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wCrmT9JFiGgC1/evMY/N9wheo9zCPwLWuhdExk30iDw=;
        b=XFI+uRIs9vPfIeIPtPwsfbdtGpcBl0mYgsHEVEVGEg5iGcDk8402IU+AqUxRpIsbzCq2EE
        o8qnuy7T47N2L0LTSQRg2n8uQMPGwAnkgBG+JGpnK2oe7em+qvY+taPJKzQuZKDeqA6jSb
        SZq1BRyR8exkuSZ2K3FJKiMBg9zVWWc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-7Z-C4zEHPPGx7hm-sWxx7g-1; Thu, 24 Mar 2022 06:49:51 -0400
X-MC-Unique: 7Z-C4zEHPPGx7hm-sWxx7g-1
Received: by mail-ed1-f71.google.com with SMTP id w8-20020a50d788000000b00418e6810364so2754006edi.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=wCrmT9JFiGgC1/evMY/N9wheo9zCPwLWuhdExk30iDw=;
        b=12+6zMKCgRolTAaxVf2KrkEHCi52vlGMuzMNktVLrppZJX8q50mZeJOOlwDvtzhZbj
         XAZfU8PAnF3lehw5pN8z6sZ8gU5xtnme1VJaeTQ3EYKvvfKvJJrgBGvTD4+vOqn4n/Yh
         aC23raJ4exDVlN3H+45rBBGl9DpfAC3mIm911FEr6w0q0AUl4vs5tBAamuW0v1Ma0ThX
         zvHXmZqncGVK8cLhTsv60tdAh9+KI0S3NQrxyD2NXZz7Oon2av+545Uxl2Jdy2lzSCbP
         IH7M1xJVsWkEUW0sQ/2ZS09aZaGty4kDRFCw17yQPWfkUP75fdE+JXWwPih9lax9m3LW
         7BKA==
X-Gm-Message-State: AOAM530+0rTAdAzkTBnLUObQbjmVFmazbqSr4rEtTp5Ok6p/YhwdFYEq
        b9anxkR8r7MFffAnFqsaC4AcZ3YeVAVLKaTC9db+2qtS/ovNiNFNHl+8bsbBgibXNjOcGRltyWl
        VClyxRyv56QSMd2QFQYlf9Oik
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id y13-20020a056402440d00b004129e8a5e51mr6021758eda.362.1648118989801;
        Thu, 24 Mar 2022 03:49:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzwIKJV4dCeNhWU460t5J7ED4+HJXWEnGSd+H5wiTSyTtwMS3JeU13ZFNvpWzugucj3iwxyA==
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id y13-20020a056402440d00b004129e8a5e51mr6021728eda.362.1648118989434;
        Thu, 24 Mar 2022 03:49:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b0040f13865fa9sm1239106edt.3.2022.03.24.03.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 03:49:49 -0700 (PDT)
Message-ID: <bd0e83ec-f42c-4617-5c1c-57501177afe6@redhat.com>
Date:   Thu, 24 Mar 2022 11:49:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.18-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for v5.18.

Note this includes some small changes to other subsystems, which
are deps of some of the pdx86 changes. These were merged through
the pdx86 tree with Acks from their subsys maintainers.

Highlights:
- new drivers:
  - AMD Host System Management Port (HSMP)
  - Intel Software Defined Silicon
- removed drivers (functionality folded into other drivers):
  - intel_cht_int33fe_microb
  - surface3_button
- amd-pmc:
  - s2idle bug-fixes
  - Support for AMD Spill to DRAM STB feature
- hp-wmi:
  - Fix SW_TABLET_MODE detection method (and other fixes)
  - Support omen thermal profile policy v1
- serial-multi-instantiate:
  - Add SPI device support
  - Add support for CS35L41 amplifiers used in new laptops
- think-lmi:
  - syfs-class-firmware-attributes Certificate authentication support
- thinkpad_acpi:
  - Fixes + quirks
  - Add platform_profile support on AMD based ThinkPads
- x86-android-tablets
  - Improve Asus ME176C / TF103C support
  - Support Nextbook Ares 8, Lenovo Tab 2 830 and 1050 tablets
- Lots of various other small fixes and hardware-id additions

Unfortunately this time there is one very much non trivial
merge conflict and a second one which also needs some extra
attention:

1. drivers/platform/x86/amd-pmc.c:

My for-next is based on 5.17-rc1, after rc1 commit 32370191c085
("platform/x86: amd-pmc: Set QOS during suspend on CZN w/ timer wakeup")
landed in my for-next branch, this was cherry-picked into my fixes
branch as commit 68af28426b3c and merged in to a later 5.17-rc# as such.
Last week AMD finished a fix for some other suspend/resume issues, which
makes the QoS workaround unnecessary, so this was reverted in my for-next
in commit 0d64787e24c6 ("platform/x86: amd-pmc: Drop CPU QoS workaround").

When merging this pull-req into v5.17 the first common commit is v5.17-rc1
which did not have the QoS workaround and neither has the
platform-drivers-x86-v5.18-1 tag. Since v5.17 does have the Qos workaround,
besides conflicting some parts of the merge which are not marked as
conflicting end up including the QoS workaround, which we no longer want.

The resolution for this is to simply take the entire amd-pmc.c file
from the platform-drivers-x86-v5.18-1 tag, overwriting the results of
the merge, so that the revert also "sticks" after the merge.

2. drivers/platform/x86/thinkpad_acpi.c

Some ThinkPads have 2 fans which requires special handling, so far this
has been handled by a quirk table, but since adding quirks 1 by 1 is
not ideal, this pull-req includes auto-detection of models with 2 fans.
We are not entirely sure if this will work everywhere, so models are only
removed from the quirk-table after testing.

The fan_quirk_table[] in v5.17 has the following entry:

        TPACPI_Q_LNV3('N', '3', '2', TPACPI_FAN_2CTL),  /* X1 Carbon (9th gen) */

Which was added post v5.17-rc1 as a fix and has been dropped in this
pull-req because the X1C9 has been confirmed to work with the auto-detect
code. So the conflict-resolution here is to simply drop this line.

Regards,

Hans



The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.18-1

for you to fetch changes up to b49f72e7f96d4ed147447428f2ae5b4cea598ca7:

  platform/x86: think-lmi: Certificate authentication support (2022-03-18 12:22:40 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.18-1

Highlights:
- new drivers:
  - AMD Host System Management Port (HSMP)
  - Intel Software Defined Silicon
- removed drivers (functionality folded into other drivers):
  - intel_cht_int33fe_microb
  - surface3_button
- amd-pmc:
  - s2idle bug-fixes
  - Support for AMD Spill to DRAM STB feature
- hp-wmi:
  - Fix SW_TABLET_MODE detection method (and other fixes)
  - Support omen thermal profile policy v1
- serial-multi-instantiate:
  - Add SPI device support
  - Add support for CS35L41 amplifiers used in new laptops
- think-lmi:
  - syfs-class-firmware-attributes Certificate authentication support
- thinkpad_acpi:
  - Fixes + quirks
  - Add platform_profile support on AMD based ThinkPads
- x86-android-tablets
  - Improve Asus ME176C / TF103C support
  - Support Nextbook Ares 8, Lenovo Tab 2 830 and 1050 tablets
- Lots of various other small fixes and hardware-id additions

The following is an automated git shortlog grouped by driver:

ACPI / scan:
 -  Create platform device for CS35L41

ACPI / x86:
 -  Add support for LPS0 callback handler

ALSA:
 -  hda/realtek: Add support for HP Laptops

Add AMD system management interface:
 - Add AMD system management interface

Add Intel Software Defined Silicon driver:
 - Add Intel Software Defined Silicon driver

Documentation:
 -  syfs-class-firmware-attributes: Lenovo Certificate support
 -  Add x86/amd_hsmp driver

ISST:
 -  Fix possible circular locking dependency detected

Input:
 -  soc_button_array - add support for Microsoft Surface 3 (MSHW0028) buttons

Merge remote-tracking branch 'pdx86/platform-drivers-x86-pinctrl-pmu_clk' into review-hans-gcc12:
 - Merge remote-tracking branch 'pdx86/platform-drivers-x86-pinctrl-pmu_clk' into review-hans-gcc12

Merge tag 'platform-drivers-x86-serial-multi-instantiate-1' into review-hans:
 - Merge tag 'platform-drivers-x86-serial-multi-instantiate-1' into review-hans

Replace acpi_bus_get_device():
 - Replace acpi_bus_get_device()

amd-pmc:
 -  Only report STB errors when STB enabled
 -  Drop CPU QoS workaround
 -  Output error codes in messages
 -  Move to later in the suspend process
 -  Validate entry into the deepest state on resume
 -  uninitialized variable in amd_pmc_s2d_init()
 -  Set QOS during suspend on CZN w/ timer wakeup
 -  Add support for AMD Spill to DRAM STB feature
 -  Correct usage of SMU version
 -  Make amd_pmc_stb_debugfs_fops static

asus-tf103c-dock:
 -  Make 2 global structs static

asus-wmi:
 -  Fix regression when probing for fan curve control

hp-wmi:
 -  support omen thermal profile policy v1
 -  Changing bios_args.data to be dynamically allocated
 -  Fix 0x05 error code reported by several WMI calls
 -  Fix SW_TABLET_MODE detection method
 -  Fix hp_wmi_read_int() reporting error (0x05)

huawei-wmi:
 -  check the return value of device_create_file()

i2c-multi-instantiate:
 -  Rename it for a generic serial driver name

int3472:
 -  Add terminator to gpiod_lookup_table

intel-uncore-freq:
 -  fix uncore_freq_common_init() error codes

intel_cht_int33fe:
 -  Move to intel directory
 -  Drop Lenovo Yogabook YB1-X9x code
 -  Switch to DMI modalias based loading

intel_crystal_cove_charger:
 -  Fix IRQ masking / unmasking

lg-laptop:
 -  Move setting of battery charge limit to common location

pinctrl:
 -  baytrail: Add pinconf group + function for the pmu_clk

platform/dcdbas:
 -  move EXPORT_SYMBOL after function

platform/surface:
 -  Remove Surface 3 Button driver
 -  surface3-wmi: Simplify resource management
 -  Replace acpi_bus_get_device()
 -  Reinstate platform dependency

platform/x86/intel-uncore-freq:
 -  Split common and enumeration part

platform/x86/intel/uncore-freq:
 -  Display uncore current frequency
 -  Use sysfs API to create attributes
 -  Move to uncore-frequency folder

selftests:
 -  sdsi: test sysfs setup

serial-multi-instantiate:
 -  Add SPI support
 -  Reorganize I2C functions

spi:
 -  Add API to count spi acpi resources
 -  Support selection of the index of the ACPI Spi Resource before alloc
 -  Create helper API to lookup ACPI info for spi device
 -  Make spi_alloc_device and spi_add_device public again

surface:
 -  surface3_power: Fix battery readings on batteries without a serial number

think-lmi:
 -  Certificate authentication support

thinkpad_acpi:
 -  consistently check fan_get_status return.
 -  Don't use test_bit on an integer
 -  Fix compiler warning about uninitialized err variable
 -  clean up dytc profile convert
 -  Add PSC mode support
 -  Add dual fan probe
 -  Add dual-fan quirk for T15g (2nd gen)
 -  Fix incorrect use of platform profile on AMD platforms
 -  Add quirk for ThinkPads without a fan

tools arch x86:
 -  Add Intel SDSi provisiong tool

touchscreen_dmi:
 -  Add info for the RWC NANOTE P8 AY07J 2-in-1

x86-android-tablets:
 -  Depend on EFI and SPI
 -  Lenovo Yoga Tablet 2 830/1050 sound support
 -  Workaround Lenovo Yoga Tablet 2 830/1050 poweroff hang
 -  Add Lenovo Yoga Tablet 2 830 / 1050 data
 -  Fix EBUSY error when requesting IOAPIC IRQs
 -  Minor charger / fuel-gauge improvements
 -  Add Nextbook Ares 8 data
 -  Add IRQ to Asus ME176C accelerometer info
 -  Add lid-switch gpio-keys pdev to Asus ME176C + TF103C
 -  Add x86_android_tablet_get_gpiod() helper
 -  Add Asus ME176C/TF103C charger and fuelgauge props
 -  Add battery swnode support
 -  Trivial typo fix for MODULE_AUTHOR
 -  Fix the buttons on CZC P10T tablet
 -  Constify the gpiod_lookup_tables arrays
 -  Add an init() callback to struct x86_dev_info
 -  Add support for disabling ACPI _AEI handlers
 -  Correct crystal_cove_charger module name

----------------------------------------------------------------
Alexander Kobel (1):
      platform/x86: thinkpad_acpi: Add quirk for ThinkPads without a fan

Christophe JAILLET (1):
      platform/surface: surface3-wmi: Simplify resource management

Dan Carpenter (2):
      platform/x86: intel-uncore-freq: fix uncore_freq_common_init() error codes
      platform/x86: amd-pmc: uninitialized variable in amd_pmc_s2d_init()

Daniel Scally (1):
      platform/x86: int3472: Add terminator to gpiod_lookup_table

David E. Box (3):
      platform/x86: Add Intel Software Defined Silicon driver
      tools arch x86: Add Intel SDSi provisiong tool
      selftests: sdsi: test sysfs setup

Enver Balalic (1):
      platform/x86: hp-wmi: support omen thermal profile policy v1

Geert Uytterhoeven (1):
      platform/surface: Reinstate platform dependency

Hans de Goede (32):
      platform/x86: x86-android-tablets: Correct crystal_cove_charger module name
      platform/x86: x86-android-tablets: Add support for disabling ACPI _AEI handlers
      platform/x86: x86-android-tablets: Add an init() callback to struct x86_dev_info
      platform/x86: x86-android-tablets: Constify the gpiod_lookup_tables arrays
      platform/x86: intel_crystal_cove_charger: Fix IRQ masking / unmasking
      platform/x86: amd-pmc: Make amd_pmc_stb_debugfs_fops static
      platform/x86: asus-tf103c-dock: Make 2 global structs static
      Merge tag 'platform-drivers-x86-serial-multi-instantiate-1' into review-hans
      platform/x86: thinkpad_acpi: Add dual-fan quirk for T15g (2nd gen)
      platform/x86: asus-wmi: Fix regression when probing for fan curve control
      platform/x86: x86-android-tablets: Add battery swnode support
      platform/x86: x86-android-tablets: Add Asus ME176C/TF103C charger and fuelgauge props
      platform/x86: x86-android-tablets: Add x86_android_tablet_get_gpiod() helper
      platform/x86: x86-android-tablets: Add lid-switch gpio-keys pdev to Asus ME176C + TF103C
      platform/x86: x86-android-tablets: Add IRQ to Asus ME176C accelerometer info
      platform/x86: x86-android-tablets: Add Nextbook Ares 8 data
      platform/x86: x86-android-tablets: Minor charger / fuel-gauge improvements
      platform/x86: intel_cht_int33fe: Switch to DMI modalias based loading
      platform/x86: intel_cht_int33fe: Drop Lenovo Yogabook YB1-X9x code
      platform/x86: intel_cht_int33fe: Move to intel directory
      pinctrl: baytrail: Add pinconf group + function for the pmu_clk
      surface: surface3_power: Fix battery readings on batteries without a serial number
      Merge remote-tracking branch 'pdx86/platform-drivers-x86-pinctrl-pmu_clk' into review-hans-gcc12
      platform/x86: x86-android-tablets: Fix EBUSY error when requesting IOAPIC IRQs
      platform/x86: x86-android-tablets: Add Lenovo Yoga Tablet 2 830 / 1050 data
      platform/x86: x86-android-tablets: Workaround Lenovo Yoga Tablet 2 830/1050 poweroff hang
      platform/x86: x86-android-tablets: Lenovo Yoga Tablet 2 830/1050 sound support
      Input: soc_button_array - add support for Microsoft Surface 3 (MSHW0028) buttons
      platform/surface: Remove Surface 3 Button driver
      platform/x86: x86-android-tablets: Depend on EFI and SPI
      platform/x86: thinkpad_acpi: Fix compiler warning about uninitialized err variable
      platform/x86: thinkpad_acpi: Don't use test_bit on an integer

Jia-Ju Bai (1):
      platform/x86: huawei-wmi: check the return value of device_create_file()

Jorge Lopez (4):
      platform/x86: hp-wmi: Fix hp_wmi_read_int() reporting error (0x05)
      platform/x86: hp-wmi: Fix SW_TABLET_MODE detection method
      platform/x86: hp-wmi: Fix 0x05 error code reported by several WMI calls
      platform/x86: hp-wmi: Changing bios_args.data to be dynamically allocated

Lubomir Rintel (2):
      platform/x86: x86-android-tablets: Fix the buttons on CZC P10T tablet
      platform/x86: x86-android-tablets: Trivial typo fix for MODULE_AUTHOR

Lucas Tanure (4):
      platform/x86: i2c-multi-instantiate: Rename it for a generic serial driver name
      platform/x86: serial-multi-instantiate: Reorganize I2C functions
      ALSA: hda/realtek: Add support for HP Laptops
      ACPI / scan: Create platform device for CS35L41

Mario Limonciello (8):
      platform/x86: amd-pmc: Correct usage of SMU version
      platform/x86: amd-pmc: Set QOS during suspend on CZN w/ timer wakeup
      platform/x86: amd-pmc: Validate entry into the deepest state on resume
      ACPI / x86: Add support for LPS0 callback handler
      platform/x86: amd-pmc: Move to later in the suspend process
      platform/x86: amd-pmc: Output error codes in messages
      platform/x86: amd-pmc: Drop CPU QoS workaround
      platform/x86: amd-pmc: Only report STB errors when STB enabled

Mark Pearson (6):
      platform/x86: thinkpad_acpi: Fix incorrect use of platform profile on AMD platforms
      platform/x86: thinkpad_acpi: Add dual fan probe
      platform/x86: thinkpad_acpi: Add PSC mode support
      platform/x86: thinkpad_acpi: clean up dytc profile convert
      Documentation: syfs-class-firmware-attributes: Lenovo Certificate support
      platform/x86: think-lmi: Certificate authentication support

Matan Ziv-Av (1):
      lg-laptop: Move setting of battery charge limit to common location

Mateusz Jończyk (1):
      platform/dcdbas: move EXPORT_SYMBOL after function

Naveen Krishna Chatradhi (1):
      Documentation: Add x86/amd_hsmp driver

Rafael J. Wysocki (2):
      platform/x86: Replace acpi_bus_get_device()
      platform/surface: Replace acpi_bus_get_device()

Sanket Goswami (1):
      platform/x86: amd-pmc: Add support for AMD Spill to DRAM STB feature

Srinivas Pandruvada (5):
      platform/x86: ISST: Fix possible circular locking dependency detected
      platform/x86/intel/uncore-freq: Move to uncore-frequency folder
      platform/x86/intel/uncore-freq: Use sysfs API to create attributes
      platform/x86/intel/uncore-freq: Display uncore current frequency
      platform/x86/intel-uncore-freq: Split common and enumeration part

Stefan Binding (5):
      spi: Make spi_alloc_device and spi_add_device public again
      spi: Create helper API to lookup ACPI info for spi device
      spi: Support selection of the index of the ACPI Spi Resource before alloc
      spi: Add API to count spi acpi resources
      platform/x86: serial-multi-instantiate: Add SPI support

Suma Hegde (1):
      platform/x86: Add AMD system management interface

Tom Rix (1):
      platform/x86: thinkpad_acpi: consistently check fan_get_status return.

Yuka Kawajiri (1):
      platform/x86: touchscreen_dmi: Add info for the RWC NANOTE P8 AY07J 2-in-1

 .../ABI/testing/sysfs-class-firmware-attributes    |  45 ++
 Documentation/ABI/testing/sysfs-driver-intel_sdsi  |  77 +++
 Documentation/ABI/testing/sysfs-platform-lg-laptop |   1 +
 Documentation/admin-guide/laptops/lg-laptop.rst    |   2 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
 Documentation/x86/amd_hsmp.rst                     |  86 +++
 Documentation/x86/index.rst                        |   1 +
 MAINTAINERS                                        |  23 +-
 arch/x86/include/asm/amd_hsmp.h                    |  16 +
 arch/x86/include/uapi/asm/amd_hsmp.h               | 203 ++++++
 drivers/acpi/scan.c                                |  21 +-
 drivers/acpi/x86/s2idle.c                          |  40 ++
 drivers/input/misc/soc_button_array.c              |  24 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c           |  10 +
 drivers/platform/surface/Kconfig                   |   8 +-
 drivers/platform/surface/Makefile                  |   1 -
 drivers/platform/surface/surface3-wmi.c            |  17 +-
 drivers/platform/surface/surface3_button.c         | 247 -------
 drivers/platform/surface/surface3_power.c          |  13 +-
 drivers/platform/surface/surface_acpi_notify.c     |   3 +-
 drivers/platform/x86/Kconfig                       |  28 +-
 drivers/platform/x86/Makefile                      |   3 +-
 drivers/platform/x86/amd-pmc.c                     | 243 +++++--
 drivers/platform/x86/amd_hsmp.c                    | 425 ++++++++++++
 drivers/platform/x86/asus-tf103c-dock.c            |   4 +-
 drivers/platform/x86/asus-wmi.c                    |   2 +-
 drivers/platform/x86/dell/dcdbas.c                 |   2 +-
 drivers/platform/x86/hp-wmi.c                      | 230 +++++--
 drivers/platform/x86/huawei-wmi.c                  |  13 +-
 drivers/platform/x86/i2c-multi-instantiate.c       | 174 -----
 drivers/platform/x86/intel/Kconfig                 |  47 +-
 drivers/platform/x86/intel/Makefile                |   9 +-
 .../intel_cht_int33fe_typec.c => chtwc_int33fe.c}  |  65 +-
 drivers/platform/x86/intel/crystal_cove_charger.c  |  26 +-
 drivers/platform/x86/intel/hid.c                   |   7 +-
 drivers/platform/x86/intel/int33fe/Kconfig         |  24 -
 drivers/platform/x86/intel/int33fe/Makefile        |   5 -
 .../x86/intel/int33fe/intel_cht_int33fe_common.c   | 118 ----
 .../x86/intel/int33fe/intel_cht_int33fe_common.h   |  41 --
 .../x86/intel/int33fe/intel_cht_int33fe_microb.c   |  61 --
 drivers/platform/x86/intel/int3472/discrete.c      |   5 +-
 .../x86/intel/int3472/tps68470_board_data.c        |   3 +-
 drivers/platform/x86/intel/sdsi.c                  | 574 ++++++++++++++++
 .../x86/intel/speed_select_if/isst_if_common.c     |  97 ++-
 drivers/platform/x86/intel/uncore-frequency.c      | 452 -------------
 .../platform/x86/intel/uncore-frequency/Kconfig    |  21 +
 .../platform/x86/intel/uncore-frequency/Makefile   |   9 +
 .../uncore-frequency/uncore-frequency-common.c     | 252 +++++++
 .../uncore-frequency/uncore-frequency-common.h     |  62 ++
 .../x86/intel/uncore-frequency/uncore-frequency.c  | 272 ++++++++
 drivers/platform/x86/intel/vbtn.c                  |   7 +-
 drivers/platform/x86/intel/vsec.c                  |  12 +-
 drivers/platform/x86/lg-laptop.c                   |  57 +-
 drivers/platform/x86/serial-multi-instantiate.c    | 348 ++++++++++
 drivers/platform/x86/think-lmi.c                   | 520 ++++++++++++---
 drivers/platform/x86/think-lmi.h                   |   5 +
 drivers/platform/x86/thinkpad_acpi.c               | 241 ++++---
 drivers/platform/x86/touchscreen_dmi.c             |  24 +
 drivers/platform/x86/x86-android-tablets.c         | 733 +++++++++++++++++++--
 drivers/spi/spi.c                                  | 137 +++-
 include/linux/acpi.h                               |  10 +-
 include/linux/spi/spi.h                            |  20 +
 sound/pci/hda/patch_realtek.c                      |  43 +-
 tools/arch/x86/intel_sdsi/Makefile                 |  21 +
 tools/arch/x86/intel_sdsi/intel_sdsi.c             | 558 ++++++++++++++++
 tools/testing/selftests/drivers/sdsi/sdsi.sh       |  25 +
 tools/testing/selftests/drivers/sdsi/sdsi_test.py  | 226 +++++++
 67 files changed, 5472 insertions(+), 1629 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
 create mode 100644 Documentation/x86/amd_hsmp.rst
 create mode 100644 arch/x86/include/asm/amd_hsmp.h
 create mode 100644 arch/x86/include/uapi/asm/amd_hsmp.h
 delete mode 100644 drivers/platform/surface/surface3_button.c
 create mode 100644 drivers/platform/x86/amd_hsmp.c
 delete mode 100644 drivers/platform/x86/i2c-multi-instantiate.c
 rename drivers/platform/x86/intel/{int33fe/intel_cht_int33fe_typec.c => chtwc_int33fe.c} (85%)
 delete mode 100644 drivers/platform/x86/intel/int33fe/Kconfig
 delete mode 100644 drivers/platform/x86/intel/int33fe/Makefile
 delete mode 100644 drivers/platform/x86/intel/int33fe/intel_cht_int33fe_common.c
 delete mode 100644 drivers/platform/x86/intel/int33fe/intel_cht_int33fe_common.h
 delete mode 100644 drivers/platform/x86/intel/int33fe/intel_cht_int33fe_microb.c
 create mode 100644 drivers/platform/x86/intel/sdsi.c
 delete mode 100644 drivers/platform/x86/intel/uncore-frequency.c
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/Kconfig
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/Makefile
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
 create mode 100644 drivers/platform/x86/serial-multi-instantiate.c
 create mode 100644 tools/arch/x86/intel_sdsi/Makefile
 create mode 100644 tools/arch/x86/intel_sdsi/intel_sdsi.c
 create mode 100755 tools/testing/selftests/drivers/sdsi/sdsi.sh
 create mode 100644 tools/testing/selftests/drivers/sdsi/sdsi_test.py

