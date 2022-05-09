Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AF651F8A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiEIJgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbiEIJIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:08:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2165E1DFD99
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652087057; x=1683623057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MhR3GL37aD2094muc0mbYoEzyBnN3ng+SbxKNMGBHqU=;
  b=kfnDIQq6l5FAf068cePBn4mr0i3enrEiYE8d8flSbLsmP97+2HLUi4y4
   urpqrg8lLUnvxDME1H+lwbW2RxlESaQf2oMiGWQbc/mjqzc7Qd5G5zOak
   2rfdvn9YxmAiqcCFbUNc1kwIaDY3Jphlk2PdWWri4Ut/jge1npN61zNQ6
   tuTn9EpGldHKaR831aY4F/3/mwYfNnlr43Ytpiizc+flYfe0ZB1HjphY2
   fVqkOQDKIOP+hswhhltGG1TiijtV0jmhjzc488uVTEVDgsKu+WAiqsspM
   +tL+r6oYLCv5OAVZScM6FoTpSFZSJfYCyl7X9bmK9ygtbjrHCcCDy2sl5
   w==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="163213415"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 02:04:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 02:04:14 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 9 May 2022 02:04:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] clocksource/drivers/timer-microchip-pit64b: use mchp_pit64b_{suspend, resume}
Date:   Mon, 9 May 2022 12:06:36 +0300
Message-ID: <20220509090637.4058399-3-claudiu.beznea@microchip.com>
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

Use mchp_pit64b_suspend() and mchp_pit64b_resume() to disable or
enable timers clocks on init and remove specific
clk_prepare_{disable, enable} calls. This is ok also for clockevent timer
as proper clock enable, disable is done on .set_state_oneshot,
.set_state_periodic, .set_state_shutdown calls.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/timer-microchip-pit64b.c | 24 ++++----------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index b51259395ac3..f50705698283 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -344,6 +344,7 @@ static int __init mchp_pit64b_init_clksrc(struct mchp_pit64b_timer *timer,
 	if (!cs)
 		return -ENOMEM;
 
+	mchp_pit64b_resume(timer);
 	mchp_pit64b_reset(timer, ULLONG_MAX, MCHP_PIT64B_MR_CONT, 0);
 
 	mchp_pit64b_cs_base = timer->base;
@@ -365,8 +366,7 @@ static int __init mchp_pit64b_init_clksrc(struct mchp_pit64b_timer *timer,
 		pr_debug("clksrc: Failed to register PIT64B clocksource!\n");
 
 		/* Stop timer. */
-		writel_relaxed(MCHP_PIT64B_CR_SWRST,
-			       timer->base + MCHP_PIT64B_CR);
+		mchp_pit64b_suspend(timer);
 		kfree(cs);
 
 		return ret;
@@ -450,19 +450,10 @@ static int __init mchp_pit64b_dt_init_timer(struct device_node *node,
 	if (ret)
 		goto irq_unmap;
 
-	ret = clk_prepare_enable(timer.pclk);
-	if (ret)
-		goto irq_unmap;
-
-	if (timer.mode & MCHP_PIT64B_MR_SGCLK) {
-		ret = clk_prepare_enable(timer.gclk);
-		if (ret)
-			goto pclk_unprepare;
-
+	if (timer.mode & MCHP_PIT64B_MR_SGCLK)
 		clk_rate = clk_get_rate(timer.gclk);
-	} else {
+	else
 		clk_rate = clk_get_rate(timer.pclk);
-	}
 	clk_rate = clk_rate / (MCHP_PIT64B_MODE_TO_PRES(timer.mode) + 1);
 
 	if (clkevt)
@@ -471,15 +462,10 @@ static int __init mchp_pit64b_dt_init_timer(struct device_node *node,
 		ret = mchp_pit64b_init_clksrc(&timer, clk_rate);
 
 	if (ret)
-		goto gclk_unprepare;
+		goto irq_unmap;
 
 	return 0;
 
-gclk_unprepare:
-	if (timer.mode & MCHP_PIT64B_MR_SGCLK)
-		clk_disable_unprepare(timer.gclk);
-pclk_unprepare:
-	clk_disable_unprepare(timer.pclk);
 irq_unmap:
 	irq_dispose_mapping(irq);
 io_unmap:
-- 
2.34.1

