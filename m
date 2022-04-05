Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5824F3E54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359284AbiDEOEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbiDEJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B5EAB;
        Tue,  5 Apr 2022 02:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09F28B81BBF;
        Tue,  5 Apr 2022 09:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB253C385A6;
        Tue,  5 Apr 2022 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150307;
        bh=7bz3/9lFuVh6UBeyajoRrHQp8fJ3tuWsYxqwUL9XLow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdzemasPpcRVHcsYcZB862RJF3oi/0MUX3sF8g6zofH5KtbGNamY8KXBIXdD+lVvu
         hCqN9ILnauBlXEobsF+MtOlREhVk9UB9sVFHTVIogKQ4JY78BzxxsC9NHGRB8p5D5L
         WsfKgBz7VRvgTzcEi19R16cXvOb6gEGG73+bgNJKoRQ09voQ7U3oeTnacCsGiIakvl
         4LB+tz3rJGq3TApbKnVSHrmzH6a7vIEKkkUKopN0ZDizh9wHvhmcNQ2ZJfVcvJP4Li
         P1L/DojopvMD6vvAyaQJr8eKyQt+pDJPJdEd9H0BYqKEwnUERtZ4sFlNRhni2l9pp9
         FgKsZecnF29Jg==
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
Subject: [PATCH 04/12] ARM: ep93xx: make mach/ep93xx-regs.h local
Date:   Tue,  5 Apr 2022 11:17:42 +0200
Message-Id: <20220405091750.3076973-5-arnd@kernel.org>
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

Nothing relies on it outside of arch/arm/mach-ep93xx/, so just move
it there.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ep93xx/{include/mach => }/ep93xx-regs.h | 4 ----
 arch/arm/mach-ep93xx/gpio-ep93xx.h                    | 2 +-
 arch/arm/mach-ep93xx/include/mach/uncompress.h        | 1 -
 arch/arm/mach-ep93xx/soc.h                            | 2 +-
 4 files changed, 2 insertions(+), 7 deletions(-)
 rename arch/arm/mach-ep93xx/{include/mach => }/ep93xx-regs.h (94%)

diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/ep93xx-regs.h
similarity index 94%
rename from arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
rename to arch/arm/mach-ep93xx/ep93xx-regs.h
index 6839ea032e58..8fa3646de0a4 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/ep93xx-regs.h
@@ -1,8 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
- */
-
 #ifndef __ASM_ARCH_EP93XX_REGS_H
 #define __ASM_ARCH_EP93XX_REGS_H
 
diff --git a/arch/arm/mach-ep93xx/gpio-ep93xx.h b/arch/arm/mach-ep93xx/gpio-ep93xx.h
index 242af4a401ea..7b46eb7e5507 100644
--- a/arch/arm/mach-ep93xx/gpio-ep93xx.h
+++ b/arch/arm/mach-ep93xx/gpio-ep93xx.h
@@ -4,7 +4,7 @@
 #ifndef __GPIO_EP93XX_H
 #define __GPIO_EP93XX_H
 
-#include <mach/ep93xx-regs.h>
+#include "ep93xx-regs.h"
 
 #define EP93XX_GPIO_PHYS_BASE		EP93XX_APB_PHYS(0x00040000)
 #define EP93XX_GPIO_BASE		EP93XX_APB_IOMEM(0x00040000)
diff --git a/arch/arm/mach-ep93xx/include/mach/uncompress.h b/arch/arm/mach-ep93xx/include/mach/uncompress.h
index b3ec1db988db..e20bcab702b2 100644
--- a/arch/arm/mach-ep93xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ep93xx/include/mach/uncompress.h
@@ -5,7 +5,6 @@
  * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
  */
 
-#include <mach/ep93xx-regs.h>
 #include <asm/mach-types.h>
 
 static unsigned char __raw_readb(unsigned int ptr)
diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
index f0986e288d19..3245ebbd5069 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -9,7 +9,7 @@
 #ifndef _EP93XX_SOC_H
 #define _EP93XX_SOC_H
 
-#include <mach/ep93xx-regs.h>
+#include "ep93xx-regs.h"
 #include "irqs.h"
 
 /*
-- 
2.29.2

