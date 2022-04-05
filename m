Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E144F4100
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350314AbiDEOGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbiDEJbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D562FE20;
        Tue,  5 Apr 2022 02:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 624B3B81B7F;
        Tue,  5 Apr 2022 09:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35910C385A9;
        Tue,  5 Apr 2022 09:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150324;
        bh=5kt1dppe+8wUuxiuygv88y2CPW/Cqw3zsgWm2dxOFr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z80kkFcSxfV5dtas7PwORryjeVdA+Jn2fzj1FMwcyzGU0LQeP00S+GmO0hkSres/e
         hqX3L/oYwdHULZseN7cqSsFWDLDNo6rN1CbucAcIhhIJ3p0RGk1HNu2AYn9k+jMifE
         GaVGy2BRncSyuAAZOPVuw/GpI9+88rTG9R5m5Xk1LLBI5/lMEK6zAQ3vkrZTJetOFM
         i0OnZbmry5qdHPi6LlOjBCT+2dEgcKp8TF9CtwNdjjszOn/aZ8XPzviVGfiQbFWMFk
         MME8se15teRx7qaOgm7fEXkyR0Kgtdg3w216bXsdd1YLsYw41TX/sNHJAsDBxRrGXl
         Llk5pWF+qKbkg==
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
Subject: [PATCH 07/12] ARM: s3c24xx: remove support for ISA drivers on BAST PC/104
Date:   Tue,  5 Apr 2022 11:17:45 +0200
Message-Id: <20220405091750.3076973-8-arnd@kernel.org>
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

BAST is the one machine that theoretically supports unmodified ISA
drivers for hardware on its PC/104 connector, using a custom version of
the inb()/outb() and inw()/outw() macros.

This is incompatible with the generic version used in asm/io.h, and
can't easily be used in a multiplatform kernel.

Removing the special case for 16-bit I/O port access on BAST gets us
closer to multiplatform, at the expense of any PC/104 users with 16-bit
cards having to either use an older kernel or modify their ISA drivers
to manually ioremap() the area and use readw()/write() in place of
inw()/outw(). Either way is probably ok, given that all of s3c24xx is
already on the way out next year, and many traditional ISA drivers are
already gone.

Machines other than BAST already have no support for ISA drivers, though a
couple of them do map one of the external chip-selects into the ISA port
range, using the same address for 8-bit and 16-bit I/O. It is unlikely
that anything actually uses this mapping, but it's also easy to keep
this working by mapping it to the normal platform-independent PCI I/O
base that is otherwise unused on s3c24xx.

