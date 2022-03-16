Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C34DBA02
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiCPVQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352738AbiCPVP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8062C116
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32F1361559
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 21:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079B6C340E9;
        Wed, 16 Mar 2022 21:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647465281;
        bh=fIP0naDxLE9JqYaH5QJymhPa4iZbnS9tNS619UXFTpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcZY7zvWNGSJe03krHO9pDAJfbeCqKx4Ro3uZo5h5oGaPdXx9Iss38jB8lwnTAzTj
         Wipzmmoq6NlPTgPVaQLfCjezq6u0PXFmx0XjuGh21dDaB9KvGk2186J9xrG9dA8xlH
         zVG9LusUuDQSn1+dyC2VjkztocHBivvbCFzOpgq3HzCI5qI0wq2bsJUqTQT8Eyrs/H
         qNSDs102fuUo4DWmEOyKSogAbtpkSTVCcwaiFGspSqSN9rSSKaxo8MXJGxHlHVv6sT
         tZIKk+jafc00u1wA2LVlpx5kOrd4BVoqNIdWXO5lz7ZanvtYUUwJDVU3tKA6FWQVtT
         K5Jb//K4nz4+A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Crispin <john@phrozen.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] ARM: remove old MMU-less CPU support
Date:   Wed, 16 Mar 2022 22:12:13 +0100
Message-Id: <20220316211315.2819835-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220316211315.2819835-1-arnd@kernel.org>
References: <20220316211315.2819835-1-arnd@kernel.org>
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

The MMU-less ARM7 and ARM9 variants have been impossible to enable
in mainline kernels for a long time, and the last such platform
was removed in 2014.

Remove the processor definitions for these, along with all associated
configuration symbols.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Given the timing of this submission, I would not expect this
to make it into the 5.18 merge window. If I merge the other
one of the two patches into the soc tree, I would suggest that
we merge it for 5.19 through Russell's tree.
---
 arch/arm/Kconfig                   |  10 +-
 arch/arm/Kconfig-nommu             |  10 -
 arch/arm/Makefile                  |   5 -
 arch/arm/configs/lpc18xx_defconfig |   2 -
 arch/arm/configs/stm32_defconfig   |   2 -
 arch/arm/configs/vf610m4_defconfig |   2 -
 arch/arm/include/asm/glue-cache.h  |  16 --
 arch/arm/mm/Kconfig                | 106 +-------
 arch/arm/mm/Makefile               |   5 -
 arch/arm/mm/proc-arm740.S          | 147 ----------
 arch/arm/mm/proc-arm7tdmi.S        | 110 --------
 arch/arm/mm/proc-arm940.S          | 360 -------------------------
 arch/arm/mm/proc-arm946.S          | 415 -----------------------------
 arch/arm/mm/proc-arm9tdmi.S        |  91 -------
 14 files changed, 8 insertions(+), 1273 deletions(-)
 delete mode 100644 arch/arm/mm/proc-arm740.S
 delete mode 100644 arch/arm/mm/proc-arm7tdmi.S
 delete mode 100644 arch/arm/mm/proc-arm940.S
 delete mode 100644 arch/arm/mm/proc-arm946.S
 delete mode 100644 arch/arm/mm/proc-arm9tdmi.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d184377ce2ae..2962778d5d12 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -515,17 +515,15 @@ config ARCH_MULTI_V4T
 	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
 	depends on !ARCH_MULTI_V6_V7
 	select ARCH_MULTI_V4_V5
-	select CPU_ARM920T if !(CPU_ARM7TDMI || CPU_ARM720T || \
-		CPU_ARM740T || CPU_ARM9TDMI || CPU_ARM922T || \
-		CPU_ARM925T || CPU_ARM940T)
+	select CPU_ARM920T if !(CPU_ARM720T || CPU_ARM922T || CPU_ARM925T)
 
 config ARCH_MULTI_V5
 	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
 	depends on !ARCH_MULTI_V6_V7
 	select ARCH_MULTI_V4_V5
-	select CPU_ARM926T if !(CPU_ARM946E || CPU_ARM1020 || \
-		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
-		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_FEROCEON)
+	select CPU_ARM926T if !(CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || \
+		CPU_ARM1026 || CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || \
+		CPU_FEROCEON)
 
 config ARCH_MULTI_V4_V5
 	bool
diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index 36c80d3dd93f..add3e9b95078 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -18,16 +18,6 @@ config DRAM_SIZE
 	hex '(S)DRAM SIZE' if SET_MEM_PARAM
 	default 0x00800000
 
-config FLASH_MEM_BASE
-	hex 'FLASH Base Address' if SET_MEM_PARAM
-	depends on CPU_ARM740T || CPU_ARM946E || CPU_ARM940T
-	default 0x00400000
-
-config FLASH_SIZE
-	hex 'FLASH Size' if SET_MEM_PARAM
-	depends on CPU_ARM740T || CPU_ARM946E || CPU_ARM940T
-	default 0x00400000
-
 config PROCESSOR_ID
 	hex 'Hard wire the processor ID'
 	default 0x00007700
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a2391b8de5a5..8b34c4127c2e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -77,12 +77,7 @@ arch-$(CONFIG_CPU_32v3)		=-D__LINUX_ARM_ARCH__=3 -march=armv3m
 arch-y := $(arch-y)
 
 # This selects how we optimise for the processor.
-tune-$(CONFIG_CPU_ARM7TDMI)	=-mtune=arm7tdmi
 tune-$(CONFIG_CPU_ARM720T)	=-mtune=arm7tdmi
-tune-$(CONFIG_CPU_ARM740T)	=-mtune=arm7tdmi
-tune-$(CONFIG_CPU_ARM9TDMI)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM940T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM946E)	=-mtune=arm9e
 tune-$(CONFIG_CPU_ARM920T)	=-mtune=arm9tdmi
 tune-$(CONFIG_CPU_ARM922T)	=-mtune=arm9tdmi
 tune-$(CONFIG_CPU_ARM925T)	=-mtune=arm9tdmi
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index be882ea0eee4..9c8d153c4d6e 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -22,8 +22,6 @@ CONFIG_ARCH_LPC18XX=y
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x28000000
 CONFIG_DRAM_SIZE=0x02000000
-CONFIG_FLASH_MEM_BASE=0x1b000000
-CONFIG_FLASH_SIZE=0x00080000
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 551db328009d..34cfcc945509 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -19,8 +19,6 @@ CONFIG_ARCH_STM32=y
 CONFIG_CPU_V7M_NUM_IRQ=240
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x90000000
-CONFIG_FLASH_MEM_BASE=0x08000000
-CONFIG_FLASH_SIZE=0x00200000
 CONFIG_PREEMPT=y
 # CONFIG_ATAGS is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
index a89f035c3b01..28cb4649656e 100644
--- a/arch/arm/configs/vf610m4_defconfig
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -11,8 +11,6 @@ CONFIG_ARCH_MXC=y
 CONFIG_SOC_VF610=y
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x8c000000
-CONFIG_FLASH_MEM_BASE=0x8f000000
-CONFIG_FLASH_SIZE=0x01000000
 CONFIG_CMDLINE="console=/dev/ttyLP2"
 CONFIG_XIP_KERNEL=y
 CONFIG_XIP_PHYS_ADDR=0x0f000080
diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index 724f8dac1e5b..07b7dc2ae0f5 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -46,22 +46,6 @@
 # endif
 #endif
 
-#if defined(CONFIG_CPU_ARM940T)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE arm940
-# endif
-#endif
-
-#if defined(CONFIG_CPU_ARM946E)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE arm946
-# endif
-#endif
-
 #if defined(CONFIG_CPU_CACHE_V4WB)
 # ifdef _CACHE
 #  define MULTI_CACHE 1
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index d30ee26ccc87..8cbedef19188 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -5,21 +5,6 @@ comment "Processor Type"
 # which CPUs we support in the kernel image, and the compiler instruction
 # optimiser behaviour.
 
-# ARM7TDMI
-config CPU_ARM7TDMI
-	bool
-	depends on !MMU
-	select CPU_32v4T
-	select CPU_ABRT_LV4T
-	select CPU_CACHE_V4
-	select CPU_PABRT_LEGACY
-	help
-	  A 32-bit RISC microprocessor based on the ARM7 processor core
-	  which has no memory control unit and cache.
-
-	  Say Y if you want support for the ARM7TDMI processor.
-	  Otherwise, say N.
-
 # ARM720T
 config CPU_ARM720T
 	bool
@@ -39,39 +24,6 @@ config CPU_ARM720T
 	  Say Y if you want support for the ARM720T processor.
 	  Otherwise, say N.
 
-# ARM740T
-config CPU_ARM740T
-	bool
-	depends on !MMU
-	select CPU_32v4T
-	select CPU_ABRT_LV4T
-	select CPU_CACHE_V4
-	select CPU_CP15_MPU
-	select CPU_PABRT_LEGACY
-	select CPU_THUMB_CAPABLE
-	help
-	  A 32-bit RISC processor with 8KB cache or 4KB variants,
-	  write buffer and MPU(Protection Unit) built around
-	  an ARM7TDMI core.
-
-	  Say Y if you want support for the ARM740T processor.
-	  Otherwise, say N.
-
-# ARM9TDMI
-config CPU_ARM9TDMI
-	bool
-	depends on !MMU
-	select CPU_32v4T
-	select CPU_ABRT_NOMMU
-	select CPU_CACHE_V4
-	select CPU_PABRT_LEGACY
-	help
-	  A 32-bit RISC microprocessor based on the ARM9 processor core
-	  which has no memory control unit and cache.
-
-	  Say Y if you want support for the ARM9TDMI processor.
-	  Otherwise, say N.
-
 # ARM920T
 config CPU_ARM920T
 	bool
@@ -168,43 +120,6 @@ config CPU_FA526
 	  Say Y if you want support for the FA526 processor.
 	  Otherwise, say N.
 
-# ARM940T
-config CPU_ARM940T
-	bool
-	depends on !MMU
-	select CPU_32v4T
-	select CPU_ABRT_NOMMU
-	select CPU_CACHE_VIVT
-	select CPU_CP15_MPU
-	select CPU_PABRT_LEGACY
-	select CPU_THUMB_CAPABLE
-	help
-	  ARM940T is a member of the ARM9TDMI family of general-
-	  purpose microprocessors with MPU and separate 4KB
-	  instruction and 4KB data cases, each with a 4-word line
-	  length.
-
-	  Say Y if you want support for the ARM940T processor.
-	  Otherwise, say N.
-
-# ARM946E-S
-config CPU_ARM946E
-	bool
-	depends on !MMU
-	select CPU_32v5
-	select CPU_ABRT_NOMMU
-	select CPU_CACHE_VIVT
-	select CPU_CP15_MPU
-	select CPU_PABRT_LEGACY
-	select CPU_THUMB_CAPABLE
-	help
-	  ARM946E-S is a member of the ARM9E-S family of high-
-	  performance, 32-bit system-on-chip processor solutions.
-	  The TCM and ARMv5TE 32-bit instruction set is supported.
-
-	  Say Y if you want support for the ARM946E-S processor.
-	  Otherwise, say N.
-
 # ARM1020 - needs validating
 config CPU_ARM1020
 	bool
@@ -763,7 +678,7 @@ config CPU_ENDIAN_BE32
 	  Support for the BE-32 (big-endian) mode on pre-ARMv6 processors.
 
 config CPU_HIGH_VECTOR
-	depends on !MMU && CPU_CP15 && !CPU_ARM740T
+	depends on !MMU && CPU_CP15
 	bool "Select the High exception vector"
 	help
 	  Say Y here to select high exception vector(0xFFFF0000~).
@@ -775,7 +690,7 @@ config CPU_HIGH_VECTOR
 
 config CPU_ICACHE_DISABLE
 	bool "Disable I-Cache (I-bit)"
-	depends on (CPU_CP15 && !(CPU_ARM720T || CPU_ARM740T || CPU_XSCALE || CPU_XSC3)) || CPU_V7M
+	depends on (CPU_CP15 && !(CPU_XSCALE || CPU_XSC3)) || CPU_V7M
 	help
 	  Say Y here to disable the processor instruction cache. Unless
 	  you have a reason not to or are unsure, say N.
@@ -795,22 +710,9 @@ config CPU_DCACHE_DISABLE
 	  Say Y here to disable the processor data cache. Unless
 	  you have a reason not to or are unsure, say N.
 
-config CPU_DCACHE_SIZE
-	hex
-	depends on CPU_ARM740T || CPU_ARM946E
-	default 0x00001000 if CPU_ARM740T
-	default 0x00002000 # default size for ARM946E-S
-	help
-	  Some cores are synthesizable to have various sized cache. For
-	  ARM946E-S case, it can vary from 0KB to 1MB.
-	  To support such cache operations, it is efficient to know the size
-	  before compile time.
-	  If your SoC is configured to have a different size, define the value
-	  here with proper conditions.
-
 config CPU_DCACHE_WRITETHROUGH
 	bool "Force write through D-cache"
-	depends on (CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_FA526) && !CPU_DCACHE_DISABLE
+	depends on (CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM1020 || CPU_FA526) && !CPU_DCACHE_DISABLE
 	default y if CPU_ARM925T
 	help
 	  Say Y here to use the data cache in writethrough mode. Unless you
@@ -818,7 +720,7 @@ config CPU_DCACHE_WRITETHROUGH
 
 config CPU_CACHE_ROUND_ROBIN
 	bool "Round robin I and D cache replacement algorithm"
