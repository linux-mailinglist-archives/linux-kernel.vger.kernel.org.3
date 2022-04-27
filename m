Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0625512166
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiD0Sqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiD0SqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:46:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE4577F2B;
        Wed, 27 Apr 2022 11:27:24 -0700 (PDT)
Date:   Wed, 27 Apr 2022 18:27:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651084043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoL9U2XeqD0PtJ1Nb4hPBI9JvQ7sPP+X93InhSo141M=;
        b=Wv5duAFyHzbRWBZ61BHFY9zLMsNMrNp+AMX52w+EI4VZl+j1dXuhxQK90pZ/11h9oJFsRw
        +GzOdQfqVnwY6JIqHu+3W7cOZERgE1t4Qm5M6kXJBkVMZ8ZmIuaf5nC5WNYZTym7sRcxIw
        RoODRaKDi+3PJtIRw1FBUBBccr/aTKn2KOn/MHBv3zjx6FJhSIbvaJdgwhhU762kNEZVxx
        TYZB7cOXsL7sjSomqr0fSTaeo2Jtk81aeDoAQmfGUupC9RqnSB/H+cE3vdYHNotZLOquEz
        qRudtyDpcj8531ugOCEz5AoGUuzR5Nsge8mxTqYNKytkdXzKglMX3TopD6Leug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651084043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoL9U2XeqD0PtJ1Nb4hPBI9JvQ7sPP+X93InhSo141M=;
        b=j5CYxGT1qNRAvGNYZ4YzXgExAJ4ehwLAoQcDurJJADD5UgeHjKxkjgPJXsy1RwD1q3qPuz
        WP+lvTolQqWoIWDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/aperfmperf: Replace aperfmperf_get_khz()
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415161206.875029458@linutronix.de>
References: <20220415161206.875029458@linutronix.de>
MIME-Version: 1.0
Message-ID: <165108404211.4207.14508957205854528512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     7d84c1ebf9ddafca27b481e6da7d24a023dacaa2
Gitweb:        https://git.kernel.org/tip/7d84c1ebf9ddafca27b481e6da7d24a023dacaa2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 21:20:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 20:22:19 +02:00

x86/aperfmperf: Replace aperfmperf_get_khz()

The frequency invariance infrastructure provides the APERF/MPERF samples
already. Utilize them for the cpu frequency display in /proc/cpuinfo.

The sample is considered valid for 20ms. So for idle or isolated NOHZ full
CPUs the function returns 0, which is matching the previous behaviour.

This gets rid of the mass IPIs and a delay of 20ms for stabilizing observed
by Eric when reading /proc/cpuinfo.

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20220415161206.875029458@linutronix.de

---
 arch/x86/kernel/cpu/aperfmperf.c | 77 +++++++++++++------------------
 fs/proc/cpuinfo.c                |  6 +--
 include/linux/cpufreq.h          |  1 +-
 3 files changed, 35 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 963c069..e9d2da7 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -101,49 +101,6 @@ static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
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
@@ -530,6 +487,40 @@ void arch_scale_freq_tick(void)
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
diff --git a/fs/proc/cpuinfo.c b/fs/proc/cpuinfo.c
index 419760f..f38bda5 100644
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
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 35c7d6d..d5595d5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1199,7 +1199,6 @@ static inline void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
 			struct cpufreq_governor *old_gov) { }
 #endif
 
-extern void arch_freq_prepare_all(void);
 extern unsigned int arch_freq_get_on_cpu(int cpu);
 
 #ifndef arch_set_freq_scale
