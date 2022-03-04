Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA54CD540
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiCDNgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbiCDNfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:35:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2191B7628
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646400904; x=1677936904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dv6XZw7MTimKroGEiXxdz6uCuJezFLvNvuWwMNpKKvM=;
  b=MBGeeYgPRwE3P14QTbGmyq5QMenBbujOcQmzdaRXfrfN9y8WtWM4gQuK
   2NC8yDp0aHbMU9AwNxJSF957KrcdJg0E6sUoCkYX24TlJdKOpjor/XC/j
   yoFT98IpAYtZxhiaJPvmXTCCrOoyXynV4PD+gIVMQX/A4dzja3vRK+zjH
   2O7Zq/9tAdJ/KdudlSgBuzFNhxzgg9kHzGA7qXmDeUAzwRzMVDOsXQuy8
   x/BQkagK9MHHhodoJTFLmE/4eylmb8CvCwsXZ4NDetQrbJGOqovdGwoRf
   QkdFmZLGVhMyODSp3PH+iBWzGEFd7l+/+SerGRDwWxuJ/MV/zr6jNC9cE
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="87833845"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 06:35:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 06:35:03 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 06:35:02 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 6/6] clocksource/drivers/timer-microchip-pit64b: fix compilation warnings
Date:   Fri, 4 Mar 2022 15:36:01 +0200
Message-ID: <20220304133601.2404086-7-claudiu.beznea@microchip.com>
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

Fix the following compilation warnings:
timer-microchip-pit64b.c:68: warning: cannot understand function prototype: 'struct mchp_pit64b_clkevt '
timer-microchip-pit64b.c:82: warning: cannot understand function prototype: 'struct mchp_pit64b_clksrc '
timer-microchip-pit64b.c:283: warning: Function parameter or member 'timer' not described in 'mchp_pit64b_init_mode'
timer-microchip-pit64b.c:283: warning: Function parameter or member 'max_rate' not described in 'mchp_pit64b_init_mode'

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/timer-microchip-pit64b.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index f50705698283..d5f1436f33d9 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -61,7 +61,7 @@ struct mchp_pit64b_timer {
 };
 
 /**
- * mchp_pit64b_clkevt - PIT64B clockevent data structure
+ * struct mchp_pit64b_clkevt - PIT64B clockevent data structure
  * @timer: PIT64B timer
  * @clkevt: clockevent
  */
@@ -75,7 +75,7 @@ struct mchp_pit64b_clkevt {
 		struct mchp_pit64b_clkevt, clkevt))
 
 /**
- * mchp_pit64b_clksrc - PIT64B clocksource data structure
+ * struct mchp_pit64b_clksrc - PIT64B clocksource data structure
  * @timer: PIT64B timer
  * @clksrc: clocksource
  */
@@ -245,8 +245,10 @@ static void __init mchp_pit64b_pres_compute(u32 *pres, u32 clk_rate,
 }
 
 /**
- * mchp_pit64b_init_mode - prepare PIT64B mode register value to be used at
- *			   runtime; this includes prescaler and SGCLK bit
+ * mchp_pit64b_init_mode() - prepare PIT64B mode register value to be used at
+ *			     runtime; this includes prescaler and SGCLK bit
+ * @timer: pointer to pit64b timer to init
+ * @max_rate: maximum rate that timer's clock could use
  *
  * PIT64B timer may be fed by gclk or pclk. When gclk is used its rate has to
  * be at least 3 times lower that pclk's rate. pclk rate is fixed, gclk rate
-- 
2.32.0

