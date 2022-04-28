Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14FC513544
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347295AbiD1NiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347288AbiD1NiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:38:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C26AF1CA;
        Thu, 28 Apr 2022 06:34:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A798E60F62;
        Thu, 28 Apr 2022 13:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B78C385A9;
        Thu, 28 Apr 2022 13:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651152897;
        bh=R/8NHwf/k1Tej2bbEXzw8QMaYJ9QL79nGrxrkXr4XI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZZH4oiRgdjoQkWerLSedC+zkti4fMhEOoBPztB/MQJHDUmshzCHJNO+7kbpsgJ/k
         41L8sMwiSVix6vesHxXMr/oRKrBWue/2E+QMpc3Fz09UgcZRgMoRg25KXIx5xcKfqe
         r2OuXP244k0ltJRAcHZu6ozIoVfgNyQlII5aZlWzk5aPFFdszRn9UKzVx73F1u8Zgb
         aUdcHSlxuCZaDOzLDRKMNBWKF3+uYeyEnM0jiV4z5LnWN71u6LOjpfEfhEJH9J41CX
         9w72rye5BoFo1mPxmwJXzt7xsCs1UWGTHBC7Cj4440/6MryqVpN6aOO9Q4vnputlik
         VnyqyKq285q2A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tony@atomide.com, jmkrzyszt@gmail.com, aaro.koskinen@iki.fi,
        vireshk@kernel.org, shiraz.linux.kernel@gmail.com, nsekhar@ti.com,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/6] ARM: spear: remove include/mach/ subdirectory
Date:   Thu, 28 Apr 2022 15:31:55 +0200
Message-Id: <20220428133210.990808-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220428133210.990808-1-arnd@kernel.org>
References: <20220428133210.990808-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Two of the remaining four headers are never used, the other
two are only used inside of the platform code. Move them
next to the files that include them and remove the
Makefile trick that adds the include path.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear/Makefile                  |  2 -
 arch/arm/mach-spear/include/mach/irqs.h       | 35 ----------------
 arch/arm/mach-spear/include/mach/uncompress.h | 42 -------------------
 .../mach-spear/{include/mach => }/misc_regs.h |  4 +-
 arch/arm/mach-spear/pl080.c                   |  4 +-
 arch/arm/mach-spear/platsmp.c                 |  2 +-
 arch/arm/mach-spear/restart.c                 |  2 +-
 .../arm/mach-spear/{include/mach => }/spear.h |  0
 arch/arm/mach-spear/spear1310.c               |  2 +-
 arch/arm/mach-spear/spear13xx.c               |  2 +-
 arch/arm/mach-spear/spear300.c                |  2 +-
 arch/arm/mach-spear/spear310.c                |  2 +-
 arch/arm/mach-spear/spear320.c                |  2 +-
 arch/arm/mach-spear/spear3xx.c                |  4 +-
 arch/arm/mach-spear/spear6xx.c                |  4 +-
 15 files changed, 14 insertions(+), 95 deletions(-)
 delete mode 100644 arch/arm/mach-spear/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-spear/include/mach/uncompress.h
 rename arch/arm/mach-spear/{include/mach => }/misc_regs.h (87%)
 rename arch/arm/mach-spear/{include/mach => }/spear.h (100%)

diff --git a/arch/arm/mach-spear/Makefile b/arch/arm/mach-spear/Makefile
index 176b14f83089..c6101a843601 100644
--- a/arch/arm/mach-spear/Makefile
+++ b/arch/arm/mach-spear/Makefile
@@ -3,8 +3,6 @@
 # SPEAr Platform specific Makefile
 #
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
-
 # Common support
 obj-y	:= restart.o time.o
 
