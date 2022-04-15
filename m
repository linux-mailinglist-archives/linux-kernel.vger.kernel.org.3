Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94CA502F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349218AbiDOTWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348785AbiDOTW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:22:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29E63467D;
        Fri, 15 Apr 2022 12:19:56 -0700 (PDT)
Message-ID: <20220415161206.592465719@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650050395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Vbg+gQ8Rxj+zh2dlsK2MvI2YGFj6irjpOgNZhjAS9Pk=;
        b=3mdSgZHopcXMcpNGI/NA35kkALwjF6jDUs3UKfpeT28exkDTndSlutzy0vO+pJem7DD/SN
        CO5jWLT2/u2BW0hq/d5Xd2tYRAlpNe5ca8E1Klar2QRVHLl/Z8CDh1JMPwZHXkrkTozcJ9
        nLuu/D5xU7eBX0o4iyv35D5RDOuK6F7TdFQ7gCRoAuX2shLc9EH+vj1SkjNwrAQBUT3XOl
        cG6PP/VPvKtGHqoRRfaL7wodtnx+hXeAQRE9AZ1MZ62/UmPTyEKB74+KJ0FCR+MgW59Tt1
        t+tqDoI8IvAapl2ufvs/qsQiypV6o/SftpsFzrtBwmPuNJc9E3Rld90L2pCLEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650050395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Vbg+gQ8Rxj+zh2dlsK2MvI2YGFj6irjpOgNZhjAS9Pk=;
        b=p7jYvFKMWytjpvilv77Uf1pDvLUcr3aa1hwkMa1myMH0veXK0lYXC9hgUh9C71VOTiDMU1
        cjUWWTcFqRdgIFBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 04/10] x86/aperfmperf: Untangle Intel and AMD frequency
 invariance init
References: <20220415133356.179706384@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Apr 2022 21:19:54 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD boot CPU initialization happens late via ACPI/CPPC which prevents the
Intel parts from being marked __init.

Split out the common code and provide a dedicated interface for the AMD
initialization and mark the Intel specific code and data __init.

The remaining text size is almost cut in half:

  text:		2614	->	1350
  init.text:	   0	->	 786

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/topology.h  |   13 ++------
 arch/x86/kernel/acpi/cppc.c      |   29 +++++++-----------
 arch/x86/kernel/cpu/aperfmperf.c |   62 ++++++++++++++++++++-------------------
 arch/x86/kernel/smpboot.c        |    2 -
 4 files changed, 49 insertions(+), 57 deletions(-)

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
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -50,20 +50,17 @@ int cpc_write_ffh(int cpunum, struct cpc
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
@@ -79,26 +76,24 @@ bool amd_set_max_freq_ratio(u64 *ratio)
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
-
-	if (!secondary)
-		bp_init_freq_invariance(true);
-	secondary = true;
+	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
+		return;
 
+	mutex_lock(&freq_invariance_lock);
+	if (!init_done)
+		amd_set_max_freq_ratio();
+	init_done = true;
 	mutex_unlock(&freq_invariance_lock);
 }
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -206,7 +206,7 @@ void arch_set_max_freq_ratio(bool turbo_
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
 
@@ -240,26 +240,26 @@ static bool slv_set_max_freq_ratio(u64 *
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
@@ -297,7 +297,7 @@ static bool knl_set_max_freq_ratio(u64 *
 	return true;
 }
 
-static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
+static bool __init skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
 {
 	u64 ratios, counts;
 	u32 group_size;
@@ -328,7 +328,7 @@ static bool skx_set_max_freq_ratio(u64 *
 	return false;
 }
 
-static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
+static bool __init core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 {
 	u64 msr;
 	int err;
@@ -351,7 +351,7 @@ static bool core_set_max_freq_ratio(u64
 	return true;
 }
 
-static bool intel_set_max_freq_ratio(void)
+static bool __init intel_set_max_freq_ratio(void)
 {
 	u64 base_freq, turbo_freq;
 	u64 turbo_ratio;
@@ -418,40 +418,42 @@ static struct syscore_ops freq_invarianc
 
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
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1396,7 +1396,7 @@ void __init native_smp_prepare_cpus(unsi
 {
 	smp_prepare_cpus_common();
 
-	bp_init_freq_invariance(false);
+	bp_init_freq_invariance();
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {

