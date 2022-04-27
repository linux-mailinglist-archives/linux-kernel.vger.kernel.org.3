Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5875119DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbiD0OAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbiD0N70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:59:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5326326565;
        Wed, 27 Apr 2022 06:56:11 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:56:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651067769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lWSATtf4XR2XEXlO9pT8fbND/GnVorKDu+mvaG+NxmI=;
        b=k6yDOqeqNF7daatFm5JYtk2oW5EpO4M1kcnY3DMUefgRlXEKn/51whZKdk9HbL7hV04VNC
        37E7P2wNoNaiWf5xSZAmdsv5HcEPjkx5i/STJOCbE1GJhvgdklsjX//fTyCnuaHbSCOUXr
        95iowxfATebcb6ximVndguv+n/vLq+wdH1CoHtbbJjY+/HGtvyvgB4ZEL17cQD8CaTkEKu
        5rMIyUP567rNKHPySZYlcOZLg7BnFE+spaMEpauS2nc88DSXoElrWs0Bt2gZwhvr67aQsv
        DoRAbwi/JQQtPiIf6H1LTedf0glAb2dopvJlKW6onacfSelIYkW/7ySvKlyE+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651067769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lWSATtf4XR2XEXlO9pT8fbND/GnVorKDu+mvaG+NxmI=;
        b=xW54HRYIkfG2qXxQcp+eQ8KBWg2V7BEzQb56oFGpgzwu2w3dmsy2TATe9zGD0II0y2i7cF
        BjDD7+oq+O5XSfCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/aperfmperf: Make parts of the frequency
 invariance code unconditional
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415161206.761988704@linutronix.de>
References: <20220415161206.761988704@linutronix.de>
MIME-Version: 1.0
Message-ID: <165106776872.4207.2659429760577662368.tip-bot2@tip-bot2>
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

Commit-ID:     93989bbee7b21fa779ab22343b0463d395d020fd
Gitweb:        https://git.kernel.org/tip/93989bbee7b21fa779ab22343b0463d395d020fd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 21:19:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 15:51:08 +02:00

x86/aperfmperf: Make parts of the frequency invariance code unconditional

The frequency invariance support is currently limited to x86/64 and SMP,
which is the vast majority of machines.

arch_scale_freq_tick() is called every tick on all CPUs and reads the APERF
and MPERF MSRs. The CPU frequency getters function do the same via dedicated
IPIs.

While it could be argued that on systems where frequency invariance support
is disabled (32bit, !SMP) the per tick read of the APERF and MPERF MSRs can
be avoided, it does not make sense to keep the extra code and the resulting
runtime issues of mass IPIs around.

As a first step split out the non frequency invariance specific
initialization code and the read MSR portion of arch_scale_freq_tick(). The
rest of the code is still conditional and guarded with a static key.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20220415161206.761988704@linutronix.de

---
 arch/x86/include/asm/cpu.h       |  2 +-
 arch/x86/include/asm/topology.h  |  4 +--
 arch/x86/kernel/cpu/aperfmperf.c | 63 ++++++++++++++++++-------------
 arch/x86/kernel/smpboot.c        |  3 +-
 4 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 86e5e4e..e89772d 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -36,6 +36,8 @@ extern int _debug_hotplug_cpu(int cpu, int action);
 #endif
 #endif
 
+extern void ap_init_aperfmperf(void);
+
 int mwait_usable(const struct cpuinfo_x86 *);
 
 unsigned int x86_family(unsigned int sig);
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index cc31707..1b2553d 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -217,13 +217,9 @@ extern void arch_scale_freq_tick(void);
 
 extern void arch_set_max_freq_ratio(bool turbo_disabled);
 extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
-extern void bp_init_freq_invariance(void);
-extern void ap_init_freq_invariance(void);
 #else
 static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
 static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
-static inline void bp_init_freq_invariance(void) { }
-static inline void ap_init_freq_invariance(void) { }
 #endif
 
 #ifdef CONFIG_ACPI_CPPC_LIB
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 6220503..df528a4 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -17,6 +17,7 @@
 #include <linux/smp.h>
 #include <linux/syscore_ops.h>
 
+#include <asm/cpu.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
@@ -164,6 +165,17 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	return per_cpu(samples.khz, cpu);
 }
 
+static void init_counter_refs(void)
+{
+	u64 aperf, mperf;
+
+	rdmsrl(MSR_IA32_APERF, aperf);
+	rdmsrl(MSR_IA32_MPERF, mperf);
+
+	this_cpu_write(cpu_samples.aperf, aperf);
+	this_cpu_write(cpu_samples.mperf, mperf);
+}
+
 #if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
 /*
  * APERF/MPERF frequency ratio computation.
@@ -405,17 +417,6 @@ out:
 	return true;
 }
 
-static void init_counter_refs(void)
-{
-	u64 aperf, mperf;
-
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
-
-	this_cpu_write(cpu_samples.aperf, aperf);
-	this_cpu_write(cpu_samples.mperf, mperf);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static struct syscore_ops freq_invariance_syscore_ops = {
 	.resume = init_counter_refs,
@@ -447,13 +448,8 @@ void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled)
 	freq_invariance_enable();
 }
 
-void __init bp_init_freq_invariance(void)
+static void __init bp_init_freq_invariance(void)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
-		return;
-
-	init_counter_refs();
-
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return;
 
@@ -461,12 +457,6 @@ void __init bp_init_freq_invariance(void)
 		freq_invariance_enable();
 }
 
-void ap_init_freq_invariance(void)
-{
-	if (cpu_feature_enabled(X86_FEATURE_APERFMPERF))
-		init_counter_refs();
-}
-
 static void disable_freq_invariance_workfn(struct work_struct *work)
 {
 	static_branch_disable(&arch_scale_freq_key);
@@ -481,6 +471,9 @@ static void scale_freq_tick(u64 acnt, u64 mcnt)
 {
 	u64 freq_scale;
 
+	if (!arch_scale_freq_invariant())
+		return;
+
 	if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
 		goto error;
 
@@ -501,13 +494,17 @@ error:
 	pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
 	schedule_work(&disable_freq_invariance_work);
 }
+#else
+static inline void bp_init_freq_invariance(void) { }
+static inline void scale_freq_tick(u64 acnt, u64 mcnt) { }
+#endif /* CONFIG_X86_64 && CONFIG_SMP */
 
 void arch_scale_freq_tick(void)
 {
 	struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
 	u64 acnt, mcnt, aperf, mperf;
 
-	if (!arch_scale_freq_invariant())
+	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
 		return;
 
 	rdmsrl(MSR_IA32_APERF, aperf);
@@ -520,4 +517,20 @@ void arch_scale_freq_tick(void)
 
 	scale_freq_tick(acnt, mcnt);
 }
-#endif /* CONFIG_X86_64 && CONFIG_SMP */
+
+static int __init bp_init_aperfmperf(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
+		return 0;
+
+	init_counter_refs();
+	bp_init_freq_invariance();
+	return 0;
+}
+early_initcall(bp_init_aperfmperf);
+
+void ap_init_aperfmperf(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_APERFMPERF))
+		init_counter_refs();
+}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b1ba7dd..eb7de77 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -186,7 +186,7 @@ static void smp_callin(void)
 	 */
 	set_cpu_sibling_map(raw_smp_processor_id());
 
-	ap_init_freq_invariance();
+	ap_init_aperfmperf();
 
 	/*
 	 * Get our bogomips.
@@ -1396,7 +1396,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 {
 	smp_prepare_cpus_common();
 
-	bp_init_freq_invariance();
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {
