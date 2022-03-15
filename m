Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19084D993E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiCOKrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347330AbiCOKpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0092B36B7B;
        Tue, 15 Mar 2022 03:44:00 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inn5j/wGS8P6T/Y6OG+U1fQtNbLD4q1w/7e6qe6qkMI=;
        b=HkHPh8FJ39RPxAiP9DYnK+3Tx/CubGkSlWkLaTL8jiNdKeTF2e/PeK7PhElCvC/AXTUJFA
        F5eyQJPON6SXArjLQneKTXyteV+cL7uFQ2z9hArjL9LmmTHl0cHJBz5fTDs3Bht2u/teIh
        1Lfp7jnvTaZRUTuE8a7R0wBjZ7/7Ah5cwqijzHxfXtrbbuszrq6I0wCH3Ut9lge7qvz3uJ
        70gfMdhAUELgoov2X+BpzWd+DpNhUuQwJKL11ft8/NDDtisosf0onIT7erVqij/+DEYIg9
        Y1Zx0FLlacS8CSpqqWTnHWt8Tte/wj6Z/OmKRoix27m8KdnVooEFy/tHte8aDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inn5j/wGS8P6T/Y6OG+U1fQtNbLD4q1w/7e6qe6qkMI=;
        b=ARiteRhMlehXgfCs0PpZymx6fNp0kefMlA/UD1ZdIpueTAOmCJ0fWmu/5vflz6NogGjUgz
        hWyfHDNoKuwX8iAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Add IBT feature, MSR and #CP handling
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.582331711@infradead.org>
References: <20220308154318.582331711@infradead.org>
MIME-Version: 1.0
Message-ID: <164734103846.16921.12424565428024318512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     991625f3dd2cbc4b787deb0213e2bcf8fa264b21
Gitweb:        https://git.kernel.org/tip/991625f3dd2cbc4b787deb0213e2bcf8fa264b21
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:39 +01:00

x86/ibt: Add IBT feature, MSR and #CP handling

The bits required to make the hardware go.. Of note is that, provided
the syscall entry points are covered with ENDBR, #CP doesn't need to
be an IST because we'll never hit the syscall gap.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.582331711@infradead.org
---
 arch/x86/include/asm/cpu.h                  |  1 +-
 arch/x86/include/asm/cpufeatures.h          |  1 +-
 arch/x86/include/asm/idtentry.h             |  5 +-
 arch/x86/include/asm/msr-index.h            | 20 ++++-
 arch/x86/include/asm/traps.h                |  2 +-
 arch/x86/include/uapi/asm/processor-flags.h |  2 +-
 arch/x86/kernel/cpu/common.c                | 25 ++++++-
 arch/x86/kernel/idt.c                       |  4 +-
 arch/x86/kernel/traps.c                     | 75 ++++++++++++++++++++-
 9 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 33d41e3..a60025f 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -7,6 +7,7 @@
 #include <linux/topology.h>
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
+#include <asm/ibt.h>
 
 #ifdef CONFIG_SMP
 
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 65d1479..c5bda35 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -390,6 +390,7 @@
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
+#define X86_FEATURE_IBT			(18*32+20) /* Indirect Branch Tracking */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index f84280a..7924f27 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -617,6 +617,11 @@ DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);
 DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_DF,	xenpv_exc_double_fault);
 #endif
 
+/* #CP */
+#ifdef CONFIG_X86_KERNEL_IBT
+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP,	exc_control_protection);
+#endif
+
 /* #VC */
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 DECLARE_IDTENTRY_VC(X86_TRAP_VC,	exc_vmm_communication);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a4a39c3..65c3599 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -360,11 +360,29 @@
 #define MSR_ATOM_CORE_TURBO_RATIOS	0x0000066c
 #define MSR_ATOM_CORE_TURBO_VIDS	0x0000066d
 
-
 #define MSR_CORE_PERF_LIMIT_REASONS	0x00000690
 #define MSR_GFX_PERF_LIMIT_REASONS	0x000006B0
 #define MSR_RING_PERF_LIMIT_REASONS	0x000006B1
 
+/* Control-flow Enforcement Technology MSRs */
+#define MSR_IA32_U_CET			0x000006a0 /* user mode cet */
+#define MSR_IA32_S_CET			0x000006a2 /* kernel mode cet */
+#define CET_SHSTK_EN			BIT_ULL(0)
+#define CET_WRSS_EN			BIT_ULL(1)
+#define CET_ENDBR_EN			BIT_ULL(2)
+#define CET_LEG_IW_EN			BIT_ULL(3)
+#define CET_NO_TRACK_EN			BIT_ULL(4)
+#define CET_SUPPRESS_DISABLE		BIT_ULL(5)
+#define CET_RESERVED			(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))
+#define CET_SUPPRESS			BIT_ULL(10)
+#define CET_WAIT_ENDBR			BIT_ULL(11)
+
+#define MSR_IA32_PL0_SSP		0x000006a4 /* ring-0 shadow stack pointer */
+#define MSR_IA32_PL1_SSP		0x000006a5 /* ring-1 shadow stack pointer */
+#define MSR_IA32_PL2_SSP		0x000006a6 /* ring-2 shadow stack pointer */
+#define MSR_IA32_PL3_SSP		0x000006a7 /* ring-3 shadow stack pointer */
+#define MSR_IA32_INT_SSP_TAB		0x000006a8 /* exception shadow stack table */
+
 /* Hardware P state interface */
 #define MSR_PPERF			0x0000064e
 #define MSR_PERF_LIMIT_REASONS		0x0000064f
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 6221be7..35317c5 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -18,6 +18,8 @@ void __init trap_init(void);
 asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
 #endif
 
