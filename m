Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF9D502F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350833AbiDOTXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349335AbiDOTWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:22:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F4496BC;
        Fri, 15 Apr 2022 12:20:04 -0700 (PDT)
Message-ID: <20220415161206.875029458@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650050403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=n2wSeLMIGPJqIrOHCJy5cyY5D0QNAlM7n2T6MTd7xwc=;
        b=b92wp7O0MUGwNsU9mIHqekKePY2y+Z5Svz757bDoLoT2kfhzp1BaT2CpKrZyUTP3Ze5SK6
        3pfo6KVA+RtT/+uCcqwadflc7T3n+mJ5dJ7Epg1tPgnUBZp9Gss9vdFqVuouUtcZBM0Huk
        99qZgNjvs0cGWt7tPuqS2wb8Ciw3g7i3Ogrq296n0vodf5zi6614yxQ6Sf7rNWk0mdg9qJ
        iTTF1OyXEMwfGq3fdVCaIFHRPBgmp5q1FF/W0QMU4tgfH4HR82qNwUNGINXKL5T8Kx3ou9
        SQ6TdZD+Q8r1CpIlDLbv4iETaSAFKWuduPLt5dxEgCxAILTM8PhkjocMtNb9Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650050403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=n2wSeLMIGPJqIrOHCJy5cyY5D0QNAlM7n2T6MTd7xwc=;
        b=Q5e+J4epcR3IihMAKz+MJov65aDoE016IQxpDVcVGrmEqMWy4ffEgQ9f5gmNTR24hRf1QE
        mlsEn3LZwo4py0CQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [patch 09/10] x86/aperfmperf: Replace aperfmperf_get_khz()
References: <20220415133356.179706384@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Apr 2022 21:20:02 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The frequency invariance infrastructure provides the APERF/MPERF samples
already. Utilize them for the cpu frequency display in /proc/cpuinfo.

The sample is considered valid for 20ms. So for idle or isolated NOHZ full
CPUs the function returns 0, which is matching the previous behaviour.

This gets rid of the mass IPIs and a delay of 20ms for stabilizing observed
by Eric when reading /proc/cpuinfo.

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/aperfmperf.c |   77 +++++++++++++++++----------------------
 fs/proc/cpuinfo.c                |    6 ---
 include/linux/cpufreq.h          |    1 
 3 files changed, 35 insertions(+), 49 deletions(-)

--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -100,49 +100,6 @@ static bool aperfmperf_snapshot_cpu(int
 	return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
 }
 
-unsigned int aperfmperf_get_khz(int cpu)
-{
-	if (!cpu_khz)
-		return 0;
-
-	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
-		return 0;
-
-	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
-		return 0;
-
-	if (rcu_is_idle_cpu(cpu))
-		return 0; /* Idle CPUs are completely uninteresting. */
-
-	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
-	return per_cpu(samples.khz, cpu);
-}
-
-void arch_freq_prepare_all(void)
-{
-	ktime_t now = ktime_get();
-	bool wait = false;
-	int cpu;
-
-	if (!cpu_khz)
-		return;
-
-	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
-		return;
-
-	for_each_online_cpu(cpu) {
-		if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
-			continue;
-		if (rcu_is_idle_cpu(cpu))
-			continue; /* Idle CPUs are completely uninteresting. */
-		if (!aperfmperf_snapshot_cpu(cpu, now, false))
-			wait = true;
-	}
-
-	if (wait)
-		msleep(APERFMPERF_REFRESH_DELAY_MS);
-}
-
 unsigned int arch_freq_get_on_cpu(int cpu)
 {
 	struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
@@ -529,6 +486,40 @@ void arch_scale_freq_tick(void)
 	scale_freq_tick(acnt, mcnt);
 }
 
+/*
+ * Discard samples older than the define maximum sample age of 20ms. There
+ * is no point in sending IPIs in such a case. If the scheduler tick was
+ * not running then the CPU is either idle or isolated.
+ */
+#define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
+
+unsigned int aperfmperf_get_khz(int cpu)
+{
+	struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
+	unsigned long last;
+	unsigned int seq;
+	u64 acnt, mcnt;
+
+	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
+		return 0;
+
+	do {
+		seq = raw_read_seqcount_begin(&s->seq);
+		last = s->last_update;
+		acnt = s->acnt;
+		mcnt = s->mcnt;
+	} while (read_seqcount_retry(&s->seq, seq));
+
+	/*
+	 * Bail on invalid count and when the last update was too long ago,
+	 * which covers idle and NOHZ full CPUs.
+	 */
+	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
+		return 0;
+
+	return div64_u64((cpu_khz * acnt), mcnt);
+}
+
 static int __init bp_init_aperfmperf(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
--- a/fs/proc/cpuinfo.c
+++ b/fs/proc/cpuinfo.c
@@ -5,14 +5,10 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
-__weak void arch_freq_prepare_all(void)
-{
-}
-
 extern const struct seq_operations cpuinfo_op;
+
 static int cpuinfo_open(struct inode *inode, struct file *file)
 {
-	arch_freq_prepare_all();
 	return seq_open(file, &cpuinfo_op);
 }
 
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1199,7 +1199,6 @@ static inline void sched_cpufreq_governo
 			struct cpufreq_governor *old_gov) { }
 #endif
 
-extern void arch_freq_prepare_all(void);
 extern unsigned int arch_freq_get_on_cpu(int cpu);
 
 #ifndef arch_set_freq_scale

