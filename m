Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A45448F916
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 20:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiAOTdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 14:33:23 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:40031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiAOTdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 14:33:17 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MHGTI-1n4OwM1hR2-00DG1w; Sat, 15
 Jan 2022 20:32:50 +0100
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
Subject: [PATCH v8 2/4] rtc: goldfish: introduce goldfish_ioread32()/goldfish_iowrite32()
Date:   Sat, 15 Jan 2022 20:32:43 +0100
Message-Id: <20220115193245.3777833-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220115193245.3777833-1-laurent@vivier.eu>
References: <20220115193245.3777833-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1oD2+bYAJeJSJIvmfB6U4pqmejOhHUflcI11xDb2WT+REYym74M
 EWTxWsR9PY6B04qmagHRr/eOEg2VnCIT7QbjW9bJUOKvOLrJ72qHJ3OJeT+hh/9Zz5hWxlA
 4dB6NTdvqvKu0C3X/vIiwG/NHXmjPqtZ/dv+lmdHHGkrsyWHzEPcgHsjvs0ASNncX4oxeNS
 fiQmmT/Y626Ikzt+r9Lyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qh+oqGRJQCc=:95WkaeAlRs4LEJse2I7XaL
 tNj1/OJOGv6qYR8lhVbBUGG76KVAWveP2fgm7hk10IV2oMfrNe2tNtCy1j7Rs4Q23Q7X0m2GR
 v1PzJI1jhuYYu51B2ZInbd/raTiEgVOIDNTZiK0P7x6uk3uBha7wHuooScO1VmyQ6rnJKbX7Z
 iJtl5BxwdSnCL+Ytw+haTXvnjST2EtzOWFaDZbSljA4MOw0s1xWWECayG8j7h2F5J7bco9ZKs
 3YDnwKI3NCCVC5WY08IIYZxU9ICEjidzcSTd8YZmYL54LvehJFuefD6UjP60LL1L0BaDhkItt
 7PIGLNBi5eJpGWH22smKPrszNTuy1J4bol/6mFlRyhlAyledj9OSyuI2BvC/vFlwlSpD2kTOe
 c5ALhLQYWnpT/i3mmTrPHGMAoHKD0i8ic+fvT8b/4452xLwy9BaVJC4WqOtDtyD45wMXRN2/g
 e1rtj2BKZh0zz2VoqjHxuUluI0wT2UUsLvoAiF+LsFOZ/mdImG8YX+J67V7TaE1YhHqcsJrA9
 fEn9jmaEWyeXEN7vGcdiSs/ua3KWkMNU0oS4v7NDWab+iX1DWJx5oKycXN6Sf3UijXGQ8TBXH
 k+eRRB8XO1kU7ZAQ4ASDRGcRj1r1bkzesX9vU1K6B0uEudgA6CkXi/sYDMXfD1BDGnCfA+Ny+
 zqBOJ3OF6fVfc2vbYlPVu1sW8b79CoQsR9fg5zMhwKws/xJtr4Iq4reXsK2Y1nZw+s3Q=
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

