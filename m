Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DA85871B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiHATtD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Aug 2022 15:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiHATs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:48:59 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685A832068;
        Mon,  1 Aug 2022 12:48:57 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y127so20624758yby.8;
        Mon, 01 Aug 2022 12:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=egmRs92oP4TdMekylU+TV/79gXiOhc1WUfIIgb3vhM8=;
        b=1OZxXZcXxROqosYLLFEMQlqHUn2oD33TwbqqJUkF14PWL2bVrQQhSnRZzkcHZhI6mo
         z0srG8LK2NIF+FDLYoVcmjPd51fPpYgDUg5R+Zd91wx4cPLrrCKsKTt6FYbqlTo1nHsn
         4u0WTTnMTGhdAPamB5RiNk/c100OSMzWyvQMwQFUKVcxwKjLXkFtWpa06BQmBQrvYobi
         xTsNdc5xPEtZ8gtpYkoMC/gfYzDda1kQYnDX9mH6GqTzLRzjpI+F0FJzGUfJ8miKythK
         PuZdvhnBOpumhr7A2Q9+WYhwRjEzggFDQ+miP5dTDwS6+odK6qp2cKM3gvRl08f49Ueh
         IyfQ==
X-Gm-Message-State: ACgBeo14SNxAoTFbhBQLcia1s8SNgqolbYa4LUHGL2/CCX1Kjm5MnX3q
        I//vHWlu7Mp1Hm9pfV6Sy1TMcp/uQcL9IcPNJOPGaC/T+r+E2w==
X-Google-Smtp-Source: AA6agR7Iv9myO84oeSF50C24Y8EbYJ8yccva8g+RlxgyexF9qLopjNZyad7AelFL0Xyj7oWNvje5BfNtCqN8a01cPyo=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr12319448ybm.482.1659383336315; Mon, 01
 Aug 2022 12:48:56 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Aug 2022 21:48:40 +0200
Message-ID: <CAJZ5v0jsKLQLf-UXyTNSjhYYSMo3XjjF6fNSW_Dbzbrzi3+NSg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.20-rc1

with top-most commit 6352f3478a95cc413ecfee4fdb3300009fd3679a

 Merge branches 'acpi-video', 'acpi-pci' and 'acpi-docs'

on top of commit e0dccc3b76fb35bb257b4118367a883073d7390e

 Linux 5.19-rc8

to receive ACPI updates for 5.20-rc1.

These rework the handling of ACPI device objects to use the driver
core facilities for managing child ones instead of some questionable
home-grown ways without the requisite locking and reference counting,
clean up the EC driver, improve suspend-to-idle handling on x86, add
some systems to the ACPI backlight quirk list, fix some assorted
issues, clean up code and improve documentation.

