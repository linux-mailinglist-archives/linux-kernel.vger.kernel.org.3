Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE089589A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiHDKsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiHDKst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 840143DF39
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659610126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DunOeUvRxOqkw3KvohWbs7RDwq1pyy6KTb6rtr8e0B4=;
        b=C9RhNsyENlLC01um+PSKd1rfv+Y/uAqiQVAD5t3ArqTO9bLtbDIrUt9XeMGoSqs3O/jiBC
        Fcy4koy1P5Gr1V1unfYnbK0GTikVsurN9hexp8ZZxHCnhiARX1KU4jQQ9VAHmdw3th2Kiq
        jjtYd1lux/oM0oRQtXUZSvV2KEWN7bk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-9RUKsGvsOwGoW344zygp_A-1; Thu, 04 Aug 2022 06:48:45 -0400
X-MC-Unique: 9RUKsGvsOwGoW344zygp_A-1
Received: by mail-ej1-f70.google.com with SMTP id hp22-20020a1709073e1600b007309edc4089so2652289ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 03:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=DunOeUvRxOqkw3KvohWbs7RDwq1pyy6KTb6rtr8e0B4=;
        b=Tw6MUiO0f6wmd8sMIQF75WBCy1uliV6puCE5M81scU6QehE4QqFK+bsB/TVjphcBr7
         RPa3OwTUyFSgi+Scr8/cNmJwAs58ltq5D2w6+9Mg3qGm+C4LcQ0wab2uzujQDIEslfEp
         lpwmhEQADzq1DmbpMPHqJxuORh5wOC06N4GY7aLxGpbafBrKrU3UpefaY+UeXnlki5es
         yzi9KHFqkvVC6DD5IJf81JOQLkztjfXC32EwvH+woWw4OMqTZ94KXgz5MaACW7TFy96S
         1EYMudD/tUwH5W3izLb25gow81HCKcACbfQF0GV1SQ3fcnQB3o89ETq6zkXmZshhkIgR
         gGIg==
X-Gm-Message-State: ACgBeo2v534IXre23lVvFK4QbGUGb2YEcvKmxjTfh4AFEteDoxu5A61L
        zDcy37CCrpghH+NNpxQHjG0JzxGEy2Na9x8NqIROb3FqoZHtyd03er8E6Dg6gwyptwPQPfSdeKd
        pbP3kIX5t/QEC5CLPuU9EAgPb
X-Received: by 2002:a05:6402:5489:b0:43b:b935:db37 with SMTP id fg9-20020a056402548900b0043bb935db37mr1415219edb.347.1659610124065;
        Thu, 04 Aug 2022 03:48:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7wFNx1IRNg8bR7vS3wclHg53nr+d7t3TE01HMsPS+iYn2A/kDmwty1xWAxkHD8HH1vmy5O5w==
X-Received: by 2002:a05:6402:5489:b0:43b:b935:db37 with SMTP id fg9-20020a056402548900b0043bb935db37mr1415203edb.347.1659610123774;
        Thu, 04 Aug 2022 03:48:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906528200b0072b3406e9c2sm206251ejm.95.2022.08.04.03.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 03:48:43 -0700 (PDT)
Message-ID: <19d29009-ab84-fffc-82dd-9754e65b092e@redhat.com>
Date:   Thu, 4 Aug 2022 12:48:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.0-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for 6.0.

Note this is a resend with the subject fixed to make sure that you
don't disregard this, sorry about that.

Highlights:
 -  Microsoft Surface:
    - SSAM hot unplug support
    - Surface Pro 8 keyboard cover support
    - Tablet mode switch support for Surface Pro 8 and Surface Laptop Studio
 -  thinkpad_acpi: AMD Automatice Mode Transitions (AMT) support
 -  asus-wmi: Mic mute LED support
 -  Mellanox:
    - Vulcan chassis COMe NVSwitch management support
    - XH3000 support
 -  New generic/shared Intel P2SB (Primary to Sideband) support
    (merged through ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-v5.20)
 -  Lots of small cleanups
 -  Various small bugfixes
    (most already send in 5.19 fixes pull-reqs)
 -  Various new hardware ids / quirks additions

