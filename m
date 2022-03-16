Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3173C4DBA00
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbiCPVOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242647AbiCPVOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:14:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C86113E2E;
        Wed, 16 Mar 2022 14:13:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87E656154D;
        Wed, 16 Mar 2022 21:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9935CC340E9;
        Wed, 16 Mar 2022 21:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647465203;
        bh=j9g1X8kPgX82QSfq1Zqkt8ZkZMplFxsc6cONfeELplI=;
        h=From:To:Cc:Subject:Date:From;
        b=OupXhXweBRDatYy0VTGvY6oNmf0tIL7OKSDPKu7o5PRgN5AYATv/ZQLIDB0v7JeBU
         iuzO945QJoqt/OcT42xN4UIvyNAvgi0qHSWK87+hzYuOWXf4t0nljZByICt3Hr0qKH
         vCJIAWlRWiBt2jd1w5lphbLVGlt+STNXElaaMwmly9bppLceQQT1whhWDEIq+jN+TB
         f/EfeB1XAf3Nz0/LpmBbZ2JUHWRx7XWQSQmLYAzsOUjaFt04C1Z/E+c8SNkbCcinHJ
         cJ2UnTQA9oadrWatkkNJ2icY5dfAEx/Osq6zHudNEEm866OddDKpLWQenzfCdS97Af
         M/pkXokv+KO/g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Crispin <john@phrozen.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Jean Delvare <jdelvare@suse.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] ARM: remove support for NOMMU ARMv4/v5
Date:   Wed, 16 Mar 2022 22:12:12 +0100
Message-Id: <20220316211315.2819835-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

It is possible to build MMU-less kernels for Cortex-M base
microcrontrollers as well as a couple of older platforms that
have not been converted to CONFIG_ARCH_MULTIPLATFORM,
specifically ep93xx, footbridge, dove, sa1100 and s3c24xx.

It seems unlikely that anybody has tested those configurations
in recent years, as even building them is frequently broken.
A patch I submitted caused another build time regression
in this configuration. I sent a patch for that, but it seems
better to also remove the option entirely, leaving ARMv7-M
as the only supported Arm NOMMU target for simplicity.

A couple of platforms have dependencies on CONFIG_MMU, those
can all be removed now. Notably, mach-integrator tries to
support MMU-less CPU cores, but those have not actually been
selectable for a long time.

This addresses several build failures in randconfig builds that
have accumulated over the years.

Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
If there are no objections, I'd apply this patch to the soc
tree for 5.18 as a cleanup.
---
 arch/arm/Kconfig                              | 34 +++++++----------
 arch/arm/mach-bcm/Kconfig                     |  1 -
 .../mach-footbridge/include/mach/hardware.h   | 20 ++++------
 arch/arm/mach-footbridge/include/mach/io.h    | 20 ----------
 arch/arm/mach-integrator/Kconfig              | 37 +------------------
 arch/arm/mach-integrator/hardware.h           |  5 ---
 arch/arm/mach-nspire/Kconfig                  |  1 -
 arch/arm/mach-orion5x/Kconfig                 |  2 +-
 arch/arm/mach-shmobile/Kconfig                |  2 +-
 arch/arm/mach-ux500/Kconfig                   |  2 +-
 10 files changed, 24 insertions(+), 100 deletions(-)
 delete mode 100644 arch/arm/mach-footbridge/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5f0b40bab4fb..d184377ce2ae 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -304,6 +304,17 @@ config MMU
 	  Select if you want MMU-based virtualised addressing space
 	  support by paged memory management. If unsure, say 'Y'.
 
+config ARM_SINGLE_ARMV7M
+	def_bool !MMU
+	select ARM_NVIC
+	select AUTO_ZRELADDR
+	select TIMER_OF
+	select COMMON_CLK
+	select CPU_V7M
+	select NO_IOPORT_MAP
+	select SPARSE_IRQ
+	select USE_OF
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 8
 
@@ -318,12 +329,11 @@ config ARCH_MMAP_RND_BITS_MAX
 #
 choice
 	prompt "ARM system type"
-	default ARM_SINGLE_ARMV7M if !MMU
-	default ARCH_MULTIPLATFORM if MMU
+	depends on MMU
+	default ARCH_MULTIPLATFORM
 
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
-	depends on MMU
 	select ARCH_FLATMEM_ENABLE
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_SELECT_MEMORY_MODEL
@@ -337,18 +347,6 @@ config ARCH_MULTIPLATFORM
 	select SPARSE_IRQ
 	select USE_OF
 
-config ARM_SINGLE_ARMV7M
-	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
-	depends on !MMU
-	select ARM_NVIC
-	select AUTO_ZRELADDR
-	select TIMER_OF
-	select COMMON_CLK
-	select CPU_V7M
-	select NO_IOPORT_MAP
-	select SPARSE_IRQ
-	select USE_OF
-
 config ARCH_EP93XX
 	bool "EP93xx-based"
 	select ARCH_SPARSEMEM_ENABLE