+extern bool ibt_selftest(void);
+
 #ifdef CONFIG_X86_F00F_BUG
 /* For handling the FOOF bug */
 void handle_invalid_op(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index bcba3c6..c47cc7f 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -130,6 +130,8 @@
 #define X86_CR4_SMAP		_BITUL(X86_CR4_SMAP_BIT)
 #define X86_CR4_PKE_BIT		22 /* enable Protection Keys support */
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
+#define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement Technology */
+#define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7b8382c..db1f149 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -59,6 +59,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
 #include <asm/sigframe.h>
+#include <asm/traps.h>
 
 #include "cpu.h"
 
@@ -361,7 +362,8 @@ out:
 
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask =
-	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP | X86_CR4_FSGSBASE;
+	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
+	X86_CR4_FSGSBASE | X86_CR4_CET;
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
 
@@ -515,6 +517,24 @@ static __init int setup_disable_pku(char *arg)
 __setup("nopku", setup_disable_pku);
 #endif /* CONFIG_X86_64 */
 
+static __always_inline void setup_cet(struct cpuinfo_x86 *c)
+{
+	u64 msr = CET_ENDBR_EN;
+
+	if (!HAS_KERNEL_IBT ||
+	    !cpu_feature_enabled(X86_FEATURE_IBT))
+		return;
+
+	wrmsrl(MSR_IA32_S_CET, msr);
+	cr4_set_bits(X86_CR4_CET);
+
+	if (!ibt_selftest()) {
+		pr_err("IBT selftest: Failed!\n");
+		setup_clear_cpu_cap(X86_FEATURE_IBT);
+		return;
+	}
+}
+
 /*
  * Some CPU features depend on higher CPUID levels, which may not always
  * be available due to CPUID level capping or broken virtualization
@@ -1632,6 +1652,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	x86_init_rdrand(c);
 	setup_pku(c);
+	setup_cet(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, need do it
@@ -1698,6 +1719,8 @@ void enable_sep_cpu(void)
 void __init identify_boot_cpu(void)
 {
 	identify_cpu(&boot_cpu_data);
+	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
+		pr_info("CET detected: Indirect Branch Tracking enabled\n");
 #ifdef CONFIG_X86_32
 	sysenter_setup();
 	enable_sep_cpu();
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 7676e34..608eb63 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -104,6 +104,10 @@ static const __initconst struct idt_data def_idts[] = {
 	ISTG(X86_TRAP_MC,		asm_exc_machine_check, IST_INDEX_MCE),
 #endif
 
+#ifdef CONFIG_X86_KERNEL_IBT
+	INTG(X86_TRAP_CP,		asm_exc_control_protection),
+#endif
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	ISTG(X86_TRAP_VC,		asm_exc_vmm_communication, IST_INDEX_VC),
 #endif
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 8143693..c073cb5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -209,6 +209,81 @@ DEFINE_IDTENTRY(exc_overflow)
 	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
 }
 
+#ifdef CONFIG_X86_KERNEL_IBT
+
+static __ro_after_init bool ibt_fatal = true;
+
+extern void ibt_selftest_ip(void); /* code label defined in asm below */
+
+enum cp_error_code {
+	CP_EC        = (1 << 15) - 1,
+
+	CP_RET       = 1,
+	CP_IRET      = 2,
+	CP_ENDBR     = 3,
+	CP_RSTRORSSP = 4,
+	CP_SETSSBSY  = 5,
+
+	CP_ENCL	     = 1 << 15,
+};
+
+DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
+		pr_err("Unexpected #CP\n");
+		BUG();
+	}
+
+	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
+		return;
+
+	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
+		regs->ax = 0;
+		return;
+	}
+
+	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
+	if (!ibt_fatal) {
+		printk(KERN_DEFAULT CUT_HERE);
+		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
+		return;
+	}
+	BUG();
+}
+
+/* Must be noinline to ensure uniqueness of ibt_selftest_ip. */
+noinline bool ibt_selftest(void)
+{
+	unsigned long ret;
+
+	asm ("	lea ibt_selftest_ip(%%rip), %%rax\n\t"
+	     ANNOTATE_RETPOLINE_SAFE
+	     "	jmp *%%rax\n\t"
+	     "ibt_selftest_ip:\n\t"
+	     UNWIND_HINT_FUNC
+	     ANNOTATE_NOENDBR
+	     "	nop\n\t"
+
+	     : "=a" (ret) : : "memory");
+
+	return !ret;
+}
+
+static int __init ibt_setup(char *str)
+{
+	if (!strcmp(str, "off"))
+		setup_clear_cpu_cap(X86_FEATURE_IBT);
+
+	if (!strcmp(str, "warn"))
+		ibt_fatal = false;
+
+	return 1;
+}
+
+__setup("ibt=", ibt_setup);
+
+#endif /* CONFIG_X86_KERNEL_IBT */
+
 #ifdef CONFIG_X86_F00F_BUG
 void handle_invalid_op(struct pt_regs *regs)
 #else
