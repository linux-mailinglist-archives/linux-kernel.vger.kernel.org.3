Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B084F42F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347857AbiDEOGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiDEJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC2345AF7;
        Tue,  5 Apr 2022 02:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 747E1B81B14;
        Tue,  5 Apr 2022 09:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD43C385A0;
        Tue,  5 Apr 2022 09:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150302;
        bh=HRzw+3b+SBJ4FlvxvEcFyPcfDzTsM2cqwGkzYB2C7u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5ukYVcqWJMVjBzRd3C4y8FcxZ8QocdCvM8dUNL2JEOUYnPI1oH23ENaV1NsWa7Pq
         FxKNz61SFZ4rcuSE7qQB/EUWKeJ7g1YUVTxksyMR9B7vfE4T9/J7bU1t2k+SvdzVBJ
         bFj5SjROpA5jSI4SBSI3MLJaQBZgDjc9dX6JqlsVr+97PMkGd2s+traU/xMiSnwBKb
         OA392wKgwdNXDFg4uWS0pshLXedugaoZY1hTUBcgFdAkXVUeyvRky5o/PnLb+z7RiN
         fjbukszvmcNOgceM3/9yH/NpDRGMqY9sqlMktyucilurqGqVcOjwhNjXHbR/kvjR9J
         JTvqbDuOBvrZw==
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
Subject: [PATCH 03/12] ARM: ep93xx: enable SPARSE_IRQ
Date:   Tue,  5 Apr 2022 11:17:41 +0200
Message-Id: <20220405091750.3076973-4-arnd@kernel.org>
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

Without CONFIG_SPARSE_IRQ, we rely on mach/irqs.h to define NR_IRQS
globally. Do the minimal conversion by setting .nr_irqs in each
machine descriptor.

