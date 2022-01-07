Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766CD4877C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347434AbiAGMuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:50:21 -0500
Received: from mx-out.tlen.pl ([193.222.135.175]:36296 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238599AbiAGMuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:50:09 -0500
Received: (wp-smtpd smtp.tlen.pl 19724 invoked from network); 7 Jan 2022 13:50:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1641559806; bh=BJO8HI8omQ1xLnjrYmlcM8vojcpUCARscQ9xK3W0xO0=;
          h=From:To:Cc:Subject;
          b=qlgTPOB3mAYGY5PE147cTwxZMAO/x5IGfYD6GbQUDb5rDIFq5tr+8KGyJYQiVl49w
           Ez9fGd2RsW9QgQ52MFj4eZIwiSOP+yxjMEp95pHxVgOMKun/yLmsc+rRiQ0JcIf3W/
           If/QoiF5RF5hOS36UNHTpuBFMCiIjlu0+ax0avSE=
Received: from aafo3.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.144.3])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 7 Jan 2022 13:50:05 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 8/9] rtc-cmos: avoid UIP when reading alarm time
Date:   Fri,  7 Jan 2022 13:49:33 +0100
Message-Id: <20220107124934.159878-9-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107124934.159878-1-mat.jonczyk@o2.pl>
References: <20220107124934.159878-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 32ca8cea749e8b68ebd9cfba76480a48
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [4aNE]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Intel chipsets disconnect the time and date RTC registers when the
clock update is in progress: during this time reads may return bogus
values and writes fail silently. This includes the RTC alarm registers.
[1]

cmos_read_alarm() did not take account for that, which caused alarm time
reads to sometimes return bogus values. This can be shown with a test
patch that I am attaching to this patch series.

Fix this, by using mc146818_avoid_UIP().

[1] 7th Generation Intel ® Processor Family I/O for U/Y Platforms [...]
Datasheet, Volume 1 of 2 (Intel's Document Number: 334658-006)
Page 208
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/7th-and-8th-gen-core-family-mobile-u-y-processor-lines-i-o-datasheet-vol-1.pdf
        "If a RAM read from the ten time and date bytes is attempted
        during an update cycle, the value read do not necessarily
        represent the true contents of those locations. Any RAM writes
        under the same conditions are ignored."

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

---

v4: fix some checkpatch --strict warnings

 drivers/rtc/rtc-cmos.c | 72 ++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index b90a603d6b12..6f47d68d2c86 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -249,10 +249,46 @@ static int cmos_set_time(struct device *dev, struct rtc_time *t)
 	return mc146818_set_time(t);
 }
 
+struct cmos_read_alarm_callback_param {
+	struct cmos_rtc *cmos;
+	struct rtc_time *time;
+	unsigned char	rtc_control;
+};
+
+static void cmos_read_alarm_callback(unsigned char __always_unused seconds,
+				     void *param_in)
+{
+	struct cmos_read_alarm_callback_param *p =
+		(struct cmos_read_alarm_callback_param *)param_in;
+	struct rtc_time *time = p->time;
+
+	time->tm_sec = CMOS_READ(RTC_SECONDS_ALARM);
+	time->tm_min = CMOS_READ(RTC_MINUTES_ALARM);
+	time->tm_hour = CMOS_READ(RTC_HOURS_ALARM);
+
+	if (p->cmos->day_alrm) {
+		/* ignore upper bits on readback per ACPI spec */
+		time->tm_mday = CMOS_READ(p->cmos->day_alrm) & 0x3f;
+		if (!time->tm_mday)
+			time->tm_mday = -1;
+
+		if (p->cmos->mon_alrm) {
+			time->tm_mon = CMOS_READ(p->cmos->mon_alrm);
+			if (!time->tm_mon)
+				time->tm_mon = -1;
+		}
+	}
+
+	p->rtc_control = CMOS_READ(RTC_CONTROL);
+}
+
 static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
-	unsigned char	rtc_control;
+	struct cmos_read_alarm_callback_param p = {
+		.cmos = cmos,
+		.time = &t->time,
+	};
 
 	/* This not only a rtc_op, but also called directly */
 	if (!is_valid_irq(cmos->irq))
@@ -263,28 +299,18 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	 * the future.
 	 */
 
-	spin_lock_irq(&rtc_lock);
-	t->time.tm_sec = CMOS_READ(RTC_SECONDS_ALARM);
-	t->time.tm_min = CMOS_READ(RTC_MINUTES_ALARM);
-	t->time.tm_hour = CMOS_READ(RTC_HOURS_ALARM);
-
-	if (cmos->day_alrm) {
-		/* ignore upper bits on readback per ACPI spec */
-		t->time.tm_mday = CMOS_READ(cmos->day_alrm) & 0x3f;
-		if (!t->time.tm_mday)
-			t->time.tm_mday = -1;
-
-		if (cmos->mon_alrm) {
-			t->time.tm_mon = CMOS_READ(cmos->mon_alrm);
-			if (!t->time.tm_mon)
-				t->time.tm_mon = -1;
-		}
-	}
-
-	rtc_control = CMOS_READ(RTC_CONTROL);
-	spin_unlock_irq(&rtc_lock);
+	/* Some Intel chipsets disconnect the alarm registers when the clock
+	 * update is in progress - during this time reads return bogus values
+	 * and writes may fail silently. See for example "7th Generation Intel®
+	 * Processor Family I/O for U/Y Platforms [...] Datasheet", section
+	 * 27.7.1
+	 *
+	 * Use the mc146818_avoid_UIP() function to avoid this.
+	 */
+	if (!mc146818_avoid_UIP(cmos_read_alarm_callback, &p))
+		return -EIO;
 
-	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+	if (!(p.rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
 		if (((unsigned)t->time.tm_sec) < 0x60)
 			t->time.tm_sec = bcd2bin(t->time.tm_sec);
 		else
@@ -313,7 +339,7 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 		}
 	}
 
-	t->enabled = !!(rtc_control & RTC_AIE);
+	t->enabled = !!(p.rtc_control & RTC_AIE);
 	t->pending = 0;
 
 	return 0;
-- 
2.25.1