Note this does touch some files outside of drivers/platform. All these
changes have been Acked by their resp. subsystem maintainers and most
of these changes come from the merging of the
ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-v5.20 tag.

Regards,

Hans


The following changes since commit d4fe9cc4ff8656704b58cfd9363d7c3c9d65e519:

  platform/x86/intel: hid: Add Surface Go to VGBS allow list (2022-06-12 14:41:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.0-1

for you to fetch changes up to 3d46d78480757e6d403c3bc2b32d2b05ecbed543:

  platform/x86/intel/vsec: Fix wrong type for local status variables (2022-08-01 16:56:34 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.0-1

Highlights:
 -  Microsoft Surface:
    - SSAM hot unplug support
    - Surface Pro 8 keyboard cover support
    - Tablet mode switch support for Surface Pro 8 and Surface Laptop Studio
 -  thinkpad_acpi: AMD Automatice Mode Transitions (AMT) support
 -  Mellanox:
    - Vulcan chassis COMe NVSwitch management support
    - XH3000 support
 - New generic/shared Intel P2SB (Primary to Sideband) support
 - Lots of small cleanups
 - Various small bugfixes
 - Various new hardware ids / quirks additions

The following is an automated git shortlog grouped by driver:

ACPI:
 -  video: Fix acpi_video_handles_brightness_key_presses()
 -  video: Change how we determine if brightness key-presses are handled

Documentation/ABI:
 -  Add new attributes for mlxreg-io sysfs interfaces
 -  mlxreg-io: Fix contact info

Drop the PMC_ATOM Kconfig option:
 - Drop the PMC_ATOM Kconfig option

EDAC, pnd2:
 -  convert to use common P2SB accessor
 -  Use proper I/O accessors and address space annotation

HID:
 -  surface-hid: Add support for hot-removal

ISST:
 -  PUNIT device mapping with Sub-NUMA clustering

Kconfig:
 -  Remove unnecessary "if X86"

MAINTAINERS:
 -  repair file entry in MICROSOFT SURFACE AGGREGATOR TABLET-MODE SWITCH

Merge tag 'ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-v5.20' into review-hans:
 - Merge tag 'ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-v5.20' into review-hans

Move AMD platform drivers to separate directory:
 - Move AMD platform drivers to separate directory

acer-wmi:
 -  Use backlight helper

acer_wmi:
 -  Cleanup Kconfig selects

apple-gmux:
 -  Use backlight helper

asus-wmi:
 -  Add mic-mute LED classdev support
 -  Add key mappings

compal-laptop:
 -  Use backlight helper

efi:
 -  Fix efi_power_off() not being run before acpi_power_off() when necessary

gigabyte-wmi:
 -  add support for B660I AORUS PRO DDR4

hp-wmi:
 -  Ignore Sanitization Mode event

i2c:
 -  i801: convert to use common P2SB accessor

ideapad-laptop:
 -  Add Ideapad 5 15ITL05 to ideapad_dytc_v4_allow_table[]
 -  Add allow_v4_dytc module parameter

intel/pmc:
 -  Add Alder Lake N support to PMC core driver

intel_atomisp2_led:
 -  Also turn off the always-on camera LED on the Asus T100TAF

leds:
 -  simatic-ipc-leds-gpio: Add GPIO version of Siemens driver
 -  simatic-ipc-leds: Convert to use P2SB accessor

mfd:
 -  lpc_ich: Add support for pinctrl in non-ACPI system
 -  lpc_ich: Switch to generic p2sb_bar()
 -  lpc_ich: Factor out lpc_ich_enable_spi_write()

mlx-platform:
 -  Add COME board revision register
 -  Add support for new system XH3000
 -  Introduce support for COMe NVSwitch management module for Vulcan chassis
 -  Add support for systems equipped with two ASICs
 -  Add cosmetic changes for alignment
 -  Make activation of some drivers conditional

p2sb:
 -  Move out of X86_PLATFORM_DEVICES dependency

panasonic-laptop:
 -  Use acpi_video_get_backlight_type()
 -  filter out duplicate volume up/down/mute keypresses
 -  don't report duplicate brightness key-presses
 -  revert "Resolve hotkey double trigger bug"
 -  sort includes alphabetically
 -  de-obfuscate button codes

pinctrl:
 -  intel: Check against matching data instead of ACPI companion

platform/mellanox:
 -  mlxreg-lc: Fix error flow and extend verbosity
 -  mlxreg-io: Add locking for io operations
 -  nvsw-sn2201: fix error code in nvsw_sn2201_create_static_devices()

platform/olpc:
 -  Fix uninitialized data in debugfs write

platform/surface:
 -  gpe: Add support for 13" Intel version of Surface Laptop 4
 -  tabletsw: Fix __le32 integer access
 -  Update copyright year of various drivers
 -  aggregator: Move subsystem hub drivers to their own module
 -  aggregator: Move device registry helper functions to core module
 -  aggregator_registry: Add support for tablet mode switch on Surface Laptop Studio
 -  aggregator_registry: Add support for tablet mode switch on Surface Pro 8
 -  Add KIP/POS tablet-mode switch driver
 -  aggregator: Add helper macros for requests with argument and return value
 -  aggregator: Reserve more event- and target-categories
 -  avoid flush_scheduled_work() usage
 -  aggregator_registry: Add support for keyboard cover on Surface Pro 8
 -  aggregator_registry: Add KIP device hub
 -  aggregator_registry: Change device ID for base hub
 -  aggregator_registry: Generify subsystem hub functionality
 -  aggregator: Add comment for KIP subsystem category
 -  aggregator_registry: Use client device wrappers for notifier registration
 -  aggregator: Allow notifiers to avoid communication on unregistering
 -  aggregator: Allow devices to be marked as hot-removed
 -  aggregator: Allow is_ssam_device() to be used when CONFIG_SURFACE_AGGREGATOR_BUS is disabled

platform/x86/amd/pmc:
 -  Add new platform support
 -  Add new acpi id for PMC controller

platform/x86/dell:
 -  Kconfig: Remove unnecessary "depends on X86_PLATFORM_DEVICES"

platform/x86/intel:
 -  Add Primary to Sideband (P2SB) bridge support

platform/x86/intel/ifs:
 -  Mark as BROKEN

platform/x86/intel/pmt:
 -  telemetry: Fix fixed region handling

platform/x86/intel/vsec:
 -  Fix wrong type for local status variables
 -  Add PCI error recovery support to Intel PMT
 -  Add support for Raptor Lake
 -  Rework early hardware code

pmc_atom:
 -  Fix comment typo
 -  Match all Lex BayTrail boards with critclk_systems DMI table

power/supply:
 -  surface_battery: Use client device wrappers for notifier registration
 -  surface_charger: Use client device wrappers for notifier registration

serial-multi-instantiate:
 -  Sort ACPI IDs by HID
 -  Get rid of redundant 'else'
 -  Use while (i--) pattern to clean up
 -  Improve dev_err_probe() messaging
 -  Drop duplicate check
 -  Improve autodetection

simatic-ipc:
 -  drop custom P2SB bar code

sony-laptop:
 -  Remove useless comparisons in sony_pic_read_possible_resource()

system76_acpi:
 -  Use dev_get_drvdata

thinkpad_acpi:
 -  Enable AMT by default on supported systems
 -  Add support for hotkey 0x131a
 -  Add support for automatic mode transitions
 -  profile capabilities as integer
 -  do not use PSC mode on Intel platforms
 -  Fix a memory leak of EFCH MMIO resource
 -  Replace custom str_on_off() etc
 -  Sort headers for better maintenance
 -  Use backlight helper

tools/power/x86/intel-speed-select:
 -  Remove unneeded semicolon
 -  Fix off by one check

watchdog:
 -  simatic-ipc-wdt: convert to use P2SB accessor

x86-android-tablets:
 -  Fix Lenovo Yoga Tablet 2 830/1050 poweroff again

----------------------------------------------------------------
Andrey Strachuk (1):
      platform/x86: sony-laptop: Remove useless comparisons in sony_pic_read_possible_resource()

Andy Shevchenko (15):
      platform/x86: thinkpad_acpi: Sort headers for better maintenance
      platform/x86: thinkpad_acpi: Replace custom str_on_off() etc
      platform/x86: serial-multi-instantiate: Improve autodetection
      platform/x86: serial-multi-instantiate: Drop duplicate check
      platform/x86: serial-multi-instantiate: Improve dev_err_probe() messaging
      platform/x86: serial-multi-instantiate: Use while (i--) pattern to clean up
      platform/x86: serial-multi-instantiate: Get rid of redundant 'else'
      platform/x86: serial-multi-instantiate: Sort ACPI IDs by HID
      pinctrl: intel: Check against matching data instead of ACPI companion
      mfd: lpc_ich: Factor out lpc_ich_enable_spi_write()
      mfd: lpc_ich: Switch to generic p2sb_bar()
      i2c: i801: convert to use common P2SB accessor
      EDAC, pnd2: Use proper I/O accessors and address space annotation
      EDAC, pnd2: convert to use common P2SB accessor
      platform/x86: p2sb: Move out of X86_PLATFORM_DEVICES dependency

Dan Carpenter (3):
      platform/mellanox: nvsw-sn2201: fix error code in nvsw_sn2201_create_static_devices()
      tools/power/x86/intel-speed-select: Fix off by one check
      platform/olpc: Fix uninitialized data in debugfs write

David E. Box (3):
      platform/x86/intel/vsec: Rework early hardware code
      platform/x86/intel/vsec: Add support for Raptor Lake
      platform/x86/intel/pmt: telemetry: Fix fixed region handling

Gayatri Kammela (2):
      platform/x86: intel/pmc: Add Alder Lake N support to PMC core driver
      platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT

Hans de Goede (20):
      platform/x86: Drop the PMC_ATOM Kconfig option
      platform/x86: acer_wmi: Cleanup Kconfig selects
      platform/x86: Kconfig: Remove unnecessary "if X86"
      platform/x86/dell: Kconfig: Remove unnecessary "depends on X86_PLATFORM_DEVICES"
      platform/x86: ideapad-laptop: Add allow_v4_dytc module parameter
      platform/x86: ideapad-laptop: Add Ideapad 5 15ITL05 to ideapad_dytc_v4_allow_table[]
      ACPI: video: Change how we determine if brightness key-presses are handled
      platform/x86: panasonic-laptop: sort includes alphabetically
      platform/x86: panasonic-laptop: revert "Resolve hotkey double trigger bug"
      platform/x86: panasonic-laptop: don't report duplicate brightness key-presses
      platform/x86: panasonic-laptop: filter out duplicate volume up/down/mute keypresses
      platform/x86: panasonic-laptop: Use acpi_video_get_backlight_type()
      platform/x86: x86-android-tablets: Fix Lenovo Yoga Tablet 2 830/1050 poweroff again
      efi: Fix efi_power_off() not being run before acpi_power_off() when necessary
      platform/x86/intel/ifs: Mark as BROKEN
      platform/x86: intel_atomisp2_led: Also turn off the always-on camera LED on the Asus T100TAF
      ACPI: video: Fix acpi_video_handles_brightness_key_presses()
      platform/x86: pmc_atom: Match all Lex BayTrail boards with critclk_systems DMI table
      Merge tag 'ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-v5.20' into review-hans
      platform/x86/intel/vsec: Fix wrong type for local status variables

Haowen Bai (1):
      platform/x86: system76_acpi: Use dev_get_drvdata

Henning Schild (4):
      watchdog: simatic-ipc-wdt: convert to use P2SB accessor
      leds: simatic-ipc-leds: Convert to use P2SB accessor
      platform/x86: simatic-ipc: drop custom P2SB bar code
      leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver

Jean Delvare (1):
      platform/x86: thinkpad_acpi: Fix a memory leak of EFCH MMIO resource

Jonathan Yong (1):
      platform/x86/intel: Add Primary to Sideband (P2SB) bridge support

Kai-Heng Feng (1):
      platform/x86: hp-wmi: Ignore Sanitization Mode event

Lukas Bulwahn (1):
      MAINTAINERS: repair file entry in MICROSOFT SURFACE AGGREGATOR TABLET-MODE SWITCH

Mark Pearson (5):
      platform/x86: thinkpad-acpi: profile capabilities as integer
      platform/x86: thinkpad-acpi: Add support for automatic mode transitions
      platform/x86: thinkpad-acpi: Add support for hotkey 0x131a
      platform/x86: thinkpad-acpi: Enable AMT by default on supported systems
      platform/x86: thinkpad_acpi: do not use PSC mode on Intel platforms

Maximilian Luz (22):
      platform/surface: aggregator: Allow is_ssam_device() to be used when CONFIG_SURFACE_AGGREGATOR_BUS is disabled
      platform/surface: aggregator: Allow devices to be marked as hot-removed
      platform/surface: aggregator: Allow notifiers to avoid communication on unregistering
      platform/surface: aggregator_registry: Use client device wrappers for notifier registration
      power/supply: surface_charger: Use client device wrappers for notifier registration
      power/supply: surface_battery: Use client device wrappers for notifier registration
      HID: surface-hid: Add support for hot-removal
      platform/surface: aggregator: Add comment for KIP subsystem category
      platform/surface: aggregator_registry: Generify subsystem hub functionality
      platform/surface: aggregator_registry: Change device ID for base hub
      platform/surface: aggregator_registry: Add KIP device hub
      platform/surface: aggregator_registry: Add support for keyboard cover on Surface Pro 8
      platform/surface: aggregator: Reserve more event- and target-categories
      platform/surface: aggregator: Add helper macros for requests with argument and return value
      platform/surface: Add KIP/POS tablet-mode switch driver
      platform/surface: aggregator_registry: Add support for tablet mode switch on Surface Pro 8
      platform/surface: aggregator_registry: Add support for tablet mode switch on Surface Laptop Studio
      platform/surface: aggregator: Move device registry helper functions to core module
      platform/surface: aggregator: Move subsystem hub drivers to their own module
      platform/surface: Update copyright year of various drivers
      platform/surface: tabletsw: Fix __le32 integer access
      platform/surface: gpe: Add support for 13" Intel version of Surface Laptop 4

Misaka19465 (1):
      platform/x86: asus-wmi: Add key mappings

PaddyKP_Yao (1):
      platform/x86: asus-wmi: Add mic-mute LED classdev support

Pär Eriksson (1):
      platform/x86: gigabyte-wmi: add support for B660I AORUS PRO DDR4

Shyam Sundar S K (3):
      platform/x86: Move AMD platform drivers to separate directory
      platform/x86/amd/pmc: Add new acpi id for PMC controller
      platform/x86/amd/pmc: Add new platform support

Srinivas Pandruvada (1):
      platform/x86: ISST: PUNIT device mapping with Sub-NUMA clustering

Stefan Seyfried (1):
      platform/x86: panasonic-laptop: de-obfuscate button codes

Stephen Kitt (4):
      platform/x86: acer-wmi: Use backlight helper
      platform/x86: apple-gmux: Use backlight helper
      platform/x86: compal-laptop: Use backlight helper
      platform/x86: thinkpad_acpi: Use backlight helper

Tan Jui Nee (1):
      mfd: lpc_ich: Add support for pinctrl in non-ACPI system

Tetsuo Handa (1):
      platform/surface: avoid flush_scheduled_work() usage

Vadim Pasternak (10):
      platform/x86: mlx-platform: Make activation of some drivers conditional
      platform/x86: mlx-platform: Add cosmetic changes for alignment
      platform/x86: mlx-platform: Add support for systems equipped with two ASICs
      platform/x86: mlx-platform: Introduce support for COMe NVSwitch management module for Vulcan chassis
      platform/x86: mlx-platform: Add support for new system XH3000
      platform/x86: mlx-platform: Add COME board revision register
      platform/mellanox: mlxreg-io: Add locking for io operations
      Documentation/ABI: mlxreg-io: Fix contact info
      Documentation/ABI: Add new attributes for mlxreg-io sysfs interfaces
      platform/mellanox: mlxreg-lc: Fix error flow and extend verbosity

Xin Gao (2):
      tools/power/x86/intel-speed-select: Remove unneeded semicolon
      platform/x86: pmc_atom: Fix comment typo

 Documentation/ABI/stable/sysfs-driver-mlxreg-io    |  81 +++-
 .../testing/sysfs-bus-surface_aggregator-tabletsw  |  57 +++
 .../driver-api/surface_aggregator/client.rst       |   6 +-
 MAINTAINERS                                        |  16 +-
 drivers/acpi/acpi_video.c                          |  16 +-
 drivers/clk/x86/Makefile                           |   4 +-
 drivers/edac/Kconfig                               |   1 +
 drivers/edac/pnd2_edac.c                           |  62 +--
 drivers/firmware/efi/reboot.c                      |  21 +-
 drivers/hid/surface-hid/surface_hid_core.c         |  38 +-
 drivers/i2c/busses/Kconfig                         |   1 +
 drivers/i2c/busses/i2c-i801.c                      |  39 +-
 drivers/leds/simple/Kconfig                        |   6 +-
 drivers/leds/simple/Makefile                       |   1 +
 drivers/leds/simple/simatic-ipc-leds-gpio.c        | 105 ++++
 drivers/leds/simple/simatic-ipc-leds.c             |  80 +---
 drivers/mfd/Kconfig                                |   1 +
 drivers/mfd/lpc_ich.c                              | 161 +++++--
 drivers/pinctrl/intel/pinctrl-intel.c              |  14 +-
 drivers/platform/Kconfig                           |   5 +-
 drivers/platform/mellanox/mlxreg-io.c              |  23 +
 drivers/platform/mellanox/mlxreg-lc.c              |  82 +++-
 drivers/platform/mellanox/nvsw-sn2201.c            |   4 +-
 drivers/platform/olpc/olpc-ec.c                    |   2 +-
 drivers/platform/surface/Kconfig                   |  58 ++-
 drivers/platform/surface/Makefile                  |   2 +
 drivers/platform/surface/aggregator/Kconfig        |   2 +-
 drivers/platform/surface/aggregator/Makefile       |   2 +-
 drivers/platform/surface/aggregator/bus.c          | 151 +++++-
 drivers/platform/surface/aggregator/bus.h          |   2 +-
 drivers/platform/surface/aggregator/controller.c   |  55 ++-
 drivers/platform/surface/aggregator/controller.h   |   2 +-
 drivers/platform/surface/aggregator/core.c         |   2 +-
 drivers/platform/surface/aggregator/ssh_msgb.h     |   2 +-
 .../platform/surface/aggregator/ssh_packet_layer.c |   2 +-
 .../platform/surface/aggregator/ssh_packet_layer.h |   2 +-
 drivers/platform/surface/aggregator/ssh_parser.c   |   2 +-
 drivers/platform/surface/aggregator/ssh_parser.h   |   2 +-
 .../surface/aggregator/ssh_request_layer.c         |   2 +-
 .../surface/aggregator/ssh_request_layer.h         |   2 +-
 drivers/platform/surface/aggregator/trace.h        |  82 ++--
 drivers/platform/surface/surface_acpi_notify.c     |  29 +-
 drivers/platform/surface/surface_aggregator_cdev.c |   2 +-
 drivers/platform/surface/surface_aggregator_hub.c  | 371 ++++++++++++++
 .../platform/surface/surface_aggregator_registry.c | 362 ++------------
 .../platform/surface/surface_aggregator_tabletsw.c | 533 +++++++++++++++++++++
 drivers/platform/surface/surface_dtx.c             |   2 +-
 drivers/platform/surface/surface_gpe.c             |  14 +-
 drivers/platform/surface/surface_hotplug.c         |   2 +-
 .../platform/surface/surface_platform_profile.c    |   2 +-
 drivers/platform/x86/Kconfig                       |  54 +--
 drivers/platform/x86/Makefile                      |   9 +-
 drivers/platform/x86/acer-wmi.c                    |   7 +-
 drivers/platform/x86/amd/Kconfig                   |  31 ++
 drivers/platform/x86/amd/Makefile                  |  10 +
 drivers/platform/x86/{amd_hsmp.c => amd/hsmp.c}    |   0
 drivers/platform/x86/{amd-pmc.c => amd/pmc.c}      |  14 +-
 drivers/platform/x86/apple-gmux.c                  |   5 +-
 drivers/platform/x86/asus-nb-wmi.c                 |   2 +
 drivers/platform/x86/asus-wmi.c                    |  25 +
 drivers/platform/x86/compal-laptop.c               |   4 +-
 drivers/platform/x86/dell/Kconfig                  |   1 -
 drivers/platform/x86/gigabyte-wmi.c                |   1 +
 drivers/platform/x86/hp-wmi.c                      |   3 +
 drivers/platform/x86/ideapad-laptop.c              |  29 +-
 drivers/platform/x86/intel/atomisp2/led.c          |   3 +-
 drivers/platform/x86/intel/ifs/Kconfig             |   3 +
 drivers/platform/x86/intel/pmc/core.c              |   1 +
 drivers/platform/x86/intel/pmt/class.c             |  23 +-
 drivers/platform/x86/intel/pmt/telemetry.c         |  18 +-
 .../x86/intel/speed_select_if/isst_if_common.c     |  39 +-
 drivers/platform/x86/intel/vsec.c                  | 130 ++++-
 drivers/platform/x86/intel/vsec.h                  |  11 +-
 drivers/platform/x86/mlx-platform.c                | 491 +++++++++++++++++--
 drivers/platform/x86/p2sb.c                        | 133 +++++
 drivers/platform/x86/panasonic-laptop.c            | 112 +++--
 drivers/platform/x86/pmc_atom.c                    |  19 +-
 drivers/platform/x86/serial-multi-instantiate.c    |  69 ++-
 drivers/platform/x86/simatic-ipc.c                 |  43 +-
 drivers/platform/x86/sony-laptop.c                 |   7 +-
 drivers/platform/x86/system76_acpi.c               |   4 +-
 drivers/platform/x86/thinkpad_acpi.c               | 219 +++++----
 drivers/platform/x86/x86-android-tablets.c         |  17 +-
 drivers/power/supply/surface_battery.c             |   4 +-
 drivers/power/supply/surface_charger.c             |   4 +-
 drivers/watchdog/Kconfig                           |   1 +
 drivers/watchdog/simatic-ipc-wdt.c                 |  15 +-
 include/linux/platform_data/x86/asus-wmi.h         |   1 +
 include/linux/platform_data/x86/p2sb.h             |  28 ++
 include/linux/platform_data/x86/pmc_atom.h         |   2 +-
 include/linux/platform_data/x86/simatic-ipc-base.h |   2 -
 include/linux/surface_aggregator/controller.h      | 149 +++++-
 include/linux/surface_aggregator/device.h          | 213 +++++++-
 include/linux/surface_aggregator/serial_hub.h      |  75 +--
 tools/power/x86/intel-speed-select/hfi-events.c    |   2 +-
 tools/power/x86/intel-speed-select/isst-daemon.c   |   2 +-
 96 files changed, 3441 insertions(+), 1109 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-surface_aggregator-tabletsw
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
 create mode 100644 drivers/platform/surface/surface_aggregator_hub.c
 create mode 100644 drivers/platform/surface/surface_aggregator_tabletsw.c
 create mode 100644 drivers/platform/x86/amd/Kconfig
 create mode 100644 drivers/platform/x86/amd/Makefile
 rename drivers/platform/x86/{amd_hsmp.c => amd/hsmp.c} (100%)
 rename drivers/platform/x86/{amd-pmc.c => amd/pmc.c} (98%)
 create mode 100644 drivers/platform/x86/p2sb.c
 create mode 100644 include/linux/platform_data/x86/p2sb.h


