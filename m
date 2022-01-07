Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6584877BF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347385AbiAGMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:50:14 -0500
Received: from mx-out.tlen.pl ([193.222.135.175]:39046 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346859AbiAGMt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:49:58 -0500
Received: (wp-smtpd smtp.tlen.pl 36341 invoked from network); 7 Jan 2022 13:49:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1641559793; bh=Jh3/X+KkvGtkBBLS7mCF+AdF3xYIv/XlK48vT/hJiVc=;
          h=From:To:Cc:Subject;
          b=K/9C2lJTJr4DE0GtImf9F8OSTHotWVkp2cA1pB+avtH24/R5VSAZ5+wGr1mIk9NPw
           c1Wl4uMRAxb5sGnLDKHWQMQuTIossgiXoVOX8a3wvy5+sqZjfguSYCAIp8eu0Prr9+
           oedo4Z7MJjIgDc7ZNA10hoFi0Syr3rIRh8lvoeqw=
Received: from aafo3.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.144.3])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 7 Jan 2022 13:49:53 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-alpha@vger.kernel.org, x86@kernel.org
Subject: [PATCH v5 3/9] Check return value from mc146818_get_time()
Date:   Fri,  7 Jan 2022 13:49:28 +0100
Message-Id: <20220107124934.159878-4-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107124934.159878-1-mat.jonczyk@o2.pl>
References: <20220107124934.159878-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 2002335df33ada2072eca26ee22eef4e
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [IYOk]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 4 users of mc146818_get_time() and none of them was checking
the return value from this function. Change this.

Print the appropriate warnings in callers of mc146818_get_time() instead
of in the function mc146818_get_time() itself, in order not to add
strings to rtc-mc146818-lib.c, which is kind of a library.

The callers of alpha_rtc_read_time() and cmos_read_time() may use the
contents of (struct rtc_time *) even when the functions return a failure
code. Therefore, set the contents of (struct rtc_time *) to 0x00,
which aligns with the (possibly stale?) comment in cmos_read_time:

	/*
	 * If pm_trace abused the RTC for storage, set the timespec to 0,
	 * which tells the caller that this RTC value is unusable.
	 */

For consistency, do this in mc146818_get_time().

Note: hpet_rtc_interrupt() may call mc146818_get_time() many times a
second. It is very unlikely, though, that the RTC suddenly stops
working and mc146818_get_time() would consistently fail.

Only compile-tested on alpha.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-alpha@vger.kernel.org
Cc: x86@kernel.org

---

TODO: would it be appropriate to add attribute __must_check to
      mc146818_get_time()?

v4: Added this patch

 arch/alpha/kernel/rtc.c        | 7 ++++++-
 arch/x86/kernel/hpet.c         | 8 ++++++--
 drivers/base/power/trace.c     | 6 +++++-
 drivers/rtc/rtc-cmos.c         | 9 ++++++++-
 drivers/rtc/rtc-mc146818-lib.c | 2 +-
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/kernel/rtc.c b/arch/alpha/kernel/rtc.c
index ce3077946e1d..fb3025396ac9 100644
--- a/arch/alpha/kernel/rtc.c
+++ b/arch/alpha/kernel/rtc.c
@@ -80,7 +80,12 @@ init_rtc_epoch(void)
 static int
 alpha_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	mc146818_get_time(tm);
+	int ret = mc146818_get_time(tm);
+
+	if (ret < 0) {
+		dev_err_ratelimited(dev, "unable to read current time\n");
+		return ret;
+	}
 
 	/* Adjust for non-default epochs.  It's easier to depend on the
 	   generic __get_rtc_time and adjust the epoch here than create
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 882213df3713..71f336425e58 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1435,8 +1435,12 @@ irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id)
 	hpet_rtc_timer_reinit();
 	memset(&curr_time, 0, sizeof(struct rtc_time));
 
-	if (hpet_rtc_flags & (RTC_UIE | RTC_AIE))
-		mc146818_get_time(&curr_time);
+	if (hpet_rtc_flags & (RTC_UIE | RTC_AIE)) {
+		if (unlikely(mc146818_get_time(&curr_time) < 0)) {
+			pr_err_ratelimited("unable to read current time from RTC\n");
+			return IRQ_HANDLED;
+		}
+	}
 
 	if (hpet_rtc_flags & RTC_UIE &&
 	    curr_time.tm_sec != hpet_prev_update_sec) {
diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index 94665037f4a3..72b7a92337b1 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -120,7 +120,11 @@ static unsigned int read_magic_time(void)
 	struct rtc_time time;
 	unsigned int val;
 
-	mc146818_get_time(&time);
+	if (mc146818_get_time(&time) < 0) {
+		pr_err("Unable to read current time from RTC\n");
+		return 0;
+	}
+
 	pr_info("RTC time: %ptRt, date: %ptRd\n", &time, &time);
 	val = time.tm_year;				/* 100 years */
 	if (val > 100)
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index dc3f8b0dde98..d0f58cca5c20 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -222,6 +222,8 @@ static inline void cmos_write_bank2(unsigned char val, unsigned char addr)
 
 static int cmos_read_time(struct device *dev, struct rtc_time *t)
 {
+	int ret;
+
 	/*
 	 * If pm_trace abused the RTC for storage, set the timespec to 0,
 	 * which tells the caller that this RTC value is unusable.
@@ -229,7 +231,12 @@ static int cmos_read_time(struct device *dev, struct rtc_time *t)
 	if (!pm_trace_rtc_valid())
 		return -EIO;
 
-	mc146818_get_time(t);
+	ret = mc146818_get_time(t);
+	if (ret < 0) {
+		dev_err_ratelimited(dev, "unable to read current time\n");
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index c186c8c4982b..ccd974b8a75a 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -24,7 +24,7 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 	/* Ensure that the RTC is accessible. Bit 6 must be 0! */
 	if (WARN_ON_ONCE((CMOS_READ(RTC_VALID) & 0x40) != 0)) {
 		spin_unlock_irqrestore(&rtc_lock, flags);
-		memset(time, 0xff, sizeof(*time));
+		memset(time, 0, sizeof(*time));
 		return -EIO;
 	}
 
-- 
2.25.1

