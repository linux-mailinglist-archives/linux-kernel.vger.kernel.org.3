Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B86C4C8BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiCAMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbiCAMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:34:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964489681F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646138035; x=1677674035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jti6Lf93/pkshsUoxGsmUk/NZEDKA40Cet1PtYYdvz4=;
  b=X1JMbmD6swKofxwq1wnJmHZ8Fk/qyFUgZF6nkGEzVM4VG5Oi84n+E5/m
   5n2KihTMTRz0k8TFYcDvloGM6eOXXFasb3p//RAoMAYNGw3oNCZIOfE7j
   /NoCBQ8LdppABbZ6HLw7Bkd+5Gd4S3ZgTtVRyL9k8jsbMWzRJ2PlfWoaG
   t2p92ZASH2f4QSHisBQYeUeIrGqrp32bi2eOWN6B2hADhNsgSzqT/oX96
   pszoTne9YaqcGy1qMs9GxdP9KTYgjcEOT9lINxJcAsZhOWNx6S8grs6Cc
   W8aH0oJrC8cwV2dxQN4U3GRS8mQ65UjM8apxNMSFFLKn/YGgLetPhQRit
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643698800"; 
   d="scan'208";a="150385102"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2022 05:33:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 1 Mar 2022 05:33:54 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 1 Mar 2022 05:33:53 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/7] clocksource/drivers/timer-microchip-pit64b: use 5MHz for clockevent
Date:   Tue, 1 Mar 2022 14:34:46 +0200
Message-ID: <20220301123449.2816625-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220301123449.2816625-1-claudiu.beznea@microchip.com>
References: <20220301123449.2816625-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 5MHz clock for clockevent timers. This increases timer's
resolution.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/timer-microchip-pit64b.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index 790d2c9b42a7..abce83d2f00b 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -42,8 +42,7 @@
 #define MCHP_PIT64B_LSBMASK		GENMASK_ULL(31, 0)
 #define MCHP_PIT64B_PRES_TO_MODE(p)	(MCHP_PIT64B_MR_PRES & ((p) << 8))
 #define MCHP_PIT64B_MODE_TO_PRES(m)	((MCHP_PIT64B_MR_PRES & (m)) >> 8)
-#define MCHP_PIT64B_DEF_CS_FREQ		5000000UL	/* 5 MHz */
-#define MCHP_PIT64B_DEF_CE_FREQ		32768		/* 32 KHz */
+#define MCHP_PIT64B_DEF_FREQ		5000000UL	/* 5 MHz */
 
 #define MCHP_PIT64B_NAME		"pit64b"
 
@@ -418,7 +417,6 @@ static int __init mchp_pit64b_init_clkevt(struct mchp_pit64b_timer *timer,
 static int __init mchp_pit64b_dt_init_timer(struct device_node *node,
 					    bool clkevt)
 {
-	u32 freq = clkevt ? MCHP_PIT64B_DEF_CE_FREQ : MCHP_PIT64B_DEF_CS_FREQ;
 	struct mchp_pit64b_timer timer;
 	unsigned long clk_rate;
 	u32 irq = 0;
@@ -446,7 +444,7 @@ static int __init mchp_pit64b_dt_init_timer(struct device_node *node,
 	}
 
 	/* Initialize mode (prescaler + SGCK bit). To be used at runtime. */
-	ret = mchp_pit64b_init_mode(&timer, freq);
+	ret = mchp_pit64b_init_mode(&timer, MCHP_PIT64B_DEF_FREQ);
 	if (ret)
 		goto irq_unmap;
 
-- 
2.32.0

