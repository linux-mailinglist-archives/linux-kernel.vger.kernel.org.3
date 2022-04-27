Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7AD512168
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiD0Sqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiD0SqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:46:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1EAD3469;
        Wed, 27 Apr 2022 11:27:29 -0700 (PDT)
Date:   Wed, 27 Apr 2022 18:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651084047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRSy+wumIGwVXSlnkrrQUlyTgxgbUG1hWXEw4SsAuBo=;
        b=XGsWyXaSMpW8cG/YKFEQ5aM5zqfl1N9i3hLF6sFQRcOzr2caq00CKARmrLsmg5HYyf2BUz
        cnXWIRGeU3Pzz8mGzkL5kVnTfGkwzQ5CiHkNy+Bx1tp7ecp+EOQCbhktUlaZLRhJQmqCYs
        kZ5UBqGYuR0WX4o1+ltcN9+SQq3vzv3WMVr3B6hBNU8ih+XjaH6jxRj2ht9DjqN7YUjWJ5
        S5bFFGuVQDk+HjhNmtxWCTrhCjkOVGGcN8UqLPZLPrfW3Wc3B6ZCksL1g7jts1hmSx8cDX
        4RctBsLQoKxgqHpqMw9vcST2pbDDXNmmed8Iw6xn8+89DSatJ15Wuomfp7PXmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651084047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRSy+wumIGwVXSlnkrrQUlyTgxgbUG1hWXEw4SsAuBo=;
        b=HMcEhCT5NwwSgCrdiZizWl6mmM6x0gFPR9Kp6vQykUP5paI5ue7dWEWpxJw5xPIEnX0GiI
        Cgh1IkbAlxVgtwAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/aperfmperf: Untangle Intel and AMD frequency
 invariance init
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415161206.592465719@linutronix.de>
References: <20220415161206.592465719@linutronix.de>
MIME-Version: 1.0
Message-ID: <165108404666.4207.18218459360410704194.tip-bot2@tip-bot2>
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

Commit-ID:     0dfaf3f6ecc0c7f4f876255aa82e8959d3721365
Gitweb:        https://git.kernel.org/tip/0dfaf3f6ecc0c7f4f876255aa82e8959d3721365
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 21:19:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 20:22:19 +02:00

x86/aperfmperf: Untangle Intel and AMD frequency invariance init

AMD boot CPU initialization happens late via ACPI/CPPC which prevents the
Intel parts from being marked __init.

Split out the common code and provide a dedicated interface for the AMD
initialization and mark the Intel specific code and data __init.

The remaining text size is almost cut in half:

  text:		2614	->	1350
  init.text:	   0	->	 786

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20220415161206.592465719@linutronix.de

---
 arch/x86/include/asm/topology.h  | 13 ++-----
 arch/x86/kernel/acpi/cppc.c      | 30 +++++++--------
 arch/x86/kernel/cpu/aperfmperf.c | 62 ++++++++++++++++---------------
 arch/x86/kernel/smpboot.c        |  2 +-
 4 files changed, 51 insertions(+), 56 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index e2faedc..cc31707 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -216,24 +216,19 @@ extern void arch_scale_freq_tick(void);
 #define arch_scale_freq_tick arch_scale_freq_tick
 
 extern void arch_set_max_freq_ratio(bool turbo_disabled);
-extern void bp_init_freq_invariance(bool cppc_ready);
+extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
+extern void bp_init_freq_invariance(void);
 extern void ap_init_freq_invariance(void);
 #else
 static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
-static inline void bp_init_freq_invariance(bool cppc_ready) { }
+static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
+static inline void bp_init_freq_invariance(void) { }
 static inline void ap_init_freq_invariance(void) { }
 #endif
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 void init_freq_invariance_cppc(void);
 #define arch_init_invariance_cppc init_freq_invariance_cppc
-
-bool amd_set_max_freq_ratio(u64 *ratio);
-#else
-static inline bool amd_set_max_freq_ratio(u64 *ratio)
-{
-	return false;
-}
 #endif
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 06109d9..8b8cbf2 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -50,20 +50,17 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 	return err;
 }
 
