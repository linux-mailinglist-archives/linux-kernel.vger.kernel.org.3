Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC02851F825
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiEIJcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbiEIJIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:08:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218391E0129
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652087057; x=1683623057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uJ5qZvhAQ1nIadAE2aDvP4HNyjdst+87wL1ry98HR+g=;
  b=TTQE5H/ojbLfiZHlqnSuMd1x3NrB/hvVM+QWiqu2JsZSiRg3jkGkwlgs
   87SuonrdY3QfqwOl5Nn5IkSSUNkzAYZfucnmCM38qUx8kJVA6yErwuYYM
   C79Gqv2dcXW27pqSkfEwbsXc7dr1I/bIrQNicoCaMIUVIjTlb0FhzrFLj
   eWKGY1EHE3KlUsRZAEN/Ydaaxu/OxU0Z9SwTlTLLWvL8+Jo2HhpKKwLjj
   LK58Hz5ZLZzDhcV3DYAQ8TfXAPIUll1vxS7iJE76JCz6B7sH/Ifr5o8vp
   J0rj7tDVsSwALCxvI8tqt0N2zx1tBquzPy9R9fTyE1qRNzDqgUHMYqqxy
   g==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="158261278"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 02:04:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 02:04:15 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 9 May 2022 02:04:14 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] clocksource/drivers/timer-microchip-pit64b: fix compilation warnings
Date:   Mon, 9 May 2022 12:06:37 +0300
Message-ID: <20220509090637.4058399-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220509090637.4058399-1-claudiu.beznea@microchip.com>
References: <20220509090637.4058399-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.34.1

