Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3854E48FF3A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 22:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiAPVjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 16:39:41 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:33536 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiAPVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 16:39:37 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:fcd:c16e:b544:6e84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 020C6292935;
        Sun, 16 Jan 2022 22:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1642369175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJMFMn9s8STk4S2DCf6Twl2pp/xi4XwXH5qJ+uvsl0M=;
        b=Kvf9zld2ZmCwotIqDmyuYd0GPaiBdpNFB8kMyc5zGkb+Fn1K4kclZkOhwX029vGwLVjsLM
        Nqr5ntpe9Nho0E3Wo04LnJULb1PEryDpyGzLinOiALQlLYsuwDgSEXU6JLxZ2bclY/GcaO
        iW0gSOM5i/1/1PzFSw9wUnsCRd1jQm4+wjFkGfy1FhSLhvSwFhYzXehAdVDNZQ3L5B2X/z
        YdcsuXzVJcX7kp268/SNaIGR/qdUPxRD8SY7WmQ3R+6YoAHZmMZgsQlCrFLOqKW27dza4O
        wdl4BwLfWPK0ZHOd9DqCNnYi3Mm+jhfqmG/KqoUy5XzdY6rfyhU1a6DhJ2vLUg==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH 2/2] clocksource/drivers: Add Realtek Otto timer driver
Date:   Sun, 16 Jan 2022 22:39:25 +0100
Message-Id: <2fb4aa29e8c581f5c7e97ab7678ccb34e99e5c6e.1642369117.git.sander@svanheule.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642369117.git.sander@svanheule.net>
References: <cover.1642369117.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver to provide initial support for the timer/counter blocks found on
Realtek Otto MIPS SoCs.

This implementation hard enables the derived clock with a divisor of 2,
to obtain the highest possible timer resolution. A real derived and
reconfigurable timer clock can be implemented later, should the need
arise for longer timeouts.

Since this platform has other clocksources (CSRC_R4K or MIPS GIC), the
timers are only added as clockevent devices.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 MAINTAINERS                              |   6 +
 drivers/clocksource/Kconfig              |   8 +
 drivers/clocksource/Makefile             |   1 +
 drivers/clocksource/timer-realtek-otto.c | 216 +++++++++++++++++++++++
 4 files changed, 231 insertions(+)
 create mode 100644 drivers/clocksource/timer-realtek-otto.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d9dafd09de0..ad7c9b10fcd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16342,6 +16342,12 @@ S:	Maintained
 F:	include/sound/rt*.h
 F:	sound/soc/codecs/rt*
 
+REALTEK OTTO TIMER
+M:	Sander Vanheule <sander@svanheule.net>
+S:	Maintained
+F:	Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml
+F:	drivers/clocksource/timer-realtek-otto.c
+
 REALTEK OTTO WATCHDOG
 M:	Sander Vanheule <sander@svanheule.net>
 L:	linux-watchdog@vger.kernel.org
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cfb8ea0df3b1..03557568182d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -84,6 +84,14 @@ config IXP4XX_TIMER
 	help
 	  Enables support for the Intel XScale IXP4xx SoC timer.
 
+config REALTEK_OTTO_TIMER
+	bool "Realtek Otto timer driver"
+	depends on MACH_REALTEK_RTL || COMPILE_TEST
+	select TIMER_OF
+	help
+	  Enables support for the timer/counter found on Realtek's networking
+	  SoC series RTL838x, RTL839x, RTL930x, RTL931x.
+
 config ROCKCHIP_TIMER
 	bool "Rockchip timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index fa5f624eadb6..43c792e4a574 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
 obj-$(CONFIG_IXP4XX_TIMER)	+= timer-ixp4xx.o
+obj-$(CONFIG_REALTEK_OTTO_TIMER)      += timer-realtek-otto.o
 obj-$(CONFIG_ROCKCHIP_TIMER)      += timer-rockchip.o
 obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
