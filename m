Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62C459B038
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiHTT62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiHTT6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:58:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0256479
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g18so7526299pju.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=EET0Un/8O4jrmVE9pDHlqLGnoLV+4eS4NEOWgSLK9sM=;
        b=Fq71Isre/Zv+ozJoJuTsRm8tE3lFksMnPqDnbyLTeYUOycze8peYrSNMEFjB3Tzgqt
         0jHONte/M/6NA9eXWsy1n1ZLpa+gJXFQwho/A5IwpP3g07VVX2tLCLvRoJqeQ0ogK4ax
         mUp4myIqgrxwwPTpwtbzHapfeuMH0LrlHdrIFin6RFvmyq/tqa9Wgtlx46RYE3NaavAw
         IlM9E/9NCnnhDnYAVsCm45zeMypJT3WMDh8c/+i2gb7xsZ/3qJUpwqHHVXSi50Z1hlv4
         8Le04vKwcIdhiUrKbLpsAvOsDAnYgiMdam8Q39OKjSjL/4GB5LtUwQht9WsSynSy2wQD
         JhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EET0Un/8O4jrmVE9pDHlqLGnoLV+4eS4NEOWgSLK9sM=;
        b=gn5XWq+JoS0Yh0zCG9b1vvt9t9t+JIvlEiss5ONNsfNlJxgkqIUKElrlq6dPNfbs/p
         SCifBaNaHySl6QDroIiFZtd9RNZewshMHwEXIM0aPIf2ZJCb2oIucFN8IMCSxVx/t8xS
         bf8YarFpMysZmUr+p9bQxrt8mLJi4I5kFylqWFOQ2WNr0nIshl7X/qZwCIsH+ZEFOQaT
         rmlr+cjuzh/lXOcOdDPMXLrIyCUVZSQQVj2sn1/95upvVP0h8/ZR6XnIDHfgqOtqqLJ1
         riQXmwqJaJjJHy55HnijrUVK9lyB2WELadjBOgItNpRxiyliwFsiD1ZoKXp7T+aSsQi6
         iANA==
X-Gm-Message-State: ACgBeo3fBWKZpaU1nBRhI+I08fAxTI9qs+i50G36e2hH+HKlPoltxf1I
        1FQyKvLkrytomJ2uU1QLgOWFAA==
X-Google-Smtp-Source: AA6agR4NQBiKeACQZHL0se4kx7TrkCzs5KUP7idmilJI/Skl9nIaDoND8/L39X6N91CTXtZzul6bDw==
X-Received: by 2002:a17:90a:fc87:b0:1fa:ddf8:ddd1 with SMTP id ci7-20020a17090afc8700b001faddf8ddd1mr10957482pjb.8.1661025493420;
        Sat, 20 Aug 2022 12:58:13 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:12 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 00/17] Support AMD Pensando Elba SoC
Date:   Sat, 20 Aug 2022 12:57:33 -0700
Message-Id: <20220820195750.70861-1-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

This series enables support for AMD Pensando Elba SoC based platforms.

The Elba SoC has the following features:
- Sixteen ARM64 A72 cores
- Dual DDR 4/5 memory controllers
- 32 lanes of PCIe Gen3/4 to the Host
- Network interfaces: Dual 200GE, Quad 100GE, 50GE, 25GE, 10GE and
  also a single 1GE management port.
- Storage/crypto offloads and 144 programmable P4 cores.
- QSPI and EMMC for SoC storage
- Two SPI interfaces for peripheral management
- I2C bus for platform management

== V6 changes ==
- Updated copyright and SPDX

v6-0001-dt-bindings-arm-add-AMD-Pensando-boards
- Delete 'Device Tree Bindings' in title

v6-0002-dt-bindings-mmc-cdns-Add-AMD-Pensando-Elba-SoC
- Change if/then for Elba which has a second reg for byte-lane control

v6-0003-dt-bindings-spi-cdns-Add-compatible-for-AMD-Pensa
- no change

v6-0004-dt-bindings-spi-dw-Add-AMD-Pensando-Elba-SoC-SPI-
- Add amd,pensando-elba-syscon

v6-0005-dt-bindings-mfd-syscon-Add-amd-pensando-elba-sysc
- no change

v6-0006-dt-bindings-mfd-amd-pensando-elbasr-Add-AMD-Pensa
- Expand description, rename nodes and change compatible usage

v6-0007-dt-bindings-reset-amd-pensando-elbasr-reset-Add-A
- Delete nodename pattern and changed spi0 to spi
- File amd,pensando-elba-reset.h is deleted as there is only
  one reset used.
- Update example

v6-0008-MAINTAINERS-Add-entry-for-AMD-PENSANDO
- no change

v6-0009-arm64-Add-config-for-AMD-Pensando-SoC-platforms
- no change

v6-0010-arm64-dts-Add-AMD-Pensando-Elba-SoC-support
- Update node names and add amd,pensando-elba-syscon
- Delete use of amd,pensando-elba-reset.h which had a single definition

