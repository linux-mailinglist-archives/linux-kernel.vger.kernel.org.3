Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E679E59869B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343877AbiHRO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343825AbiHRO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B03BCCFE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46230612FE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F85CC433D7;
        Thu, 18 Aug 2022 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660834613;
        bh=ezX5UU1asPXPTgpHCHPVGm4xP/s54A8YsDjVnU6X4vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QagzPj3DbZBasCuAInN1YxC1ZjhQ03z5N84MC95qF+eCsEtEvOf2S0PcNGJzAMfTG
         /3Y0O07XKHmewILZ3JopAB6dLRUWYd1HyWjaYphBs+05ozODmWgk+eX9RKpiw6QkcF
         PsrbtFpL8QPegKQAz4cVnTbE7avW8B8gXlA6WjUcFjhLguzTx4euY5zIcuZ/VLxdzl
         7LfzAwLjGxCFLngyjlOR50RKyrsF6Awt/lKqvPZkpl8zuleS2mILewHru5K8Qq0nfl
         W1SrO0ObLpLawYrmhz/vhlHWWSjmEj8Oiu4SOPNoR8FdyfSx5q1MLxZl5UH+TJF3Xp
         3ZUUCh8VquRLg==
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
Subject: [PATCH 5/5] ARM: make ARCH_MULTIPLATFORM user-visible
Date:   Thu, 18 Aug 2022 16:56:16 +0200
Message-Id: <20220818145616.3156379-6-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818145616.3156379-1-arnd@kernel.org>
References: <20220818145616.3156379-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some options like CONFIG_DEBUG_UNCOMPRESS and CONFIG_CMDLINE_FORCE are
fundamentally incompatible with portable kernels but are currently allowed
in all configurations. Other options like XIP_KERNEL are essentially
useless after the completion of the multiplatform conversion.

Repurpose the existing CONFIG_ARCH_MULTIPLATFORM option to decide
whether the resulting kernel image is meant to be portable or not,
and using this to guard all of the known incompatible options.

This is similar to how the RISC-V kernel handles the CONFIG_NONPORTABLE
option (with the opposite polarity).

A few references to CONFIG_ARCH_MULTIPLATFORM were left behind by
earlier clanups and have to be removed now up.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig               | 15 ++++++++++++++-
 arch/arm/Kconfig.debug         |  1 +
 arch/arm/kernel/devtree.c      |  2 --
 arch/arm/mach-dove/Makefile    |  2 +-
 arch/arm/mach-mv78xx0/Makefile |  2 +-
 arch/arm/mach-mvebu/Makefile   |  2 +-
 arch/arm/mach-orion5x/Makefile |  2 +-
 7 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3066ce82cffc..9cbac5bf8b3a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -320,7 +320,19 @@ config ARCH_MMAP_RND_BITS_MAX
 	default 16
 
 config ARCH_MULTIPLATFORM
-	def_bool MMU && !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
+	bool "Require kernel to be portable to multiple machines" if EXPERT
+	depends on MMU && !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
+	default y
+	help
+	  In general, all Arm machines can be supported in a single
+	  kernel image, covering either Armv4/v5 or Armv6/v7.
+
+	  However, some configuration options require hardcoding machine
+	  specific physical addresses or enable errata workarounds that may
+	  break other machines.
+
+	  Selecting N here allows using those options, including
+	  DEBUG_UNCOMPRESS, XIP_KERNEL and ZBOOT_ROM. If unsure, say Y.
 
 menu "Platform selection"
 	depends on MMU
@@ -1609,6 +1621,7 @@ config CMDLINE_EXTEND
 
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
+	depends on !ARCH_MULTIPLATFORM
 	help
 	  Always use the default kernel command string, even if the boot
 	  loader passes other arguments to the kernel.
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 655f84ada30f..c345775f035b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1904,6 +1904,7 @@ config DEBUG_UART_8250_PALMCHIP
 
 config DEBUG_UNCOMPRESS
 	bool "Enable decompressor debugging via DEBUG_LL output"
+	depends on !ARCH_MULTIPLATFORM
 	depends on !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
 	depends on DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 02839d8b6202..264827281113 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -194,14 +194,12 @@ const struct machine_desc * __init setup_machine_fdt(void *dt_virt)
 {
 	const struct machine_desc *mdesc, *mdesc_best = NULL;
 
-#if defined(CONFIG_ARCH_MULTIPLATFORM) || defined(CONFIG_ARM_SINGLE_ARMV7M)
 	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
 		.l2c_aux_val = 0x0,
 		.l2c_aux_mask = ~0x0,
 	MACHINE_END
 
 	mdesc_best = &__mach_desc_GENERIC_DT;
-#endif
 
 	if (!dt_virt || !early_init_dt_verify(dt_virt))
 		return NULL;
diff --git a/arch/arm/mach-dove/Makefile b/arch/arm/mach-dove/Makefile
index e83f6492834d..da373a5768ba 100644
--- a/arch/arm/mach-dove/Makefile
+++ b/arch/arm/mach-dove/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-orion/include
+ccflags-y := -I$(srctree)/arch/arm/plat-orion/include
 
 obj-y				+= common.o
 obj-$(CONFIG_DOVE_LEGACY)	+= irq.o mpp.o
diff --git a/arch/arm/mach-mv78xx0/Makefile b/arch/arm/mach-mv78xx0/Makefile
index a839e960b8c6..50aff70065f2 100644
--- a/arch/arm/mach-mv78xx0/Makefile
+++ b/arch/arm/mach-mv78xx0/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-orion/include
+ccflags-y := -I$(srctree)/arch/arm/plat-orion/include
 
 obj-y				+= common.o mpp.o irq.o pcie.o
 obj-$(CONFIG_MACH_DB78X00_BP)	+= db78x00-bp-setup.o
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index cb106899dd7c..c21733cbb4fa 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-orion/include
+ccflags-y := -I$(srctree)/arch/arm/plat-orion/include
 
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 CFLAGS_pmsu.o			:= -march=armv7-a
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
index 1a585a62d5e6..572c3520f7fe 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion5x/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-orion/include
+ccflags-y := -I$(srctree)/arch/arm/plat-orion/include
 
 obj-y				+= common.o pci.o irq.o mpp.o
 obj-$(CONFIG_MACH_DB88F5281)	+= db88f5281-setup.o
-- 
2.29.2

