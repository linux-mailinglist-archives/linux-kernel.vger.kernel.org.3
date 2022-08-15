Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543AF592F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242772AbiHONNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbiHONNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:13:37 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA8B91901E;
        Mon, 15 Aug 2022 06:13:30 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 672F180FB;
        Mon, 15 Aug 2022 13:06:37 +0000 (UTC)
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
Subject: [PATCH 4/9] clocksource/drivers/timer-ti-dm: Simplify register access further
Date:   Mon, 15 Aug 2022 16:12:45 +0300
Message-Id: <20220815131250.34603-5-tony@atomide.com>
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

Let's unify register access and use dmtimer_read() and dmtimer_write()
also for the timer revision specific registers like we now do for the
shread registers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 28 ++++++++++++++--------------
 include/clocksource/timer-ti-dm.h |  6 +++---
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -101,16 +101,16 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
 	tidr = readl_relaxed(timer->io_base);
 	if (!(tidr >> 16)) {
 		timer->revision = 1;
-		timer->irq_stat = timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
-		timer->irq_ena = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
-		timer->irq_dis = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->irq_stat = OMAP_TIMER_V1_STAT_OFFSET;
+		timer->irq_ena = OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->irq_dis = OMAP_TIMER_V1_INT_EN_OFFSET;
 		timer->pend = timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
 		timer->func_base = timer->io_base;
 	} else {
 		timer->revision = 2;
-		timer->irq_stat = timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
-		timer->irq_ena = timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
-		timer->irq_dis = timer->io_base + OMAP_TIMER_V2_IRQENABLE_CLR;
+		timer->irq_stat = OMAP_TIMER_V2_IRQSTATUS - OMAP_TIMER_V2_FUNC_OFFSET;
+		timer->irq_ena = OMAP_TIMER_V2_IRQENABLE_SET - OMAP_TIMER_V2_FUNC_OFFSET;
+		timer->irq_dis = OMAP_TIMER_V2_IRQENABLE_CLR - OMAP_TIMER_V2_FUNC_OFFSET;
 		timer->pend = timer->io_base +
 			_OMAP_TIMER_WRITE_PEND_OFFSET +
 				OMAP_TIMER_V2_FUNC_OFFSET;
@@ -165,13 +165,13 @@ static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
 	}
 
 	/* Ack possibly pending interrupt */
-	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
+	dmtimer_write(timer, timer->irq_stat, OMAP_TIMER_INT_OVERFLOW);
 }
 
 static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
 						unsigned int value)
 {
-	writel_relaxed(value, timer->irq_ena);
+	dmtimer_write(timer, timer->irq_ena, value);
 	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value);
 }
 
@@ -184,7 +184,7 @@ __omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
 						unsigned int value)
 {
-	writel_relaxed(value, timer->irq_stat);
+	dmtimer_write(timer, timer->irq_stat, value);
 }
 
 static void omap_timer_restore_context(struct omap_dm_timer *timer)
@@ -196,7 +196,7 @@ static void omap_timer_restore_context(struct omap_dm_timer *timer)
 	dmtimer_write(timer, OMAP_TIMER_LOAD_REG, timer->context.tldr);
 	dmtimer_write(timer, OMAP_TIMER_MATCH_REG, timer->context.tmar);
 	dmtimer_write(timer, OMAP_TIMER_IF_CTRL_REG, timer->context.tsicr);
-	writel_relaxed(timer->context.tier, timer->irq_ena);
+	dmtimer_write(timer, timer->irq_ena, timer->context.tier);
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, timer->context.tclr);
 }
 
@@ -208,7 +208,7 @@ static void omap_timer_save_context(struct omap_dm_timer *timer)
 	timer->context.twer = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG);
 	timer->context.tldr = dmtimer_read(timer, OMAP_TIMER_LOAD_REG);
 	timer->context.tmar = dmtimer_read(timer, OMAP_TIMER_MATCH_REG);
-	timer->context.tier = readl_relaxed(timer->irq_ena);
+	timer->context.tier = dmtimer_read(timer, timer->irq_ena);
 	timer->context.tsicr = dmtimer_read(timer, OMAP_TIMER_IF_CTRL_REG);
 }
 
@@ -722,9 +722,9 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 	omap_dm_timer_enable(timer);
 
 	if (timer->revision == 1)
-		l = readl_relaxed(timer->irq_ena) & ~mask;
+		l = dmtimer_read(timer, timer->irq_ena) & ~mask;
 
-	writel_relaxed(l, timer->irq_dis);
+	dmtimer_write(timer, timer->irq_dis, l);
 	l = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
 	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
 
@@ -741,7 +741,7 @@ static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 		return 0;
 	}
 
-	l = readl_relaxed(timer->irq_stat);
+	l = dmtimer_read(timer, timer->irq_stat);
 
 	return l;
 }
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -100,9 +100,9 @@ struct omap_dm_timer {
 	struct clk *fclk;
 
 	void __iomem	*io_base;
-	void __iomem	*irq_stat;	/* TISR/IRQSTATUS interrupt status */
-	void __iomem	*irq_ena;	/* irq enable */
-	void __iomem	*irq_dis;	/* irq disable, only on v2 ip */
+	int		irq_stat;	/* TISR/IRQSTATUS interrupt status */
+	int		irq_ena;	/* irq enable */
+	int		irq_dis;	/* irq disable, only on v2 ip */
 	void __iomem	*pend;		/* write pending */
 	void __iomem	*func_base;	/* function register base */
 
-- 
2.37.1
