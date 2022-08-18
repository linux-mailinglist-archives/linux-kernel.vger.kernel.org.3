Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EAA598F67
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346788AbiHRVYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347074AbiHRVXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C266A4B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E23C61646
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FEBC433B5;
        Thu, 18 Aug 2022 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660857365;
        bh=hmm/QFL7jCta2OjdSxcxJaevc86Rcoy8NfIWFne5tvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pt4FE1jy1DSqZkADgkccazLUzSG3HgS/YGZtBsKPNP/IdpU2xY9Jc3nzgK/AulVDR
         iAr20SAEug+UhXQlxI7QfDDSybiNsuprHxHbxubIAJFIfZInKfm93c3Tx6gJ4njC8C
         QvflvkrVxgAmydXxcoX3qCRffymhceZqXUGuAi1LtIl3EUyYmaPE9T94bUo4K4Boqe
         Voa/snGN4t73oIo0h7QEA1nl+4NELvyI0SMuCP8xE60SpGQvEuZu2KzQ0pU5nuvGUL
         Razn9VPEC1ukZVbZAaXLmE5eJQhIimb87CZ/kXsGeCjjhbCzOQToK3tMoYY8UMAa2y
         mnDBoK36gCUbA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 3/4] ARM: footbridge: move isa-dma support into footbridge
Date:   Thu, 18 Aug 2022 23:15:49 +0200
Message-Id: <20220818211550.3272321-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818211550.3272321-1-arnd@kernel.org>
References: <20220818211550.3272321-1-arnd@kernel.org>
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

The dma-isa.c was shared between footbridge and shark a long time ago,
but as shark was removed, it can be made footbridge specific again.

The fb_dma bits in turn are not used at all and can be removed.

All the ISA related files are now built into the platform regardless
of CONFIG_ISA, as they just refer to on-chip devices rather than actual
ISA cards.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                              |  5 --
 arch/arm/kernel/Makefile                      |  1 -
 arch/arm/mach-footbridge/Kconfig              |  2 +-
 arch/arm/mach-footbridge/Makefile             |  3 +-
 .../arm/{kernel => mach-footbridge}/dma-isa.c |  7 ++-
 arch/arm/mach-footbridge/dma.c                | 57 -------------------
 .../mach-footbridge/include/mach/isa-dma.h    | 14 +----
 7 files changed, 9 insertions(+), 80 deletions(-)
 rename arch/arm/{kernel => mach-footbridge}/dma-isa.c (98%)
 delete mode 100644 arch/arm/mach-footbridge/dma.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87badeae3181..ec7e48f6bd91 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -989,11 +989,6 @@ config ISA
 	  (MCA) or VESA.  ISA is an older system, now being displaced by PCI;
 	  newer boards don't support it.  If you have ISA, say Y, otherwise N.
 
-# Select ISA DMA controller support
-config ISA_DMA
-	bool
-	select ISA_DMA_API
-
 # Select ISA DMA interface
 config ISA_DMA_API
 	bool
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 553866751e1a..95034d32213c 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_ISA_DMA_API)	+= dma.o
 obj-$(CONFIG_FIQ)		+= fiq.o fiqasm.o
 obj-$(CONFIG_MODULES)		+= armksyms.o module.o
 obj-$(CONFIG_ARM_MODULE_PLTS)	+= module-plts.o
-obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o isa.o
 obj-$(CONFIG_ARM_CPU_SUSPEND)	+= sleep.o suspend.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate.o
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index 3497ea8e91e3..1a3676109654 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -48,7 +48,7 @@ config FOOTBRIDGE
 	def_bool y
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_MIGHT_HAVE_PC_SERIO
-	select ISA_DMA
+	select ISA_DMA_API
 
 config ARCH_EBSA285
 	bool
diff --git a/arch/arm/mach-footbridge/Makefile b/arch/arm/mach-footbridge/Makefile
index 30bae6684dce..55d570739f19 100644
--- a/arch/arm/mach-footbridge/Makefile
+++ b/arch/arm/mach-footbridge/Makefile
@@ -5,7 +5,7 @@
 
 # Object file lists.
 
-obj-y			:= common.o dma.o isa-irq.o
+obj-y			:= common.o isa-irq.o isa.o isa-rtc.o dma-isa.o
 
 pci-y			+= dc21285.o
 pci-$(CONFIG_ARCH_CATS) += cats-pci.o
