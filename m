Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307384F4580
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358974AbiDEOD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiDEJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7836F10B9;
        Tue,  5 Apr 2022 02:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E95DB61645;
        Tue,  5 Apr 2022 09:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19986C385A0;
        Tue,  5 Apr 2022 09:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150291;
        bh=H0F69XTNeFYoiH0TOoODEQW7arKN3D+NDTM7oJiL1w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZI96+y5WZ5YKP+jmDF7Bfenr5BbwUy30x3T+Zk6iBLz7qBE8vt1aMQONQ8mxwtsu1
         7hhMC+oKntEqsgVBR6m/7aXu1GCirczzTHHbuCDLLiUxPHGksGNFlTsXV5GUAdYhzv
         fWpBW/zwbZnRAhvdhbltlF6WKlDr0rpYJDKMMbO2wkQ3em7V4tLTn0qb+eCglgMd97
         yCpeQS1NGzXHGeGOU7azC62DbBwhAfr0zsz+NVYERKyf/2zI1QN3uaYi7gizHubUYh
         y4+5ICsKLakY2lpQVtCM0AXck6cDlRgv0yBtjDkVw7CB2HzcV6aKih2Q9w0kX/a6+d
         kKJe2tD4X8X3A==
From:   Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 01/12] ARM: versatile: move integrator/realview/vexpress to versatile
Date:   Tue,  5 Apr 2022 11:17:39 +0200
Message-Id: <20220405091750.3076973-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220405091750.3076973-1-arnd@kernel.org>
References: <20220405091750.3076973-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These are all fairly small platforms by now, and they are
closely related. Just move them all into a single directory.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                                   |   3 -
 arch/arm/Kconfig                              |   6 -
 arch/arm/Makefile                             |   7 +-
 arch/arm/mach-integrator/Kconfig              | 125 -------
 arch/arm/mach-integrator/Makefile             |  10 -
 arch/arm/mach-realview/Kconfig                | 103 ------
 arch/arm/mach-realview/Makefile               |   8 -
 arch/arm/mach-versatile/Kconfig               | 308 ++++++++++++++++++
 arch/arm/mach-versatile/Makefile              |  32 +-
 .../Makefile.boot                             |   0
 .../{mach-vexpress => mach-versatile}/dcscb.c |   4 +-
 .../dcscb_setup.S                             |   2 -
 .../headsmp.S                                 |   2 -
 .../hotplug.c                                 |   2 +-
 .../cm.h => mach-versatile/integrator-cm.h}   |   0
 .../integrator-hardware.h}                    |   0
 .../core.c => mach-versatile/integrator.c}    |   8 +-
 .../common.h => mach-versatile/integrator.h}  |   0
 .../integrator_ap.c                           |   8 +-
 .../integrator_cp.c                           |   8 +-
 .../platsmp-realview.c}                       |   2 +-
 .../platsmp-vexpress.c}                       |   7 +-
 .../platsmp.c                                 |   4 +-
 .../include/plat => mach-versatile}/platsmp.h |   2 -
 .../realview.c}                               |   0
 .../{mach-vexpress => mach-versatile}/spc.c   |   0
 .../{mach-vexpress => mach-versatile}/spc.h   |   0
 .../tc2_pm.c                                  |   2 -
 .../v2m-mps2.c                                |   0
 .../{mach-vexpress => mach-versatile}/v2m.c   |   2 +-
 .../{versatile_dt.c => versatile.c}           |   0
 .../core.h => mach-versatile/vexpress.h}      |   0
 arch/arm/mach-vexpress/Kconfig                |  81 -----
 arch/arm/mach-vexpress/Makefile               |  19 --
 arch/arm/plat-versatile/Makefile              |   5 -
 35 files changed, 357 insertions(+), 403 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/Kconfig
 delete mode 100644 arch/arm/mach-integrator/Makefile
 delete mode 100644 arch/arm/mach-realview/Kconfig
 delete mode 100644 arch/arm/mach-realview/Makefile
 rename arch/arm/{mach-vexpress => mach-versatile}/Makefile.boot (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/dcscb.c (97%)
 rename arch/arm/{mach-vexpress => mach-versatile}/dcscb_setup.S (95%)
 rename arch/arm/{plat-versatile => mach-versatile}/headsmp.S (94%)
 rename arch/arm/{plat-versatile => mach-versatile}/hotplug.c (98%)
 rename arch/arm/{mach-integrator/cm.h => mach-versatile/integrator-cm.h} (100%)
 rename arch/arm/{mach-integrator/hardware.h => mach-versatile/integrator-hardware.h} (100%)
 rename arch/arm/{mach-integrator/core.c => mach-versatile/integrator.c} (95%)
 rename arch/arm/{mach-integrator/common.h => mach-versatile/integrator.h} (100%)
 rename arch/arm/{mach-integrator => mach-versatile}/integrator_ap.c (97%)
 rename arch/arm/{mach-integrator => mach-versatile}/integrator_cp.c (96%)
 rename arch/arm/{mach-realview/platsmp-dt.c => mach-versatile/platsmp-realview.c} (98%)
 rename arch/arm/{mach-vexpress/platsmp.c => mach-versatile/platsmp-vexpress.c} (96%)
 rename arch/arm/{plat-versatile => mach-versatile}/platsmp.c (97%)
 rename arch/arm/{plat-versatile/include/plat => mach-versatile}/platsmp.h (87%)
 rename arch/arm/{mach-realview/realview-dt.c => mach-versatile/realview.c} (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/spc.c (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/spc.h (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/tc2_pm.c (99%)
 rename arch/arm/{mach-vexpress => mach-versatile}/v2m-mps2.c (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/v2m.c (97%)
 rename arch/arm/mach-versatile/{versatile_dt.c => versatile.c} (100%)
 rename arch/arm/{mach-vexpress/core.h => mach-versatile/vexpress.h} (100%)
 delete mode 100644 arch/arm/mach-vexpress/Kconfig
 delete mode 100644 arch/arm/mach-vexpress/Makefile
 delete mode 100644 arch/arm/plat-versatile/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..6a0363b0f106 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1525,10 +1525,7 @@ F:	Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
 F:	arch/arm/boot/dts/arm-realview-*
 F:	arch/arm/boot/dts/integrator*
 F:	arch/arm/boot/dts/versatile*
-F:	arch/arm/mach-integrator/
-F:	arch/arm/mach-realview/
 F:	arch/arm/mach-versatile/
-F:	arch/arm/plat-versatile/
 F:	drivers/bus/arm-integrator-lm.c
 F:	drivers/clk/versatile/
 F:	drivers/i2c/busses/i2c-versatile.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e8091e2d8a8..31f024e6e925 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -622,8 +622,6 @@ source "arch/arm/mach-hisi/Kconfig"
 
 source "arch/arm/mach-imx/Kconfig"
 
-source "arch/arm/mach-integrator/Kconfig"
-
 source "arch/arm/mach-iop32x/Kconfig"
 
 source "arch/arm/mach-ixp4xx/Kconfig"
@@ -675,8 +673,6 @@ source "arch/arm/mach-rda/Kconfig"
 
 source "arch/arm/mach-realtek/Kconfig"
 
-source "arch/arm/mach-realview/Kconfig"
-
 source "arch/arm/mach-rockchip/Kconfig"
 
 source "arch/arm/mach-s3c/Kconfig"
@@ -705,8 +701,6 @@ source "arch/arm/mach-ux500/Kconfig"
 
 source "arch/arm/mach-versatile/Kconfig"
 
-source "arch/arm/mach-vexpress/Kconfig"
-
 source "arch/arm/mach-vt8500/Kconfig"
 
 source "arch/arm/mach-zynq/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a2391b8de5a5..8740e3a63afb 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -179,7 +179,6 @@ machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_HISI)		+= hisi
-machine-$(CONFIG_ARCH_INTEGRATOR)	+= integrator
 machine-$(CONFIG_ARCH_IOP32X)		+= iop32x
 machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
 machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
@@ -187,7 +186,6 @@ machine-$(CONFIG_ARCH_LPC18XX)		+= lpc18xx
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
 machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
-machine-$(CONFIG_ARCH_MPS2)		+= vexpress
 machine-$(CONFIG_ARCH_MOXART)		+= moxart
 machine-$(CONFIG_ARCH_MV78XX0)		+= mv78xx0
 machine-$(CONFIG_ARCH_MVEBU)		+= mvebu
@@ -207,7 +205,6 @@ machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_QCOM)		+= qcom
 machine-$(CONFIG_ARCH_RDA)		+= rda
 machine-$(CONFIG_ARCH_REALTEK)		+= realtek
-machine-$(CONFIG_ARCH_REALVIEW)		+= realview
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_RPC)		+= rpc
 machine-$(CONFIG_PLAT_SAMSUNG)		+= s3c
@@ -220,10 +217,9 @@ machine-$(CONFIG_ARCH_STM32)		+= stm32
 machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U8500)		+= ux500
-machine-$(CONFIG_ARCH_VERSATILE)	+= versatile
-machine-$(CONFIG_ARCH_VEXPRESS)		+= vexpress
 machine-$(CONFIG_ARCH_VT8500)		+= vt8500
 machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
+machine-$(CONFIG_PLAT_VERSATILE)	+= versatile
 machine-$(CONFIG_PLAT_SPEAR)		+= spear
 
 # Platform directory name.  This list is sorted alphanumerically
@@ -231,7 +227,6 @@ machine-$(CONFIG_PLAT_SPEAR)		+= spear
 plat-$(CONFIG_ARCH_OMAP)	+= omap
 plat-$(CONFIG_PLAT_ORION)	+= orion
 plat-$(CONFIG_PLAT_PXA)		+= pxa
-plat-$(CONFIG_PLAT_VERSATILE)	+= versatile
 
 # The byte offset of the kernel image in RAM from the start of RAM.
 TEXT_OFFSET := $(textofs-y)
diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
deleted file mode 100644
index d61ea616cf8e..000000000000
--- a/arch/arm/mach-integrator/Kconfig
+++ /dev/null
@@ -1,125 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_INTEGRATOR
-	bool "ARM Ltd. Integrator family"
-	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V6
-	select ARM_AMBA
-	select CMA
-	select DMA_CMA
-	select HAVE_TCM
-	select CLK_ICST
-	select MFD_SYSCON
-	select PLAT_VERSATILE
-	select POWER_RESET
-	select POWER_RESET_VERSATILE
-	select POWER_SUPPLY
-	select SOC_INTEGRATOR_CM
-	select VERSATILE_FPGA_IRQ
-	help
-	  Support for ARM's Integrator platform.
-
-if ARCH_INTEGRATOR
-
-config ARCH_INTEGRATOR_AP
-	bool "Support Integrator/AP and Integrator/PP2 platforms"
-	select INTEGRATOR_AP_TIMER
-	select SERIAL_AMBA_PL010 if TTY
-	select SERIAL_AMBA_PL010_CONSOLE if TTY
-	select SOC_BUS
-	help
-	  Include support for the ARM(R) Integrator/AP and
-	  Integrator/PP2 platforms.
-
-config INTEGRATOR_IMPD1
-	bool "Include support for Integrator/IM-PD1"
-	depends on ARCH_INTEGRATOR_AP
-	select ARM_VIC
-	select GPIO_PL061
-	select GPIOLIB
-	select REGULATOR
-	select REGULATOR_FIXED_VOLTAGE
-	help
-	  The IM-PD1 is an add-on logic module for the Integrator which
-	  allows ARM(R) Ltd PrimeCells to be developed and evaluated.
-	  The IM-PD1 can be found on the Integrator/PP2 platform.
-
-config INTEGRATOR_CM720T
-	bool "Integrator/CM720T core module"
-	depends on ARCH_INTEGRATOR_AP
-	depends on ARCH_MULTI_V4T
-	select CPU_ARM720T
-
-config INTEGRATOR_CM920T
-	bool "Integrator/CM920T core module"
-	depends on ARCH_INTEGRATOR_AP
-	depends on ARCH_MULTI_V4T
-	select CPU_ARM920T
-
-config INTEGRATOR_CM922T_XA10
-	bool "Integrator/CM922T-XA10 core module"
-	depends on ARCH_MULTI_V4T
-	depends on ARCH_INTEGRATOR_AP
-	select CPU_ARM922T
-
-config INTEGRATOR_CM926EJS
-	bool "Integrator/CM926EJ-S core module"
-	depends on ARCH_INTEGRATOR_AP
-	depends on ARCH_MULTI_V5
-	select CPU_ARM926T
-
-config INTEGRATOR_CM10200E_REV0
-	bool "Integrator/CM10200E rev.0 core module"
-	depends on ARCH_INTEGRATOR_AP && n
-	depends on ARCH_MULTI_V5
-	select CPU_ARM1020
-
-config INTEGRATOR_CM10200E
-	bool "Integrator/CM10200E core module"
-	depends on ARCH_INTEGRATOR_AP && n
-	depends on ARCH_MULTI_V5
-	select CPU_ARM1020E
-
-config INTEGRATOR_CM10220E
-	bool "Integrator/CM10220E core module"
-	depends on ARCH_INTEGRATOR_AP
-	depends on ARCH_MULTI_V5
-	select CPU_ARM1022
-
-config INTEGRATOR_CM1026EJS
-	bool "Integrator/CM1026EJ-S core module"
-	depends on ARCH_INTEGRATOR_AP
-	depends on ARCH_MULTI_V5
-	select CPU_ARM1026
-
-config INTEGRATOR_CM1136JFS
-	bool "Integrator/CM1136JF-S core module"
-	depends on ARCH_INTEGRATOR_AP
-	depends on ARCH_MULTI_V6
-	select CPU_V6
-
-config ARCH_INTEGRATOR_CP
-	bool "Support Integrator/CP platform"
-	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6
-	select ARM_TIMER_SP804
-	select SERIAL_AMBA_PL011 if TTY
-	select SERIAL_AMBA_PL011_CONSOLE if TTY
-	select SOC_BUS
-	help
-	  Include support for the ARM(R) Integrator CP platform.
-
-config INTEGRATOR_CT926
-	bool "Integrator/CT926 (ARM926EJ-S) core tile"
-	depends on ARCH_INTEGRATOR_CP
-	depends on ARCH_MULTI_V5
-	select CPU_ARM926T
-
-config INTEGRATOR_CTB36
-	bool "Integrator/CTB36 (ARM1136JF-S) core tile"
-	depends on ARCH_INTEGRATOR_CP
-	depends on ARCH_MULTI_V6
-	select CPU_V6
-
-config ARCH_CINTEGRATOR
-	depends on ARCH_INTEGRATOR_CP
-	def_bool y
-
-endif
diff --git a/arch/arm/mach-integrator/Makefile b/arch/arm/mach-integrator/Makefile
deleted file mode 100644
index 7857a55c90b0..000000000000
--- a/arch/arm/mach-integrator/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the linux kernel.
-#
-
-# Object file lists.
-
-obj-y					:= core.o
-obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= integrator_ap.o
-obj-$(CONFIG_ARCH_INTEGRATOR_CP)	+= integrator_cp.o
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
deleted file mode 100644
index a4c36024b5e8..000000000000
--- a/arch/arm/mach-realview/Kconfig
+++ /dev/null
@@ -1,103 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_REALVIEW
-	bool "ARM Ltd. RealView family"
-	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
-	select ARM_AMBA
-	select ARM_GIC
-	select ARM_TIMER_SP804
-	select CLK_SP810
-	select GPIO_PL061 if GPIOLIB
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select HAVE_PATA_PLATFORM
-	select HAVE_TCM
-	select CLK_ICST
-	select MACH_REALVIEW_EB if ARCH_MULTI_V5
-	select MFD_SYSCON
-	select PLAT_VERSATILE
-	select POWER_RESET
-	select POWER_RESET_VERSATILE
-	select POWER_SUPPLY
-	select SOC_REALVIEW
-	help
-	  This enables support for ARM Ltd RealView boards.
-
-if ARCH_REALVIEW
-
-config MACH_REALVIEW_EB
-	bool "Support RealView(R) Emulation Baseboard"
-	select ARM_GIC
-	select CPU_ARM926T if ARCH_MULTI_V5
-	help
-	  Include support for the ARM(R) RealView(R) Emulation Baseboard
-	  platform. On an ARMv5 kernel, this will include support for
-	  the ARM926EJ-S core tile, while on an ARMv6/v7 kernel, at least
-	  one of the ARM1136, ARM1176, ARM11MPCore or Cortex-A9MPCore
-	  core tile options should be enabled.
-
-config REALVIEW_EB_ARM1136
-	bool "Support ARM1136J(F)-S Tile"
-	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
-	select CPU_V6
-	help
-	  Enable support for the ARM1136 tile fitted to the
-	  Realview(R) Emulation Baseboard platform.
-
-config REALVIEW_EB_ARM1176
-	bool "Support ARM1176JZ(F)-S Tile"
-	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
-	help
-	  Enable support for the ARM1176 tile fitted to the
-	  Realview(R) Emulation Baseboard platform.
-
-config REALVIEW_EB_A9MP
-	bool "Support Multicore Cortex-A9 Tile"
-	depends on MACH_REALVIEW_EB && ARCH_MULTI_V7
-	help
-	  Enable support for the Cortex-A9MPCore tile fitted to the
-	  Realview(R) Emulation Baseboard platform.
-
-config REALVIEW_EB_ARM11MP
-	bool "Support ARM11MPCore Tile"
-	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
-	select HAVE_SMP
-	help
-	  Enable support for the ARM11MPCore tile fitted to the Realview(R)
-	  Emulation Baseboard platform.
-
-config MACH_REALVIEW_PB11MP
-	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
-	depends on ARCH_MULTI_V6
-	select HAVE_SMP
-	help
-	  Include support for the ARM(R) RealView(R) Platform Baseboard for
-	  the ARM11MPCore.  This platform has an on-board ARM11MPCore and has
-	  support for PCI-E and Compact Flash.
-
-# ARMv6 CPU without K extensions, but does have the new exclusive ops
-config MACH_REALVIEW_PB1176
-	bool "Support RealView(R) Platform Baseboard for ARM1176JZF-S"
-	depends on ARCH_MULTI_V6
-	select CPU_V6
-	select HAVE_TCM
-	help
-	  Include support for the ARM(R) RealView(R) Platform Baseboard for
-	  ARM1176JZF-S.
-
-config MACH_REALVIEW_PBA8
-	bool "Support RealView(R) Platform Baseboard for Cortex(tm)-A8 platform"
-	depends on ARCH_MULTI_V7
-	help
-	  Include support for the ARM(R) RealView Platform Baseboard for
-	  Cortex(tm)-A8.  This platform has an on-board Cortex-A8 and has
-	  support for PCI-E and Compact Flash.
-
-config MACH_REALVIEW_PBX
-	bool "Support RealView(R) Platform Baseboard Explore for Cortex-A9"
-	depends on ARCH_MULTI_V7
-	select ZONE_DMA
-	help
-	  Include support for the ARM(R) RealView(R) Platform Baseboard
-	  Explore.
-
-endif
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
deleted file mode 100644
index e259091591b8..000000000000
--- a/arch/arm/mach-realview/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for the linux kernel.
-#
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-versatile/include
-
-obj-y					+= realview-dt.o
-obj-$(CONFIG_SMP)			+= platsmp-dt.o
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index f78a1d358031..94b492c12e8d 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -16,3 +16,311 @@ config ARCH_VERSATILE
 	help
 	  This enables support for ARM Ltd Versatile board.
 
+menuconfig ARCH_INTEGRATOR
+	bool "ARM Ltd. Integrator family"
+	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V6
+	select ARM_AMBA
+	select CMA
+	select DMA_CMA
+	select HAVE_TCM
+	select CLK_ICST
+	select MFD_SYSCON
+	select PLAT_VERSATILE
+	select POWER_RESET
+	select POWER_RESET_VERSATILE
+	select POWER_SUPPLY
+	select SOC_INTEGRATOR_CM
+	select VERSATILE_FPGA_IRQ
+	help
+	  Support for ARM's Integrator platform.
+
+if ARCH_INTEGRATOR
+
+config ARCH_INTEGRATOR_AP
+	bool "Support Integrator/AP and Integrator/PP2 platforms"
+	select INTEGRATOR_AP_TIMER
+	select SERIAL_AMBA_PL010 if TTY
+	select SERIAL_AMBA_PL010_CONSOLE if TTY
+	select SOC_BUS
+	help
+	  Include support for the ARM(R) Integrator/AP and
+	  Integrator/PP2 platforms.
+
+config INTEGRATOR_IMPD1
+	bool "Include support for Integrator/IM-PD1"
+	depends on ARCH_INTEGRATOR_AP
+	select ARM_VIC
+	select GPIO_PL061
+	select GPIOLIB
+	select REGULATOR
+	select REGULATOR_FIXED_VOLTAGE
+	help
+	  The IM-PD1 is an add-on logic module for the Integrator which
+	  allows ARM(R) Ltd PrimeCells to be developed and evaluated.
+	  The IM-PD1 can be found on the Integrator/PP2 platform.
+
+config INTEGRATOR_CM720T
+	bool "Integrator/CM720T core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V4T
+	select CPU_ARM720T
+
+config INTEGRATOR_CM920T
+	bool "Integrator/CM920T core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V4T
+	select CPU_ARM920T
+
+config INTEGRATOR_CM922T_XA10
+	bool "Integrator/CM922T-XA10 core module"
+	depends on ARCH_MULTI_V4T
+	depends on ARCH_INTEGRATOR_AP
+	select CPU_ARM922T
+
+config INTEGRATOR_CM926EJS
+	bool "Integrator/CM926EJ-S core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V5
+	select CPU_ARM926T
+
+config INTEGRATOR_CM10200E_REV0
+	bool "Integrator/CM10200E rev.0 core module"
+	depends on ARCH_INTEGRATOR_AP && n
+	depends on ARCH_MULTI_V5
+	select CPU_ARM1020
+
+config INTEGRATOR_CM10200E
+	bool "Integrator/CM10200E core module"
+	depends on ARCH_INTEGRATOR_AP && n
+	depends on ARCH_MULTI_V5
+	select CPU_ARM1020E
+
+config INTEGRATOR_CM10220E
+	bool "Integrator/CM10220E core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V5
+	select CPU_ARM1022
+
+config INTEGRATOR_CM1026EJS
+	bool "Integrator/CM1026EJ-S core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V5
+	select CPU_ARM1026
+
+config INTEGRATOR_CM1136JFS
+	bool "Integrator/CM1136JF-S core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V6
+	select CPU_V6
+
+config ARCH_INTEGRATOR_CP
+	bool "Support Integrator/CP platform"
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6
+	select ARM_TIMER_SP804
+	select SERIAL_AMBA_PL011 if TTY
+	select SERIAL_AMBA_PL011_CONSOLE if TTY
+	select SOC_BUS
+	help
+	  Include support for the ARM(R) Integrator CP platform.
+
+config INTEGRATOR_CT926
+	bool "Integrator/CT926 (ARM926EJ-S) core tile"
+	depends on ARCH_INTEGRATOR_CP
+	depends on ARCH_MULTI_V5
+	select CPU_ARM926T
+
+config INTEGRATOR_CTB36
+	bool "Integrator/CTB36 (ARM1136JF-S) core tile"
+	depends on ARCH_INTEGRATOR_CP
+	depends on ARCH_MULTI_V6
+	select CPU_V6
+
+config ARCH_CINTEGRATOR
+	depends on ARCH_INTEGRATOR_CP
+	def_bool y
+
+endif
+
+menuconfig ARCH_REALVIEW
+	bool "ARM Ltd. RealView family"
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_TIMER_SP804
+	select CLK_SP810
+	select GPIO_PL061 if GPIOLIB
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select HAVE_PATA_PLATFORM
+	select HAVE_TCM
+	select CLK_ICST
+	select MACH_REALVIEW_EB if ARCH_MULTI_V5
+	select MFD_SYSCON
+	select PLAT_VERSATILE
+	select POWER_RESET
+	select POWER_RESET_VERSATILE
+	select POWER_SUPPLY
+	select SOC_REALVIEW
+	help
+	  This enables support for ARM Ltd RealView boards.
+
+if ARCH_REALVIEW
+
+config MACH_REALVIEW_EB
+	bool "Support RealView(R) Emulation Baseboard"
+	select ARM_GIC
+	select CPU_ARM926T if ARCH_MULTI_V5
+	help
+	  Include support for the ARM(R) RealView(R) Emulation Baseboard
+	  platform. On an ARMv5 kernel, this will include support for
+	  the ARM926EJ-S core tile, while on an ARMv6/v7 kernel, at least
+	  one of the ARM1136, ARM1176, ARM11MPCore or Cortex-A9MPCore
+	  core tile options should be enabled.
+
+config REALVIEW_EB_ARM1136
+	bool "Support ARM1136J(F)-S Tile"
+	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
+	select CPU_V6
+	help
+	  Enable support for the ARM1136 tile fitted to the
+	  Realview(R) Emulation Baseboard platform.
+
+config REALVIEW_EB_ARM1176
+	bool "Support ARM1176JZ(F)-S Tile"
+	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
+	help
+	  Enable support for the ARM1176 tile fitted to the
+	  Realview(R) Emulation Baseboard platform.
+
+config REALVIEW_EB_A9MP
+	bool "Support Multicore Cortex-A9 Tile"
+	depends on MACH_REALVIEW_EB && ARCH_MULTI_V7
+	help
+	  Enable support for the Cortex-A9MPCore tile fitted to the
+	  Realview(R) Emulation Baseboard platform.
+
+config REALVIEW_EB_ARM11MP
+	bool "Support ARM11MPCore Tile"
+	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
+	select HAVE_SMP
+	help
+	  Enable support for the ARM11MPCore tile fitted to the Realview(R)
+	  Emulation Baseboard platform.
+
+config MACH_REALVIEW_PB11MP
+	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
+	depends on ARCH_MULTI_V6
+	select HAVE_SMP
+	help
+	  Include support for the ARM(R) RealView(R) Platform Baseboard for
+	  the ARM11MPCore.  This platform has an on-board ARM11MPCore and has
+	  support for PCI-E and Compact Flash.
+
+# ARMv6 CPU without K extensions, but does have the new exclusive ops
+config MACH_REALVIEW_PB1176
+	bool "Support RealView(R) Platform Baseboard for ARM1176JZF-S"
+	depends on ARCH_MULTI_V6
+	select CPU_V6
+	select HAVE_TCM
+	help
+	  Include support for the ARM(R) RealView(R) Platform Baseboard for
+	  ARM1176JZF-S.
+
+config MACH_REALVIEW_PBA8
+	bool "Support RealView(R) Platform Baseboard for Cortex(tm)-A8 platform"
+	depends on ARCH_MULTI_V7
+	help
+	  Include support for the ARM(R) RealView Platform Baseboard for
+	  Cortex(tm)-A8.  This platform has an on-board Cortex-A8 and has
+	  support for PCI-E and Compact Flash.
+
+config MACH_REALVIEW_PBX
+	bool "Support RealView(R) Platform Baseboard Explore for Cortex-A9"
+	depends on ARCH_MULTI_V7
+	select ZONE_DMA
+	help
+	  Include support for the ARM(R) RealView(R) Platform Baseboard
+	  Explore.
+
+endif
+
+menuconfig ARCH_VEXPRESS
+	bool "ARM Ltd. Versatile Express family"
+	depends on ARCH_MULTI_V7
+	select ARCH_SUPPORTS_BIG_ENDIAN
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_GLOBAL_TIMER
+	select ARM_TIMER_SP804
+	select GPIOLIB
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select HAVE_PATA_PLATFORM
+	select CLK_ICST
+	select NO_IOPORT_MAP
+	select PLAT_VERSATILE
+	select POWER_RESET
+	select POWER_RESET_VEXPRESS
+	select POWER_SUPPLY
+	select REGULATOR if MMC_ARMMMCI
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select VEXPRESS_CONFIG
+	help
+	  This option enables support for systems using Cortex processor based
+	  ARM core and logic (FPGA) tiles on the Versatile Express motherboard,
+	  for example:
+
+	  - CoreTile Express A5x2 (V2P-CA5s)
+	  - CoreTile Express A9x4 (V2P-CA9)
+	  - CoreTile Express A15x2 (V2P-CA15)
+	  - LogicTile Express 13MG (V2F-2XV6) with A5, A7, A9 or A15 SMMs
+	    (Soft Macrocell Models)
+	  - Versatile Express RTSMs (Models)
+
+	  You must boot using a Flattened Device Tree in order to use these
+	  platforms. The traditional (ATAGs) boot method is not usable on
+	  these boards with this option.
+
+if ARCH_VEXPRESS
+
+config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
+	bool "Enable A5 and A9 only errata work-arounds"
+	default y
+	select ARM_ERRATA_643719 if SMP
+	select ARM_ERRATA_720789
+	select PL310_ERRATA_753970 if CACHE_L2X0
+	help
+	  Provides common dependencies for Versatile Express platforms
+	  based on Cortex-A5 and Cortex-A9 processors. In order to
+	  build a working kernel, you must also enable relevant core
+	  tile support or Flattened Device Tree based support options.
+
+config ARCH_VEXPRESS_DCSCB
+	bool "Dual Cluster System Control Block (DCSCB) support"
+	depends on MCPM
+	select ARM_CCI400_PORT_CTRL
+	help
+	  Support for the Dual Cluster System Configuration Block (DCSCB).
+	  This is needed to provide CPU and cluster power management
+	  on RTSM implementing big.LITTLE.
+
+config ARCH_VEXPRESS_SPC
+	bool "Versatile Express Serial Power Controller (SPC)"
+	select PM_OPP
+	help
+	  The TC2 (A15x2 A7x3) versatile express core tile integrates a logic
+	  block called Serial Power Controller (SPC) that provides the interface
+	  between the dual cluster test-chip and the M3 microcontroller that
+	  carries out power management.
+
+config ARCH_VEXPRESS_TC2_PM
+	bool "Versatile Express TC2 power management"
+	depends on MCPM
+	select ARM_CCI400_PORT_CTRL
+	select ARCH_VEXPRESS_SPC
+	select ARM_CPU_SUSPEND
+	help
+	  Support for CPU and cluster power management on Versatile Express
+	  with a TC2 (A15x2 A7x3) big.LITTLE core tile.
+
+endif
diff --git a/arch/arm/mach-versatile/Makefile b/arch/arm/mach-versatile/Makefile
index 2b907718d467..27d712bcf1af 100644
--- a/arch/arm/mach-versatile/Makefile
+++ b/arch/arm/mach-versatile/Makefile
@@ -3,4 +3,34 @@
 # Makefile for the linux kernel.
 #
 
-obj-y					:= versatile_dt.o
+# versatile
+obj-$(CONFIG_ARCH_VERSATILE)		+= versatile.o
+
+# integrator
+obj-$(CONFIG_ARCH_INTEGRATOR)		+= integrator.o
+obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= integrator_ap.o
+obj-$(CONFIG_ARCH_INTEGRATOR_CP)	+= integrator_cp.o
+
+# realview
+obj-$(CONFIG_ARCH_REALVIEW)		+= realview.o
+
+# vexpress
+obj-$(CONFIG_ARCH_VEXPRESS)		:= v2m.o
+obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
+CFLAGS_dcscb.o				+= -march=armv7-a
+CFLAGS_REMOVE_dcscb.o			= -pg
+obj-$(CONFIG_ARCH_VEXPRESS_SPC)		+= spc.o
+CFLAGS_REMOVE_spc.o			= -pg
+obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o
+CFLAGS_tc2_pm.o				+= -march=armv7-a
+CFLAGS_REMOVE_tc2_pm.o			= -pg
+
+# mps2
+obj-$(CONFIG_ARCH_MPS2)			+= v2m-mps2.o
+
+ifdef CONFIG_SMP
+obj-y					+= headsmp.o platsmp.o
+obj-$(CONFIG_ARCH_REALVIEW)		+= platsmp-realview.o
+obj-$(CONFIG_ARCH_VEXPRESS)		+= platsmp-vexpress.o
+obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
+endif
diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-versatile/Makefile.boot
similarity index 100%
rename from arch/arm/mach-vexpress/Makefile.boot
rename to arch/arm/mach-versatile/Makefile.boot
diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-versatile/dcscb.c
similarity index 97%
rename from arch/arm/mach-vexpress/dcscb.c
rename to arch/arm/mach-versatile/dcscb.c
index a0554d7d04f7..866270e7f271 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-versatile/dcscb.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * arch/arm/mach-vexpress/dcscb.c - Dual Cluster System Configuration Block
+ * dcscb.c - Dual Cluster System Configuration Block
  *
  * Created by:	Nicolas Pitre, May 2012
  * Copyright:	(C) 2012-2013  Linaro Limited
@@ -20,7 +20,7 @@
 #include <asm/cputype.h>
 #include <asm/cp15.h>
 
-#include "core.h"
+#include "vexpress.h"
 
 #define RST_HOLD0	0x0
 #define RST_HOLD1	0x4
diff --git a/arch/arm/mach-vexpress/dcscb_setup.S b/arch/arm/mach-versatile/dcscb_setup.S
similarity index 95%
rename from arch/arm/mach-vexpress/dcscb_setup.S
rename to arch/arm/mach-versatile/dcscb_setup.S
index 0614b2ebd354..92d1fd9d7f6a 100644
--- a/arch/arm/mach-vexpress/dcscb_setup.S
+++ b/arch/arm/mach-versatile/dcscb_setup.S
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * arch/arm/include/asm/dcscb_setup.S
- *
  * Created by:  Dave Martin, 2012-06-22
  * Copyright:   (C) 2012-2013  Linaro Limited
  */
diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/mach-versatile/headsmp.S
similarity index 94%
rename from arch/arm/plat-versatile/headsmp.S
rename to arch/arm/mach-versatile/headsmp.S
index 09d9fc30c8ca..99c32db412ae 100644
--- a/arch/arm/plat-versatile/headsmp.S
+++ b/arch/arm/mach-versatile/headsmp.S
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  linux/arch/arm/plat-versatile/headsmp.S
- *
  *  Copyright (c) 2003 ARM Limited
  *  All Rights Reserved
  */
diff --git a/arch/arm/plat-versatile/hotplug.c b/arch/arm/mach-versatile/hotplug.c
similarity index 98%
rename from arch/arm/plat-versatile/hotplug.c
rename to arch/arm/mach-versatile/hotplug.c
index 2e9dca38bec0..5a152175578b 100644
--- a/arch/arm/plat-versatile/hotplug.c
+++ b/arch/arm/mach-versatile/hotplug.c
@@ -15,7 +15,7 @@
 #include <asm/smp_plat.h>
 #include <asm/cp15.h>
 
-#include <plat/platsmp.h>
+#include "platsmp.h"
 
 static inline void versatile_immitation_enter_lowpower(unsigned int actrl_mask)
 {
diff --git a/arch/arm/mach-integrator/cm.h b/arch/arm/mach-versatile/integrator-cm.h
similarity index 100%
rename from arch/arm/mach-integrator/cm.h
rename to arch/arm/mach-versatile/integrator-cm.h
diff --git a/arch/arm/mach-integrator/hardware.h b/arch/arm/mach-versatile/integrator-hardware.h
similarity index 100%
rename from arch/arm/mach-integrator/hardware.h
rename to arch/arm/mach-versatile/integrator-hardware.h
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-versatile/integrator.c
similarity index 95%
rename from arch/arm/mach-integrator/core.c
rename to arch/arm/mach-versatile/integrator.c
index 0fe5e1dc9d89..fdf9c4db08a7 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-versatile/integrator.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/mach-integrator/core.c
- *
  *  Copyright (C) 2000-2003 Deep Blue Solutions Ltd
  */
 #include <linux/types.h>
@@ -26,9 +24,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/time.h>
 
-#include "hardware.h"
-#include "cm.h"
-#include "common.h"
+#include "integrator-hardware.h"
+#include "integrator-cm.h"
+#include "integrator.h"
 
 static DEFINE_RAW_SPINLOCK(cm_lock);
 static void __iomem *cm_base;
diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-versatile/integrator.h
similarity index 100%
rename from arch/arm/mach-integrator/common.h
rename to arch/arm/mach-versatile/integrator.h
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-versatile/integrator_ap.c
similarity index 97%
rename from arch/arm/mach-integrator/integrator_ap.c
rename to arch/arm/mach-versatile/integrator_ap.c
index 58b02cbbea72..44a69cc69376 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-versatile/integrator_ap.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  linux/arch/arm/mach-integrator/integrator_ap.c
- *
  *  Copyright (C) 2000-2003 Deep Blue Solutions Ltd
  */
 #include <linux/kernel.h>
@@ -20,9 +18,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include "hardware.h"
-#include "cm.h"
-#include "common.h"
+#include "integrator-hardware.h"
+#include "integrator-cm.h"
+#include "integrator.h"
 
 /* Regmap to the AP system controller */
 static struct regmap *ap_syscon_map;
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-versatile/integrator_cp.c
similarity index 96%
rename from arch/arm/mach-integrator/integrator_cp.c
rename to arch/arm/mach-versatile/integrator_cp.c
index b7eb4038798b..2ed4ded56b3f 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-versatile/integrator_cp.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/mach-integrator/integrator_cp.c
- *
  *  Copyright (C) 2003 Deep Blue Solutions Ltd
  */
 #include <linux/kernel.h>
@@ -18,9 +16,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include "hardware.h"
-#include "cm.h"
-#include "common.h"
+#include "integrator-hardware.h"
+#include "integrator-cm.h"
+#include "integrator.h"
 
 /* Base address to the core module header */
 static struct regmap *cm_map;
diff --git a/arch/arm/mach-realview/platsmp-dt.c b/arch/arm/mach-versatile/platsmp-realview.c
similarity index 98%
rename from arch/arm/mach-realview/platsmp-dt.c
rename to arch/arm/mach-versatile/platsmp-realview.c
index 5ae783767a5d..5d363385c801 100644
--- a/arch/arm/mach-realview/platsmp-dt.c
+++ b/arch/arm/mach-versatile/platsmp-realview.c
@@ -13,7 +13,7 @@
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
-#include <plat/platsmp.h>
+#include "platsmp.h"
 
 #define REALVIEW_SYS_FLAGSSET_OFFSET	0x30
 
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-versatile/platsmp-vexpress.c
similarity index 96%
rename from arch/arm/mach-vexpress/platsmp.c
rename to arch/arm/mach-versatile/platsmp-vexpress.c
index 99c93124aa68..1ee3c45e71c9 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-versatile/platsmp-vexpress.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/mach-vexpress/platsmp.c
- *
  *  Copyright (C) 2002 ARM Ltd.
  *  All Rights Reserved
  */
@@ -16,9 +14,8 @@
 #include <asm/smp_scu.h>
 #include <asm/mach/map.h>
 
-#include <plat/platsmp.h>
-
-#include "core.h"
+#include "platsmp.h"
+#include "vexpress.h"
 
 bool __init vexpress_smp_init_ops(void)
 {
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/mach-versatile/platsmp.c
similarity index 97%
rename from arch/arm/plat-versatile/platsmp.c
rename to arch/arm/mach-versatile/platsmp.c
index 3567296cec2a..fa7378321e23 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/mach-versatile/platsmp.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/plat-versatile/platsmp.c
- *
  *  Copyright (C) 2002 ARM Ltd.
  *  All Rights Reserved
  *
@@ -20,7 +18,7 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 
-#include <plat/platsmp.h>
+#include "platsmp.h"
 
 /*
  * versatile_cpu_release controls the release of CPUs from the holding
diff --git a/arch/arm/plat-versatile/include/plat/platsmp.h b/arch/arm/mach-versatile/platsmp.h
similarity index 87%
rename from arch/arm/plat-versatile/include/plat/platsmp.h
rename to arch/arm/mach-versatile/platsmp.h
index 500605f48b80..171a0ab72220 100644
--- a/arch/arm/plat-versatile/include/plat/platsmp.h
+++ b/arch/arm/mach-versatile/platsmp.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  linux/arch/arm/plat-versatile/include/plat/platsmp.h
- *
  *  Copyright (C) 2011 ARM Ltd.
  *  All Rights Reserved
  */
diff --git a/arch/arm/mach-realview/realview-dt.c b/arch/arm/mach-versatile/realview.c
similarity index 100%
rename from arch/arm/mach-realview/realview-dt.c
rename to arch/arm/mach-versatile/realview.c
diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-versatile/spc.c
similarity index 100%
rename from arch/arm/mach-vexpress/spc.c
rename to arch/arm/mach-versatile/spc.c
diff --git a/arch/arm/mach-vexpress/spc.h b/arch/arm/mach-versatile/spc.h
similarity index 100%
rename from arch/arm/mach-vexpress/spc.h
rename to arch/arm/mach-versatile/spc.h
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-versatile/tc2_pm.c
similarity index 99%
rename from arch/arm/mach-vexpress/tc2_pm.c
rename to arch/arm/mach-versatile/tc2_pm.c
index e96c42ae3602..0fe78da0c109 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-versatile/tc2_pm.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * arch/arm/mach-vexpress/tc2_pm.c - TC2 power management support
- *
  * Created by:	Nicolas Pitre, October 2012
  * Copyright:	(C) 2012-2013  Linaro Limited
  *
diff --git a/arch/arm/mach-vexpress/v2m-mps2.c b/arch/arm/mach-versatile/v2m-mps2.c
similarity index 100%
rename from arch/arm/mach-vexpress/v2m-mps2.c
rename to arch/arm/mach-versatile/v2m-mps2.c
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-versatile/v2m.c
similarity index 97%
rename from arch/arm/mach-vexpress/v2m.c
rename to arch/arm/mach-versatile/v2m.c
index ffe7c7a85ae9..79afdf2a90b6 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-versatile/v2m.c
@@ -3,7 +3,7 @@
 #include <linux/of_address.h>
 #include <asm/mach/arch.h>
 
-#include "core.h"
+#include "vexpress.h"
 
 #define SYS_FLAGSSET		0x030
 #define SYS_FLAGSCLR		0x034
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile.c
similarity index 100%
rename from arch/arm/mach-versatile/versatile_dt.c
rename to arch/arm/mach-versatile/versatile.c
diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-versatile/vexpress.h
similarity index 100%
rename from arch/arm/mach-vexpress/core.h
rename to arch/arm/mach-versatile/vexpress.h
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
deleted file mode 100644
index 2e6aff5a0f17..000000000000
--- a/arch/arm/mach-vexpress/Kconfig
+++ /dev/null
@@ -1,81 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-menuconfig ARCH_VEXPRESS
-	bool "ARM Ltd. Versatile Express family"
-	depends on ARCH_MULTI_V7
-	select ARCH_SUPPORTS_BIG_ENDIAN
-	select ARM_AMBA
-	select ARM_GIC
-	select ARM_GLOBAL_TIMER
-	select ARM_TIMER_SP804
-	select GPIOLIB
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select HAVE_PATA_PLATFORM
-	select CLK_ICST
-	select NO_IOPORT_MAP
-	select PLAT_VERSATILE
-	select POWER_RESET
-	select POWER_RESET_VEXPRESS
-	select POWER_SUPPLY
-	select REGULATOR if MMC_ARMMMCI
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select VEXPRESS_CONFIG
-	help
-	  This option enables support for systems using Cortex processor based
-	  ARM core and logic (FPGA) tiles on the Versatile Express motherboard,
-	  for example:
-
-	  - CoreTile Express A5x2 (V2P-CA5s)
-	  - CoreTile Express A9x4 (V2P-CA9)
-	  - CoreTile Express A15x2 (V2P-CA15)
-	  - LogicTile Express 13MG (V2F-2XV6) with A5, A7, A9 or A15 SMMs
-	    (Soft Macrocell Models)
-	  - Versatile Express RTSMs (Models)
-
-	  You must boot using a Flattened Device Tree in order to use these
-	  platforms. The traditional (ATAGs) boot method is not usable on
-	  these boards with this option.
-
-if ARCH_VEXPRESS
-
-config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
-	bool "Enable A5 and A9 only errata work-arounds"
-	default y
-	select ARM_ERRATA_643719 if SMP
-	select ARM_ERRATA_720789
-	select PL310_ERRATA_753970 if CACHE_L2X0
-	help
-	  Provides common dependencies for Versatile Express platforms
-	  based on Cortex-A5 and Cortex-A9 processors. In order to
-	  build a working kernel, you must also enable relevant core
-	  tile support or Flattened Device Tree based support options.
-
-config ARCH_VEXPRESS_DCSCB
-	bool "Dual Cluster System Control Block (DCSCB) support"
-	depends on MCPM
-	select ARM_CCI400_PORT_CTRL
-	help
-	  Support for the Dual Cluster System Configuration Block (DCSCB).
-	  This is needed to provide CPU and cluster power management
-	  on RTSM implementing big.LITTLE.
-
-config ARCH_VEXPRESS_SPC
-	bool "Versatile Express Serial Power Controller (SPC)"
-	select PM_OPP
-	help
-	  The TC2 (A15x2 A7x3) versatile express core tile integrates a logic
-	  block called Serial Power Controller (SPC) that provides the interface
-	  between the dual cluster test-chip and the M3 microcontroller that
-	  carries out power management.
-
-config ARCH_VEXPRESS_TC2_PM
-	bool "Versatile Express TC2 power management"
-	depends on MCPM
-	select ARM_CCI400_PORT_CTRL
-	select ARCH_VEXPRESS_SPC
-	select ARM_CPU_SUSPEND
-	help
-	  Support for CPU and cluster power management on Versatile Express
-	  with a TC2 (A15x2 A7x3) big.LITTLE core tile.
-
-endif
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
deleted file mode 100644
index 3651a1ed0f2b..000000000000
--- a/arch/arm/mach-vexpress/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the linux kernel.
-#
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := \
-	-I$(srctree)/arch/arm/plat-versatile/include
-
-obj-$(CONFIG_ARCH_VEXPRESS)		:= v2m.o
-obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
-CFLAGS_dcscb.o				+= -march=armv7-a
-CFLAGS_REMOVE_dcscb.o			= -pg
-obj-$(CONFIG_ARCH_VEXPRESS_SPC)		+= spc.o
-CFLAGS_REMOVE_spc.o			= -pg
-obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o
-CFLAGS_tc2_pm.o				+= -march=armv7-a
-CFLAGS_REMOVE_tc2_pm.o			= -pg
-obj-$(CONFIG_SMP)			+= platsmp.o
-
-obj-$(CONFIG_ARCH_MPS2)			+= v2m-mps2.o
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
deleted file mode 100644
index 5de44a57c4de..000000000000
--- a/arch/arm/plat-versatile/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
-
-obj-$(CONFIG_SMP) += headsmp.o platsmp.o
-obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
-- 
2.29.2

