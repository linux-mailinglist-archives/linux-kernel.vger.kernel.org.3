Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D9A4F42D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378822AbiDEOHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbiDEJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91351BB0;
        Tue,  5 Apr 2022 02:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2745CB81B75;
        Tue,  5 Apr 2022 09:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4DCC385AA;
        Tue,  5 Apr 2022 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150345;
        bh=LZi7P727AAqyG0pNnIQlVKBnL0VuX4PaSD5yANuxZ+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujrpDM4B05bGJDyQnmT9CBUXkpuJk/J7gqvyEvm5CRjqSBoowQyDSHaENyib2r47f
         3Krta7/8znFiBKkFREqpzcRqKk/5mBHon+QeGvweYqgN9bDrMJV7EzeqeR54PL1sBa
         AVOJ3DZACKiQjDqorzUIa03Jn+Z684h1cOmwwRlYhJ+EcV7gU6XL44K5RdqywCsSt7
         NCP55TOSN2kxXlzxH/xNxdiT52ZCGhfSdqpbOXK4T3tykQ7D4wwUxQC2GqX7ElQ0Ol
         Dv5WYgP/Ze7WgTIK+gFy9ZAilDoyXNuO8wQO5gyiKRoWvNPz9joBSpjf2crd8LsKmh
         m33/c1S7ST2Kg==
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
Subject: [PATCH 11/12] ARM: rework endianess selection
Date:   Tue,  5 Apr 2022 11:17:49 +0200
Message-Id: <20220405091750.3076973-12-arnd@kernel.org>
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

Choosing big-endian vs little-endian kernels in Kconfig has not worked
correctly since the introduction of CONFIG_ARCH_MULTIPLATFORM a long
time ago.

The problems is that CONFIG_BIG_ENDIAN depends on
ARCH_SUPPORTS_BIG_ENDIAN, which can set by any one platform
in the config, but would actually have to be supported by all
of them.

This was mostly ok for ARMv6/ARMv7 builds, since these are BE8 and
tend to just work aside from problems in nonportable device drivers.
For ARMv4/v5 machines, CONFIG_BIG_ENDIAN and CONFIG_ARCH_MULTIPLATFORM
were never set together, so this was disabled on all those machines
except for IXP4xx.

As IXP4xx can now become part of ARCH_MULTIPLATFORM, it seems better to
formalize this logic: all ARMv4/v5 platforms get an explicit dependency
on being either big-endian (ixp4xx) or little-endian (the rest). We may
want to fix ixp4xx in the future to support both, but it does not work
in LE mode at the moment.

For the ARMv6/v7 platforms, there are two ways this could be handled

 a) allow both modes only for platforms selecting
    'ARCH_SUPPORTS_BIG_ENDIAN' today, but only LE mode for the
    others, given that these were added intentionally at some
    point.

 b) allow both modes everwhere, given that it was already possible
    to build that way by e.g. selecting ARCH_VIRT, and that the
    list is not an accurate reflection of which platforms may or
    may not work.