Only the vision_ep9307 machine has extra IRQs for GPIOs, so make
.nr_irqs the original value there, while using the plain NR_EP93XX_IRQS
everywhere else.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Hubert Feurstein <hubert.feurstein@contec.at>
Cc: Lukasz Majewski <lukma@denx.de>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                               | 2 ++
 arch/arm/mach-ep93xx/adssphere.c               | 1 +
 arch/arm/mach-ep93xx/core.c                    | 1 +
 arch/arm/mach-ep93xx/edb93xx.c                 | 8 ++++++++
 arch/arm/mach-ep93xx/gesbc9312.c               | 1 +
 arch/arm/mach-ep93xx/{include/mach => }/irqs.h | 7 -------
 arch/arm/mach-ep93xx/micro9.c                  | 4 ++++
 arch/arm/mach-ep93xx/simone.c                  | 1 +
 arch/arm/mach-ep93xx/snappercl15.c             | 1 +
 arch/arm/mach-ep93xx/soc.h                     | 1 +
 arch/arm/mach-ep93xx/ts72xx.c                  | 3 ++-
 arch/arm/mach-ep93xx/vision_ep9307.c           | 1 +
 12 files changed, 23 insertions(+), 8 deletions(-)
 rename arch/arm/mach-ep93xx/{include/mach => }/irqs.h (96%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 31f024e6e925..5177e54cc14c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -358,6 +358,8 @@ config ARCH_EP93XX
 	select CPU_ARM920T
 	select GPIOLIB
 	select COMMON_CLK
+	select IRQ_DOMAIN
+	select SPARSE_IRQ
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index 8d5e349a7a6d..0c48d3c5b8e7 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -32,6 +32,7 @@ static void __init adssphere_init_machine(void)
 MACHINE_START(ADSSPHERE, "ADS Sphere board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index e4569a5acc3f..2d58e273c96d 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -47,6 +47,7 @@
 #include <asm/mach/map.h>
 
 #include "soc.h"
+#include "irqs.h"
 
 /*************************************************************************
  * Static I/O mappings that are needed for all EP93xx platforms
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index af0e22471ebd..4b90899a66e9 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -243,6 +243,7 @@ static void __init edb93xx_init_machine(void)
 MACHINE_START(EDB9301, "Cirrus Logic EDB9301 Evaluation Board")
 	/* Maintainer: H Hartley Sweeten <hsweeten@visionengravers.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -255,6 +256,7 @@ MACHINE_END
 MACHINE_START(EDB9302, "Cirrus Logic EDB9302 Evaluation Board")
 	/* Maintainer: George Kashperko <george@chas.com.ua> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -267,6 +269,7 @@ MACHINE_END
 MACHINE_START(EDB9302A, "Cirrus Logic EDB9302A Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -279,6 +282,7 @@ MACHINE_END
 MACHINE_START(EDB9307, "Cirrus Logic EDB9307 Evaluation Board")
 	/* Maintainer: Herbert Valerio Riedel <hvr@gnu.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -291,6 +295,7 @@ MACHINE_END
 MACHINE_START(EDB9307A, "Cirrus Logic EDB9307A Evaluation Board")
 	/* Maintainer: H Hartley Sweeten <hsweeten@visionengravers.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -303,6 +308,7 @@ MACHINE_END
 MACHINE_START(EDB9312, "Cirrus Logic EDB9312 Evaluation Board")
 	/* Maintainer: Toufeeq Hussain <toufeeq_hussain@infosys.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -315,6 +321,7 @@ MACHINE_END
 MACHINE_START(EDB9315, "Cirrus Logic EDB9315 Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -327,6 +334,7 @@ MACHINE_END
 MACHINE_START(EDB9315A, "Cirrus Logic EDB9315A Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index d7f9890321eb..0b7043e3e178 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -32,6 +32,7 @@ static void __init gesbc9312_init_machine(void)
 MACHINE_START(GESBC9312, "Glomation GESBC-9312-sx")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/include/mach/irqs.h b/arch/arm/mach-ep93xx/irqs.h
similarity index 96%
rename from arch/arm/mach-ep93xx/include/mach/irqs.h
rename to arch/arm/mach-ep93xx/irqs.h
index 60c69c4ed7e1..353201b90c66 100644
--- a/arch/arm/mach-ep93xx/include/mach/irqs.h
+++ b/arch/arm/mach-ep93xx/irqs.h
@@ -1,8 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * arch/arm/mach-ep93xx/include/mach/irqs.h
- */
-
 #ifndef __ASM_ARCH_IRQS_H
 #define __ASM_ARCH_IRQS_H
 
@@ -77,7 +73,4 @@
 #define EP93XX_BOARD_IRQ(x)		(NR_EP93XX_IRQS + (x))
 #define EP93XX_BOARD_IRQS		32
 
-#define NR_IRQS				(NR_EP93XX_IRQS + EP93XX_BOARD_IRQS)
-
-
 #endif
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index e6ead8ded6ee..c121c459aa17 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -76,6 +76,7 @@ static void __init micro9_init_machine(void)
 MACHINE_START(MICRO9, "Contec Micro9-High")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -88,6 +89,7 @@ MACHINE_END
 MACHINE_START(MICRO9M, "Contec Micro9-Mid")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -100,6 +102,7 @@ MACHINE_END
 MACHINE_START(MICRO9L, "Contec Micro9-Lite")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -112,6 +115,7 @@ MACHINE_END
 MACHINE_START(MICRO9S, "Contec Micro9-Slim")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 5291053023b2..569e72413561 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -119,6 +119,7 @@ static void __init simone_init_machine(void)
 MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
 	/* Maintainer: Ryan Mallon */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index e200d69471e9..1dfb725671b1 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -153,6 +153,7 @@ static void __init snappercl15_init_machine(void)
 MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
 	/* Maintainer: Ryan Mallon */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
index 94ef7f275f94..f0986e288d19 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -10,6 +10,7 @@
 #define _EP93XX_SOC_H
 
 #include <mach/ep93xx-regs.h>
+#include "irqs.h"
 
 /*
  * EP93xx Physical Memory Map:
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 12eff8c8074d..e70bac011407 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -22,7 +22,6 @@
 
 #include "gpio-ep93xx.h"
 #include "hardware.h"
-#include <mach/irqs.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -350,6 +349,7 @@ static void __init ts72xx_init_machine(void)
 MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ts72xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -413,6 +413,7 @@ static void __init bk3_init_machine(void)
 MACHINE_START(BK3, "Liebherr controller BK3.1")
 	/* Maintainer: Lukasz Majewski <lukma@denx.de> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ts72xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index e46281e60bf7..30d9cf3791eb 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -302,6 +302,7 @@ static void __init vision_init_machine(void)
 MACHINE_START(VISION_EP9307, "Vision Engraving Systems EP9307")
 	/* Maintainer: H Hartley Sweeten <hsweeten@visionengravers.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS + EP93XX_BOARD_IRQS,
 	.map_io		= vision_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
-- 
2.29.2

