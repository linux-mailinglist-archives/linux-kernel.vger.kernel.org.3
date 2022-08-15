Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F5592F92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiHONOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242807AbiHONOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:14:08 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B48A1AF06;
        Mon, 15 Aug 2022 06:13:41 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id EB9C880FB;
        Mon, 15 Aug 2022 13:06:47 +0000 (UTC)
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
Subject: [PATCH 8/9] clocksource/drivers/timer-ti-dm: Add flag to detect omap1
Date:   Mon, 15 Aug 2022 16:12:49 +0300
Message-Id: <20220815131250.34603-9-tony@atomide.com>
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

Let's make it clear that some features need to be tested currently on
omap1. Only omap1 still uses platform_data.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -133,6 +133,7 @@ struct dmtimer {
 	unsigned long rate;
 	unsigned reserved:1;
 	unsigned posted:1;
+	unsigned omap1:1;
 	struct timer_regs context;
 	int revision;
 	u32 capability;
@@ -423,7 +424,7 @@ static int omap_dm_timer_set_source(struct omap_dm_timer *cookie, int source)
 	 * use the clock framework to set the parent clock. To be removed
 	 * once OMAP1 migrated to using clock framework for dmtimers
 	 */
-	if (pdata && pdata->set_timer_src)
+	if (timer->omap1 && pdata && pdata->set_timer_src)
 		return pdata->set_timer_src(timer->pdev, source);
 
 #if defined(CONFIG_COMMON_CLK)
@@ -476,7 +477,7 @@ static int omap_dm_timer_prepare(struct dmtimer *timer)
 	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
 	 * do not call clk_get() for these devices.
 	 */
-	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
+	if (!timer->omap1) {
 		timer->fclk = clk_get(&timer->pdev->dev, "fck");
 		if (WARN_ON_ONCE(IS_ERR(timer->fclk))) {
 			dev_err(&timer->pdev->dev, ": No fclk handle.\n");
@@ -763,7 +764,7 @@ static int omap_dm_timer_stop(struct omap_dm_timer *cookie)
 
 	dev = &timer->pdev->dev;
 
-	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET))
+	if (!timer->omap1)
 		rate = clk_get_rate(timer->fclk);
 
 	__omap_dm_timer_stop(timer, rate);
@@ -1119,6 +1120,8 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
 	}
 
+	timer->omap1 = timer->capability & OMAP_TIMER_NEEDS_RESET;
+
 	if (!(timer->capability & OMAP_TIMER_ALWON)) {
 		timer->nb.notifier_call = omap_timer_context_notifier;
 		cpu_pm_register_notifier(&timer->nb);
-- 
2.37.1
