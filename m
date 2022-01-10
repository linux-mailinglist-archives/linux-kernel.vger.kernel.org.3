Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F877489926
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiAJNC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiAJNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D6FC03400B;
        Mon, 10 Jan 2022 04:59:55 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:59:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSdcEpLAcMHS+NOyUotEDNwDWy+JgJyIrfkaKD/bGCo=;
        b=j2Gq6aF5Npq0+iFE+4miaYP14UuSJUfDEMpWcpd5RN2p43rv3G36XIvfJZ1MYvoj3erSPJ
        PQoBunlncQP0biXJvrg9mFTatoojA2+HmY+qVDw49HZEL3nCenYKJaT7eVVLFKt2FXyZJa
        4Nd4ygb28RWhsewfjQpcMIToOCvE2E+CfuwFge4eR6ZaZegl8EwmodatgyCRzgyJKKn+xM
        3EfZIxeUsH5Vgrg3LKvDsOjbJlgsAwHl5LvTh9utXrJ1IfykfecMgALYYPrp401hXSmPv+
        N+jx1j8iBSWRn6hQid7S5Vc6oDwQGhslOetO0EBUH6b3+TKmst2oKNyooiG6JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSdcEpLAcMHS+NOyUotEDNwDWy+JgJyIrfkaKD/bGCo=;
        b=SwSdqDbvdvwnpzZp78zP8Vat38fJBxDb964wDeqrlkrmRkj3KnvJky/h+RuMJ0IKcn4d0H
        chMV1Agl4WZLbxAg==
From:   "tip-bot2 for Romain Perier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers: Add MStar MSC313e timer support
Cc:     Romain Perier <romain.perier@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211217195727.8955-2-romain.perier@gmail.com>
References: <20211217195727.8955-2-romain.perier@gmail.com>
MIME-Version: 1.0
Message-ID: <164181959270.16921.10853551289437755976.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5fc1f93f69989e72be7a84ded6ee867d6415f690
Gitweb:        https://git.kernel.org/tip/5fc1f93f69989e72be7a84ded6ee867d6415f690
Author:        Romain Perier <romain.perier@gmail.com>
AuthorDate:    Fri, 17 Dec 2021 20:57:22 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 20 Dec 2021 13:28:28 +01:00

clocksource/drivers: Add MStar MSC313e timer support

The MSC313e-compatible SoCs have 3 timer hardware blocks. All of these
are free running 32-bit increasing counters and can generate interrupts.
Based onto a maximum value register, each timer can either count from 0
to max, one time then stop (which generates interrupts) or can count
from 0 to max and then roll. This commit adds basic support for these
timers, the first timer block being used as clocksource/sched_clock
and delay, while the others will be used as clockevents.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Co-developed-by: Daniel Palmer <daniel@0x0f.com>
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Link: https://lore.kernel.org/r/20211217195727.8955-2-romain.perier@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS                         |   1 +-
 drivers/clocksource/Kconfig         |   9 +-
 drivers/clocksource/Makefile        |   1 +-
 drivers/clocksource/timer-msc313e.c | 244 +++++++++++++++++++++++++++-
 4 files changed, 255 insertions(+)
 create mode 100644 drivers/clocksource/timer-msc313e.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345c..f39a161 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2282,6 +2282,7 @@ F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
 F:	arch/arm/boot/dts/mstar-*
 F:	arch/arm/mach-mstar/
 F:	drivers/clk/mstar/
+F:	drivers/clocksource/timer-msc313e.c
 F:	drivers/gpio/gpio-msc313.c
 F:	drivers/rtc/rtc-msc313.c
 F:	drivers/watchdog/msc313e_wdt.c
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 821ea4a..cfb8ea0 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -672,6 +672,15 @@ config MILBEAUT_TIMER
 	help
 	  Enables the support for Milbeaut timer driver.
 
