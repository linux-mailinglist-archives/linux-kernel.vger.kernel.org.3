Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79604E3EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiCVNBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiCVNBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:01:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB6D85BC4;
        Tue, 22 Mar 2022 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647954017; x=1679490017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=LK/0HHvU/W4kAOcWdNQcwy4DYl4ertGfDz5CiTnAaAU=;
  b=AEMlg6cthieULhPOmGOFlvThtu38Z30Y49Z6BK64iPg0IzCslSVTLqca
   gw16UfwbyuqHdL52oppoTKhFCHcW+91Y/hDoC7huJfR1qQ2DGohM+StMA
   Y/D39GjMiGbW0m+8F0KlzPNIYewoqLQ9iSaN2STAiZpRwbQ01YgB9utqN
   DJlGeVRVd5864HxcaNpkMpmf9LeYaqtovEyuPYNzjr8pDgqjAYXvREEZn
   obsnpw1f7KC5EOFved9HK+jCq+dCOBZVTRxRoqOZJAwXuC4ytdJZ6qFJZ
   f0j02sioz0DF3TjJUvoJqVM5xjPLgLRDmHv1xB6CDAXkuFV20r0gf0+Dl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="282645724"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="282645724"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 06:00:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="552087650"
Received: from gio-01395267463.iind.intel.com ([10.49.4.124])
  by fmsmga007.fm.intel.com with ESMTP; 22 Mar 2022 06:00:13 -0700
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        srikanth.thokala@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v10 2/2] clocksource: Add Intel Keem Bay timer support
Date:   Tue, 22 Mar 2022 18:30:05 +0530
Message-Id: <20220322130005.16045-3-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220322130005.16045-1-shruthi.sanil@intel.com>
References: <20220322130005.16045-1-shruthi.sanil@intel.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/clocksource/timer-keembay.c | 226 ++++++++++++++++++++++++++++
 4 files changed, 244 insertions(+)
 create mode 100644 drivers/clocksource/timer-keembay.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 05fd080b82f3..90af9439d529 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9791,6 +9791,12 @@ F:	drivers/crypto/keembay/keembay-ocs-hcu-core.c
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
index 000000000000..4cf3f6868964
--- /dev/null
+++ b/drivers/clocksource/timer-keembay.c
@@ -0,0 +1,226 @@
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
+		/* Periodic Timer */
+		keembay_timer_clear_pending_int(tim_base);
+	} else {
+		/* One-Shot Timer */
+		keembay_timer_disable(tim_base);
+	}
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct timer_of keembay_ce_to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+	.clkevt = {
+		.name		    = "keembay_sys_clkevt",
+		.cpumask	    = cpu_possible_mask,
+		.features	    = CLOCK_EVT_FEAT_PERIODIC |
+				      CLOCK_EVT_FEAT_ONESHOT  |
+				      CLOCK_EVT_FEAT_DYNIRQ,
+		.rating		    = TIM_RATING,
+		.set_next_event	    = keembay_timer_set_next_event,
+		.set_state_periodic = keembay_timer_periodic,
+		.set_state_shutdown = keembay_timer_shutdown,
+	},
+	.of_irq = {
+		.handler = keembay_timer_isr,
+		.flags   = IRQF_TIMER,
+	},
+};
+
+static int __init keembay_clockevent_init(struct device_node *np)
+{
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
+		pr_err(FW_BUG "%pOF: Prescaler is not enabled\n", np);
+		ret = -ENODEV;
+	}
+
+	ret = timer_of_init(np, &keembay_ce_to);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(regmap, TIM_RELOAD_VAL_OFFSET, &val);
+	if (ret)
+		return ret;
+
+	keembay_ce_to.of_clk.rate = keembay_ce_to.of_clk.rate / (val + 1);
+
+	clockevents_config_and_register(&keembay_ce_to.clkevt,
+					timer_of_rate(&keembay_ce_to),
+					1,
+					U32_MAX);
+
+	return 0;
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
+		pr_err(FW_BUG "%pOF: free running counter is not enabled\n", np);
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

