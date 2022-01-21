Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E2E49662B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 21:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiAUUIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 15:08:10 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:58049 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAUUIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 15:08:09 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mw9Lw-1mLW2S12Rw-00s5pz; Fri, 21
 Jan 2022 21:07:48 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v12 3/5] rtc: goldfish: use gf_ioread32()/gf_iowrite32()
Date:   Fri, 21 Jan 2022 21:07:36 +0100
Message-Id: <20220121200738.2577697-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121200738.2577697-1-laurent@vivier.eu>
References: <20220121200738.2577697-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wMc9aE7SFhI7ob7vc3dfBy3RQ4C731TguCOa+Fbg8SfX8eSNBwH
 WyCC1Z2nARQd/EkrKPQO49x4Gwdz73YUsShXk+pNkAu5w36sSzKx+YlgHTSZQF5+X331XQ3
 oMMKs8SG9uDrvuDp4q44xnK/zQqQPEEOT13m/n6SrPD69SIKm2MQ2eE0a41L7E73g5yd+Lh
 fqbPmwobKkCiHkjyYZ0oQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dXI6QUoe4hs=:jubA7W0XAkAQpKv/ggIbaU
 aoYyBvb+WURmh9pkbCsEznOaIhQZzRh9zyFfnHNQJCNrdMqiGcOHSpKdf4fe5Ka5huKFg2FXB
 GkbVC9MLlPnGGR9lbS4295pKX3ADX+rEfsfL/U2NHKVzuTEgxojR9wSWMvIFdK/yVC7ZWKli9
 de6CrLLx0Blk66qe9P0MfM+0Pn9HsvowTQwf9qne9GQLbg3EjMMp0IEJZqPXSFql8A0gGquLu
 ZxjlVMIU4LjuWMB4qlxlUjnC/gB5dTmTW5az4yee8qv0mPG6DeYTtfFfOROQL2TrRsiWfTVWT
 4Qe2IxMOuyavIOyEHAh5+wB6rkXsRgP0fmQ5zl5fzYrqn2+J8H4yc9n8PMLzLQ8TrvD9n6SXT
 BdPAyCv3stv0Q1xvEVHxi9pHKelK9aPyJzpXzcNVvTtTAkOpJo4DwkyJNWz42AQNqZU2oWnAc
 hfb/5oxdd2CgUCMxQEOeWU9ag6/nz0NsvbBa8/kshQAmba2XKoOU/yq6PxJ+ALF4A5K5HCwXJ
 NiPutnJ11jh4CHc2qvYTi6lNlj4HXYzTBeoSH4gXAvRJ0D9kvLcjej1qYSDwME7YklmbVPmaY
 JWqFxE8WL8HtsS9YDwR61vC12Q7//M2vrHBMsmkgQfnykEJqUMVzTEijH6W9N9/8oZN/k+Mql
 2mcJvK37ACOAShH4MlHQwcsPoEXRI1w0B6I5aaRuw0zGsMOHTNluBcGHYYCTwC3HUbyQ=
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

