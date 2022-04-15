Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE9B502F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350179AbiDOTXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349450AbiDOTWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:22:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2128449CB7;
        Fri, 15 Apr 2022 12:20:06 -0700 (PDT)
Message-ID: <20220415161206.934040006@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650050404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/7LOTx5hx+68ftEvKF2Kc2mzFZcFNFGa3+VDAnNipgs=;
        b=GaUoxDIsPqmzxlXffXRK+ealpE55XymsmTSL/XJsrOjViIeYvJ37JvNgZgVlK7gv+dOIW7
        qWQEMSwdB/NaheS/wdMHBDJpnKAjNKYw80HWKv1DcD3LrAm2npH7ZHbzd/m/wuvf/vUTjW
        vIXCCav3r6fzk2s/JA5R9hlKbpSqV+OSfAG5PL5Bbt+Hsdf6rGtfsedPGrc6PEr+uctYLQ
        3Bf2i0wdffu/Xn9oOzvRL+chJZUYrlZ0G8hx33AynsTSVUMGb2QyVl2tt4McIxiOHRH9Hz
        tCABN3rlmuV9yjmzKatydBi5Oiff9Z1P/wse2hNahQu6Snj9HtLpy3KvmpBlrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650050404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/7LOTx5hx+68ftEvKF2Kc2mzFZcFNFGa3+VDAnNipgs=;
        b=dAza+VAiQGEv5S45kUuVVsNj3+xxkX4pyoGiKm1qRfoTV/b9TE6V0A9YEQK8Tm6uvfYIoT
        AglGamnDJTRveqBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 10/10] x86/aperfmperf: Replace arch_freq_get_on_cpu()
References: <20220415133356.179706384@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Apr 2022 21:20:04 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/kernel/cpu/aperfmperf.c |   94 ---------------------------------------
 arch/x86/kernel/cpu/proc.c       |    2 
 2 files changed, 2 insertions(+), 94 deletions(-)

--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -35,98 +35,6 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(str
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
@@ -493,7 +401,7 @@ void arch_scale_freq_tick(void)
  */
 #define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
 
-unsigned int aperfmperf_get_khz(int cpu)
+unsigned int arch_freq_get_on_cpu(int cpu)
 {
 	struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
 	unsigned long last;
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -84,7 +84,7 @@ static int show_cpuinfo(struct seq_file
 		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
 
 	if (cpu_has(c, X86_FEATURE_TSC)) {
-		unsigned int freq = aperfmperf_get_khz(cpu);
+		unsigned int freq = arch_freq_get_on_cpu(cpu);
 
 		if (!freq)
 			freq = cpufreq_quick_get(cpu);

