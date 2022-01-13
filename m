Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D6848DECF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiAMUT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:19:58 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:39697 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiAMUTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:19:50 -0500
Received: from quad ([82.142.23.158]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MbizQ-1mccMd2wuc-00dCMK; Thu, 13
 Jan 2022 21:19:25 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k@lists.linux-m68k.org,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v6 3/4] clocksource/drivers: Add a goldfish-timer clocksource
Date:   Thu, 13 Jan 2022 21:19:19 +0100
Message-Id: <20220113201920.3201760-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113201920.3201760-1-laurent@vivier.eu>
References: <20220113201920.3201760-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8LedgtcWwvkgVdL96ZL9Y0PPPTjvChn7uwx3tBvh+GeLSSFcLPh
 7+PmUF/N9sRX4vgcIvmhv1OJhpi/08kuR25LM8bTwE15T/RPHJcHJux1xQ5sBtlCEhcQD5F
 eqzDmmMXB15zkpoRPzBJo4toQ3ns+xBtpkBbY2aOxcLwaEqKqF8TwtDNpKbINx6gbuZEC2o
 kKW9HcRY9D1aRAgTu02hg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tycD+lAV9KY=:H6PEOX8oUqAb25tPLy44OB
 hy22F4k286hTqeApe4raXpTnf8Ep/TcD9k9aO8XRcmtyiINq3UxWf0OizgZTZzd93PJ7YUmhM
 Z9LwMdaFX5s62+oXSqBkEHKE33yCw/8OcNp+4yRePF6iOYgBTNoPnXnwATNK8jL47ybtluGtD
 mFyzuqXbz+oOXKjh8Fl0dt9EmFOsR4SRU96ifaGqEgvXOdjquTGj2Caud5ZRhu/rc+vdGsri8
 VHB9qDSuhUWHiOvEPhURDtN61EOF6E/AnQLkamjhq7xcHKocgMSopUpUBSGOfWc27C0rh4cr5
 xOa3DjazxulcvwUcBURhHt57MSNEsfM2Z7Zm5bb8FP/o/PYjAcQhdb/EmMl+uCMZuj5/hlQyV
 zEJYndJOxYpo6p9HW99kWn9p5o39bgHQBKh8t4p7yldhiiTo8n7Whd1A3BiJjtvJD+mDtl1xJ
 e5rQuaSJKdPwfkyw9N9tg5+WiX33nCx88whok4N4gsXgaVDxmAOVxegzQrh5zD7fpsXUIXfUL
 T4VqWf/Wqs/h7M2HGHnAGU+mNLYcN5ts2Sw6ed/q16pILttRVp/j711Bc0TpcuakwV3ui52ib
 qWF5x0WN8EhQAkwZ8BohjJJORjr+44BvcXfsf+HfGLrmKS2Za2xnKrKyKJJDXHonDA29UzBT4
 L/YT+lgWJFL1CmmdTQJjX6tU+XSeuR1NSA7pt1d0SUVDWOcjvcCwsAPcxTfUKwENlULs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clocksource based on the goldfish-rtc device.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/clocksource/Kconfig          |   7 ++
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-goldfish.c | 130 +++++++++++++++++++++++++++
 include/clocksource/timer-goldfish.h |  12 +++
 4 files changed, 150 insertions(+)
 create mode 100644 drivers/clocksource/timer-goldfish.c
 create mode 100644 include/clocksource/timer-goldfish.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f65e31bab9ae..6ca9bb78407d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -711,4 +711,11 @@ config MICROCHIP_PIT64B
 	  modes and high resolution. It is used as a clocksource
 	  and a clockevent.
 
+config GOLDFISH_TIMER
+	bool "Clocksource using goldfish-rtc"
+	select RTC_CLASS
+	select RTC_DRV_GOLDFISH
+	help
+	  Support for the timer/counter of goldfish-rtc
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index c17ee32a7151..e624a1a27027 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
+obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
diff --git a/drivers/clocksource/timer-goldfish.c b/drivers/clocksource/timer-goldfish.c
new file mode 100644
index 000000000000..b1553c3c9456
--- /dev/null
+++ b/drivers/clocksource/timer-goldfish.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/module.h>
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
+static int goldfish_timer_set_oneshot(struct clock_event_device *evt)
+{
+	struct goldfish_timer *timerdrv = ced_to_gf(evt);
+	void __iomem *base = timerdrv->base;
+
+	__raw_writel(0, base + TIMER_ALARM_HIGH);
+	__raw_writel(0, base + TIMER_ALARM_LOW);
+	__raw_writel(1, base + TIMER_IRQ_ENABLED);
+
+	return 0;
+}
+
+static int goldfish_timer_shutdown(struct clock_event_device *evt)
+{
+	struct goldfish_timer *timerdrv = ced_to_gf(evt);
+	void __iomem *base = timerdrv->base;
+
+	__raw_writel(0, base + TIMER_IRQ_ENABLED);
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
+	__raw_writel(1, base + TIMER_CLEAR_INTERRUPT);
+
+	/*
+	 * time_low: get low bits of current time and update time_high
+	 * time_high: get high bits of time at last time_low read
+	 */
+	now = __raw_readl(base + TIMER_TIME_LOW);
+	now += (u64)__raw_readl(base + TIMER_TIME_HIGH) << 32;
+
+	now += delta;
+
+	__raw_writel(upper_32_bits(now), base + TIMER_ALARM_HIGH);
+	__raw_writel(lower_32_bits(now), base + TIMER_ALARM_LOW);
+
+	return 0;
+}
+
+static irqreturn_t golfish_timer_tick(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
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
+		.shift			= 32,
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
+EXPORT_SYMBOL_GPL(goldfish_timer_init);
diff --git a/include/clocksource/timer-goldfish.h b/include/clocksource/timer-goldfish.h
new file mode 100644
index 000000000000..12bcd08f90af
--- /dev/null
+++ b/include/clocksource/timer-goldfish.h
@@ -0,0 +1,12 @@
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
+
-- 
2.34.1

