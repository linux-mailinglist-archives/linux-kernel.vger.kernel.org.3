Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC454F3EAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbiDEOMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbiDEJbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CFF26FA;
        Tue,  5 Apr 2022 02:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65FAEB81B62;
        Tue,  5 Apr 2022 09:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200F6C385AC;
        Tue,  5 Apr 2022 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150313;
        bh=J6wtCACpXBxLmkz/EnCKwxs03UNfKLPJWoTIRgLakyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbF8ZztCBrqYcjuwKSVQCiU3VGjPjEz3Tye5ptnnpKrxGhc8riDbmT+V8Oq5SZGyy
         dEzr2RGLAXRp5rN636zq2zXhCJIUbvm3fYB2A68PY9RufYkgdmj7D+7BymNlCCdZs/
         eRzM5C760LUirkjJvrgnDwVWGShrPVJiFvQyYVJVIMmZ6OwMk6KcDI/LpW5G4kU8dt
         d/kbIFqmxXff97E9GGvcxxcBTFZW5GhgosYEaOtAkKeE/lO4gTG5hb6WUjfEPTsSTc
         Q2N8r2QLLzL8A9Xmr0B7IPyd5oddNm1Oasj71bxHcpZDtlJ/XhJBYFQpbLBaa/3ST9
         xzLnDaOFom/Ew==
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
Subject: [PATCH 05/12] ARM: ep93xx: multiplatform support
Date:   Tue,  5 Apr 2022 11:17:43 +0200
Message-Id: <20220405091750.3076973-6-arnd@kernel.org>
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

With the clock support and the interrupts out of the way, ep93xx can be
compiled into the same kernel image as the other ARMv4/v5 platforms. The
last obstacle are the two workarounds for broken boot loaders that
require us to re-initialize the ethernet controller and/or the watchdog
on certain machines.

