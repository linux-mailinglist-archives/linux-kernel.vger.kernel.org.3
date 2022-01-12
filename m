Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF448CDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiALVjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:39:24 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:54981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiALVjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:39:18 -0500
Received: from quad ([82.142.23.158]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MFbBO-1n8MDM0glq-00HAXY; Wed, 12
 Jan 2022 22:39:06 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Laurent Vivier <laurent@vivier.eu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 3/3] m68k: virt: Remove LEGACY_TIMER_TICK
Date:   Wed, 12 Jan 2022 22:39:01 +0100
Message-Id: <20220112213901.2178667-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112213901.2178667-1-laurent@vivier.eu>
References: <20220112213901.2178667-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YXtM90aHK1d0OvIhVyXWSgykMR28ld+QZcz3xqT1FE55S6fbL2g
 2XLUVIPCPCcc0cITaHfkR1/1JTWpVqsYttX+FHiZRPHn2vs0OV9m58vIHvifcb2xlccHjJF
 uV+hlJsEhHvz49jJPR2hBLTxk5WijKSYPi5+MW7Jj/R2qqrpkRRICvmY/PlCCjqkGrX6zzz
 KHhzN6PcXqAoqXeeNri9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:teksdMZ8okw=:Pa5JvdQsPVOSQbzhA3t5YU
 DrZAO9tmjLOIk4lQu9+dmMsozylLLm7DOgX//1UuZ+rK3Xf+k9SxT4bFl4casS7YjZ5Kjl9Mg
 IGmrkBrvoLoEHTTsn5OYOaWZQ6Oqpz1rI8HkDQPYyZ4PSj7biLYYKKfAEz+Wi4RYeZUCjp+AB
 PJIp4NBLOeM84gCMWzk+5w317SVi3wSvu8Sb5Q7cmdM0jTcUl+qCzdfAt5EWcJATVsoKoW7qS
 ArAQ6Ok3V8qem4ciBZJG5/TEKnrGab70jLSLornk0PL1A2N4JEn/NTrWu11ibuDULtPAtrykE
 D1jXl1X2SFSbwg4x4IY44++in2YL3SxdRga08++OWXBl4UTwGhJ7jL0Hy8GHEWnWEPMCQW9iJ
 B52gVwburOrCGBE2WOMLRFov/hCpxSnbfaaz30Eza7jnIlQaFgv3ltepOoqC+A+G2g2VuG1AW
 Mq0tlaXO+smcmyEo2koNcFGyhPZXDBLmJCqaOt9mCeBI1cRjQlYDxRp0YYyzJI8hdgrxXn7OH
 lMm1HcSs8Xpe7Eoe8+4YUHvY8HEWI2OPz85FWQ4YiLE0EJO+Abog3FJEyh8ecuUn2hAPYnB46
 xceey3lE4QNAtRQqyvGYt/BySyXMxgVe8CQD+NXCeg0AP9qSiEsVu7Tk5mwC8PKN4hylfyQdu
 lQculNAc23dZeJtbqjBNTIeRIG4RUGR1e+CZ1Q+wsUS6LtmedKeEO7fxbFwkbRARnfCE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move virt machine to generic clockevents.

cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 arch/m68k/Kconfig.machine |  1 -
 arch/m68k/virt/timer.c    | 56 ++++++++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 769c5b38fe16..74a2354bc226 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -152,7 +152,6 @@ config SUN3
 config VIRT
 	bool "Virtual M68k Machine support"
 	depends on MMU
-	select LEGACY_TIMER_TICK
 	select M68040
 	select MMU_MOTOROLA if MMU
 	select GOLDFISH
diff --git a/arch/m68k/virt/timer.c b/arch/m68k/virt/timer.c
index 843bf6ed7e1a..767b01f75abb 100644
--- a/arch/m68k/virt/timer.c
+++ b/arch/m68k/virt/timer.c
@@ -3,6 +3,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 #include <asm/virt.h>
 
 struct goldfish_timer {
@@ -41,7 +42,25 @@ static struct clocksource goldfish_timer = {
 	.max_idle_ns	= LONG_MAX,
 };
 
-static irqreturn_t golfish_timer_handler(int irq, void *dev_id)
+static int goldfish_timer_set_oneshot(struct clock_event_device *evt)
+{
+	gf_timer->alarm_high = 0;
+	gf_timer->alarm_low = 0;
+
+	gf_timer->irq_enabled = 1;
+
+	return 0;
+}
+
+static int goldfish_timer_shutdown(struct clock_event_device *evt)
+{
+	gf_timer->irq_enabled = 0;
+
+	return 0;
+}
+
+static int goldfish_timer_next_event(unsigned long delta,
+				     struct clock_event_device *evt)
 {
 	u64 now;
 
@@ -49,19 +68,35 @@ static irqreturn_t golfish_timer_handler(int irq, void *dev_id)
 
 	now = goldfish_timer_read(NULL);
 
-	legacy_timer_tick(1);
+	now += delta;
 
-	now += NSEC_PER_SEC / HZ;
 	gf_timer->alarm_high = upper_32_bits(now);
 	gf_timer->alarm_low = lower_32_bits(now);
 
+	return 0;
+}
+
+struct clock_event_device goldfish_timer_clockevent = {
+	.name			= "goldfish_timer",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= goldfish_timer_shutdown,
+	.set_state_oneshot      = goldfish_timer_set_oneshot,
+	.set_next_event		= goldfish_timer_next_event,
+	.shift			= 32,
+};
+
+static irqreturn_t golfish_timer_tick(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &goldfish_timer_clockevent;
+
+	evt->event_handler(evt);
+
 	return IRQ_HANDLED;
 }
 
 void __init virt_sched_init(void)
 {
 	static struct resource sched_res;
-	u64 now;
 
 	sched_res.name  = "goldfish_timer";
 	sched_res.start = virt_bi_data.rtc.mmio;
@@ -72,19 +107,14 @@ void __init virt_sched_init(void)
 		return;
 	}
 
-	if (request_irq(virt_bi_data.rtc.irq, golfish_timer_handler, IRQF_TIMER,
+	clockevents_config_and_register(&goldfish_timer_clockevent, NSEC_PER_SEC,
+					1, 0xffffffff);
+
+	if (request_irq(virt_bi_data.rtc.irq, golfish_timer_tick, IRQF_TIMER,
 			"timer", NULL)) {
 		pr_err("Couldn't register timer interrupt\n");
 		return;
 	}
 
-	now = goldfish_timer_read(NULL);
-	now += NSEC_PER_SEC / HZ;
-
-	gf_timer->clear_interrupt = 1;
-	gf_timer->alarm_high = upper_32_bits(now);
-	gf_timer->alarm_low = lower_32_bits(now);
-	gf_timer->irq_enabled = 1;
-
 	clocksource_register_hz(&goldfish_timer, NSEC_PER_SEC);
 }
-- 
2.34.1

