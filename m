Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28D548EAB2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241265AbiANN3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:29:18 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiANN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:29:15 -0500
Received: from quad ([82.142.23.158]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MeCxd-1magJE0mql-00bGPO; Fri, 14
 Jan 2022 14:28:55 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k@lists.linux-m68k.org, Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v7 2/4] rtc: goldfish: introduce goldfish_ioread32()/goldfish_iowrite32()
Date:   Fri, 14 Jan 2022 14:28:48 +0100
Message-Id: <20220114132850.3433263-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114132850.3433263-1-laurent@vivier.eu>
References: <20220114132850.3433263-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r9oaTQRHsQi7/MFbkp7YcRW4JOPgbV9avLWyU2ZYNUXoO+uFMh8
 Bnxad1NhIssPLw8lGJ+N81M+K+gvlkiS61u5KeAR8lPu2OprhbxvRXjGE2axSaRvmGeii/H
 7p7ivpkqeXY74jiVf5QYe20ZSuBDcw/1QsXIMLe0H/LSqzCcqY6i3juDV5yH3PGFba1LLv7
 11z8Jaz4WDCltZbCqQ+dw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BxyMxjc3W7I=:JlOXhbdbHodklNLkkbK+Fw
 NLuBc2kma1EDEAAHAftFK0wIQyZhDeYfPJs3GMAfJBzLaF4bd8F6fHuHge8ON2dkc3nlLolGY
 yHb/iFSMm8Q73rbfT/XJbfuzpjNNttO2tb12f9T5Lio0jUuHK784xiaO0Be6CljxnRgsNKKVq
 w3csDl1Bm7qh6wbrQambPDILf8wArZJj6fvlReSvymHUGqkL86i2osv1vz2Df3sIoxBNQxmrT
 lcbZ5EWzYicup62InmCv85SWR4ixN68z0epnbvumwBJaYlSBqjyW0SQHJeE6fga5XqALI4dM+
 /c10FYO7hqSS7XaK3nVl3qh7VJb5rpF2RSPr2SgkihFy2mkvvU7KrJ9MqHCLtVTtvNIdtyC8G
 bjug/YoVAsIrTkU2ZjV1Xuhi8eFGnffdYn73/Engvv6YgO+pW0TZM95fbsISJXFzKB7GtcOuC
 /IGryJHbaxNogUBSavgkhc2KqbLpHysRc6/sZ8YX5cinL75LTmpaBhM2mhe4EeZJaUJWUxwrc
 SQ2uZgmXCAZAnx/1WZ+8UPbYv0BzJkhwKt5D+YXs6uTJaepXRykwKE8lHZW5p/i2PtVRpr2JQ
 A596h2RTQ1et1mGsgA6rV2eN60nzNYIExbG6/35A9LPBJEp1tYSCgZ732q9OrwTndG3Fb2JPk
 96JRaoQiHV0j9aWYj0DBvY61JY7xRNgsZWBJYlTiF4EGnyA+C51mgllqGH9Ns8z4JQC4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goldfish device always uses the same endianness as the architecture
using it:
https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/timer/goldfish_timer.c#177

On a big-endian machine, the device is also big-endian, on a
little-endian machine the device is little-endian.

So we need to use the right accessor to read/write values to the goldfish
registers: ioread32()/iowrite32() on a little-endian machine,
ioread32be()/iowrite32be() on a big-endian machine.

This patch introduces goldfish_ioread32()/goldfish_iowrite32() that uses
the expected accessor according to the machine endianness.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/rtc/rtc-goldfish.c | 39 +++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
index 7ab95d052644..b0cae4729b03 100644
--- a/drivers/rtc/rtc-goldfish.c
+++ b/drivers/rtc/rtc-goldfish.c
@@ -23,6 +23,15 @@
 #define TIMER_ALARM_STATUS	0x18
 #define TIMER_CLEAR_INTERRUPT	0x1c
 
