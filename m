Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4860502F38
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349384AbiDOTWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348799AbiDOTWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:22:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A648E77;
        Fri, 15 Apr 2022 12:19:54 -0700 (PDT)
Message-ID: <20220415161206.536733494@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650050393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ykE17w4lSXk/0eDFAm6MD4uH2sdqxkH5OoCX5fvgous=;
        b=PLfiZ9jXMCez8OUGdHF55LRBLjKU/RPxmbl89CDp+DYiQBqNWd1NRtosQ9MbmK3my7nfER
        tyEB2Cqkf86JeCDB1T1E4kOCl3lmIlj6G8h/UYfe9shl7zKMpG54K2L89Om2HrGPyN+oDk
        NXVL7BP6ifQYhFKdEX3wdVydy5HqJK+m7iagoVnbn4rlzuNl8fsfoEI4F4YLWYcMiGw3kW
        5sCgrdfP1pntlNinBzrBe6QSVmwq4PLuMnWnt2O6T8t7vOn+yUOcFxB5EHIM0qj7KRK9p4
        nrOdDyea1njMnwAhe3yRifeGtMKtliuZdd+o9HOimn8/jGZIJb2Y8Y4V1Sh+zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650050393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ykE17w4lSXk/0eDFAm6MD4uH2sdqxkH5OoCX5fvgous=;
        b=k+U1hmyNo7XL4KEqo1PlhF/QxCF51ampKFcw/N7IGHqhgtpSOpZPxe0zQ3Bi9aluQgsiqX
        nZjcMIjd/Hc69uDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 03/10] x86/aperfmperf: Separate AP/BP frequency invariance init
References: <20220415133356.179706384@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Apr 2022 21:19:53 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is convoluted and because it can be invoked post init via the
ACPI/CPPC code, all of the initialization functionality is built in instead
of being part of init text and init data.

As a first step create separate calls for the boot and the application
processors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/topology.h  |   12 +++++-------
 arch/x86/kernel/acpi/cppc.c      |    3 ++-
 arch/x86/kernel/cpu/aperfmperf.c |   23 +++++++++++------------
 arch/x86/kernel/smpboot.c        |    4 ++--
 4 files changed, 20 insertions(+), 22 deletions(-)

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
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -96,7 +96,8 @@ void init_freq_invariance_cppc(void)
 
 	mutex_lock(&freq_invariance_lock);
 
-	init_freq_invariance(secondary, true);
+	if (!secondary)
+		bp_init_freq_invariance(true);
 	secondary = true;
 
 	mutex_unlock(&freq_invariance_lock);
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -428,31 +428,24 @@ static void register_freq_invariance_sys
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
@@ -461,6 +454,12 @@ void init_freq_invariance(bool secondary
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
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -186,7 +186,7 @@ static void smp_callin(void)
 	 */
 	set_cpu_sibling_map(raw_smp_processor_id());
 
-	init_freq_invariance(true, false);
+	ap_init_freq_invariance();
 
 	/*
 	 * Get our bogomips.
@@ -1396,7 +1396,7 @@ void __init native_smp_prepare_cpus(unsi
 {
 	smp_prepare_cpus_common();
 
-	init_freq_invariance(false, false);
+	bp_init_freq_invariance(false);
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {

