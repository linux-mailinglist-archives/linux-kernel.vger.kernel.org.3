Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94792493196
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350381AbiASAF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:05:56 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:43981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350354AbiASAFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:05:43 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MJW5G-1muW1X0kEi-00JugW; Wed, 19
 Jan 2022 01:05:11 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v10 2/5] rtc: goldfish: introduce goldfish_ioread32()/goldfish_iowrite32()
Date:   Wed, 19 Jan 2022 01:05:03 +0100
Message-Id: <20220119000506.1299843-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119000506.1299843-1-laurent@vivier.eu>
References: <20220119000506.1299843-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0bxgxaXMXgbL7csaXO2BB1eRaJk0rCjqkzDj0UjF7V23QJ5xWD0
 /ZFeL6X34SMhWEwkx51zHptBsS5PvTvwMd+EiWT8fIDwrohazZZvw6r40qH8HKEG1P62IoM
 tB5rIBQauuYw7PwGBxgf5UyJZ3s+rXUX2QXH8iEZWQICKxwF8X7AWrL9mz/gkjcdiIr0f2u
 bfb69LNPqovp6PUYi7xdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iHCX0BuEoY4=:YYQHByIHg07sUO4NKXweB4
 5656OGcoUEYdODgMuxhgoGGQnhAtUv9qeLreGwYct66HC4K6B7PQzg5oduxhgW4Pr/Q9AW6pq
 PEo8+YUcjyEdYDLhT3JmAEk+4f85rD58LFqZCYUbOBL/RrKqiRNt772xgCz3ZWW4MllhrlyhJ
 gIxJc8kQrl96m2OMH1nm2Lc/v2LlMsQp3pJjdZyW7CpmbTPg84/RjdYXNFohOTH5FtxCQ8ni4
 Bip4HpvWmID4QnzAA3rN4Ltc8mB+bkxgqIsIfalifRPsykcYCBVFRxlMJI4JUdj1XIVZO1IJd
 TS7NglU+E6YtIIg1KegckWitKSr6WPeG5D0qtuOTSek0Z6zyaKmgvZOmcfFrk+sDTvxcEJ26/
 sHSbSfdWyTqTSMy8eTrPL1ofCZCPyQIeUFx1bi7aPzVfhf+eNTSfqpBKwlcmQhNuMIt/NJFOs
 HB1ytUAgGjtfI3n3DlnydYXwLH1UdNKVvGDzYKs3L5/GmqDjoKkBj+L50GMw1bXk4fjv/OJy/
 vUw7V0K4x6SghZquK2VqfNnOoq8Bba06l+rnEcS8mve5ixhI3Awvb2Tz8IvhL9Sakx/7SKFZI
 YM+56txGjxZTQaaBD1IgZXaFeNtfk449FKTuM75VloBqwbzEYzghbIM60oLm8UkBVZddG5Lhu
 7UiGjmjr1Dp8OXA9EcGjfOFUi+F97EdNGxIH1QRScFd2CI6fG0kZHMK+7gSicFwPyR7M=
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

This patch introduces goldfish_ioread32()/goldfish_iowrite32() to allow
architectures to define them accordlingly to their endianness.

We define them by default in asm-generic/io.h to access the device using
little-endian access as it is the current use, but we will be able to define
big-endian version when new architectures will use them.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/rtc/rtc-goldfish.c | 30 +++++++++++++++---------------
 include/asm-generic/io.h   |  7 +++++++
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
index 7ab95d052644..1b2180ccfcdd 100644
--- a/drivers/rtc/rtc-goldfish.c
+++ b/drivers/rtc/rtc-goldfish.c
@@ -41,8 +41,8 @@ static int goldfish_rtc_read_alarm(struct device *dev,
 	rtcdrv = dev_get_drvdata(dev);
 	base = rtcdrv->base;
 
-	rtc_alarm_low = readl(base + TIMER_ALARM_LOW);
-	rtc_alarm_high = readl(base + TIMER_ALARM_HIGH);
+	rtc_alarm_low = goldfish_ioread32(base + TIMER_ALARM_LOW);
+	rtc_alarm_high = goldfish_ioread32(base + TIMER_ALARM_HIGH);
 	rtc_alarm = (rtc_alarm_high << 32) | rtc_alarm_low;
 
 	do_div(rtc_alarm, NSEC_PER_SEC);
@@ -50,7 +50,7 @@ static int goldfish_rtc_read_alarm(struct device *dev,
 
 	rtc_time64_to_tm(rtc_alarm, &alrm->time);
 
-	if (readl(base + TIMER_ALARM_STATUS))
+	if (goldfish_ioread32(base + TIMER_ALARM_STATUS))
 		alrm->enabled = 1;
 	else
 		alrm->enabled = 0;
@@ -71,18 +71,18 @@ static int goldfish_rtc_set_alarm(struct device *dev,
 
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
@@ -98,9 +98,9 @@ static int goldfish_rtc_alarm_irq_enable(struct device *dev,
 	base = rtcdrv->base;
 
 	if (enabled)
-		writel(1, base + TIMER_IRQ_ENABLED);
+		goldfish_iowrite32(1, base + TIMER_IRQ_ENABLED);
 	else
-		writel(0, base + TIMER_IRQ_ENABLED);
+		goldfish_iowrite32(0, base + TIMER_IRQ_ENABLED);
 
 	return 0;
 }
@@ -110,7 +110,7 @@ static irqreturn_t goldfish_rtc_interrupt(int irq, void *dev_id)
 	struct goldfish_rtc *rtcdrv = dev_id;
 	void __iomem *base = rtcdrv->base;
 
-	writel(1, base + TIMER_CLEAR_INTERRUPT);
+	goldfish_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
 
 	rtc_update_irq(rtcdrv->rtc, 1, RTC_IRQF | RTC_AF);
 
@@ -128,8 +128,8 @@ static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	rtcdrv = dev_get_drvdata(dev);
 	base = rtcdrv->base;
 
-	time_low = readl(base + TIMER_TIME_LOW);
-	time_high = readl(base + TIMER_TIME_HIGH);
+	time_low = goldfish_ioread32(base + TIMER_TIME_LOW);
+	time_high = goldfish_ioread32(base + TIMER_TIME_HIGH);
 	time = (time_high << 32) | time_low;
 
 	do_div(time, NSEC_PER_SEC);
@@ -149,8 +149,8 @@ static int goldfish_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	base = rtcdrv->base;
 
 	now64 = rtc_tm_to_time64(tm) * NSEC_PER_SEC;
-	writel((now64 >> 32), base + TIMER_TIME_HIGH);
-	writel(now64, base + TIMER_TIME_LOW);
+	goldfish_iowrite32((now64 >> 32), base + TIMER_TIME_HIGH);
+	goldfish_iowrite32(now64, base + TIMER_TIME_LOW);
 
 	return 0;
 }
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ce93aaf69f8..7f7e9d8c2eef 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -906,6 +906,13 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
 #endif /* CONFIG_64BIT */
 #endif /* CONFIG_GENERIC_IOMAP */
 
+#ifndef goldfish_ioread32
+#define goldfish_ioread32 ioread32
+#endif
+#ifndef goldfish_iowrite32
+#define goldfish_iowrite32 iowrite32
+#endif
+
 #ifdef __KERNEL__
 
 #include <linux/vmalloc.h>
-- 
2.34.1

