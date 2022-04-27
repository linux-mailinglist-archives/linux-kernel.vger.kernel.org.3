Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2121511ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiD0OAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbiD0N73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:59:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9861713EAA;
        Wed, 27 Apr 2022 06:56:16 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:56:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651067775;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=312k+1Zx9pDd7SRCWUEIce3ACXEjPEasWM/zzfjWGpU=;
        b=Tx7OvDacn7MtuCcgZTSzBCWTYFFV87bZiKcmWEpQpbynKax1Lur7HbMmxejzEsmu0gYGlZ
        UlHOAzY3uo6l2yC+nQmrjO2u4yYt0UGm29J0SGYxv99dbi1+PdWTwJgPQDAwDOzpMtzLeA
        61nscJXXysSnNqCnB6GG5qNzZ/7RnERecpTRuDIxS0n0oWZmqypFrnEeJQiDNvknNcC2uA
        wO5rB4uIZyK78lF4Irw+yC+HQY6Oi+vSSr4eDJJK8/z5KtusoRPXhWHlCEZ5F3DnrbgDsA
        7F3el8OJWjtMfUtEsFS9Nw8cM6oFGXHZ6k5R/p9dosoV6VqXbX9Ss5TE9jpvYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651067775;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=312k+1Zx9pDd7SRCWUEIce3ACXEjPEasWM/zzfjWGpU=;
        b=dGPV4JB7rNkwKTEnHHbR8lV2zkST2KwUUBFCkqn2AYpXA1OYBdm2RnPSOX6u+hXLG3fbxW
        QLgKcSz/O2ro3UBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/smp: Move APERF/MPERF code where it belongs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415161206.478362457@linutronix.de>
References: <20220415161206.478362457@linutronix.de>
MIME-Version: 1.0
Message-ID: <165106777393.4207.683566493687257841.tip-bot2@tip-bot2>
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

Commit-ID:     55cb0b70749361d7f82a979768c77ac301f07da9
Gitweb:        https://git.kernel.org/tip/55cb0b70749361d7f82a979768c77ac301f07da9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 21:19:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 15:51:08 +02:00

x86/smp: Move APERF/MPERF code where it belongs

as this can share code with the preexisting APERF/MPERF code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20220415161206.478362457@linutronix.de

---
 arch/x86/kernel/cpu/aperfmperf.c | 366 +++++++++++++++++++++++++++++-
 arch/x86/kernel/smpboot.c        | 355 +-----------------------------
 2 files changed, 362 insertions(+), 359 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index ea9160f..35fff01 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -6,15 +6,19 @@
  * Copyright (C) 2017 Intel Corp.
  * Author: Len Brown <len.brown@intel.com>
  */
-
+#include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
 #include <linux/math64.h>
 #include <linux/percpu.h>
-#include <linux/cpufreq.h>
-#include <linux/smp.h>
-#include <linux/sched/isolation.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/isolation.h>
+#include <linux/sched/topology.h>
+#include <linux/smp.h>
+#include <linux/syscore_ops.h>
+
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 
 #include "cpu.h"
 
@@ -152,3 +156,357 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 
 	return per_cpu(samples.khz, cpu);
 }
+
+#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
+/*
+ * APERF/MPERF frequency ratio computation.
+ *
+ * The scheduler wants to do frequency invariant accounting and needs a <1
+ * ratio to account for the 'current' frequency, corresponding to
+ * freq_curr / freq_max.
+ *
+ * Since the frequency freq_curr on x86 is controlled by micro-controller and
+ * our P-state setting is little more than a request/hint, we need to observe
+ * the effective frequency 'BusyMHz', i.e. the average frequency over a time
+ * interval after discarding idle time. This is given by:
+ *
+ *   BusyMHz = delta_APERF / delta_MPERF * freq_base
+ *
+ * where freq_base is the max non-turbo P-state.
+ *
+ * The freq_max term has to be set to a somewhat arbitrary value, because we
+ * can't know which turbo states will be available at a given point in time:
+ * it all depends on the thermal headroom of the entire package. We set it to
+ * the turbo level with 4 cores active.
+ *
+ * Benchmarks show that's a good compromise between the 1C turbo ratio
+ * (freq_curr/freq_max would rarely reach 1) and something close to freq_base,
+ * which would ignore the entire turbo range (a conspicuous part, making
+ * freq_curr/freq_max always maxed out).
+ *
+ * An exception to the heuristic above is the Atom uarch, where we choose the
+ * highest turbo level for freq_max since Atom's are generally oriented towards
+ * power efficiency.
+ *
+ * Setting freq_max to anything less than the 1C turbo ratio makes the ratio
+ * freq_curr / freq_max to eventually grow >1, in which case we clip it to 1.
+ */
+
+DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
+
+static DEFINE_PER_CPU(u64, arch_prev_aperf);
+static DEFINE_PER_CPU(u64, arch_prev_mperf);
+static u64 arch_turbo_freq_ratio = SCHED_CAPACITY_SCALE;
+static u64 arch_max_freq_ratio = SCHED_CAPACITY_SCALE;
+
+void arch_set_max_freq_ratio(bool turbo_disabled)
+{
+	arch_max_freq_ratio = turbo_disabled ? SCHED_CAPACITY_SCALE :
+					arch_turbo_freq_ratio;
+}
+EXPORT_SYMBOL_GPL(arch_set_max_freq_ratio);
+
+static bool turbo_disabled(void)
+{
+	u64 misc_en;
+	int err;
+
+	err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
+	if (err)
+		return false;
+
+	return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
+}
+
+static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
+{
+	int err;
+
+	err = rdmsrl_safe(MSR_ATOM_CORE_RATIOS, base_freq);
+	if (err)
+		return false;
+
+	err = rdmsrl_safe(MSR_ATOM_CORE_TURBO_RATIOS, turbo_freq);
+	if (err)
+		return false;
+
+	*base_freq = (*base_freq >> 16) & 0x3F;     /* max P state */
+	*turbo_freq = *turbo_freq & 0x3F;           /* 1C turbo    */
+
+	return true;
+}
+
+#define X86_MATCH(model)					\
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
+		INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
+
+static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
+	X86_MATCH(XEON_PHI_KNL),
+	X86_MATCH(XEON_PHI_KNM),
+	{}
+};
+
+static const struct x86_cpu_id has_skx_turbo_ratio_limits[] = {
+	X86_MATCH(SKYLAKE_X),
+	{}
+};
+
+static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
+	X86_MATCH(ATOM_GOLDMONT),
+	X86_MATCH(ATOM_GOLDMONT_D),
+	X86_MATCH(ATOM_GOLDMONT_PLUS),
+	{}
+};
+
+static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
+				int num_delta_fratio)
+{
+	int fratio, delta_fratio, found;
+	int err, i;
+	u64 msr;
+
+	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
+	if (err)
+		return false;
+
+	*base_freq = (*base_freq >> 8) & 0xFF;	    /* max P state */
+
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
+	if (err)
+		return false;
+
+	fratio = (msr >> 8) & 0xFF;
+	i = 16;
+	found = 0;
+	do {
+		if (found >= num_delta_fratio) {
+			*turbo_freq = fratio;
+			return true;
+		}
+
+		delta_fratio = (msr >> (i + 5)) & 0x7;
+
+		if (delta_fratio) {
+			found += 1;
+			fratio -= delta_fratio;
+		}
+
+		i += 8;
+	} while (i < 64);
+
+	return true;
+}
+
+static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
+{
+	u64 ratios, counts;
+	u32 group_size;
+	int err, i;
+
+	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
+	if (err)
+		return false;
+
+	*base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
+
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &ratios);
+	if (err)
+		return false;
+
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT1, &counts);
+	if (err)
+		return false;
+
+	for (i = 0; i < 64; i += 8) {
+		group_size = (counts >> i) & 0xFF;
+		if (group_size >= size) {
+			*turbo_freq = (ratios >> i) & 0xFF;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
+{
+	u64 msr;
+	int err;
+
+	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
+	if (err)
+		return false;
+
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
+	if (err)
+		return false;
+
+	*base_freq = (*base_freq >> 8) & 0xFF;    /* max P state */
+	*turbo_freq = (msr >> 24) & 0xFF;         /* 4C turbo    */
+
+	/* The CPU may have less than 4 cores */
+	if (!*turbo_freq)
+		*turbo_freq = msr & 0xFF;         /* 1C turbo    */
+
+	return true;
+}
+
+static bool intel_set_max_freq_ratio(void)
+{
+	u64 base_freq, turbo_freq;
+	u64 turbo_ratio;
+
+	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
+		goto out;
+
+	if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
+	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
+		goto out;
+
+	if (x86_match_cpu(has_knl_turbo_ratio_limits) &&
+	    knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
+		goto out;
+
+	if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
+	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4))
+		goto out;
+
+	if (core_set_max_freq_ratio(&base_freq, &turbo_freq))
+		goto out;
+
+	return false;
+
+out:
+	/*
+	 * Some hypervisors advertise X86_FEATURE_APERFMPERF
+	 * but then fill all MSR's with zeroes.
+	 * Some CPUs have turbo boost but don't declare any turbo ratio
+	 * in MSR_TURBO_RATIO_LIMIT.
+	 */
+	if (!base_freq || !turbo_freq) {
+		pr_debug("Couldn't determine cpu base or turbo frequency, necessary for scale-invariant accounting.\n");
+		return false;
+	}
+
+	turbo_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE, base_freq);
+	if (!turbo_ratio) {
+		pr_debug("Non-zero turbo and base frequencies led to a 0 ratio.\n");
+		return false;
+	}
+
+	arch_turbo_freq_ratio = turbo_ratio;
+	arch_set_max_freq_ratio(turbo_disabled());
+
+	return true;
+}
+
+static void init_counter_refs(void)
+{
+	u64 aperf, mperf;
+
+	rdmsrl(MSR_IA32_APERF, aperf);
+	rdmsrl(MSR_IA32_MPERF, mperf);
+
+	this_cpu_write(arch_prev_aperf, aperf);
+	this_cpu_write(arch_prev_mperf, mperf);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static struct syscore_ops freq_invariance_syscore_ops = {
+	.resume = init_counter_refs,
+};
+
+static void register_freq_invariance_syscore_ops(void)
+{
+	/* Bail out if registered already. */
+	if (freq_invariance_syscore_ops.node.prev)
+		return;
+
+	register_syscore_ops(&freq_invariance_syscore_ops);
+}
+#else
+static inline void register_freq_invariance_syscore_ops(void) {}
+#endif
+
+void init_freq_invariance(bool secondary, bool cppc_ready)
+{
+	bool ret = false;
+
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
+		return;
+
+	if (secondary) {
+		if (static_branch_likely(&arch_scale_freq_key)) {
+			init_counter_refs();
+		}
+		return;
+	}
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		ret = intel_set_max_freq_ratio();
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		if (!cppc_ready) {
+			return;
+		}
+		ret = amd_set_max_freq_ratio(&arch_turbo_freq_ratio);
+	}
+
+	if (ret) {
+		init_counter_refs();
+		static_branch_enable(&arch_scale_freq_key);
+		register_freq_invariance_syscore_ops();
+		pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
+	} else {
+		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
+	}
+}
+
+static void disable_freq_invariance_workfn(struct work_struct *work)
+{
+	static_branch_disable(&arch_scale_freq_key);
+}
+
+static DECLARE_WORK(disable_freq_invariance_work,
+		    disable_freq_invariance_workfn);
+
+DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
+
+void arch_scale_freq_tick(void)
+{
+	u64 freq_scale;
+	u64 aperf, mperf;
+	u64 acnt, mcnt;
+
+	if (!arch_scale_freq_invariant())
+		return;
+
+	rdmsrl(MSR_IA32_APERF, aperf);
+	rdmsrl(MSR_IA32_MPERF, mperf);
+
+	acnt = aperf - this_cpu_read(arch_prev_aperf);
+	mcnt = mperf - this_cpu_read(arch_prev_mperf);
+
+	this_cpu_write(arch_prev_aperf, aperf);
+	this_cpu_write(arch_prev_mperf, mperf);
+
+	if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
+		goto error;
+
+	if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
+		goto error;
+
+	freq_scale = div64_u64(acnt, mcnt);
+	if (!freq_scale)
+		goto error;
+
+	if (freq_scale > SCHED_CAPACITY_SCALE)
+		freq_scale = SCHED_CAPACITY_SCALE;
+
+	this_cpu_write(arch_freq_scale, freq_scale);
+	return;
+
+error:
+	pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
+	schedule_work(&disable_freq_invariance_work);
+}
+#endif /* CONFIG_X86_64 && CONFIG_SMP */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 2ef1477..a9fc16a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -56,7 +56,6 @@
 #include <linux/numa.h>
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
-#include <linux/syscore_ops.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -1847,357 +1846,3 @@ void native_play_dead(void)
 }
 
 #endif