The mach/map-base.h file is no longer referenced in global headers and
can be moved into the platform directory.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                              |  1 -
 arch/arm/mach-s3c/Kconfig.s3c24xx             |  1 -
 arch/arm/mach-s3c/cpu.c                       |  2 +-
 arch/arm/mach-s3c/include/mach/io-s3c24xx.h   | 50 -------------------
 arch/arm/mach-s3c/include/mach/io.h           |  8 ---
 arch/arm/mach-s3c/irq-pm-s3c24xx.c            |  2 +-
 arch/arm/mach-s3c/mach-anubis.c               |  5 --
 arch/arm/mach-s3c/mach-bast.c                 |  5 --
 arch/arm/mach-s3c/mach-osiris.c               |  5 --
 arch/arm/mach-s3c/mach-rx3715.c               |  6 ---
 arch/arm/mach-s3c/mach-smdk2416.c             | 10 ----
 arch/arm/mach-s3c/mach-smdk2440.c             | 10 ----
 arch/arm/mach-s3c/mach-smdk2443.c             | 10 ----
 arch/arm/mach-s3c/mach-vr1000.c               |  5 --
 .../mach-s3c/{include/mach => }/map-base.h    |  6 +++
 arch/arm/mach-s3c/map-s3c24xx.h               |  2 +-
 arch/arm/mach-s3c/map-s3c64xx.h               |  2 +-
 17 files changed, 10 insertions(+), 120 deletions(-)
 delete mode 100644 arch/arm/mach-s3c/include/mach/io-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/include/mach/io.h
 rename arch/arm/mach-s3c/{include/mach => }/map-base.h (87%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index faf696173af7..2242d2ae8854 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -444,7 +444,6 @@ config ARCH_S3C24XX
 	select CLKSRC_SAMSUNG_PWM
 	select GPIO_SAMSUNG
 	select GPIOLIB
-	select NEED_MACH_IO_H
 	select S3C2410_WATCHDOG
 	select SAMSUNG_ATAGS
 	select USE_OF
diff --git a/arch/arm/mach-s3c/Kconfig.s3c24xx b/arch/arm/mach-s3c/Kconfig.s3c24xx
index 000e3e234f71..d47df6427e89 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c24xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c24xx
@@ -181,7 +181,6 @@ config MACH_AML_M5900
 
 config ARCH_BAST
 	bool "Simtec Electronics BAST (EB2410ITX)"
-	select ISA
 	select MACH_BAST_IDE
 	select S3C2410_COMMON_DCLK
 	select S3C2410_IOTIMING if ARM_S3C2410_CPUFREQ
diff --git a/arch/arm/mach-s3c/cpu.c b/arch/arm/mach-s3c/cpu.c
index 6e9772555f0d..05a6b4be1768 100644
--- a/arch/arm/mach-s3c/cpu.c
+++ b/arch/arm/mach-s3c/cpu.c
@@ -10,7 +10,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 
-#include <mach/map-base.h>
+#include "map-base.h"
 #include "cpu.h"
 
 unsigned long samsung_cpu_id;
diff --git a/arch/arm/mach-s3c/include/mach/io-s3c24xx.h b/arch/arm/mach-s3c/include/mach/io-s3c24xx.h
deleted file mode 100644
index 738b775d3336..000000000000
--- a/arch/arm/mach-s3c/include/mach/io-s3c24xx.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * arch/arm/mach-s3c2410/include/mach/io.h
- *  from arch/arm/mach-rpc/include/mach/io.h
- *
- * Copyright (C) 1997 Russell King
- *	     (C) 2003 Simtec Electronics
-*/
-
-#ifndef __ASM_ARM_ARCH_IO_S3C24XX_H
-#define __ASM_ARM_ARCH_IO_S3C24XX_H
-
-#include <mach/map-base.h>
-
-/*
- * ISA style IO, for each machine to sort out mappings for,
- * if it implements it. We reserve two 16M regions for ISA,
- * so the PC/104 can use separate addresses for 8-bit and
- * 16-bit port I/O.
- */
-#define PCIO_BASE		S3C_ADDR(0x02000000)
-#define IO_SPACE_LIMIT		0x00ffffff
-#define S3C24XX_VA_ISA_WORD	(PCIO_BASE)
-#define S3C24XX_VA_ISA_BYTE	(PCIO_BASE + 0x01000000)
-
-#ifdef CONFIG_ISA
-
-#define inb(p)		readb(S3C24XX_VA_ISA_BYTE + (p))
-#define inw(p)		readw(S3C24XX_VA_ISA_WORD + (p))
-#define inl(p)		readl(S3C24XX_VA_ISA_WORD + (p))
-
-#define outb(v,p)	writeb((v), S3C24XX_VA_ISA_BYTE + (p))
-#define outw(v,p)	writew((v), S3C24XX_VA_ISA_WORD + (p))
-#define outl(v,p)	writel((v), S3C24XX_VA_ISA_WORD + (p))
-
-#define insb(p,d,l)	readsb(S3C24XX_VA_ISA_BYTE + (p),d,l)
-#define insw(p,d,l)	readsw(S3C24XX_VA_ISA_WORD + (p),d,l)
-#define insl(p,d,l)	readsl(S3C24XX_VA_ISA_WORD + (p),d,l)
-
-#define outsb(p,d,l)	writesb(S3C24XX_VA_ISA_BYTE + (p),d,l)
-#define outsw(p,d,l)	writesw(S3C24XX_VA_ISA_WORD + (p),d,l)
-#define outsl(p,d,l)	writesl(S3C24XX_VA_ISA_WORD + (p),d,l)
-
-#else
-
-#define __io(x) (PCIO_BASE + (x))
-
-#endif
-
-#endif
diff --git a/arch/arm/mach-s3c/include/mach/io.h b/arch/arm/mach-s3c/include/mach/io.h
deleted file mode 100644
index 30a0135708dc..000000000000
--- a/arch/arm/mach-s3c/include/mach/io.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2020 Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-#ifdef CONFIG_ARCH_S3C24XX
-#include "io-s3c24xx.h"
-#endif
diff --git a/arch/arm/mach-s3c/irq-pm-s3c24xx.c b/arch/arm/mach-s3c/irq-pm-s3c24xx.c
index 4d5e28312d91..55f41135ad70 100644
--- a/arch/arm/mach-s3c/irq-pm-s3c24xx.c
+++ b/arch/arm/mach-s3c/irq-pm-s3c24xx.c
@@ -15,7 +15,7 @@
 
 #include "cpu.h"
 #include "pm.h"
-#include <mach/map-base.h>
+#include "map-base.h"
 #include "map-s3c.h"
 
 #include "regs-irq.h"
diff --git a/arch/arm/mach-s3c/mach-anubis.c b/arch/arm/mach-s3c/mach-anubis.c
index 04147cc0adcc..60df40052209 100644
--- a/arch/arm/mach-s3c/mach-anubis.c
+++ b/arch/arm/mach-s3c/mach-anubis.c
@@ -57,11 +57,6 @@ static struct map_desc anubis_iodesc[] __initdata = {
 	.pfn		= __phys_to_pfn(0x0),
 	.length		= SZ_4M,
 	.type		= MT_DEVICE,
-  }, {
-	.virtual	= (u32)S3C24XX_VA_ISA_WORD,
-	.pfn		= __phys_to_pfn(0x0),
-	.length 	= SZ_4M,
-	.type		= MT_DEVICE,
   },
 
   /* we could possibly compress the next set down into a set of smaller tables
diff --git a/arch/arm/mach-s3c/mach-bast.c b/arch/arm/mach-s3c/mach-bast.c
index 27e8d5950228..5ac24e406157 100644
--- a/arch/arm/mach-s3c/mach-bast.c
+++ b/arch/arm/mach-s3c/mach-bast.c
@@ -75,11 +75,6 @@ static struct map_desc bast_iodesc[] __initdata = {
 	  .pfn		= PA_CS2(BAST_PA_ISAIO),
 	  .length	= SZ_16M,
 	  .type		= MT_DEVICE,
-  }, {
-	  .virtual	= (u32)S3C24XX_VA_ISA_WORD,
-	  .pfn		= PA_CS3(BAST_PA_ISAIO),
-	  .length	= SZ_16M,
-	  .type		= MT_DEVICE,
   },
   /* bast CPLD control registers, and external interrupt controls */
   {
diff --git a/arch/arm/mach-s3c/mach-osiris.c b/arch/arm/mach-s3c/mach-osiris.c
index 3aefb9d22340..8387773f4fd4 100644
--- a/arch/arm/mach-s3c/mach-osiris.c
+++ b/arch/arm/mach-s3c/mach-osiris.c
@@ -58,11 +58,6 @@ static struct map_desc osiris_iodesc[] __initdata = {
 	  .pfn		= __phys_to_pfn(S3C2410_CS5),
 	  .length	= SZ_16M,
 	  .type		= MT_DEVICE,
-  }, {
-	  .virtual	= (u32)S3C24XX_VA_ISA_WORD,
-	  .pfn		= __phys_to_pfn(S3C2410_CS5),
-	  .length	= SZ_16M,
-	  .type		= MT_DEVICE,
   },
 
   /* CPLD control registers */
diff --git a/arch/arm/mach-s3c/mach-rx3715.c b/arch/arm/mach-s3c/mach-rx3715.c
index 9fd2d9dc3689..586cb0fdfce0 100644
--- a/arch/arm/mach-s3c/mach-rx3715.c
+++ b/arch/arm/mach-s3c/mach-rx3715.c
@@ -48,13 +48,7 @@
 
 static struct map_desc rx3715_iodesc[] __initdata = {
 	/* dump ISA space somewhere unused */
-
 	{
-		.virtual	= (u32)S3C24XX_VA_ISA_WORD,
-		.pfn		= __phys_to_pfn(S3C2410_CS3),
-		.length		= SZ_1M,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (u32)S3C24XX_VA_ISA_BYTE,
 		.pfn		= __phys_to_pfn(S3C2410_CS3),
 		.length		= SZ_1M,
diff --git a/arch/arm/mach-s3c/mach-smdk2416.c b/arch/arm/mach-s3c/mach-smdk2416.c
index 4d883a792cc6..38b4a7cd4178 100644
--- a/arch/arm/mach-s3c/mach-smdk2416.c
+++ b/arch/arm/mach-s3c/mach-smdk2416.c
@@ -53,16 +53,6 @@ static struct map_desc smdk2416_iodesc[] __initdata = {
 	/* ISA IO Space map (memory space selected by A24) */
 
 	{
-		.virtual	= (u32)S3C24XX_VA_ISA_WORD,
-		.pfn		= __phys_to_pfn(S3C2410_CS2),
-		.length		= 0x10000,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (u32)S3C24XX_VA_ISA_WORD + 0x10000,
-		.pfn		= __phys_to_pfn(S3C2410_CS2 + (1<<24)),
-		.length		= SZ_4M,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (u32)S3C24XX_VA_ISA_BYTE,
 		.pfn		= __phys_to_pfn(S3C2410_CS2),
 		.length		= 0x10000,
diff --git a/arch/arm/mach-s3c/mach-smdk2440.c b/arch/arm/mach-s3c/mach-smdk2440.c
index 7f6fe0db04f3..392554b1eba2 100644
--- a/arch/arm/mach-s3c/mach-smdk2440.c
+++ b/arch/arm/mach-s3c/mach-smdk2440.c
@@ -43,16 +43,6 @@ static struct map_desc smdk2440_iodesc[] __initdata = {
 	/* ISA IO Space map (memory space selected by A24) */
 
 	{
-		.virtual	= (u32)S3C24XX_VA_ISA_WORD,
-		.pfn		= __phys_to_pfn(S3C2410_CS2),
-		.length		= 0x10000,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (u32)S3C24XX_VA_ISA_WORD + 0x10000,
-		.pfn		= __phys_to_pfn(S3C2410_CS2 + (1<<24)),
-		.length		= SZ_4M,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (u32)S3C24XX_VA_ISA_BYTE,
 		.pfn		= __phys_to_pfn(S3C2410_CS2),
 		.length		= 0x10000,
diff --git a/arch/arm/mach-s3c/mach-smdk2443.c b/arch/arm/mach-s3c/mach-smdk2443.c
index fc54c91ade56..4c541a03e49e 100644
--- a/arch/arm/mach-s3c/mach-smdk2443.c
+++ b/arch/arm/mach-s3c/mach-smdk2443.c
@@ -40,16 +40,6 @@ static struct map_desc smdk2443_iodesc[] __initdata = {
 	/* ISA IO Space map (memory space selected by A24) */
 
 	{
-		.virtual	= (u32)S3C24XX_VA_ISA_WORD,
-		.pfn		= __phys_to_pfn(S3C2410_CS2),
-		.length		= 0x10000,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (u32)S3C24XX_VA_ISA_WORD + 0x10000,
-		.pfn		= __phys_to_pfn(S3C2410_CS2 + (1<<24)),
-		.length		= SZ_4M,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (u32)S3C24XX_VA_ISA_BYTE,
 		.pfn		= __phys_to_pfn(S3C2410_CS2),
 		.length		= 0x10000,
diff --git a/arch/arm/mach-s3c/mach-vr1000.c b/arch/arm/mach-s3c/mach-vr1000.c
index 5c3d07cf2e79..3aa8c707f8a2 100644
--- a/arch/arm/mach-s3c/mach-vr1000.c
+++ b/arch/arm/mach-s3c/mach-vr1000.c
@@ -67,11 +67,6 @@ static struct map_desc vr1000_iodesc[] __initdata = {
 	  .pfn		= PA_CS2(BAST_PA_ISAIO),
 	  .length	= SZ_16M,
 	  .type		= MT_DEVICE,
-  }, {
-	  .virtual	= (u32)S3C24XX_VA_ISA_WORD,
-	  .pfn		= PA_CS3(BAST_PA_ISAIO),
-	  .length	= SZ_16M,
-	  .type		= MT_DEVICE,
   },
 
   /*  CPLD control registers, and external interrupt controls */
diff --git a/arch/arm/mach-s3c/include/mach/map-base.h b/arch/arm/mach-s3c/map-base.h
similarity index 87%
rename from arch/arm/mach-s3c/include/mach/map-base.h
rename to arch/arm/mach-s3c/map-base.h
index 34b39ded0e2e..463a995b399b 100644
--- a/arch/arm/mach-s3c/include/mach/map-base.h
+++ b/arch/arm/mach-s3c/map-base.h
@@ -33,6 +33,12 @@
 #define S3C_VA_WATCHDOG	S3C_ADDR(0x00400000)	/* watchdog */
 #define S3C_VA_UART	S3C_ADDR(0x01000000)	/* UART */
 
+/* ISA device mapping for BAST to use with inb()/outb() on 8-bit I/O.
+ * 16-bit I/O on BAST now requires driver modifications to manually
+ * ioremap CS3.
+ */
+#define S3C24XX_VA_ISA_BYTE	PCI_IOBASE
+
 /* This is used for the CPU specific mappings that may be needed, so that
  * they do not need to directly used S3C_ADDR() and thus make it easier to
  * modify the space for mapping.
diff --git a/arch/arm/mach-s3c/map-s3c24xx.h b/arch/arm/mach-s3c/map-s3c24xx.h
index b5dba78a9dd7..f8d075b11d6f 100644
--- a/arch/arm/mach-s3c/map-s3c24xx.h
+++ b/arch/arm/mach-s3c/map-s3c24xx.h
@@ -9,7 +9,7 @@
 #ifndef __ASM_ARCH_MAP_H
 #define __ASM_ARCH_MAP_H
 
-#include <mach/map-base.h>
+#include "map-base.h"
 #include "map-s3c.h"
 
 /*
diff --git a/arch/arm/mach-s3c/map-s3c64xx.h b/arch/arm/mach-s3c/map-s3c64xx.h
index d7740d2a77c4..9de1c58bcb06 100644
--- a/arch/arm/mach-s3c/map-s3c64xx.h
+++ b/arch/arm/mach-s3c/map-s3c64xx.h
@@ -11,7 +11,7 @@
 #ifndef __ASM_ARCH_MAP_H
 #define __ASM_ARCH_MAP_H __FILE__
 
-#include <mach/map-base.h>
+#include "map-base.h"
 #include "map-s3c.h"
 
 /*
-- 
2.29.2

