Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C093C4877CB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiAGMvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:51:47 -0500
Received: from mx-out.tlen.pl ([193.222.135.145]:32268 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238689AbiAGMvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:51:46 -0500
Received: (wp-smtpd smtp.tlen.pl 11641 invoked from network); 7 Jan 2022 13:51:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1641559904; bh=MRl1ggHFuJRUUgPcgGYIjWNycMQc/u+l0MgTCskd6Gk=;
          h=From:To:Cc:Subject;
          b=dOozskg9pCAhCp7+o0Q3JHBGFKLt5pDaq1Zh3Ln6YGWw4XkltJRu68Zk7GLGlOf4O
           JHNDQJxHay2RWlMeTNkq6pVA5oh+2x0zsMRzjpzEDKFz4GmkL/4N1P8yo3USooaczz
           k3XmwEQgXAB04eazjG72LfW+hTwSyrbe3aCY5fE8=
Received: from aafo3.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.144.3])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 7 Jan 2022 13:51:44 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [DEBUG PATCH v5] rtc-cmos: cmos_read_alarm bug demonstration
Date:   Fri,  7 Jan 2022 13:51:36 +0100
Message-Id: <20220107125136.165332-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107124934.159878-9-mat.jonczyk@o2.pl>
References: <20220107124934.159878-9-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: fe72e307d62f10880ccae58e1412d27f
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [oXOE]                               
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

v5: Update to apply cleanly

 drivers/rtc/rtc-cmos.c | 59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index b90a603d6b12..9baf91fc2c41 100644
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
 	int ret;
@@ -237,6 +242,7 @@ static int cmos_read_time(struct device *dev, struct rtc_time *t)
 		return ret;
 	}
 
+	cmos_read_alarm_uip_debugging(dev);
 	return 0;
 }
 
@@ -319,6 +325,59 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
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
 static void cmos_checkintr(struct cmos_rtc *cmos, unsigned char rtc_control)
 {
 	unsigned char	rtc_intr;
-- 
2.25.1

