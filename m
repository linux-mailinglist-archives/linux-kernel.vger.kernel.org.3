Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BA04D5292
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343678AbiCJTv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245746AbiCJTvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:51:49 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9D0155C2F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:50:47 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AFr41f001338;
        Thu, 10 Mar 2022 19:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=bjvk+Zn3tI+/ULcEr8lQw4vSOHB4N60QCDz7J96T4b8=;
 b=oPLE+0mi3GP6c8aP6HJvxsMFXuk96vanO3lor5fd7MFyZU63mRMXfLC+lxyvYynXtrms
 TvhUegPkXAMHp43yK3lqgx2mPyXbAo3vgwKMMUfOhHNLXCHQcyoVh3pdAxdjD4DQukcy
 NgPkjSno/OWysOmXKOYjUD45Fn6TOrYoHTJaosp2PI1YoRPZjz83m+pBdfJeJesJrFMa
 siVebOKeiFTenxyHIUbz6gzHG3a0ITiWPYGADadqwx4BE3l7vW0mYt0gAiOERj4ognkO
 PVUIRbQ0ZcbojMU5awdBWUshRa9zrhBgPRP50OYxxH5ZsiaVOh/hvDT5AMuxzwj0aE09 jw== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eqa3sgd58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 19:50:36 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 86CD665;
        Thu, 10 Mar 2022 19:50:35 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/10] clocksource/drivers: Add HPE GXP timer
Date:   Thu, 10 Mar 2022 13:52:23 -0600
Message-Id: <20220310195229.109477-4-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: 8Cwj-8ljJCEh6QnZSqHQZZTS11zH3Ing
X-Proofpoint-ORIG-GUID: 8Cwj-8ljJCEh6QnZSqHQZZTS11zH3Ing
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_08,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100100
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add support for the HPE GXP SOC timer. The GXP supports several
different kinds of timers but for the purpose of this driver there
is only support for the General Timer. The timer has a 1us
resolution and is 32 bits.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 drivers/clocksource/Kconfig     |   8 ++
 drivers/clocksource/Makefile    |   1 +
 drivers/clocksource/gxp-timer.c | 159 ++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/clocksource/gxp-timer.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cfb8ea0df3b1..5916dade7608 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -617,6 +617,14 @@ config CLKSRC_ST_LPC
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
 
+config GXP_TIMER
+	bool "GXP timer driver"
+	depends on ARCH_HPE
+	default y
+	help
+	  Provides a driver for the timer control found on HPE
+	  GXP SOCs. This is required for all GXP SOCs.
+
 config ATCPIT100_TIMER
 	bool "ATCPIT100 timer driver"
 	depends on NDS32 || COMPILE_TEST
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index fa5f624eadb6..dbfb8c56a8a0 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
 obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
