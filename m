Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161005788D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiGRRwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiGRRwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:52:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA7D2D1D0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:52:12 -0700 (PDT)
Message-ID: <20220718173923.951305696@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658166731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KrrFulS1b+TRk+Ir+OgNMh3CyYA86JKp9Z084M+JkBQ=;
        b=zi2nidXUDEzobjRZcbJT0RFqPgEoTGbEfLVtFMnXRGBT+3qt4kBQhSEEEDmzeA/kg/AmLg
        HNb+rrgYrJzBhPD9PAPv+Rz0jUTCr4BQm0nLbZSpgUL/hEhJAsfB4ISTwq2bJ0PJ8mQBhm
        rvz8eoclb/OvyIKh9UzCoEFyrN6xA0nenWKP/EPBX/fK+gSxp1QnFjZQEmpno74zhvSLqe
        UwCPQxt+q5jYmog7EO2wTSBracfFoBetC5OwA4BBUzRFcwAHiP/RCghO8msODr+1VzfH9A
        dmq85fZP05BNu9BxVz6V7Lyj3K+Lv8UE2bUdn8nkHHiTyOvP3uYuEsDP6rJ58A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658166731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KrrFulS1b+TRk+Ir+OgNMh3CyYA86JKp9Z084M+JkBQ=;
        b=yYGiepyyxCJiWuj3M7Gexb9o05hj5kTDaiTxAH/FVcvxOiopFgzGEqN1wNpEx72CsqJKZS
        b+4WtYrXpLoye0AQ==
2Message-ID: <20220718173814.731702240@linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch 2/3] x86/cpu: Get rid of redundant switch_to_new_gdt() invocations
References: <20220716230952.787452088@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 18 Jul 2022 19:52:11 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only place where switch_to_new_gdt() is required is early boot to
switch from the early GDT to the direct GDT. Any other invocation is
completely redundant because it does not change anything.

Secondary CPUs come out of the ASM code with GDT and GSBASE correctly set
up. The same is true for XEN_PV.

Remove all the voodoo invocations which are left overs from the ancient
past, rename the function to switch_to_direct_gdt() and mark it init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    2 +-
 arch/x86/kernel/cpu/common.c     |   14 ++------------
 arch/x86/kernel/setup_percpu.c   |    2 +-
 arch/x86/kernel/smpboot.c        |    6 +++++-
 arch/x86/xen/enlighten_pv.c      |    2 +-
 5 files changed, 10 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -670,7 +670,7 @@ extern int sysenter_setup(void);
 /* Defined in head.S */
 extern struct desc_ptr		early_gdt_descr;
 
-extern void switch_to_new_gdt(int);
+extern void switch_to_direct_gdt(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void cpu_init(void);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -729,14 +729,14 @@ void load_fixmap_gdt(int cpu)
 EXPORT_SYMBOL_GPL(load_fixmap_gdt);
 
 /**
- * switch_to_new_gdt - Switch form early GDT to the direct one
+ * switch_to_direct_gdt - Switch form early GDT to the direct one
  * @cpu:	The CPU number for which this is invoked
  *
  * Invoked during early boot to switch from early GDT and early per CPU
  * (%fs on 32bit, GS_BASE on 64bit) to the direct GDT and the runtime per
  * CPU area.
  */
-void switch_to_new_gdt(int cpu)
+void __init switch_to_direct_gdt(int cpu)
 {
 	load_direct_gdt(cpu);
 
@@ -751,10 +751,6 @@ void switch_to_new_gdt(int cpu)
 	 * wrmsrl() happens the early mapping is still valid. That means
 	 * the GSBASE update will lose any prior per CPU data which was
 	 * not copied over in setup_per_cpu_areas().
-	 *
-	 * For secondary CPUs this is not a problem because they start
-	 * already with the direct GDT and the real GSBASE. This invocation
-	 * is pointless and will be removed in a subsequent step.
 	 */
 	if (IS_ENABLED(CONFIG_X86_64))
 		wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
@@ -2238,12 +2234,6 @@ void cpu_init(void)
 	    boot_cpu_has(X86_FEATURE_TSC) || boot_cpu_has(X86_FEATURE_DE))
 		cr4_clear_bits(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
 
-	/*
-	 * Initialize the per-CPU GDT with the boot GDT,
-	 * and set up the GDT descriptor:
-	 */
-	switch_to_new_gdt(cpu);
-
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		loadsegment(fs, 0);
 		memset(cur->thread.tls_array, 0, GDT_ENTRY_TLS_ENTRIES * 8);
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -211,7 +211,7 @@ void __init setup_per_cpu_areas(void)
 		 * area.  Reload any changed state for the boot CPU.
 		 */
 		if (!cpu)
-			switch_to_new_gdt(cpu);
+			switch_to_direct_gdt(cpu);
 	}
 
 	/* indicate the early static arrays will soon be gone */
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1457,7 +1457,11 @@ void arch_thaw_secondary_cpus_end(void)
 void __init native_smp_prepare_boot_cpu(void)
 {
 	int me = smp_processor_id();
-	switch_to_new_gdt(me);
+
+	/* SMP invokes this from setup_per_cpu_areas() */
+	if (!IS_ENABLED(CONFIG_SMP))
+		switch_to_direct_gdt(me);
+
 	/* already set me in cpu_online_mask in boot_cpu_init() */
 	cpumask_set_cpu(me, cpu_callout_mask);
 	cpu_set_state_online(me);
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1164,7 +1164,7 @@ static void __init xen_setup_gdt(int cpu
 	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry_boot;
 	pv_ops.cpu.load_gdt = xen_load_gdt_boot;
 
-	switch_to_new_gdt(cpu);
+	switch_to_direct_gdt(cpu);
 
 	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry;
 	pv_ops.cpu.load_gdt = xen_load_gdt;

