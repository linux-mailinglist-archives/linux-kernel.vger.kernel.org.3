Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2701489FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbiAJTNX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 14:13:23 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:41589 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbiAJTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:13:21 -0500
Received: by mail-qt1-f170.google.com with SMTP id f17so13074876qtf.8;
        Mon, 10 Jan 2022 11:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VuVoeNojOMOjjk/QESFHUzqMVanwVWoLBdUwgl83MrY=;
        b=crsvxWs4nJv6agsj6nwUyMgk+w94Uz7jvrJiwwgIe+V1ta2HYDAIXVV7d+Fq7ff8/j
         GbPO3KRfzTZSJYMr7R+zmGeg8WVIu3ouJ72Fc7h0Qj+6eXXEfAzBNStwJ4CWTUfSIDqc
         BdmxW4xCgVoke5aMBSP0LKbREeBDbPUhOYqjRrasd5VJF6KLKzkMkijAM99H6b5T3A7o
         7v3TDa8GZv0TyzKQ6pjTxuAzkAMAoms++zMn/De0ee9kuVjUR7p/v9t8PMhVoT7ww5zi
         qt03kcN4eC/gAKBw528pBMNGOiYsRj0XLeUajZvxw1WEroR0GEI/xoeawksFP1RKHs2a
         arfw==
X-Gm-Message-State: AOAM531pKtAee63m9oruXOfR1wRJ6T0eqPAc1D8xlmOgZLhyt7SiUg2k
        OYUq+0d9IwNsfk+/OFCOSAVTIeSivFu9EY5TwhHaqewzBvg=
X-Google-Smtp-Source: ABdhPJy9aHsiiQBlM7rUBjqviuU+TYyHYeUiirlZKGrfhR2TL8br/M45zOvxUD44PeFbrgsd6+fCiJsQAcEQ1vs7ESM=
X-Received: by 2002:ac8:5c89:: with SMTP id r9mr1023019qta.612.1641841998663;
 Mon, 10 Jan 2022 11:13:18 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Jan 2022 20:13:07 +0100
Message-ID: <CAJZ5v0hHd+um2KOmHvLuixMUoTSmD3=OdcGuXz0oLizJ0m3B=g@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.17-rc1

with top-most commit 70df8e1bdc941431af2370270f5140291dcbb282

 Merge branches 'acpi-tables', 'acpi-numa', 'acpi-sysfs', 'acpi-cppc',
'acpi-thermal' and 'acpi-battery'

on top of commit fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2

 Linux 5.16-rc7

to receive ACPI updates for 5.17-rc1.

These are usual ACPICA code updates (although there are more of them
than in the last few releases), a noticeable EC driver update (which
mostly consists of cleanups, though), the device enumeration quirks
handling rework from Hans, some updates eliminating unnecessary CPU
cache flushing in some places (processor idle and system-wide PM
code) and a bunch of assorted cleanups and fixes.

