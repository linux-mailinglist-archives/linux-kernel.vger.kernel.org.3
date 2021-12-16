Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FA3477402
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbhLPOLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:11:31 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:10939 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbhLPOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639663889; x=1671199889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Cn32FVsFXj7kfAuzJ2kdL23yH/APr88N4Syy5Ekn8OM=;
  b=eyeJFPQDyPJd3HHTMpXpD4QCGvBK+u86+KskR+rUTzuVn6hmvGIw5fJ4
   Qr5o8TaK8hto5R0OfW1H2GqezReCutr7v9PWOnHTS6/Empb/cMEfsowKt
   +BEQbJTun/X5IAFsyPnH+eagOA8NK7KwkqRFqSbZSFoeXZXNpd00EOfZy
   ILwKbeVOZk/Ss3aOpb3dk/jDSQlHN6hRJahm8pcscoi9fghpfnJ+p638o
   Gl1Wx2PBWNlM/ogRBjG0O7GPZlFTDrItf4Xzh1I+vIbRDrweVYvGyfBGw
   B3C+PQPJsUdhpUFO35cRd7G3TFElWIMf9iJphC442nHbkubvVfjW1EwdU
   A==;
IronPort-SDR: 6hpipkpsGy1eUV4LY0tRSeT+Vo5RQrrGtrB01+f9j4W8WkpaXasP9jEgVzJo9r/ZZL/r3StRWn
 bZNttU9TS2p6YGGj1BNkvJSkeXcQZHBRyLGGSS2vIcHQrosbR8i5tylctMkjYIaWIMbmKp3vn2
 RLR19yArvbnW/+lBPtgj0zUs7/BHLownkqw6ukWWx0wWkiQ3Pu7XwNB03XA6OM7Shi4UHbhO+m
 wpJGDGP1i4kl7E2783ulH7p/Uj0FocybyfBTHHXP6D3fpL5/YS2tT6UrfLXnMnNMfbeJV5YVG2
 9UuwZqMpRAgLaTl/PZBX/frA
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="147461397"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2021 07:11:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 07:11:28 -0700
Received: from rob-dk-mpu02.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Dec 2021 07:11:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] ARM: at91: ddr: remove CONFIG_SOC_SAMA7 dependency
Date:   Thu, 16 Dec 2021 16:13:31 +0200
Message-ID: <20211216141338.35144-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216141338.35144-1-claudiu.beznea@microchip.com>
References: <20211216141338.35144-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_SOC_SAMA7 dependency to avoid having #ifdef preprocessor
directives in driver code (arch/arm/mach-at91/pm.c). This prepares the
code for next commits.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/soc/at91/sama7-ddr.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/soc/at91/sama7-ddr.h b/include/soc/at91/sama7-ddr.h
index f6542584ca13..13b47e26cdbe 100644
--- a/include/soc/at91/sama7-ddr.h
+++ b/include/soc/at91/sama7-ddr.h
@@ -11,8 +11,6 @@
 #ifndef __SAMA7_DDR_H__
 #define __SAMA7_DDR_H__
 
-#ifdef CONFIG_SOC_SAMA7
-
 /* DDR3PHY */
 #define DDR3PHY_PIR				(0x04)		/* DDR3PHY PHY Initialization Register	*/
 #define	DDR3PHY_PIR_DLLBYP		(1 << 17)	/* DLL Bypass */
@@ -75,6 +73,4 @@
 #define UDDRC_PCTRL_3				(0x6A0)		/* UDDRC Port 3 Control Register */
 #define UDDRC_PCTRL_4				(0x750)		/* UDDRC Port 4 Control Register */
 
-#endif /* CONFIG_SOC_SAMA7 */
-
 #endif /* __SAMA7_DDR_H__ */
-- 
2.32.0

