Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346B0511AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbiD0OAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbiD0N71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:59:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A351FCDD;
        Wed, 27 Apr 2022 06:56:15 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:56:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651067774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pzG8cgssQnwRCyYxoRtgVhdpwIa1MVmzbrC5C66ibs=;
        b=wjPcgXhHkWjz+gB46UsNB0feEP3S711Q6hxCamqEtAaYvol8uTP4haXFdQZckxKH2L1XLP
        lVX4goyvt2YYoSq7J99Zv1ejp3qmRmbHUG7xtaT5I4zGL9qxbvPQIlsPCRpUiFTScIgT8c
        1MhHYrBlRlI1k8/AGGNcrG9vL+1SpQa5txpHLAYnF2BhvPoZ7rtAqenuajPn4J4+YpDEPf
        b5hwSRlQmyBgaoZ+SrIMr70eRGdBZWSv9yqYvnQwnZNTJebJKFZ6OnIRZky0ua5HdZ+mAd
        KvkDEVAXFUmVwmPx20JStSPePjHDtzxpBBKzCTh9chtKGbEj4FWBxtHQ6c/z5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651067774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pzG8cgssQnwRCyYxoRtgVhdpwIa1MVmzbrC5C66ibs=;
        b=a/VlehnNyRaWLkeiuypAJxPaQQs7d+hBSS2LuGXK0VY+9mMCztsP1kL7ANhm6VaPouwR99
        1vyQYdwJK4mUVlBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/aperfmperf: Separate AP/BP frequency invariance init
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415161206.536733494@linutronix.de>
References: <20220415161206.536733494@linutronix.de>
MIME-Version: 1.0
Message-ID: <165106777292.4207.1405426122813761201.tip-bot2@tip-bot2>
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

Commit-ID:     138a7f9c6beae8d652113b8e7a44994b4200bbcd
Gitweb:        https://git.kernel.org/tip/138a7f9c6beae8d652113b8e7a44994b4200bbcd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 21:19:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 15:51:08 +02:00

x86/aperfmperf: Separate AP/BP frequency invariance init

This code is convoluted and because it can be invoked post init via the
ACPI/CPPC code, all of the initialization functionality is built in instead
of being part of init text and init data.

As a first step create separate calls for the boot and the application
processors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20220415161206.536733494@linutronix.de

---
 arch/x86/include/asm/topology.h  | 12 +++++-------
 arch/x86/kernel/acpi/cppc.c      |  3 ++-
 arch/x86/kernel/cpu/aperfmperf.c | 23 +++++++++++------------
 arch/x86/kernel/smpboot.c        |  4 ++--
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 9619385..e2faedc 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -216,14 +216,12 @@ extern void arch_scale_freq_tick(void);
 #define arch_scale_freq_tick arch_scale_freq_tick
 
 extern void arch_set_max_freq_ratio(bool turbo_disabled);
-void init_freq_invariance(bool secondary, bool cppc_ready);
+extern void bp_init_freq_invariance(bool cppc_ready);
+extern void ap_init_freq_invariance(void);
 #else
-static inline void arch_set_max_freq_ratio(bool turbo_disabled)
-{
-}
-static inline void init_freq_invariance(bool secondary, bool cppc_ready)
-{
-}
+static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
+static inline void bp_init_freq_invariance(bool cppc_ready) { }
+static inline void ap_init_freq_invariance(void) { }
 #endif
 
 #ifdef CONFIG_ACPI_CPPC_LIB
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index df1644d..06109d9 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -96,7 +96,8 @@ void init_freq_invariance_cppc(void)
 
 	mutex_lock(&freq_invariance_lock);
 
-	init_freq_invariance(secondary, true);
+	if (!secondary)
+		bp_init_freq_invariance(true);
 	secondary = true;
 
 	mutex_unlock(&freq_invariance_lock);
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 35fff01..87f34f2 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -428,31 +428,24 @@ static void register_freq_invariance_syscore_ops(void)
 static inline void register_freq_invariance_syscore_ops(void) {}
 #endif
 
-void init_freq_invariance(bool secondary, bool cppc_ready)
+void bp_init_freq_invariance(bool cppc_ready)
 {
-	bool ret = false;
+	bool ret;
 
-	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
+	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
 		return;
 
-	if (secondary) {
-		if (static_branch_likely(&arch_scale_freq_key)) {
-			init_counter_refs();
-		}
-		return;
-	}
+	init_counter_refs();
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		ret = intel_set_max_freq_ratio();
 	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		if (!cppc_ready) {
+		if (!cppc_ready)
 			return;
-		}
 		ret = amd_set_max_freq_ratio(&arch_turbo_freq_ratio);
 	}
 
 	if (ret) {
-		init_counter_refs();
 		static_branch_enable(&arch_scale_freq_key);
 		register_freq_invariance_syscore_ops();
 		pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
@@ -461,6 +454,12 @@ void init_freq_invariance(bool secondary, bool cppc_ready)
 	}
 }
 
+void ap_init_freq_invariance(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_APERFMPERF))
+		init_counter_refs();
+}
+
 static void disable_freq_invariance_workfn(struct work_struct *work)
 {
 	static_branch_disable(&arch_scale_freq_key);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a9fc16a..023feb4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -186,7 +186,7 @@ static void smp_callin(void)
 	 */
 	set_cpu_sibling_map(raw_smp_processor_id());
 
-	init_freq_invariance(true, false);
+	ap_init_freq_invariance();
 
 	/*
 	 * Get our bogomips.
@@ -1396,7 +1396,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 {
 	smp_prepare_cpus_common();
 
-	init_freq_invariance(false, false);
+	bp_init_freq_invariance(false);
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {
