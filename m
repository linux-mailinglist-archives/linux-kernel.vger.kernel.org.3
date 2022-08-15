Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36801592F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242866AbiHONOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242826AbiHONOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:14:12 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFFF61CB16;
        Mon, 15 Aug 2022 06:13:43 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 84FA78225;
        Mon, 15 Aug 2022 13:06:50 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 9/9] clocksource/drivers/timer-ti-dm: Get clock in probe with devm_clk_get()
Date:   Mon, 15 Aug 2022 16:12:50 +0300
Message-Id: <20220815131250.34603-10-tony@atomide.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815131250.34603-1-tony@atomide.com>
References: <20220815131250.34603-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can simplify the code a bit by getting the clock in probe, and using
devm_clk_get(). This will also make further changes easier as the clock
is available in probe instead of prepare.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -473,18 +473,6 @@ static int omap_dm_timer_prepare(struct dmtimer *timer)
 	struct device *dev = &timer->pdev->dev;
 	int rc;
 
-	/*
-	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
-	 * do not call clk_get() for these devices.
-	 */
-	if (!timer->omap1) {
-		timer->fclk = clk_get(&timer->pdev->dev, "fck");
-		if (WARN_ON_ONCE(IS_ERR(timer->fclk))) {
-			dev_err(&timer->pdev->dev, ": No fclk handle.\n");
-			return -EINVAL;
-		}
-	}
-
 	rc = pm_runtime_resume_and_get(dev);
 	if (rc)
 		return rc;
@@ -650,8 +638,6 @@ static int omap_dm_timer_free(struct omap_dm_timer *cookie)
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	clk_put(timer->fclk);
-
 	WARN_ON(!timer->reserved);
 	timer->reserved = 0;
 	return 0;
@@ -1098,7 +1084,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	if (timer->irq < 0)
 		return timer->irq;
 
-	timer->fclk = ERR_PTR(-ENODEV);
 	timer->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))
 		return PTR_ERR(timer->io_base);
@@ -1122,6 +1107,15 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 
 	timer->omap1 = timer->capability & OMAP_TIMER_NEEDS_RESET;
 
+	/* OMAP1 devices do not yet use the clock framework for dmtimers */
+	if (!timer->omap1) {
+		timer->fclk = devm_clk_get(dev, "fck");
+		if (IS_ERR(timer->fclk))
+			return PTR_ERR(timer->fclk);
+	} else {
+		timer->fclk = ERR_PTR(-ENODEV);
+	}
+
 	if (!(timer->capability & OMAP_TIMER_ALWON)) {
 		timer->nb.notifier_call = omap_timer_context_notifier;
 		cpu_pm_register_notifier(&timer->nb);
-- 
2.37.1
