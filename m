Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5357FB73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiGYIfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiGYIfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:35:36 -0400
Received: from out29-217.mail.aliyun.com (out29-217.mail.aliyun.com [115.124.29.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78EC14004
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:35:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437|-1;BR=01201311R231S26rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.118326-0.0259815-0.855693;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.Od487LD_1658738131;
Received: from SunxiBot.allwinnertech.com(mailfrom:victor@allwinnertech.com fp:SMTPD_---.Od487LD_1658738131)
          by smtp.aliyun-inc.com;
          Mon, 25 Jul 2022 16:35:32 +0800
From:   Victor Hassan <victor@allwinnertech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        allwinner-opensource-support@allwinnertech.com
Subject: [PATCH 1/2] clocksource: sun4i: Fix the bug that tick_resume stucks
Date:   Mon, 25 Jul 2022 16:35:21 +0800
Message-Id: <20220725083522.82931-1-victor@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently syscore_resume() will stuck on tick_resume().
Fix this by changing  `.tick_resume` from
sun4i_clkevt_shutdown() to a new function sun4i_tick_resume().

Signed-off-by: Victor Hassan <victor@allwinnertech.com>
---
 drivers/clocksource/timer-sun4i.c | 131 ++++++++++++++++++++++--------
 1 file changed, 96 insertions(+), 35 deletions(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index bb6ea6c19829..afc26de963af 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -38,6 +38,19 @@
 
 #define TIMER_SYNC_TICKS	3
 
+/* Registers which needs to be saved and restored before and after sleeping */
+static u32 sun4i_timer_regs_offset[] = {
+	TIMER_IRQ_EN_REG,
+	TIMER_CTL_REG(0),
+	TIMER_INTVAL_REG(0),
+	TIMER_CNTVAL_REG(0),
+	TIMER_CTL_REG(1),
+	TIMER_INTVAL_REG(1),
+	TIMER_CNTVAL_REG(1),
+};
+
+static void __iomem *sun4i_timer_sched_base __read_mostly;
+
 /*
  * When we disable a timer, we need to wait at least for 2 cycles of
  * the timer source clock. We will use for that the clocksource timer
@@ -79,10 +92,41 @@ static void sun4i_clkevt_time_start(void __iomem *base, u8 timer,
 	       base + TIMER_CTL_REG(timer));
 }
 
+static inline void sun4i_timer_save_regs(struct timer_of *to)
+{
+	void __iomem *base = timer_of_base(to);
+	int i;
+	u32 *regs_backup = (u32 *)to->private_data;
+
+	for (i = 0; i < ARRAY_SIZE(sun4i_timer_regs_offset); i++)
+		regs_backup[i] = readl(base + sun4i_timer_regs_offset[i]);
+}
+
+static inline void sun4i_timer_restore_regs(struct timer_of *to)
+{
+	void __iomem *base = timer_of_base(to);
+	int i;
+	u32 *regs_backup = (u32 *)to->private_data;
+
+	for (i = 0; i < ARRAY_SIZE(sun4i_timer_regs_offset); i++)
+		writel(regs_backup[i], base + sun4i_timer_regs_offset[i]);
+}
+
 static int sun4i_clkevt_shutdown(struct clock_event_device *evt)
 {
 	struct timer_of *to = to_timer_of(evt);
 
+	sun4i_timer_save_regs(to);
+	sun4i_clkevt_time_stop(timer_of_base(to), 0);
+
+	return 0;
+}
+
+static int sun4i_tick_resume(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+
+	sun4i_timer_restore_regs(to);
 	sun4i_clkevt_time_stop(timer_of_base(to), 0);
 
 	return 0;
@@ -137,45 +181,54 @@ static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct timer_of to = {
-	.flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
-
-	.clkevt = {
-		.name = "sun4i_tick",
-		.rating = 350,
-		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-		.set_state_shutdown = sun4i_clkevt_shutdown,
-		.set_state_periodic = sun4i_clkevt_set_periodic,
-		.set_state_oneshot = sun4i_clkevt_set_oneshot,
-		.tick_resume = sun4i_clkevt_shutdown,
-		.set_next_event = sun4i_clkevt_next_event,
-		.cpumask = cpu_possible_mask,
-	},
-
-	.of_irq = {
-		.handler = sun4i_timer_interrupt,
-		.flags = IRQF_TIMER | IRQF_IRQPOLL,
-	},
-};
+static void __init sun4i_clockevent_init(struct timer_of *to)
+{
+	to->clkevt.name = "sun4i_tick";
+	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	to->clkevt.set_state_shutdown = sun4i_clkevt_shutdown;
+	to->clkevt.set_state_periodic = sun4i_clkevt_set_periodic;
+	to->clkevt.set_state_oneshot = sun4i_clkevt_set_oneshot;
+	to->clkevt.tick_resume = sun4i_tick_resume;
+	to->clkevt.set_next_event = sun4i_clkevt_next_event;
+	to->clkevt.cpumask = cpu_possible_mask;
+	to->of_irq.flags = IRQF_TIMER | IRQF_IRQPOLL;
+
+	sun4i_timer_sched_base = timer_of_base(to) + TIMER_CNTVAL_REG(1);
+}
 
 static u64 notrace sun4i_timer_sched_read(void)
 {
-	return ~readl(timer_of_base(&to) + TIMER_CNTVAL_REG(1));
+	return (u64)~readl(sun4i_timer_sched_base);
 }
 
 static int __init sun4i_timer_init(struct device_node *node)
 {
+	struct timer_of *to;
 	int ret;
 	u32 val;
 
-	ret = timer_of_init(node, &to);
+	to = kzalloc(sizeof(*to), GFP_KERNEL);
+	if (!to)
+		return -ENOMEM;
+
+	to->flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE;
+	to->of_irq.handler = sun4i_timer_interrupt;
+	ret = timer_of_init(node, to);
 	if (ret)
-		return ret;
+		goto err;
 
-	writel(~0, timer_of_base(&to) + TIMER_INTVAL_REG(1));
+	sun4i_clockevent_init(to);
+
+	to->private_data = kcalloc(ARRAY_SIZE(sun4i_timer_regs_offset), sizeof(u32), GFP_KERNEL);
+	if (!to->private_data) {
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	writel(~0, timer_of_base(to) + TIMER_INTVAL_REG(1));
 	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD |
 	       TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
-	       timer_of_base(&to) + TIMER_CTL_REG(1));
+	       timer_of_base(to) + TIMER_CTL_REG(1));
 
 	/*
 	 * sched_clock_register does not have priorities, and on sun6i and
@@ -186,32 +239,40 @@ static int __init sun4i_timer_init(struct device_node *node)
 	    of_machine_is_compatible("allwinner,sun5i-a10s") ||
 	    of_machine_is_compatible("allwinner,suniv-f1c100s"))
 		sched_clock_register(sun4i_timer_sched_read, 32,
-				     timer_of_rate(&to));
+				     timer_of_rate(to));
 
-	ret = clocksource_mmio_init(timer_of_base(&to) + TIMER_CNTVAL_REG(1),
-				    node->name, timer_of_rate(&to), 350, 32,
+	ret = clocksource_mmio_init(timer_of_base(to) + TIMER_CNTVAL_REG(1),
+				    node->name, timer_of_rate(to), 350, 32,
 				    clocksource_mmio_readl_down);
 	if (ret) {
 		pr_err("Failed to register clocksource\n");
-		return ret;
+		goto err2;
 	}
 
 	writel(TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
-	       timer_of_base(&to) + TIMER_CTL_REG(0));
+	       timer_of_base(to) + TIMER_CTL_REG(0));
 
 	/* Make sure timer is stopped before playing with interrupts */
-	sun4i_clkevt_time_stop(timer_of_base(&to), 0);
+	sun4i_clkevt_time_stop(timer_of_base(to), 0);
 
 	/* clear timer0 interrupt */
-	sun4i_timer_clear_interrupt(timer_of_base(&to));
+	sun4i_timer_clear_interrupt(timer_of_base(to));
 
-	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
 					TIMER_SYNC_TICKS, 0xffffffff);
 
 	/* Enable timer0 interrupt */
-	val = readl(timer_of_base(&to) + TIMER_IRQ_EN_REG);
-	writel(val | TIMER_IRQ_EN(0), timer_of_base(&to) + TIMER_IRQ_EN_REG);
+	val = readl(timer_of_base(to) + TIMER_IRQ_EN_REG);
+	writel(val | TIMER_IRQ_EN(0), timer_of_base(to) + TIMER_IRQ_EN_REG);
+
+	return ret;
 
+err2:
+	kfree(to->private_data);
+err1:
+	timer_of_cleanup(to);
+err:
+	kfree(to);
 	return ret;
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
-- 
2.29.0