Specifics:

 - Update ACPICA code in the kernel to the 20211217 upstream release
   including the following changes:

   * iASL/Disassembler: Additional support for NHLT table (Bob Moore).
   * Change a return_ACPI_STATUS (AE_BAD_PARAMETER) (Bob Moore).
   * Fix a couple of warnings under MSVC (Bob Moore).
   * iASL: Add TDEL table to both compiler/disassembler (Bob Moore).
   * iASL/NHLT table: "Specific Data" field support (Bob Moore).
   * Use original data_table_region pointer for accesses (Jessica
     Clarke).
   * Use original pointer for virtual origin tables (Jessica Clarke).
   * Macros: Remove ACPI_PHYSADDR_TO_PTR (Jessica Clarke).
   * Avoid subobject buffer overflow when validating RSDP signature
     (Jessica Clarke).
   * iASL: Add suppport for AGDI table (Ilkka Koskinen).
   * Hardware: Do not flush CPU cache when entering S4 and S5 (Kirill
     A. Shutemov).
   * Expand the ACPI_ACCESS_ definitions (Mark Langsdorf).
   * Utilities: Avoid deleting the same object twice in a row (Rafael
     Wysocki).
   * Executer: Fix REFCLASS_REFOF case in acpi_ex_opcode_1A_0T_1R()
     (Rafael Wysocki).
   * Fix AEST Processor generic resource substructure data field byte
     length (Shuuichirou Ishii).
   * Fix wrong interpretation of PCC address (Sudeep Holla).
   * Add support for PCC Opregion special context data (Sudeep Holla).

 - Implement OperationRegion handler for PCC Type 3 subtype (Sudeep
   Holla).

 - Introduce acpi_fetch_acpi_dev() as a replacement for
   acpi_bus_get_device() and use it in the ACPI subsystem (Rafael
   Wysocki).

 - Avoid using _CID for device enumeration if _HID is missing or
   invalid (Rafael Wysocki).

 - Rework quirk handling during ACPI device enumeration and add some
   new quirks for known broken platforms (Hans de Goede).

 - Avoid unnecessary or redundant CPU cache flushing during system
   PM transitions (Kirill A. Shutemov).

 - Add PM debug messages related to power resources (Rafael Wysocki).

 - Fix kernel-doc comment in the PCI host bridge ACPI driver (Yang Li).

 - Rework flushing of EC work while suspended to idle and clean up
   the handling of events in the ACPI EC driver (Rafael Wysocki).

 - Prohibit ec_sys module parameter write_support from being used
   when the system is locked down (Hans de Goede).

 - Make the ACPI processor thermal driver use cpufreq_cpu_get() to
   check for presence of cpufreq policy (Manfred Spraul).

 - Avoid unnecessary CPU cache flushing in the ACPI processor idle
   driver (Kirill A. Shutemov).

 - Replace kernel.h with the necessary inclusions in the ACPI
   processor driver (Andy Shevchenko).

 - Use swap() instead of open coding it in the ACPI processor idle
   driver (Guo Zhengkui).

 - Fix the handling of defective LPAT in the ACPI xpower PMIC driver
   and clean up some definitions of PMIC data structures (Hans de
   Goede).

 - Fix outdated comment in the ACPI DPTF driver (Sumeet Pawnikar).

 - Add AEST to the list of known ACPI table signatures (Shuuichirou
   Ishii).

 - Make ACPI NUMA code take hotpluggable memblocks into account when
   CONFIG_MEMORY_HOTPLUG is not set (Vitaly Kuznetsov).

 - Use default_groups in kobj_type in the ACPI sysfs code (Greg
   Kroah-Hartman).

 - Rearrange _CPC structure documentation (Andy Shevchenko).

 - Drop an always true check from the ACPI thermal driver (Adam
   Borowski).

 - Add new "not charging" quirk for Lenovo ThinkPads to the ACPI
   battery driver (Thomas Weißschuh).

Thanks!


---------------

Adam Borowski (1):
      ACPI: thermal: drop an always true check

Andy Shevchenko (2):
      ACPI: processor: Replace kernel.h with the necessary inclusions
      ACPI: CPPC: Amend documentation in the comments

Bob Moore (6):
      ACPICA: iASL/Disassembler: Additional support for NHLT table
      ACPICA: Change a return_ACPI_STATUS (AE_BAD_PARAMETER)
      ACPICA: Fixed a couple of warnings under MSVC
      ACPICA: iASL: Add TDEL table to both compiler/disassembler
      ACPICA: iASL/NHLT table: "Specific Data" field support
      ACPICA: Update version to 20211217

Greg Kroah-Hartman (1):
      ACPI: sysfs: use default_groups in kobj_type

Guo Zhengkui (1):
      ACPI: processor idle: Use swap() instead of open coding it

Hans de Goede (17):
      ACPI / x86: Drop PWM2 device on Lenovo Yoga Book from always present table
      ACPI: Change acpi_device_always_present() into
acpi_device_override_status()
      ACPI / x86: Allow specifying acpi_device_override_status() quirks by path
      ACPI / x86: Add not-present quirk for the PCI0.SDHB.BRC1 device
on the GPD win
      ACPI / x86: Add PWM2 on the Xiaomi Mi Pad 2 to the always_present list
      mmc: sdhci-acpi: Remove special handling for GPD win/pocket devices
      mmc: sdhci-acpi: Use the new soc_intel_is_byt() helper
      ACPI: EC: Mark the ec_sys write_support param as module_param_hw()
      ACPI: PMIC: constify all struct intel_pmic_opregion_data declarations
      ACPI: PMIC: allow drivers to provide a custom lpat_raw_to_temp() function
      ACPI: PMIC: xpower: Fix _TMP ACPI errors
      ACPI: scan: Create platform device for BCM4752 and LNV4752 ACPI nodes
      ACPI / x86: Add acpi_quirk_skip_[i2c_client|serdev]_enumeration() helpers
      i2c: acpi: Do not instantiate I2C-clients on boards with known
