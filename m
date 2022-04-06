Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786DB4F6C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiDFV0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiDFVZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:25:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE6E387;
        Wed,  6 Apr 2022 13:21:11 -0700 (PDT)
Received: from quad ([82.142.17.26]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MJEpp-1nIc2t18Tj-00KhmC; Wed, 06
 Apr 2022 22:15:28 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v16 2/4] rtc: goldfish: use gf_ioread32()/gf_iowrite32()
Date:   Wed,  6 Apr 2022 22:15:21 +0200
Message-Id: <20220406201523.243733-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406201523.243733-1-laurent@vivier.eu>
References: <20220406201523.243733-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:440bktU+LghY03EMHGCKgFXTVMJpkJ4k9h7er7klmnABur2bVos
 U10voJxwau+eTzJihzRv/oyVj4t73P7k4Wbpc5T3aBeeN97Ymmmk1MaQoOgzHhKDeLFWr/l
 dHpz3prcD/4eLTyQA9uORG3qDIKkonE4J+jfLJu6uBnvK5/LKQ00954R1NmuvdZjNkGfbxi
 /pP7oTTDvudFDZaXO1hzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BMwy4i+q7T8=:5fTMTNfg5EfyaH8FCAGKcT
 bY/jyPCHg4DIuZEq6O9GgO3Uq20MPHhXNtG0IlQ8OJ6Y8kbv7bxVEpgeRwmc7xFrBmQUA0Xco
 Gan5iFxqd8fC5JVuy9/yDdjxMq9RDIGnx+GwJBlBKxQzcpbZhaq3lrgsVLl6WSQE2q4di/hKB
 72NGZ4OXVTNUeW2R/VUtZ4FbfdSrsDXRa3hBUXKumScH5e7VwN6SVBS34DDWMhRZ1EyUVGWpk
 nGZjbvJ0QhtB5OVMipGHd/qiyKfZtZG7Q5Meb37Vl8ZYYU47ztHXgmG8N/z2qJtip1tgsKdCM
 t7BuQScWNnp9N7l+OrqIlWoeCIX31AnZy5MX9mI4JH0hjN6IfGkHN8EIhRApay0rKghr1U+xR
 BnfmHn5JSMPJTSNDn/gKbCkji2RjYNPZwlEU1WbPgIB3giTeIS99luZkxQr7lWs5PmGvY5Juv
 TVKgxszJe8/USQT4tP82rJOFrK5q6i/U8WaSD/QJC3BZ9x0LYp8ew052O2KzzkoHzQKkjHX+T
 KIf3EBPl+lxFPAAqA2nc9hO7u8g/wJSmSxybSd190LGUA0KruV4Hn1SSXR7cmz6T7L6q4gk6s
 rWVrTTEncGTi4fjAgAlnsWYbN++CuAwIUR5NTEmFAmoQdv3T7ecijP0ur0zHDozYLOuDfoSe2
 N8a86xDoKPAjbn8V7T3mCoeKW54ATEdzeAHaeQKn+MrlaxSkQXAGnRI/bqJwvXE8fOTk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace readl()/writel() by gf_ioread32()/gf_iowrite32()
as done for goldfish-tty.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
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

