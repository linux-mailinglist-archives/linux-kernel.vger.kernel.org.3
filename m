Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0C348FDFE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiAPQvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 11:51:20 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:37789 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiAPQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 11:51:13 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MtOOm-1mK3Bh2Hde-00upva; Sun, 16
 Jan 2022 17:50:55 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k@lists.linux-m68k.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v9 2/4] rtc: goldfish: introduce goldfish_ioread32()/goldfish_iowrite32()
Date:   Sun, 16 Jan 2022 17:50:49 +0100
Message-Id: <20220116165051.120826-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116165051.120826-1-laurent@vivier.eu>
References: <20220116165051.120826-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+k1FifxnRr8+ISOTLHm6WqlQsIQaRoVY6Z83ax8p5wBA8cD2Tyc
 nVMAMV2wLRlXvXALWqksmqr7ARM0KJ9MwbJLtNIENPsHQLydQWd7KU7JOD75XowHT9oSoAv
 uw1KcRYP9WnXKEXMQS6jFjp1jS37mecIzpbVFsLSHpwpwvqyeZ0aACswVQFK4+XsmRxy+Jt
 c3DVA26WkozM3L3vXIALA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:veMA0nMWdjM=:i75S6vO+lnRqRqnxkbBPR8
 0ml/9CqhE+UL24AMW939SL+hmNsDrhlkInu/OQeUzQCHGsyvdF/CatAuvSQQBWlWqM0JWEXoq
 ZHIcbn8xmPnxG9gN4GMyZwxB3BeanFacGE24MhRYcNZ+MlMZpSTIZ3+oSg01Vp1xI+5utj1el
 RBq9RO8F+x+c4rjS/bs9YFchxapIBcI8rFGmWqPQeCbBzJhTDtmITktcI7o83TqxKDb+KNPSp
 xGmU7RlWkd82V3uLlfTlgKxrJZqAmYaGvl13wlx/jKlpgfThA8Po9xy9KmRnvJI+FUBbxOT+G
 2rMTVN2kI8L6XG9C704L0Wqo5q860BS49AR18YSuq0F8xSrs2SCMJRhd/XfwRHCNSr43syvFP
 B1P4cAetq9bae6zB25MbeKy/2i14T1lIPwoiVFwkRvfq+VboJ4ndCi9CcOOdzsdpKPs9D+ZMS
 zeVuyahz7MU3LQHMjhewGnDctmm/kG8AwmjE/p/1V1Dp8TtojMrVK866CqBog3PjU9AVCbBFT
 8mwi6Dz6x6bA/ZGZTBSSSuqgiOm8b9w/nvAX9oaUlYXcm/eai7yEvAf6TrcwQ7aFtUdcmJITs
 wXl1qK3/6HSTkRFRMvfe3gsgD7nSIQF4KqdP/+PfoC1bmrev2bq0ul2/1CJ8WqXYTCVnzsYaq
 HDr3GAoglrPNGbr0DueEH315SDDggzW82pZYVwyqakyy6X6/DofXhjs6t6ohHt8vkyyE=
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
 drivers/rtc/rtc-goldfish.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
index 7ab95d052644..611cc6123bbe 100644
--- a/drivers/rtc/rtc-goldfish.c
+++ b/drivers/rtc/rtc-goldfish.c
@@ -23,6 +23,14 @@
 #define TIMER_ALARM_STATUS	0x18
 #define TIMER_CLEAR_INTERRUPT	0x1c
 
+#ifdef CONFIG_M68K
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
@@ -41,8 +49,8 @@ static int goldfish_rtc_read_alarm(struct device *dev,
 	rtcdrv = dev_get_drvdata(dev);
 	base = rtcdrv->base;
 
-	rtc_alarm_low = readl(base + TIMER_ALARM_LOW);
-	rtc_alarm_high = readl(base + TIMER_ALARM_HIGH);
+	rtc_alarm_low = goldfish_ioread32(base + TIMER_ALARM_LOW);
+	rtc_alarm_high = goldfish_ioread32(base + TIMER_ALARM_HIGH);
 	rtc_alarm = (rtc_alarm_high << 32) | rtc_alarm_low;
 
 	do_div(rtc_alarm, NSEC_PER_SEC);
@@ -50,7 +58,7 @@ static int goldfish_rtc_read_alarm(struct device *dev,
 
 	rtc_time64_to_tm(rtc_alarm, &alrm->time);
 
-	if (readl(base + TIMER_ALARM_STATUS))
+	if (goldfish_ioread32(base + TIMER_ALARM_STATUS))
 		alrm->enabled = 1;
 	else
 		alrm->enabled = 0;
@@ -71,18 +79,18 @@ static int goldfish_rtc_set_alarm(struct device *dev,
 
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
@@ -98,9 +106,9 @@ static int goldfish_rtc_alarm_irq_enable(struct device *dev,
 	base = rtcdrv->base;
 
 	if (enabled)
-		writel(1, base + TIMER_IRQ_ENABLED);
+		goldfish_iowrite32(1, base + TIMER_IRQ_ENABLED);
 	else
-		writel(0, base + TIMER_IRQ_ENABLED);
+		goldfish_iowrite32(0, base + TIMER_IRQ_ENABLED);
 
 	return 0;
 }
@@ -110,7 +118,7 @@ static irqreturn_t goldfish_rtc_interrupt(int irq, void *dev_id)
 	struct goldfish_rtc *rtcdrv = dev_id;
 	void __iomem *base = rtcdrv->base;
 
-	writel(1, base + TIMER_CLEAR_INTERRUPT);
+	goldfish_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
 
 	rtc_update_irq(rtcdrv->rtc, 1, RTC_IRQF | RTC_AF);
 
@@ -128,8 +136,8 @@ static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	rtcdrv = dev_get_drvdata(dev);
 	base = rtcdrv->base;
 
-	time_low = readl(base + TIMER_TIME_LOW);
-	time_high = readl(base + TIMER_TIME_HIGH);
+	time_low = goldfish_ioread32(base + TIMER_TIME_LOW);
+	time_high = goldfish_ioread32(base + TIMER_TIME_HIGH);
 	time = (time_high << 32) | time_low;
 
 	do_div(time, NSEC_PER_SEC);
@@ -149,8 +157,8 @@ static int goldfish_rtc_set_time(struct device *dev, struct rtc_time *tm)
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