Move this code into the decompressor sources directly, checking for
each possibly affected machine individually.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                              | 16 -----
 .../compressed/misc-ep93xx.h}                 | 69 +++++++++----------
 arch/arm/boot/compressed/misc.c               |  4 ++
 arch/arm/configs/ep93xx_defconfig             |  2 +
 arch/arm/mach-ep93xx/Kconfig                  | 12 ++++
 5 files changed, 51 insertions(+), 52 deletions(-)
 rename arch/arm/{mach-ep93xx/include/mach/uncompress.h => boot/compressed/misc-ep93xx.h} (51%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5177e54cc14c..2bd611beefe1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -347,22 +347,6 @@ config ARCH_MULTIPLATFORM
 	select SPARSE_IRQ
 	select USE_OF
 
-config ARCH_EP93XX
-	bool "EP93xx-based"
-	select ARCH_SPARSEMEM_ENABLE
-	select ARM_AMBA
-	imply ARM_PATCH_PHYS_VIRT
-	select ARM_VIC
-	select AUTO_ZRELADDR
-	select CLKSRC_MMIO
-	select CPU_ARM920T
-	select GPIOLIB
-	select COMMON_CLK
-	select IRQ_DOMAIN
-	select SPARSE_IRQ
-	help
-	  This enables support for the Cirrus EP93xx series of CPUs.
-
 config ARCH_FOOTBRIDGE
 	bool "FootBridge"
 	select CPU_SA110
diff --git a/arch/arm/mach-ep93xx/include/mach/uncompress.h b/arch/arm/boot/compressed/misc-ep93xx.h
similarity index 51%
rename from arch/arm/mach-ep93xx/include/mach/uncompress.h
rename to arch/arm/boot/compressed/misc-ep93xx.h
index e20bcab702b2..3dc942589cba 100644
--- a/arch/arm/mach-ep93xx/include/mach/uncompress.h
+++ b/arch/arm/boot/compressed/misc-ep93xx.h
@@ -1,54 +1,25 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * arch/arm/mach-ep93xx/include/mach/uncompress.h
- *
  * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
  */
 
 #include <asm/mach-types.h>
 
-static unsigned char __raw_readb(unsigned int ptr)
-{
-	return *((volatile unsigned char *)ptr);
-}
-
-static unsigned int __raw_readl(unsigned int ptr)
+static inline unsigned int __raw_readl(unsigned int ptr)
 {
 	return *((volatile unsigned int *)ptr);
 }
 
-static void __raw_writeb(unsigned char value, unsigned int ptr)
+static inline void __raw_writeb(unsigned char value, unsigned int ptr)
 {
 	*((volatile unsigned char *)ptr) = value;
 }
 
-static void __raw_writel(unsigned int value, unsigned int ptr)
+static inline void __raw_writel(unsigned int value, unsigned int ptr)
 {
 	*((volatile unsigned int *)ptr) = value;
 }
 
-#define PHYS_UART_DATA		(CONFIG_DEBUG_UART_PHYS + 0x00)
-#define PHYS_UART_FLAG		(CONFIG_DEBUG_UART_PHYS + 0x18)
-#define UART_FLAG_TXFF		0x20
-
-static inline void putc(int c)
-{
-	int i;
-
-	for (i = 0; i < 10000; i++) {
-		/* Transmit fifo not full? */
-		if (!(__raw_readb(PHYS_UART_FLAG) & UART_FLAG_TXFF))
-			break;
-	}
-
-	__raw_writeb(c, PHYS_UART_DATA);
-}
-
-static inline void flush(void)
-{
-}
-
-
 /*
  * Some bootloaders don't turn off DMA from the ethernet MAC before
  * jumping to linux, which means that we might end up with bits of RX
@@ -58,7 +29,7 @@ static inline void flush(void)
 #define PHYS_ETH_SELF_CTL		0x80010020
 #define ETH_SELF_CTL_RESET		0x00000001
 
-static void ethernet_reset(void)
+static inline void ep93xx_ethernet_reset(void)
 {
 	unsigned int v;
 
@@ -75,15 +46,41 @@ static void ethernet_reset(void)
 #define TS72XX_WDT_FEED_PHYS_BASE	0x23c00000
 #define TS72XX_WDT_FEED_VAL		0x05
 
-static void __maybe_unused ts72xx_watchdog_disable(void)
+static inline void __maybe_unused ts72xx_watchdog_disable(void)
 {
 	__raw_writeb(TS72XX_WDT_FEED_VAL, TS72XX_WDT_FEED_PHYS_BASE);
 	__raw_writeb(0, TS72XX_WDT_CONTROL_PHYS_BASE);
 }
 
-static void arch_decomp_setup(void)
+static inline void ep93xx_decomp_setup(void)
 {
 	if (machine_is_ts72xx())
 		ts72xx_watchdog_disable();
-	ethernet_reset();
+
+	if (machine_is_adssphere() ||
+	    machine_is_edb9301() ||
+	    machine_is_edb9302() ||
+	    machine_is_edb9302a() ||
+	    machine_is_edb9302a() ||
+	    machine_is_edb9307() ||
+	    machine_is_edb9307a() ||
+	    machine_is_edb9307a() ||
+	    machine_is_edb9312() ||
+	    machine_is_edb9315() ||
+	    machine_is_edb9315a() ||
+	    machine_is_edb9315a() ||
+	    machine_is_gesbc9312() ||
+	    machine_is_micro9() ||
+	    machine_is_micro9l() ||
+	    machine_is_micro9m() ||
+	    machine_is_micro9s() ||
+	    machine_is_micro9m() ||
+	    machine_is_micro9l() ||
+	    machine_is_micro9s() ||
+	    machine_is_sim_one() ||
+	    machine_is_snapper_cl15() ||
+	    machine_is_ts72xx() ||
+	    machine_is_bk3() ||
+	    machine_is_vision_ep9307())
+		ep93xx_ethernet_reset();
 }
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index c3c66ff2d696..cb2e069dc73f 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -23,6 +23,7 @@ unsigned int __machine_arch_type;
 #include <linux/types.h>
 #include <linux/linkage.h>
 #include "misc.h"
+#include "misc-ep93xx.h"
 
 static void putstr(const char *ptr);
 
@@ -143,6 +144,9 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 	free_mem_end_ptr	= free_mem_ptr_end_p;
 	__machine_arch_type	= arch_id;
 
+#ifdef CONFIG_ARCH_EP93XX
+	ep93xx_decomp_setup();
+#endif
 	arch_decomp_setup();
 
 	putstr("Uncompressing Linux...");
diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 88d5ecc2121e..fef802b7af8c 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -11,6 +11,8 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
+CONFIG_ARCH_MULTI_V4T=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_EP93XX=y
 CONFIG_MACH_ADSSPHERE=y
 CONFIG_MACH_EDB9301=y
diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 15c68a646d51..aa502ab57404 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -1,4 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0-only
+menuconfig ARCH_EP93XX
+	bool "EP93xx-based"
+	depends on ARCH_MULTI_V4T
+	select ARCH_SPARSEMEM_ENABLE
+	select ARM_AMBA
+	select ARM_VIC
+	select CLKSRC_MMIO
+	select CPU_ARM920T
+	select GPIOLIB
+	help
+	  This enables support for the Cirrus EP93xx series of CPUs.
+
 if ARCH_EP93XX
 
 menu "Cirrus EP93xx Implementation Options"
-- 
2.29.2

