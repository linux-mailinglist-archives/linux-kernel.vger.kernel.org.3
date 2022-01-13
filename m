Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F9E48D5DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiAMKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:36:15 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiAMKgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:36:12 -0500
Received: from quad ([82.142.23.158]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N6srB-1mH9zg468N-018LVz; Thu, 13
 Jan 2022 11:36:04 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Laurent Vivier <laurent@vivier.eu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 3/3] m68k: virt: Remove LEGACY_TIMER_TICK
Date:   Thu, 13 Jan 2022 11:35:59 +0100
Message-Id: <20220113103559.2577216-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113103559.2577216-1-laurent@vivier.eu>
References: <20220113103559.2577216-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CxVx98xeVEfHEM6vPf1+SJx0Fa5YyWVWggpaPIfWOJJOJARZwmk
 kT1krpbVTeQXpDnjLoSbF4AIqyopWeI4VX7a3+0QfilteKz/G8a3eKHA3gYyBgJ5hRliaYx
 dg+GTBeRqBlkd0xlXQXga1tI7CBlGdX5Rhq07U/YssoWRH1eF9IL/Xxavy9BWRjXuFgNFAq
 ssuRFI8KXDyF5GHwmeyzQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JB+uTI4NO90=:DzncB3KMar501Wxfs34FCc
 a2FwheJ9+4gVzLXI2/pY3xXFMJFvxfMJ8esJ9YMhRDCinNoD6YLhiXDFsm8ChjNl1NzQmIKDj
 6s4cs0kUhoDo3DH4kkpgEdv29qP7uk16BRDSzmduIS4Ij0A86wm3YwTcj7ybgP5FrEU4f8Jz/
 4q+cROTPEDgj5H7mP4lyenxHOeNnruCD/AMdHtEOitH1C1alvdtahO/xAZcRv9HRm0d8f8rdv
 Vg/uNz2bKoVPzwyBZ88aAFHmsOThFOWAcRaUfSKKOy1pY717+wsAskUAIgpp/O90BlojJpeBM
 Zo04uGgjkZhmx4zXl98R+4Y3uP804of95iHj4dbPzdZEr/vliMYSxUq02XgvEdsJBqjAdRkHo
 DKphlTt1jD0CRlVZTMsPiS26aB6IJqAHz3Ya0RWi8PMeaaxiEK7EX0W6VuJ5u2JIcTAbvwIhz
 FZToaoike1RwKqg8R7DqTG7FRuPq2e01RzBddZJK5fXgJtUKW4QAkYq1aThqeb0uIdKjDzWng
 GYSixr1zrdDSZXbgllTSH5F+yWXDP+xe6161maA+kc5si0SYkwkH+Gpf0xV4Rm54P7nagwep2
 x/zDfLdbIVraYhbuTPoW0x9jIamIhI0dId66DMPzVhPx3Ke3kMDRMT7AvpKDuXDfN6N7bPfPN
 sBqhZFHi1BvMP0Hx2juQx8qs1sV+PGUzrh42Wtd7DTwqAI1b720/J/p9e2myRpMP3/eo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move virt machine to generic clockevents.

cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 arch/m68k/Kconfig.machine |  2 +-
 arch/m68k/virt/timer.c    | 56 ++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 769c5b38fe16..03e5254ed73a 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -152,7 +152,7 @@ config SUN3
 config VIRT
 	bool "Virtual M68k Machine support"
 	depends on MMU
-	select LEGACY_TIMER_TICK
+	select GENERIC_CLOCKEVENTS
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

