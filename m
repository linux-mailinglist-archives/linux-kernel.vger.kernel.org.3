Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D750A909
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391822AbiDUTW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388536AbiDUTWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:22:40 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7D74C7A6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:19:49 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23LEudva006748;
        Thu, 21 Apr 2022 19:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=uc5dE8hjheCv7Lt4oOoTUVhbvJ88FjRdaChwylT8gYg=;
 b=ci2qDHcmj8uklDFL6DcRoJH0c5TXCBQzVFyGp/XUegf1tb1Urdbhe/YAh6uENsqQiyiE
 40ZUC6rad88H6GzMwtfI8CeDwxTsccIwHc4oU2AQ8LwqVfqAUkZbIgNWFxwMJwhaJ4CZ
 SpBYGFlU3HuCpzWwui2GFzXOD1uAcwtjTFSiHHVmwOFEiymWne43YpgLFGN6qQhXVaiV
 d1dFnU1xjYyhBQAlAkX9NGpIyYUX6ylFaegs3crJ2eZyYeLWF/+0G9/2K2YQXrjdNL3v
 HppC2A2Vw2wqZPCGN+ZwStm8Uc7M3cyHzk6mDdm3hStvTr/yxW0B9SgiSMmFNJ8Tq8wu oQ== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fk9fkt6ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 19:19:39 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 6F56461;
        Thu, 21 Apr 2022 19:19:38 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 375044F;
        Thu, 21 Apr 2022 19:19:38 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/11] clocksource/drivers: Add HPE GXP timer
Date:   Thu, 21 Apr 2022 14:21:25 -0500
Message-Id: <20220421192132.109954-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421192132.109954-1-nick.hawkins@hpe.com>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: HAaUnHz2e38EvmqrIBSENKghq2KSJgzG
X-Proofpoint-ORIG-GUID: HAaUnHz2e38EvmqrIBSENKghq2KSJgzG
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_04,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204210102
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add support for the HPE GXP SOC timer. The GXP supports several
different kinds of timers but for the purpose of this driver there
is only support for the General Timer. The timer has a 1us
resolution and is 32 bits. The timer also creates a child watchdog
device as the register region is the same based on previous review
feedback.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v5:
* Corrected version log
* Removed uncessary include file
v4:
* Made watchdog a child of timer as they share the same register
  region
* Fixed watchdog init timeout call
* Fixed variable usage u32/u64
* Removed Read Once
* fixed error that should have been debug
v3:
* Put into proper patchset form
v2:
* No change
---
 drivers/clocksource/Kconfig     |   8 ++
 drivers/clocksource/Makefile    |   1 +
 drivers/clocksource/timer-gxp.c | 182 ++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 drivers/clocksource/timer-gxp.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1589ae7d5abb..110dd10b32f2 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -617,6 +617,14 @@ config CLKSRC_ST_LPC
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
 
+config GXP_TIMER
+	bool "GXP timer driver" if COMPILE_TEST
+	depends on ARCH_HPE
+	default y
+	help
+	  Provides a driver for the timer control found on HPE
+	  GXP SOCs. This is required for all GXP SOCs.
+
 config RISCV_TIMER
 	bool "Timer for the RISC-V platform" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && RISCV && RISCV_SBI
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 9c85ee2bb373..98017abf6c03 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
 obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