v6-0011-spi-cadence-quadspi-Add-compatible-for-AMD-Pensan
- Remove (void) cast

v6-0012-spi-dw-Add-support-for-AMD-Pensando-Elba-SoC
- Update use of amd,pensando-elba-syscon

v6-0013-mmc-sdhci-cadence-Enable-device-specific-override
- Change this patch to add a priv_writel() callback where all
  existing designs use writel().  This separates the Elba
  support into three patches.  The second patch is added
  to the end of the sequence for Elba support.  The third
  patch enables mmc hardware reset.

v6-0014-mfd-pensando-elbasr-Add-AMD-Pensando-Elba-System-
- Updates from review comments
- Use spi_message_init_with_transfers instead of init/add_tail API

v6-0015-reset-elbasr-Add-AMD-Pensando-Elba-SR-Reset-Contr
- Remove use of amd,pensando-elba-reset.h and use BIT()

v6-0016-mmc-sdhci-cadence-Add-AMD-Pensando-Elba-SoC-suppo
- Elba sdhci-cadence.c support added in this patch to build on
  0013 which just adds a callback to override priv_writel()

v6-0017-mmc-sdhci-cadence-Support-mmc-hardware-reset
- New patch where Elba has a reset-controller for mmc hardware
  reset.  The reset is implemented by a register in the cpld.

== V5 changes ==
- Change to AMD Pensando instead of Pensando.
- No reference to spidev in the device tree.  Add multi-function driver
  pensando-elbasr and sub-device reset-elbasr which provides mfd and
  /dev interface to the cpld.
- Rebase to linux-next tag next-20220609 5.19.0-rc1
- Redo the email list after rebase and using scripts/get_maintainer.pl

== V4 changes ==
The version of dtschema used is 2022.3.2.

v4-0001-dt-bindings-arm-add-Pensando-boards.patch
- Add description and board compatible

v4-0003-dt-bindings-mmc-Add-Pensando-Elba-SoC-binding.patch
- Change from elba-emmc to elba-sd4hc to match file convention
- Use minItems: 1 and maxItems: 2 to pass schema check

v4-0005-dt-bindings-spi-dw-Add-Pensando-Elba-SoC-SPI-Control.patch
- Add required property pensando,syscon-spics to go with
  pensando,elba-spi

v4-0006-MAINTAINERS-Add-entry-for-PENSANDO.patch
- Change Maintained to Supported

v4-0007-arm64-Add-config-for-Pensando-SoC-platforms.patch
- Fix a typo on interface max speed

v4-0008-spi-cadence-quadspi-Add-compatible-for-Pensando-Elba.patch
- Update due to spi-cadence-quadspi.c changes

v4-0009-mmc-sdhci-cadence-Add-Pensando-Elba-SoC-support.patch
- Change from elba-emmc to elba-sd4hc to match file convention

v4-0010-spi-dw-Add-support-for-Pensando-Elba-SoC.patch
- Use more descriptive dt property pensando,syscon-spics
- Minor changes from review input

v4-0011-arm64-dts-Add-Pensando-Elba-SoC-support.patch
- Changed to dual copyright (GPL-2.0+ OR MIT)
- Minor changes from review input

== V3 changes ==
v3-0001-gpio-Add-Elba-SoC-gpio-driver-for-spi-cs-control.patch
- This patch is deleted.  Elba SOC specific gpio spics control is
  integrated into spi-dw-mmio.c.

v3-0002-spi-cadence-quadspi-Add-QSPI-support-for-Pensando-El.patch
- Changed compatible to "pensando,elba-qspi" to be more descriptive
  in spi-cadence-quadspi.c.

- Arnd wondered if moving to DT properties for quirks may be the
  way to go.  Feedback I've received on other patches was don't
  mix two efforts in one patch so I'm currently just adding the
  Elba support to the current design.

v3-0003-spi-dw-Add-support-for-Pensando-Elba-SoC-SPI.patch
- Changed the implementation to use existing dw_spi_set_cs() and
  integrated Elba specific CS control into spi-dw-mmio.c.  The
  native designware support is for two chip-selects while Elba
  provides 4 chip-selects.  Instead of adding a new file for
  this support in gpio-elba-spics.c the support is in one
  file (spi-dw-mmio.c).

v3-0004-spidev-Add-Pensando-CPLD-compatible.patch
- This patch is deleted.  The addition of compatible "pensando,cpld"
  to spidev.c is not added and an existing compatible is used 
  in the device tree to enable.

v3-0005-mmc-sdhci-cadence-Add-Pensando-Elba-SoC-support.patch
- Ulf and Yamada-san agreed the amount of code for this support
  is not enough to need a new file.  The support is added into
  sdhci-cadence.c and new files sdhci-cadence-elba.c and
  sdhci-cadence.h are deleted.
- Redundant defines are removed (e.g. use SDHCI_CDNS_HRS04 and
  remove SDIO_REG_HRS4).
