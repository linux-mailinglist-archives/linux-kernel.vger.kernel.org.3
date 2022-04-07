Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC314F77F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242109AbiDGHqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242066AbiDGHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:46:43 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9804C8CCD7;
        Thu,  7 Apr 2022 00:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649317484;
  x=1680853484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mz29Z7g6XhZMBEyDRcC5tTyavLUBWPycQxmbBGsMjXg=;
  b=NyXR4hg5UcFB3Jv7w04WGn+Zyh4a3uzeRqCPECArNPc3PcUJ5Qwz0kbv
   xod9/rT7jlegJxPvIGgr1E5o1c7j6nkKSjRIVWZFLBx8Q/Ff67Cd21ne9
   L5W/BAQmeSu9bMPI/T2wgp9E6pt1tHv0kmgdY2XeAv6GS/KmlFwTCN9c1
   qljE/cYWvQCZ/xzlJdqw6VSvRzyEFg87GVAqPA51bxHISMOHX/4HxGRSm
   RcFkE4W8s68BnDiLeoIDgMBsFVHzSjLQpNQHNSdyrje76DGo+Ocl0dRcu
   HMMRXO+Pa6G85n3nL1FLexbn8FdnsNIKQR0XWsYijcTsxvOJoWEWJ/Bpd
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <krzk@kernel.org>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <alim.akhtar@samsung.com>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v3 3/4] clocksource/drivers/exynos_mct: Support local-timers property
Date:   Thu, 7 Apr 2022 09:44:31 +0200
Message-ID: <20220407074432.424578-4-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220407074432.424578-1-vincent.whitchurch@axis.com>
References: <20220407074432.424578-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device tree indicates that the hardware requires that the
processor only use certain local timers, respect that.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v3:
    - Use array in devicetree
    - Remove addition of global variable
    - Split out FRC sharing changes

 drivers/clocksource/exynos_mct.c | 51 ++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 12023831dedf..4093a71ff618 100644
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
@@ -66,6 +66,8 @@
 #define MCT_L0_IRQ	4
 /* Max number of IRQ as per DT binding document */
 #define MCT_NR_IRQS	20
+/* Max number of local timers */
+#define MCT_NR_LOCAL	(MCT_NR_IRQS - MCT_L0_IRQ)
 
 enum {
 	MCT_INT_SPI,
@@ -456,7 +458,6 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 		per_cpu_ptr(&percpu_mct_tick, cpu);
 	struct clock_event_device *evt = &mevt->evt;
 
-	mevt->base = EXYNOS4_MCT_L_BASE(cpu);
 	snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d", cpu);
 
 	evt->name = mevt->name;
@@ -528,7 +529,9 @@ static int __init exynos4_timer_resources(struct device_node *np)
 }
 
 static int __init exynos4_timer_interrupts(struct device_node *np,
-					   unsigned int int_type)
+					   unsigned int int_type,
+					   u32 *local_idx,
+					   size_t nr_local)
 {
 	int nr_irqs, i, err, cpu;
 
@@ -561,13 +564,19 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 	} else {
 		for_each_possible_cpu(cpu) {
 			int mct_irq;
+			unsigned int irqidx;
 			struct mct_clock_event_device *pcpu_mevt =
 				per_cpu_ptr(&percpu_mct_tick, cpu);
 
+			if (cpu >= nr_local)
+				break;
+
+			irqidx = MCT_L0_IRQ + local_idx[cpu];
+
 			pcpu_mevt->evt.irq = -1;
-			if (MCT_L0_IRQ + cpu >= ARRAY_SIZE(mct_irqs))
+			if (irqidx >= ARRAY_SIZE(mct_irqs))
 				break;
-			mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
+			mct_irq = mct_irqs[irqidx];
 
 			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
 			if (request_irq(mct_irq,
@@ -583,6 +592,15 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 		}
 	}
 
+	for_each_possible_cpu(cpu) {
+		struct mct_clock_event_device *mevt = per_cpu_ptr(&percpu_mct_tick, cpu);
+
+		if (cpu >= nr_local)
+			break;
+
+		mevt->base = EXYNOS4_MCT_L_BASE(local_idx[cpu]);
+	}
+
 	/* Install hotplug callbacks which configure the timer on this CPU */
 	err = cpuhp_setup_state(CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 				"clockevents/exynos4/mct_timer:starting",
@@ -613,13 +631,34 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
 	bool frc_shared = of_property_read_bool(np, "samsung,frc-shared");
+	u32 local_idx[MCT_NR_LOCAL] = {0};
+	int nr_local;
 	int ret;
 
+	nr_local = of_property_count_u32_elems(np, "samsung,local-timers");
+	if (nr_local == 0)
+		return -EINVAL;
+	if (nr_local > 0) {
+		if (nr_local > ARRAY_SIZE(local_idx))
+			return -EINVAL;
+
+		ret = of_property_read_u32_array(np, "samsung,local-timers",
+						 local_idx, nr_local);
+		if (ret)
+			return ret;
+	} else {
+		int i;
+
+		nr_local = ARRAY_SIZE(local_idx);
+		for (i = 0; i < nr_local; i++)
+			local_idx[i] = i;
+	}
+
 	ret = exynos4_timer_resources(np);
 	if (ret)
 		return ret;
 
-	ret = exynos4_timer_interrupts(np, int_type);
+	ret = exynos4_timer_interrupts(np, int_type, local_idx, nr_local);
 	if (ret)
 		return ret;
 
-- 
2.34.1

