Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F648DEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiAMUTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:19:45 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:49435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiAMUTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:19:45 -0500
Received: from quad ([82.142.23.158]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MTREY-1ml6Zc2oyi-00Tohu; Thu, 13
 Jan 2022 21:19:24 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k@lists.linux-m68k.org,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v6 2/4] rtc: goldfish: use __raw_writel()/__raw_readl()
Date:   Thu, 13 Jan 2022 21:19:18 +0100
Message-Id: <20220113201920.3201760-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113201920.3201760-1-laurent@vivier.eu>
References: <20220113201920.3201760-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DvTzkg2lQWY7l7xt/QzK0twfwynLEyfgcQi29Cvr+IgjyFnIQtn
 XL/JZ0js0HRxNANm0z+O1czBwUBu186ajjyQkW+xVPfRhPCzpqLtPEBxVoQxmDQ4//vEicU
 ObHv8NS6hM4lutquxxosOR0W8IMtNmfXfr8G+jrrQbOxpPcOYh+VVUy4iFnr6KwI9NaTH+M
 OlV1uph++rLdwN377ts3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1B3kFT6rffI=:KU2bD1CW/f9Spo81K0QOPF
 +uRlw7myNGK9Yg2swX3M3gyLCgVfB+ByaxnrAQ4s/K1yIf2/IMP7+MOO/a5c8DFznmo9fwNQy
 0Qs+3vtE+3mANze/WuPgyJgZw+VKTyldEWBZCLAIZTwrnNb3b8WZ+VFkm2VpkGf/brY7cxlW4
 H7eYVKcV3YfmgR++4Zal7UluEAHzrrqdiny1n5IYUZSzj1yMbd7rX8HD3yhbTZIWgvKtP+QO/
 aFPawz+8S91V1xe+xR/NiyjqCf9U6+htlNJpJ1pTXNvJe4f1Ij7xne7heAqPXESqjwWuO/XC9
 D/yiAkpmEYNh5iGIzfkcbdRnNVkusC4plqdzs/+lRvjR+vqJQisRMpBk2W/fSXdve5rmbmTmg
 YU5Rwp8e2a4+TDnr6Tt6YdIAPnkWBtpPZbBtN8eq3ND/54Il6meMaL9mp8xCTV3MLrkbk2KcU
 jrPBH7NQ46ERclJ6fr0dkC/b0JJGQVsHG4xV2hUQkgtecvdHe+VuWHKoBEWPnK2Gt0N2aIxUn
 MtEgrWQYpt2W5aKTdNfY6jGfOxh6JYyGjVkVJzr2m/dUxMhR1Wdmc1XUeU2SCOAJWO3MN/vAh
 sUf6gEN3YDXma73HN+qR5lvWajmGFGz2jzH1xwQ7vcIdyUu4jW52ttuZtV012Kh5GC/AUorJw
 JbTqRyCi8DgbJA6iP373iipyEpY5RIDIadSRLlFMcQ1QOT/kjSvEm6v3IeZptcKshxi4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As android implementation defines the endianness of the device is the one
of the architecture replace all writel()/readl() by
__raw_writel()/__raw_readl()

https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/timer/goldfish_timer.c#177

