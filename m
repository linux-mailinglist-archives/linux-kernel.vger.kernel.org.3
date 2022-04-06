Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A79D4F6C80
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiDFVWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiDFVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:22:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3C6BCA7;
        Wed,  6 Apr 2022 13:16:00 -0700 (PDT)
Received: from quad ([82.142.17.26]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N3bCH-1o2d1u18mh-010fI0; Wed, 06
 Apr 2022 22:15:29 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v16 3/4] clocksource/drivers: Add a goldfish-timer clocksource
Date:   Wed,  6 Apr 2022 22:15:22 +0200
Message-Id: <20220406201523.243733-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406201523.243733-1-laurent@vivier.eu>
References: <20220406201523.243733-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fa6nVRSYP60DJJ7IN53EUW6THMMrld7ThAIQf6yX6tGks3VpoaD
 CMetn/JiQBvmm1jZU6FpgGLx9A8m0xBGIKHA/FoxgVnYLzq76OmwNBPZOyBM+ACr4gCxg8x
 d85P1svsztkdDml3ryNqiDQvj7P4hIQ/RFsxIZVbtdvlPsjiKLaqzWzHTs9JKgdybClakBl
 SG2nB33wav5KprrYtjITw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zGXdslg5nQU=:1vT41QB0mrU5h8CNAQ+5X/
 DTyDneGT7oEnjmLkE2zhxVskxn0VrVFnWg6gn8CoUjHoxXcyi/g1iuzeS2h0XFnWDTOL6VvuL
 rfQbsIxuW+6OKRBTNPJpxhWHhqKtwY3CqmQMv5A1s9Y5D8U7THRpwtTFaDMiI80/DN0UoCSk7
 yfrAJjvGfn1PUvxy3ItgXW2+6nbns5RBCkaDdTCNWhn72ceWGaA/wi8KoI1cwfU5sikW1W9VK
 is/HVXoNdot2ZFktNwDMmVZ5a+ZB7PMW91D79XswJXLIA9NuNJMasJ+ChS6ywcY+IGwOgdmUo
 wjq7SBTtn3tHEWzg6ZkH0DNvFvXZK6nc29Plf5OFh3tlnOC9xv4hIJY42VTIZ4aT+H0UXNKat
 jlhFLaCVz3cXWbBdv8hhWmqG9SOFS3Xy4jH5+s435Bi8FdOfZisTr1rApezgYSSiUyF7irT4e
 DqRT/t5q7HqesF7UYa2/TFXBFKJ0Shxi5W7QiXJLpDOD3RD8xorTXQPIHTk4LhscxsGDqDtnZ
 wdSBDoqPXrvyItaOr+n76/0nhfVvwHrYjOqyENw2/3j+OI8foZUb05Sqq1aCLj25LEdbtXIxt
 2gsDVGZZIZfisDxsmzeUAAmbT3A9m3QJbHakvkLa7a32TZ9pAEUvXBYgUW38zJS/10f77lCaq
 XUYMn3Qa+5BpE5xrfBAoE/MPeIqUQiJ6enmNi/AolGIXgKNeRdQ7BTQLcy1HzjlXedHI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clocksource based on the goldfish-rtc device.

Move the timer register definition to <clocksource/timer-goldfish.h>

This kernel implementation is based on the QEMU upstream implementation:

   https://git.qemu.org/?p=qemu.git;a=blob_plain;f=hw/rtc/goldfish_rtc.c

goldfish-timer is a high-precision signed 64-bit nanosecond timer.
It is part of the 'goldfish' virtual hardware platform used to run
some emulated Android systems under QEMU.
This timer only supports oneshot event.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig          |   7 ++
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-goldfish.c | 153 +++++++++++++++++++++++++++
 drivers/rtc/rtc-goldfish.c           |  13 +--
 include/clocksource/timer-goldfish.h |  31 ++++++
 5 files changed, 193 insertions(+), 12 deletions(-)
 create mode 100644 drivers/clocksource/timer-goldfish.c
 create mode 100644 include/clocksource/timer-goldfish.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1589ae7d5abb..06866bfa1826 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -711,4 +711,11 @@ config MICROCHIP_PIT64B
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
index 9c85ee2bb373..b839beb6ea53 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
 obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
+obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
diff --git a/drivers/clocksource/timer-goldfish.c b/drivers/clocksource/timer-goldfish.c
new file mode 100644
index 000000000000..0512d5eabc82
--- /dev/null
+++ b/drivers/clocksource/timer-goldfish.c
@@ -0,0 +1,153 @@
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
+struct goldfish_timer {
+	struct clocksource cs;
+	struct clock_event_device ced;
+	struct resource res;
+	void __iomem *base;
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
+static irqreturn_t goldfish_timer_irq(int irq, void *dev_id)
+{
+	struct goldfish_timer *timerdrv = dev_id;
+	struct clock_event_device *evt = &timerdrv->ced;
+	void __iomem *base = timerdrv->base;
+
+	gf_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+int __init goldfish_timer_init(int irq, void __iomem *base)
+{
+	struct goldfish_timer *timerdrv;
+	int ret;
+
+	timerdrv = kzalloc(sizeof(*timerdrv), GFP_KERNEL);
+	if (!timerdrv)
+		return -ENOMEM;
+
+	timerdrv->base = base;
+
+	timerdrv->ced = (struct clock_event_device){
+		.name			= "goldfish_timer",
+		.features		= CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_shutdown	= goldfish_timer_shutdown,
+		.set_state_oneshot      = goldfish_timer_set_oneshot,
+		.set_next_event		= goldfish_timer_next_event,
+	};
+
+	timerdrv->res = (struct resource){
+		.name  = "goldfish_timer",
+		.start = (unsigned long)base,
+		.end   = (unsigned long)base + 0xfff,
+	};
+
+	ret = request_resource(&iomem_resource, &timerdrv->res);
+	if (ret) {
+		pr_err("Cannot allocate '%s' resource\n", timerdrv->res.name);
+		return ret;
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
+	ret = request_irq(irq, goldfish_timer_irq, IRQF_TIMER,
+			  "goldfish_timer", timerdrv);
+	if (ret) {
+		pr_err("Couldn't register goldfish-timer interrupt\n");
+		return ret;
+	}
+
+	clockevents_config_and_register(&timerdrv->ced, NSEC_PER_SEC,
+					1, 0xffffffff);
+
+	return 0;
+}
diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
index eb1929b0cbb6..59c0f38cc08d 100644
--- a/drivers/rtc/rtc-goldfish.c
+++ b/drivers/rtc/rtc-goldfish.c
@@ -11,18 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 #include <linux/goldfish.h>
-
-#define TIMER_TIME_LOW		0x00	/* get low bits of current time  */
-					/*   and update TIMER_TIME_HIGH  */
-#define TIMER_TIME_HIGH	0x04	/* get high bits of time at last */
-					/*   TIMER_TIME_LOW read         */
-#define TIMER_ALARM_LOW	0x08	/* set low bits of alarm and     */
-					/*   activate it                 */
-#define TIMER_ALARM_HIGH	0x0c	/* set high bits of next alarm   */
-#define TIMER_IRQ_ENABLED	0x10
-#define TIMER_CLEAR_ALARM	0x14
-#define TIMER_ALARM_STATUS	0x18
-#define TIMER_CLEAR_INTERRUPT	0x1c
+#include <clocksource/timer-goldfish.h>
 
 struct goldfish_rtc {
 	void __iomem *base;
diff --git a/include/clocksource/timer-goldfish.h b/include/clocksource/timer-goldfish.h
new file mode 100644
index 000000000000..05a3a4f610d6
--- /dev/null
+++ b/include/clocksource/timer-goldfish.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * goldfish-timer clocksource
+ * Registers definition for the goldfish-timer device
+ */
+
+#ifndef _CLOCKSOURCE_TIMER_GOLDFISH_H
+#define _CLOCKSOURCE_TIMER_GOLDFISH_H
+
+/*
+ * TIMER_TIME_LOW	 get low bits of current time and update TIMER_TIME_HIGH
+ * TIMER_TIME_HIGH	 get high bits of time at last TIMER_TIME_LOW read
+ * TIMER_ALARM_LOW	 set low bits of alarm and activate it
+ * TIMER_ALARM_HIGH	 set high bits of next alarm
+ * TIMER_IRQ_ENABLED	 enable alarm interrupt
+ * TIMER_CLEAR_ALARM	 disarm an existing alarm
+ * TIMER_ALARM_STATUS	 alarm status (running or not)
+ * TIMER_CLEAR_INTERRUPT clear interrupt
+ */
+#define TIMER_TIME_LOW		0x00
+#define TIMER_TIME_HIGH		0x04
+#define TIMER_ALARM_LOW		0x08
+#define TIMER_ALARM_HIGH	0x0c
+#define TIMER_IRQ_ENABLED	0x10
+#define TIMER_CLEAR_ALARM	0x14
+#define TIMER_ALARM_STATUS	0x18
+#define TIMER_CLEAR_INTERRUPT	0x1c
+
+extern int goldfish_timer_init(int irq, void __iomem *base);
+
+#endif /* _CLOCKSOURCE_TIMER_GOLDFISH_H */
-- 
2.35.1