bogus DSDT entries
      serdev: Do not instantiate serdevs on boards with known bogus DSDT entries
      ACPI / x86: Introduce an acpi_quirk_skip_acpi_ac_and_battery() helper
      ACPI / x86: Skip AC and battery devices on x86 Android tablets
with broken DSDTs

Ilkka Koskinen (1):
      ACPICA: iASL: Add support for AGDI table

Jessica Clarke (4):
      ACPICA: Use original data_table_region pointer for accesses
      ACPICA: Use original pointer for virtual origin tables
      ACPICA: Macros: Remove ACPI_PHYSADDR_TO_PTR
      ACPICA: Avoid subobject buffer overflow when validating RSDP signature

Kirill A. Shutemov (4):
      ACPI: PM: Avoid CPU cache flush when entering S4
      ACPI: processor: idle: Only flush cache on entering C3
      ACPI: PM: Remove redundant cache flushing
      ACPICA: Hardware: Do not flush CPU cache when entering S4 and S5

Manfred Spraul (1):
      ACPI: processor: thermal: avoid cpufreq_get_policy()

Mark Langsdorf (1):
      ACPICA: actypes.h: Expand the ACPI_ACCESS_ definitions

Rafael J. Wysocki (16):
      ACPI: PM: Emit debug messages when enabling/disabling wakeup power
      ACPI: scan: Do not add device IDs from _CID if _HID is not valid
      ACPI: EC: Rework flushing of EC work while suspended to idle
      ACPI: EC: Call advance_transaction() from acpi_ec_dispatch_gpe()
      ACPI: EC: Pass one argument to acpi_ec_query()
      ACPI: EC: Fold acpi_ec_check_event() into acpi_ec_event_handler()
      ACPI: EC: Rearrange the loop in acpi_ec_event_handler()
      ACPI: EC: Simplify locking in acpi_ec_event_handler()
      ACPI: EC: Rename three functions
      ACPI: EC: Avoid queuing unnecessary work in acpi_ec_submit_event()
      ACPI: EC: Make the event work state machine visible
      ACPI: EC: Relocate acpi_ec_create_query() and drop acpi_ec_delete_query()
      ACPI: scan: Introduce acpi_fetch_acpi_dev()
      ACPI: Use acpi_fetch_acpi_dev() instead of acpi_bus_get_device()
      ACPICA: Utilities: Avoid deleting the same object twice in a row
      ACPICA: Executer: Fix the REFCLASS_REFOF case in acpi_ex_opcode_1A_0T_1R()

Shuuichirou Ishii (2):
      ACPI: tables: Add AEST to the list of known table signatures
      ACPICA: Fix AEST Processor generic resource substructure data
field byte length

Sudeep Holla (3):
      ACPICA: Fix wrong interpretation of PCC address
      ACPICA: Add support for PCC Opregion special context data
      ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype

Sumeet Pawnikar (1):
      ACPI: DPTF: Update device ID in a comment

Thomas Weißschuh (1):
      ACPI: battery: Add the ThinkPad "Not Charging" quirk

Vitaly Kuznetsov (1):
      ACPI: NUMA: Process hotpluggable memblocks when !CONFIG_MEMORY_HOTPLUG

Yang Li (1):
      PCI/ACPI: Fix acpi_pci_osc_control_set() kernel-doc comment

