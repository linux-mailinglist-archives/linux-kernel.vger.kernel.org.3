Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578FF51192C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiD0OAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbiD0N70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:59:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B11E3464B;
        Wed, 27 Apr 2022 06:56:08 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:56:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651067767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C5smDIbG45jhVWZCKV0dHaEoPAtm3onBdnDDrbZ1Da8=;
        b=1kTLFMDnTLnFkoLYoorJ1PbeoT2ALfDMt3bsyJMkuLclboCSv8zUkEv2NRPhNdnoDdrlLC
        35M0JaOZRfUXdoud6QWHA4yi9JpwGmnvZw6AwTLt/yH4Rh4ba/O4rTsRcrqZQYClKSa7Yt
        eWmljpUEiJvRZ0aWdKjBGwHbhkU0v34brd8ajy3TZNfdl2m/lKzOl7wtfJTWQQNJYqp3Ej
        fMWH/Awd+QnDq+E4fLeYxziH+VBUDejahOzlOE3bJpI5VtaH793iYWgoA5bbgB1gllztQ3
        4BJiJQZFsGJW6O9BO6VHNMQyZ/kUWFMzpZ1t4Jh4vPsivMsHrOp6DdSACHwdhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651067767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C5smDIbG45jhVWZCKV0dHaEoPAtm3onBdnDDrbZ1Da8=;
        b=dpWpkxRL6b5tvK2360FcyitklYLU3riCiRFOLjrL7w56mA80Ljej6wIKTyNscyz/EvA2tN
        pjN+fWxGPhpXjkCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/aperfmperf: Replace arch_freq_get_on_cpu()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415161206.934040006@linutronix.de>
References: <20220415161206.934040006@linutronix.de>
MIME-Version: 1.0
Message-ID: <165106776589.4207.4086346739108492456.tip-bot2@tip-bot2>
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

Commit-ID:     a86a1356ee79da6bc4abfb9e0499f963ff6da9ae
Gitweb:        https://git.kernel.org/tip/a86a1356ee79da6bc4abfb9e0499f963ff6da9ae
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 21:20:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 15:51:09 +02:00

x86/aperfmperf: Replace arch_freq_get_on_cpu()

Reading the current CPU frequency from /sys/..../scaling_cur_freq involves
in the worst case two IPIs due to the ad hoc sampling.

The frequency invariance infrastructure provides the APERF/MPERF samples
already. Utilize them and consolidate this with the /proc/cpuinfo readout.

The sample is considered valid for 20ms. So for idle or isolated NOHZ full
CPUs the function returns 0, which is matching the previous behaviour.

The resulting text size vs. the original APERF/MPERF plus the separate
frequency invariance code:

  text:		2411	->   723
  init.text:	   0	->   767

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20220415161206.934040006@linutronix.de

---
 arch/x86/kernel/cpu/aperfmperf.c | 94 +-------------------------------
 arch/x86/kernel/cpu/proc.c       |  2 +-
 2 files changed, 2 insertions(+), 94 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index e9d2da7..b15c884 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -36,98 +36,6 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct aperfmperf, cpu_samples) = {
 	.seq = SEQCNT_ZERO(cpu_samples.seq)
 };
 
-struct aperfmperf_sample {
-	unsigned int	khz;
-	atomic_t	scfpending;
-	ktime_t	time;
-	u64	aperf;
-	u64	mperf;
-};
-
-static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
-
-#define APERFMPERF_CACHE_THRESHOLD_MS	10
-#define APERFMPERF_REFRESH_DELAY_MS	10
-#define APERFMPERF_STALE_THRESHOLD_MS	1000
-
-/*
- * aperfmperf_snapshot_khz()
- * On the current CPU, snapshot APERF, MPERF, and jiffies
- * unless we already did it within 10ms
- * calculate kHz, save snapshot
- */
-static void aperfmperf_snapshot_khz(void *dummy)
-{
-	u64 aperf, aperf_delta;
-	u64 mperf, mperf_delta;
-	struct aperfmperf_sample *s = this_cpu_ptr(&samples);
-	unsigned long flags;
-
-	local_irq_save(flags);
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
-	local_irq_restore(flags);
-
-	aperf_delta = aperf - s->aperf;
-	mperf_delta = mperf - s->mperf;
-
-	/*
-	 * There is no architectural guarantee that MPERF
-	 * increments faster than we can read it.
-	 */
-	if (mperf_delta == 0)
-		return;
-
-	s->time = ktime_get();
-	s->aperf = aperf;
-	s->mperf = mperf;
-	s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
-	atomic_set_release(&s->scfpending, 0);
-}
-
-static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
-{
-	s64 time_delta = ktime_ms_delta(now, per_cpu(samples.time, cpu));
-	struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
-
-	/* Don't bother re-computing within the cache threshold time. */
-	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
-		return true;
-
-	if (!atomic_xchg(&s->scfpending, 1) || wait)
-		smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
-
-	/* Return false if the previous iteration was too long ago. */
-	return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
-}
-
-unsigned int arch_freq_get_on_cpu(int cpu)
-{
-	struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
-
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
-		return 0;
-
-	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
-		return per_cpu(samples.khz, cpu);
-
-	msleep(APERFMPERF_REFRESH_DELAY_MS);
-	atomic_set(&s->scfpending, 1);
-	smp_mb(); /* ->scfpending before smp_call_function_single(). */
-	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
-
-	return per_cpu(samples.khz, cpu);
-}
-
 static void init_counter_refs(void)
 {
 	u64 aperf, mperf;
@@ -494,7 +402,7 @@ void arch_scale_freq_tick(void)
  */
 #define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
 
-unsigned int aperfmperf_get_khz(int cpu)
+unsigned int arch_freq_get_on_cpu(int cpu)
 {
 	struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
 	unsigned long last;
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 4eec888..0a0ee55 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -84,7 +84,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
 
 	if (cpu_has(c, X86_FEATURE_TSC)) {
-		unsigned int freq = aperfmperf_get_khz(cpu);
+		unsigned int freq = arch_freq_get_on_cpu(cpu);
 
 		if (!freq)
 			freq = cpufreq_quick_get(cpu);