@@ -367,7 +365,6 @@ config ARCH_FOOTBRIDGE
 	bool "FootBridge"
 	select CPU_SA110
 	select FOOTBRIDGE
-	select NEED_MACH_IO_H if !MMU
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for systems based on the DC21285 companion chip
@@ -375,7 +372,6 @@ config ARCH_FOOTBRIDGE
 
 config ARCH_IOP32X
 	bool "IOP32x-based"
-	depends on MMU
 	select CPU_XSCALE
 	select GPIO_IOP
 	select GPIOLIB
@@ -387,7 +383,6 @@ config ARCH_IOP32X
 
 config ARCH_IXP4XX
 	bool "IXP4xx-based"
-	depends on MMU
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_PATCH_PHYS_VIRT
 	select CPU_XSCALE
@@ -418,7 +413,6 @@ config ARCH_DOVE
 
 config ARCH_PXA
 	bool "PXA2xx/PXA3xx-based"
-	depends on MMU
 	select ARCH_MTD_XIP
 	select ARM_CPU_SUSPEND if PM
 	select AUTO_ZRELADDR
@@ -437,7 +431,6 @@ config ARCH_PXA
 
 config ARCH_RPC
 	bool "RiscPC"
-	depends on MMU
 	depends on !CC_IS_CLANG && GCC_VERSION < 90100 && GCC_VERSION >= 60000
 	select ARCH_ACORN
 	select ARCH_MAY_HAVE_PC_FDC
@@ -493,7 +486,6 @@ config ARCH_S3C24XX
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
-	depends on MMU
 	select ARCH_OMAP
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index bd3f82788ebc..8db655c3e321 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -185,7 +185,6 @@ config ARCH_BCM_53573
 config ARCH_BCM_63XX
 	bool "Broadcom BCM63xx DSL SoC"
 	depends on ARCH_MULTI_V7
-	depends on MMU
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
diff --git a/arch/arm/mach-footbridge/include/mach/hardware.h b/arch/arm/mach-footbridge/include/mach/hardware.h
index ecaf6e7388d9..985ad3a95671 100644
--- a/arch/arm/mach-footbridge/include/mach/hardware.h
+++ b/arch/arm/mach-footbridge/include/mach/hardware.h
@@ -21,32 +21,26 @@
  * 0xf0000000	0x80000000	16MB	ISA memory
  */
 
-#ifdef CONFIG_MMU
-#define MMU_IO(a, b)	(a)
-#else
-#define MMU_IO(a, b)	(b)
-#endif
-
 #define XBUS_SIZE		0x00100000
-#define XBUS_BASE		MMU_IO(0xff800000, 0x40000000)
+#define XBUS_BASE		0xff800000
 
 #define ARMCSR_SIZE		0x00100000
-#define ARMCSR_BASE		MMU_IO(0xfe000000, 0x42000000)
+#define ARMCSR_BASE		0xfe000000
 
 #define WFLUSH_SIZE		0x00100000
-#define WFLUSH_BASE		MMU_IO(0xfd000000, 0x78000000)
+#define WFLUSH_BASE		0xfd000000
 
 #define PCIIACK_SIZE		0x00100000
-#define PCIIACK_BASE		MMU_IO(0xfc000000, 0x79000000)
+#define PCIIACK_BASE		0xfc000000
 
 #define PCICFG1_SIZE		0x01000000
-#define PCICFG1_BASE		MMU_IO(0xfb000000, 0x7a000000)
+#define PCICFG1_BASE		0xfb000000
 
 #define PCICFG0_SIZE		0x01000000
-#define PCICFG0_BASE		MMU_IO(0xfa000000, 0x7b000000)
+#define PCICFG0_BASE		0xfa000000
 
 #define PCIMEM_SIZE		0x01000000
-#define PCIMEM_BASE		MMU_IO(0xf0000000, 0x80000000)
+#define PCIMEM_BASE		0xf0000000
 
 #define XBUS_CS2		0x40012000
 
diff --git a/arch/arm/mach-footbridge/include/mach/io.h b/arch/arm/mach-footbridge/include/mach/io.h
deleted file mode 100644
index 4e18b921373f..000000000000
--- a/arch/arm/mach-footbridge/include/mach/io.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  arch/arm/mach-footbridge/include/mach/io.h
- *
- *  Copyright (C) 1997-1999 Russell King
- *
- *  Modifications:
- *   06-12-1997	RMK	Created.
- *   07-04-1999	RMK	Major cleanup
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-/*
- * Translation of various i/o addresses to host addresses for !CONFIG_MMU
- */
-#define PCIO_BASE       0x7c000000
-#define __io(a)			((void __iomem *)(PCIO_BASE + (a)))
-
-#endif
diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index 63a0ca82659a..d61ea616cf8e 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -42,24 +42,12 @@ config INTEGRATOR_IMPD1
 	  allows ARM(R) Ltd PrimeCells to be developed and evaluated.
 	  The IM-PD1 can be found on the Integrator/PP2 platform.
 
