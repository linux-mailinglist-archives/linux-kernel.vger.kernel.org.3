Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB84A3168
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 19:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353098AbiA2SnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 13:43:14 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:34927 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353020AbiA2SnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 13:43:03 -0500
Received: from quad ([82.142.10.94]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M7bJ5-1nAJuE20Xl-0082Ye; Sat, 29
 Jan 2022 19:42:31 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-rtc@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v13 3/5] rtc: goldfish: use gf_ioread32()/gf_iowrite32()
Date:   Sat, 29 Jan 2022 19:42:23 +0100
Message-Id: <20220129184225.407100-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129184225.407100-1-laurent@vivier.eu>
References: <20220129184225.407100-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gBBypLL0zhyZ/uCuEHR8GlI2hgXr3Kkh1FDj+Smyq8swU4oM2T0
 mTzSGljOqRnDTUKYmgFsXf5fgptHJhS+u6bYPI1W5aoWl9sYzQrC+XEXIToum8jK8EmI2cs
 hOQB8NYgmIrtIWxkAdOPjBq3ALoMf+0bgxWpki2kB1WdzbZ89dahUL88eiTpfmZGz2QoeLB
 T8b3dOVROwcjBAtbFnYng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CD2/P4Ijn8k=:NW1RI8Xsp7IfDjlhuRhiU/
 Owg+BtAAfIME/BIwb2n07J5P+R0bTm3awUR++qfVwD0DtAEtg7RnpLdhcivOqNMtqhJbkNvrB
 taWkh684dpdNUwMKJctkfpfXIrv+6/PwPJdAbzsBy65q9NcXz2Z8HTHN2plmU3G4AdMAeMKIf
 A/PCCpZidF5lGCw881zwpX1zc04gnExvlX0DnYhPKJRNNvfy48xgcQDZ2QS5lQeqm3aJ/e2s7
 0av0FxXnMvsPHdoCtX7HFEbAv44wTdv/lyJ38MXhkdW1Z4/Aw7JigZUcvZiYNquALIgGwWnFi
 a/DCtXpGuautg40PZodEChe/NAPSyF6xDGbVBGS4Q5vZIdzhuNzhxCy0+dHIQi+mNkjxsZj/F
 93XIzC+2awQC6eEJwIvwlpjEPnb/L7yKA2zWSMsMeFAVREmEbtUfCpFC+YrW58R5R+lxVeX7s
 ROSgM6Mz+6OmI/hyMm5A/OaEko37Jfr7HnzqvCSpX9Q2yar1yTE0uuN4401uniqpsOk1vg3Js
 0fYDcbCwvDvtMfVMhoiKMaPSigvOOBenbwlkru9Ywj80cl9ndMlE3qRBVw8zi0r5DIQn2+gSW
 qWPvtT+ycaia89G6PgSp+CoxxJd81RR94py2/BAqOoAwpB2t6vhIiAzWEtLO6vjAXDj1T47iD
 5Khoynm83kfWAruWSffqp8I6C1U46RfHziTBT0glxsd7Mw8UvpXpUh/j1LqP3sTLkHKs=
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
2.34.1

