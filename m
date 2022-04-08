Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF47B4F92C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiDHKTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiDHKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:19:30 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29FCC50074;
        Fri,  8 Apr 2022 03:17:27 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 9D3B48131;
        Fri,  8 Apr 2022 10:15:00 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/3] clocksource/drivers/timer-ti-dm: Move inline functions to driver for am6
Date:   Fri,  8 Apr 2022 13:17:13 +0300
Message-Id: <20220408101715.43697-2-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408101715.43697-1-tony@atomide.com>
References: <20220408101715.43697-1-tony@atomide.com>
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

The __omap_dm_timer_* inline functions in the header are no longer needed
outside the driver, and the header ifdefs prevent the driver working for
ARCH_K3.

Let's move the inline functions to the driver and drop the ifdefs and
drop the unused functions __omap_dm_timer_override_errata() and
__omap_dm_timer_load_start().

Cc: Keerthy <j-keerthy@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 115 ++++++++++++++++++++++++
 include/clocksource/timer-ti-dm.h | 144 ------------------------------
 2 files changed, 115 insertions(+), 144 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -44,6 +44,121 @@ enum {
 	REQUEST_BY_NODE,
 };
 
+static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
+						int posted)
+{
+	if (posted)
+		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
+			cpu_relax();
+
+	return readl_relaxed(timer->func_base + (reg & 0xff));
+}
+
+static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
+					u32 reg, u32 val, int posted)
+{
+	if (posted)
+		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
+			cpu_relax();
+
+	writel_relaxed(val, timer->func_base + (reg & 0xff));
+}
+
+static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
+{
+	u32 tidr;
+
+	/* Assume v1 ip if bits [31:16] are zero */
+	tidr = readl_relaxed(timer->io_base);
+	if (!(tidr >> 16)) {
+		timer->revision = 1;
+		timer->irq_stat = timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
+		timer->irq_ena = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->irq_dis = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->pend = timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
+		timer->func_base = timer->io_base;
+	} else {
+		timer->revision = 2;
+		timer->irq_stat = timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
+		timer->irq_ena = timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
+		timer->irq_dis = timer->io_base + OMAP_TIMER_V2_IRQENABLE_CLR;
+		timer->pend = timer->io_base +
+			_OMAP_TIMER_WRITE_PEND_OFFSET +
+				OMAP_TIMER_V2_FUNC_OFFSET;
+		timer->func_base = timer->io_base + OMAP_TIMER_V2_FUNC_OFFSET;
+	}
+}
+
+/*
+ * __omap_dm_timer_enable_posted - enables write posted mode
+ * @timer:      pointer to timer instance handle
+ *
+ * Enables the write posted mode for the timer. When posted mode is enabled
+ * writes to certain timer registers are immediately acknowledged by the
+ * internal bus and hence prevents stalling the CPU waiting for the write to
+ * complete. Enabling this feature can improve performance for writing to the
+ * timer registers.
+ */
+static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
+{
+	if (timer->posted)
+		return;
+
+	if (timer->errata & OMAP_TIMER_ERRATA_I103_I767) {
+		timer->posted = OMAP_TIMER_NONPOSTED;
+		__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG, 0, 0);
+		return;
+	}
+
+	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
+			      OMAP_TIMER_CTRL_POSTED, 0);
+	timer->context.tsicr = OMAP_TIMER_CTRL_POSTED;
+	timer->posted = OMAP_TIMER_POSTED;
+}
+
+static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
+					int posted, unsigned long rate)
+{
+	u32 l;
+
+	l = __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+	if (l & OMAP_TIMER_CTRL_ST) {
+		l &= ~0x1;
+		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
+#ifdef CONFIG_ARCH_OMAP2PLUS
+		/* Readback to make sure write has completed */
+		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+		/*
+		 * Wait for functional clock period x 3.5 to make sure that
+		 * timer is stopped
+		 */
+		udelay(3500000 / rate + 1);
+#endif
+	}
+
+	/* Ack possibly pending interrupt */
+	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
+}
+
+static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
+						unsigned int value)
+{
+	writel_relaxed(value, timer->irq_ena);
+	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
+}
+
+static inline unsigned int
+__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
+{
+	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
+}
+
+static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
+						unsigned int value)
+{
+	writel_relaxed(value, timer->irq_stat);
+}
+
 /**
  * omap_dm_timer_read_reg - read timer registers in posted and non-posted mode
  * @timer:      timer pointer over which read operation to perform
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -247,148 +247,4 @@ int omap_dm_timers_active(void);
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
-/*
- * The below are inlined to optimize code size for system timers. Other code
- * should not need these at all.
- */
-#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2PLUS)
-static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
-						int posted)
-{
-	if (posted)
-		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
-			cpu_relax();
-
-	return readl_relaxed(timer->func_base + (reg & 0xff));
-}
-
-static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
-					u32 reg, u32 val, int posted)
-{
-	if (posted)
-		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
-			cpu_relax();
-
-	writel_relaxed(val, timer->func_base + (reg & 0xff));
-}
-
-static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
-{
-	u32 tidr;
-
-	/* Assume v1 ip if bits [31:16] are zero */
-	tidr = readl_relaxed(timer->io_base);
-	if (!(tidr >> 16)) {
-		timer->revision = 1;
-		timer->irq_stat = timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
-		timer->irq_ena = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
-		timer->irq_dis = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
-		timer->pend = timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
-		timer->func_base = timer->io_base;
-	} else {
-		timer->revision = 2;
-		timer->irq_stat = timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
-		timer->irq_ena = timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
-		timer->irq_dis = timer->io_base + OMAP_TIMER_V2_IRQENABLE_CLR;
-		timer->pend = timer->io_base +
-			_OMAP_TIMER_WRITE_PEND_OFFSET +
-				OMAP_TIMER_V2_FUNC_OFFSET;
-		timer->func_base = timer->io_base + OMAP_TIMER_V2_FUNC_OFFSET;
-	}
-}
-
-/*
- * __omap_dm_timer_enable_posted - enables write posted mode
- * @timer:      pointer to timer instance handle
- *
- * Enables the write posted mode for the timer. When posted mode is enabled
- * writes to certain timer registers are immediately acknowledged by the
- * internal bus and hence prevents stalling the CPU waiting for the write to
- * complete. Enabling this feature can improve performance for writing to the
- * timer registers.
- */
-static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
-{
-	if (timer->posted)
-		return;
-
-	if (timer->errata & OMAP_TIMER_ERRATA_I103_I767) {
-		timer->posted = OMAP_TIMER_NONPOSTED;
-		__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG, 0, 0);
-		return;
-	}
-
-	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
-			      OMAP_TIMER_CTRL_POSTED, 0);
-	timer->context.tsicr = OMAP_TIMER_CTRL_POSTED;
-	timer->posted = OMAP_TIMER_POSTED;
-}
-
-/**
- * __omap_dm_timer_override_errata - override errata flags for a timer
- * @timer:      pointer to timer handle
- * @errata:	errata flags to be ignored
- *
- * For a given timer, override a timer errata by clearing the flags
- * specified by the errata argument. A specific erratum should only be
- * overridden for a timer if the timer is used in such a way the erratum
- * has no impact.
- */
-static inline void __omap_dm_timer_override_errata(struct omap_dm_timer *timer,
-						   u32 errata)
-{
-	timer->errata &= ~errata;
-}
-
-static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
-					int posted, unsigned long rate)
-{
-	u32 l;
-
-	l = __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
-	if (l & OMAP_TIMER_CTRL_ST) {
-		l &= ~0x1;
-		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
-#ifdef CONFIG_ARCH_OMAP2PLUS
-		/* Readback to make sure write has completed */
-		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
-		/*
-		 * Wait for functional clock period x 3.5 to make sure that
-		 * timer is stopped
-		 */
-		udelay(3500000 / rate + 1);
-#endif
-	}
-
-	/* Ack possibly pending interrupt */
-	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
-}
-
-static inline void __omap_dm_timer_load_start(struct omap_dm_timer *timer,
-						u32 ctrl, unsigned int load,
-						int posted)
-{
-	__omap_dm_timer_write(timer, OMAP_TIMER_COUNTER_REG, load, posted);
-	__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, ctrl, posted);
-}
-
-static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
-						unsigned int value)
-{
-	writel_relaxed(value, timer->irq_ena);
-	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
-}
-
-static inline unsigned int
-__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
-{
-	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
-}
-
-static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
-						unsigned int value)
-{
-	writel_relaxed(value, timer->irq_stat);
-}
-#endif /* CONFIG_ARCH_OMAP1 || CONFIG_ARCH_OMAP2PLUS */
 #endif /* __CLOCKSOURCE_DMTIMER_H */
-- 
2.35.1
