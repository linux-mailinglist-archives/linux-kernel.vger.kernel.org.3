Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504B55017AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359102AbiDNPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352594AbiDNPRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:17:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FC9BC84F;
        Thu, 14 Apr 2022 08:01:49 -0700 (PDT)
Date:   Thu, 14 Apr 2022 15:01:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649948508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TDdmE09S+E9/Bqk8y91Y/tlKrElwL0r7vtr9lMqW9U=;
        b=InGj8ELY5RkNkL8kloc8CDlSZ1y2WANocZcFCND+1ssigyWALFB/ng6WkUbYbXJiXTBhSL
        Y20HEGYHEaj+O77omc/5xrq2ww29MpLHuJSv28immg0A5mRJXC5Fl6d/IjNFR0Bsl1QTms
        CzgoC2WaQNS8SmFj+ViWq40toUj9gm40qvR7r2NgfjLaF1DsF/wntdG0keZU1oRx85HgOn
        JXKZ+Bx6zUKw3Y8be4BT64yNtaPbJIOCRp2qHvQkehR8PulBsI5mnTl1wYU4jQ5bQESC33
        3EAlC9GRJWHGX9s+k+vDjjr7QnnndnCoNWvVwFy0JkWRM/JrB1ZXGVr+S7xhcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649948508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TDdmE09S+E9/Bqk8y91Y/tlKrElwL0r7vtr9lMqW9U=;
        b=3/uIJrS7WAhtmU1EGBcKtXPgShejbu9njwq0JTnjtLGRSPOWIF6NFxyVabVWlQBU5fWTgj
        lIh/ULi630BYpkDA==
From:   "tip-bot2 for Kurt Kanzenbach" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Introduce fast accessor to clock tai
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220414091805.89667-2-kurt@linutronix.de>
References: <20220414091805.89667-2-kurt@linutronix.de>
MIME-Version: 1.0
Message-ID: <164994850704.4207.9058445142052855306.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3dc6ffae2da201284cb24af66af77ee0bbb2efaa
Gitweb:        https://git.kernel.org/tip/3dc6ffae2da201284cb24af66af77ee0bbb2efaa
Author:        Kurt Kanzenbach <kurt@linutronix.de>
AuthorDate:    Thu, 14 Apr 2022 11:18:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Apr 2022 16:19:30 +02:00

timekeeping: Introduce fast accessor to clock tai

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20220414091805.89667-2-kurt@linutronix.de

---
 Documentation/core-api/timekeeping.rst |  1 +
 include/linux/timekeeping.h            |  1 +
 kernel/time/timekeeping.c              | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
index 729e248..22ec68f 100644
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
index 78a98bd..fe1e467 100644
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
index dcdcb85..2c22023 100644
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
