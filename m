Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C01598691
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbiHRO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343754AbiHRO4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:56:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1742BD087
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33AF8B8218F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC7BC43142;
        Thu, 18 Aug 2022 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660834605;
        bh=gXkTI0r2TAql0FBkVhgbbck3bOmCndCtXNOnUhl0JeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXzui0ohxXPCEvKzLE0zGZNn9zdv01Tuh+1/dRp9oDwGyJRr89zhfUeaPrFFa2aqX
         vdiP1bKIsIpgXP3QEmMVd4tIk3jXuuCx73toV4ulqJ2wgL1PPa3rBhMwQ9q7Pu5z/k
         YpyAJOjrXRjL9J4VwJ0rzY/G9WqnspjVt8vRDtnf3QAEBN2pxJ0zG0bUL9Rx4CvbHj
         A3IzSS1Iv82hSIs5VO9maO9rc7g20ZZEOE/2ROq8ueJ60Rer6IuHC3tbP+Pnb/bQ8s
         Gxj3hdi4jlpdRRmynT8FlA32yZY6OC2SvoZWSRlf/T6nWNIWrXj0WZ+uRa5EY/u0Qn
         hsdgKn6CAwmgA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 3/5] ARM: Kconfig: clean up platform selection
Date:   Thu, 18 Aug 2022 16:56:14 +0200
Message-Id: <20220818145616.3156379-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818145616.3156379-1-arnd@kernel.org>
References: <20220818145616.3156379-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The top-level platform selection is mostly meaningless these days after
almost everything is sorted below the CONFIG_ARCH_MULTIPLATFORM, with
the only exception being the 20+ year old StrongARM based machines.

Make this more consistent by removing the entire choice statement and
moving the StrongARM specific options into regular platform specific
Kconfig files.

The three platforms (footbridge, rpc and sa1100) are still mutually
exclusive and cannot coexist with other ARMv4/v5 machines, but since
there are only three of them and we will not add more, this can be
expressed using Kconfig 'depends on' statements.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                      | 114 ++++----------------------
 arch/arm/Kconfig.debug                |   7 +-
 arch/arm/configs/assabet_defconfig    |   2 +
 arch/arm/configs/badge4_defconfig     |   2 +
 arch/arm/configs/cerfcube_defconfig   |   2 +
 arch/arm/configs/collie_defconfig     |   2 +
 arch/arm/configs/footbridge_defconfig |   2 +
 arch/arm/configs/h3600_defconfig      |   2 +
 arch/arm/configs/hackkit_defconfig    |   2 +
 arch/arm/configs/jornada720_defconfig |   2 +
 arch/arm/configs/lart_defconfig       |   2 +
 arch/arm/configs/neponset_defconfig   |   2 +
 arch/arm/configs/netwinder_defconfig  |   2 +
 arch/arm/configs/pleb_defconfig       |   2 +
 arch/arm/configs/rpc_defconfig        |   2 +
 arch/arm/configs/shannon_defconfig    |   2 +
 arch/arm/configs/simpad_defconfig     |   2 +
 arch/arm/mach-footbridge/Kconfig      |  19 ++++-
 arch/arm/mach-imx/Kconfig             |   2 +-
 arch/arm/mach-nspire/Kconfig          |   2 +-
 arch/arm/mach-rpc/Kconfig             |  21 +++++
 arch/arm/mach-sa1100/Kconfig          |  25 ++++--
 22 files changed, 109 insertions(+), 111 deletions(-)
 create mode 100644 arch/arm/mach-rpc/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6894b4758bfb..3066ce82cffc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -28,7 +28,6 @@ config ARM
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MIGHT_HAVE_PC_PARPORT
-	select ARCH_NO_SG_CHAIN if !ARM_HAS_SG_CHAIN
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
 	select ARCH_SUPPORTS_ATOMIC_RMW
@@ -42,6 +41,7 @@ config ARM
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select BUILDTIME_TABLE_SORT if MMU
+	select COMMON_CLK if !(ARCH_RPC || ARCH_FOOTBRIDGE)
 	select CLONE_BACKWARDS
 	select CPU_PM if SUSPEND || CPU_IDLE
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
@@ -110,6 +110,7 @@ config ARM
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
+	select HAVE_PCI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
@@ -126,13 +127,17 @@ config ARM
 	select OF_EARLY_FLATTREE if OF
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
+	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC
 	select RTC_LIB
+	select SPARSE_IRQ if !(ARCH_FOOTBRIDGE || ARCH_RPC)
 	select SYS_SUPPORTS_APM_EMULATION
 	select THREAD_INFO_IN_TASK
+	select TIMER_OF if OF
 	select HAVE_ARCH_VMAP_STACK if MMU && ARM_HAS_GROUP_RELOCS
 	select TRACE_IRQFLAGS_SUPPORT if !CPU_V7M
+	select USE_OF if !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
@@ -154,12 +159,8 @@ config ARM_HAS_GROUP_RELOCS
 	  which is usually sufficient, but not for allyesconfig, so we disable
 	  this feature when doing compile testing.
 
-config ARM_HAS_SG_CHAIN
-	bool
-
 config ARM_DMA_USE_IOMMU
 	bool
-	select ARM_HAS_SG_CHAIN
 	select NEED_SG_DMA_LENGTH
 
 if ARM_DMA_USE_IOMMU
@@ -307,13 +308,8 @@ config MMU
 config ARM_SINGLE_ARMV7M
 	def_bool !MMU
 	select ARM_NVIC
-	select AUTO_ZRELADDR
-	select TIMER_OF
-	select COMMON_CLK
 	select CPU_V7M
 	select NO_IOPORT_MAP
-	select SPARSE_IRQ
-	select USE_OF
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 8
@@ -323,94 +319,19 @@ config ARCH_MMAP_RND_BITS_MAX
 	default 15 if PAGE_OFFSET=0x80000000
 	default 16
 
-#
-# The "ARM system type" choice list is ordered alphabetically by option
-# text.  Please add new entries in the option alphabetic order.
-#
-choice
-	prompt "ARM system type"
-	depends on MMU
-	default ARCH_MULTIPLATFORM
-
 config ARCH_MULTIPLATFORM
-	bool "Allow multiple platforms to be selected"
-	select ARCH_FLATMEM_ENABLE
-	select ARCH_SPARSEMEM_ENABLE
-	select ARCH_SELECT_MEMORY_MODEL
-	select ARM_HAS_SG_CHAIN
-	select ARM_PATCH_PHYS_VIRT
-	select AUTO_ZRELADDR
-	select TIMER_OF
-	select COMMON_CLK
-	select HAVE_PCI
-	select PCI_DOMAINS_GENERIC if PCI
-	select SPARSE_IRQ
-	select USE_OF
-
-config ARCH_FOOTBRIDGE
-	bool "FootBridge"
-	depends on CPU_LITTLE_ENDIAN
-	depends on ATAGS
-	select CPU_SA110
-	select FOOTBRIDGE
-	select NEED_MACH_MEMORY_H
-	help
-	  Support for systems based on the DC21285 companion chip
-	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
-
-config ARCH_RPC
-	bool "RiscPC"
-	depends on !CC_IS_CLANG && GCC_VERSION < 90100 && GCC_VERSION >= 60000
-	depends on CPU_LITTLE_ENDIAN
-	depends on ATAGS
-	select ARCH_ACORN
-	select ARCH_MAY_HAVE_PC_FDC
-	select ARCH_SPARSEMEM_ENABLE
-	select ARM_HAS_SG_CHAIN
-	select CPU_SA110
-	select FIQ
-	select HAVE_PATA_PLATFORM
-	select ISA_DMA_API
-	select LEGACY_TIMER_TICK
-	select NEED_MACH_IO_H
-	select NEED_MACH_MEMORY_H
-	select NO_IOPORT_MAP
-	help
-	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
-	  CD-ROM interface, serial and parallel port, and the floppy drive.
-
-config ARCH_SA1100
-	bool "SA1100-based"
-	depends on CPU_LITTLE_ENDIAN
-	depends on ATAGS
-	select ARCH_MTD_XIP
-	select ARCH_SPARSEMEM_ENABLE
-	select CLKSRC_MMIO
-	select CLKSRC_PXA
-	select TIMER_OF if OF
-	select COMMON_CLK
-	select CPU_FREQ
-	select CPU_SA1100
-	select GPIOLIB
-	select IRQ_DOMAIN
-	select ISA
-	select NEED_MACH_MEMORY_H
-	select SPARSE_IRQ
-	help
-	  Support for StrongARM 11x0 based boards.
+	def_bool MMU && !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
 
-endchoice
-
-menu "Multiple platform selection"
-	depends on ARCH_MULTIPLATFORM
+menu "Platform selection"
+	depends on MMU
 
 comment "CPU Core family selection"
 
 config ARCH_MULTI_V4
-	bool "ARMv4 based platforms (FA526)"
+	bool "ARMv4 based platforms (FA526, StrongARM)"
 	depends on !ARCH_MULTI_V6_V7
 	select ARCH_MULTI_V4_V5
-	select CPU_FA526
+	select CPU_FA526 if !(CPU_SA110 || CPU_SA1100)
 
 config ARCH_MULTI_V4T
 	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
@@ -472,7 +393,6 @@ config ARCH_AIROHA
 	select ARM_GIC_V3
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
-	select COMMON_CLK
 	help
 	  Support for Airoha EN7523 SoCs
 
@@ -573,6 +493,8 @@ source "arch/arm/mach-rda/Kconfig"
 
 source "arch/arm/mach-realtek/Kconfig"
 
+source "arch/arm/mach-rpc/Kconfig"
+
 source "arch/arm/mach-rockchip/Kconfig"
 
 source "arch/arm/mach-s3c/Kconfig"
@@ -638,7 +560,6 @@ config ARCH_ACORN
 config PLAT_ORION
 	bool
 	select CLKSRC_MMIO
-	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
@@ -1358,13 +1279,13 @@ config OABI_COMPAT
 	  at all). If in doubt say N.
 
 config ARCH_SELECT_MEMORY_MODEL
-	bool
+	def_bool y
 
 config ARCH_FLATMEM_ENABLE
-	bool
+	def_bool !(ARCH_RPC || ARCH_SA1100)
 
 config ARCH_SPARSEMEM_ENABLE
-	bool
+	def_bool !ARCH_FOOTBRIDGE
 	select SPARSEMEM_STATIC if SPARSEMEM
 
 config HIGHMEM
@@ -1772,7 +1693,8 @@ config CRASH_DUMP
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
 config AUTO_ZRELADDR
-	bool "Auto calculation of the decompressed kernel image address"
+	bool "Auto calculation of the decompressed kernel image address" if !ARCH_MULTIPLATFORM
+	default !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
 	help
 	  ZRELADDR is the physical address where the decompressed kernel
 	  image will be placed. If AUTO_ZRELADDR is selected, the address
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 792796a348c3..655f84ada30f 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1904,7 +1904,7 @@ config DEBUG_UART_8250_PALMCHIP
 
 config DEBUG_UNCOMPRESS
 	bool "Enable decompressor debugging via DEBUG_LL output"
-	depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
+	depends on !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
 	depends on DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
 		     !DEBUG_BRCMSTB_UART && !DEBUG_SEMIHOSTING
@@ -1921,9 +1921,8 @@ config DEBUG_UNCOMPRESS
 
 config UNCOMPRESS_INCLUDE
 	string
-	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
-	default "mach/uncompress.h"
+	default "mach/uncompress.h" if ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100
+	default "debug/uncompress.h"
 
 config EARLY_PRINTK
 	bool "Early printk"
diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index 801383e4135d..8ba8eb7a4adf 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -1,6 +1,8 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_ASSABET=y
 CONFIG_CMDLINE="mem=32M console=ttySA0,38400n8 initrd=0xc0800000,3M root=/dev/ram"
diff --git a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
index 506f3378da07..b12752fd45cb 100644
--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -1,5 +1,7 @@
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_BADGE4=y
 CONFIG_UNUSED_BOARD_FILES=y
diff --git a/arch/arm/configs/cerfcube_defconfig b/arch/arm/configs/cerfcube_defconfig
index 7e6f7dfa3023..9ada868e2648 100644
--- a/arch/arm/configs/cerfcube_defconfig
+++ b/arch/arm/configs/cerfcube_defconfig
@@ -1,6 +1,8 @@
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_CERF=y
 CONFIG_SA1100_CERF_FLASH_16MB=y
diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index d35cc59ce847..2a2d2cb3ce2e 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -5,6 +5,8 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_BASE_FULL is not set
 # CONFIG_EPOLL is not set
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_COLLIE=y
 CONFIG_CMDLINE="noinitrd root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 504070812ad0..55bf8a6383e2 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -4,6 +4,8 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_HOTPLUG is not set
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_FOOTBRIDGE=y
 CONFIG_ARCH_EBSA285_HOST=y
 CONFIG_ARCH_NETWINDER=y
diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index 5bd1ec539610..4e272875c797 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -4,6 +4,8 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_H3600=y
 # CONFIG_CPU_FREQ_STAT is not set
diff --git a/arch/arm/configs/hackkit_defconfig b/arch/arm/configs/hackkit_defconfig
index b9327b2eacd3..a28fb396afc4 100644
--- a/arch/arm/configs/hackkit_defconfig
+++ b/arch/arm/configs/hackkit_defconfig
@@ -1,6 +1,8 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_HACKKIT=y
 CONFIG_UNUSED_BOARD_FILES=y
diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
index 3dcf89d3e1f1..283c81812e18 100644
--- a/arch/arm/configs/jornada720_defconfig
+++ b/arch/arm/configs/jornada720_defconfig
@@ -1,6 +1,8 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_JORNADA720=y
 CONFIG_SA1100_JORNADA720_SSP=y
diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index 0c2f19d756c0..b0eb488de9bc 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -1,6 +1,8 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_LART=y
 CONFIG_UNUSED_BOARD_FILES=y
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 907403529e30..79da67d37be9 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -1,6 +1,8 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_ASSABET=y
 CONFIG_ASSABET_NEPONSET=y
diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
index cf7bbcf9d98a..17fe4126c5de 100644
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -1,5 +1,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_FOOTBRIDGE=y
 CONFIG_ARCH_NETWINDER=y
 CONFIG_DEPRECATED_PARAM_STRUCT=y
diff --git a/arch/arm/configs/pleb_defconfig b/arch/arm/configs/pleb_defconfig
index d87263336cb2..fd2667873273 100644
--- a/arch/arm/configs/pleb_defconfig
+++ b/arch/arm/configs/pleb_defconfig
@@ -4,6 +4,8 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_HOTPLUG is not set
 # CONFIG_SHMEM is not set
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_PLEB=y
 CONFIG_UNUSED_BOARD_FILES=y
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index 16d74a1f027a..71bfbd5d811c 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -4,6 +4,8 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_RPC=y
 CONFIG_CPU_SA110=y
 CONFIG_FPE_NWFPE=y
diff --git a/arch/arm/configs/shannon_defconfig b/arch/arm/configs/shannon_defconfig
index 42252e85ee49..dfcea70b8034 100644
--- a/arch/arm/configs/shannon_defconfig
+++ b/arch/arm/configs/shannon_defconfig
@@ -1,6 +1,8 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_SHANNON=y
 CONFIG_UNUSED_BOARD_FILES=y
diff --git a/arch/arm/configs/simpad_defconfig b/arch/arm/configs/simpad_defconfig
index cc451728f6d9..4e00a4c2c287 100644
--- a/arch/arm/configs/simpad_defconfig
+++ b/arch/arm/configs/simpad_defconfig
@@ -5,6 +5,8 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_SIMPAD=y
 CONFIG_UNUSED_BOARD_FILES=y
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index acc10b1caa69..1c9eae26e6ac 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -1,7 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0-only
-if ARCH_FOOTBRIDGE
+menuconfig ARCH_FOOTBRIDGE
+	bool "FootBridge Implementations"
+	depends on ARCH_MULTI_V4 && !(ARCH_MULTI_V4T || ARCH_MULTI_V5)
+	depends on !(ARCH_MOXART || ARCH_GEMINI || ARCH_SA1100)
+	depends on ATAGS
+	depends on CPU_LITTLE_ENDIAN
+	depends on MMU
+	select ARCH_NO_SG_CHAIN
+	select CPU_SA110
+	select FOOTBRIDGE
+	select NEED_MACH_MEMORY_H
+	help
+	  Support for systems based on the DC21285 companion chip
+	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
 
