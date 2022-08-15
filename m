Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF13592F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbiHONOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242802AbiHONNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:13:52 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21CD91C10D;
        Mon, 15 Aug 2022 06:13:36 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 9580181D0;
        Mon, 15 Aug 2022 13:06:42 +0000 (UTC)
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
Subject: [PATCH 6/9] clocksource/drivers/timer-ti-dm: Use runtime PM directly and check errors
Date:   Mon, 15 Aug 2022 16:12:47 +0300
Message-Id: <20220815131250.34603-7-tony@atomide.com>
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

Use pm_runtime_resume_and_get() and check for a possible error returned.

We want to do this as omap_dm_timer_enable() and omap_dm_timer_disable()
are exposed to the pwm and remoteproc drivers, and in the following patch
we turn struct omap_dm_timer into a cookie used by the exposed functions
only.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 117 +++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 26 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -387,16 +387,24 @@ static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 
 static void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
-	pm_runtime_get_sync(&timer->pdev->dev);
+	struct device *dev = &timer->pdev->dev;
+	int rc;
+
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		dev_err(dev, "could not enable timer\n");
 }
 
 static void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
-	pm_runtime_put_sync(&timer->pdev->dev);
+	struct device *dev = &timer->pdev->dev;
+
+	pm_runtime_put_sync(dev);
 }
 
 static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
+	struct device *dev = &timer->pdev->dev;
 	int rc;
 
 	/*
@@ -411,18 +419,20 @@ static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 		}
 	}
 
-	omap_dm_timer_enable(timer);
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
 
 	if (timer->capability & OMAP_TIMER_NEEDS_RESET) {
 		rc = omap_dm_timer_reset(timer);
 		if (rc) {
-			omap_dm_timer_disable(timer);
+			pm_runtime_put_sync(dev);
 			return rc;
 		}
 	}
 
 	__omap_dm_timer_enable_posted(timer);
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
 
 	return 0;
 }
@@ -628,12 +638,16 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 static int omap_dm_timer_start(struct omap_dm_timer *timer)
 {
+	struct device *dev = &timer->pdev->dev;
+	int rc;
 	u32 l;
 
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
 
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (!(l & OMAP_TIMER_CTRL_ST)) {
@@ -646,6 +660,7 @@ static int omap_dm_timer_start(struct omap_dm_timer *timer)
 
 static int omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
+	struct device *dev = &timer->pdev->dev;
 	unsigned long rate = 0;
 
 	if (unlikely(!timer))
@@ -656,32 +671,47 @@ static int omap_dm_timer_stop(struct omap_dm_timer *timer)
 
 	__omap_dm_timer_stop(timer, rate);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
 static int omap_dm_timer_set_load(struct omap_dm_timer *timer,
 				  unsigned int load)
 {
+	struct device *dev;
+	int rc;
+
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	dmtimer_write(timer, OMAP_TIMER_LOAD_REG, load);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
 static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 				   unsigned int match)
 {
+	struct device *dev;
+	int rc;
 	u32 l;
 
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (enable)
 		l |= OMAP_TIMER_CTRL_CE;
@@ -690,19 +720,26 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	dmtimer_write(timer, OMAP_TIMER_MATCH_REG, match);
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
 static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 				 int toggle, int trigger, int autoreload)
 {
+	struct device *dev;
+	int rc;
 	u32 l;
 
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
 	       OMAP_TIMER_CTRL_PT | (0x03 << 10) | OMAP_TIMER_CTRL_AR);
@@ -715,20 +752,28 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 		l |= OMAP_TIMER_CTRL_AR;
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
 static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
 {
+	struct device *dev;
+	int rc;
 	u32 l;
 
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
-	omap_dm_timer_disable(timer);
+
+	pm_runtime_put_sync(dev);
 
 	return l;
 }
@@ -736,12 +781,18 @@ static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
 static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 					int prescaler)
 {
+	struct device *dev;
+	int rc;
 	u32 l;
 
 	if (unlikely(!timer) || prescaler < -1 || prescaler > 7)
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
 	if (prescaler >= 0) {
@@ -750,20 +801,29 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 	}
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
 static int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 					unsigned int value)
 {
+	struct device *dev;
+	int rc;
+
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	__omap_dm_timer_int_enable(timer, value);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
@@ -776,12 +836,17 @@ static int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
  */
 static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 {
+	struct device *dev;
 	u32 l = mask;
+	int rc;
 
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
 
 	if (timer->revision == 1)
 		l = dmtimer_read(timer, timer->irq_ena) & ~mask;
@@ -790,7 +855,8 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 	l = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
 	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
@@ -943,11 +1009,11 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	if (!timer->reserved) {
-		ret = pm_runtime_get_sync(dev);
-		if (ret < 0) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
 			dev_err(dev, "%s: pm_runtime_get_sync failed!\n",
 				__func__);
-			goto err_get_sync;
+			goto err_disable;
 		}
 		__omap_dm_timer_init_regs(timer);
 		pm_runtime_put(dev);
@@ -962,8 +1028,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_get_sync:
-	pm_runtime_put_noidle(dev);
+err_disable:
 	pm_runtime_disable(dev);
 	return ret;
 }
-- 
2.37.1