-config INTEGRATOR_CM7TDMI
-	bool "Integrator/CM7TDMI core module"
-	depends on ARCH_INTEGRATOR_AP
-	depends on ARCH_MULTI_V4 && !MMU
-	select CPU_ARM7TDMI
-
 config INTEGRATOR_CM720T
 	bool "Integrator/CM720T core module"
 	depends on ARCH_INTEGRATOR_AP
 	depends on ARCH_MULTI_V4T
 	select CPU_ARM720T
 
-config INTEGRATOR_CM740T
-	bool "Integrator/CM740T core module"
-	depends on ARCH_INTEGRATOR_AP
-	depends on ARCH_MULTI_V4T && !MMU
-	select CPU_ARM740T
-
 config INTEGRATOR_CM920T
 	bool "Integrator/CM920T core module"
 	depends on ARCH_INTEGRATOR_AP
@@ -78,23 +66,6 @@ config INTEGRATOR_CM926EJS
 	depends on ARCH_MULTI_V5
 	select CPU_ARM926T
 
-config INTEGRATOR_CM940T
-	bool "Integrator/CM940T core module"
-	depends on ARCH_INTEGRATOR_AP
-	depends on ARCH_MULTI_V4T && !MMU
-	select CPU_ARM940T
-
-config INTEGRATOR_CM946ES
-	bool "Integrator/CM946E-S core module"
-	depends on ARCH_INTEGRATOR_AP
-	depends on ARCH_MULTI_V5 && !MMU
-	select CPU_ARM946E
-
-config INTEGRATOR_CM966ES
-	bool "Integrator/CM966E-S core module"
-	depends on ARCH_INTEGRATOR_AP
-	depends on BROKEN # no kernel support
-
 config INTEGRATOR_CM10200E_REV0
 	bool "Integrator/CM10200E rev.0 core module"
 	depends on ARCH_INTEGRATOR_AP && n
@@ -127,7 +98,7 @@ config INTEGRATOR_CM1136JFS
 
 config ARCH_INTEGRATOR_CP
 	bool "Support Integrator/CP platform"
-	depends on (!MMU || ARCH_MULTI_V5 || ARCH_MULTI_V6)
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6
 	select ARM_TIMER_SP804
 	select SERIAL_AMBA_PL011 if TTY
 	select SERIAL_AMBA_PL011_CONSOLE if TTY
@@ -135,12 +106,6 @@ config ARCH_INTEGRATOR_CP
 	help
 	  Include support for the ARM(R) Integrator CP platform.
 
-config INTEGRATOR_CT7T
-	bool "Integrator/CT7TD (ARM7TDMI) core tile"
-	depends on ARCH_INTEGRATOR_CP
-	depends on ARCH_MULTI_V4T && !MMU
-	select CPU_ARM7TDMI
-
 config INTEGRATOR_CT926
 	bool "Integrator/CT926 (ARM926EJ-S) core tile"
 	depends on ARCH_INTEGRATOR_CP
diff --git a/arch/arm/mach-integrator/hardware.h b/arch/arm/mach-integrator/hardware.h
index 4d6ade3dd4ee..81ce09e3ad45 100644
--- a/arch/arm/mach-integrator/hardware.h
+++ b/arch/arm/mach-integrator/hardware.h
@@ -16,12 +16,7 @@
 #define IO_START		INTEGRATOR_HDR_BASE        // PA of IO
 
 /* macro to get at IO space when running virtually */
-#ifdef CONFIG_MMU
 #define IO_ADDRESS(x)	(((x) & 0x000fffff) | (((x) >> 4) & 0x0ff00000) | IO_BASE)
-#else
-#define IO_ADDRESS(x)	(x)
-#endif
-
 #define __io_address(n)		((void __iomem *)IO_ADDRESS(n))
 
 /*
diff --git a/arch/arm/mach-nspire/Kconfig b/arch/arm/mach-nspire/Kconfig
index b3d161e8e2fb..6ef1b167619b 100644
--- a/arch/arm/mach-nspire/Kconfig
+++ b/arch/arm/mach-nspire/Kconfig
@@ -2,7 +2,6 @@
 config ARCH_NSPIRE
 	bool "TI-NSPIRE based"
 	depends on ARCH_MULTI_V4_V5
-	depends on MMU
 	select CPU_ARM926T
 	select GENERIC_IRQ_CHIP
 	select ARM_AMBA
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index e94a61901ffd..c77f3b4e287b 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_ORION5X
 	bool "Marvell Orion"
-	depends on MMU && ARCH_MULTI_V5
+	depends on ARCH_MULTI_V5
 	select CPU_FEROCEON
 	select GPIOLIB
 	select MVEBU_MBUS
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 3683d6f10973..50909c4b95b2 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
-	depends on ARCH_MULTI_V7 && MMU
+	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select GPIOLIB
 	select NO_IOPORT_MAP
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 24ed7f4a87a4..c18def269137 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig ARCH_U8500
 	bool "ST-Ericsson U8500 Series"
-	depends on ARCH_MULTI_V7 && MMU
+	depends on ARCH_MULTI_V7
 	select AB8500_CORE
 	select ABX500_CORE
 	select ARM_AMBA
-- 
2.29.2

