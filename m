Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AD252ACA5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352907AbiEQUWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346834AbiEQUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:22:06 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E347551E6E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:22:04 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 25005 invoked from network); 17 May 2022 22:22:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1652818921; bh=9ovi1FLOubpAPQv/lsODTtczv1FUcAB21cjp/YOWmuc=;
          h=From:To:Cc:Subject;
          b=cPqYGL7HgHwWrg1WcUe9hM7PLyTlZXXLSu5NJECaVtm3CJ+UkBcJiqP9pijmW3e/f
           VP5v/nUG2ZhpF/oaQiYhoP61pj//b33TQ+a4iOERKbrYl5UBGEZ+zyqA/8BPN0J6BD
           jfAGoP2WOxeiyHHd3d2ftUB19w+pRP9++Tx+jV4c=
Received: from aafg236.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.136.236])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 17 May 2022 22:22:01 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2 resend 1/2] x86/rtc: rewrite mach_get_cmos_time to delete duplicated code
Date:   Tue, 17 May 2022 22:21:30 +0200
Message-Id: <20220517202131.379939-2-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517202131.379939-1-mat.jonczyk@o2.pl>
References: <20220517202131.379939-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 432265b158737b545904e0712bae5acf
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [cYNx]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are functions in drivers/rtc/rtc-mc146818-lib.c that handle
reading from / writing to the CMOS RTC clock. mach_get_cmos_time() in
arch/x86/kernel/rtc.c did not use them and was mostly a duplicate of
mc146818_get_time(). Modify mach_get_cmos_time() to use
mc146818_get_time() and remove the duplicated code.

mach_get_cmos_time() used a different algorithm than
mc146818_get_time(), but these functions are equivalent. The major
differences were:

- mc146818_get_time() is better refined: it was updated in
  commit 05a0302c3548 ("rtc: mc146818: Prevent reading garbage")
  to take account of various edge conditions,

- when the UIP ("Update in progress") bit of the RTC is set,
  mach_get_cmos_time() was busy waiting with cpu_relax() while
  mc146818_get_time() is now using mdelay(1) in every loop iteration,

- mach_get_cmos_time() assumed that the RTC year must be >= 2000, which
  may not be true on some old boxes with a dead battery,

- mach_get_cmos_time() was holding the rtc_lock for a long time.

As a bonus, mach_get_cmos_time() after the modification does not hang
indefinitely if the CMOS RTC is not present.

The RTC writing counterpart, mach_set_rtc_mmss() is already using
mc146818_get_time() from drivers/rtc. This was done in
        commit 3195ef59cb42 ("x86: Do full rtc synchronization with ntp")
It appears that mach_get_cmos_time() was simply forgotten.

mach_get_cmos_time() is really used only in read_persistent_clock64(),
which is called only in a few places in kernel/time/timekeeping.c .

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Prarit Bhargava <prarit@redhat.com>

---

v2:
  - use pr_err() in place of pr_err_ratelimited(). mach_get_cmos_time()
    is not called frequently, so ratelimiting is not necessary.
  - tweak commit description.
---
 arch/x86/kernel/rtc.c | 59 +++++--------------------------------------
 1 file changed, 7 insertions(+), 52 deletions(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 586f718b8e95..1cadc8a15267 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -4,11 +4,8 @@
  */
 #include <linux/platform_device.h>
 #include <linux/mc146818rtc.h>
-#include <linux/acpi.h>
-#include <linux/bcd.h>
 #include <linux/export.h>
 #include <linux/pnp.h>
-#include <linux/of.h>
 
 #include <asm/vsyscall.h>
 #include <asm/x86_init.h>
@@ -20,15 +17,12 @@
 /*
  * This is a special lock that is owned by the CPU and holds the index
  * register we are working with.  It is required for NMI access to the
- * CMOS/RTC registers.  See include/asm-i386/mc146818rtc.h for details.
+ * CMOS/RTC registers.  See arch/x86/include/asm/mc146818rtc.h for details.
  */
 volatile unsigned long cmos_lock;
 EXPORT_SYMBOL(cmos_lock);
 #endif /* CONFIG_X86_32 */
 
-/* For two digit years assume time is always after that */
-#define CMOS_YEARS_OFFS 2000
-
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
@@ -62,8 +56,7 @@ int mach_set_rtc_mmss(const struct timespec64 *now)
 
 void mach_get_cmos_time(struct timespec64 *now)
 {
-	unsigned int status, year, mon, day, hour, min, sec, century = 0;
-	unsigned long flags;
+	struct rtc_time tm;
 
 	/*
 	 * If pm_trace abused the RTC as storage, set the timespec to 0,
@@ -74,51 +67,13 @@ void mach_get_cmos_time(struct timespec64 *now)
 		return;
 	}
 
-	spin_lock_irqsave(&rtc_lock, flags);
-
-	/*
-	 * If UIP is clear, then we have >= 244 microseconds before
-	 * RTC registers will be updated.  Spec sheet says that this
-	 * is the reliable way to read RTC - registers. If UIP is set
-	 * then the register access might be invalid.
-	 */
-	while ((CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-		cpu_relax();
-
-	sec = CMOS_READ(RTC_SECONDS);
-	min = CMOS_READ(RTC_MINUTES);
-	hour = CMOS_READ(RTC_HOURS);
-	day = CMOS_READ(RTC_DAY_OF_MONTH);
-	mon = CMOS_READ(RTC_MONTH);
-	year = CMOS_READ(RTC_YEAR);
-
-#ifdef CONFIG_ACPI
-	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
-	    acpi_gbl_FADT.century)
-		century = CMOS_READ(acpi_gbl_FADT.century);
-#endif
-
-	status = CMOS_READ(RTC_CONTROL);
-	WARN_ON_ONCE(RTC_ALWAYS_BCD && (status & RTC_DM_BINARY));
-
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	if (RTC_ALWAYS_BCD || !(status & RTC_DM_BINARY)) {
-		sec = bcd2bin(sec);
-		min = bcd2bin(min);
-		hour = bcd2bin(hour);
-		day = bcd2bin(day);
-		mon = bcd2bin(mon);
-		year = bcd2bin(year);
+	if (mc146818_get_time(&tm)) {
+		pr_err("Unable to read current time from RTC\n");
+		now->tv_sec = now->tv_nsec = 0;
+		return;
 	}
 
-	if (century) {
-		century = bcd2bin(century);
-		year += century * 100;
-	} else
-		year += CMOS_YEARS_OFFS;
-
-	now->tv_sec = mktime64(year, mon, day, hour, min, sec);
+	now->tv_sec = rtc_tm_to_time64(&tm);
 	now->tv_nsec = 0;
 }
 
-- 
2.25.1

