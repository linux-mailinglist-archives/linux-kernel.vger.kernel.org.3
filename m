Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1346F4C8BB3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiCAMez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbiCAMej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:34:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77B295A30
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646138040; x=1677674040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=43qiS6l/WyBCSmUqkK2jh3Y6sKNvcyLpeI6tzHqMrPE=;
  b=Il6yuQ1elDuFTze4gx8Qhb8rCShd5ZWQv6KblkEkGwrEDpV1sXWPSiAh
   qiiokYSlmKVAFKspA8yeEr18Iqxuk03t/JscRfW4Yffhtfr6QR95+NTEJ
   c+BqVKOSJee/v7ggXhSJXMae2QHGlYzzJvVnmvhgalT62zqfTjmFw6wFA
   peszpYVYVUFkr1kc5rDcWephHM7HMGmOl0hyQ3rB1WFPxMokXkwl6ceLz
   8tt4lndBjat7sc7LEGHxkVG1JNrUJ7enb5C9e4qRY/Y5hubgJU+L93YOL
   woSILsw+7gaiMT1oRhdsbQoGq/IkndZbl17fEtggyudYAMsOJlnRjNHbg
   A==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643698800"; 
   d="scan'208";a="147642347"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2022 05:34:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 1 Mar 2022 05:33:58 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 1 Mar 2022 05:33:56 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 6/7] clocksource/drivers/timer-microchip-pit64b: use mchp_pit64b_{suspend, resume}
Date:   Tue, 1 Mar 2022 14:34:48 +0200
Message-ID: <20220301123449.2816625-7-claudiu.beznea@microchip.com>
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
2.32.0