- Removed phy init function sd4_set_dlyvr() and used existing
  sdhci_cdns_phy_init(). Init values are from DT properties.
- Replace  devm_ioremap_resource(&pdev->dev, iomem)
     with  devm_platform_ioremap_resource(pdev, 1)
- Refactored the elba priv_writ_l() and elba_write_l() to
  remove a little redundant code.
- The config option CONFIG_MMC_SDHCI_CADENCE_ELBA goes away.
- Only C syntax and Elba functions are prefixed with elba_

v3-0006-arm64-Add-config-for-Pensando-SoC-platforms.patch
- Added a little more info to the platform help text to assist
  users to decide on including platform support or not.

v3-0007-arm64-dts-Add-Pensando-Elba-SoC-support.patch
- Node names changed to DT generic names
- Changed from using 'spi@' which is reserved
- The elba-flash-parts.dtsi is kept separate as
  it is included in multiple dts files.
- SPDX license tags at the top of each file
- The compatible = "pensando,elba" and 'model' are
  now together in the board file.
- UIO nodes removed
- Ordered nodes by increasing unit address
- Removed an unreferenced container node.
- Dropped deprecated 'device_type' for uart0 node.

v3-0010-dt-bindings-spi-cadence-qspi-Add-support-for-Pensand.patch
- Updated since the latest documentation has been converted to yaml

v3-0011-dt-bindings-gpio-Add-Pensando-Elba-SoC-support.patch
- This patch is deleted since the Elba gpio spics is added to
  the spi dw driver and documented there.

Because of the deletion of patches and merging of code
the new patchset is not similar.  A changelog is added into
the patches for merged code to be helpful on the history.

== V2 changes ==
- 01    Fix typo, return code value and log message.
- 03    Remove else clause, intrinsic DW chip-select is never used.
- 08-11 Split out dts and bindings to sub-patches
- 10    Converted existing cadence-quadspi.txt to YAML schema
- 13    New driver should use <linux/gpio/driver.h>


Brad Larson (17):
  dt-bindings: arm: add AMD Pensando boards
  dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
  dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
  dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
    bindings
  dt-bindings: mfd: syscon: Add amd,pensando-elba-syscon compatible
  dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando Elba System
    Resource chip
  dt-bindings: reset: amd,pensando-elbasr-reset: Add AMD Pensando SR
    Reset Controller bindings
  MAINTAINERS: Add entry for AMD PENSANDO
  arm64: Add config for AMD Pensando SoC platforms
  arm64: dts: Add AMD Pensando Elba SoC support
  spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
  spi: dw: Add support for AMD Pensando Elba SoC
  mmc: sdhci-cadence: Enable device specific override of writel()
  mfd: pensando-elbasr: Add AMD Pensando Elba System Resource chip
  reset: elbasr: Add AMD Pensando Elba SR Reset Controller
  mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
  mmc: sdhci-cadence: Support mmc hardware reset

 .../devicetree/bindings/arm/amd,pensando.yaml |  26 +
 .../bindings/mfd/amd,pensando-elbasr.yaml     |  97 ++
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   |  13 +-
 .../reset/amd,pensando-elbasr-reset.yaml      |  57 ++
 .../bindings/spi/cdns,qspi-nor.yaml           |  12 +
 .../bindings/spi/snps,dw-apb-ssi.yaml         |  11 +
 MAINTAINERS                                   |   9 +
 arch/arm64/Kconfig.platforms                  |  12 +
 arch/arm64/boot/dts/amd/Makefile              |   1 +
 arch/arm64/boot/dts/amd/elba-16core.dtsi      | 189 ++++
 arch/arm64/boot/dts/amd/elba-asic-common.dtsi | 101 +++
 arch/arm64/boot/dts/amd/elba-asic.dts         |  28 +
 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi | 106 +++
 arch/arm64/boot/dts/amd/elba.dtsi             | 192 ++++
 drivers/mfd/Kconfig                           |  14 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/pensando-elbasr.c                 | 854 ++++++++++++++++++
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/sdhci-cadence.c              | 179 +++-
 drivers/reset/Kconfig                         |   9 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-elbasr.c                  |  77 ++
 drivers/spi/spi-cadence-quadspi.c             |  19 +
 drivers/spi/spi-dw-mmio.c                     |  77 ++
 include/linux/mfd/pensando-elbasr.h           |  78 ++
 26 files changed, 2149 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
 create mode 100644 arch/arm64/boot/dts/amd/elba-16core.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba-asic-common.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba-asic.dts
 create mode 100644 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba.dtsi
 create mode 100644 drivers/mfd/pensando-elbasr.c
 create mode 100644 drivers/reset/reset-elbasr.c
 create mode 100644 include/linux/mfd/pensando-elbasr.h


base-commit: 3cc40a443a04d52b0c95255dce264068b01e9bfe
-- 
2.17.1