Out of these, I picked b) because it seemed slighly more logical
to me.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                  |  8 ++++++--
 arch/arm/mach-asm9260/Kconfig     |  1 +
 arch/arm/mach-aspeed/Kconfig      |  2 +-
 arch/arm/mach-at91/Kconfig        |  3 ++-
 arch/arm/mach-clps711x/Kconfig    |  1 +
 arch/arm/mach-davinci/Kconfig     |  1 +
 arch/arm/mach-ep93xx/Kconfig      |  1 +
 arch/arm/mach-exynos/Kconfig      |  1 -
 arch/arm/mach-gemini/Kconfig      |  1 +
 arch/arm/mach-highbank/Kconfig    |  1 -
 arch/arm/mach-hisi/Kconfig        |  2 +-
 arch/arm/mach-imx/Kconfig         |  4 ++--
 arch/arm/mach-iop32x/Kconfig      |  1 +
 arch/arm/mach-keystone/Kconfig    |  1 -
 arch/arm/mach-lpc32xx/Kconfig     |  1 +
 arch/arm/mach-mmp/Kconfig         |  2 +-
 arch/arm/mach-moxart/Kconfig      |  1 +
 arch/arm/mach-mv78xx0/Kconfig     |  1 +
 arch/arm/mach-mvebu/Kconfig       |  3 +--
 arch/arm/mach-mxs/Kconfig         |  1 +
 arch/arm/mach-nomadik/Kconfig     |  1 +
 arch/arm/mach-npcm/Kconfig        |  2 +-
 arch/arm/mach-nspire/Kconfig      |  1 +
 arch/arm/mach-orion5x/Kconfig     |  1 +
 arch/arm/mach-oxnas/Kconfig       |  2 +-
 arch/arm/mach-qcom/Kconfig        |  1 -
 arch/arm/mach-s3c/Kconfig.s3c24xx |  1 +
 arch/arm/mach-socfpga/Kconfig     |  1 -
 arch/arm/mach-spear/Kconfig       |  2 +-
 arch/arm/mach-sunxi/Kconfig       |  3 +--
 arch/arm/mach-versatile/Kconfig   |  5 +++--
 arch/arm/mach-vt8500/Kconfig      |  1 +
 arch/arm/mach-zynq/Kconfig        |  1 -
 arch/arm/mm/Kconfig               | 28 ++++++++++++++++++----------
 34 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 94909cadb78a..4d98de155e20 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -349,6 +349,7 @@ config ARCH_MULTIPLATFORM
 
 config ARCH_FOOTBRIDGE
 	bool "FootBridge"
+	depends on CPU_LITTLE_ENDIAN
 	select CPU_SA110
 	select FOOTBRIDGE
 	select NEED_MACH_MEMORY_H
@@ -358,7 +359,7 @@ config ARCH_FOOTBRIDGE
 
 config ARCH_IXP4XX
 	bool "IXP4xx-based"
-	select ARCH_SUPPORTS_BIG_ENDIAN
+	depends on CPU_BIG_ENDIAN
 	select ARM_PATCH_PHYS_VIRT
 	select CPU_XSCALE
 	select GPIO_IXP4XX
@@ -374,6 +375,7 @@ config ARCH_IXP4XX
 
 config ARCH_PXA
 	bool "PXA2xx/PXA3xx-based"
+	depends on CPU_LITTLE_ENDIAN
 	select ARCH_MTD_XIP
 	select ARM_CPU_SUSPEND if PM
 	select AUTO_ZRELADDR
@@ -393,6 +395,7 @@ config ARCH_PXA
 config ARCH_RPC
 	bool "RiscPC"
 	depends on !CC_IS_CLANG && GCC_VERSION < 90100 && GCC_VERSION >= 60000
+	depends on CPU_LITTLE_ENDIAN
 	select ARCH_ACORN
 	select ARCH_MAY_HAVE_PC_FDC
 	select ARCH_SPARSEMEM_ENABLE
@@ -411,6 +414,7 @@ config ARCH_RPC
 
 config ARCH_SA1100
 	bool "SA1100-based"
+	depends on CPU_LITTLE_ENDIAN
 	select ARCH_MTD_XIP
 	select ARCH_SPARSEMEM_ENABLE
 	select CLKSRC_MMIO
@@ -429,6 +433,7 @@ config ARCH_SA1100
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
+	depends on CPU_LITTLE_ENDIAN
 	select ARCH_OMAP
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
@@ -505,7 +510,6 @@ config ARCH_VIRT
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
-	select ARCH_SUPPORTS_BIG_ENDIAN
 
 config ARCH_AIROHA
 	bool "Airoha SoC Support"
diff --git a/arch/arm/mach-asm9260/Kconfig b/arch/arm/mach-asm9260/Kconfig
index a2e1d0aaf252..74e0f61c74c8 100644
--- a/arch/arm/mach-asm9260/Kconfig
+++ b/arch/arm/mach-asm9260/Kconfig
@@ -2,6 +2,7 @@
 config MACH_ASM9260
 	bool "Alphascale ASM9260"
 	depends on ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
 	select CPU_ARM926T
 	select ASM9260_TIMER
 	help
diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index ea96d11b8502..cd8a15be0724 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_ASPEED
 	bool "Aspeed BMC architectures"
-	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
+	depends on (CPU_LITTLE_ENDIAN && ARCH_MULTI_V5) || ARCH_MULTI_V6 || ARCH_MULTI_V7
 	select SRAM
 	select WATCHDOG
 	select ASPEED_WATCHDOG
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 279810381256..b427c8abc4c6 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_AT91
 	bool "AT91/Microchip SoCs"
-	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
+	depends on (CPU_LITTLE_ENDIAN && (ARCH_MULTI_V4T || ARCH_MULTI_V5)) || \
+		ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
 	select ARM_CPU_SUSPEND if PM && ARCH_MULTI_V7
 	select COMMON_CLK_AT91
 	select GPIOLIB
diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index 314de9477b84..fd32e576ecd0 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -2,6 +2,7 @@
 menuconfig ARCH_CLPS711X
 	bool "Cirrus Logic EP721x/EP731x-based"
 	depends on ARCH_MULTI_V4T
+	depends on CPU_LITTLE_ENDIAN
 	select CLPS711X_TIMER
 	select CPU_ARM720T
 	select GPIOLIB
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 1d3aef84287d..008cbc2ab867 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -3,6 +3,7 @@
 menuconfig ARCH_DAVINCI
 	bool "TI DaVinci"
 	depends on ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
 	select DAVINCI_TIMER
 	select ZONE_DMA
 	select PM_GENERIC_DOMAINS if PM
diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index aa502ab57404..21f4cc2ba651 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -2,6 +2,7 @@
 menuconfig ARCH_EP93XX
 	bool "EP93xx-based"
 	depends on ARCH_MULTI_V4T
+	depends on CPU_LITTLE_ENDIAN
 	select ARCH_SPARSEMEM_ENABLE
 	select ARM_AMBA
 	select ARM_VIC
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index f7d993628cb7..51a336f349f4 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -8,7 +8,6 @@
 menuconfig ARCH_EXYNOS
 	bool "Samsung Exynos"
 	depends on ARCH_MULTI_V7
-	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
 	select EXYNOS_IRQ_COMBINER
diff --git a/arch/arm/mach-gemini/Kconfig b/arch/arm/mach-gemini/Kconfig
index 969674ea5f17..f436a2009eca 100644
--- a/arch/arm/mach-gemini/Kconfig
+++ b/arch/arm/mach-gemini/Kconfig
@@ -2,6 +2,7 @@
 menuconfig ARCH_GEMINI
 	bool "Cortina Systems Gemini"
 	depends on ARCH_MULTI_V4
+	depends on CPU_LITTLE_ENDIAN
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_AMBA
 	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index 9de38ce8124f..c2d6ef6b3927 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -2,7 +2,6 @@
 config ARCH_HIGHBANK
 	bool "Calxeda ECX-1000/2000 (Highbank/Midway)"
 	depends on ARCH_MULTI_V7
-	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 2e980f834a6a..75cccbd3f05f 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ARCH_HISI
 	bool "Hisilicon SoC Support"
-	depends on ARCH_MULTI_V7 || ARCH_MULTI_V5
+	depends on ARCH_MULTI_V7 || (ARCH_MULTI_V5 && CPU_LITTLE_ENDIAN)
 	select ARM_AMBA
 	select ARM_GIC if ARCH_MULTI_V7
 	select ARM_TIMER_SP804
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c5a59158722b..696c59fe4588 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_MXC
 	bool "Freescale i.MX family"