-
-#ifdef CONFIG_X86_64
-/*
- * APERF/MPERF frequency ratio computation.
- *
- * The scheduler wants to do frequency invariant accounting and needs a <1
- * ratio to account for the 'current' frequency, corresponding to
- * freq_curr / freq_max.
- *
- * Since the frequency freq_curr on x86 is controlled by micro-controller and
- * our P-state setting is little more than a request/hint, we need to observe
- * the effective frequency 'BusyMHz', i.e. the average frequency over a time
- * interval after discarding idle time. This is given by:
- *
- *   BusyMHz = delta_APERF / delta_MPERF * freq_base
- *
- * where freq_base is the max non-turbo P-state.
- *
- * The freq_max term has to be set to a somewhat arbitrary value, because we
- * can't know which turbo states will be available at a given point in time:
- * it all depends on the thermal headroom of the entire package. We set it to
- * the turbo level with 4 cores active.
- *
- * Benchmarks show that's a good compromise between the 1C turbo ratio
- * (freq_curr/freq_max would rarely reach 1) and something close to freq_base,
- * which would ignore the entire turbo range (a conspicuous part, making
- * freq_curr/freq_max always maxed out).
- *
- * An exception to the heuristic above is the Atom uarch, where we choose the
- * highest turbo level for freq_max since Atom's are generally oriented towards
- * power efficiency.
- *
- * Setting freq_max to anything less than the 1C turbo ratio makes the ratio
- * freq_curr / freq_max to eventually grow >1, in which case we clip it to 1.
- */
-
-DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
-
-static DEFINE_PER_CPU(u64, arch_prev_aperf);
-static DEFINE_PER_CPU(u64, arch_prev_mperf);
-static u64 arch_turbo_freq_ratio = SCHED_CAPACITY_SCALE;
-static u64 arch_max_freq_ratio = SCHED_CAPACITY_SCALE;
-
-void arch_set_max_freq_ratio(bool turbo_disabled)
-{
-	arch_max_freq_ratio = turbo_disabled ? SCHED_CAPACITY_SCALE :
-					arch_turbo_freq_ratio;
-}
-EXPORT_SYMBOL_GPL(arch_set_max_freq_ratio);
-
-static bool turbo_disabled(void)
-{
-	u64 misc_en;
-	int err;
-
-	err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
-	if (err)
-		return false;
-
-	return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
-}
-
-static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
-{
-	int err;
-
-	err = rdmsrl_safe(MSR_ATOM_CORE_RATIOS, base_freq);
-	if (err)
-		return false;
-
-	err = rdmsrl_safe(MSR_ATOM_CORE_TURBO_RATIOS, turbo_freq);
-	if (err)
-		return false;
-
-	*base_freq = (*base_freq >> 16) & 0x3F;     /* max P state */
-	*turbo_freq = *turbo_freq & 0x3F;           /* 1C turbo    */
-
-	return true;
-}
-
-#define X86_MATCH(model)					\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
-		INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
-
-static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
-	X86_MATCH(XEON_PHI_KNL),
-	X86_MATCH(XEON_PHI_KNM),
-	{}
-};
-
-static const struct x86_cpu_id has_skx_turbo_ratio_limits[] = {
-	X86_MATCH(SKYLAKE_X),
-	{}
-};
-
-static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
-	X86_MATCH(ATOM_GOLDMONT),
-	X86_MATCH(ATOM_GOLDMONT_D),
-	X86_MATCH(ATOM_GOLDMONT_PLUS),
-	{}
-};
-
-static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
-				int num_delta_fratio)
-{
-	int fratio, delta_fratio, found;
-	int err, i;
-	u64 msr;
-
-	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
-	if (err)
-		return false;
-
-	*base_freq = (*base_freq >> 8) & 0xFF;	    /* max P state */
-
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
-	if (err)
-		return false;
-
-	fratio = (msr >> 8) & 0xFF;
-	i = 16;
-	found = 0;
-	do {
-		if (found >= num_delta_fratio) {
-			*turbo_freq = fratio;
-			return true;
-		}
-
-		delta_fratio = (msr >> (i + 5)) & 0x7;
-
-		if (delta_fratio) {
-			found += 1;
-			fratio -= delta_fratio;
-		}
-
-		i += 8;
-	} while (i < 64);
-
-	return true;
-}
-
-static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
-{
-	u64 ratios, counts;
-	u32 group_size;
-	int err, i;
-
-	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
-	if (err)
-		return false;
-
-	*base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
-
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &ratios);
-	if (err)
-		return false;
-
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT1, &counts);
-	if (err)
-		return false;
-
-	for (i = 0; i < 64; i += 8) {
-		group_size = (counts >> i) & 0xFF;
-		if (group_size >= size) {
-			*turbo_freq = (ratios >> i) & 0xFF;
-			return true;
-		}
-	}
-
-	return false;
-}
-
-static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
-{
-	u64 msr;
-	int err;
-
-	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
-	if (err)
-		return false;
-
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
-	if (err)
-		return false;
-
-	*base_freq = (*base_freq >> 8) & 0xFF;    /* max P state */
-	*turbo_freq = (msr >> 24) & 0xFF;         /* 4C turbo    */
-
-	/* The CPU may have less than 4 cores */
-	if (!*turbo_freq)
-		*turbo_freq = msr & 0xFF;         /* 1C turbo    */
-
-	return true;
-}
-
-static bool intel_set_max_freq_ratio(void)
-{
-	u64 base_freq, turbo_freq;
-	u64 turbo_ratio;
-
-	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
-		goto out;
-
-	if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
-	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
-		goto out;
-
-	if (x86_match_cpu(has_knl_turbo_ratio_limits) &&
-	    knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
-		goto out;
-
-	if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
-	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4))
-		goto out;
-
-	if (core_set_max_freq_ratio(&base_freq, &turbo_freq))
-		goto out;
-
-	return false;
-
-out:
-	/*
-	 * Some hypervisors advertise X86_FEATURE_APERFMPERF
-	 * but then fill all MSR's with zeroes.
-	 * Some CPUs have turbo boost but don't declare any turbo ratio
-	 * in MSR_TURBO_RATIO_LIMIT.
-	 */
-	if (!base_freq || !turbo_freq) {
-		pr_debug("Couldn't determine cpu base or turbo frequency, necessary for scale-invariant accounting.\n");
-		return false;
-	}
-
-	turbo_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE, base_freq);
-	if (!turbo_ratio) {
-		pr_debug("Non-zero turbo and base frequencies led to a 0 ratio.\n");
-		return false;
-	}
-
-	arch_turbo_freq_ratio = turbo_ratio;
-	arch_set_max_freq_ratio(turbo_disabled());
-
-	return true;
-}
-
-static void init_counter_refs(void)
-{
-	u64 aperf, mperf;
-
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
-
-	this_cpu_write(arch_prev_aperf, aperf);
-	this_cpu_write(arch_prev_mperf, mperf);
-}
-
-#ifdef CONFIG_PM_SLEEP
-static struct syscore_ops freq_invariance_syscore_ops = {
-	.resume = init_counter_refs,
-};
-
-static void register_freq_invariance_syscore_ops(void)
-{
-	/* Bail out if registered already. */
-	if (freq_invariance_syscore_ops.node.prev)
-		return;
-
-	register_syscore_ops(&freq_invariance_syscore_ops);
-}
-#else
-static inline void register_freq_invariance_syscore_ops(void) {}
-#endif
-
-void init_freq_invariance(bool secondary, bool cppc_ready)
-{
-	bool ret = false;
-
-	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
-		return;
-
-	if (secondary) {
-		if (static_branch_likely(&arch_scale_freq_key)) {
-			init_counter_refs();
-		}
-		return;
-	}
-
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
-		ret = intel_set_max_freq_ratio();
-	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		if (!cppc_ready) {
-			return;
-		}
-		ret = amd_set_max_freq_ratio(&arch_turbo_freq_ratio);
-	}
-
-	if (ret) {
-		init_counter_refs();
-		static_branch_enable(&arch_scale_freq_key);
-		register_freq_invariance_syscore_ops();
-		pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
-	} else {
-		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
-	}
-}
-
-static void disable_freq_invariance_workfn(struct work_struct *work)
-{
-	static_branch_disable(&arch_scale_freq_key);
-}
-
-static DECLARE_WORK(disable_freq_invariance_work,
-		    disable_freq_invariance_workfn);
-
-DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
-
-void arch_scale_freq_tick(void)
-{
-	u64 freq_scale;
-	u64 aperf, mperf;
-	u64 acnt, mcnt;
-
-	if (!arch_scale_freq_invariant())
-		return;
-
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
-
-	acnt = aperf - this_cpu_read(arch_prev_aperf);
-	mcnt = mperf - this_cpu_read(arch_prev_mperf);
-
-	this_cpu_write(arch_prev_aperf, aperf);
-	this_cpu_write(arch_prev_mperf, mperf);
-
-	if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
-		goto error;
-
-	if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
-		goto error;
-
-	freq_scale = div64_u64(acnt, mcnt);
-	if (!freq_scale)
-		goto error;
-
-	if (freq_scale > SCHED_CAPACITY_SCALE)
-		freq_scale = SCHED_CAPACITY_SCALE;
-
-	this_cpu_write(arch_freq_scale, freq_scale);
-	return;
-
-error:
-	pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
-	schedule_work(&disable_freq_invariance_work);
-}
-#endif /* CONFIG_X86_64 */
