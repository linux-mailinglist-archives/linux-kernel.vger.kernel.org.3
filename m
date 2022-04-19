Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06291507508
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355296AbiDSQtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354886AbiDSQmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:42:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8D415FDD;
        Tue, 19 Apr 2022 09:39:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D7A3B81BEB;
        Tue, 19 Apr 2022 16:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CD1C385AF;
        Tue, 19 Apr 2022 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386378;
        bh=7xEnZ0JSPWZhTH940v/NcGNAbOyRIyfBWQe+0s0khHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2+iU6c8bjeJ3b4/hWR8738LXyw2qX/PeoFQkQee06q/vC7ddu3A5paCnfw9cViZ0
         1fBHsL7duftcUL7G4nuM2IRlQk2KY6lsgVtQuDj/pHPyjLxqHD/8dTXiqD3xm3lzOw
         3zqMMyS3sa9kuU55H0WPkrepH99Qln75vsXp46325cju4AxH9JOASF64ejSwaYDiQW
         XK4cjQPK/vvSqzAbE/RPMy1oHrXG/vxp89TInVKBQwrtCc6W5mnrs/h8bNfSFxEhEX
         cWCDK6zl1DWuudpeHuSJIn2jTIsuGmr5kz5m3ceIgi2uQGIuHn5uclCDYzNllRUsoG
         VX9+70vTRthWw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 06/48] ARM: pxa: stop using mach/bitfield.h
Date:   Tue, 19 Apr 2022 18:37:28 +0200
Message-Id: <20220419163810.2118169-7-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419163810.2118169-1-arnd@kernel.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are two identical copies of mach/bitfield.h, one for
mach-sa1100 and one for mach-pxa. The pxafb driver only
makes use of two macros, which can be trivially open-coded
in the header.

Cc: dri-devel@lists.freedesktop.org
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/idp.c                   | 1 -
 arch/arm/mach-pxa/include/mach/regs-lcd.h | 5 +++--
 arch/arm/mach-pxa/regs-u2d.h              | 2 --
 drivers/video/fbdev/pxafb.c               | 1 -
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index 57c0511472bc..525d01ddfbbb 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -30,7 +30,6 @@
 #include "pxa25x.h"
 #include "idp.h"
 #include <linux/platform_data/video-pxafb.h>
-#include <mach/bitfield.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/smc91x.h>
 
diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h b/arch/arm/mach-pxa/include/mach/regs-lcd.h
index e2b6e3d1f625..6a434675f84a 100644
--- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
+++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_ARCH_REGS_LCD_H
 #define __ASM_ARCH_REGS_LCD_H
 
-#include <mach/bitfield.h>
-
 /*
  * LCD Controller Registers and Bits Definitions
  */
@@ -86,6 +84,9 @@
 #define LCCR0_OUC	(1 << 25)	/* Overlay Underlay control bit */
 #define LCCR0_LDDALT	(1 << 26)	/* LDD alternate mapping control */
 
+#define Fld(Size, Shft)	(((Size) << 16) + (Shft))
+#define FShft(Field)	((Field) & 0x0000FFFF)
+
 #define LCCR1_PPL	Fld (10, 0)	/* Pixels Per Line - 1 */
 #define LCCR1_DisWdth(Pixel)	(((Pixel) - 1) << FShft (LCCR1_PPL))
 
diff --git a/arch/arm/mach-pxa/regs-u2d.h b/arch/arm/mach-pxa/regs-u2d.h
index fe4c80ad87ec..ab517ba62c9a 100644
--- a/arch/arm/mach-pxa/regs-u2d.h
+++ b/arch/arm/mach-pxa/regs-u2d.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_ARCH_PXA3xx_U2D_H
 #define __ASM_ARCH_PXA3xx_U2D_H
 
-#include <mach/bitfield.h>
-
 /*
  * USB2 device controller registers and bits definitions
  */
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index e3d1a184d2be..edf080f64a8c 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -64,7 +64,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/div64.h>
-#include <mach/bitfield.h>
 #include <linux/platform_data/video-pxafb.h>
 
 /*
-- 
2.29.2

