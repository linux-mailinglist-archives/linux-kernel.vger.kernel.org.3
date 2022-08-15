Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4D7592F86
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242752AbiHONNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242733AbiHONN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:13:27 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63EE712D3E;
        Mon, 15 Aug 2022 06:13:25 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id E19D48218;
        Mon, 15 Aug 2022 13:06:31 +0000 (UTC)
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
Subject: [PATCH 2/9] clocksource/drivers/timer-ti-dm: Simplify register reads with dmtimer_read()
Date:   Mon, 15 Aug 2022 16:12:43 +0300
Message-Id: <20220815131250.34603-3-tony@atomide.com>
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

We can simplify register read access by checking for the register write
posted mode in the read function. This way we can combine the functions
for __omap_dm_timer_read() and omap_dm_timer_read_reg() into a single
function dmtimer_read().

We update the shared register access first, the timer revision specific
register access will be updated in a later patch.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 88 ++++++++++++++-----------------
 1 file changed, 40 insertions(+), 48 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -44,14 +44,28 @@ enum {
 	REQUEST_BY_NODE,
 };
 
-static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
-						int posted)
+/**
+ * dmtimer_read - read timer registers in posted and non-posted mode
+ * @timer:	timer pointer over which read operation to perform
+ * @reg:	lowest byte holds the register offset
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode, write
+ * pending bit must be checked. Otherwise a read of a non completed write
+ * will produce an error.
+ */
+static inline u32 dmtimer_read(struct omap_dm_timer *timer, u32 reg)
 {
-	if (posted)
-		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
+	u16 wp, offset;
+
+	wp = reg >> WPSHIFT;
+	offset = reg & 0xff;
+
+	/* Wait for a possible write pending bit in posted mode */
+	if (wp && timer->posted)
+		while (readl_relaxed(timer->pend) & wp)
 			cpu_relax();
 
-	return readl_relaxed(timer->func_base + (reg & 0xff));
+	return readl_relaxed(timer->func_base + offset);
 }
 
 static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
@@ -121,13 +135,13 @@ static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
 {
 	u32 l;
 
-	l = __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (l & OMAP_TIMER_CTRL_ST) {
 		l &= ~0x1;
 		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
 #ifdef CONFIG_ARCH_OMAP2PLUS
 		/* Readback to make sure write has completed */
-		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+		dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 		/*
 		 * Wait for functional clock period x 3.5 to make sure that
 		 * timer is stopped
@@ -148,9 +162,9 @@ static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
 }
 
 static inline unsigned int
-__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
+__omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
-	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
+	return dmtimer_read(timer, OMAP_TIMER_COUNTER_REG);
 }
 
 static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
@@ -159,21 +173,6 @@ static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
 	writel_relaxed(value, timer->irq_stat);
 }
 
-/**
- * omap_dm_timer_read_reg - read timer registers in posted and non-posted mode
- * @timer:      timer pointer over which read operation to perform
- * @reg:        lowest byte holds the register offset
- *
- * The posted mode bit is encoded in reg. Note that in posted mode write
- * pending bit must be checked. Otherwise a read of a non completed write
- * will produce an error.
- */
-static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
-{
-	WARN_ON((reg & 0xff) < _OMAP_TIMER_WAKEUP_EN_OFFSET);
-	return __omap_dm_timer_read(timer, reg, timer->posted);
-}
-
 /**
  * omap_dm_timer_write_reg - write timer registers in posted and non-posted mode
  * @timer:      timer pointer over which write operation is to perform
@@ -213,20 +212,14 @@ static void omap_timer_restore_context(struct omap_dm_timer *timer)
 
 static void omap_timer_save_context(struct omap_dm_timer *timer)
 {
-	timer->context.ocp_cfg =
-		__omap_dm_timer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET, 0);
-
-	timer->context.tclr =
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	timer->context.twer =
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG);
-	timer->context.tldr =
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_LOAD_REG);
-	timer->context.tmar =
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_MATCH_REG);
+	timer->context.ocp_cfg = dmtimer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET);
+
+	timer->context.tclr = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+	timer->context.twer = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG);
+	timer->context.tldr = dmtimer_read(timer, OMAP_TIMER_LOAD_REG);
+	timer->context.tmar = dmtimer_read(timer, OMAP_TIMER_MATCH_REG);
 	timer->context.tier = readl_relaxed(timer->irq_ena);
-	timer->context.tsicr =
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_IF_CTRL_REG);
+	timer->context.tsicr = dmtimer_read(timer, OMAP_TIMER_IF_CTRL_REG);
 }
 
 static int omap_timer_context_notifier(struct notifier_block *nb,
@@ -266,8 +259,7 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 
 	do {
-		l = __omap_dm_timer_read(timer,
-					 OMAP_TIMER_V1_SYS_STAT_OFFSET, 0);
+		l = dmtimer_read(timer, OMAP_TIMER_V1_SYS_STAT_OFFSET);
 	} while (!l && timeout--);
 
 	if (!timeout) {
@@ -276,7 +268,7 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 	}
 
 	/* Configure timer for smart-idle mode */
-	l = __omap_dm_timer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET, 0);
+	l = dmtimer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET);
 	l |= 0x2 << 0x3;
 	__omap_dm_timer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET, l, 0);
 
@@ -550,7 +542,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 	list_for_each_entry(timer, &omap_timer_list, node) {
 		u32 l;
 
-		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+		l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 		if (l & OMAP_TIMER_CTRL_ST) {
 			if (((omap_readl(MOD_CONF_CTRL_1) >> (i * 2)) & 0x03) == 0)
 				inputmask &= ~(1 << 1);
@@ -591,7 +583,7 @@ static int omap_dm_timer_start(struct omap_dm_timer *timer)
 
 	omap_dm_timer_enable(timer);
 
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (!(l & OMAP_TIMER_CTRL_ST)) {
 		l |= OMAP_TIMER_CTRL_ST;
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
@@ -638,7 +630,7 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (enable)
 		l |= OMAP_TIMER_CTRL_CE;
 	else
@@ -659,7 +651,7 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
 	       OMAP_TIMER_CTRL_PT | (0x03 << 10) | OMAP_TIMER_CTRL_AR);
 	if (def_on)
@@ -683,7 +675,7 @@ static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	omap_dm_timer_disable(timer);
 
 	return l;
@@ -698,7 +690,7 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
 	if (prescaler >= 0) {
 		l |= OMAP_TIMER_CTRL_PRE;
@@ -743,7 +735,7 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 		l = readl_relaxed(timer->irq_ena) & ~mask;
 
 	writel_relaxed(l, timer->irq_dis);
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
+	l = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
 
 	omap_dm_timer_disable(timer);
@@ -781,7 +773,7 @@ static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 		return 0;
 	}
 
-	return __omap_dm_timer_read_counter(timer, timer->posted);
+	return __omap_dm_timer_read_counter(timer);
 }
 
 static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
-- 
2.37.1