-bool amd_set_max_freq_ratio(u64 *ratio)
+static void amd_set_max_freq_ratio(void)
 {
 	struct cppc_perf_caps perf_caps;
 	u64 highest_perf, nominal_perf;
 	u64 perf_ratio;
 	int rc;
 
-	if (!ratio)
-		return false;
-
 	rc = cppc_get_perf_caps(0, &perf_caps);
 	if (rc) {
 		pr_debug("Could not retrieve perf counters (%d)\n", rc);
-		return false;
+		return;
 	}
 
 	highest_perf = amd_get_highest_perf();
@@ -71,7 +68,7 @@ bool amd_set_max_freq_ratio(u64 *ratio)
 
 	if (!highest_perf || !nominal_perf) {
 		pr_debug("Could not retrieve highest or nominal performance\n");
-		return false;
+		return;
 	}
 
 	perf_ratio = div_u64(highest_perf * SCHED_CAPACITY_SCALE, nominal_perf);
@@ -79,26 +76,27 @@ bool amd_set_max_freq_ratio(u64 *ratio)
 	perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
 	if (!perf_ratio) {
 		pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
-		return false;
+		return;
 	}
 
-	*ratio = perf_ratio;
-	arch_set_max_freq_ratio(false);
-
-	return true;
+	freq_invariance_set_perf_ratio(perf_ratio, false);
 }
 
 static DEFINE_MUTEX(freq_invariance_lock);
 
 void init_freq_invariance_cppc(void)
 {
-	static bool secondary;
+	static bool init_done;
 
-	mutex_lock(&freq_invariance_lock);
+	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
+		return;
 
-	if (!secondary)
-		bp_init_freq_invariance(true);
-	secondary = true;
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return;
 
+	mutex_lock(&freq_invariance_lock);
+	if (!init_done)
+		amd_set_max_freq_ratio();
+	init_done = true;
 	mutex_unlock(&freq_invariance_lock);
 }
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 87f34f2..b4f4ea5 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -206,7 +206,7 @@ void arch_set_max_freq_ratio(bool turbo_disabled)
 }
 EXPORT_SYMBOL_GPL(arch_set_max_freq_ratio);
 
-static bool turbo_disabled(void)
+static bool __init turbo_disabled(void)
 {
 	u64 misc_en;
 	int err;
@@ -218,7 +218,7 @@ static bool turbo_disabled(void)
 	return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
 }
 
-static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
+static bool __init slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 {
 	int err;
 
@@ -240,26 +240,26 @@ static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
 		INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
 
-static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
+static const struct x86_cpu_id has_knl_turbo_ratio_limits[] __initconst = {
 	X86_MATCH(XEON_PHI_KNL),
 	X86_MATCH(XEON_PHI_KNM),
 	{}
 };
 
-static const struct x86_cpu_id has_skx_turbo_ratio_limits[] = {
+static const struct x86_cpu_id has_skx_turbo_ratio_limits[] __initconst = {
 	X86_MATCH(SKYLAKE_X),
 	{}
 };
 
-static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
+static const struct x86_cpu_id has_glm_turbo_ratio_limits[] __initconst = {
 	X86_MATCH(ATOM_GOLDMONT),
 	X86_MATCH(ATOM_GOLDMONT_D),
 	X86_MATCH(ATOM_GOLDMONT_PLUS),
 	{}
 };
 
-static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
-				int num_delta_fratio)
+static bool __init knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
+					  int num_delta_fratio)
 {
 	int fratio, delta_fratio, found;
 	int err, i;
@@ -297,7 +297,7 @@ static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
 	return true;
 }
 
-static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
+static bool __init skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
 {
 	u64 ratios, counts;
 	u32 group_size;
@@ -328,7 +328,7 @@ static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
 	return false;
 }
 
-static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
+static bool __init core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 {
 	u64 msr;
 	int err;
@@ -351,7 +351,7 @@ static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 	return true;
 }
 
-static bool intel_set_max_freq_ratio(void)
+static bool __init intel_set_max_freq_ratio(void)
 {
 	u64 base_freq, turbo_freq;
 	u64 turbo_ratio;
@@ -418,40 +418,42 @@ static struct syscore_ops freq_invariance_syscore_ops = {
 
 static void register_freq_invariance_syscore_ops(void)
 {
-	/* Bail out if registered already. */
-	if (freq_invariance_syscore_ops.node.prev)
-		return;
-
 	register_syscore_ops(&freq_invariance_syscore_ops);
 }
 #else
 static inline void register_freq_invariance_syscore_ops(void) {}
 #endif
 
-void bp_init_freq_invariance(bool cppc_ready)
+static void freq_invariance_enable(void)
+{
+	if (static_branch_unlikely(&arch_scale_freq_key)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
+	static_branch_enable(&arch_scale_freq_key);
+	register_freq_invariance_syscore_ops();
+	pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
+}
+
+void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled)
 {
-	bool ret;
+	arch_turbo_freq_ratio = ratio;
+	arch_set_max_freq_ratio(turbo_disabled);
+	freq_invariance_enable();
+}
 
+void __init bp_init_freq_invariance(void)
+{
 	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
 		return;
 
 	init_counter_refs();
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
-		ret = intel_set_max_freq_ratio();
-	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		if (!cppc_ready)
-			return;
-		ret = amd_set_max_freq_ratio(&arch_turbo_freq_ratio);
-	}
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return;
 
-	if (ret) {
-		static_branch_enable(&arch_scale_freq_key);
-		register_freq_invariance_syscore_ops();
-		pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
-	} else {
-		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
-	}
+	if (intel_set_max_freq_ratio())
+		freq_invariance_enable();
 }
 
 void ap_init_freq_invariance(void)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 023feb4..b1ba7dd 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1396,7 +1396,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 {
 	smp_prepare_cpus_common();
 
-	bp_init_freq_invariance(false);
+	bp_init_freq_invariance();
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {
