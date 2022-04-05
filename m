Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46A4F407E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358470AbiDEOHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbiDEJbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48FB24BD3;
        Tue,  5 Apr 2022 02:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3129361654;
        Tue,  5 Apr 2022 09:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5B3C385A0;
        Tue,  5 Apr 2022 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150329;
        bh=z96vxEiwP1b5sZF7dgUcgoEbuYgbb8uvtvAVuuKNgPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sy1mCzdMdvm9zHtJ2BcGP4AS2ItnMeWkD82ANJeGFxq8QqF2CvpnF3jUc2+UowXZy
         ZVr1IT+YXHminOM73W11fVdhzPj3655Mgz83Tv+j/a/UCcTDSzcM/JwgSj6BkBwmkA
         Z5LlxRi7KKDOYmb00eTDx7kDyKZLAhNKpMwl96bmG7Fn87BNDEGggjN9ipWCBswOta
         zFbH7vU5ZYxfJ95u3w3CJMn2xAzpDpd8avcouHvDe+UGYbFyqd3ajJm/8vQX1icOLk
         kker9LNWgRF3NLbv5d3auPRvP9dUG3CaLG49ZQhWswkfNy9QqrKWQzztTSzU/WLCxc
         TZs3dZzkVuA+g==
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
Subject: [PATCH 08/12] ARM: s3c24xx: convert to sparse-irq
Date:   Tue,  5 Apr 2022 11:17:46 +0200
Message-Id: <20220405091750.3076973-9-arnd@kernel.org>
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

As a final bit of preparation for converting to ARCH_MULTIPLATFORM,
change the interrupt handling for s3c24xx to use sparse IRQs.

