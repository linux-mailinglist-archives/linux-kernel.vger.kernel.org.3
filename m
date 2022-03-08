Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6244D1C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbiCHP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348074AbiCHP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC14F9DC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VDw1qYyBlm4BTGn1wDiFtzqcWfJTM7hH6oR7HaQOnsk=; b=ECouK2xUhfeKp0mchuxU0c73aS
        /ns7XP6CoA0o2JdqGjZy0e1JKwOsmriLcNUEuOl2Mf+sVynuAp+u583hU7KFI86y+oggk5GjtAGyU
        W54zhSukLI/tjfsmYgwgkgXy7bLAjuOA0asW3l4g1O5GyIVq+g7goZOaR3jWl4DFuIzHKftoK7Ooz
        rCwwxMabzDe3ugWtyhE+tM40U4Kowk+Tly2hVlqws6B3P+rA9FJI1Yd82D5xo/E2pVcOJdPkeW4tv
        QtRZoq8q381xkvsMs6lR26dO0AWncbWQ1i1xcrx3O+5GBU93mCCRinVAKYOuWhbGrLJFAFBUJgydX
        NLATI35A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GUia-Q3; Tue, 08 Mar 2022 15:54:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41CB7302D47;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 61A362B56192D; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154318.582331711@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 24/45] x86/ibt: Add IBT feature, MSR and #CP handling
References: <20220308153011.021123062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bits required to make the hardware go.. Of note is that, provided
the syscall entry points are covered with ENDBR, #CP doesn't need to
be an IST because we'll never hit the syscall gap.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cpu.h                  |    1 
 arch/x86/include/asm/cpufeatures.h          |    1 
 arch/x86/include/asm/idtentry.h             |    5 +
 arch/x86/include/asm/msr-index.h            |   20 +++++++
 arch/x86/include/asm/traps.h                |    2 
 arch/x86/include/uapi/asm/processor-flags.h |    2 
 arch/x86/kernel/cpu/common.c                |   25 +++++++++
 arch/x86/kernel/idt.c                       |    4 +
 arch/x86/kernel/traps.c                     |   74 ++++++++++++++++++++++++++++
 9 files changed, 132 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -7,6 +7,7 @@
 #include <linux/topology.h>
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
+#include <asm/ibt.h>
 
 #ifdef CONFIG_SMP
 
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -387,6 +387,7 @@
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
+#define X86_FEATURE_IBT			(18*32+20) /* Indirect Branch Tracking */
 #define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
 #define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -617,6 +617,11 @@ DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_dou
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
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -362,11 +362,29 @@
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
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -59,6 +59,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
 #include <asm/sigframe.h>
+#include <asm/traps.h>
 
 #include "cpu.h"
 
@@ -438,7 +439,8 @@ static __always_inline void setup_umip(s
 
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask =
-	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP | X86_CR4_FSGSBASE;
+	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
+	X86_CR4_FSGSBASE | X86_CR4_CET;
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
 
@@ -592,6 +594,24 @@ static __init int setup_disable_pku(char
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
@@ -1709,6 +1729,7 @@ static void identify_cpu(struct cpuinfo_
 
 	x86_init_rdrand(c);
 	setup_pku(c);
+	setup_cet(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, need do it
@@ -1777,6 +1798,8 @@ void enable_sep_cpu(void)
 void __init identify_boot_cpu(void)
 {
 	identify_cpu(&boot_cpu_data);
+	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
+		pr_info("CET detected: Indirect Branch Tracking enabled\n");
 #ifdef CONFIG_X86_32
 	sysenter_setup();
 	enable_sep_cpu();
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -104,6 +104,10 @@ static const __initconst struct idt_data
 	ISTG(X86_TRAP_MC,		asm_exc_machine_check, IST_INDEX_MCE),
 #endif
 
+#ifdef CONFIG_X86_KERNEL_IBT
+	INTG(X86_TRAP_CP,		asm_exc_control_protection),
+#endif
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	ISTG(X86_TRAP_VC,		asm_exc_vmm_communication, IST_INDEX_VC),
 #endif
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -210,6 +210,80 @@ DEFINE_IDTENTRY(exc_overflow)
 	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
 }
 
+#ifdef CONFIG_X86_KERNEL_IBT
+
+static __ro_after_init bool ibt_fatal = true;
+
+void ibt_selftest_ip(void); /* code label defined in asm below */
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
+	if (unlikely(regs->ip == (unsigned long)ibt_selftest_ip)) {
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
+bool ibt_selftest(void)
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