Specifics:

 - Use facilities provided by the driver core and some additional
   helpers to handle the children of a given ACPI device object in
   multiple places instead of using the children and node list heads in
   struct acpi_device which is error prone (Rafael Wysocki).

 - Fix ACPI-related device reference counting issue in the hisi_lpc bus
   driver (Yang Yingliang).

 - Drop the children and node list heads that are not needed any more
   from struct acpi_device (Rafael Wysocki).

 - Drop driver member from struct acpi_device (Uwe Kleine-König).

 - Drop redundant check from acpi_device_remove() (Uwe Kleine-König).

 - Prepare the CPPC library for handling backwards-compatible future
   _CPC return package formats gracefully (Rafael Wysocki).

 - Clean up the ACPI EC driver after previous changes in it (Hans
   de Goede).

 - Drop leftover acpi_processor_get_limit_info() declaration (Riwen
   Lu).

 - Split out thermal initialization from ACPI PSS (Riwen Lu).

 - Annotate more functions in the ACPI CPU idle driver to live in the
   cpuidle section (Guilherme G. Piccoli).

 - Fix _EINJ vs "special purpose" EFI memory regions (Dan Williams).

 - Implement a better fix to avoid spamming the console with old error
   logs (Tony Luck).

 - Fix typo in a comment in the APEI code (Xiang wangx).

 - Save NVS memory during transitions into S3 on Lenovo G40-45 (Manyi
   Li).

 - Add support for upcoming AMD uPEP device ID AMDI008 to the ACPI
   suspend-to-idle driver for x86 platforms (Shyam Sundar S K).

 - Clean up checks related to the ACPI_FADT_LOW_POWER_S0 platform flag
   in the LPIT table driver and the suspend-to-idle driver for x86
   platforms (Rafael Wysocki).

 - Print information messages regarding declared LPS0 idle support in
   the platform firmware (Rafael Wysocki).

 - Fix missing check in register_device_clock() in the ACPI driver for
   Intel SoCs (huhai).

 - Fix ACS setup in the VIOT table parser (Eric Auger).

 - Skip IRQ override on AMD Zen platforms where it's harmful (Chuanhong
   Guo).

 - Use native backlight on Dell Inspiron N4010 (Hans de Goede).

 - Use native backlight on some TongFang devices (Werner Sembach).

 - Drop X86 dependency from the ACPI backlight driver Kconfig (Riwen
   Lu).

 - Shorten the quirk list in the ACPI backlight driver by identifying
   Clevo by board_name only (Werner Sembach).

 - Remove useless NULL pointer checks from 2 ACPI PCI link management
   functions (Andrey Strachuk).

 - Fix obsolete example in the ACPI EINJ documentation (Qifu Zhang).

 - Update links and references to _DSD-related documents (Sudeep
   Holla).

Thanks!


---------------

Andrey Strachuk (1):
      ACPI/PCI: Remove useless NULL pointer checks

Chuanhong Guo (1):
      ACPI: resource: skip IRQ override on AMD Zen platforms

Dan Williams (1):
      ACPI: APEI: Fix _EINJ vs EFI_MEMORY_SP

Eric Auger (1):
      ACPI: VIOT: Fix ACS setup

Guilherme G. Piccoli (1):
      ACPI: processor/idle: Annotate more functions to live in cpuidle section

Hans de Goede (5):
      ACPI: EC: Remove duplicate ThinkPad X1 Carbon 6th entry from DMI quirks
      ACPI: EC: Drop the EC_FLAGS_IGNORE_DSDT_GPE quirk
      ACPI: EC: Re-use boot_ec when possible even when
EC_FLAGS_TRUST_DSDT_GPE is set
      ACPI: EC: Drop unused ident initializers from dmi_system_id tables
      ACPI: video: Use native backlight on Dell Inspiron N4010

Manyi Li (1):
      ACPI: PM: save NVS memory for Lenovo G40-45

Qifu Zhang (1):
      Documentation: ACPI: EINJ: Fix obsolete example

Rafael J. Wysocki (21):
      ACPI: glue: Use acpi_dev_for_each_child()
      ACPI: glue: Introduce acpi_dev_has_children()
      ACPI: glue: Introduce acpi_find_child_by_adr()
      thunderbolt: ACPI: Replace tb_acpi_find_port() with
acpi_find_child_by_adr()
      USB: ACPI: Replace usb_acpi_find_port() with acpi_find_child_by_adr()
      ACPI: container: Use acpi_dev_for_each_child()
      ACPI: property: Use acpi_dev_for_each_child() for child lookup
      ACPI: bus: Export acpi_dev_for_each_child() to modules
      ACPI: video: Use acpi_dev_for_each_child()
      ACPI: bus: Introduce acpi_dev_for_each_child_reverse()
      ACPI: scan: Walk ACPI device's children using driver core
      platform/x86/thinkpad_acpi: Use acpi_dev_for_each_child()
      soundwire: Use acpi_dev_for_each_child()
      ACPI / MMC: PM: Unify fixing up device power
      mfd: core: Use acpi_dev_for_each_child()
      hisi_lpc: Use acpi_dev_for_each_child()
      ACPI: bus: Drop unused list heads from struct acpi_device
      Revert "ACPI / PM: LPIT: Register sysfs attributes based on FADT"
      ACPI: PM: s2idle: Use LPS0 idle if ACPI_FADT_LOW_POWER_S0 is unset
      ACPI: PM: x86: Print messages regarding LPS0 idle support
      ACPI: CPPC: Do not prevent CPPC from working in the future

