Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280574CF3A9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiCGIeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiCGIeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:34:18 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E2713D26
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646642001;
  x=1678178001;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mhhc4KiuxbavjISsXlMiWu5G1CPhO3zCf6Xz+ptSOuQ=;
  b=JSRk6HM0syu9KGBVQr2Ht/qUIIYLdf/iFjisceZMBQiAmzeareXoqfy8
   e3e0XjfvG6ClxVBX2L3t08o/YJPux9NGKgcAMQHzc2qd3TiVbx3WB0pnH
   3fjwghQLOqmTdR5hP0rxDYi9hkBA3pzufFgtAGwVz03wYOqGUFMRGECcz
   7+p7k1A4+0EMpHRf7ebC+mBSJDq6Vzb3+UaVOpf+22pNnfy5i7AnzG/C8
   D0ykAYAY5tH/exwej/ZMhkON0QiX2z+OECGXeFNpBa8yLKYWydz9/2y+G
   6Dor9/0I944RNmECFxP+tpF9RZDP07tfmR99OHbB+ekdsOBUvDdw1exeN
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Subject: [PATCH] clocksource/drivers/exynos_mct: Support using only local timer
Date:   Mon, 7 Mar 2022 09:32:55 +0100
Message-ID: <20220307083255.1577365-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARTPEC-8 SoC has a quad-core Cortex-A53 and a single-core Cortex-A5
which share one MCT with one global and eight local timers.

The Cortex-A53 boots first and starts the global FRC and also registers
a clock events device using the global timer.  (This global timer clock
events is usually replaced by arch timer clock events for each of the
cores.)

When the A5 boots, we should not use the global timer interrupts or
write to the global timer registers.  This is because even if there are
four global comparators, the control bits for all four are in the same
registers, and we would need to synchronize between the cpus.  Instead,
the global timer FRC (already started by the A53) should be used as the
clock source, and one of the local timers which are not used by the A53
can be used for clock events on the A5.

To support this, add a module param to set the local timer starting
index.  If this parameter is non-zero, the global timer clock events
device is not registered and we don't write to the global FRC if it is
already started.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/clocksource/exynos_mct.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index f29c812b70c9..7ea2919b1808 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -33,7 +33,7 @@
 #define EXYNOS4_MCT_G_INT_ENB		EXYNOS4_MCTREG(0x248)
 #define EXYNOS4_MCT_G_WSTAT		EXYNOS4_MCTREG(0x24C)
 #define _EXYNOS4_MCT_L_BASE		EXYNOS4_MCTREG(0x300)
-#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * x))
+#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * (x)))
 #define EXYNOS4_MCT_L_MASK		(0xffffff00)
 
 #define MCT_L_TCNTB_OFFSET		(0x00)
@@ -77,6 +77,13 @@ static unsigned long clk_rate;
 static unsigned int mct_int_type;
 static int mct_irqs[MCT_NR_IRQS];
 
+/*
+ * First local timer index to use.  If non-zero, global
+ * timer is not written to.
+ */
+static unsigned int mct_local_idx;
+module_param_named(local_idx, mct_local_idx, int, 0);
+
 struct mct_clock_event_device {
 	struct clock_event_device evt;
 	unsigned long base;
@@ -157,6 +164,17 @@ static void exynos4_mct_frc_start(void)
 	u32 reg;
 
 	reg = readl_relaxed(reg_base + EXYNOS4_MCT_G_TCON);
+
+	/*
+	 * If the FRC is already running, we don't need to start it again.  We
+	 * could probably just do this on all systems, but, to avoid any risk
+	 * for regressions, we only do it on systems where it's absolutely
+	 * necessary (i.e., on systems where writes to the global registers
+	 * need to be avoided).
+	 */
+	if (mct_local_idx && (reg & MCT_G_TCON_START))
+		return;
+
 	reg |= MCT_G_TCON_START;
 	exynos4_mct_write(reg, EXYNOS4_MCT_G_TCON);
 }
@@ -449,7 +467,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 		per_cpu_ptr(&percpu_mct_tick, cpu);
 	struct clock_event_device *evt = &mevt->evt;
 
-	mevt->base = EXYNOS4_MCT_L_BASE(cpu);
+	mevt->base = EXYNOS4_MCT_L_BASE(mct_local_idx + cpu);
 	snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d", cpu);
 
 	evt->name = mevt->name;
@@ -554,13 +572,14 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 	} else {
 		for_each_possible_cpu(cpu) {
 			int mct_irq;
+			unsigned int irqidx = MCT_L0_IRQ + mct_local_idx + cpu;
 			struct mct_clock_event_device *pcpu_mevt =
 				per_cpu_ptr(&percpu_mct_tick, cpu);
 
 			pcpu_mevt->evt.irq = -1;
-			if (MCT_L0_IRQ + cpu >= ARRAY_SIZE(mct_irqs))
+			if (irqidx >= ARRAY_SIZE(mct_irqs))
 				break;
-			mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
+			mct_irq = mct_irqs[irqidx];
 
 			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
 			if (request_irq(mct_irq,
@@ -619,7 +638,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	if (ret)
 		return ret;
 
-	return exynos4_clockevent_init();
+	return (mct_local_idx == 0) ? exynos4_clockevent_init() : ret;
 }
 
 
-- 
2.34.1

