Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B094F49490C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358401AbiATIEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:04:20 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:48149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345111AbiATIEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:04:13 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MadGG-1mZkpC28pW-00c8Ru; Thu, 20
 Jan 2022 09:03:56 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v11 4/5] clocksource/drivers: Add a goldfish-timer clocksource
Date:   Thu, 20 Jan 2022 09:03:46 +0100
Message-Id: <20220120080347.1595379-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120080347.1595379-1-laurent@vivier.eu>
References: <20220120080347.1595379-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tX47dR4GqPQ8lZzM2rFQxq26QCNH2k5h57dbhZSG8C93GSEZ2Uf
 zZYOBta1y/88sp2igVRuY9DD/r/vM/7C7wUqHGFQhHS8bzULEvwlh2i4Pxc2tI0uzMuZZQZ
 Wly+XED10CXFiTZGITHjRYUHHtWvGPhAFoMlbVzPYpyghOr0m1dOOZ8ie5Z2eYEydT1/jeD
 5Ll864bqeox2nEBeeBA6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fYpxx3P4xJ0=:9pPsDHnzdt9nYu8bTgUcAD
 ZpEd0q0d327UP1Iy6tvrMKDAvsLpMpabnCClqBpL+nRE8NGOmJ8IG5SLH9zkcriIxe1E1qkeC
 04ZHSJU7K4uLWgtADnwzY/ZtRcidSFQ8SKAvhjYenzHuFFFiCx1kVAqOQct7ctHh6aE4eVJBi
 nyIG44pQ8WH7qUlgfwAhGcevoddztKLmxgvbTxENTNq8VYZrZqa4RuujTpLiWAXx2y9/JgHFW
 8e5oQjmV5Aiv1tGyZZcrp2heiS1ImHeBbjiujW/uhek+rrgplzi30RygsNI3W1Nsk9c9xTgXa
 Wul2eta1eUYnBoOY9ypNo7oPDWm/2xPLE/Sa/KHug/LrrF1xa6ZxpwUrrtBWcYJgb4NJfgRvT
 4gLa0ZUw03GMvzdVM6t43Mg4z5TjzQ6va8KmawWzfdHyBKMcxXYnqgE11qKRV1hR1QqNNOljR
 Dd90qX6v8ft2SRKWLR7Rt19yu5Y+o28W7Myi4OKCqmf+Z4/0psG+Gl7+bMYeJHkehpdn9Jg+k
 3bClq578ePTzxdX9PAhIK6MEjadHLhSXj3XyQUn2dUDdAIpral0UubesDcGYcFJdIfN7eddCi
 6obxR6+RDo0p7GLArEkuF9JGpWnHrWN+XXRWf8lzma/UnXYQwYK1SEim51+ytuGn+ppAHVkF1
 b35QrEflhH2I8HDRLbUKJGyAiaFdCffnun+2tbj/NV5El3VWzBYicEr9uaIELX++MHz0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clocksource based on the goldfish-rtc device.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/clocksource/Kconfig          |   7 ++
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-goldfish.c | 162 +++++++++++++++++++++++++++
 include/clocksource/timer-goldfish.h |  11 ++
 4 files changed, 181 insertions(+)
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
index 000000000000..b57c964b3dda
--- /dev/null
+++ b/drivers/clocksource/timer-goldfish.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/module.h>
+#include <linux/slab.h>
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

