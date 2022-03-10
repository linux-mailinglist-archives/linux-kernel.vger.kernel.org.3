Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC534D4317
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbiCJJHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbiCJJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:07:37 -0500
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 01:06:36 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1427137768;
        Thu, 10 Mar 2022 01:06:36 -0800 (PST)
Received: from quad ([82.142.8.122]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MvbO4-1oKbhb3Gdi-00seeS; Thu, 10
 Mar 2022 10:00:53 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v15 3/5] rtc: goldfish: use gf_ioread32()/gf_iowrite32()
Date:   Thu, 10 Mar 2022 10:00:46 +0100
Message-Id: <20220310090048.1933020-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310090048.1933020-1-laurent@vivier.eu>
References: <20220310090048.1933020-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y1UXGbhiYyMqGUrRT8KMQ9UOt6Sx3ZUCeTlLC3SjudGFfuB5viq
 TO9Y4m/OvnjDvc+ehn3SgSIYKgGaBhGBZttatKB/DmemNTiYlS1/PGR7ulPVKJuBlNGzwhl
 ms5Aazjf4PVmfW7gryyA+1txrpXA3fSzFiEPn2i1NdnZgASoqb78SQqSiyOBdmcPxRH5wci
 /lz0wtZ6gTKm6yTJFkPig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eO0M1qMlxTo=:QyEppZfr6HnBATDy98QkJt
 l/KmYvznQfz36VO5dFxmn7PgV+puYXjeByh7PYgE6CpcfBkrWOwe8/2DHFtqPE8+LcuEXZxLC
 PFQg6iVCxRee7x4CJke0XYO4E6j6phYZehASpAkf9csRIkIqsEpvoygyzYxwZW7YISx7IzQ04
 0P5YF20AtZIeXbgE04o7v9nbF4BfaVp+gDFuRdvCzd4jLntYUCQeQaoRllWI/gnBP6bvzsCfZ
 ULSqVevsuUb6yzDQvGU+oRvXv5eUfhR1Z6f2pKMXkaYgy9QD26sbc6UOCoCWA5JnWq8SBlYKG
 jmqPuevbXYWAPAtSN5TMV7UPbAubDqPCpUWNvVEx9thUyWi8gHpOCliwmS5tlUoxaC0wbYD4g
 tM/phZGJxIU7YIfs9s5RrJSRFA4caLxVHshMzcLzBph+F+fran/1ec+K0bmMnr9XlOZU2QJ0D
 xxquAUxhLrYKH+WSQp++il5pKtDpGrSLAeipNiVym204e+Dt5yA9K1gUURGPUvAI/pm9WLBCo
 AtWyX56dJv5XOBSPWxMgUtB4wISRePsvV5desxTZDY5lGbU+HK6pfptuussXbR2BlYLf9GGKa
 rulidZ61VrD3DD6j8/z0aZs5h7RBcV7nj7NFbFuw06JS51Hyu/Qb0kRSbHKCuqp04/ixkF3s2
 H3DEztIPB+TmbI6a39ZXbW4EYwweKCjLd7U5tX2TuWAn0vzJF2qrjV9uvTntlr9m+euo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace readl()/writel() by gf_ioread32()/gf_iowrite32()
as done for goldfish-tty.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/rtc/rtc-goldfish.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
index 7ab95d052644..eb1929b0cbb6 100644
--- a/drivers/rtc/rtc-goldfish.c
+++ b/drivers/rtc/rtc-goldfish.c
@@ -10,6 +10,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
+#include <linux/goldfish.h>
 
 #define TIMER_TIME_LOW		0x00	/* get low bits of current time  */
 					/*   and update TIMER_TIME_HIGH  */