-	depends on (CPU_ARM926T || CPU_ARM946E || CPU_ARM1020) && (!CPU_ICACHE_DISABLE || !CPU_DCACHE_DISABLE)
+	depends on (CPU_ARM926T || CPU_ARM1020) && (!CPU_ICACHE_DISABLE || !CPU_DCACHE_DISABLE)
 	help
 	  Say Y here to use the predictable round-robin cache replacement
 	  policy.  Unless you specifically require this or are unsure, say N.
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 3510503bc5e6..233d273e8c7f 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -75,16 +75,11 @@ obj-$(CONFIG_CPU_TLB_FA)	+= tlb-fa.o
 AFLAGS_tlb-v6.o		:=-Wa,-march=armv6
 AFLAGS_tlb-v7.o		:=-Wa,-march=armv7-a
 
-obj-$(CONFIG_CPU_ARM7TDMI)	+= proc-arm7tdmi.o
 obj-$(CONFIG_CPU_ARM720T)	+= proc-arm720.o
-obj-$(CONFIG_CPU_ARM740T)	+= proc-arm740.o
-obj-$(CONFIG_CPU_ARM9TDMI)	+= proc-arm9tdmi.o
 obj-$(CONFIG_CPU_ARM920T)	+= proc-arm920.o
 obj-$(CONFIG_CPU_ARM922T)	+= proc-arm922.o
 obj-$(CONFIG_CPU_ARM925T)	+= proc-arm925.o
 obj-$(CONFIG_CPU_ARM926T)	+= proc-arm926.o
-obj-$(CONFIG_CPU_ARM940T)	+= proc-arm940.o
-obj-$(CONFIG_CPU_ARM946E)	+= proc-arm946.o
 obj-$(CONFIG_CPU_FA526)		+= proc-fa526.o
 obj-$(CONFIG_CPU_ARM1020)	+= proc-arm1020.o
 obj-$(CONFIG_CPU_ARM1020E)	+= proc-arm1020e.o
diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
deleted file mode 100644
index f2ec3bc60874..000000000000
--- a/arch/arm/mm/proc-arm740.S
+++ /dev/null
@@ -1,147 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  linux/arch/arm/mm/arm740.S: utility functions for ARM740
- *
- *  Copyright (C) 2004-2006 Hyok S. Choi (hyok.choi@samsung.com)
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <linux/pgtable.h>
-#include <asm/assembler.h>
-#include <asm/asm-offsets.h>
-#include <asm/hwcap.h>
-#include <asm/pgtable-hwdef.h>
-#include <asm/ptrace.h>
-
-#include "proc-macros.S"
-
-	.text
-/*
- * cpu_arm740_proc_init()
- * cpu_arm740_do_idle()
- * cpu_arm740_dcache_clean_area()
- * cpu_arm740_switch_mm()
- *
- * These are not required.
- */
-ENTRY(cpu_arm740_proc_init)
-ENTRY(cpu_arm740_do_idle)
-ENTRY(cpu_arm740_dcache_clean_area)
-ENTRY(cpu_arm740_switch_mm)
-	ret	lr
-
-/*
- * cpu_arm740_proc_fin()
- */
-ENTRY(cpu_arm740_proc_fin)
-	mrc	p15, 0, r0, c1, c0, 0
-	bic	r0, r0, #0x3f000000		@ bank/f/lock/s
-	bic	r0, r0, #0x0000000c		@ w-buffer/cache
-	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ret	lr
-
-/*
- * cpu_arm740_reset(loc)
- * Params  : r0 = address to jump to
- * Notes   : This sets up everything for a reset
- */
-	.pushsection	.idmap.text, "ax"
-ENTRY(cpu_arm740_reset)
-	mov	ip, #0
-	mcr	p15, 0, ip, c7, c0, 0		@ invalidate cache
-	mrc	p15, 0, ip, c1, c0, 0		@ get ctrl register
-	bic	ip, ip, #0x0000000c		@ ............wc..
-	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
-	ret	r0
-ENDPROC(cpu_arm740_reset)
-	.popsection
-
-	.type	__arm740_setup, #function
-__arm740_setup:
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c0, 0		@ invalidate caches
-
-	mcr	p15, 0, r0, c6, c3		@ disable area 3~7
-	mcr	p15, 0, r0, c6, c4
-	mcr	p15, 0, r0, c6, c5
-	mcr	p15, 0, r0, c6, c6
-	mcr	p15, 0, r0, c6, c7
-
-	mov	r0, #0x0000003F			@ base = 0, size = 4GB
-	mcr	p15, 0, r0, c6,	c0		@ set area 0, default
-
-	ldr	r0, =(CONFIG_DRAM_BASE & 0xFFFFF000) @ base[31:12] of RAM
-	ldr	r3, =(CONFIG_DRAM_SIZE >> 12)	@ size of RAM (must be >= 4KB)
-	mov	r4, #10				@ 11 is the minimum (4KB)
-1:	add	r4, r4, #1			@ area size *= 2
-	movs	r3, r3, lsr #1
-	bne	1b				@ count not zero r-shift
-	orr	r0, r0, r4, lsl #1		@ the area register value
-	orr	r0, r0, #1			@ set enable bit
-	mcr	p15, 0, r0, c6,	c1		@ set area 1, RAM
-
-	ldr	r0, =(CONFIG_FLASH_MEM_BASE & 0xFFFFF000) @ base[31:12] of FLASH
-	ldr	r3, =(CONFIG_FLASH_SIZE >> 12)	@ size of FLASH (must be >= 4KB)
-	cmp	r3, #0
-	moveq	r0, #0
-	beq	2f
-	mov	r4, #10				@ 11 is the minimum (4KB)
-1:	add	r4, r4, #1			@ area size *= 2
-	movs	r3, r3, lsr #1
-	bne	1b				@ count not zero r-shift
-	orr	r0, r0, r4, lsl #1		@ the area register value
-	orr	r0, r0, #1			@ set enable bit
-2:	mcr	p15, 0, r0, c6,	c2		@ set area 2, ROM/FLASH
-
-	mov	r0, #0x06
-	mcr	p15, 0, r0, c2, c0		@ Region 1&2 cacheable
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mov	r0, #0x00			@ disable whole write buffer
-#else
-	mov	r0, #0x02			@ Region 1 write bufferred
-#endif
-	mcr	p15, 0, r0, c3, c0
-
-	mov	r0, #0x10000
-	sub	r0, r0, #1			@ r0 = 0xffff
-	mcr	p15, 0, r0, c5, c0		@ all read/write access
-
-	mrc	p15, 0, r0, c1, c0		@ get control register
-	bic	r0, r0, #0x3F000000		@ set to standard caching mode
-						@ need some benchmark
-	orr	r0, r0, #0x0000000d		@ MPU/Cache/WB
-
-	ret	lr
-
-	.size	__arm740_setup, . - __arm740_setup
-
-	__INITDATA
-
-	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
-	define_processor_functions arm740, dabort=v4t_late_abort, pabort=legacy_pabort, nommu=1
-
-	.section ".rodata"
-
-	string	cpu_arch_name, "armv4"
-	string	cpu_elf_name, "v4"
-	string	cpu_arm740_name, "ARM740T"
-
-	.align
-
-	.section ".proc.info.init", "a"
-	.type	__arm740_proc_info,#object
-__arm740_proc_info:
-	.long	0x41807400
-	.long	0xfffffff0
-	.long	0
-	.long	0
-	initfn	__arm740_setup, __arm740_proc_info
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_26BIT
-	.long	cpu_arm740_name
-	.long	arm740_processor_functions
-	.long	0
-	.long	0
-	.long	v4_cache_fns			@ cache model
-	.size	__arm740_proc_info, . - __arm740_proc_info
diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
deleted file mode 100644
index 01bbe7576c1c..000000000000
--- a/arch/arm/mm/proc-arm7tdmi.S
+++ /dev/null
@@ -1,110 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  linux/arch/arm/mm/proc-arm7tdmi.S: utility functions for ARM7TDMI
- *
- *  Copyright (C) 2003-2006 Hyok S. Choi <hyok.choi@samsung.com>
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <linux/pgtable.h>
-#include <asm/assembler.h>
-#include <asm/asm-offsets.h>
-#include <asm/hwcap.h>
-#include <asm/pgtable-hwdef.h>
-#include <asm/ptrace.h>
-
-#include "proc-macros.S"
-
-	.text
-/*
- * cpu_arm7tdmi_proc_init()
- * cpu_arm7tdmi_do_idle()
- * cpu_arm7tdmi_dcache_clean_area()
- * cpu_arm7tdmi_switch_mm()
- *
- * These are not required.
- */
-ENTRY(cpu_arm7tdmi_proc_init)
-ENTRY(cpu_arm7tdmi_do_idle)
-ENTRY(cpu_arm7tdmi_dcache_clean_area)
-ENTRY(cpu_arm7tdmi_switch_mm)
-		ret	lr
-
-/*
- * cpu_arm7tdmi_proc_fin()
- */
-ENTRY(cpu_arm7tdmi_proc_fin)
-		ret	lr
-
-/*
- * Function: cpu_arm7tdmi_reset(loc)
- * Params  : loc(r0)	address to jump to
- * Purpose : Sets up everything for a reset and jump to the location for soft reset.
- */
-		.pushsection	.idmap.text, "ax"
-ENTRY(cpu_arm7tdmi_reset)
-		ret	r0
-ENDPROC(cpu_arm7tdmi_reset)
-		.popsection
-
-		.type	__arm7tdmi_setup, #function
-__arm7tdmi_setup:
-		ret	lr
-		.size	__arm7tdmi_setup, . - __arm7tdmi_setup
-
-		__INITDATA
-
-		@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
-		define_processor_functions arm7tdmi, dabort=v4t_late_abort, pabort=legacy_pabort, nommu=1
-
-		.section ".rodata"
-
-		string	cpu_arch_name, "armv4t"
-		string	cpu_elf_name, "v4"
-		string	cpu_arm7tdmi_name, "ARM7TDMI"
-		string	cpu_triscenda7_name, "Triscend-A7x"
-		string	cpu_at91_name, "Atmel-AT91M40xxx"
-		string	cpu_s3c3410_name, "Samsung-S3C3410"
-		string	cpu_s3c44b0x_name, "Samsung-S3C44B0x"
-		string	cpu_s3c4510b_name, "Samsung-S3C4510B"
-		string	cpu_s3c4530_name, "Samsung-S3C4530"
-		string	cpu_netarm_name, "NETARM"
-
-		.align
-
-		.section ".proc.info.init", "a"
-
-.macro arm7tdmi_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, \
-	extra_hwcaps=0
-		.type	__\name\()_proc_info, #object
-__\name\()_proc_info:
-		.long	\cpu_val
-		.long	\cpu_mask
-		.long	0
-		.long	0
-		initfn	__arm7tdmi_setup, __\name\()_proc_info
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_26BIT | ( \extra_hwcaps )
-		.long	\cpu_name
-		.long	arm7tdmi_processor_functions
-		.long	0
-		.long	0
-		.long	v4_cache_fns
-		.size	__\name\()_proc_info, . - __\name\()_proc_info
-.endm
-
-		arm7tdmi_proc_info arm7tdmi, 0x41007700, 0xfff8ff00, \
-			cpu_arm7tdmi_name
-		arm7tdmi_proc_info triscenda7, 0x0001d2ff, 0x0001ffff, \
-			cpu_triscenda7_name, extra_hwcaps=HWCAP_THUMB
-		arm7tdmi_proc_info at91, 0x14000040, 0xfff000e0, \
-			cpu_at91_name, extra_hwcaps=HWCAP_THUMB
-		arm7tdmi_proc_info s3c4510b, 0x36365000, 0xfffff000, \
-			cpu_s3c4510b_name, extra_hwcaps=HWCAP_THUMB
-		arm7tdmi_proc_info s3c4530, 0x4c000000, 0xfff000e0, \
-			cpu_s3c4530_name, extra_hwcaps=HWCAP_THUMB
-		arm7tdmi_proc_info s3c3410, 0x34100000, 0xffff0000, \
-			cpu_s3c3410_name, extra_hwcaps=HWCAP_THUMB
-		arm7tdmi_proc_info s3c44b0x, 0x44b00000, 0xffff0000, \
-			cpu_s3c44b0x_name, extra_hwcaps=HWCAP_THUMB
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
deleted file mode 100644
index cf9bfcc825ca..000000000000
--- a/arch/arm/mm/proc-arm940.S
+++ /dev/null
@@ -1,360 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  linux/arch/arm/mm/arm940.S: utility functions for ARM940T
- *
- *  Copyright (C) 2004-2006 Hyok S. Choi (hyok.choi@samsung.com)
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <linux/pgtable.h>
-#include <asm/assembler.h>
-#include <asm/hwcap.h>
-#include <asm/pgtable-hwdef.h>
-#include <asm/ptrace.h>
-#include "proc-macros.S"
-
-/* ARM940T has a 4KB DCache comprising 256 lines of 4 words */
-#define CACHE_DLINESIZE	16
-#define CACHE_DSEGMENTS	4
-#define CACHE_DENTRIES	64
-
-	.text
-/*
- * cpu_arm940_proc_init()
- * cpu_arm940_switch_mm()
- *
- * These are not required.
- */
-ENTRY(cpu_arm940_proc_init)
-ENTRY(cpu_arm940_switch_mm)
-	ret	lr
-
-/*
- * cpu_arm940_proc_fin()
- */
-ENTRY(cpu_arm940_proc_fin)
-	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
-	bic	r0, r0, #0x00001000		@ i-cache
-	bic	r0, r0, #0x00000004		@ d-cache
-	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ret	lr
-
-/*
- * cpu_arm940_reset(loc)
- * Params  : r0 = address to jump to
- * Notes   : This sets up everything for a reset
- */
-	.pushsection	.idmap.text, "ax"
-ENTRY(cpu_arm940_reset)
-	mov	ip, #0
-	mcr	p15, 0, ip, c7, c5, 0		@ flush I cache
-	mcr	p15, 0, ip, c7, c6, 0		@ flush D cache
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
-	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
-	bic	ip, ip, #0x00000005		@ .............c.p
-	bic	ip, ip, #0x00001000		@ i-cache
-	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
-	ret	r0
-ENDPROC(cpu_arm940_reset)
-	.popsection
-
-/*
- * cpu_arm940_do_idle()
- */
-	.align	5
-ENTRY(cpu_arm940_do_idle)
-	mcr	p15, 0, r0, c7, c0, 4		@ Wait for interrupt
-	ret	lr
-
-/*
- *	flush_icache_all()
- *
- *	Unconditionally clean and invalidate the entire icache.
- */
-ENTRY(arm940_flush_icache_all)
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
-	ret	lr
-ENDPROC(arm940_flush_icache_all)
-
-/*
- *	flush_user_cache_all()
- */
-ENTRY(arm940_flush_user_cache_all)
-	/* FALLTHROUGH */
-
-/*
- *	flush_kern_cache_all()
- *
- *	Clean and invalidate the entire cache.
- */
-ENTRY(arm940_flush_kern_cache_all)
-	mov	r2, #VM_EXEC
-	/* FALLTHROUGH */
-
-/*
- *	flush_user_cache_range(start, end, flags)
- *
- *	There is no efficient way to flush a range of cache entries
- *	in the specified address range. Thus, flushes all.
- *
- *	- start	- start address (inclusive)
- *	- end	- end address (exclusive)
- *	- flags	- vm_flags describing address space
- */
-ENTRY(arm940_flush_user_cache_range)
-	mov	ip, #0
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mcr	p15, 0, ip, c7, c6, 0		@ flush D cache
-#else
-	mov	r1, #(CACHE_DSEGMENTS - 1) << 4	@ 4 segments
-1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 26 @ 64 entries
-2:	mcr	p15, 0, r3, c7, c14, 2		@ clean/flush D index
-	subs	r3, r3, #1 << 26
-	bcs	2b				@ entries 63 to 0
-	subs	r1, r1, #1 << 4
-	bcs	1b				@ segments 3 to 0
-#endif
-	tst	r2, #VM_EXEC
-	mcrne	p15, 0, ip, c7, c5, 0		@ invalidate I cache
-	mcrne	p15, 0, ip, c7, c10, 4		@ drain WB
-	ret	lr
-
-/*
- *	coherent_kern_range(start, end)
- *
- *	Ensure coherency between the Icache and the Dcache in the
- *	region described by start, end.  If you have non-snooping
- *	Harvard caches, you need to implement this function.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- */
-ENTRY(arm940_coherent_kern_range)
-	/* FALLTHROUGH */
-
-/*
- *	coherent_user_range(start, end)
- *
- *	Ensure coherency between the Icache and the Dcache in the
- *	region described by start, end.  If you have non-snooping
- *	Harvard caches, you need to implement this function.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- */
-ENTRY(arm940_coherent_user_range)
-	/* FALLTHROUGH */
-
-/*
- *	flush_kern_dcache_area(void *addr, size_t size)
- *
- *	Ensure no D cache aliasing occurs, either with itself or
- *	the I cache
- *
- *	- addr	- kernel address
- *	- size	- region size
- */
-ENTRY(arm940_flush_kern_dcache_area)
-	mov	r0, #0
-	mov	r1, #(CACHE_DSEGMENTS - 1) << 4	@ 4 segments
-1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 26 @ 64 entries
-2:	mcr	p15, 0, r3, c7, c14, 2		@ clean/flush D index
-	subs	r3, r3, #1 << 26
-	bcs	2b				@ entries 63 to 0
-	subs	r1, r1, #1 << 4
-	bcs	1b				@ segments 7 to 0
-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	ret	lr
-
-/*
- *	dma_inv_range(start, end)
- *
- *	There is no efficient way to invalidate a specifid virtual
- *	address range. Thus, invalidates all.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- */
-arm940_dma_inv_range:
-	mov	ip, #0
-	mov	r1, #(CACHE_DSEGMENTS - 1) << 4	@ 4 segments
-1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 26 @ 64 entries
-2:	mcr	p15, 0, r3, c7, c6, 2		@ flush D entry
-	subs	r3, r3, #1 << 26
-	bcs	2b				@ entries 63 to 0
-	subs	r1, r1, #1 << 4
-	bcs	1b				@ segments 7 to 0
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
-	ret	lr
-
-/*
- *	dma_clean_range(start, end)
- *
- *	There is no efficient way to clean a specifid virtual
- *	address range. Thus, cleans all.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- */
-arm940_dma_clean_range:
-ENTRY(cpu_arm940_dcache_clean_area)
-	mov	ip, #0
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mov	r1, #(CACHE_DSEGMENTS - 1) << 4	@ 4 segments
-1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 26 @ 64 entries
-2:	mcr	p15, 0, r3, c7, c10, 2		@ clean D entry
-	subs	r3, r3, #1 << 26
-	bcs	2b				@ entries 63 to 0
-	subs	r1, r1, #1 << 4
-	bcs	1b				@ segments 7 to 0
-#endif
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
-	ret	lr
-
-/*
- *	dma_flush_range(start, end)
- *
- *	There is no efficient way to clean and invalidate a specifid
- *	virtual address range.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- */
-ENTRY(arm940_dma_flush_range)
-	mov	ip, #0
-	mov	r1, #(CACHE_DSEGMENTS - 1) << 4	@ 4 segments
-1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 26 @ 64 entries
-2:
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mcr	p15, 0, r3, c7, c14, 2		@ clean/flush D entry
-#else
-	mcr	p15, 0, r3, c7, c6, 2		@ invalidate D entry
-#endif
-	subs	r3, r3, #1 << 26
-	bcs	2b				@ entries 63 to 0
-	subs	r1, r1, #1 << 4
-	bcs	1b				@ segments 7 to 0
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
-	ret	lr
-
-/*
- *	dma_map_area(start, size, dir)
- *	- start	- kernel virtual start address
- *	- size	- size of region
- *	- dir	- DMA direction
- */
-ENTRY(arm940_dma_map_area)
-	add	r1, r1, r0
-	cmp	r2, #DMA_TO_DEVICE
-	beq	arm940_dma_clean_range
-	bcs	arm940_dma_inv_range
-	b	arm940_dma_flush_range
-ENDPROC(arm940_dma_map_area)
-
-/*
- *	dma_unmap_area(start, size, dir)
- *	- start	- kernel virtual start address
- *	- size	- size of region
- *	- dir	- DMA direction
- */
-ENTRY(arm940_dma_unmap_area)
-	ret	lr
-ENDPROC(arm940_dma_unmap_area)
-
-	.globl	arm940_flush_kern_cache_louis
-	.equ	arm940_flush_kern_cache_louis, arm940_flush_kern_cache_all
-
-	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
-	define_cache_functions arm940
-
-	.type	__arm940_setup, #function
-__arm940_setup:
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
-	mcr	p15, 0, r0, c7, c6, 0		@ invalidate D cache
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-
-	mcr	p15, 0, r0, c6, c3, 0		@ disable data area 3~7
-	mcr	p15, 0, r0, c6, c4, 0
-	mcr	p15, 0, r0, c6, c5, 0
-	mcr	p15, 0, r0, c6, c6, 0
-	mcr	p15, 0, r0, c6, c7, 0
-
-	mcr	p15, 0, r0, c6, c3, 1		@ disable instruction area 3~7
-	mcr	p15, 0, r0, c6, c4, 1
-	mcr	p15, 0, r0, c6, c5, 1
-	mcr	p15, 0, r0, c6, c6, 1
-	mcr	p15, 0, r0, c6, c7, 1
-
-	mov	r0, #0x0000003F			@ base = 0, size = 4GB
-	mcr	p15, 0, r0, c6,	c0, 0		@ set area 0, default
-	mcr	p15, 0, r0, c6,	c0, 1
-
-	ldr	r0, =(CONFIG_DRAM_BASE & 0xFFFFF000) @ base[31:12] of RAM
-	ldr	r7, =CONFIG_DRAM_SIZE >> 12	@ size of RAM (must be >= 4KB)
-	pr_val	r3, r0, r7, #1
-	mcr	p15, 0, r3, c6,	c1, 0		@ set area 1, RAM
-	mcr	p15, 0, r3, c6,	c1, 1
-
-	ldr	r0, =(CONFIG_FLASH_MEM_BASE & 0xFFFFF000) @ base[31:12] of FLASH
-	ldr	r7, =CONFIG_FLASH_SIZE		@ size of FLASH (must be >= 4KB)
-	pr_val	r3, r0, r6, #1
-	mcr	p15, 0, r3, c6,	c2, 0		@ set area 2, ROM/FLASH
-	mcr	p15, 0, r3, c6,	c2, 1
-
-	mov	r0, #0x06
-	mcr	p15, 0, r0, c2, c0, 0		@ Region 1&2 cacheable
-	mcr	p15, 0, r0, c2, c0, 1
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mov	r0, #0x00			@ disable whole write buffer
-#else
-	mov	r0, #0x02			@ Region 1 write bufferred
-#endif
-	mcr	p15, 0, r0, c3, c0, 0
-
-	mov	r0, #0x10000
-	sub	r0, r0, #1			@ r0 = 0xffff
-	mcr	p15, 0, r0, c5, c0, 0		@ all read/write access
-	mcr	p15, 0, r0, c5, c0, 1
-
-	mrc	p15, 0, r0, c1, c0		@ get control register
-	orr	r0, r0, #0x00001000		@ I-cache
-	orr	r0, r0, #0x00000005		@ MPU/D-cache
-
-	ret	lr
-
-	.size	__arm940_setup, . - __arm940_setup
-
-	__INITDATA
-
-	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
-	define_processor_functions arm940, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
-
-	.section ".rodata"
-
-	string	cpu_arch_name, "armv4t"
-	string	cpu_elf_name, "v4"
-	string	cpu_arm940_name, "ARM940T"
-
-	.align
-
-	.section ".proc.info.init", "a"
-
-	.type	__arm940_proc_info,#object
-__arm940_proc_info:
-	.long	0x41009400
-	.long	0xff00fff0
-	.long	0
-	initfn	__arm940_setup, __arm940_proc_info
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB
-	.long	cpu_arm940_name
-	.long	arm940_processor_functions
-	.long	0
-	.long	0
-	.long	arm940_cache_fns
-	.size	__arm940_proc_info, . - __arm940_proc_info
-
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
deleted file mode 100644
index 6fb3898ad1cd..000000000000
--- a/arch/arm/mm/proc-arm946.S
+++ /dev/null
@@ -1,415 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  linux/arch/arm/mm/arm946.S: utility functions for ARM946E-S
- *
- *  Copyright (C) 2004-2006 Hyok S. Choi (hyok.choi@samsung.com)
- *
- *  (Many of cache codes are from proc-arm926.S)
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <linux/pgtable.h>
-#include <asm/assembler.h>
-#include <asm/hwcap.h>
-#include <asm/pgtable-hwdef.h>
-#include <asm/ptrace.h>
-#include "proc-macros.S"
-
-/*
- * ARM946E-S is synthesizable to have 0KB to 1MB sized D-Cache,
- * comprising 256 lines of 32 bytes (8 words).
- */
-#define CACHE_DSIZE	(CONFIG_CPU_DCACHE_SIZE) /* typically 8KB. */
-#define CACHE_DLINESIZE	32			/* fixed */
-#define CACHE_DSEGMENTS	4			/* fixed */
-#define CACHE_DENTRIES	(CACHE_DSIZE / CACHE_DSEGMENTS / CACHE_DLINESIZE)
-#define CACHE_DLIMIT	(CACHE_DSIZE * 4)	/* benchmark needed */
-
-	.text
-/*
- * cpu_arm946_proc_init()
- * cpu_arm946_switch_mm()
- *
- * These are not required.
- */
-ENTRY(cpu_arm946_proc_init)
-ENTRY(cpu_arm946_switch_mm)
-	ret	lr
-
-/*
- * cpu_arm946_proc_fin()
- */
-ENTRY(cpu_arm946_proc_fin)
-	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
-	bic	r0, r0, #0x00001000		@ i-cache
-	bic	r0, r0, #0x00000004		@ d-cache
-	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ret	lr
-
-/*
- * cpu_arm946_reset(loc)
- * Params  : r0 = address to jump to
- * Notes   : This sets up everything for a reset
- */
-	.pushsection	.idmap.text, "ax"
-ENTRY(cpu_arm946_reset)
-	mov	ip, #0
-	mcr	p15, 0, ip, c7, c5, 0		@ flush I cache
-	mcr	p15, 0, ip, c7, c6, 0		@ flush D cache
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
-	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
-	bic	ip, ip, #0x00000005		@ .............c.p
-	bic	ip, ip, #0x00001000		@ i-cache
-	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
-	ret	r0
-ENDPROC(cpu_arm946_reset)
-	.popsection
-
-/*
- * cpu_arm946_do_idle()
- */
-	.align	5
-ENTRY(cpu_arm946_do_idle)
-	mcr	p15, 0, r0, c7, c0, 4		@ Wait for interrupt
-	ret	lr
-
-/*
- *	flush_icache_all()
- *
- *	Unconditionally clean and invalidate the entire icache.
- */
-ENTRY(arm946_flush_icache_all)
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
-	ret	lr
-ENDPROC(arm946_flush_icache_all)
-
-/*
- *	flush_user_cache_all()
- */
-ENTRY(arm946_flush_user_cache_all)
-	/* FALLTHROUGH */
-
-/*
- *	flush_kern_cache_all()
- *
- *	Clean and invalidate the entire cache.
- */
-ENTRY(arm946_flush_kern_cache_all)
-	mov	r2, #VM_EXEC
-	mov	ip, #0
-__flush_whole_cache:
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mcr	p15, 0, ip, c7, c6, 0		@ flush D cache
-#else
-	mov	r1, #(CACHE_DSEGMENTS - 1) << 29 @ 4 segments
-1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 4 @ n entries
-2:	mcr	p15, 0, r3, c7, c14, 2		@ clean/flush D index
-	subs	r3, r3, #1 << 4
-	bcs	2b				@ entries n to 0
-	subs	r1, r1, #1 << 29
-	bcs	1b				@ segments 3 to 0
-#endif
-	tst	r2, #VM_EXEC
-	mcrne	p15, 0, ip, c7, c5, 0		@ flush I cache
-	mcrne	p15, 0, ip, c7, c10, 4		@ drain WB
-	ret	lr
-
-/*
- *	flush_user_cache_range(start, end, flags)
- *
- *	Clean and invalidate a range of cache entries in the
- *	specified address range.
- *
- *	- start	- start address (inclusive)
- *	- end	- end address (exclusive)
- *	- flags	- vm_flags describing address space
- * (same as arm926)
- */
-ENTRY(arm946_flush_user_cache_range)
-	mov	ip, #0
-	sub	r3, r1, r0			@ calculate total size
-	cmp	r3, #CACHE_DLIMIT
-	bhs	__flush_whole_cache
-
-1:	tst	r2, #VM_EXEC
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
-	mcrne	p15, 0, r0, c7, c5, 1		@ invalidate I entry
-	add	r0, r0, #CACHE_DLINESIZE
-	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
-	mcrne	p15, 0, r0, c7, c5, 1		@ invalidate I entry
-	add	r0, r0, #CACHE_DLINESIZE
-#else
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D entry
-	mcrne	p15, 0, r0, c7, c5, 1		@ invalidate I entry
-	add	r0, r0, #CACHE_DLINESIZE
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D entry
-	mcrne	p15, 0, r0, c7, c5, 1		@ invalidate I entry
-	add	r0, r0, #CACHE_DLINESIZE
-#endif
-	cmp	r0, r1
-	blo	1b
-	tst	r2, #VM_EXEC
-	mcrne	p15, 0, ip, c7, c10, 4		@ drain WB
-	ret	lr
-
-/*
- *	coherent_kern_range(start, end)
- *
- *	Ensure coherency between the Icache and the Dcache in the
- *	region described by start, end.  If you have non-snooping
- *	Harvard caches, you need to implement this function.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- */
-ENTRY(arm946_coherent_kern_range)
-	/* FALLTHROUGH */
-
-/*
- *	coherent_user_range(start, end)
- *
- *	Ensure coherency between the Icache and the Dcache in the
- *	region described by start, end.  If you have non-snooping
- *	Harvard caches, you need to implement this function.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- * (same as arm926)
- */
-ENTRY(arm946_coherent_user_range)
-	bic	r0, r0, #CACHE_DLINESIZE - 1
-1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
-	mcr	p15, 0, r0, c7, c5, 1		@ invalidate I entry
-	add	r0, r0, #CACHE_DLINESIZE
-	cmp	r0, r1
-	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	mov	r0, #0
-	ret	lr
-
-/*
- *	flush_kern_dcache_area(void *addr, size_t size)
- *
- *	Ensure no D cache aliasing occurs, either with itself or
- *	the I cache
- *
- *	- addr	- kernel address
- *	- size	- region size
- * (same as arm926)
- */
-ENTRY(arm946_flush_kern_dcache_area)
-	add	r1, r0, r1
-1:	mcr	p15, 0, r0, c7, c14, 1		@ clean+invalidate D entry
-	add	r0, r0, #CACHE_DLINESIZE
-	cmp	r0, r1
-	blo	1b
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	ret	lr
-
-/*
- *	dma_inv_range(start, end)
- *
- *	Invalidate (discard) the specified virtual address range.
- *	May not write back any entries.  If 'start' or 'end'
- *	are not cache line aligned, those lines must be written
- *	back.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- * (same as arm926)
- */
-arm946_dma_inv_range:
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	tst	r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
-#endif
-	bic	r0, r0, #CACHE_DLINESIZE - 1
-1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
-	add	r0, r0, #CACHE_DLINESIZE
-	cmp	r0, r1
-	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	ret	lr
-
-/*
- *	dma_clean_range(start, end)
- *
- *	Clean the specified virtual address range.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- *
- * (same as arm926)
- */
-arm946_dma_clean_range:
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	bic	r0, r0, #CACHE_DLINESIZE - 1
-1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
-	add	r0, r0, #CACHE_DLINESIZE
-	cmp	r0, r1
-	blo	1b
-#endif
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	ret	lr
-
-/*
- *	dma_flush_range(start, end)
- *
- *	Clean and invalidate the specified virtual address range.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- *
- * (same as arm926)
- */
-ENTRY(arm946_dma_flush_range)
-	bic	r0, r0, #CACHE_DLINESIZE - 1
-1:
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mcr	p15, 0, r0, c7, c14, 1		@ clean+invalidate D entry
-#else
-	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
-#endif
-	add	r0, r0, #CACHE_DLINESIZE
-	cmp	r0, r1
-	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	ret	lr
-
-/*
- *	dma_map_area(start, size, dir)
- *	- start	- kernel virtual start address
- *	- size	- size of region
- *	- dir	- DMA direction
- */
-ENTRY(arm946_dma_map_area)
-	add	r1, r1, r0
-	cmp	r2, #DMA_TO_DEVICE
-	beq	arm946_dma_clean_range
-	bcs	arm946_dma_inv_range
-	b	arm946_dma_flush_range
-ENDPROC(arm946_dma_map_area)
-
-/*
- *	dma_unmap_area(start, size, dir)
- *	- start	- kernel virtual start address
- *	- size	- size of region
- *	- dir	- DMA direction
- */
-ENTRY(arm946_dma_unmap_area)
-	ret	lr
-ENDPROC(arm946_dma_unmap_area)
-
-	.globl	arm946_flush_kern_cache_louis
-	.equ	arm946_flush_kern_cache_louis, arm946_flush_kern_cache_all
-
-	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
-	define_cache_functions arm946
-
-ENTRY(cpu_arm946_dcache_clean_area)
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
-	add	r0, r0, #CACHE_DLINESIZE
-	subs	r1, r1, #CACHE_DLINESIZE
-	bhi	1b
-#endif
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	ret	lr
-
-	.type	__arm946_setup, #function
-__arm946_setup:
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
-	mcr	p15, 0, r0, c7, c6, 0		@ invalidate D cache
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-
-	mcr	p15, 0, r0, c6, c3, 0		@ disable memory region 3~7
-	mcr	p15, 0, r0, c6, c4, 0
-	mcr	p15, 0, r0, c6, c5, 0
-	mcr	p15, 0, r0, c6, c6, 0
-	mcr	p15, 0, r0, c6, c7, 0
-
-	mov	r0, #0x0000003F			@ base = 0, size = 4GB
-	mcr	p15, 0, r0, c6,	c0, 0		@ set region 0, default
-
-	ldr	r0, =(CONFIG_DRAM_BASE & 0xFFFFF000) @ base[31:12] of RAM
-	ldr	r7, =CONFIG_DRAM_SIZE		@ size of RAM (must be >= 4KB)
-	pr_val	r3, r0, r7, #1
-	mcr	p15, 0, r3, c6, c1, 0
-
-	ldr	r0, =(CONFIG_FLASH_MEM_BASE & 0xFFFFF000) @ base[31:12] of FLASH
-	ldr	r7, =CONFIG_FLASH_SIZE		@ size of FLASH (must be >= 4KB)
-	pr_val	r3, r0, r7, #1
-	mcr	p15, 0, r3, c6, c2, 0
-
-	mov	r0, #0x06
-	mcr	p15, 0, r0, c2, c0, 0		@ region 1,2 d-cacheable
-	mcr	p15, 0, r0, c2, c0, 1		@ region 1,2 i-cacheable
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mov	r0, #0x00			@ disable whole write buffer
-#else
-	mov	r0, #0x02			@ region 1 write bufferred
-#endif
-	mcr	p15, 0, r0, c3, c0, 0
-
-/*
- *  Access Permission Settings for future permission control by PU.
- *
- *				priv.	user
- * 	region 0 (whole)	rw	--	: b0001
- * 	region 1 (RAM)		rw	rw	: b0011
- * 	region 2 (FLASH)	rw	r-	: b0010
- *	region 3~7 (none)	--	--	: b0000
- */
-	mov	r0, #0x00000031
-	orr	r0, r0, #0x00000200
-	mcr	p15, 0, r0, c5, c0, 2		@ set data access permission
-	mcr	p15, 0, r0, c5, c0, 3		@ set inst. access permission
-
-	mrc	p15, 0, r0, c1, c0		@ get control register
-	orr	r0, r0, #0x00001000		@ I-cache
-	orr	r0, r0, #0x00000005		@ MPU/D-cache
-#ifdef CONFIG_CPU_CACHE_ROUND_ROBIN
-	orr	r0, r0, #0x00004000		@ .1.. .... .... ....
-#endif
-	ret	lr
-
-	.size	__arm946_setup, . - __arm946_setup
-
-	__INITDATA
-
-	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
-	define_processor_functions arm946, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
-
-	.section ".rodata"
-
-	string	cpu_arch_name, "armv5te"
-	string	cpu_elf_name, "v5t"
-	string	cpu_arm946_name, "ARM946E-S"
-
-	.align
-
-	.section ".proc.info.init", "a"
-	.type	__arm946_proc_info,#object
-__arm946_proc_info:
-	.long	0x41009460
-	.long	0xff00fff0
-	.long	0
-	.long	0
-	initfn	__arm946_setup, __arm946_proc_info
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB
-	.long	cpu_arm946_name
-	.long	arm946_processor_functions
-	.long	0
-	.long	0
-	.long	arm946_cache_fns
-	.size	__arm946_proc_info, . - __arm946_proc_info
-
diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.S
deleted file mode 100644
index a054c0e9c034..000000000000
--- a/arch/arm/mm/proc-arm9tdmi.S
+++ /dev/null
@@ -1,91 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  linux/arch/arm/mm/proc-arm9tdmi.S: utility functions for ARM9TDMI
- *
- *  Copyright (C) 2003-2006 Hyok S. Choi <hyok.choi@samsung.com>
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <linux/pgtable.h>
-#include <asm/assembler.h>
-#include <asm/asm-offsets.h>
-#include <asm/hwcap.h>
-#include <asm/pgtable-hwdef.h>
-#include <asm/ptrace.h>
-
-#include "proc-macros.S"
-
-	.text
-/*
- * cpu_arm9tdmi_proc_init()
- * cpu_arm9tdmi_do_idle()
- * cpu_arm9tdmi_dcache_clean_area()
- * cpu_arm9tdmi_switch_mm()
- *
- * These are not required.
- */
-ENTRY(cpu_arm9tdmi_proc_init)
-ENTRY(cpu_arm9tdmi_do_idle)
-ENTRY(cpu_arm9tdmi_dcache_clean_area)
-ENTRY(cpu_arm9tdmi_switch_mm)
-		ret	lr
-
-/*
- * cpu_arm9tdmi_proc_fin()
- */
-ENTRY(cpu_arm9tdmi_proc_fin)
-		ret	lr
-
-/*
- * Function: cpu_arm9tdmi_reset(loc)
- * Params  : loc(r0)	address to jump to
- * Purpose : Sets up everything for a reset and jump to the location for soft reset.
- */
-		.pushsection	.idmap.text, "ax"
-ENTRY(cpu_arm9tdmi_reset)
-		ret	r0
-ENDPROC(cpu_arm9tdmi_reset)
-		.popsection
-
-		.type	__arm9tdmi_setup, #function
-__arm9tdmi_setup:
-		ret	lr
-		.size	__arm9tdmi_setup, . - __arm9tdmi_setup
-
-		__INITDATA
-
-		@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
-		define_processor_functions arm9tdmi, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
-
-		.section ".rodata"
-
-		string	cpu_arch_name, "armv4t"
-		string	cpu_elf_name, "v4"
-		string	cpu_arm9tdmi_name, "ARM9TDMI"
-		string	cpu_p2001_name, "P2001"
-
-		.align
-
-		.section ".proc.info.init", "a"
-
-.macro arm9tdmi_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req
-		.type	__\name\()_proc_info, #object
-__\name\()_proc_info:
-		.long	\cpu_val
-		.long	\cpu_mask
-		.long	0
-		.long	0
-		initfn	__arm9tdmi_setup, __\name\()_proc_info
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_THUMB | HWCAP_26BIT
-		.long	\cpu_name
-		.long	arm9tdmi_processor_functions
-		.long	0
-		.long	0
-		.long	v4_cache_fns
-		.size	__\name\()_proc_info, . - __\name\()_proc_info
-.endm
-
-	arm9tdmi_proc_info arm9tdmi, 0x41009900, 0xfff8ff00, cpu_arm9tdmi_name
-	arm9tdmi_proc_info p2001, 0x41029000, 0xffffffff, cpu_p2001_name
-- 
2.29.2

