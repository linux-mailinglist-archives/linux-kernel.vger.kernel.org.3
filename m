Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F567496632
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 21:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiAUUIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 15:08:21 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55703 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiAUUIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 15:08:13 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Myb8P-1mNQue1U1l-00yxSE; Fri, 21
 Jan 2022 21:07:49 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v12 4/5] clocksource/drivers: Add a goldfish-timer clocksource
Date:   Fri, 21 Jan 2022 21:07:37 +0100
Message-Id: <20220121200738.2577697-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121200738.2577697-1-laurent@vivier.eu>
References: <20220121200738.2577697-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t9F+QJPerRrdNNw6UxdFBSoZ5ZNOY6FNV83dX+gVFdTpTvQPOMP
 kLec/+y30wSRYLOFe6Q2IcCfY8uigNZ9YbfT95JPM3M0AAaFuBhvOzipg1ac7S1C1EJ3MPy
 0b9m2dSTuvfztLzBWxterCTHfAc6INsKOcAmnVgJUWM1NTt8zgPRLQ6QFYmAIbJLTIIyIOU
 NruPi7QKDWE9ZOZmLAU7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nNuRimE7atE=:GYZD+bWh7Ldve9RQ5CHcia
 VF0x3mQr64QoC1k/mS9DrsfwkNA/twt77H5PjWjcMjuj+lHjGO5Mc2k6zG/wbE3g6DCDSPe9c
 eiJGkzKGkaVkV1DsFAxgLUByQPfKTNFO4M8CYxZPM9BiV2CNeGxUTUNmnQIpxMxrmFIRqypp4
 LAmaUhwiSOkHgYIML6mEa+HLE7cMLKRo+GxdAcEKruHrwCvU/i6lGdsIAjuL8HQ8d5xMIfLEa
 /leqYSey+9KAsEd3CD40zKlwWhMN7VvJIfbctB5ZQgxyDl//BoE2sdJDd2pbX7qugp28N1wR5
 /1JaNOnpuVZyd1ubIj2N8Yoycd6QWTmnL51JFioEXCkgmSY8UQ1NHMzoexWy9QsAMy57yBz1O
 RnST/N2lyjQER7DxzprtDCHbba7pdmD3EN0fVE/NbczQOS7/Xtk0cCTactkHwncYk6grrVa8G
 RC5fLf3TatRDwSVGSblQ9QNSZnhMXeL7Q39xbavRIumTPLBoOx/RKBgIXrwpdo8M5CPlU7dUI
 8lsQBWOxrgOBbIuJ7H0jjBTCk4If77qugKC9dNN5ucx4WM3nGBQjewbHEK2kqTVjKj2xwloGe
 KvQUqnw0XMLPs3uFNhkW/Y8OzVVRhsG5STYrzVJ/Lo3MbzcMLkIfVdiULNbG2WGmtaWQviFZT
 vs6jiCeOSz7socXSplXfuotgZuSdnwqU3+pe6o3hKNQB7JPSfkCerzImluD4UyK7VcK4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clocksource based on the goldfish-rtc device.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/clocksource/Kconfig          |   7 ++
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-goldfish.c | 163 +++++++++++++++++++++++++++
 include/clocksource/timer-goldfish.h |  11 ++
 4 files changed, 182 insertions(+)
 create mode 100644 drivers/clocksource/timer-goldfish.c
 create mode 100644 include/clocksource/timer-goldfish.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cfb8ea0df3b1..94f00374cebb 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -721,4 +721,11 @@ config MICROCHIP_PIT64B
 	  modes and high resolution. It is used as a clocksource
 	  and a clockevent.
 
+config GOLDFISH_TIMER
+	bool "Clocksource using goldfish-rtc"
+	depends on M68K || COMPILE_TEST
+	depends on RTC_DRV_GOLDFISH
+	help
+	  Support for the timer/counter of goldfish-rtc
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index fa5f624eadb6..12f5d7e8cc2d 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
 obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
+obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
diff --git a/drivers/clocksource/timer-goldfish.c b/drivers/clocksource/timer-goldfish.c
new file mode 100644
index 000000000000..4c670a1aea16
--- /dev/null
+++ b/drivers/clocksource/timer-goldfish.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/goldfish.h>
+#include <clocksource/timer-goldfish.h>
+
+#define TIMER_TIME_LOW		0x00	/* get low bits of current time  */
+					/*   and update TIMER_TIME_HIGH  */
+#define TIMER_TIME_HIGH		0x04	/* get high bits of time at last */
+					/*   TIMER_TIME_LOW read         */
+#define TIMER_ALARM_LOW		0x08	/* set low bits of alarm and     */
+					/*   activate it                 */
+#define TIMER_ALARM_HIGH	0x0c	/* set high bits of next alarm   */
+#define TIMER_IRQ_ENABLED	0x10
+#define TIMER_CLEAR_ALARM	0x14
+#define TIMER_ALARM_STATUS	0x18
+#define TIMER_CLEAR_INTERRUPT	0x1c
+
+struct goldfish_timer {
+	struct clocksource cs;
+	struct clock_event_device ced;
+	struct resource res;
+	void __iomem *base;
+	int irq;
+};
+
+static struct goldfish_timer *ced_to_gf(struct clock_event_device *ced)
+{
+	return container_of(ced, struct goldfish_timer, ced);
+}
+
+static struct goldfish_timer *cs_to_gf(struct clocksource *cs)
+{
+	return container_of(cs, struct goldfish_timer, cs);
+}
+
+static u64 goldfish_timer_read(struct clocksource *cs)
+{
+	struct goldfish_timer *timerdrv = cs_to_gf(cs);
+	void __iomem *base = timerdrv->base;
+	u32 time_low, time_high;
+	u64 ticks;
+
+	/*
+	 * time_low: get low bits of current time and update time_high
+	 * time_high: get high bits of time at last time_low read
+	 */
+	time_low = gf_ioread32(base + TIMER_TIME_LOW);
+	time_high = gf_ioread32(base + TIMER_TIME_HIGH);
+
+	ticks = ((u64)time_high << 32) | time_low;
+
+	return ticks;
+}
+
+static int goldfish_timer_set_oneshot(struct clock_event_device *evt)
+{
+	struct goldfish_timer *timerdrv = ced_to_gf(evt);
+	void __iomem *base = timerdrv->base;
+
+	gf_iowrite32(0, base + TIMER_ALARM_HIGH);
+	gf_iowrite32(0, base + TIMER_ALARM_LOW);
+	gf_iowrite32(1, base + TIMER_IRQ_ENABLED);
+
+	return 0;
+}
+
+static int goldfish_timer_shutdown(struct clock_event_device *evt)
+{
+	struct goldfish_timer *timerdrv = ced_to_gf(evt);
+	void __iomem *base = timerdrv->base;
+
+	gf_iowrite32(0, base + TIMER_IRQ_ENABLED);
+
+	return 0;
+}
+
+static int goldfish_timer_next_event(unsigned long delta,
+				     struct clock_event_device *evt)
+{
+	struct goldfish_timer *timerdrv = ced_to_gf(evt);
+	void __iomem *base = timerdrv->base;
+	u64 now;
+
+	now = goldfish_timer_read(&timerdrv->cs);
+
+	now += delta;
+
+	gf_iowrite32(upper_32_bits(now), base + TIMER_ALARM_HIGH);
+	gf_iowrite32(lower_32_bits(now), base + TIMER_ALARM_LOW);
+
+	return 0;
+}
+
+static irqreturn_t golfish_timer_tick(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct goldfish_timer *timerdrv = ced_to_gf(evt);
+	void __iomem *base = timerdrv->base;
+
+	gf_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+void __init goldfish_timer_init(int irq, void __iomem *base)
+{
+	struct goldfish_timer *timerdrv;
+	int ret;
+
+	timerdrv = kzalloc(sizeof(*timerdrv), GFP_KERNEL);
+	if (!timerdrv)
+		return;
+
+	timerdrv->base = base;
+	timerdrv->irq = irq;
+
+	timerdrv->ced = (struct clock_event_device){
+		.name			= "goldfish_timer",
+		.features		= CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_shutdown	= goldfish_timer_shutdown,
+		.set_state_oneshot      = goldfish_timer_set_oneshot,
+		.set_next_event		= goldfish_timer_next_event,
+	};
+	timerdrv->res = (struct resource){
+		.name  = "goldfish_timer",
+		.start = (unsigned long)base,
+		.end   = (unsigned long)base + 0xfff,
+	};
+
+	if (request_resource(&iomem_resource, &timerdrv->res)) {
+		pr_err("Cannot allocate goldfish-timer resource\n");
+		return;
+	}
+
+	timerdrv->cs = (struct clocksource){
+		.name		= "goldfish_timer",
+		.rating		= 400,
+		.read		= goldfish_timer_read,
+		.mask		= CLOCKSOURCE_MASK(64),
+		.flags		= 0,
+		.max_idle_ns	= LONG_MAX,
+	};
+
+	clocksource_register_hz(&timerdrv->cs, NSEC_PER_SEC);
+
+	ret = request_irq(timerdrv->irq, golfish_timer_tick, IRQF_TIMER,
+			  "goldfish_timer", &timerdrv->ced);
+	if (ret) {
+		pr_err("Couldn't register goldfish-timer interrupt\n");
+		return;
+	}
+
+	clockevents_config_and_register(&timerdrv->ced, NSEC_PER_SEC,
+					1, 0xffffffff);
+}
diff --git a/include/clocksource/timer-goldfish.h b/include/clocksource/timer-goldfish.h
new file mode 100644
index 000000000000..b237267844f1
--- /dev/null
+++ b/include/clocksource/timer-goldfish.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * goldfish-timer clocksource
+ */
+
+#ifndef _CLOCKSOURCE_GOLDFISH_TIMER_H
+#define _CLOCKSOURCE_GOLDFISH_TIMER_H
+
+extern void goldfish_timer_init(int irq, void __iomem *base);
+
+#endif /* _CLOCKSOURCE_GOLDFISH_TIMER_H */
-- 
2.34.1