Riwen Lu (3):
      ACPI: video: Drop X86 dependency from Kconfig
      ACPI: processor: Split out thermal initialization from ACPI PSS
      ACPI: processor: Drop leftover acpi_processor_get_limit_info() declaration

Shyam Sundar S K (1):
      ACPI: PM: s2idle: Add support for upcoming AMD uPEP HID AMDI008

Sudeep Holla (1):
      Documentation: ACPI: Update links and references to DSD related docs

Tony Luck (1):
      ACPI: APEI: Better fix to avoid spamming the console with old error logs

Uwe Kleine-König (2):
      ACPI: bus: Drop redundant check in acpi_device_remove()
      ACPI: bus: Drop driver member of struct acpi_device

Werner Sembach (2):
      ACPI: video: Force backlight native for some TongFang devices
      ACPI: video: Shortening quirk list by identifying Clevo by board_name only

Xiang wangx (1):
      ACPI: APEI: Fix double word in a comment

Yang Yingliang (1):
      bus: hisi_lpc: fix missing platform_device_put() in hisi_lpc_acpi_probe()

huhai (1):
      ACPI: LPSS: Fix missing check in register_device_clock()

---------------

 .../firmware-guide/acpi/DSD-properties-rules.rst   |  11 +-
 Documentation/firmware-guide/acpi/apei/einj.rst    |   2 +-
 drivers/acpi/Kconfig                               |   4 +-
 drivers/acpi/Makefile                              |   5 +-
 drivers/acpi/acpi_lpit.c                           |   6 -
 drivers/acpi/acpi_lpss.c                           |   3 +
 drivers/acpi/acpi_video.c                          |  41 ++---
 drivers/acpi/apei/apei-base.c                      |   2 +-
 drivers/acpi/apei/bert.c                           |  31 +++-
 drivers/acpi/apei/einj.c                           |   2 +
 drivers/acpi/bus.c                                 |  47 +++--
 drivers/acpi/container.c                           |  17 +-
 drivers/acpi/cppc_acpi.c                           |  54 +++---
 drivers/acpi/device_pm.c                           |  22 +++
 drivers/acpi/device_sysfs.c                        |   2 +-
 drivers/acpi/ec.c                                  | 140 +++++---------
 drivers/acpi/glue.c                                | 133 ++++++++++----
 drivers/acpi/pci_link.c                            |   8 +-
 drivers/acpi/processor_driver.c                    |  72 +-------
 drivers/acpi/processor_idle.c                      |   6 +-
 drivers/acpi/processor_thermal.c                   |  54 ++++++
 drivers/acpi/property.c                            |  45 ++---
 drivers/acpi/resource.c                            |  10 +
 drivers/acpi/scan.c                                |  70 +++----
 drivers/acpi/sleep.c                               |  11 ++
 drivers/acpi/video_detect.c                        |  63 +++++--
 drivers/acpi/viot.c                                |  26 ++-
 drivers/acpi/x86/s2idle.c                          |  17 +-
 drivers/bus/hisi_lpc.c                             | 204 ++++++++++-----------
 drivers/mfd/mfd-core.c                             |  31 +++-
 drivers/mmc/host/sdhci-acpi.c                      |   7 +-
 drivers/mmc/host/sdhci-pci-core.c                  |  11 +-
 drivers/platform/x86/thinkpad_acpi.c               |  53 +++---
 drivers/soundwire/slave.c                          | 117 +++++++-----
 drivers/thunderbolt/acpi.c                         |  29 +--
 drivers/usb/core/usb-acpi.c                        |  18 +-
 include/acpi/acpi_bus.h                            |   9 +-
 include/acpi/cppc_acpi.h                           |   2 +-
 include/acpi/processor.h                           |   9 +-
 include/linux/acpi_viot.h                          |   2 +
 40 files changed, 748 insertions(+), 648 deletions(-)