Since the number of possible interrupts is already fixed and relatively
small per chip, just make it use all legacy interrupts preallocated
using the .nr_irqs field in the machine descriptor, rather than actually
allocating domains on the fly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                               |  2 ++
 arch/arm/mach-s3c/bast-ide.c                   |  2 +-
 arch/arm/mach-s3c/bast-irq.c                   |  2 +-
 arch/arm/mach-s3c/dev-audio-s3c64xx.c          |  2 +-
 arch/arm/mach-s3c/dev-uart-s3c64xx.c           |  2 +-
 arch/arm/mach-s3c/devs.c                       |  2 +-
 arch/arm/mach-s3c/gpio-samsung.c               |  2 +-
 arch/arm/mach-s3c/irq-s3c24xx.c                |  2 +-
 .../mach-s3c/{include/mach => }/irqs-s3c24xx.h | 18 ++++++++++++------
 .../mach-s3c/{include/mach => }/irqs-s3c64xx.h |  0
 arch/arm/mach-s3c/{include/mach => }/irqs.h    |  0
 arch/arm/mach-s3c/mach-amlm5900.c              |  2 ++
 arch/arm/mach-s3c/mach-anubis.c                |  1 +
 arch/arm/mach-s3c/mach-anw6410.c               |  2 +-
 arch/arm/mach-s3c/mach-at2440evb.c             |  1 +
 arch/arm/mach-s3c/mach-bast.c                  |  1 +
 arch/arm/mach-s3c/mach-crag6410-module.c       |  2 +-
 arch/arm/mach-s3c/mach-crag6410.c              |  2 +-
 arch/arm/mach-s3c/mach-gta02.c                 |  1 +
 arch/arm/mach-s3c/mach-h1940.c                 |  1 +
 arch/arm/mach-s3c/mach-hmt.c                   |  2 +-
 arch/arm/mach-s3c/mach-jive.c                  |  2 +-
 arch/arm/mach-s3c/mach-mini2440.c              |  3 ++-
 arch/arm/mach-s3c/mach-mini6410.c              |  2 +-
 arch/arm/mach-s3c/mach-n30.c                   |  2 ++
 arch/arm/mach-s3c/mach-ncp.c                   |  2 +-
 arch/arm/mach-s3c/mach-nexcoder.c              |  1 +
 arch/arm/mach-s3c/mach-osiris.c                |  1 +
 arch/arm/mach-s3c/mach-otom.c                  |  1 +
 arch/arm/mach-s3c/mach-qt2410.c                |  1 +
 arch/arm/mach-s3c/mach-real6410.c              |  2 +-
 arch/arm/mach-s3c/mach-rx1950.c                |  1 +
 arch/arm/mach-s3c/mach-rx3715.c                |  1 +
 arch/arm/mach-s3c/mach-smartq5.c               |  2 +-
 arch/arm/mach-s3c/mach-smartq7.c               |  2 +-
 arch/arm/mach-s3c/mach-smdk2410.c              |  1 +
 arch/arm/mach-s3c/mach-smdk2413.c              |  3 +++
 arch/arm/mach-s3c/mach-smdk2416.c              |  1 +
 arch/arm/mach-s3c/mach-smdk2440.c              |  1 +
 arch/arm/mach-s3c/mach-smdk2443.c              |  2 +-
 arch/arm/mach-s3c/mach-smdk6400.c              |  2 +-
 arch/arm/mach-s3c/mach-smdk6410.c              |  2 +-
 arch/arm/mach-s3c/mach-tct_hammer.c            |  1 +
 arch/arm/mach-s3c/mach-vr1000.c                |  1 +
 arch/arm/mach-s3c/mach-vstms.c                 |  1 +
 arch/arm/mach-s3c/pl080.c                      |  2 +-
 arch/arm/mach-s3c/pm-core-s3c24xx.h            |  2 +-
 arch/arm/mach-s3c/pm-s3c2412.c                 |  2 +-
 arch/arm/mach-s3c/pm-s3c64xx.c                 |  2 +-
 arch/arm/mach-s3c/pm.c                         |  2 +-
 arch/arm/mach-s3c/s3c2443.c                    |  2 +-
 arch/arm/mach-s3c/s3c24xx.h                    |  2 +-
 arch/arm/mach-s3c/s3c64xx.c                    |  2 +-
 arch/arm/mach-s3c/simtec-usb.c                 |  2 +-
 54 files changed, 69 insertions(+), 36 deletions(-)
 rename arch/arm/mach-s3c/{include/mach => }/irqs-s3c24xx.h (95%)
 rename arch/arm/mach-s3c/{include/mach => }/irqs-s3c64xx.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/irqs.h (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2242d2ae8854..c06e008c90ab 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -444,8 +444,10 @@ config ARCH_S3C24XX
 	select CLKSRC_SAMSUNG_PWM
 	select GPIO_SAMSUNG
 	select GPIOLIB
+	select IRQ_DOMAIN
 	select S3C2410_WATCHDOG
 	select SAMSUNG_ATAGS
+	select SPARSE_IRQ
 	select USE_OF
 	select WATCHDOG
 	help
diff --git a/arch/arm/mach-s3c/bast-ide.c b/arch/arm/mach-s3c/bast-ide.c
index da64db1811d8..67f0adc1fec0 100644
--- a/arch/arm/mach-s3c/bast-ide.c
+++ b/arch/arm/mach-s3c/bast-ide.c
@@ -20,7 +20,7 @@
 #include <asm/mach/irq.h>
 
 #include "map.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include "bast.h"
 
diff --git a/arch/arm/mach-s3c/bast-irq.c b/arch/arm/mach-s3c/bast-irq.c
index d299f124e6dc..cfc2ddc65513 100644
--- a/arch/arm/mach-s3c/bast-irq.c
+++ b/arch/arm/mach-s3c/bast-irq.c
@@ -16,7 +16,7 @@
 #include <asm/mach/irq.h>
 
 #include "regs-irq.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include "bast.h"
 
diff --git a/arch/arm/mach-s3c/dev-audio-s3c64xx.c b/arch/arm/mach-s3c/dev-audio-s3c64xx.c
index fc2f077afd24..909e82c148ba 100644
--- a/arch/arm/mach-s3c/dev-audio-s3c64xx.c
+++ b/arch/arm/mach-s3c/dev-audio-s3c64xx.c
@@ -10,7 +10,7 @@
 #include <linux/gpio.h>
 #include <linux/export.h>
 
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "map.h"
 
 #include "devs.h"
diff --git a/arch/arm/mach-s3c/dev-uart-s3c64xx.c b/arch/arm/mach-s3c/dev-uart-s3c64xx.c
index 8288e8d6c092..f9c947b8971b 100644
--- a/arch/arm/mach-s3c/dev-uart-s3c64xx.c
+++ b/arch/arm/mach-s3c/dev-uart-s3c64xx.c
@@ -16,7 +16,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include "map.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include "devs.h"
 
diff --git a/arch/arm/mach-s3c/devs.c b/arch/arm/mach-s3c/devs.c
index 1e266fc24f9b..9ac07c023adf 100644
--- a/arch/arm/mach-s3c/devs.c
+++ b/arch/arm/mach-s3c/devs.c
@@ -38,7 +38,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "map.h"
 #include "gpio-samsung.h"
 #include "gpio-cfg.h"
diff --git a/arch/arm/mach-s3c/gpio-samsung.c b/arch/arm/mach-s3c/gpio-samsung.c
index fda2c01f5a08..b7fc7c41309c 100644
--- a/arch/arm/mach-s3c/gpio-samsung.c
+++ b/arch/arm/mach-s3c/gpio-samsung.c
@@ -26,7 +26,7 @@
 
 #include <asm/irq.h>
 
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "map.h"
 #include "regs-gpio.h"
 #include "gpio-samsung.h"
diff --git a/arch/arm/mach-s3c/irq-s3c24xx.c b/arch/arm/mach-s3c/irq-s3c24xx.c
index 3776d5206f9b..088cc04b7431 100644
--- a/arch/arm/mach-s3c/irq-s3c24xx.c
+++ b/arch/arm/mach-s3c/irq-s3c24xx.c
@@ -26,7 +26,7 @@
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "regs-irq.h"
 #include "regs-gpio.h"
 
diff --git a/arch/arm/mach-s3c/include/mach/irqs-s3c24xx.h b/arch/arm/mach-s3c/irqs-s3c24xx.h
similarity index 95%
rename from arch/arm/mach-s3c/include/mach/irqs-s3c24xx.h
rename to arch/arm/mach-s3c/irqs-s3c24xx.h
index aaf3bae08b52..fecbf7e440c6 100644
--- a/arch/arm/mach-s3c/include/mach/irqs-s3c24xx.h
+++ b/arch/arm/mach-s3c/irqs-s3c24xx.h
@@ -108,6 +108,8 @@
 #define IRQ_TC			S3C2410_IRQSUB(9)
 #define IRQ_ADC			S3C2410_IRQSUB(10)
 
+#define NR_IRQS_S3C2410		(S3C2410_IRQSUB(10) + 1)
+
 /* extra irqs for s3c2412 */
 
 #define IRQ_S3C2412_CFSDI	S3C2410_IRQ(21)
@@ -115,6 +117,7 @@
 #define IRQ_S3C2412_SDI		S3C2410_IRQSUB(13)
 #define IRQ_S3C2412_CF		S3C2410_IRQSUB(14)
 
+#define NR_IRQS_S3C2412		(S3C2410_IRQSUB(14) + 1)
 
 #define IRQ_S3C2416_EINT8t15	S3C2410_IRQ(5)
 #define IRQ_S3C2416_DMA		S3C2410_IRQ(17)
@@ -146,13 +149,20 @@
 #define IRQ_S3C2416_I2S0	S3C2416_IRQ(6)
 #define IRQ_S3C2416_I2S1	S3C2416_IRQ(7)
 
-/* extra irqs for s3c2440 */
+#define NR_IRQS_S3C2416		(S3C2416_IRQ(7) + 1)
+
+/* extra irqs for s3c2440/s3c2442 */
 
 #define IRQ_S3C2440_CAM_C	S3C2410_IRQSUB(11)	/* S3C2443 too */
 #define IRQ_S3C2440_CAM_P	S3C2410_IRQSUB(12)	/* S3C2443 too */
+
+#define NR_IRQS_S3C2442		(S3C2410_IRQSUB(12) + 1)
+
 #define IRQ_S3C2440_WDT		S3C2410_IRQSUB(13)
 #define IRQ_S3C2440_AC97	S3C2410_IRQSUB(14)
 
+#define NR_IRQS_S3C2440		(S3C2410_IRQSUB(14) + 1)
+
 /* irqs for s3c2443 */
 
 #define IRQ_S3C2443_DMA		S3C2410_IRQ(17)		/* IRQ_DMA1 */
@@ -186,11 +196,7 @@
 #define IRQ_S3C2443_WDT		S3C2410_IRQSUB(27)
 #define IRQ_S3C2443_AC97	S3C2410_IRQSUB(28)
 
-#if defined(CONFIG_CPU_S3C2416)
-#define NR_IRQS (IRQ_S3C2416_I2S1 + 1)
-#else
-#define NR_IRQS (IRQ_S3C2443_AC97 + 1)
-#endif
+#define NR_IRQS_S3C2443		(S3C2410_IRQSUB(28) + 1)
 
 /* compatibility define. */
 #define IRQ_UART3		IRQ_S3C2443_UART3
diff --git a/arch/arm/mach-s3c/include/mach/irqs-s3c64xx.h b/arch/arm/mach-s3c/irqs-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/irqs-s3c64xx.h
rename to arch/arm/mach-s3c/irqs-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/irqs.h b/arch/arm/mach-s3c/irqs.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/irqs.h
rename to arch/arm/mach-s3c/irqs.h
diff --git a/arch/arm/mach-s3c/mach-amlm5900.c b/arch/arm/mach-s3c/mach-amlm5900.c
index 94c4512ace17..f85e5885e9b4 100644
--- a/arch/arm/mach-s3c/mach-amlm5900.c
+++ b/arch/arm/mach-s3c/mach-amlm5900.c
@@ -239,7 +239,9 @@ static void __init amlm5900_init(void)
 
 MACHINE_START(AML_M5900, "AML_M5900")
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2410,
 	.map_io		= amlm5900_map_io,
+	.nr_irqs	= NR_IRQS_S3C2410,
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= amlm5900_init,
 	.init_time	= amlm5900_init_time,
diff --git a/arch/arm/mach-s3c/mach-anubis.c b/arch/arm/mach-s3c/mach-anubis.c
index 60df40052209..4536f3e66e27 100644
--- a/arch/arm/mach-s3c/mach-anubis.c
+++ b/arch/arm/mach-s3c/mach-anubis.c
@@ -414,6 +414,7 @@ static void __init anubis_init(void)
 MACHINE_START(ANUBIS, "Simtec-Anubis")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2440,
 	.map_io		= anubis_map_io,
 	.init_machine	= anubis_init,
 	.init_irq	= s3c2440_init_irq,
diff --git a/arch/arm/mach-s3c/mach-anw6410.c b/arch/arm/mach-s3c/mach-anw6410.c
index 825714e9ac66..b67eae43e04f 100644
--- a/arch/arm/mach-s3c/mach-anw6410.c
+++ b/arch/arm/mach-s3c/mach-anw6410.c
@@ -40,7 +40,7 @@
 
 #include "devs.h"
 #include "cpu.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "regs-gpio.h"
 #include "gpio-samsung.h"
 
diff --git a/arch/arm/mach-s3c/mach-at2440evb.c b/arch/arm/mach-s3c/mach-at2440evb.c
index c6a5a51d84aa..743403d873e0 100644
--- a/arch/arm/mach-s3c/mach-at2440evb.c
+++ b/arch/arm/mach-s3c/mach-at2440evb.c
@@ -225,6 +225,7 @@ static void __init at2440evb_init(void)
 
 MACHINE_START(AT2440EVB, "AT2440EVB")
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2440,
 	.map_io		= at2440evb_map_io,
 	.init_machine	= at2440evb_init,
 	.init_irq	= s3c2440_init_irq,
diff --git a/arch/arm/mach-s3c/mach-bast.c b/arch/arm/mach-s3c/mach-bast.c
index 5ac24e406157..a33ceab81e09 100644
--- a/arch/arm/mach-s3c/mach-bast.c
+++ b/arch/arm/mach-s3c/mach-bast.c
@@ -575,6 +575,7 @@ static void __init bast_init(void)
 MACHINE_START(BAST, "Simtec-BAST")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2410,
 	.map_io		= bast_map_io,
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= bast_init,
diff --git a/arch/arm/mach-s3c/mach-crag6410-module.c b/arch/arm/mach-s3c/mach-crag6410-module.c
index 5d1d4b67a4b7..4edde13b89b5 100644
--- a/arch/arm/mach-s3c/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c/mach-crag6410-module.c
@@ -28,7 +28,7 @@
 #include <linux/platform_data/spi-s3c64xx.h>
 
 #include "cpu.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include "crag6410.h"
 
diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
index e3e0fe897bcc..9a45474d1bf7 100644
--- a/arch/arm/mach-s3c/mach-crag6410.c
+++ b/arch/arm/mach-s3c/mach-crag6410.c
@@ -47,7 +47,7 @@
 #include "map.h"
 #include "regs-gpio.h"
 #include "gpio-samsung.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include "fb.h"
 #include "sdhci.h"
diff --git a/arch/arm/mach-s3c/mach-gta02.c b/arch/arm/mach-s3c/mach-gta02.c
index 418939ce0fc3..abfdce765525 100644
--- a/arch/arm/mach-s3c/mach-gta02.c
+++ b/arch/arm/mach-s3c/mach-gta02.c
@@ -572,6 +572,7 @@ static void __init gta02_init_time(void)
 MACHINE_START(NEO1973_GTA02, "GTA02")
 	/* Maintainer: Nelson Castillo <arhuaco@freaks-unidos.net> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2442,
 	.map_io		= gta02_map_io,
 	.init_irq	= s3c2442_init_irq,
 	.init_machine	= gta02_machine_init,
diff --git a/arch/arm/mach-s3c/mach-h1940.c b/arch/arm/mach-s3c/mach-h1940.c
index 8a43ed1c4c4d..032b18837855 100644
--- a/arch/arm/mach-s3c/mach-h1940.c
+++ b/arch/arm/mach-s3c/mach-h1940.c
@@ -793,6 +793,7 @@ static void __init h1940_init(void)
 MACHINE_START(H1940, "IPAQ-H1940")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2410,
 	.map_io		= h1940_map_io,
 	.reserve	= h1940_reserve,
 	.init_irq	= s3c2410_init_irq,
diff --git a/arch/arm/mach-s3c/mach-hmt.c b/arch/arm/mach-s3c/mach-hmt.c
index b287e9987311..49ba16c447aa 100644
--- a/arch/arm/mach-s3c/mach-hmt.c
+++ b/arch/arm/mach-s3c/mach-hmt.c
@@ -26,7 +26,7 @@
 
 #include <video/samsung_fimd.h>
 #include "map.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-s3c/mach-jive.c b/arch/arm/mach-s3c/mach-jive.c
index 0d7d408c3729..e32773175944 100644
--- a/arch/arm/mach-s3c/mach-jive.c
+++ b/arch/arm/mach-s3c/mach-jive.c
@@ -677,7 +677,7 @@ static void __init jive_machine_init(void)
 MACHINE_START(JIVE, "JIVE")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
-
+	.nr_irqs	= NR_IRQS_S3C2412,
 	.init_irq	= s3c2412_init_irq,
 	.map_io		= jive_map_io,
 	.init_machine	= jive_machine_init,
diff --git a/arch/arm/mach-s3c/mach-mini2440.c b/arch/arm/mach-s3c/mach-mini2440.c
index 551ec660ab59..131015cc0c34 100644
--- a/arch/arm/mach-s3c/mach-mini2440.c
+++ b/arch/arm/mach-s3c/mach-mini2440.c
@@ -35,7 +35,7 @@
 
 #include "regs-gpio.h"
 #include <linux/platform_data/leds-s3c24xx.h>
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "gpio-samsung.h"
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
@@ -789,6 +789,7 @@ static void __init mini2440_init(void)
 MACHINE_START(MINI2440, "MINI2440")
 	/* Maintainer: Michel Pollet <buserror@gmail.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2440,
 	.map_io		= mini2440_map_io,
 	.init_machine	= mini2440_init,
 	.init_irq	= s3c2440_init_irq,
diff --git a/arch/arm/mach-s3c/mach-mini6410.c b/arch/arm/mach-s3c/mach-mini6410.c
index c14c2e27127b..058ae9e8b89f 100644
--- a/arch/arm/mach-s3c/mach-mini6410.c
+++ b/arch/arm/mach-s3c/mach-mini6410.c
@@ -35,7 +35,7 @@
 #include <linux/platform_data/mmc-sdhci-s3c.h>
 #include "sdhci.h"
 #include <linux/platform_data/touchscreen-s3c2410.h>
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
diff --git a/arch/arm/mach-s3c/mach-n30.c b/arch/arm/mach-s3c/mach-n30.c
index e40c1fcf418c..75f5dc6351a1 100644
--- a/arch/arm/mach-s3c/mach-n30.c
+++ b/arch/arm/mach-s3c/mach-n30.c
@@ -656,6 +656,7 @@ MACHINE_START(N30, "Acer-N30")
 				Ben Dooks <ben-linux@fluff.org>
 	*/
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2410,
 	.init_time	= n30_init_time,
 	.init_machine	= n30_init,
 	.init_irq	= s3c2410_init_irq,
@@ -666,6 +667,7 @@ MACHINE_START(N35, "Acer-N35")
 	/* Maintainer: Christer Weinigel <christer@weinigel.se>
 	*/
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2410,
 	.init_time	= n30_init_time,
 	.init_machine	= n30_init,
 	.init_irq	= s3c2410_init_irq,
diff --git a/arch/arm/mach-s3c/mach-ncp.c b/arch/arm/mach-s3c/mach-ncp.c
index 1a45bed56622..1e65f8bce5c4 100644
--- a/arch/arm/mach-s3c/mach-ncp.c
+++ b/arch/arm/mach-s3c/mach-ncp.c
@@ -24,7 +24,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "map.h"
 
 #include <asm/irq.h>
diff --git a/arch/arm/mach-s3c/mach-nexcoder.c b/arch/arm/mach-s3c/mach-nexcoder.c
index 2a454c919658..d17a3fcb7425 100644
--- a/arch/arm/mach-s3c/mach-nexcoder.c
+++ b/arch/arm/mach-s3c/mach-nexcoder.c
@@ -154,6 +154,7 @@ static void __init nexcoder_init(void)
 MACHINE_START(NEXCODER_2440, "NexVision - Nexcoder 2440")
 	/* Maintainer: Guillaume GOURAT <guillaume.gourat@nexvision.tv> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2440,
 	.map_io		= nexcoder_map_io,
 	.init_machine	= nexcoder_init,
 	.init_irq	= s3c2440_init_irq,
diff --git a/arch/arm/mach-s3c/mach-osiris.c b/arch/arm/mach-s3c/mach-osiris.c
index 8387773f4fd4..d900d1354de1 100644
--- a/arch/arm/mach-s3c/mach-osiris.c
+++ b/arch/arm/mach-s3c/mach-osiris.c
@@ -397,6 +397,7 @@ static void __init osiris_init(void)
 MACHINE_START(OSIRIS, "Simtec-OSIRIS")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2440,
 	.map_io		= osiris_map_io,
 	.init_irq	= s3c2440_init_irq,
 	.init_machine	= osiris_init,
diff --git a/arch/arm/mach-s3c/mach-otom.c b/arch/arm/mach-s3c/mach-otom.c
index 460ee97766cd..3a2db2f58833 100644
--- a/arch/arm/mach-s3c/mach-otom.c
+++ b/arch/arm/mach-s3c/mach-otom.c
@@ -116,6 +116,7 @@ static void __init otom11_init(void)
 MACHINE_START(OTOM, "Nex Vision - Otom 1.1")
 	/* Maintainer: Guillaume GOURAT <guillaume.gourat@nexvision.tv> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2410,
 	.map_io		= otom11_map_io,
 	.init_machine	= otom11_init,
 	.init_irq	= s3c2410_init_irq,
diff --git a/arch/arm/mach-s3c/mach-qt2410.c b/arch/arm/mach-s3c/mach-qt2410.c
index f88b961798fd..36fe0684a438 100644
--- a/arch/arm/mach-s3c/mach-qt2410.c
+++ b/arch/arm/mach-s3c/mach-qt2410.c
@@ -367,6 +367,7 @@ static void __init qt2410_machine_init(void)
 
 MACHINE_START(QT2410, "QT2410")
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2410,
 	.map_io		= qt2410_map_io,
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= qt2410_machine_init,
diff --git a/arch/arm/mach-s3c/mach-real6410.c b/arch/arm/mach-s3c/mach-real6410.c
index 9d218a53d631..8c10ebc38a9c 100644
--- a/arch/arm/mach-s3c/mach-real6410.c
+++ b/arch/arm/mach-s3c/mach-real6410.c
@@ -27,7 +27,7 @@
 #include "map.h"
 #include "regs-gpio.h"
 #include "gpio-samsung.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include <linux/soc/samsung/s3c-adc.h>
 #include "cpu.h"
diff --git a/arch/arm/mach-s3c/mach-rx1950.c b/arch/arm/mach-s3c/mach-rx1950.c
index 313e080e179e..7a3e7c0a6484 100644
--- a/arch/arm/mach-s3c/mach-rx1950.c
+++ b/arch/arm/mach-s3c/mach-rx1950.c
@@ -868,6 +868,7 @@ static void __init rx1950_reserve(void)
 MACHINE_START(RX1950, "HP iPAQ RX1950")
     /* Maintainers: Vasily Khoruzhick */
 	.atag_offset = 0x100,
+	.nr_irqs	= NR_IRQS_S3C2442,
 	.map_io = rx1950_map_io,
 	.reserve	= rx1950_reserve,
 	.init_irq	= s3c2442_init_irq,
diff --git a/arch/arm/mach-s3c/mach-rx3715.c b/arch/arm/mach-s3c/mach-rx3715.c
index 586cb0fdfce0..52b3c38acbb2 100644
--- a/arch/arm/mach-s3c/mach-rx3715.c
+++ b/arch/arm/mach-s3c/mach-rx3715.c
@@ -204,6 +204,7 @@ static void __init rx3715_init_machine(void)
 MACHINE_START(RX3715, "IPAQ-RX3715")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2440,
 	.map_io		= rx3715_map_io,
 	.reserve	= rx3715_reserve,
 	.init_irq	= s3c2440_init_irq,
diff --git a/arch/arm/mach-s3c/mach-smartq5.c b/arch/arm/mach-s3c/mach-smartq5.c
index 8c940227e810..ce3fce0bba20 100644
--- a/arch/arm/mach-s3c/mach-smartq5.c
+++ b/arch/arm/mach-s3c/mach-smartq5.c
@@ -14,7 +14,7 @@
 #include <asm/mach/arch.h>
 
 #include <video/samsung_fimd.h>
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "map.h"
 #include "regs-gpio.h"
 #include "gpio-samsung.h"
diff --git a/arch/arm/mach-s3c/mach-smartq7.c b/arch/arm/mach-s3c/mach-smartq7.c
index ab243969d6d0..78ca0e704797 100644
--- a/arch/arm/mach-s3c/mach-smartq7.c
+++ b/arch/arm/mach-s3c/mach-smartq7.c
@@ -14,7 +14,7 @@
 #include <asm/mach/arch.h>
 
 #include <video/samsung_fimd.h>
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "map.h"
 #include "regs-gpio.h"
 #include "gpio-samsung.h"
diff --git a/arch/arm/mach-s3c/mach-smdk2410.c b/arch/arm/mach-s3c/mach-smdk2410.c
index ca83d5a7d101..76b0a8846616 100644
--- a/arch/arm/mach-s3c/mach-smdk2410.c
+++ b/arch/arm/mach-s3c/mach-smdk2410.c
@@ -104,6 +104,7 @@ MACHINE_START(SMDK2410, "SMDK2410") /* @TODO: request a new identifier and switc
 				    * to SMDK2410 */
 	/* Maintainer: Jonas Dietsche */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2410,
 	.map_io		= smdk2410_map_io,
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= smdk2410_init,
diff --git a/arch/arm/mach-s3c/mach-smdk2413.c b/arch/arm/mach-s3c/mach-smdk2413.c
index c43095b321d7..f1f0ec174579 100644
--- a/arch/arm/mach-s3c/mach-smdk2413.c
+++ b/arch/arm/mach-s3c/mach-smdk2413.c
@@ -129,6 +129,7 @@ static void __init smdk2413_machine_init(void)
 MACHINE_START(S3C2413, "S3C2413")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2412,
 
 	.fixup		= smdk2413_fixup,
 	.init_irq	= s3c2412_init_irq,
@@ -140,6 +141,7 @@ MACHINE_END
 MACHINE_START(SMDK2412, "SMDK2412")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2412,
 
 	.fixup		= smdk2413_fixup,
 	.init_irq	= s3c2412_init_irq,
@@ -151,6 +153,7 @@ MACHINE_END
 MACHINE_START(SMDK2413, "SMDK2413")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2412,
 
 	.fixup		= smdk2413_fixup,
 	.init_irq	= s3c2412_init_irq,
diff --git a/arch/arm/mach-s3c/mach-smdk2416.c b/arch/arm/mach-s3c/mach-smdk2416.c
index 38b4a7cd4178..329fe26be268 100644
--- a/arch/arm/mach-s3c/mach-smdk2416.c
+++ b/arch/arm/mach-s3c/mach-smdk2416.c
@@ -239,6 +239,7 @@ static void __init smdk2416_machine_init(void)
 MACHINE_START(SMDK2416, "SMDK2416")
 	/* Maintainer: Yauhen Kharuzhy <jekhor@gmail.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2416,
 
 	.init_irq	= s3c2416_init_irq,
 	.map_io		= smdk2416_map_io,
diff --git a/arch/arm/mach-s3c/mach-smdk2440.c b/arch/arm/mach-s3c/mach-smdk2440.c
index 392554b1eba2..6aea769ebde1 100644
--- a/arch/arm/mach-s3c/mach-smdk2440.c
+++ b/arch/arm/mach-s3c/mach-smdk2440.c
@@ -171,6 +171,7 @@ static void __init smdk2440_machine_init(void)
 MACHINE_START(S3C2440, "SMDK2440")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2440,
 
 	.init_irq	= s3c2440_init_irq,
 	.map_io		= smdk2440_map_io,
diff --git a/arch/arm/mach-s3c/mach-smdk2443.c b/arch/arm/mach-s3c/mach-smdk2443.c
index 4c541a03e49e..075140f8f760 100644
--- a/arch/arm/mach-s3c/mach-smdk2443.c
+++ b/arch/arm/mach-s3c/mach-smdk2443.c
@@ -118,7 +118,7 @@ static void __init smdk2443_machine_init(void)
 MACHINE_START(SMDK2443, "SMDK2443")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
-
+	.nr_irqs	= NR_IRQS_S3C2443,
 	.init_irq	= s3c2443_init_irq,
 	.map_io		= smdk2443_map_io,
 	.init_machine	= smdk2443_machine_init,
diff --git a/arch/arm/mach-s3c/mach-smdk6400.c b/arch/arm/mach-s3c/mach-smdk6400.c
index 827221398d6c..a3c1b2a82455 100644
--- a/arch/arm/mach-s3c/mach-smdk6400.c
+++ b/arch/arm/mach-s3c/mach-smdk6400.c
@@ -22,7 +22,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "map.h"
 
 #include "devs.h"
diff --git a/arch/arm/mach-s3c/mach-smdk6410.c b/arch/arm/mach-s3c/mach-smdk6410.c
index ae18c1375c9c..e57b2bb61484 100644
--- a/arch/arm/mach-s3c/mach-smdk6410.c
+++ b/arch/arm/mach-s3c/mach-smdk6410.c
@@ -45,7 +45,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "map.h"
 
 #include <asm/irq.h>
diff --git a/arch/arm/mach-s3c/mach-tct_hammer.c b/arch/arm/mach-s3c/mach-tct_hammer.c
index 2a61df316e8c..93ab1abd8bd3 100644
--- a/arch/arm/mach-s3c/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c/mach-tct_hammer.c
@@ -149,6 +149,7 @@ static void __init tct_hammer_init(void)
 
 MACHINE_START(TCT_HAMMER, "TCT_HAMMER")
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2410,
 	.map_io		= tct_hammer_map_io,
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= tct_hammer_init,
diff --git a/arch/arm/mach-s3c/mach-vr1000.c b/arch/arm/mach-s3c/mach-vr1000.c
index 3aa8c707f8a2..c85033e6ef8f 100644
--- a/arch/arm/mach-s3c/mach-vr1000.c
+++ b/arch/arm/mach-s3c/mach-vr1000.c
@@ -356,6 +356,7 @@ static void __init vr1000_init(void)
 MACHINE_START(VR1000, "Thorcom-VR1000")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2410,
 	.map_io		= vr1000_map_io,
 	.init_machine	= vr1000_init,
 	.init_irq	= s3c2410_init_irq,
diff --git a/arch/arm/mach-s3c/mach-vstms.c b/arch/arm/mach-s3c/mach-vstms.c
index ec024af7b0ce..6f878418be3e 100644
--- a/arch/arm/mach-s3c/mach-vstms.c
+++ b/arch/arm/mach-s3c/mach-vstms.c
@@ -156,6 +156,7 @@ static void __init vstms_init(void)
 
 MACHINE_START(VSTMS, "VSTMS")
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_S3C2412,
 
 	.fixup		= vstms_fixup,
 	.init_irq	= s3c2412_init_irq,
diff --git a/arch/arm/mach-s3c/pl080.c b/arch/arm/mach-s3c/pl080.c
index 4730f080c736..0a14f77b24c1 100644
--- a/arch/arm/mach-s3c/pl080.c
+++ b/arch/arm/mach-s3c/pl080.c
@@ -11,7 +11,7 @@
 #include <linux/of.h>
 
 #include "cpu.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "map.h"
 
 #include "regs-sys-s3c64xx.h"
diff --git a/arch/arm/mach-s3c/pm-core-s3c24xx.h b/arch/arm/mach-s3c/pm-core-s3c24xx.h
index bcb7978a4e85..a71ed5711019 100644
--- a/arch/arm/mach-s3c/pm-core-s3c24xx.h
+++ b/arch/arm/mach-s3c/pm-core-s3c24xx.h
@@ -12,7 +12,7 @@
 
 #include "regs-clock.h"
 #include "regs-irq-s3c24xx.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 
 static inline void s3c_pm_debug_init_uart(void)
 {
diff --git a/arch/arm/mach-s3c/pm-s3c2412.c b/arch/arm/mach-s3c/pm-s3c2412.c
index 6a9604477c9e..ed3b4cfc7c0f 100644
--- a/arch/arm/mach-s3c/pm-s3c2412.c
+++ b/arch/arm/mach-s3c/pm-s3c2412.c
@@ -19,7 +19,7 @@
 #include <asm/cacheflush.h>
 #include <asm/irq.h>
 
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "regs-gpio.h"
 
 #include "cpu.h"
diff --git a/arch/arm/mach-s3c/pm-s3c64xx.c b/arch/arm/mach-s3c/pm-s3c64xx.c
index 4f1778123dee..1770276a00f2 100644
--- a/arch/arm/mach-s3c/pm-s3c64xx.c
+++ b/arch/arm/mach-s3c/pm-s3c64xx.c
@@ -15,7 +15,7 @@
 #include <linux/pm_domain.h>
 
 #include "map.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include "cpu.h"
 #include "devs.h"
diff --git a/arch/arm/mach-s3c/pm.c b/arch/arm/mach-s3c/pm.c
index c563bb9d92be..06f019690d81 100644
--- a/arch/arm/mach-s3c/pm.c
+++ b/arch/arm/mach-s3c/pm.c
@@ -21,7 +21,7 @@
 #include "map.h"
 #include "regs-clock.h"
 #include "regs-irq.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include <asm/irq.h>
 
diff --git a/arch/arm/mach-s3c/s3c2443.c b/arch/arm/mach-s3c/s3c2443.c
index 08f910144246..05c3c298b9f8 100644
--- a/arch/arm/mach-s3c/s3c2443.c
+++ b/arch/arm/mach-s3c/s3c2443.c
@@ -25,7 +25,7 @@
 
 #include "map.h"
 #include "gpio-samsung.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 
diff --git a/arch/arm/mach-s3c/s3c24xx.h b/arch/arm/mach-s3c/s3c24xx.h
index 5848bef5bb49..34dd4ac507e9 100644
--- a/arch/arm/mach-s3c/s3c24xx.h
+++ b/arch/arm/mach-s3c/s3c24xx.h
@@ -10,7 +10,7 @@
 #define __ARCH_ARM_MACH_S3C24XX_COMMON_H __FILE__
 
 #include <linux/reboot.h>
-#include <mach/irqs.h>
+#include "irqs.h"
 
 struct s3c2410_uartcfg;
 
diff --git a/arch/arm/mach-s3c/s3c64xx.c b/arch/arm/mach-s3c/s3c64xx.c
index 4dfb648142f2..c89982dbb418 100644
--- a/arch/arm/mach-s3c/s3c64xx.c
+++ b/arch/arm/mach-s3c/s3c64xx.c
@@ -36,7 +36,7 @@
 #include <asm/system_misc.h>
 
 #include "map.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "regs-gpio.h"
 #include "gpio-samsung.h"
 
diff --git a/arch/arm/mach-s3c/simtec-usb.c b/arch/arm/mach-s3c/simtec-usb.c
index 18fe0642743a..76cedb5c7373 100644
--- a/arch/arm/mach-s3c/simtec-usb.c
+++ b/arch/arm/mach-s3c/simtec-usb.c
@@ -24,7 +24,7 @@
 #include <asm/mach/irq.h>
 
 #include "gpio-samsung.h"
-#include <mach/irqs.h>
+#include "irqs.h"
 #include <asm/irq.h>
 
 #include <linux/platform_data/usb-ohci-s3c2410.h>
-- 
2.29.2