-	depends on ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7 || ARM_SINGLE_ARMV7M
-	select ARCH_SUPPORTS_BIG_ENDIAN
+	depends on (ARCH_MULTI_V4_V5 && CPU_LITTLE_ENDIAN) || \
+		ARCH_MULTI_V6_V7 || ARM_SINGLE_ARMV7M
 	select CLKSRC_IMX_GPT
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
diff --git a/arch/arm/mach-iop32x/Kconfig b/arch/arm/mach-iop32x/Kconfig
index 07dd137b8867..01f60a8e6404 100644
--- a/arch/arm/mach-iop32x/Kconfig
+++ b/arch/arm/mach-iop32x/Kconfig
@@ -2,6 +2,7 @@
 menuconfig ARCH_IOP32X
 	bool "IOP32x-based platforms"
 	depends on ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
 	select CPU_XSCALE
 	select GPIO_IOP
 	select GPIOLIB
diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index cfd39f729f8e..de69cc2dd483 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -8,7 +8,6 @@ config ARCH_KEYSTONE
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_ERRATA_798181 if SMP
 	select COMMON_CLK_KEYSTONE
-	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ZONE_DMA if ARM_LPAE
 	select PINCTRL
 	select PM_GENERIC_DOMAINS if PM
diff --git a/arch/arm/mach-lpc32xx/Kconfig b/arch/arm/mach-lpc32xx/Kconfig
index ec87c65f4536..35730d3696d0 100644
--- a/arch/arm/mach-lpc32xx/Kconfig
+++ b/arch/arm/mach-lpc32xx/Kconfig
@@ -3,6 +3,7 @@
 config ARCH_LPC32XX
 	bool "NXP LPC32XX"
 	depends on ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
 	select ARM_AMBA
 	select CLKSRC_LPC32XX
 	select CPU_ARM926T
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 0dd999212944..9642e6663a52 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_MMP
 	bool "Marvell PXA168/910/MMP2/MMP3"
-	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
+	depends on (CPU_LITTLE_ENDIAN && ARCH_MULTI_V5) || ARCH_MULTI_V7
 	select GPIO_PXA
 	select GPIOLIB
 	select PINCTRL
diff --git a/arch/arm/mach-moxart/Kconfig b/arch/arm/mach-moxart/Kconfig
index 31ada63ba51b..909c6573ba8b 100644
--- a/arch/arm/mach-moxart/Kconfig
+++ b/arch/arm/mach-moxart/Kconfig
@@ -2,6 +2,7 @@
 menuconfig ARCH_MOXART
 	bool "MOXA ART SoC"
 	depends on ARCH_MULTI_V4
+	depends on CPU_LITTLE_ENDIAN
 	select CPU_FA526
 	select ARM_DMA_MEM_BUFFERABLE
 	select FARADAY_FTINTC010
diff --git a/arch/arm/mach-mv78xx0/Kconfig b/arch/arm/mach-mv78xx0/Kconfig
index ea52c7fabb79..f0276f0d1102 100644
--- a/arch/arm/mach-mv78xx0/Kconfig
+++ b/arch/arm/mach-mv78xx0/Kconfig
@@ -2,6 +2,7 @@
 menuconfig ARCH_MV78XX0
 	bool "Marvell MV78xx0"
 	depends on ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
 	select CPU_FEROCEON
 	select GPIOLIB
 	select MVEBU_MBUS
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 34dbeaab94b0..9f60a6fe0eaf 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_MVEBU
 	bool "Marvell Engineering Business Unit (MVEBU) SoCs"
-	depends on ARCH_MULTI_V7 || ARCH_MULTI_V5
-	select ARCH_SUPPORTS_BIG_ENDIAN
+	depends on ARCH_MULTI_V7 || (ARCH_MULTI_V5 && CPU_LITTLE_ENDIAN)
 	select CLKSRC_MMIO
 	select PINCTRL
 	select PLAT_ORION
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index be1c1388055a..26dd8b9b7321 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -16,6 +16,7 @@ config SOC_IMX28
 config ARCH_MXS
 	bool "Freescale MXS (i.MX23, i.MX28) support"
 	depends on ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
 	select GPIOLIB
 	select MXS_TIMER
 	select PINCTRL
diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index e98429be2b18..d1f819468e94 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -2,6 +2,7 @@
 menuconfig ARCH_NOMADIK
 	bool "ST-Ericsson Nomadik"
 	depends on ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
 	select ARM_AMBA
 	select ARM_VIC
 	select CLKSRC_NOMADIK_MTU
diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
index a71cf1d189ae..63b42a19d1b8 100644
--- a/arch/arm/mach-npcm/Kconfig
+++ b/arch/arm/mach-npcm/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_NPCM
 	bool "Nuvoton NPCM Architecture"
-	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
+	depends on (ARCH_MULTI_V5 && CPU_LITTLE_ENDIAN) || ARCH_MULTI_V7
 	select PINCTRL
 
 if ARCH_NPCM
diff --git a/arch/arm/mach-nspire/Kconfig b/arch/arm/mach-nspire/Kconfig
index 6ef1b167619b..eb9916233dea 100644
--- a/arch/arm/mach-nspire/Kconfig
+++ b/arch/arm/mach-nspire/Kconfig
@@ -2,6 +2,7 @@
 config ARCH_NSPIRE
 	bool "TI-NSPIRE based"
 	depends on ARCH_MULTI_V4_V5
+	depends on CPU_LITTLE_ENDIAN
 	select CPU_ARM926T
 	select GENERIC_IRQ_CHIP
 	select ARM_AMBA
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index c77f3b4e287b..bf833b51931d 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -2,6 +2,7 @@
 menuconfig ARCH_ORION5X
 	bool "Marvell Orion"
 	depends on ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
 	select CPU_FEROCEON
 	select GPIOLIB
 	select MVEBU_MBUS
diff --git a/arch/arm/mach-oxnas/Kconfig b/arch/arm/mach-oxnas/Kconfig
index bee5f64c2e5f..a9ded7079268 100644
--- a/arch/arm/mach-oxnas/Kconfig
+++ b/arch/arm/mach-oxnas/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_OXNAS
 	bool "Oxford Semiconductor OXNAS Family SoCs"
+	depends on (ARCH_MULTI_V5 && CPU_LITTLE_ENDIAN) || ARCH_MULTI_V6
 	select ARCH_HAS_RESET_CONTROLLER
 	select COMMON_CLK_OXNAS
 	select GPIOLIB
@@ -11,7 +12,6 @@ menuconfig ARCH_OXNAS
 	select RESET_OXNAS
 	select VERSATILE_FPGA_IRQ
 	select PINCTRL
-	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6
 	help
 	  Support for OxNas SoC family developed by Oxford Semiconductor.
 
diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 466acc4a5e0c..109e126f7271 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -2,7 +2,6 @@
 menuconfig ARCH_QCOM
 	bool "Qualcomm Support"
 	depends on ARCH_MULTI_V7
-	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_GIC
 	select ARM_AMBA
 	select PINCTRL
diff --git a/arch/arm/mach-s3c/Kconfig.s3c24xx b/arch/arm/mach-s3c/Kconfig.s3c24xx
index e388e265ba83..d7dc031abc7a 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c24xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c24xx
@@ -8,6 +8,7 @@
 menuconfig ARCH_S3C24XX
 	bool "Samsung S3C24XX SoCs"
 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
 	select ATAGS
 	select CLKSRC_SAMSUNG_PWM
 	select GPIO_SAMSUNG
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 594edf9bbea4..eb72c240c248 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -3,7 +3,6 @@ menuconfig ARCH_INTEL_SOCFPGA
 	bool "Altera SOCFPGA family"
 	depends on ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
-	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
 	select CACHE_L2X0
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index 20e284563a80..1add7ee49b63 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -5,7 +5,7 @@
 
 menuconfig PLAT_SPEAR
 	bool "ST SPEAr Family"
