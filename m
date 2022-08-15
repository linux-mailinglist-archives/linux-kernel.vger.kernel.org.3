Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2889592C66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiHOItL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHOItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:49:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83707205CE;
        Mon, 15 Aug 2022 01:49:07 -0700 (PDT)
Date:   Mon, 15 Aug 2022 08:49:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660553346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8I9Ib2HD91ZLaQDYmOiASkWK12fL+yNfPzlPFzIKBk=;
        b=pr8soAWvnDImRgNgAEnVzeOYfvI1tMHuC9ufw1Kfj7NvQEyhhCraY9IpcC82v3ZcZJ5Pva
        ao+TM2xOdkX2Tk6K9GQjVyKMJsTTAxd1QN2AHT9JYKi8rcTEjZHK7QETB3TC0DnGek3Oz/
        J/lp266vKSRjsFOlwCOpaNg3YzJUfwNDEG2J9BKRqTebmG8LRNGcmhAR+1/OXxff7ybSyD
        lP+wPEcj+FdTciOkyEN1rPVjxnPMnGupW5/elXQ0q3vwkR3T1a0xuAktcdKOotLiyeZs7i
        YJvON7Qe1myI3lWriJxe97zzM7KY+u6AR9GPuIjVgVs/SN4Y/3/4BN3Rd2JLTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660553346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8I9Ib2HD91ZLaQDYmOiASkWK12fL+yNfPzlPFzIKBk=;
        b=4gpovY5rdbFznpnJi6+bT2LCabeo0a91EOTAYW0CeOAzb0676oVbz421SWmhT7xH2+X12B
        ur2yZl2QnpNq5ECg==
From:   tip-bot2 for Mateusz =?utf-8?q?Jo=C5=84czyk?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/timers] x86/rtc: Rewrite & simplify mach_get_cmos_time() by
 deleting duplicated functionality
Cc:     mat.jonczyk@o2.pl, Ingo Molnar <mingo@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220813131034.768527-1-mat.jonczyk@o2.pl>
References: <20220813131034.768527-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Message-ID: <166055334489.401.11112157644462774552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/timers branch of tip:

Commit-ID:     fc04b2ccf0edc49e53d2e1251d122e40285233e6
Gitweb:        https://git.kernel.org/tip/fc04b2ccf0edc49e53d2e1251d122e40285=
233e6
Author:        Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
AuthorDate:    Sat, 13 Aug 2022 15:10:33 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Aug 2022 11:24:08 +02:00

x86/rtc: Rewrite & simplify mach_get_cmos_time() by deleting duplicated funct=
ionality

There are functions in drivers/rtc/rtc-mc146818-lib.c that handle
reading from / writing to the CMOS RTC clock. mach_get_cmos_time() in
arch/x86/kernel/rtc.c did not use them and was mostly a duplicate of
mc146818_get_time(). Modify mach_get_cmos_time() to use
mc146818_get_time() and remove the duplicated functionality.

mach_get_cmos_time() used a different algorithm than
mc146818_get_time(), but these functions are equivalent. The major
differences are:

- mc146818_get_time() is better refined and handles various edge
  conditions,

- when the UIP ("Update in progress") bit of the RTC is set,
  mach_get_cmos_time() was busy waiting with cpu_relax() while
  mc146818_get_time() is using mdelay(1) in every loop iteration.
  (However, there is my commit merged for Linux 5.20 / 6.0 to decrease
  this period to 100us:
    commit d2a632a8a117 ("rtc: mc146818-lib: reduce RTC_UIP polling period")
  ),

- mach_get_cmos_time() assumed that the RTC year is >=3D 2000, which
  may not be true on some old boxes with a dead battery,

- mach_get_cmos_time() was holding the rtc_lock for a long time
  and could hang if the RTC is broken or not present.

The RTC writing counterpart, mach_set_rtc_mmss() is already using
mc146818_get_time() from drivers/rtc. This was done in
        commit 3195ef59cb42 ("x86: Do full rtc synchronization with ntp")
It appears that mach_get_cmos_time() was simply forgotten.

mach_get_cmos_time() is really used only in read_persistent_clock64(),
which is called only in a few places in kernel/time/timekeeping.c .

[ mingo: These changes are not supposed to change behavior, but they are
         not identity transformations either, as mc146818_get_time() is a
	 better but different implementation of the same logic - so
	 regressions are possible in principle. ]

Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20220813131034.768527-1-mat.jonczyk@o2.pl
---
 arch/x86/kernel/rtc.c | 59 ++++--------------------------------------
 1 file changed, 7 insertions(+), 52 deletions(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 586f718..1cadc8a 100644
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
=20
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
=20
-/* For two digit years assume time is always after that */
-#define CMOS_YEARS_OFFS 2000
-
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
=20
@@ -62,8 +56,7 @@ int mach_set_rtc_mmss(const struct timespec64 *now)
=20
 void mach_get_cmos_time(struct timespec64 *now)
 {
-	unsigned int status, year, mon, day, hour, min, sec, century =3D 0;
-	unsigned long flags;
+	struct rtc_time tm;
=20
 	/*
 	 * If pm_trace abused the RTC as storage, set the timespec to 0,
@@ -74,51 +67,13 @@ void mach_get_cmos_time(struct timespec64 *now)
 		return;
 	}
=20
-	spin_lock_irqsave(&rtc_lock, flags);
-
-	/*
-	 * If UIP is clear, then we have >=3D 244 microseconds before
-	 * RTC registers will be updated.  Spec sheet says that this
-	 * is the reliable way to read RTC - registers. If UIP is set
-	 * then the register access might be invalid.
-	 */
-	while ((CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-		cpu_relax();
-
-	sec =3D CMOS_READ(RTC_SECONDS);
-	min =3D CMOS_READ(RTC_MINUTES);
-	hour =3D CMOS_READ(RTC_HOURS);
-	day =3D CMOS_READ(RTC_DAY_OF_MONTH);
-	mon =3D CMOS_READ(RTC_MONTH);
-	year =3D CMOS_READ(RTC_YEAR);
-
-#ifdef CONFIG_ACPI
-	if (acpi_gbl_FADT.header.revision >=3D FADT2_REVISION_ID &&
-	    acpi_gbl_FADT.century)
-		century =3D CMOS_READ(acpi_gbl_FADT.century);
-#endif
-
-	status =3D CMOS_READ(RTC_CONTROL);
-	WARN_ON_ONCE(RTC_ALWAYS_BCD && (status & RTC_DM_BINARY));
-
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	if (RTC_ALWAYS_BCD || !(status & RTC_DM_BINARY)) {
-		sec =3D bcd2bin(sec);
-		min =3D bcd2bin(min);
-		hour =3D bcd2bin(hour);
-		day =3D bcd2bin(day);
-		mon =3D bcd2bin(mon);
-		year =3D bcd2bin(year);
+	if (mc146818_get_time(&tm)) {
+		pr_err("Unable to read current time from RTC\n");
+		now->tv_sec =3D now->tv_nsec =3D 0;
+		return;
 	}
=20
-	if (century) {
-		century =3D bcd2bin(century);
-		year +=3D century * 100;
-	} else
-		year +=3D CMOS_YEARS_OFFS;
-
-	now->tv_sec =3D mktime64(year, mon, day, hour, min, sec);
+	now->tv_sec =3D rtc_tm_to_time64(&tm);
 	now->tv_nsec =3D 0;
 }
=20
