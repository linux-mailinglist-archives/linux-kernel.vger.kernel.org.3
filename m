Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF65C4FA5CD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbiDIIPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbiDIIP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:15:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FE93B014;
        Sat,  9 Apr 2022 01:13:20 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649491998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QzcH6z3Am+D81qDzofvGn1v+XN9UIqBR/iqwfKWEGtk=;
        b=g08lZTeDaqga7QeSnpS3Gg3UQWrGLCc57n0dC/Y9mMTfzATiUX+sDqZB1cjUMaJ0OOr6Tt
        0U/CI/7/+SDBgKSg5VOanA3J/VatXIrFKbtl3CSh5CqKIcrLf10u7imYbYbE449JBs+C1m
        u2cnDn4+skwSdJJOEz0PbNpO273ph2VmWj3S/zFO6+J1XUztCMSN3wmuFSys7VVVUOnLFl
        aKmfCOGC14ekT27v+b5vquTt96UvHHUPIJNYFB4RqkkwE0uXN/2TY76rSmOgzlf5OhHAAY
        U7UGG/McpAl0dwUDDJpFvIiF3/TMpxP56njxcpnm2lbu4hvWm1RDUNacg+BguA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649491998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QzcH6z3Am+D81qDzofvGn1v+XN9UIqBR/iqwfKWEGtk=;
        b=+olXlv1t565OFPTGouHJINnEgCzS4ySza2oWb/PIRfv1NCCmbS61ALK9SVTg4bj0K/jXMz
        uYWfNC9bP9DYVLCg==
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 1/3] timekeeping: Introduce fast accessor to clock tai
Date:   Sat,  9 Apr 2022 10:12:58 +0200
Message-Id: <20220409081300.4762-2-kurt@linutronix.de>
In-Reply-To: <20220409081300.4762-1-kurt@linutronix.de>
References: <20220409081300.4762-1-kurt@linutronix.de>
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
 include/linux/timekeeping.h |  1 +
 kernel/time/timekeeping.c   | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

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
index dcdcb85121e4..fd639a7e532e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -532,6 +532,23 @@ u64 notrace ktime_get_boot_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
 
+/**
+ * ktime_get_tai_fast_ns - NMI safe and fast access to tai clock.
+ *
+ * The same limitations as described for ktime_get_boot_fast_ns() apply: The
+ * mono time and the TAI offset are not read atomically which may yield wrong
+ * readouts. However, an update of the TAI offset is an rare event e.g., caused
+ * by settime or adjtimex with an offset. The user of this function has to deal
+ * with the possibility of wrong timestamps in post processing.
+ */
+u64 notrace ktime_get_tai_fast_ns(void)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+
+	return (ktime_get_mono_fast_ns() + ktime_to_ns(tk->offs_tai));
+}
+EXPORT_SYMBOL_GPL(ktime_get_tai_fast_ns);
+
 static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 {
 	struct tk_read_base *tkr;
-- 
2.30.2