+obj-$(CONFIG_GXP_TIMER)			+= timer-gxp.o
diff --git a/drivers/clocksource/timer-gxp.c b/drivers/clocksource/timer-gxp.c
new file mode 100644
index 000000000000..c9290fb8131c
--- /dev/null
+++ b/drivers/clocksource/timer-gxp.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P.*/
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/sched_clock.h>
+
+#define TIMER0_FREQ	1000000
+#define GXP_TIMER_CNT_OFS 0x00
+#define GXP_TIMESTAMP_OFS 0x08
+#define GXP_TIMER_CTRL_OFS 0x14
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
+static struct gxp_timer *local_gxp_timer;
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
+static int gxp_time_set_next_event(unsigned long event,	struct clock_event_device *evt_dev)
+{
+	struct gxp_timer *timer = to_gxp_timer(evt_dev);
+
+	/* Stop counting and disable interrupt before updating */
+	writeb_relaxed(MASK_TCS_TC, timer->control);
+	writel_relaxed(event, timer->counter);
+	writeb_relaxed(MASK_TCS_TC | MASK_TCS_ENABLE, timer->control);
+
+	return 0;
+}
+
+static irqreturn_t gxp_timer_interrupt(int irq, void *dev_id)
+{
+	struct gxp_timer *timer = (struct gxp_timer *)dev_id;
+
+	if (!(readb_relaxed(timer->control) & MASK_TCS_TC))
+		return IRQ_NONE;
+
+	writeb_relaxed(MASK_TCS_TC, timer->control);
+
+	timer->evt.event_handler(&timer->evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init gxp_timer_init(struct device_node *node)
+{
+	void __iomem *base;
+	struct clk *clk;
+	u32 freq;
+	int ret, irq;
+	struct gxp_timer *gxp_timer;
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("Can't remap timer base register");
+		ret = -ENXIO;
+		return ret;
+	}
+
+	/*Set the offset to the clock register*/
+	system_clock = base + GXP_TIMESTAMP_OFS;
+
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk)) {
+		pr_err("%pOFn clock not found: %d\n", node, (int)PTR_ERR(clk));
+		ret = -EIO;
+		goto err_iounmap;
+	}
+
+	ret = clk_prepare_enable(clk);
+
+	freq = clk_get_rate(clk);
+
+	sched_clock_register(gxp_sched_read, 32, freq);
+	clocksource_mmio_init(system_clock, node->name, freq,
+			      300, 32, clocksource_mmio_readl_up);
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
+	gxp_timer->counter = base + GXP_TIMER_CNT_OFS;
+	gxp_timer->control = base + GXP_TIMER_CTRL_OFS;
+	gxp_timer->evt.name = node->name;
+	gxp_timer->evt.rating = 300;
+	gxp_timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
+	gxp_timer->evt.set_next_event = gxp_time_set_next_event;
+	gxp_timer->evt.cpumask = cpumask_of(0);
+
+	local_gxp_timer = gxp_timer;
+
+	ret = request_irq(irq, gxp_timer_interrupt, IRQF_TIMER | IRQF_SHARED,
+			  node->name, gxp_timer);
+	if (ret) {
+		pr_err("%s: request_irq() failed %pe\n", "GXP Timer Tick", ERR_PTR(ret));
+		goto err_iounmap;
+	}
+
+	clockevents_config_and_register(&gxp_timer->evt, TIMER0_FREQ,
+					0xf, 0xffffffff);
+
+	pr_debug("gxp: system timer (irq = %d)\n", irq);
+	return 0;
+
+err_iounmap:
+	iounmap(system_clock);
+	iounmap(base);
+	return ret;
+}
+
+static struct platform_device gxp_watchdog_device = {
+	.name = "gxp-wdt",
+	.id = -1,
+};
+
+/*
+ * This probe gets called after the timer is already up and running. This will create
+ * the watchdog device as a child since the registers are shared.
+ */
+
+static int gxp_timer_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	/* Pass the base address (counter) as platform data and nothing else */
+	gxp_watchdog_device.dev.platform_data = local_gxp_timer->counter;
+	gxp_watchdog_device.dev.parent = dev;
+	return platform_device_register(&gxp_watchdog_device);
+}
+
+static const struct of_device_id gxp_timer_of_match[] = {
+	{ .compatible = "hpe,gxp-timer", },
+	{},
+};
+
+static struct platform_driver gxp_timer_driver = {
+	.probe  = gxp_timer_probe,
+	.driver = {
+		.name = "gxp-timer",
+		.of_match_table = gxp_timer_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+builtin_platform_driver(gxp_timer_driver);
+
+TIMER_OF_DECLARE(gxp, "hpe,gxp-timer", gxp_timer_init);
-- 
2.17.1

