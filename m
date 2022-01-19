Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3440F493198
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350405AbiASAF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:05:59 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:46449 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350362AbiASAFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:05:45 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N8GAQ-1mErbF0Bqi-014Dng; Wed, 19
 Jan 2022 01:05:13 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v10 4/5] clocksource/drivers: Add a goldfish-timer clocksource
Date:   Wed, 19 Jan 2022 01:05:05 +0100
Message-Id: <20220119000506.1299843-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119000506.1299843-1-laurent@vivier.eu>
References: <20220119000506.1299843-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kvishkwe6iiVARgzrVfUl7UML0CqT5azoRc51L5oImQ6gOIbysR
 ol10OFkIkz65ZCPiuRZnp5I5fmgkW7NlmUKaZ+YaZFp4IHuS9dLtHsnBIaA/vBYn+xURsSn
 phyHawcA1+I7iZvOR5RFn+euoJ2xagJrkQDIis6qsBadsPNeKnab/04ISznlmiuVep7CVTN
 xTT5vA+H9QitdcBN5ADwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QDP+Gf0OIdA=:MSlaAkLNpvaQdiOOvw/9pl
 xyTSu3eQme8pIulJwfLkLZ+r0NqYl8jSxHVkpoZOqgBL2m6DliRhaVO5AUO1C1aif/VfC3m6B
 DAokki4VMdD/LvassfH6CBH6DjiA3TX5t0utstsLbTh0+QuSE27y5bbkA6suPYjkly5jEZb7E
 RV+c4ucsEuEPwcw30YhLRoPqTowJbE8SRTJK0mJshpdxodBbrFdE5EWVEYz8yyeArgPISFamc
 nPazwGdjdYx4ujDV0BRCeo/keg64A8Kqv3x2FmmRdsD0vRFtwfWMDF8DnsgwD+AynXb6UmCbA
 eXe76V1pmUqiKkWU2ZkCv8Xvng7TYfSDzFwSWlRMJ50xvb+XA1AenKAFMN64RvNq/InMagCu7
 RbP7UwZlP3joHdfrqfjWbzPF/+mZOrirt9InYWIi90MeLA8GajEiHSFyARhau2juoyCPFHQtn
 ea+I9JySERGPckfa5v4sxZgI6mqeidk0z25/JXD4Sf6fmmoVXGV28Gibq5XOuIW2PKcS9jOx6
 HJ38lEmrnbiRa+uQqCABgSKC46SlDWeii/bkPkFFPI4EEW/sBMSxIhaTk1jEDg3cVgW8NlgiJ
 Eu+30AeSiXDapHRLWPLt3fJOey3hx2XCCAIbtXAK9XmQcC9IP5NDvYJxG4KTw83RX1I/hhuNC
 /dGErRRkL+uF34AAWZvzTGy4YGkIjdiM6hvbB/rAriitU3hl14yDp0GrJD64ldh7D+5k=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clocksource based on the goldfish-rtc device.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/clocksource/Kconfig          |   7 ++
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-goldfish.c | 130 +++++++++++++++++++++++++++
 include/clocksource/timer-goldfish.h |  11 +++
 4 files changed, 149 insertions(+)
 create mode 100644 drivers/clocksource/timer-goldfish.c
 create mode 100644 include/clocksource/timer-goldfish.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f65e31bab9ae..fa66fb7156da 100644
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
index 000000000000..e446f9d3cc49
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
+	goldfish_iowrite32(0, base + TIMER_ALARM_HIGH);
+	goldfish_iowrite32(0, base + TIMER_ALARM_LOW);
+	goldfish_iowrite32(1, base + TIMER_IRQ_ENABLED);
+
+	return 0;
+}
+
+static int goldfish_timer_shutdown(struct clock_event_device *evt)
+{
+	struct goldfish_timer *timerdrv = ced_to_gf(evt);
+	void __iomem *base = timerdrv->base;
+
+	goldfish_iowrite32(0, base + TIMER_IRQ_ENABLED);
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
+	goldfish_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
+
+	/*
+	 * time_low: get low bits of current time and update time_high
+	 * time_high: get high bits of time at last time_low read
+	 */
+	now = goldfish_ioread32(base + TIMER_TIME_LOW);
+	now += (u64)goldfish_ioread32(base + TIMER_TIME_HIGH) << 32;
+
+	now += delta;
+
+	goldfish_iowrite32(upper_32_bits(now), base + TIMER_ALARM_HIGH);
+	goldfish_iowrite32(lower_32_bits(now), base + TIMER_ALARM_LOW);
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

