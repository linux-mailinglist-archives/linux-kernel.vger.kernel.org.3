Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EFD4CD53F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiCDNf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbiCDNfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:35:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E462D1B763C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646400898; x=1677936898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jti6Lf93/pkshsUoxGsmUk/NZEDKA40Cet1PtYYdvz4=;
  b=Uun02UYxsVxYivYMKpb82g6zKJoc3so64pkIYV5EkCEJj5PsyfpO4yNN
   Zbf2HTcXDQVwC/5fe9RwXaMzvjhOJMvYJVB+QybpXeJedRvACev1a6+kT
   2kOoHYImoormtFc4Supzn1K7BkUxnrzfD3fX+po1EnwfxhwCGFySE7BQl
   Tuyc6+nTp/O+Ghy+6mX4gY/OjFO76FYBk9Y95PIxey79cY01aZG+uHnzh
   LAQYdM1iclgnxAP4TDv4ps5O+9qnNuGnNHnBFWj71gqWjlB9XQSn6Ef4G
   KcgnAQlkNQbefpvNwfttMaNxvxXPdbBeqVlEz6CoCmpHh296gbKWxugCD
   A==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="148098685"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 06:34:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 06:34:58 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 06:34:56 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 3/6] clocksource/drivers/timer-microchip-pit64b: use 5MHz for clockevent
Date:   Fri, 4 Mar 2022 15:35:58 +0200
Message-ID: <20220304133601.2404086-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220304133601.2404086-1-claudiu.beznea@microchip.com>
References: <20220304133601.2404086-1-claudiu.beznea@microchip.com>
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