-menu "Footbridge Implementations"
+if ARCH_FOOTBRIDGE
 
 config ARCH_CATS
 	bool "CATS"
@@ -57,8 +70,6 @@ config ARCH_NETWINDER
 
 	  Saying N will reduce the size of the Footbridge kernel.
 
-endmenu
-
 # Footbridge support
 config FOOTBRIDGE
 	select ARCH_HAS_PHYS_TO_DMA
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 77e435df8dfe..ab767f059929 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_MXC
 	bool "Freescale i.MX family"
-	depends on (ARCH_MULTI_V4_V5 && CPU_LITTLE_ENDIAN) || \
+	depends on ((ARCH_MULTI_V4T || ARCH_MULTI_V5) && CPU_LITTLE_ENDIAN) || \
 		ARCH_MULTI_V6_V7 || ARM_SINGLE_ARMV7M
 	select CLKSRC_IMX_GPT
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-nspire/Kconfig b/arch/arm/mach-nspire/Kconfig
index eb9916233dea..b7a3871876d7 100644
--- a/arch/arm/mach-nspire/Kconfig
+++ b/arch/arm/mach-nspire/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ARCH_NSPIRE
 	bool "TI-NSPIRE based"
-	depends on ARCH_MULTI_V4_V5
+	depends on ARCH_MULTI_V4T
 	depends on CPU_LITTLE_ENDIAN
 	select CPU_ARM926T
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-rpc/Kconfig b/arch/arm/mach-rpc/Kconfig
new file mode 100644
index 000000000000..55f6d829b677
--- /dev/null
+++ b/arch/arm/mach-rpc/Kconfig
@@ -0,0 +1,21 @@
+config ARCH_RPC
+	bool "RiscPC"
+	depends on ARCH_MULTI_V4 && !(ARCH_MULTI_V4T || ARCH_MULTI_V5)
+	depends on !(ARCH_FOOTBRIDGE || ARCH_SA1100 || ARCH_MOXART || ARCH_GEMINI)
+	depends on !CC_IS_CLANG && GCC_VERSION < 90100 && GCC_VERSION >= 60000
+	depends on CPU_LITTLE_ENDIAN
+	depends on ATAGS
+	depends on MMU
+	select ARCH_ACORN
+	select ARCH_MAY_HAVE_PC_FDC
+	select CPU_SA110
+	select FIQ
+	select HAVE_PATA_PLATFORM
+	select ISA_DMA_API
+	select LEGACY_TIMER_TICK
+	select NEED_MACH_IO_H
+	select NEED_MACH_MEMORY_H
+	select NO_IOPORT_MAP
+	help
+	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
+	  CD-ROM interface, serial and parallel port, and the floppy drive.
diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 7e0161cb1c1f..fb9cd10705de 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -1,7 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0-only
-if ARCH_SA1100
+menuconfig ARCH_SA1100
+	bool "SA11x0 Implementations"
+	depends on ARCH_MULTI_V4 && !(ARCH_MULTI_V4T || ARCH_MULTI_V5)
+	depends on !(ARCH_MOXART || ARCH_GEMINI)
+	depends on ATAGS
+	depends on CPU_LITTLE_ENDIAN
+	depends on MMU
+	select ARCH_NO_SG_CHAIN
+	select ARCH_MTD_XIP
+	select CLKSRC_MMIO
+	select CLKSRC_PXA
+	select CPU_FREQ
+	select CPU_SA1100
+	select GPIOLIB
+	select IRQ_DOMAIN
+	select ISA
+	select NEED_MACH_MEMORY_H
+	help
+	  Support for StrongARM 11x0 based boards.
 
-menu "SA11x0 Implementations"
+if ARCH_SA1100
 
 config SA1100_ASSABET
 	bool "Assabet"
@@ -179,7 +197,4 @@ config SA1100_SSP
 	  This isn't for audio support, but for attached sensors and
 	  other devices, eg for BadgePAD 4 sensor support.
 
-endmenu
-
 endif
-
-- 
2.29.2

