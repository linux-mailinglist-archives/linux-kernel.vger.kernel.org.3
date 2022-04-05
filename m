Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315364F4314
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbiDEOLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiDEJbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774204B42E;
        Tue,  5 Apr 2022 02:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14E4E61659;
        Tue,  5 Apr 2022 09:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFBCC385A8;
        Tue,  5 Apr 2022 09:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150340;
        bh=B/tl0sLKN/jq3y3vKn6NywiuZfLqqyXYtHMpnT36iZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H76qWq8PTbzVION7e1O3AqI8T+Ojbrjf9nMoXOAEyWKVp6xYXony2BIW/PHRxEpBP
         yp0KFdfwkeOhu/vNY725yzPvPArmX3SLO0MWpMSv6v9CpUJ+S4xJJJB3nRP1AeDQOW
         /psAekrbP5q5agfjTg2pmUwS/X6SAAMIpxriXA/x26/wAMRCpvY+DMdffjUq/uzCkT
         k18qRWlI2Xg8FfDb02sppQ7fEY2ovzcTXP0HfyyyLn8FYX2W5EiOUJCBo7pRUOkbZG
         8aZKheTTPjHl2MOQM1iaEih8S31lShDtzv3WSK9xlZu5I/wQRAlrI4bOzPBdkjhY43
         faDclQ0WZVtaQ==
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
Subject: [PATCH 10/12] ARM: iop32x: enable multiplatform support
Date:   Tue,  5 Apr 2022 11:17:48 +0200
Message-Id: <20220405091750.3076973-11-arnd@kernel.org>
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

After iop32x was converted to the generic multi-irq entry
code, nothing really stops us from building it into a
generic kernel.

The two last headers can simply be removed, the mach/irqs.h
gets replaced with the sparse-irq intiialization from the
board specific .nr_irqs value, and the decompressor debug
output can use the debug_ll hack that all other platforms
use.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                              | 14 -----------
 arch/arm/mach-iop32x/Kconfig                  | 17 ++++++++-----
 arch/arm/mach-iop32x/em7210.c                 |  1 +
 arch/arm/mach-iop32x/glantank.c               |  1 +
 arch/arm/mach-iop32x/include/mach/irqs.h      | 14 -----------
 .../arm/mach-iop32x/include/mach/uncompress.h | 25 -------------------
 arch/arm/mach-iop32x/iq31244.c                |  1 +
 arch/arm/mach-iop32x/iq80321.c                |  1 +
 arch/arm/mach-iop32x/irqs.h                   |  2 ++
 arch/arm/mach-iop32x/n2100.c                  |  1 +
 10 files changed, 18 insertions(+), 59 deletions(-)
 delete mode 100644 arch/arm/mach-iop32x/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 68b0a857f9e5..94909cadb78a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -356,17 +356,6 @@ config ARCH_FOOTBRIDGE
 	  Support for systems based on the DC21285 companion chip
 	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
 
-config ARCH_IOP32X
-	bool "IOP32x-based"
-	select CPU_XSCALE
-	select GPIO_IOP
-	select GPIOLIB
-	select FORCE_PCI
-	select PLAT_IOP
-	help
-	  Support for Intel's 80219 and IOP32X (XScale) family of
-	  processors.
-
 config ARCH_IXP4XX
 	bool "IXP4xx-based"
 	select ARCH_SUPPORTS_BIG_ENDIAN
@@ -688,9 +677,6 @@ config ARCH_MPS2
 config ARCH_ACORN
 	bool
 
-config PLAT_IOP
-	bool
-
 config PLAT_ORION
 	bool
 	select CLKSRC_MMIO
diff --git a/arch/arm/mach-iop32x/Kconfig b/arch/arm/mach-iop32x/Kconfig
index f1f342cb0509..07dd137b8867 100644
--- a/arch/arm/mach-iop32x/Kconfig
+++ b/arch/arm/mach-iop32x/Kconfig
@@ -1,9 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
-if ARCH_IOP32X
-
-menu "IOP32x Implementation Options"
+menuconfig ARCH_IOP32X
+	bool "IOP32x-based platforms"
+	depends on ARCH_MULTI_V5
+	select CPU_XSCALE
+	select GPIO_IOP
+	select GPIOLIB
+	select FORCE_PCI
+	help
+	  Support for Intel's 80219 and IOP32X (XScale) family of
+	  processors.
 
-comment "IOP32x Platform Types"
+if ARCH_IOP32X
 
 config MACH_EP80219
 	bool
@@ -42,6 +49,4 @@ config MACH_EM7210
 	  board. Say also Y here if you have a SS4000e Baxter Creek NAS
 	  appliance."
 
-endmenu
-
 endif
diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
index d43ced3cd4e7..ac130aba5a6e 100644
--- a/arch/arm/mach-iop32x/em7210.c
+++ b/arch/arm/mach-iop32x/em7210.c
@@ -223,6 +223,7 @@ static void __init em7210_init_machine(void)
 
 MACHINE_START(EM7210, "Lanner EM7210")
 	.atag_offset	= 0x100,
+	.nr_irqs	= IOP32X_NR_IRQS,
 	.map_io		= em7210_map_io,
 	.init_irq	= iop32x_init_irq,
 	.init_time	= em7210_timer_init,
diff --git a/arch/arm/mach-iop32x/glantank.c b/arch/arm/mach-iop32x/glantank.c
index 2fe0f77d1f1d..cd6e7da2ea10 100644
--- a/arch/arm/mach-iop32x/glantank.c
+++ b/arch/arm/mach-iop32x/glantank.c
@@ -205,6 +205,7 @@ static void __init glantank_init_machine(void)
 MACHINE_START(GLANTANK, "GLAN Tank")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= IOP32X_NR_IRQS,
 	.map_io		= glantank_map_io,
 	.init_irq	= iop32x_init_irq,
 	.init_time	= glantank_timer_init,
diff --git a/arch/arm/mach-iop32x/include/mach/irqs.h b/arch/arm/mach-iop32x/include/mach/irqs.h
deleted file mode 100644
index e09ae5f48aec..000000000000
--- a/arch/arm/mach-iop32x/include/mach/irqs.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * arch/arm/mach-iop32x/include/mach/irqs.h
- *
- * Author:	Rory Bolt <rorybolt@pacbell.net>
- * Copyright:	(C) 2002 Rory Bolt
- */
-
-#ifndef __IRQS_H
-#define __IRQS_H
-
-#define NR_IRQS			33
-
-#endif
diff --git a/arch/arm/mach-iop32x/include/mach/uncompress.h b/arch/arm/mach-iop32x/include/mach/uncompress.h
deleted file mode 100644
index c8548875d942..000000000000
--- a/arch/arm/mach-iop32x/include/mach/uncompress.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * arch/arm/mach-iop32x/include/mach/uncompress.h
- */
-
-#include <asm/types.h>
-#include <asm/mach-types.h>
-#include <linux/serial_reg.h>
-
-#define uart_base ((volatile u8 *)0xfe800000)
-
-#define TX_DONE		(UART_LSR_TEMT | UART_LSR_THRE)
-
-static inline void putc(char c)
-{
-	while ((uart_base[UART_LSR] & TX_DONE) != TX_DONE)
-		barrier();
-	uart_base[UART_TX] = c;
-}
-
-static inline void flush(void)
-{
-}
-
-#define arch_decomp_setup() do { } while (0)
diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
index 49caaa703881..8b4c29d17265 100644
--- a/arch/arm/mach-iop32x/iq31244.c
+++ b/arch/arm/mach-iop32x/iq31244.c
@@ -324,6 +324,7 @@ MACHINE_END
 MACHINE_START(EP80219, "Intel EP80219")
 	/* Maintainer: Intel Corp. */
 	.atag_offset	= 0x100,
+	.nr_irqs	= IOP32X_NR_IRQS,
 	.map_io		= iq31244_map_io,
 	.init_irq	= iop32x_init_irq,
 	.init_time	= iq31244_timer_init,
diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
index b455d7073296..d9780c4660cb 100644
--- a/arch/arm/mach-iop32x/iq80321.c
+++ b/arch/arm/mach-iop32x/iq80321.c
@@ -183,6 +183,7 @@ static void __init iq80321_init_machine(void)
 MACHINE_START(IQ80321, "Intel IQ80321")
 	/* Maintainer: Intel Corp. */
 	.atag_offset	= 0x100,
+	.nr_irqs	= IOP32X_NR_IRQS,
 	.map_io		= iq80321_map_io,
 	.init_irq	= iop32x_init_irq,
 	.init_time	= iq80321_timer_init,
diff --git a/arch/arm/mach-iop32x/irqs.h b/arch/arm/mach-iop32x/irqs.h
index e1dfc8b4e7d7..e9fc88e09189 100644
--- a/arch/arm/mach-iop32x/irqs.h
+++ b/arch/arm/mach-iop32x/irqs.h
@@ -43,4 +43,6 @@
 #define IRQ_IOP32X_XINT3	IOP_IRQ(30)
 #define IRQ_IOP32X_HPI		IOP_IRQ(31)
 
+#define IOP32X_NR_IRQS		(IRQ_IOP32X_HPI + 1)
+
 #endif
diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index bf99e718f8b8..bb1e2e11bf35 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -358,6 +358,7 @@ static void __init n2100_init_machine(void)
 MACHINE_START(N2100, "Thecus N2100")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= IOP32X_NR_IRQS,
 	.map_io		= n2100_map_io,
 	.init_irq	= iop32x_init_irq,
 	.init_time	= n2100_timer_init,
-- 
2.29.2

