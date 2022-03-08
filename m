Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E254D1A68
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347452AbiCHOZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiCHOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:25:21 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690CC4B859;
        Tue,  8 Mar 2022 06:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646749463;
  x=1678285463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rFioSpH+5uUKbkMGJw1iA2/404Dx7lV4IUNdiyH/vxw=;
  b=JMpGYNo9FAtHlhNQqdUWImuQ8GADoh/QigC1WxRr82ppGbKGzv02i2en
   Vuvz3SOelwX4x/seJSxoPDxseaassK7HLel1PCsD7WF2NLM8Oa+TDEqGG
   NwUvSmdd43ZUbmOnv+ZKRVN1URhz5Hl5xC1FpK7CFOB2jrr+TbxLYkM1f
   SnB4sm7M36fI9lf2vRzaSBgdCLRxAgd0NVwH4y4/yPJdK4E61xxJzBAyV
   NfTQte/S9+hDL9rSSarMw0JZ2GV7IVr68dlKvB0siOebz02raAyEPqRAC
   6FwUA1+/2doAaQz/b8QvixdnhSVme7rNudk64qsZ99uev7YE1MYYqt/lM
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <krzysztof.kozlowski@canonical.com>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 3/4] clocksource/drivers/exynos_mct: Support local-timer-index property
Date:   Tue, 8 Mar 2022 15:24:09 +0100
Message-ID: <20220308142410.3193729-4-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
References: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
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

Support the documented semantics of the local-timer-index property: Use
it as the first index of the local timer, ensure that global timer clock
events device is not registered, and don't write to the global FRC if it
is already started.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v2: Use devicetree property instead of module parameter.

 drivers/clocksource/exynos_mct.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index f29c812b70c9..5f8b516614eb 100644
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
@@ -75,6 +75,7 @@ enum {
 static void __iomem *reg_base;
 static unsigned long clk_rate;
 static unsigned int mct_int_type;
+static unsigned int mct_local_idx;
 static int mct_irqs[MCT_NR_IRQS];
 
 struct mct_clock_event_device {
@@ -157,6 +158,17 @@ static void exynos4_mct_frc_start(void)
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
@@ -449,7 +461,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 		per_cpu_ptr(&percpu_mct_tick, cpu);
 	struct clock_event_device *evt = &mevt->evt;
 
-	mevt->base = EXYNOS4_MCT_L_BASE(cpu);
+	mevt->base = EXYNOS4_MCT_L_BASE(mct_local_idx + cpu);
 	snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d", cpu);
 
 	evt->name = mevt->name;
@@ -554,13 +566,14 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
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
@@ -607,6 +620,8 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
 	int ret;
 
+	of_property_read_u32(np, "local-timer-index", &mct_local_idx);
+
 	ret = exynos4_timer_resources(np);
 	if (ret)
 		return ret;
@@ -619,7 +634,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	if (ret)
 		return ret;
 
-	return exynos4_clockevent_init();
+	return (mct_local_idx == 0) ? exynos4_clockevent_init() : ret;
 }
 
 
-- 
2.34.1