---------------

 drivers/acpi/Kconfig                    |  17 ++
 drivers/acpi/Makefile                   |   1 +
 drivers/acpi/ac.c                       |  43 +----
 drivers/acpi/acpi_pcc.c                 | 120 ++++++++++++
 drivers/acpi/acpi_video.c               |   5 +-
 drivers/acpi/acpica/acevents.h          |   5 +
 drivers/acpi/acpica/acobject.h          |   1 +
 drivers/acpi/acpica/actables.h          |   8 +-
 drivers/acpi/acpica/dsopcode.c          |   1 +
 drivers/acpi/acpica/evhandler.c         |   2 +-
 drivers/acpi/acpica/evregion.c          |  10 +
 drivers/acpi/acpica/evrgnini.c          |  52 ++++++
 drivers/acpi/acpica/exconfig.c          |   2 +-
 drivers/acpi/acpica/excreate.c          |   1 +
 drivers/acpi/acpica/exfield.c           |   7 +-
 drivers/acpi/acpica/exoparg1.c          |   3 +-
 drivers/acpi/acpica/exregion.c          |  15 +-
 drivers/acpi/acpica/hwesleep.c          |   4 +-
 drivers/acpi/acpica/hwsleep.c           |   4 +-
 drivers/acpi/acpica/hwxfsleep.c         |   2 -
 drivers/acpi/acpica/tbdata.c            |  93 +++++++---
 drivers/acpi/acpica/tbfadt.c            |   6 +-
 drivers/acpi/acpica/tbinstal.c          |  15 +-
 drivers/acpi/acpica/tbprint.c           |   3 +-
 drivers/acpi/acpica/tbutils.c           |   2 +-
 drivers/acpi/acpica/tbxfload.c          |  52 ++++--
 drivers/acpi/acpica/utdelete.c          |   1 +
 drivers/acpi/battery.c                  |  46 ++---
 drivers/acpi/bus.c                      |   5 +-
 drivers/acpi/cppc_acpi.c                |  62 +++----
 drivers/acpi/device_pm.c                |  31 ++--
 drivers/acpi/device_sysfs.c             |   3 +-
 drivers/acpi/dock.c                     |   3 +-
 drivers/acpi/dptf/dptf_pch_fivr.c       |   2 +-
 drivers/acpi/ec.c                       | 317 ++++++++++++++++++--------------
 drivers/acpi/ec_sys.c                   |   2 +-
 drivers/acpi/internal.h                 |  12 +-
 drivers/acpi/numa/srat.c                |   5 +-
 drivers/acpi/pci_link.c                 |  12 +-
 drivers/acpi/pci_root.c                 |  12 +-
 drivers/acpi/pmic/intel_pmic.c          |  14 +-
 drivers/acpi/pmic/intel_pmic.h          |   8 +-
 drivers/acpi/pmic/intel_pmic_bxtwc.c    |   3 +-
 drivers/acpi/pmic/intel_pmic_bytcrc.c   |   3 +-
 drivers/acpi/pmic/intel_pmic_chtcrc.c   |   3 +-
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c |   3 +-
 drivers/acpi/pmic/intel_pmic_chtwc.c    |   3 +-
 drivers/acpi/pmic/intel_pmic_xpower.c   |  24 ++-
 drivers/acpi/power.c                    |  19 +-
 drivers/acpi/processor_driver.c         |  10 +-
 drivers/acpi/processor_idle.c           |  11 +-
 drivers/acpi/processor_thermal.c        |  13 +-
 drivers/acpi/property.c                 |  11 +-
 drivers/acpi/resource.c                 |   4 +-
 drivers/acpi/scan.c                     |  57 ++++--
 drivers/acpi/sleep.c                    |   5 -
 drivers/acpi/sysfs.c                    |   3 +-
 drivers/acpi/tables.c                   |   6 +-
 drivers/acpi/thermal.c                  |  11 +-
 drivers/acpi/video_detect.c             |   6 +-
 drivers/acpi/x86/s2idle.c               |   4 +-
 drivers/acpi/x86/utils.c                | 305 ++++++++++++++++++++++++++----
 drivers/i2c/i2c-core-acpi.c             |   7 +
 drivers/mmc/host/sdhci-acpi.c           |  78 +-------
 drivers/tty/serdev/core.c               |  14 ++
 include/acpi/acpi_bus.h                 |  27 ++-
 include/acpi/acpi_numa.h                |   1 -
 include/acpi/acpixf.h                   |   8 +-
 include/acpi/actbl2.h                   | 116 ++++++++----
 include/acpi/actypes.h                  |  23 ++-
 include/acpi/processor.h                |   7 +-
 include/linux/acpi.h                    |   6 +
 72 files changed, 1210 insertions(+), 590 deletions(-)
