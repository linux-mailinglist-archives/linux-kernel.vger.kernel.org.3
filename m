Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D743C4F43C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359679AbiDEOHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbiDEJbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B084992D;
        Tue,  5 Apr 2022 02:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90CF3CE1B55;
        Tue,  5 Apr 2022 09:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16137C385A2;
        Tue,  5 Apr 2022 09:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150335;
        bh=cobwypes8x1Y1nEK97L8+w7M2tP4Y3ZkJhAVWGRhnmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fasO7u3ltU88/oq+SUA59QkdlG1fpUJ9k6ySxEZiwMwgSRzQWLG1ld2GQtNSZxD3A
         AOMy9RhcyRAk14Z1wOIkOgHA+V28MDhhpsBqJpurlpetiRW/EaJeHLeaQfsuDE9IRa
         4xWsJ0QNvoOzfXOIJX42Uu6k1XT4ZOqaC9ZzBDcv2RGK+dH/o0gZPfj9DZ2DdPVGOd
         9ewToWkhL2TQz84+23flv5wO4dbY0u/AS49JKM5pabpF3QmPtwyR/ppRdJSE/c/S6R
         ppRMmbqA7Oed2fAiGWJAYAZUQHx+Q+0Y6KpWC7QwAYjbgDLar7cJlnjhRTzZX7Gw5i
         0OPR/SA0rKdrQ==
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
Subject: [PATCH 09/12] ARM: s3c: enable s3c24xx multiplatform support
Date:   Tue,  5 Apr 2022 11:17:47 +0200
Message-Id: <20220405091750.3076973-10-arnd@kernel.org>
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

With the custom ISA I/O and the missing sparse-irq support
out of the way, s3c24xx can now be built into the same
kernel as all other ARM9 based platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                  | 18 ------------------
 arch/arm/mach-s3c/Kconfig.s3c24xx | 23 ++++++++++++++++++++++-
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c06e008c90ab..68b0a857f9e5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -438,24 +438,6 @@ config ARCH_SA1100
 	help
 	  Support for StrongARM 11x0 based boards.
 
-config ARCH_S3C24XX
-	bool "Samsung S3C24XX SoCs"
-	select ATAGS
-	select CLKSRC_SAMSUNG_PWM
-	select GPIO_SAMSUNG
-	select GPIOLIB
-	select IRQ_DOMAIN
-	select S3C2410_WATCHDOG
-	select SAMSUNG_ATAGS
-	select SPARSE_IRQ
-	select USE_OF
-	select WATCHDOG
-	help
-	  Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443
-	  and S3C2450 SoCs based systems, such as the Simtec Electronics BAST
-	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
-	  Samsung SMDK2410 development board (and derivatives).
-
 config ARCH_OMAP1
 	bool "TI OMAP1"
 	select ARCH_OMAP
diff --git a/arch/arm/mach-s3c/Kconfig.s3c24xx b/arch/arm/mach-s3c/Kconfig.s3c24xx
index d47df6427e89..e388e265ba83 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c24xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c24xx
@@ -5,6 +5,22 @@
 #
 # Copyright 2007 Simtec Electronics
 
+menuconfig ARCH_S3C24XX
+	bool "Samsung S3C24XX SoCs"
+	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5
+	select ATAGS
+	select CLKSRC_SAMSUNG_PWM
+	select GPIO_SAMSUNG
+	select GPIOLIB
+	select S3C2410_WATCHDOG
+	select SAMSUNG_ATAGS
+	select WATCHDOG
+	help
+	  Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443
+	  and S3C2450 SoCs based systems, such as the Simtec Electronics BAST
+	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
+	  Samsung SMDK2410 development board (and derivatives).
+
 if ARCH_S3C24XX
 
 config PLAT_S3C24XX
@@ -12,7 +28,6 @@ config PLAT_S3C24XX
 	select GPIOLIB
 	select NO_IOPORT_MAP
 	select S3C_DEV_NAND
-	select IRQ_DOMAIN
 	select COMMON_CLK
 	help
 	  Base platform code for any Samsung S3C24XX device
@@ -25,6 +40,7 @@ comment "S3C24XX SoCs"
 
 config CPU_S3C2410
 	bool "Samsung S3C2410"
+	depends on ARCH_MULTI_V4T
 	default y
 	select CPU_ARM920T
 	select S3C2410_COMMON_CLK
@@ -36,6 +52,7 @@ config CPU_S3C2410
 
 config CPU_S3C2412
 	bool "Samsung S3C2412"
+	depends on ARCH_MULTI_V5
 	select CPU_ARM926T
 	select S3C2412_COMMON_CLK
 	select S3C2412_PM if PM_SLEEP
@@ -44,6 +61,7 @@ config CPU_S3C2412
 
 config CPU_S3C2416
 	bool "Samsung S3C2416/S3C2450"
+	depends on ARCH_MULTI_V5
 	select CPU_ARM926T
 	select S3C2416_PM if PM_SLEEP
 	select S3C2443_COMMON_CLK
@@ -52,6 +70,7 @@ config CPU_S3C2416
 
 config CPU_S3C2440
 	bool "Samsung S3C2440"
+	depends on ARCH_MULTI_V4T
 	select CPU_ARM920T
 	select S3C2410_COMMON_CLK
 	select S3C2410_PM if PM_SLEEP
@@ -60,6 +79,7 @@ config CPU_S3C2440
 
 config CPU_S3C2442
 	bool "Samsung S3C2442"
+	depends on ARCH_MULTI_V4T
 	select CPU_ARM920T
 	select S3C2410_COMMON_CLK
 	select S3C2410_PM if PM_SLEEP
@@ -72,6 +92,7 @@ config CPU_S3C244X
 
 config CPU_S3C2443
 	bool "Samsung S3C2443"
+	depends on ARCH_MULTI_V4T
 	select CPU_ARM920T
 	select S3C2443_COMMON_CLK
 	help
-- 
2.29.2

