Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C00470B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhLJUHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:07:20 -0500
Received: from mx-out.tlen.pl ([193.222.135.142]:44202 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhLJUHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:07:19 -0500
Received: (wp-smtpd smtp.tlen.pl 4465 invoked from network); 10 Dec 2021 21:03:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1639166622; bh=6EV3+Db16M1TTmcxm0Ltf+cHXWaK6K5VL+dcc/n0F48=;
          h=From:To:Cc:Subject;
          b=uaFrV1+7Goh9zI8smbFJXAMZVID7+wgEAs4rJJ6IMzHU0pWjnE3PK2WqvRYoSvt7e
           cOS6EOSRZiIwi/iO4yIjkvp04HuUp6z7rDdj1OjMxnX1xsrRpAAvK/t2A4Iw7in0qZ
           oQ212rGFz5vgPg8i1XCAcWsc9QcGB6XI+GiqlIqw=
Received: from aaff136.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.135.136])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 10 Dec 2021 21:03:42 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [DEBUG PATCH v4] rtc-cmos: cmos_read_alarm bug demonstration
Date:   Fri, 10 Dec 2021 21:03:27 +0100
Message-Id: <20211210200327.153966-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210200131.153887-9-mat.jonczyk@o2.pl>
References: <20211210200131.153887-9-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: a624c190df58d0367e0b96c5b60aaf90
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0100001 [QUIj]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before my commit "rtc-cmos: avoid UIP when reading alarm time",
applying this patch and reading the CMOS time like so:

        while true; do cat /sys/class/rtc/rtc0/time ; sleep 0.5; done

produces errors in dmesg on my Intel Kaby Lake laptop.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-cmos.c | 61 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index b6d7dd3cf066..3de049930745 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -43,6 +43,9 @@
 #include <linux/dmi.h>
 #endif
 
+#include <linux/ktime.h>
+#include <linux/timekeeping.h>
+
 /* this is for "generic access to PC-style RTC" using CMOS_READ/CMOS_WRITE */
 #include <linux/mc146818rtc.h>
 
@@ -220,6 +223,8 @@ static inline void cmos_write_bank2(unsigned char val, unsigned char addr)
 
 /*----------------------------------------------------------------*/
 
+static void cmos_read_alarm_uip_debugging(struct device *dev);
+
 static int cmos_read_time(struct device *dev, struct rtc_time *t)
 {
 	/*
@@ -230,6 +235,8 @@ static int cmos_read_time(struct device *dev, struct rtc_time *t)
 		return -EIO;
 
 	mc146818_get_time(t);
+
+	cmos_read_alarm_uip_debugging(dev);
 	return 0;
 }
 
@@ -338,6 +345,60 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	return 0;
 }
 
+static void cmos_read_alarm_uip_debugging(struct device *dev)
+{
+	unsigned long	flags;
+	unsigned char	rtc_uip_baseline, rtc_uip;
+	struct rtc_wkalrm t_baseline, t;
+	ktime_t time_start, time_end;
+	int i;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	rtc_uip_baseline = CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP;
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	cmos_read_alarm(dev, &t_baseline);
+
+	time_start = ktime_get();
+
+	for (i = 0; i < 2000; i++) {
+		spin_lock_irqsave(&rtc_lock, flags);
+		rtc_uip = CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP;
+		spin_unlock_irqrestore(&rtc_lock, flags);
+
+		cmos_read_alarm(dev, &t);
+
+		if (t_baseline.time.tm_sec != t.time.tm_sec) {
+			dev_err(dev,
+				"Inconsistent alarm tm_sec value: %d != %d (RTC_UIP = %d; %d)\n",
+				t_baseline.time.tm_sec,
+				t.time.tm_sec,
+				rtc_uip_baseline, rtc_uip);
+		}
+		if (t_baseline.time.tm_min != t.time.tm_min) {
+			dev_err(dev,
+				"Inconsistent alarm tm_min value: %d != %d (RTC_UIP = %d; %d)\n",
+				t_baseline.time.tm_min,
+				t.time.tm_min,
+				rtc_uip_baseline, rtc_uip);
+		}
+		if (t_baseline.time.tm_hour != t.time.tm_hour) {
+			dev_err(dev,
+				"Inconsistent alarm tm_hour value: %d != %d (RTC_UIP = %d; %d)\n",
+				t_baseline.time.tm_hour,
+				t.time.tm_hour,
+				rtc_uip_baseline, rtc_uip);
+		}
+
+	}
+
+	time_end = ktime_get();
+
+	pr_info_ratelimited("%s: loop executed in %lld ns\n",
+			__func__, ktime_to_ns(ktime_sub(time_end, time_start)));
+}
+
+
 static void cmos_checkintr(struct cmos_rtc *cmos, unsigned char rtc_control)
 {
 	unsigned char	rtc_intr;
-- 
2.25.1