-	depends on ARCH_MULTI_V7 || ARCH_MULTI_V5
+	depends on ARCH_MULTI_V7 || (ARCH_MULTI_V5 && CPU_LITTLE_ENDIAN)
 	select ARM_AMBA
 	select CLKSRC_MMIO
 	select GPIOLIB
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e5c2fce281cd..93cf70c0749b 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs"
-	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
+	depends on (CPU_LITTLE_ENDIAN && ARCH_MULTI_V5) || ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
@@ -40,7 +40,6 @@ config MACH_SUN7I
 	default ARCH_SUNXI
 	select ARM_GIC
 	select ARM_PSCI
-	select ARCH_SUPPORTS_BIG_ENDIAN
 	select HAVE_ARM_ARCH_TIMER
 	select SUN5I_HSTIMER
 
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index 94b492c12e8d..2ef226194c3a 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -2,6 +2,7 @@
 config ARCH_VERSATILE
 	bool "ARM Ltd. Versatile family"
 	depends on ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
 	select ARM_AMBA
 	select ARM_TIMER_SP804
 	select ARM_VIC
@@ -19,6 +20,7 @@ config ARCH_VERSATILE
 menuconfig ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V6
+	depends on CPU_LITTLE_ENDIAN || ARCH_MULTI_V6
 	select ARM_AMBA
 	select CMA
 	select DMA_CMA
@@ -143,7 +145,7 @@ endif
 
 menuconfig ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
-	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
+	depends on (CPU_LITTLE_ENDIAN && ARCH_MULTI_V5) || ARCH_MULTI_V6 || ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
@@ -247,7 +249,6 @@ endif
 menuconfig ARCH_VEXPRESS
 	bool "ARM Ltd. Versatile Express family"
 	depends on ARCH_MULTI_V7
-	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_GLOBAL_TIMER
diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index d01cdd9ad9c7..1aad54ea3c3d 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -10,6 +10,7 @@ config ARCH_VT8500
 config ARCH_WM8505
 	bool "VIA/Wondermedia 85xx and WM8650"
  	depends on ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
  	select ARCH_VT8500
  	select CPU_ARM926T
 
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index a56748d671c4..05be5aa9b402 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -3,7 +3,6 @@ config ARCH_ZYNQ
 	bool "Xilinx Zynq ARM Cortex A9 Platform"
 	depends on ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
-	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_GLOBAL_TIMER
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index d30ee26ccc87..a3a4589ec73b 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -738,15 +738,29 @@ config SWP_EMULATE
 
 	  If unsure, say Y.
 
+choice
+	prompt "CPU Endianess"
+	default CPU_LITTLE_ENDIAN
+
+config CPU_LITTLE_ENDIAN
+	bool "Built little-endian kernel"
+	help
+	  Say Y if you plan on running a kernel in little-endian mode.
+	  This is the default and is used in practically all modern user
+	  space builds.
+
 config CPU_BIG_ENDIAN
 	bool "Build big-endian kernel"
-	depends on ARCH_SUPPORTS_BIG_ENDIAN
 	depends on !LD_IS_LLD
 	help
 	  Say Y if you plan on running a kernel in big-endian mode.
-	  Note that your board must be properly built and your board
-	  port must properly enable any big-endian related features
-	  of your chipset/board/processor.
+	  This works on many machines using ARMv6 or newer processors
+	  but requires big-endian user space.
+
+	  The only ARMv5 platform with big-endian support is
+	  Intel IXP4xx.
+
+endchoice
 
 config CPU_ENDIAN_BE8
 	bool
@@ -1122,12 +1136,6 @@ config ARM_DMA_MEM_BUFFERABLE
 config ARM_HEAVY_MB
 	bool
 
-config ARCH_SUPPORTS_BIG_ENDIAN
-	bool
-	help
-	  This option specifies the architecture can support big endian
-	  operation.
-
 config DEBUG_ALIGN_RODATA
 	bool "Make rodata strictly non-executable"
 	depends on STRICT_KERNEL_RWX
-- 
2.29.2