@@ -41,8 +42,8 @@ static int goldfish_rtc_read_alarm(struct device *dev,
 	rtcdrv = dev_get_drvdata(dev);
 	base = rtcdrv->base;
 
-	rtc_alarm_low = readl(base + TIMER_ALARM_LOW);
-	rtc_alarm_high = readl(base + TIMER_ALARM_HIGH);
+	rtc_alarm_low = gf_ioread32(base + TIMER_ALARM_LOW);
+	rtc_alarm_high = gf_ioread32(base + TIMER_ALARM_HIGH);
 	rtc_alarm = (rtc_alarm_high << 32) | rtc_alarm_low;
 
 	do_div(rtc_alarm, NSEC_PER_SEC);
@@ -50,7 +51,7 @@ static int goldfish_rtc_read_alarm(struct device *dev,
 
 	rtc_time64_to_tm(rtc_alarm, &alrm->time);
 
-	if (readl(base + TIMER_ALARM_STATUS))
+	if (gf_ioread32(base + TIMER_ALARM_STATUS))
 		alrm->enabled = 1;
 	else
 		alrm->enabled = 0;
@@ -71,18 +72,18 @@ static int goldfish_rtc_set_alarm(struct device *dev,
 
 	if (alrm->enabled) {
 		rtc_alarm64 = rtc_tm_to_time64(&alrm->time) * NSEC_PER_SEC;
-		writel((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
-		writel(rtc_alarm64, base + TIMER_ALARM_LOW);
-		writel(1, base + TIMER_IRQ_ENABLED);
+		gf_iowrite32((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
+		gf_iowrite32(rtc_alarm64, base + TIMER_ALARM_LOW);
+		gf_iowrite32(1, base + TIMER_IRQ_ENABLED);
 	} else {
 		/*
 		 * if this function was called with enabled=0
 		 * then it could mean that the application is
 		 * trying to cancel an ongoing alarm
 		 */
-		rtc_status_reg = readl(base + TIMER_ALARM_STATUS);
+		rtc_status_reg = gf_ioread32(base + TIMER_ALARM_STATUS);
 		if (rtc_status_reg)
-			writel(1, base + TIMER_CLEAR_ALARM);
+			gf_iowrite32(1, base + TIMER_CLEAR_ALARM);
 	}
 
 	return 0;
@@ -98,9 +99,9 @@ static int goldfish_rtc_alarm_irq_enable(struct device *dev,
 	base = rtcdrv->base;
 
 	if (enabled)
-		writel(1, base + TIMER_IRQ_ENABLED);
+		gf_iowrite32(1, base + TIMER_IRQ_ENABLED);
 	else
-		writel(0, base + TIMER_IRQ_ENABLED);
+		gf_iowrite32(0, base + TIMER_IRQ_ENABLED);
 
 	return 0;
 }
@@ -110,7 +111,7 @@ static irqreturn_t goldfish_rtc_interrupt(int irq, void *dev_id)
 	struct goldfish_rtc *rtcdrv = dev_id;
 	void __iomem *base = rtcdrv->base;
 
-	writel(1, base + TIMER_CLEAR_INTERRUPT);
+	gf_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
 
 	rtc_update_irq(rtcdrv->rtc, 1, RTC_IRQF | RTC_AF);
 
@@ -128,8 +129,8 @@ static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	rtcdrv = dev_get_drvdata(dev);
 	base = rtcdrv->base;
 
-	time_low = readl(base + TIMER_TIME_LOW);
-	time_high = readl(base + TIMER_TIME_HIGH);
+	time_low = gf_ioread32(base + TIMER_TIME_LOW);
+	time_high = gf_ioread32(base + TIMER_TIME_HIGH);
 	time = (time_high << 32) | time_low;
 
 	do_div(time, NSEC_PER_SEC);
@@ -149,8 +150,8 @@ static int goldfish_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	base = rtcdrv->base;
 
 	now64 = rtc_tm_to_time64(tm) * NSEC_PER_SEC;
-	writel((now64 >> 32), base + TIMER_TIME_HIGH);
-	writel(now64, base + TIMER_TIME_LOW);
+	gf_iowrite32((now64 >> 32), base + TIMER_TIME_HIGH);
+	gf_iowrite32(now64, base + TIMER_TIME_LOW);
 
 	return 0;
 }
-- 
2.35.1

