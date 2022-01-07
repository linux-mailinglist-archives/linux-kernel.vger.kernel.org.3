Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D024877BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347352AbiAGMuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:50:12 -0500
Received: from mx-out.tlen.pl ([193.222.135.175]:42384 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347046AbiAGMuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:50:03 -0500
Received: (wp-smtpd smtp.tlen.pl 9070 invoked from network); 7 Jan 2022 13:50:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1641559801; bh=I/4RYL7EKZv4t+bxf5/RSulqF0o7YLF3+QfsSAQPK0Q=;
          h=From:To:Cc:Subject;
          b=QJjeubJfpvj3hTNn1zoQ5dJYAivGjMiIgpf3skcGOpsLgwrSFYY00hqeSsJLgi3qr
           m5F9vUbnKdST463uEH4zd4WRH+UuYBzPreMfxGPR42uEFMK/wRKH/JSjdGzBKCqcYE
           3DSiui/Q+0Y0bJKsEotCoPvze4WYRtMazsMHbtVs=
Received: from aafo3.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.144.3])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 7 Jan 2022 13:50:01 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 6/9] rtc-mc146818-lib: refactor mc146818_get_time
Date:   Fri,  7 Jan 2022 13:49:31 +0100
Message-Id: <20220107124934.159878-7-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107124934.159878-1-mat.jonczyk@o2.pl>
References: <20220107124934.159878-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 8d4fdc04669a42893f058cae0fc6d7c3
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [sZMk]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor mc146818_get_time() so that it uses mc146818_avoid_UIP().

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

---

I'm sorry that the diff is so unreadable, but I was unable to fix this
easily.

 drivers/rtc/rtc-mc146818-lib.c | 109 +++++++++++++--------------------
 1 file changed, 42 insertions(+), 67 deletions(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index 1c52e1de54c4..34a1ed61a4f9 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -103,49 +103,20 @@ bool mc146818_does_rtc_work(void)
 }
 EXPORT_SYMBOL_GPL(mc146818_does_rtc_work);
 
-unsigned int mc146818_get_time(struct rtc_time *time)
-{
+struct mc146818_get_time_callback_param {
+	struct rtc_time *time;
 	unsigned char ctrl;
-	unsigned long flags;
-	unsigned int iter_count = 0;
-	unsigned char century = 0;
-	bool retry;
-
+#ifdef CONFIG_ACPI
+	unsigned char century;
+#endif
 #ifdef CONFIG_MACH_DECSTATION
 	unsigned int real_year;
 #endif
+};
 
-again:
-	if (iter_count > 20) {
-		memset(time, 0, sizeof(*time));
-		return -EIO;
-	}
-	iter_count++;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-
-	/*
-	 * Check whether there is an update in progress during which the
-	 * readout is unspecified. The maximum update time is ~2ms. Poll
-	 * every msec for completion.
-	 *
-	 * Store the second value before checking UIP so a long lasting NMI
-	 * which happens to hit after the UIP check cannot make an update
-	 * cycle invisible.
-	 */
-	time->tm_sec = CMOS_READ(RTC_SECONDS);
-
-	if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
-		spin_unlock_irqrestore(&rtc_lock, flags);
-		mdelay(1);
-		goto again;
-	}
-
-	/* Revalidate the above readout */
-	if (time->tm_sec != CMOS_READ(RTC_SECONDS)) {
-		spin_unlock_irqrestore(&rtc_lock, flags);
-		goto again;
-	}
+static void mc146818_get_time_callback(unsigned char seconds, void *param_in)
+{
+	struct mc146818_get_time_callback_param *p = param_in;
 
 	/*
 	 * Only the values that we read from the RTC are set. We leave
@@ -153,39 +124,39 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
 	 * by the RTC when initially set to a non-zero value.
 	 */
-	time->tm_min = CMOS_READ(RTC_MINUTES);
-	time->tm_hour = CMOS_READ(RTC_HOURS);
-	time->tm_mday = CMOS_READ(RTC_DAY_OF_MONTH);
-	time->tm_mon = CMOS_READ(RTC_MONTH);
-	time->tm_year = CMOS_READ(RTC_YEAR);
+	p->time->tm_sec = seconds;
+	p->time->tm_min = CMOS_READ(RTC_MINUTES);
+	p->time->tm_hour = CMOS_READ(RTC_HOURS);
+	p->time->tm_mday = CMOS_READ(RTC_DAY_OF_MONTH);
+	p->time->tm_mon = CMOS_READ(RTC_MONTH);
+	p->time->tm_year = CMOS_READ(RTC_YEAR);
 #ifdef CONFIG_MACH_DECSTATION
-	real_year = CMOS_READ(RTC_DEC_YEAR);
+	p->real_year = CMOS_READ(RTC_DEC_YEAR);
 #endif
 #ifdef CONFIG_ACPI
 	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
-	    acpi_gbl_FADT.century)
-		century = CMOS_READ(acpi_gbl_FADT.century);
+	    acpi_gbl_FADT.century) {
+		p->century = CMOS_READ(acpi_gbl_FADT.century);
+	} else {
+		p->century = 0;
+	}
 #endif
-	ctrl = CMOS_READ(RTC_CONTROL);
-	/*
-	 * Check for the UIP bit again. If it is set now then
-	 * the above values may contain garbage.
-	 */
-	retry = CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP;
-	/*
-	 * A NMI might have interrupted the above sequence so check whether
-	 * the seconds value has changed which indicates that the NMI took
-	 * longer than the UIP bit was set. Unlikely, but possible and
-	 * there is also virt...
-	 */
-	retry |= time->tm_sec != CMOS_READ(RTC_SECONDS);
 
-	spin_unlock_irqrestore(&rtc_lock, flags);
+	p->ctrl = CMOS_READ(RTC_CONTROL);
+}
 
-	if (retry)
-		goto again;
+unsigned int mc146818_get_time(struct rtc_time *time)
+{
+	struct mc146818_get_time_callback_param p = {
+		.time = time
+	};
+
+	if (!mc146818_avoid_UIP(mc146818_get_time_callback, &p)) {
+		memset(time, 0, sizeof(*time));
+		return -EIO;
+	}
 
-	if (!(ctrl & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
+	if (!(p.ctrl & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
 	{
 		time->tm_sec = bcd2bin(time->tm_sec);
 		time->tm_min = bcd2bin(time->tm_min);
@@ -193,15 +164,19 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 		time->tm_mday = bcd2bin(time->tm_mday);
 		time->tm_mon = bcd2bin(time->tm_mon);
 		time->tm_year = bcd2bin(time->tm_year);
-		century = bcd2bin(century);
+#ifdef CONFIG_ACPI
+		p.century = bcd2bin(p.century);
+#endif
 	}
 
 #ifdef CONFIG_MACH_DECSTATION
-	time->tm_year += real_year - 72;
+	time->tm_year += p.real_year - 72;
 #endif
 
-	if (century > 20)
-		time->tm_year += (century - 19) * 100;
+#ifdef CONFIG_ACPI
+	if (p.century > 20)
+		time->tm_year += (p.century - 19) * 100;
+#endif
 
 	/*
 	 * Account for differences between how the RTC uses the values
-- 
2.25.1