The same change has been done for goldfish-tty:

  commit da31de35cd2f ("tty: goldfish: use __raw_writel()/__raw_readl()")

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/rtc/rtc-goldfish.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
index 7ab95d052644..3e76160d40b9 100644
--- a/drivers/rtc/rtc-goldfish.c
+++ b/drivers/rtc/rtc-goldfish.c
@@ -41,8 +41,8 @@ static int goldfish_rtc_read_alarm(struct device *dev,
 	rtcdrv = dev_get_drvdata(dev);
 	base = rtcdrv->base;
 
-	rtc_alarm_low = readl(base + TIMER_ALARM_LOW);
-	rtc_alarm_high = readl(base + TIMER_ALARM_HIGH);
+	rtc_alarm_low = __raw_readl(base + TIMER_ALARM_LOW);
+	rtc_alarm_high = __raw_readl(base + TIMER_ALARM_HIGH);
 	rtc_alarm = (rtc_alarm_high << 32) | rtc_alarm_low;
 
 	do_div(rtc_alarm, NSEC_PER_SEC);
@@ -50,7 +50,7 @@ static int goldfish_rtc_read_alarm(struct device *dev,
 
 	rtc_time64_to_tm(rtc_alarm, &alrm->time);
 
-	if (readl(base + TIMER_ALARM_STATUS))
+	if (__raw_readl(base + TIMER_ALARM_STATUS))
 		alrm->enabled = 1;
 	else
 		alrm->enabled = 0;
@@ -71,18 +71,18 @@ static int goldfish_rtc_set_alarm(struct device *dev,
 
 	if (alrm->enabled) {
 		rtc_alarm64 = rtc_tm_to_time64(&alrm->time) * NSEC_PER_SEC;
-		writel((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
-		writel(rtc_alarm64, base + TIMER_ALARM_LOW);
-		writel(1, base + TIMER_IRQ_ENABLED);
+		__raw_writel((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
+		__raw_writel(rtc_alarm64, base + TIMER_ALARM_LOW);
+		__raw_writel(1, base + TIMER_IRQ_ENABLED);
 	} else {
 		/*
 		 * if this function was called with enabled=0
 		 * then it could mean that the application is
 		 * trying to cancel an ongoing alarm
 		 */
-		rtc_status_reg = readl(base + TIMER_ALARM_STATUS);
+		rtc_status_reg = __raw_readl(base + TIMER_ALARM_STATUS);
 		if (rtc_status_reg)
-			writel(1, base + TIMER_CLEAR_ALARM);
+			__raw_writel(1, base + TIMER_CLEAR_ALARM);
 	}
 
 	return 0;
@@ -98,9 +98,9 @@ static int goldfish_rtc_alarm_irq_enable(struct device *dev,
 	base = rtcdrv->base;
 
 	if (enabled)
-		writel(1, base + TIMER_IRQ_ENABLED);
+		__raw_writel(1, base + TIMER_IRQ_ENABLED);
 	else
-		writel(0, base + TIMER_IRQ_ENABLED);
+		__raw_writel(0, base + TIMER_IRQ_ENABLED);
 
 	return 0;
 }
@@ -110,7 +110,7 @@ static irqreturn_t goldfish_rtc_interrupt(int irq, void *dev_id)
 	struct goldfish_rtc *rtcdrv = dev_id;
 	void __iomem *base = rtcdrv->base;
 
-	writel(1, base + TIMER_CLEAR_INTERRUPT);
+	__raw_writel(1, base + TIMER_CLEAR_INTERRUPT);
 
 	rtc_update_irq(rtcdrv->rtc, 1, RTC_IRQF | RTC_AF);
 
@@ -128,8 +128,8 @@ static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	rtcdrv = dev_get_drvdata(dev);
 	base = rtcdrv->base;
 
-	time_low = readl(base + TIMER_TIME_LOW);
-	time_high = readl(base + TIMER_TIME_HIGH);
+	time_low = __raw_readl(base + TIMER_TIME_LOW);
+	time_high = __raw_readl(base + TIMER_TIME_HIGH);
 	time = (time_high << 32) | time_low;
 
 	do_div(time, NSEC_PER_SEC);
@@ -149,8 +149,8 @@ static int goldfish_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	base = rtcdrv->base;
 
 	now64 = rtc_tm_to_time64(tm) * NSEC_PER_SEC;
-	writel((now64 >> 32), base + TIMER_TIME_HIGH);
-	writel(now64, base + TIMER_TIME_LOW);
+	__raw_writel((now64 >> 32), base + TIMER_TIME_HIGH);
+	__raw_writel(now64, base + TIMER_TIME_LOW);
 
 	return 0;
 }
-- 
2.34.1