diff --git a/arch/arm/mach-spear/include/mach/irqs.h b/arch/arm/mach-spear/include/mach/irqs.h
deleted file mode 100644
index 7058720c5278..000000000000
--- a/arch/arm/mach-spear/include/mach/irqs.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * IRQ helper macros for spear machine family
- *
- * Copyright (C) 2009-2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
- * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_IRQS_H
-#define __MACH_IRQS_H
-
-#ifdef CONFIG_ARCH_SPEAR3XX
-#define NR_IRQS			256
-#endif
-
-#ifdef CONFIG_ARCH_SPEAR6XX
-/* IRQ definitions */
-/* VIC 1 */
-#define IRQ_VIC_END				64
-
-/* GPIO pins virtual irqs */
-#define VIRTUAL_IRQS				24
-#define NR_IRQS					(IRQ_VIC_END + VIRTUAL_IRQS)
-#endif
-
-#ifdef CONFIG_ARCH_SPEAR13XX
-#define IRQ_GIC_END			160
-#define NR_IRQS				IRQ_GIC_END
-#endif
-
-#endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear/include/mach/uncompress.h b/arch/arm/mach-spear/include/mach/uncompress.h
deleted file mode 100644
index 8439b9c12edb..000000000000
--- a/arch/arm/mach-spear/include/mach/uncompress.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * arch/arm/plat-spear/include/plat/uncompress.h
- *
- * Serial port stubs for kernel decompress status messages
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/io.h>
-#include <linux/amba/serial.h>
-#include <mach/spear.h>
-
-#ifndef __PLAT_UNCOMPRESS_H
-#define __PLAT_UNCOMPRESS_H
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	void __iomem *base = (void __iomem *)SPEAR_DBG_UART_BASE;
-
-	while (readl_relaxed(base + UART01x_FR) & UART01x_FR_TXFF)
-		barrier();
-
-	writel_relaxed(c, base + UART01x_DR);
-}
-
-static inline void flush(void)
-{
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-
-#endif /* __PLAT_UNCOMPRESS_H */
diff --git a/arch/arm/mach-spear/include/mach/misc_regs.h b/arch/arm/mach-spear/misc_regs.h
similarity index 87%
rename from arch/arm/mach-spear/include/mach/misc_regs.h
rename to arch/arm/mach-spear/misc_regs.h
index cfaf7c665b58..53cd74301f58 100644
--- a/arch/arm/mach-spear/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear/misc_regs.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-spear3xx/include/mach/misc_regs.h
- *
  * Miscellaneous registers definitions for SPEAr3xx machine family
  *
  * Copyright (C) 2009 ST Microelectronics
@@ -14,7 +12,7 @@
 #ifndef __MACH_MISC_REGS_H
 #define __MACH_MISC_REGS_H
 
-#include <mach/spear.h>
+#include "spear.h"
 
 #define MISC_BASE		(VA_SPEAR_ICM3_MISC_REG_BASE)
 #define DMA_CHN_CFG		(MISC_BASE + 0x0A0)
diff --git a/arch/arm/mach-spear/pl080.c b/arch/arm/mach-spear/pl080.c
index b4529f3e0ee9..38b479f413dc 100644
--- a/arch/arm/mach-spear/pl080.c
+++ b/arch/arm/mach-spear/pl080.c
@@ -17,8 +17,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/spinlock_types.h>
-#include <mach/spear.h>
-#include <mach/misc_regs.h>
+#include "spear.h"
+#include "misc_regs.h"
 
 static spinlock_t lock = __SPIN_LOCK_UNLOCKED(x);
 
diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
index e33a85c28c95..97fbda998df9 100644
--- a/arch/arm/mach-spear/platsmp.c
+++ b/arch/arm/mach-spear/platsmp.c
@@ -14,7 +14,7 @@
 #include <linux/smp.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_scu.h>
-#include <mach/spear.h>
+#include "spear.h"
 #include "generic.h"
 
 /* XXX spear_pen_release is cargo culted code - DO NOT COPY XXX */
diff --git a/arch/arm/mach-spear/restart.c b/arch/arm/mach-spear/restart.c
index b4342155a783..43417d0db6d9 100644
--- a/arch/arm/mach-spear/restart.c
+++ b/arch/arm/mach-spear/restart.c
@@ -14,7 +14,7 @@
 #include <linux/amba/sp810.h>
 #include <linux/reboot.h>
 #include <asm/system_misc.h>
-#include <mach/spear.h>
+#include "spear.h"
 #include "generic.h"
 
 #define SPEAR13XX_SYS_SW_RES			(VA_MISC_BASE + 0x204)
diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/spear.h
similarity index 100%
rename from arch/arm/mach-spear/include/mach/spear.h
rename to arch/arm/mach-spear/spear.h
diff --git a/arch/arm/mach-spear/spear1310.c b/arch/arm/mach-spear/spear1310.c
index a7d4f136836f..549ab2be1b74 100644
--- a/arch/arm/mach-spear/spear1310.c
+++ b/arch/arm/mach-spear/spear1310.c
@@ -18,7 +18,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include "generic.h"
-#include <mach/spear.h>
+#include "spear.h"
 
 /* Base addresses */
 #define SPEAR1310_RAS_GRP1_BASE			UL(0xD8000000)
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index b38391e9d8bf..9d4bdce2e865 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -21,7 +21,7 @@
 #include <linux/of.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
-#include <mach/spear.h>
+#include "spear.h"
 #include "generic.h"
 
 void __init spear13xx_l2x0_init(void)
diff --git a/arch/arm/mach-spear/spear300.c b/arch/arm/mach-spear/spear300.c
index 325b89579be1..1f2a6bbcf096 100644
--- a/arch/arm/mach-spear/spear300.c
+++ b/arch/arm/mach-spear/spear300.c
@@ -17,7 +17,7 @@
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include "generic.h"
-#include <mach/spear.h>
+#include "spear.h"
 
 /* DMAC platform data's slave info */
 struct pl08x_channel_data spear300_dma_info[] = {
diff --git a/arch/arm/mach-spear/spear310.c b/arch/arm/mach-spear/spear310.c
index 59e173dc85cf..f0fc140a59cf 100644
--- a/arch/arm/mach-spear/spear310.c
+++ b/arch/arm/mach-spear/spear310.c
@@ -18,7 +18,7 @@
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include "generic.h"
-#include <mach/spear.h>
+#include "spear.h"
 
 #define SPEAR310_UART1_BASE		UL(0xB2000000)
 #define SPEAR310_UART2_BASE		UL(0xB2080000)
diff --git a/arch/arm/mach-spear/spear320.c b/arch/arm/mach-spear/spear320.c
index 926d5a243238..cb464ae7c08a 100644
--- a/arch/arm/mach-spear/spear320.c
+++ b/arch/arm/mach-spear/spear320.c
@@ -20,7 +20,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include "generic.h"
-#include <mach/spear.h>
+#include "spear.h"
 
 #define SPEAR320_UART1_BASE		UL(0xA3000000)
 #define SPEAR320_UART2_BASE		UL(0xA4000000)
diff --git a/arch/arm/mach-spear/spear3xx.c b/arch/arm/mach-spear/spear3xx.c
index f83321d5e353..fab3d6df69ff 100644
--- a/arch/arm/mach-spear/spear3xx.c
+++ b/arch/arm/mach-spear/spear3xx.c
@@ -20,8 +20,8 @@
 #include <asm/mach/map.h>
 #include "pl080.h"
 #include "generic.h"
-#include <mach/spear.h>
-#include <mach/misc_regs.h>
+#include "spear.h"
+#include "misc_regs.h"
 
 /* ssp device registration */
 struct pl022_ssp_controller pl022_plat_data = {
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index c5fc110134ba..d061080b191f 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -25,8 +25,8 @@
 #include <asm/mach/map.h>
 #include "pl080.h"
 #include "generic.h"
-#include <mach/spear.h>
-#include <mach/misc_regs.h>
+#include "spear.h"
+#include "misc_regs.h"
 
 /* dmac device registration */
 static struct pl08x_channel_data spear600_dma_info[] = {
-- 
2.29.2

