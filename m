Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B125A48F911
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 20:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiAOTdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 14:33:16 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:49587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiAOTdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 14:33:15 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M8yU2-1nDn8v1qgY-0064Eo; Sat, 15
 Jan 2022 20:32:51 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>, linux-rtc@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v8 3/4] clocksource/drivers: Add a goldfish-timer clocksource
Date:   Sat, 15 Jan 2022 20:32:44 +0100
Message-Id: <20220115193245.3777833-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220115193245.3777833-1-laurent@vivier.eu>
References: <20220115193245.3777833-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zoqsBoCh8ZlMtPVaWutscqm+5PpM4Llwm15xPA1RwGoqxZbIJxy
 1FiIPKzBS6cO5DP90DGC7mnuBMarkuSKfcrIzfZAQa2sW5KJQjZKEnUhunnDrCovaMhkjir
 wkk/uqSjEhgia9CmwkmDFPm87eXtVvvvwBN/gdB+S0CBvVi4uC+zZmb1rQbABuyzEdv5t9g
 poxDL3JcmkSlvJwjRWacQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YcMs1PesKa8=:QxAKRxUrWQc/sXzXrt5fpZ
 qwzEjAFzziC5PjxMwdPZnqNII6+klv2PIlxTnD8Nyp0X+2iyoRK9AWD3bOCieXDXHiihdzxaM
 mzoHDPWpiYyGcv46zlB6bzx685ASJtfHaiQtcXQwKxKdeU2pvDktsZ75wbPMOIIjMXnkk3ZWr
 hPb13JE/pGNf4i4Uld6X4r4Di08GWNr18HBVdQHpKYTh6GyJExN1cMUczyLu50nDPPGbe4C1B
 u5ii2TjjZ2W7uezyalrNNO6VeMSX1CT81YxV4WN+wZZansvMe3sDlQA1mCZh+AKZc1jjpW9YZ
 0Kw1REK3DSvIFQ5gJMt67W7f2N5TxiqANBGHmn/d2c/EvBwq443KTiojNbCtjAF8jr4hG/YhQ
 W07/9XSAn5rZheX49+KV4+IBkOqAsRCrw1qYyaourCWkGxUTeFN2LY77NH5ElgQkNMGg3JR8B
 DNu3OmY0rmAYB62oDOMo5iWV2/LmZjWPD1fklxvA01lE+YsE45l2y1slqI1ulwTkrkY0MkwFe
 cS7a2z3g+A6h3euABvkGduQ1rVpqa+WQt6l+yP8Zxwyqvm+ZxOQRbKb9KSNW72/e1Yjg0Gphh
 RJQclA2XIhdhSuuZwm38ChNw3Q5WfxsixqY1fTRQrEohkp0qYkOC+LycBvDH2677qcx41dE44
 DblsenN9QsS8M5AGIJ2qfyB+c5xLy25PhNvj2B3Gj8WGeOcuw4OU7Mbe+moiNSFxIwzw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clocksource based on the goldfish-rtc device.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/clocksource/Kconfig          |   7 ++
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-goldfish.c | 139 +++++++++++++++++++++++++++
 include/clocksource/timer-goldfish.h |  11 +++
 4 files changed, 158 insertions(+)
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
index 000000000000..9bf9ac8c4f5c
--- /dev/null
+++ b/drivers/clocksource/timer-goldfish.c
@@ -0,0 +1,139 @@
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
+/* goldfish endianness depends on CPU endianness */
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define goldfish_ioread32 ioread32be
+#define goldfish_iowrite32 iowrite32be
+#else
+#define goldfish_ioread32 ioread32
+#define goldfish_iowrite32 iowrite32
+#endif
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

