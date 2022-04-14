Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9F850098B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbiDNJUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241167AbiDNJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:20:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3483E5130A;
        Thu, 14 Apr 2022 02:18:14 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649927892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a//Ayf6Cd8/CsHAT40buAmbBeRMSfyUjelkzghG9ajI=;
        b=lPl+ddht5blVzHrAnBdE9KsqTJEZMbBs0aOx2oy1+AV63uIVl5VCDZGsaUbQUgh5+602Xh
        YTLzkz+i7NNfx7nXFZCglWU8lNN3NDultV74pP+5pecZlhtvV+EiKvrfuZ2fDrrPHi0gV5
        0sjY72QxhIReM/h561J/9Mau/6QWDNFcQRhBij6NMmS962JPLyp2sByPQvDC256N7/I0vb
        mQ7dR5oWOqGl4RUTVmCuStRdmlaVP+syP0VtT6bP828RCyersvUWEkdfP8FSq9I+TXIA3e
        5goKc1e6Vde7XzInYq7EIy0uUbzlrsmAOR8s/rk9x4ZNAuxrMkt/7Ze8o81yHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649927892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a//Ayf6Cd8/CsHAT40buAmbBeRMSfyUjelkzghG9ajI=;
        b=CZ70hXWPP5URIE/vjVomUR7Egh4Nlo9mlKYwmbtQlb1yGW1SflMkNwffgoxYuBmo0hfQcQ
        t0JUfnZoDEHbsgDA==
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v2 1/3] timekeeping: Introduce fast accessor to clock tai
Date:   Thu, 14 Apr 2022 11:18:03 +0200
Message-Id: <20220414091805.89667-2-kurt@linutronix.de>
In-Reply-To: <20220414091805.89667-1-kurt@linutronix.de>
References: <20220414091805.89667-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce fast/NMI safe accessor to clock tai for tracing. The Linux kernel
tracing infrastructure has support for using different clocks to generate
timestamps for trace events. Especially in TSN networks it's useful to have TAI
as trace clock, because the application scheduling is done in accordance to the
network time, which is based on TAI. With a tai trace_clock in place, it becomes
very convenient to correlate network activity with Linux kernel application
traces.

Use the same implementation as ktime_get_boot_fast_ns() does by reading the
monotonic time and adding the TAI offset. The same limitations as for the fast
boot implementation apply. The TAI offset may change at run time e.g., by
setting the time or using adjtimex() with an offset. However, these kind of
offset changes are rare events. Nevertheless, the user has to be aware and deal
with it in post processing.

An alternative approach would be to use the same implementation as
ktime_get_real_fast_ns() does. However, this requires to add an additional u64
member to the tk_read_base struct. This struct together with a seqcount is
designed to fit into a single cache line on 64 bit architectures. Adding a new
member would violate this constraint.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 Documentation/core-api/timekeeping.rst |  1 +
 include/linux/timekeeping.h            |  1 +
 kernel/time/timekeeping.c              | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
index 729e24864fe7..22ec68f24421 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -132,6 +132,7 @@ Some additional variants exist for more specialized cases:
 .. c:function:: u64 ktime_get_mono_fast_ns( void )
 		u64 ktime_get_raw_fast_ns( void )
 		u64 ktime_get_boot_fast_ns( void )
+		u64 ktime_get_tai_fast_ns( void )
 		u64 ktime_get_real_fast_ns( void )
 
 	These variants are safe to call from any context, including from
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 78a98bdff76d..fe1e467ba046 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -177,6 +177,7 @@ static inline u64 ktime_get_raw_ns(void)
 extern u64 ktime_get_mono_fast_ns(void);
 extern u64 ktime_get_raw_fast_ns(void);
 extern u64 ktime_get_boot_fast_ns(void);
+extern u64 ktime_get_tai_fast_ns(void);
 extern u64 ktime_get_real_fast_ns(void);
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index dcdcb85121e4..2c22023fbf5f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -532,6 +532,23 @@ u64 notrace ktime_get_boot_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
 
+/**
+ * ktime_get_tai_fast_ns - NMI safe and fast access to tai clock.
+ *
+ * The same limitations as described for ktime_get_boot_fast_ns() apply. The
+ * mono time and the TAI offset are not read atomically which may yield wrong
+ * readouts. However, an update of the TAI offset is an rare event e.g., caused
+ * by settime or adjtimex with an offset. The user of this function has to deal
+ * with the possibility of wrong timestamps in post processing.
+ */
+u64 notrace ktime_get_tai_fast_ns(void)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+
+	return (ktime_get_mono_fast_ns() + ktime_to_ns(data_race(tk->offs_tai)));
+}
+EXPORT_SYMBOL_GPL(ktime_get_tai_fast_ns);
+
 static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 {
 	struct tk_read_base *tkr;
-- 
2.30.2

