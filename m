Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC944D312E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiCIOno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiCIOne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:43:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD03BC7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:42:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA8960EA5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4170C340F6;
        Wed,  9 Mar 2022 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646836948;
        bh=/IOE9q8yo2NZlvwDe/DVbTQPPU3AcAWQOmaN09MF3ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAYul9PoPEfDWMBeCdNiNUwJTibarEbYXVrQU9Qb2clrADYsp4BMJfuZtdDtnfI5y
         M0M9CgT3+IbHvKCpqrXsb80DY9AbY2h5r2w+ZPszArbcyoSwMetTgzigfNsDOeFB49
         eHruOFUCPnOVRGPzMy7ELfJ89Hk2at0zrmGvkG2K9JHHnqxveT58ooxLO/WDMehuTb
         EhlRWpzNAOWO9AHpmygrRqrXdWppRR8ATvAt/ZWNifbP53Sqbh0BdoqUjKHc0l8tIP
         HMwY2MQNapTLtQ70ITgnlLUACUZjmfiUZ+28lGaAyu6e/EM5xThDIIh+/25Y0wOLum
         BPb5u4KzVt3eA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 2/2] ARM: remove support for NOMMU ARMv4/v5
Date:   Wed,  9 Mar 2022 15:40:48 +0100
Message-Id: <20220309144138.360482-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220309144138.360482-1-arnd@kernel.org>
References: <20220309144138.360482-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This addresses several build failures in randconfig builds that
have accumulated over the years.

Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
If there are no objections, I'd apply this patch to the soc
tree for 5.18 as a cleanup.
---
 arch/arm/Kconfig                              | 34 +++++++------------
 .../mach-footbridge/include/mach/hardware.h   | 20 ++++-------
 arch/arm/mach-footbridge/include/mach/io.h    | 20 -----------
 arch/arm/mach-integrator/hardware.h           |  5 ---
 4 files changed, 20 insertions(+), 59 deletions(-)
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
-- 
2.29.2

