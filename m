Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7F44877BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347305AbiAGMuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:50:10 -0500
Received: from mx-out.tlen.pl ([193.222.135.175]:10174 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347227AbiAGMuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:50:00 -0500
Received: (wp-smtpd smtp.tlen.pl 4242 invoked from network); 7 Jan 2022 13:49:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1641559798; bh=eImvJpBGle0hPP/yF5ySQwCmGcFRzp2xVWU4Yb+QpUY=;
          h=From:To:Cc:Subject;
          b=F/99C788sc8F7ac2j+oKYG4Tp7peHc4EZeOMFkRkQvVxwPrc19uOlt9utoRnvLVFd
           EIrvh7/2kzkOSa9B7814SuwIpkqZ91HVoRVwHEBBGE5pHBVLVYz2RG5TaxjCZBfq18
           QhgZJkzdHllV12urFEeQQSQOb7BdYTdovrJJjDQ0=
Received: from aafo3.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.144.3])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 7 Jan 2022 13:49:58 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 5/9] rtc-mc146818-lib: extract mc146818_avoid_UIP
Date:   Fri,  7 Jan 2022 13:49:30 +0100
Message-Id: <20220107124934.159878-6-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107124934.159878-1-mat.jonczyk@o2.pl>
References: <20220107124934.159878-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 56383c404bebda3cd2a8bdeb4b46cd71
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [UYMU]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function mc146818_get_time() contains an elaborate mechanism of reading
the RTC time while no RTC update is in progress. It turns out that
reading the RTC alarm clock also requires avoiding the RTC update.
Therefore, the mechanism in mc146818_get_time() should be reused - so
extract it into a separate function.

The logic in mc146818_avoid_UIP() is same as in mc146818_get_time()
except that after every

        if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {

there is now "mdelay(1)".

To avoid producing a very unreadable patch, mc146818_get_time() will be
refactored to use mc146818_avoid_UIP() in the next patch.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

---

v4: rename mc146818_do_avoiding_UIP() to mc146818_avoid_UIP(),
    remove definition of mc146818_callback_t,

v5: increase maximum duration of the the UIP high pulse from 10 to 20ms,
    in case there are some very slow chips out there.

 drivers/rtc/rtc-mc146818-lib.c | 70 ++++++++++++++++++++++++++++++++++
 include/linux/mc146818rtc.h    |  3 ++
 2 files changed, 73 insertions(+)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index 9b04c304d909..1c52e1de54c4 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -8,6 +8,76 @@
 #include <linux/acpi.h>
 #endif
 
+/*
+ * Execute a function while the UIP (Update-in-progress) bit of the RTC is
+ * unset.
+ *
+ * Warning: callback may be executed more then once.
+ */
+bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
+			void *param)
+{
+	int i;
+	unsigned long flags;
+	unsigned char seconds;
+
+	for (i = 0; i < 20; i++) {
+		spin_lock_irqsave(&rtc_lock, flags);
+
+		/*
+		 * Check whether there is an update in progress during which the
+		 * readout is unspecified. The maximum update time is ~2ms. Poll
+		 * every msec for completion.
+		 *
+		 * Store the second value before checking UIP so a long lasting
+		 * NMI which happens to hit after the UIP check cannot make
+		 * an update cycle invisible.
+		 */
+		seconds = CMOS_READ(RTC_SECONDS);
+
+		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
+			spin_unlock_irqrestore(&rtc_lock, flags);
+			mdelay(1);
+			continue;
+		}
+
+		/* Revalidate the above readout */
+		if (seconds != CMOS_READ(RTC_SECONDS)) {
+			spin_unlock_irqrestore(&rtc_lock, flags);
+			continue;
+		}
+
+		if (callback)
+			callback(seconds, param);
+
+		/*
+		 * Check for the UIP bit again. If it is set now then
+		 * the above values may contain garbage.
+		 */
+		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
+			spin_unlock_irqrestore(&rtc_lock, flags);
+			mdelay(1);
+			continue;
+		}
+
+		/*
+		 * A NMI might have interrupted the above sequence so check
+		 * whether the seconds value has changed which indicates that
+		 * the NMI took longer than the UIP bit was set. Unlikely, but
+		 * possible and there is also virt...
+		 */
+		if (seconds != CMOS_READ(RTC_SECONDS)) {
+			spin_unlock_irqrestore(&rtc_lock, flags);
+			continue;
+		}
+		spin_unlock_irqrestore(&rtc_lock, flags);
+
+		return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(mc146818_avoid_UIP);
+
 /*
  * If the UIP (Update-in-progress) bit of the RTC is set for more then
  * 20ms, the RTC is apparently broken or not present.
diff --git a/include/linux/mc146818rtc.h b/include/linux/mc146818rtc.h
index 69c80c4325bf..67fb0a12becc 100644
--- a/include/linux/mc146818rtc.h
+++ b/include/linux/mc146818rtc.h
@@ -127,4 +127,7 @@ bool mc146818_does_rtc_work(void);
 unsigned int mc146818_get_time(struct rtc_time *time);
 int mc146818_set_time(struct rtc_time *time);
 
+bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
+			void *param);
+
 #endif /* _MC146818RTC_H */
-- 
2.25.1

