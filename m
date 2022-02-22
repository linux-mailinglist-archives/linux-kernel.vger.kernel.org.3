Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4753C4BF53A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiBVJ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiBVJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:57:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CC86AA64;
        Tue, 22 Feb 2022 01:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645523824; x=1677059824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jIpQZ66aUQrcT+gWMOuhuvkSP2jf18o/QiiPqjhMKNI=;
  b=ISbnWCGxKwdlaSssv16j1zwmAd/JHkk1NR00YJ1LYH8WID4hVdh8f8Re
   CRJ+Y39agby/Vc1SKueiGTU+H3mrYVj/qRKaPXZc0xoekjYksXfrChh71
   YnKaKagcHLE1wVDK3DzhkbCK0s2ug68sQj2bcXHGb3F8pVgH5gkgRjudQ
   bi4aK3UJ/Xz1WxKWHs0pHUvI+dhZmwYNnxEgzNC/Rs8lWIONn//6Wpiyj
   Bw1FiWx+w/kcaWY8UeaxmxnewKSBSgi40FKDvf2xLRSg+WgiQXpaOh/Ka
   YMTbbMbwDXb/0fyRxn3YMMQpeY6cmFFGufUqk9jaw42G86pkk14fYSyGB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="250478914"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="250478914"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 01:57:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="591248155"
Received: from gio-01395267462.iind.intel.com ([10.49.4.124])
  by fmsmga008.fm.intel.com with ESMTP; 22 Feb 2022 01:57:01 -0800
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        srikanth.thokala@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Date:   Tue, 22 Feb 2022 15:26:54 +0530
Message-Id: <20220222095654.9097-3-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222095654.9097-1-shruthi.sanil@intel.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

The Intel Keem Bay timer driver supports clocksource and clockevent
features for the timer IP used in Intel Keem Bay SoC.
The timer block supports 1 free running counter and 8 timers.
The free running counter can be used as a clocksource and
the timers can be used as clockevent. Each timer is capable of
generating individual interrupt.
Both the features are enabled through the timer general config register.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
---
 MAINTAINERS                         |   6 +
 drivers/clocksource/Kconfig         |  11 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-keembay.c | 230 ++++++++++++++++++++++++++++
 4 files changed, 248 insertions(+)
 create mode 100644 drivers/clocksource/timer-keembay.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 777cd6fa2b3d..73c0029dcdf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9796,6 +9796,12 @@ F:	drivers/crypto/keembay/keembay-ocs-hcu-core.c
 F:	drivers/crypto/keembay/ocs-hcu.c
 F:	drivers/crypto/keembay/ocs-hcu.h
 
+INTEL KEEM BAY TIMER DRIVER
+M:	Shruthi Sanil <shruthi.sanil@intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
+F:	drivers/clocksource/timer-keembay.c
+
 INTEL THUNDER BAY EMMC PHY DRIVER
 M:	Nandhini Srikandan <nandhini.srikandan@intel.com>
 M:	Rashmi A <rashmi.a@intel.com>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cfb8ea0df3b1..65b6cf916e5a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -721,4 +721,15 @@ config MICROCHIP_PIT64B
 	  modes and high resolution. It is used as a clocksource
 	  and a clockevent.
 
+config KEEMBAY_TIMER
+	bool "Intel Keem Bay timer"
+	depends on ARCH_KEEMBAY || COMPILE_TEST
+	select TIMER_OF
+	help
+	  This option enables the support for the Intel Keem Bay
+	  general purpose timer and free running counter driver.
+	  Each timer can generate an individual interrupt and
+	  supports oneshot and periodic modes.
+	  The 64-bit counter can be used as a clock source.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index fa5f624eadb6..dff6458ef9e5 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
 obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