diff --git a/drivers/clocksource/timer-realtek-otto.c b/drivers/clocksource/timer-realtek-otto.c
new file mode 100644
index 000000000000..2c07be042614
--- /dev/null
+++ b/drivers/clocksource/timer-realtek-otto.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Realtek Otto platform timer/counter
+ *
+ * Copyright
+ *	Sander Vanheule - 2022
+ *
+ * Up-counting 28-bit timer that can operate in oneshot or repeat mode,
+ * providing interrupts at roll-over. The maximum value is written to the DATA
+ * register, while the current timer value can be read from the CNT register.
+ *
+ * A divided clock is used to drive the timer, derived from the bus clock. The
+ * clock divisor is configurable from 2 to 65535. Divisor values of 0 and 1
+ * disable the timer clock. The timer can also be enabled independently from
+ * the clock selection with the ENABLE flag.
+ *
+ * The SoC's interrupt controller can configure the CPU affinity of the timer
+ * interrupts to any subset of the available CPUs.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include "timer-of.h"
+
+struct otto_tc_ctrl {
+	struct timer_of to;
+	spinlock_t lock;
+};
+
+#define OTTO_TC_REG_OFFSET(to, offset)	(timer_of_base(to) + offset)
+
+#define OTTO_TC_REG_DATA(to)		OTTO_TC_REG_OFFSET(to, 0x0)
+#define OTTO_TC_REG_CNT(to)		OTTO_TC_REG_OFFSET(to, 0x4)
+#define OTTO_TC_WIDTH			28
+#define OTTO_TC_MAX_PERIOD		BIT(OTTO_TC_WIDTH)
+
+#define OTTO_TC_REG_CTL(to)		OTTO_TC_REG_OFFSET(to, 0x8)
+#define OTTO_TC_CTL_ENABLE		BIT(28)
+#define OTTO_TC_CTL_MODE		BIT(24)
+#define OTTO_TC_MODE_ONESHOT		FIELD_PREP(OTTO_TC_CTL_MODE, 0)
+#define OTTO_TC_MODE_REPEAT		FIELD_PREP(OTTO_TC_CTL_MODE, 1)
+#define OTTO_TC_CTL_DIVISOR		GENMASK(15, 0)
+
+#define OTTO_TC_MIN_DIVISOR		2
+#define OTTO_TC_MAX_DIVISOR		OTTO_TC_CTL_DIVISOR
+
+#define OTTO_TC_REG_ICTL(to)		OTTO_TC_REG_OFFSET(to, 0xC)
+#define OTTO_TC_ICTL_ENABLE		BIT(20)
+#define OTTO_TC_ICTL_STATUS		BIT(16)
+
+static inline void otto_tc_irq_enable_clear(struct timer_of *to)
+{
+	writel(OTTO_TC_ICTL_ENABLE | OTTO_TC_ICTL_STATUS, OTTO_TC_REG_ICTL(to));
+}
+
+static inline struct otto_tc_ctrl *otto_tc_timer_to_ctrl(struct timer_of *to)
+{
+	return container_of(to, struct otto_tc_ctrl, to);
+}
+
+static irqreturn_t otto_tc_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *ced = dev_id;
+	struct timer_of *to = to_timer_of(ced);
+
+	otto_tc_irq_enable_clear(to);
+	ced->event_handler(ced);
+
+	return IRQ_HANDLED;
+}
+
+static void otto_tc_set_divisor(struct otto_tc_ctrl *ctrl, u16 divisor)
+{
+	struct timer_of *to = &ctrl->to;
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	val = readl(OTTO_TC_REG_CTL(to)) & ~OTTO_TC_CTL_DIVISOR;
+	val |= FIELD_PREP(OTTO_TC_CTL_DIVISOR, divisor);
+	writel(val, OTTO_TC_REG_CTL(to));
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+}
+
+static void otto_tc_set_timeout(struct clock_event_device *ced, u32 value)
+{
+	struct timer_of *to = to_timer_of(ced);
+	struct otto_tc_ctrl *ctrl = otto_tc_timer_to_ctrl(to);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	writel(value, OTTO_TC_REG_DATA(to));
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+}
+
+/*
+ * Timers can only be (re)started from the disabled state. The clkevt state
+ * machine is expected perform the necessary disables (shutdown) before moving
+ * a timer into an enabled state through .set_oneshot() or .set_periodic().
+ */
+static void otto_tc_set_mode(struct clock_event_device *ced, bool started, u32 mode)
+{
+	struct timer_of *to = to_timer_of(ced);
+	struct otto_tc_ctrl *ctrl = otto_tc_timer_to_ctrl(to);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	val = readl(OTTO_TC_REG_CTL(to));
+	val = (val & ~OTTO_TC_CTL_MODE) | mode;
+	if (started)
+		val |= OTTO_TC_CTL_ENABLE;
+	else
+		val &= ~OTTO_TC_CTL_ENABLE;
+	writel(val, OTTO_TC_REG_CTL(to));
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+}
+
+static int otto_tc_set_next_event(unsigned long evt, struct clock_event_device *ced)
+{
+	otto_tc_set_timeout(ced, evt);
+
+	return 0;
+}
+
+static int otto_tc_set_periodic(struct clock_event_device *ced)
+{
+	struct timer_of *to = to_timer_of(ced);
+
+	otto_tc_set_timeout(ced, timer_of_period(to));
+	otto_tc_set_mode(ced, true, OTTO_TC_MODE_REPEAT);
+
+	return 0;
+}
+
+static int otto_tc_set_oneshot(struct clock_event_device *ced)
+{
+	otto_tc_set_mode(ced, true, OTTO_TC_MODE_ONESHOT);
+
+	return 0;
+}
+
+static int otto_tc_set_oneshot_stopped(struct clock_event_device *ced)
+{
+	otto_tc_set_mode(ced, false, OTTO_TC_MODE_ONESHOT);
+
+	return 0;
+}
+
+static int otto_tc_set_shutdown(struct clock_event_device *ced)
+{
+	otto_tc_set_mode(ced, false, 0);
+
+	return 0;
+}
+
+static void __init otto_tc_init_clkevt(struct timer_of *to)
+{
+	struct clock_event_device *ced = &to->clkevt;
+
+	ced->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC |
+		CLOCK_EVT_FEAT_DYNIRQ;
+	ced->set_next_event = otto_tc_set_next_event;
+	ced->set_state_periodic = otto_tc_set_periodic;
+	ced->set_state_oneshot = otto_tc_set_oneshot;
+	ced->set_state_oneshot_stopped = otto_tc_set_oneshot_stopped;
+	ced->set_state_shutdown = otto_tc_set_shutdown;
+	ced->cpumask = cpumask_of(0);
+	ced->rating = 300;
+
+	clockevents_config_and_register(ced, timer_of_rate(to), 1, OTTO_TC_MAX_PERIOD);
+}
+
+static int __init otto_tc_init(struct device_node *node)
+{
+	struct otto_tc_ctrl *ctrl;
+	int err;
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	spin_lock_init(&ctrl->lock);
+
+	ctrl->to.flags = TIMER_OF_BASE | TIMER_OF_IRQ | TIMER_OF_CLOCK;
+	ctrl->to.of_clk.name = "bus";
+	ctrl->to.of_irq.flags = IRQF_TIMER;
+	ctrl->to.of_irq.handler = otto_tc_handler;
+
+	err = timer_of_init(node, &ctrl->to);
+	if (err)
+		goto err_out;
+
+	/* Reset timer state */
+	writel(0, OTTO_TC_REG_CTL(&ctrl->to));
+	writel(0, OTTO_TC_REG_DATA(&ctrl->to));
+
+	/* TODO Replace by a real derived clock */
+	otto_tc_set_divisor(ctrl, OTTO_TC_MIN_DIVISOR);
+	ctrl->to.of_clk.rate /= OTTO_TC_MIN_DIVISOR;
+	ctrl->to.of_clk.period /= OTTO_TC_MIN_DIVISOR;
+
+	otto_tc_irq_enable_clear(&ctrl->to);
+	otto_tc_init_clkevt(&ctrl->to);
+
+	return 0;
+
+err_out:
+	kfree(ctrl);
+
+	return err;
+}
+TIMER_OF_DECLARE(otto_tc, "realtek,otto-tc", otto_tc_init);
-- 
2.34.1