+obj-$(CONFIG_GXP_TIMER)			+= gxp-timer.o
diff --git a/drivers/clocksource/gxp-timer.c b/drivers/clocksource/gxp-timer.c
new file mode 100644
index 000000000000..a24cd1cc5c04
--- /dev/null
+++ b/drivers/clocksource/gxp-timer.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P.*/
+
+#include <linux/bitops.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sched_clock.h>
+
+#include <asm/irq.h>
+
+#define TIMER0_FREQ	1000000
+
+/*TCS Stands for Timer Control/Status: these are masks to be used in*/
+/* the Timer Count Registers */
+#define MASK_TCS_ENABLE	0x01
+#define MASK_TCS_PERIOD	0x02
+#define MASK_TCS_RELOAD	0x04
+#define MASK_TCS_TC	0x80
+
+struct gxp_timer {
+	void __iomem *counter;
+	void __iomem *control;
+	struct clock_event_device evt;
+};
+
+static void __iomem *system_clock __read_mostly;
+
+static inline struct gxp_timer *to_gxp_timer(struct clock_event_device *evt_dev)
+{
+	return container_of(evt_dev, struct gxp_timer, evt);
+}
+
+static u64 notrace gxp_sched_read(void)
+{
+	return readl_relaxed(system_clock);
+}
+
+static int gxp_time_set_next_event(unsigned long event,
+								struct clock_event_device *evt_dev)
+{
+	struct gxp_timer *timer = to_gxp_timer(evt_dev);
+	/* Stop counting and disable interrupt before updating */
+	writeb_relaxed(MASK_TCS_TC, timer->control);
+	writel_relaxed(event, timer->counter);
+	writeb_relaxed(MASK_TCS_TC | MASK_TCS_ENABLE, timer->control);
+
+	return 0;
+}
+
+static irqreturn_t gxp_time_interrupt(int irq, void *dev_id)
+{
+	struct gxp_timer *timer = dev_id;
+	void (*event_handler)(struct clock_event_device *timer);
+
+	if (!(readb_relaxed(timer->control) & MASK_TCS_TC))
+		return IRQ_NONE;
+
+	writeb_relaxed(MASK_TCS_TC, timer->control);
+
+	event_handler = READ_ONCE(timer->evt.event_handler);
+	event_handler(&timer->evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init gxp_timer_init(struct device_node *node)
+{
+	void __iomem *base_counter;
+	void __iomem *base_control;
+	u32 freq;
+	int ret, irq;
+	struct gxp_timer *gxp_timer;
+
+	base_counter = of_iomap(node, 0);
+	if (!base_counter) {
+		pr_err("Can't remap counter registers");
+		ret = -ENXIO;
+		return ret;
+	}
+
+	base_control = of_iomap(node, 1);
+	if (!base_control) {
+		pr_err("Can't remap control registers");
+		ret = -ENXIO;
+		goto err_iounmap;
+	}
+
+	system_clock = of_iomap(node, 2);
+	if (!system_clock) {
+		pr_err("Can't remap control registers");
+		ret = -ENXIO;
+		goto err_iounmap;
+	}
+
+	if (of_property_read_u32(node, "clock-frequency", &freq)) {
+		pr_err("Can't read clock-frequency\n");
+		ret = -EIO;
+		goto err_iounmap;
+	}
+
+	sched_clock_register(gxp_sched_read, 32, freq);
+	clocksource_mmio_init(system_clock, node->name, freq,
+				300, 32, clocksource_mmio_readl_up);
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (irq <= 0) {
+		ret = -EINVAL;
+		pr_err("GXP Timer Can't parse IRQ %d", irq);
+		goto err_iounmap;
+	}
+
+	gxp_timer = kzalloc(sizeof(*gxp_timer), GFP_KERNEL);
+	if (!gxp_timer) {
+		ret = -ENOMEM;
+		goto err_iounmap;
+	}
+
+	gxp_timer->counter = base_counter;
+	gxp_timer->control = base_control;
+	gxp_timer->evt.name = node->name;
+	gxp_timer->evt.rating = 300;
+	gxp_timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
+	gxp_timer->evt.set_next_event = gxp_time_set_next_event;
+	gxp_timer->evt.cpumask = cpumask_of(0);
+
+	if (request_irq(irq, gxp_time_interrupt, IRQF_TIMER | IRQF_SHARED,
+			node->name, gxp_timer)) {
+		ret = -EIO;
+		pr_err("%s: request_irq() failed\n", "GXP Timer Tick");
+		goto err_timer_free;
+	}
+
+	clockevents_config_and_register(&gxp_timer->evt, TIMER0_FREQ,
+					0xf, 0xffffffff);
+
+	pr_info("gxp: system timer (irq = %d)\n", irq);
+	return 0;
+
+
+err_timer_free:
+	kfree(gxp_timer);
+
+err_iounmap:
+	iounmap(system_clock);
+	iounmap(base_control);
+	iounmap(base_counter);
+	return ret;
+}
+
+TIMER_OF_DECLARE(gxp, "hpe,gxp-timer", gxp_timer_init);
-- 
2.17.1