+obj-$(CONFIG_KEEMBAY_TIMER)		+= timer-keembay.o
diff --git a/drivers/clocksource/timer-keembay.c b/drivers/clocksource/timer-keembay.c
new file mode 100644
index 000000000000..230609c06a26
--- /dev/null
+++ b/drivers/clocksource/timer-keembay.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keem Bay Timer driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ */
+
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+
+#include "timer-of.h"
+
+/* Timer register offset */
+#define TIM_CNT_VAL_OFFSET		0x0
+#define TIM_RELOAD_VAL_OFFSET		0x4
+#define TIM_CONFIG_OFFSET		0x8
+
+/* Bit fields of timer general config register */
+#define TIM_CONFIG_PRESCALER_ENABLE	BIT(2)
+#define TIM_CONFIG_COUNTER_ENABLE	BIT(0)
+
+/* Bit fields of timer config register */
+#define TIM_CONFIG_INTERRUPT_PENDING	BIT(4)
+#define TIM_CONFIG_INTERRUPT_ENABLE	BIT(2)
+#define TIM_CONFIG_RESTART		BIT(1)
+#define TIM_CONFIG_ENABLE		BIT(0)
+
+#define TIM_GEN_MASK			GENMASK(31, 12)
+#define TIM_RATING			200
+#define TIM_CLKSRC_MASK_BITS		64
+
+#define TIMER_NAME_SIZE			25
+
+static inline void keembay_timer_enable(void __iomem *base, u32 flags)
+{
+	writel(TIM_CONFIG_ENABLE | flags, base + TIM_CONFIG_OFFSET);
+}
+
+static inline void keembay_timer_disable(void __iomem *base)
+{
+	writel(0x0, base + TIM_CONFIG_OFFSET);
+}
+
+static inline void keembay_timer_update_counter(void __iomem *base, u32 val)
+{
+	writel(val, base + TIM_CNT_VAL_OFFSET);
+	writel(val, base + TIM_RELOAD_VAL_OFFSET);
+}
+
+static inline void keembay_timer_clear_pending_int(void __iomem *base)
+{
+	u32 val;
+
+	val = readl(base + TIM_CONFIG_OFFSET);
+	val &= ~TIM_CONFIG_INTERRUPT_PENDING;
+	writel(val, base + TIM_CONFIG_OFFSET);
+}
+
+static int keembay_timer_set_next_event(unsigned long evt, struct clock_event_device *ce)
+{
+	u32 flags = TIM_CONFIG_INTERRUPT_ENABLE;
+	struct timer_of *to = to_timer_of(ce);
+	void __iomem *tim_base = timer_of_base(to);
+
+	keembay_timer_disable(tim_base);
+	keembay_timer_update_counter(tim_base, evt);
+	keembay_timer_enable(tim_base, flags);
+
+	return 0;
+}
+
+static int keembay_timer_periodic(struct clock_event_device *ce)
+{
+	u32 flags = TIM_CONFIG_INTERRUPT_ENABLE | TIM_CONFIG_RESTART;
+	struct timer_of *to = to_timer_of(ce);
+	void __iomem *tim_base = timer_of_base(to);
+
+	keembay_timer_disable(tim_base);
+	keembay_timer_update_counter(tim_base, timer_of_period(to));
+	keembay_timer_enable(tim_base, flags);
+
+	return 0;
+}
+
+static int keembay_timer_shutdown(struct clock_event_device *ce)
+{
+	struct timer_of *to = to_timer_of(ce);
+
+	keembay_timer_disable(timer_of_base(to));
+
+	return 0;
+}
+
+static irqreturn_t keembay_timer_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct timer_of *to = to_timer_of(evt);
+	void __iomem *tim_base = timer_of_base(to);
+	u32 val;
+
+	val = readl(tim_base + TIM_CONFIG_OFFSET);
+
+	if (val & TIM_CONFIG_RESTART) {
+		/* Clear interrupt for periodic timer*/
+		keembay_timer_clear_pending_int(tim_base);
+	} else {
+		/* Disable the timer for one shot timer */
+		keembay_timer_disable(tim_base);
+	}
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init keembay_clockevent_init(struct device_node *np)
+{
+	struct timer_of *keembay_ce_to;
+	struct regmap *regmap;
+	int ret;
+	u32 val;
+
+	regmap = device_node_to_regmap(np->parent);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = regmap_read(regmap, TIM_CONFIG_OFFSET, &val);
+	if (ret)
+		return ret;
+
+	/* Prescaler bit must be enabled for the timer to function */
+	if (!(val & TIM_CONFIG_PRESCALER_ENABLE)) {
+		pr_err("%pOF: Prescaler is not enabled\n", np);
+		ret = -ENODEV;
+	}
+
+	keembay_ce_to = kzalloc(sizeof(*keembay_ce_to), GFP_KERNEL);
+	if (!keembay_ce_to)
+		ret = -ENOMEM;
+
+	keembay_ce_to->flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK;
+	keembay_ce_to->clkevt.name = "keembay_timer";
+	keembay_ce_to->clkevt.cpumask = cpu_possible_mask;
+	keembay_ce_to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC |
+					 CLOCK_EVT_FEAT_ONESHOT  |
+					 CLOCK_EVT_FEAT_DYNIRQ;
+	keembay_ce_to->clkevt.rating = TIM_RATING;
+	keembay_ce_to->clkevt.set_next_event = keembay_timer_set_next_event;
+	keembay_ce_to->clkevt.set_state_periodic = keembay_timer_periodic;
+	keembay_ce_to->clkevt.set_state_shutdown = keembay_timer_shutdown;
+	keembay_ce_to->of_irq.handler = keembay_timer_isr;
+	keembay_ce_to->of_irq.flags = IRQF_TIMER;
+
+	ret = timer_of_init(np, keembay_ce_to);
+	if (ret)
+		goto err_keembay_ce_to_free;
+
+	ret = regmap_read(regmap, TIM_RELOAD_VAL_OFFSET, &val);
+	if (ret)
+		goto err_keembay_ce_to_free;
+
+	keembay_ce_to->of_clk.rate = keembay_ce_to->of_clk.rate / (val + 1);
+
+	clockevents_config_and_register(&keembay_ce_to->clkevt,
+					timer_of_rate(keembay_ce_to),
+					1,
+					U32_MAX);
+
+	return 0;
+
+err_keembay_ce_to_free:
+	kfree(keembay_ce_to);
+
+	return ret;
+}
+
+static struct timer_of keembay_cs_to = {
+	.flags	= TIMER_OF_BASE | TIMER_OF_CLOCK,
+};
+
+static u64 notrace keembay_clocksource_read(struct clocksource *cs)
+{
+	return lo_hi_readq(timer_of_base(&keembay_cs_to));
+}
+
+static struct clocksource keembay_counter = {
+	.name	= "keembay_sys_counter",
+	.rating	= TIM_RATING,
+	.read	= keembay_clocksource_read,
+	.mask	= CLOCKSOURCE_MASK(TIM_CLKSRC_MASK_BITS),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS |
+		  CLOCK_SOURCE_SUSPEND_NONSTOP,
+};
+
+static int __init keembay_clocksource_init(struct device_node *np)
+{
+	struct regmap *regmap;
+	u32 val;
+	int ret;
+
+	regmap = device_node_to_regmap(np->parent);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = regmap_read(regmap, TIM_CONFIG_OFFSET, &val);
+	if (ret)
+		return ret;
+
+	/* Free Running Counter bit must be enabled for counter to function */
+	if (!(val & TIM_CONFIG_COUNTER_ENABLE)) {
+		pr_err("%pOF: free running counter is not enabled\n", np);
+		return -ENODEV;
+	}
+
+	ret = timer_of_init(np, &keembay_cs_to);
+	if (ret)
+		return ret;
+
+	return clocksource_register_hz(&keembay_counter, timer_of_rate(&keembay_cs_to));
+}
+
+TIMER_OF_DECLARE(keembay_clockevent, "intel,keembay-timer", keembay_clockevent_init);
+TIMER_OF_DECLARE(keembay_clocksource, "intel,keembay-counter", keembay_clocksource_init);
-- 
2.17.1