@@ -18,4 +18,3 @@ obj-$(CONFIG_ARCH_NETWINDER) += netwinder-hw.o isa-timer.o
 
 obj-$(CONFIG_PCI)	+=$(pci-y)
 
-obj-$(CONFIG_ISA)	+= isa.o isa-rtc.o
diff --git a/arch/arm/kernel/dma-isa.c b/arch/arm/mach-footbridge/dma-isa.c
similarity index 98%
rename from arch/arm/kernel/dma-isa.c
rename to arch/arm/mach-footbridge/dma-isa.c
index 2d90ecce5a11..e45bc31b0959 100644
--- a/arch/arm/kernel/dma-isa.c
+++ b/arch/arm/mach-footbridge/dma-isa.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/kernel/dma-isa.c
- *
  *  Copyright (C) 1999-2000 Russell King
  *
  *  ISA DMA primitives
@@ -157,7 +155,7 @@ static dma_t isa_dma[8];
 /*
  * ISA DMA always starts at channel 0
  */
-void __init isa_init_dma(void)
+static int __init isa_init_dma(void)
 {
 	/*
 	 * Try to autodetect presence of an ISA DMA controller.
@@ -222,4 +220,7 @@ void __init isa_init_dma(void)
 
 		request_dma(DMA_ISA_CASCADE, "cascade");
 	}
+
+	return 0;
 }
+core_initcall(isa_dma_init);
diff --git a/arch/arm/mach-footbridge/dma.c b/arch/arm/mach-footbridge/dma.c
deleted file mode 100644
index 228757c8e06f..000000000000
--- a/arch/arm/mach-footbridge/dma.c
+++ /dev/null
@@ -1,57 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  linux/arch/arm/kernel/dma-ebsa285.c
- *
- *  Copyright (C) 1998 Phil Blundell
- *
- * DMA functions specific to EBSA-285/CATS architectures
- *
- *  Changelog:
- *   09-Nov-1998 RMK	Split out ISA DMA functions to dma-isa.c
- *   17-Mar-1999 RMK	Allow any EBSA285-like architecture to have
- *			ISA DMA controllers.
- */
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/spinlock.h>
-#include <linux/scatterlist.h>
-
-#include <asm/dma.h>
-
-#include <asm/mach/dma.h>
-#include <asm/hardware/dec21285.h>
-
-#if 0
-static int fb_dma_request(unsigned int chan, dma_t *dma)
-{
-	return -EINVAL;
-}
-
-static void fb_dma_enable(unsigned int chan, dma_t *dma)
-{
-}
-
-static void fb_dma_disable(unsigned int chan, dma_t *dma)
-{
-}
-
-static struct dma_ops fb_dma_ops = {
-	.type		= "fb",
-	.request	= fb_dma_request,
-	.enable		= fb_dma_enable,
-	.disable	= fb_dma_disable,
-};
-#endif
-
-static int __init fb_dma_init(void)
-{
-#if 0
-	dma[_DC21285_DMA(0)].d_ops = &fb_dma_ops;
-	dma[_DC21285_DMA(1)].d_ops = &fb_dma_ops;
-#endif
-#ifdef CONFIG_ISA_DMA
-	isa_init_dma();
-#endif
-	return 0;
-}
-core_initcall(fb_dma_init);
diff --git a/arch/arm/mach-footbridge/include/mach/isa-dma.h b/arch/arm/mach-footbridge/include/mach/isa-dma.h
index 8a1b991076e1..b10731a1f66a 100644
--- a/arch/arm/mach-footbridge/include/mach/isa-dma.h
+++ b/arch/arm/mach-footbridge/include/mach/isa-dma.h
@@ -10,17 +10,9 @@
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H
 
-/*
- * The 21285 has two internal DMA channels; we call these 8 and 9.
- * On CATS hardware we have an additional eight ISA dma channels
- * numbered 0..7.
- */
-#define _ISA_DMA(x)		(0+(x))
-#define _DC21285_DMA(x)		(8+(x))
-
-#define MAX_DMA_CHANNELS	10
+#define MAX_DMA_CHANNELS	8
 
-#define DMA_FLOPPY		_ISA_DMA(2)
-#define DMA_ISA_CASCADE		_ISA_DMA(4)
+#define DMA_FLOPPY		(2)
+#define DMA_ISA_CASCADE		(4)
 
 #endif /* _ASM_ARCH_DMA_H */
-- 
2.29.2