+config MSC313E_TIMER
+	bool "MSC313E timer driver" if COMPILE_TEST
+	select TIMER_OF
+	select CLKSRC_MMIO
+	help
+	  Enables support for the MStar MSC313E timer driver.
+	  This provides access to multiple interrupt generating
+	  programmable 32-bit free running incrementing counters.
+
 config INGENIC_TIMER
 	bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
 	default MACH_INGENIC
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index c17ee32..fa5f624 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
+obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
diff --git a/drivers/clocksource/timer-msc313e.c b/drivers/clocksource/timer-msc313e.c
new file mode 100644
index 0000000..154e734
--- /dev/null
+++ b/drivers/clocksource/timer-msc313e.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MStar timer driver
+ *
+ * Copyright (C) 2021 Daniel Palmer
+ * Copyright (C) 2021 Romain Perier
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#ifdef CONFIG_ARM
+#include <linux/delay.h>
+#endif
+
+#include "timer-of.h"
+
+#define TIMER_NAME "msc313e_timer"
+
+#define MSC313E_REG_CTRL		0x00
+#define MSC313E_REG_CTRL_TIMER_EN	BIT(0)
+#define MSC313E_REG_CTRL_TIMER_TRIG	BIT(1)
+#define MSC313E_REG_CTRL_TIMER_INT_EN	BIT(8)
+#define MSC313E_REG_TIMER_MAX_LOW	0x08
+#define MSC313E_REG_TIMER_MAX_HIGH	0x0c
+#define MSC313E_REG_COUNTER_LOW		0x10
+#define MSC313E_REG_COUNTER_HIGH	0x14
+
+#define TIMER_SYNC_TICKS		3
+
+#ifdef CONFIG_ARM
+struct msc313e_delay {
+	void __iomem *base;
+	struct delay_timer delay;
+};
+static struct msc313e_delay msc313e_delay;
+#endif
+
+static void __iomem *msc313e_clksrc;
+
+static void msc313e_timer_stop(void __iomem *base)
+{
+	writew(0, base + MSC313E_REG_CTRL);
+}
+
+static void msc313e_timer_start(void __iomem *base, bool periodic)
+{
+	u16 reg;
+
+	reg = readw(base + MSC313E_REG_CTRL);
+	if (periodic)
+		reg |= MSC313E_REG_CTRL_TIMER_EN;
+	else
+		reg |= MSC313E_REG_CTRL_TIMER_TRIG;
+	writew(reg | MSC313E_REG_CTRL_TIMER_INT_EN, base + MSC313E_REG_CTRL);
+}
+
+static void msc313e_timer_setup(void __iomem *base, unsigned long delay)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	writew(delay >> 16, base + MSC313E_REG_TIMER_MAX_HIGH);
+	writew(delay & 0xffff, base + MSC313E_REG_TIMER_MAX_LOW);
+	local_irq_restore(flags);
+}
+
+static unsigned long msc313e_timer_current_value(void __iomem *base)
+{
+	unsigned long flags;
+	u16 l, h;
+
+	local_irq_save(flags);
+	l = readw(base + MSC313E_REG_COUNTER_LOW);
+	h = readw(base + MSC313E_REG_COUNTER_HIGH);
+	local_irq_restore(flags);
+
+	return (((u32)h) << 16 | l);
+}
+
+static int msc313e_timer_clkevt_shutdown(struct clock_event_device *evt)
+{
+	struct timer_of *timer = to_timer_of(evt);
+
+	msc313e_timer_stop(timer_of_base(timer));
+
+	return 0;
+}
+
+static int msc313e_timer_clkevt_set_oneshot(struct clock_event_device *evt)
+{
+	struct timer_of *timer = to_timer_of(evt);
+
+	msc313e_timer_stop(timer_of_base(timer));
+	msc313e_timer_start(timer_of_base(timer), false);
+
+	return 0;
+}
+
+static int msc313e_timer_clkevt_set_periodic(struct clock_event_device *evt)
+{
+	struct timer_of *timer = to_timer_of(evt);
+
+	msc313e_timer_stop(timer_of_base(timer));
+	msc313e_timer_setup(timer_of_base(timer), timer_of_period(timer));
+	msc313e_timer_start(timer_of_base(timer), true);
+
+	return 0;
+}
+
+static int msc313e_timer_clkevt_next_event(unsigned long evt, struct clock_event_device *clkevt)
+{
+	struct timer_of *timer = to_timer_of(clkevt);
+
+	msc313e_timer_stop(timer_of_base(timer));
+	msc313e_timer_setup(timer_of_base(timer), evt);
+	msc313e_timer_start(timer_of_base(timer), false);
+
+	return 0;
+}
+
+static irqreturn_t msc313e_timer_clkevt_irq(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static u64 msc313e_timer_clksrc_read(struct clocksource *cs)
+{
+	return msc313e_timer_current_value(msc313e_clksrc) & cs->mask;
+}
+
+#ifdef CONFIG_ARM
+static unsigned long msc313e_read_delay_timer_read(void)
+{
+	return msc313e_timer_current_value(msc313e_delay.base);
+}
+#endif
+
+static u64 msc313e_timer_sched_clock_read(void)
+{
+	return msc313e_timer_current_value(msc313e_clksrc);
+}
+
+static struct clock_event_device msc313e_clkevt = {
+	.name = TIMER_NAME,
+	.rating = 300,
+	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown = msc313e_timer_clkevt_shutdown,
+	.set_state_periodic = msc313e_timer_clkevt_set_periodic,
+	.set_state_oneshot = msc313e_timer_clkevt_set_oneshot,
+	.tick_resume = msc313e_timer_clkevt_shutdown,
+	.set_next_event = msc313e_timer_clkevt_next_event,
+};
+
+static int __init msc313e_clkevt_init(struct device_node *np)
+{
+	int ret;
+	struct timer_of *to;
+
+	to = kzalloc(sizeof(*to), GFP_KERNEL);
+	if (!to)
+		return -ENOMEM;
+
+	to->flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE;
+	to->of_irq.handler = msc313e_timer_clkevt_irq;
+	ret = timer_of_init(np, to);
+	if (ret)
+		return ret;
+
+	msc313e_clkevt.cpumask = cpu_possible_mask;
+	msc313e_clkevt.irq = to->of_irq.irq;
+	to->clkevt = msc313e_clkevt;
+
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
+					TIMER_SYNC_TICKS, 0xffffffff);
+	return 0;
+}
+
+static int __init msc313e_clksrc_init(struct device_node *np)
+{
+	struct timer_of to = { 0 };
+	int ret;
+	u16 reg;
+
+	to.flags = TIMER_OF_BASE | TIMER_OF_CLOCK;
+	ret = timer_of_init(np, &to);
+	if (ret)
+		return ret;
+
+	msc313e_clksrc = timer_of_base(&to);
+	reg = readw(msc313e_clksrc + MSC313E_REG_CTRL);
+	reg |= MSC313E_REG_CTRL_TIMER_EN;
+	writew(reg, msc313e_clksrc + MSC313E_REG_CTRL);
+
+#ifdef CONFIG_ARM
+	msc313e_delay.base = timer_of_base(&to);
+	msc313e_delay.delay.read_current_timer = msc313e_read_delay_timer_read;
+	msc313e_delay.delay.freq = timer_of_rate(&to);
+
+	register_current_timer_delay(&msc313e_delay.delay);
+#endif
+
+	sched_clock_register(msc313e_timer_sched_clock_read, 32, timer_of_rate(&to));
+	return clocksource_mmio_init(timer_of_base(&to), TIMER_NAME, timer_of_rate(&to), 300, 32,
+				     msc313e_timer_clksrc_read);
+}
+
+static int __init msc313e_timer_init(struct device_node *np)
+{
+	int ret = 0;
+	static int num_called;
+
+	switch (num_called) {
+	case 0:
+		ret = msc313e_clksrc_init(np);
+		if (ret)
+			return ret;
+		break;
+
+	default:
+		ret = msc313e_clkevt_init(np);
+		if (ret)
+			return ret;
+		break;
+	}
+
+	num_called++;
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(msc313, "mstar,msc313e-timer", msc313e_timer_init);