+/* goldfish endianness depends on CPU endianness */
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define goldfish_ioread32 ioread32be
+#define goldfish_iowrite32 iowrite32be
+#else
+#define goldfish_ioread32 ioread32
+#define goldfish_iowrite32 iowrite32
+#endif
+
 struct goldfish_rtc {
 	void __iomem *base;
 	int irq;
@@ -41,8 +50,8 @@ static int goldfish_rtc_read_alarm(struct device *dev,
 	rtcdrv = dev_get_drvdata(dev);
 	base = rtcdrv->base;
 
-	rtc_alarm_low = readl(base + TIMER_ALARM_LOW);
-	rtc_alarm_high = readl(base + TIMER_ALARM_HIGH);
+	rtc_alarm_low = goldfish_ioread32(base + TIMER_ALARM_LOW);
+	rtc_alarm_high = goldfish_ioread32(base + TIMER_ALARM_HIGH);
 	rtc_alarm = (rtc_alarm_high << 32) | rtc_alarm_low;
 
 	do_div(rtc_alarm, NSEC_PER_SEC);
@@ -50,7 +59,7 @@ static int goldfish_rtc_read_alarm(struct device *dev,
 
 	rtc_time64_to_tm(rtc_alarm, &alrm->time);
 
-	if (readl(base + TIMER_ALARM_STATUS))
+	if (goldfish_ioread32(base + TIMER_ALARM_STATUS))
 		alrm->enabled = 1;
 	else
 		alrm->enabled = 0;
@@ -71,18 +80,18 @@ static int goldfish_rtc_set_alarm(struct device *dev,
 
 	if (alrm->enabled) {
 		rtc_alarm64 = rtc_tm_to_time64(&alrm->time) * NSEC_PER_SEC;
-		writel((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
-		writel(rtc_alarm64, base + TIMER_ALARM_LOW);
-		writel(1, base + TIMER_IRQ_ENABLED);
+		goldfish_iowrite32((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
+		goldfish_iowrite32(rtc_alarm64, base + TIMER_ALARM_LOW);
+		goldfish_iowrite32(1, base + TIMER_IRQ_ENABLED);
 	} else {
 		/*
 		 * if this function was called with enabled=0
 		 * then it could mean that the application is
 		 * trying to cancel an ongoing alarm
 		 */
-		rtc_status_reg = readl(base + TIMER_ALARM_STATUS);
+		rtc_status_reg = goldfish_ioread32(base + TIMER_ALARM_STATUS);
 		if (rtc_status_reg)
-			writel(1, base + TIMER_CLEAR_ALARM);
+			goldfish_iowrite32(1, base + TIMER_CLEAR_ALARM);
 	}
 
 	return 0;
@@ -98,9 +107,9 @@ static int goldfish_rtc_alarm_irq_enable(struct device *dev,
 	base = rtcdrv->base;
 
 	if (enabled)
-		writel(1, base + TIMER_IRQ_ENABLED);
+		goldfish_iowrite32(1, base + TIMER_IRQ_ENABLED);
 	else
-		writel(0, base + TIMER_IRQ_ENABLED);
+		goldfish_iowrite32(0, base + TIMER_IRQ_ENABLED);
 
 	return 0;
 }
@@ -110,7 +119,7 @@ static irqreturn_t goldfish_rtc_interrupt(int irq, void *dev_id)
 	struct goldfish_rtc *rtcdrv = dev_id;
 	void __iomem *base = rtcdrv->base;
 
-	writel(1, base + TIMER_CLEAR_INTERRUPT);
+	goldfish_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
 
 	rtc_update_irq(rtcdrv->rtc, 1, RTC_IRQF | RTC_AF);
 
@@ -128,8 +137,8 @@ static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	rtcdrv = dev_get_drvdata(dev);
 	base = rtcdrv->base;
 
-	time_low = readl(base + TIMER_TIME_LOW);
-	time_high = readl(base + TIMER_TIME_HIGH);
+	time_low = goldfish_ioread32(base + TIMER_TIME_LOW);
+	time_high = goldfish_ioread32(base + TIMER_TIME_HIGH);
 	time = (time_high << 32) | time_low;
 
 	do_div(time, NSEC_PER_SEC);
@@ -149,8 +158,8 @@ static int goldfish_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	base = rtcdrv->base;
 
 	now64 = rtc_tm_to_time64(tm) * NSEC_PER_SEC;
-	writel((now64 >> 32), base + TIMER_TIME_HIGH);
-	writel(now64, base + TIMER_TIME_LOW);
+	goldfish_iowrite32((now64 >> 32), base + TIMER_TIME_HIGH);
+	goldfish_iowrite32(now64, base + TIMER_TIME_LOW);
 
 	return 0;
 }
-- 
2.34.1

