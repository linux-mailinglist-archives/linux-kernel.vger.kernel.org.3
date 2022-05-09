Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C24B51F926
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbiEIJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiEIJII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:08:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D601D737D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652087053; x=1683623053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WM3JFuf+XYcullGR01eKGb7NQo6CAvDdzpgDWQsXV8g=;
  b=kPX4dKOfqtO/CoRb/NP6p3dWygLBnkyZ9uf/UxVZnWs5Ae/41zsdjrNK
   8ONa+UluSl3mIIhOHQN2IKQHPr8VAgofmAgJi0KlXhOC5urQI/kbbP8Bx
   aDQnj0XVUc50hnZke4NZpOAB+gQqMyXnY2M2D6+x/saTU4BatCABlGi6l
   t3jf/vf1m8j2tRWImhuEnc934Jg+rU0QjJwDPR8ZqtJMdP7PzbtuZVvOe
   HQLbI+tlt/x+UAttID29OZ92WRw+jeV9UkkuunS4TC/L4xdneeYR1GJHP
   +xptJ2X471Giw9j1QWkl4FRFPLQYg3HI4L7Q1D75rnFs7sjXnsrjWO4GN
   g==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="163213408"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 02:04:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 02:04:12 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 9 May 2022 02:04:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] clocksource/drivers/timer-microchip-pit64b: remove suspend/resume ops for ce
Date:   Mon, 9 May 2022 12:06:35 +0300
Message-ID: <20220509090637.4058399-2-claudiu.beznea@microchip.com>
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

Remove suspend and resume ops for clockevent and add set_state_oneshot()
instead. Along with this mchp_pit64b_{suspend, resume}() were called on
proper function to disable/enable clocks. This will allow disabling clocks
for clockevent in case it is not selected as active clockevent.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/timer-microchip-pit64b.c | 30 +++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index abce83d2f00b..b51259395ac3 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -173,7 +173,8 @@ static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
+	if (!clockevent_state_detached(cedev))
+		mchp_pit64b_suspend(timer);
 
 	return 0;
 }
@@ -182,35 +183,37 @@ static int mchp_pit64b_clkevt_set_periodic(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
+	if (clockevent_state_shutdown(cedev))
+		mchp_pit64b_resume(timer);
+
 	mchp_pit64b_reset(timer, mchp_pit64b_ce_cycles, MCHP_PIT64B_MR_CONT,
 			  MCHP_PIT64B_IER_PERIOD);
 
 	return 0;
 }
 
-static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
-					     struct clock_event_device *cedev)
+static int mchp_pit64b_clkevt_set_oneshot(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT,
+	if (clockevent_state_shutdown(cedev))
+		mchp_pit64b_resume(timer);
+
+	mchp_pit64b_reset(timer, mchp_pit64b_ce_cycles, MCHP_PIT64B_MR_ONE_SHOT,
 			  MCHP_PIT64B_IER_PERIOD);
 
 	return 0;
 }
 
-static void mchp_pit64b_clkevt_suspend(struct clock_event_device *cedev)
+static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
+					     struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	mchp_pit64b_suspend(timer);
-}
-
-static void mchp_pit64b_clkevt_resume(struct clock_event_device *cedev)
-{
-	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
+	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT,
+			  MCHP_PIT64B_IER_PERIOD);
 
-	mchp_pit64b_resume(timer);
+	return 0;
 }
 
 static irqreturn_t mchp_pit64b_interrupt(int irq, void *dev_id)
@@ -395,9 +398,8 @@ static int __init mchp_pit64b_init_clkevt(struct mchp_pit64b_timer *timer,
 	ce->clkevt.rating = 150;
 	ce->clkevt.set_state_shutdown = mchp_pit64b_clkevt_shutdown;
 	ce->clkevt.set_state_periodic = mchp_pit64b_clkevt_set_periodic;
+	ce->clkevt.set_state_oneshot = mchp_pit64b_clkevt_set_oneshot;
 	ce->clkevt.set_next_event = mchp_pit64b_clkevt_set_next_event;
-	ce->clkevt.suspend = mchp_pit64b_clkevt_suspend;
-	ce->clkevt.resume = mchp_pit64b_clkevt_resume;
 	ce->clkevt.cpumask = cpumask_of(0);
 	ce->clkevt.irq = irq;
 
-- 
2.34.1

