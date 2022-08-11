Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB54158F5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiHKCtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiHKCtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:49:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6431788DE9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660186148; x=1691722148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+aqelz7R2UObYo7+m0nAdTqLPIvz8yx3xgG4c//Qfbk=;
  b=N7GWXBA179vGPaDKylrXB7lXfZxZ5cDHfRgW//QY4OOFZjGQCs3Dzwlv
   Ig9s+J9ouzUJzXFz4XKWCyBg/eDxNj24Yx25fHMPPQ123zY0mgVJeX1wA
   cyUNv4mfkKisxiV3SKZGeKY3hjxP/Y5KIyrUcPFy2/mt6AfqsGbyEmVOD
   aVjqbVHf/fSlGlFgKeqOkVNmemFdJKDqnYtK9wISPg+QCNvkawfP2YZbn
   bqCnrjN1OsssLhtEnYo1kj+6/ItW42kxZ4H6Ipk8KO4VR4DgVTDF0Q8qD
   dU6tRuvkV+7hlc+15o5A5YekwvKQINPqmydIkgii0+XMC8RllsBfVqeSb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="352981561"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="352981561"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 19:49:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="638336677"
Received: from zjoseph-mobl3.amr.corp.intel.com (HELO localhost) ([10.209.123.207])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 19:49:07 -0700
From:   ira.weiny@intel.com
To:     Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] x86/entry: Add auxiliary pt_regs space
Date:   Wed, 10 Aug 2022 19:49:02 -0700
Message-Id: <20220811024903.178925-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220811024903.178925-1-ira.weiny@intel.com>
References: <20220811024903.178925-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Rik van Riel reports that knowledge of where a fault hits is valuable in
detecting CPU failures in large data centers.[0]  Having auxiliary
pt_regs space is a useful place to store the CPU and avoids passing
additional data through the exception call stacks.

Two possible places for preserving this state were originally
considered, irqentry_state_t or pt_regs.[1]  pt_regs was much more
complicated and was potentially fraught with unintended consequences.[2]
However, Andy Lutomirski came up with a way to hide additional values on
the stack which could be accessed as "extended_pt_regs".[3] This method
allows any function with current access to pt_regs to obtain access to
the extra information without expanding the use of irqentry_state_t and
leaving pt_regs intact for compatibility with outside tools like BPF.

Prepare the assembly code to add a hidden auxiliary pt_regs space.  To
simplify, the assembly code only adds space on the stack as defined by
the C code which needs it.  The use of this space is left to the C code
which is required to select ARCH_HAS_PTREGS_AUXILIARY to enable this
support.

Each nested exception gets another copy of this auxiliary space allowing
for any number of levels of exception handling.

Initially the space is left empty and results in no code changes because
ARCH_HAS_PTREGS_AUXILIARY is not set.  Subsequent patches adding data to
pt_regs_auxiliary must set ARCH_HAS_PTREGS_AUXILIARY or a build failure
will occur.  The use of ARCH_HAS_PTREGS_AUXILIARY also avoids the
introduction of 2 instructions (addq/subq) on every entry call when the
extra space is not needed.

32bit is specifically excluded.

Peter, Thomas, Andy, Dave, and Dan all suggested parts of the patch or
aided in the development of the patch..

[0] https://lore.kernel.org/all/20220805101644.2e674553@imladris.surriel.com/
[1] https://lore.kernel.org/lkml/CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com/
[2] https://lore.kernel.org/lkml/874kpxx4jf.fsf@nanos.tec.linutronix.de/#t
[3] https://lore.kernel.org/lkml/CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com/

Cc: Rik van Riel <riel@surriel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Forward port from PKS series
	https://lore.kernel.org/lkml/20220419170649.1022246-18-ira.weiny@intel.com/
---
 arch/x86/Kconfig                 |  4 ++++
 arch/x86/entry/calling.h         | 19 +++++++++++++++++++
 arch/x86/entry/entry_64.S        | 22 ++++++++++++++++++++++
 arch/x86/entry/entry_64_compat.S |  6 ++++++
 arch/x86/include/asm/ptrace.h    | 18 ++++++++++++++++++
 arch/x86/kernel/asm-offsets_64.c | 15 +++++++++++++++
 arch/x86/kernel/head_64.S        |  6 ++++++
 7 files changed, 90 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..5a0b6ee49cb4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1872,6 +1872,10 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 
 	  If unsure, say y.
 
+config ARCH_HAS_PTREGS_AUXILIARY
+	depends on X86_64
+	bool
+
 choice
 	prompt "TSX enable mode"
 	depends on CPU_SUP_INTEL
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index f6907627172b..b7515f8b0092 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -65,6 +65,25 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
+#ifdef CONFIG_ARCH_HAS_PTREGS_AUXILIARY
+
+.macro PUSH_PTREGS_AUXILIARY
+	/* add space for pt_regs_auxiliary */
+	subq $PTREGS_AUX_SIZE, %rsp
+.endm
+
+.macro POP_PTREGS_AUXILIARY
+	/* remove space for pt_regs_auxiliary */
+	addq $PTREGS_AUX_SIZE, %rsp
+.endm
+
+#else
+
+#define PUSH_PTREGS_AUXILIARY
+#define POP_PTREGS_AUXILIARY
+
+#endif
+
 .macro PUSH_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9953d966d124..4f9f7f5cb563 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -362,7 +362,9 @@ SYM_CODE_END(xen_error_entry)
 		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	.endif
 
+	PUSH_PTREGS_AUXILIARY
 	call	\cfunc
+	POP_PTREGS_AUXILIARY
 
 	/* For some configurations \cfunc ends up being a noreturn. */
 	REACHABLE
@@ -472,7 +474,9 @@ SYM_CODE_START(\asmsym)
 
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
+	PUSH_PTREGS_AUXILIARY
 	call	\cfunc
+	POP_PTREGS_AUXILIARY
 
 	jmp	paranoid_exit
 
@@ -535,7 +539,9 @@ SYM_CODE_START(\asmsym)
 	 * stack.
 	 */
 	movq	%rsp, %rdi		/* pt_regs pointer */
+	PUSH_PTREGS_AUXILIARY
 	call	vc_switch_off_ist
+	POP_PTREGS_AUXILIARY
 	movq	%rax, %rsp		/* Switch to new stack */
 
 	ENCODE_FRAME_POINTER
@@ -547,7 +553,9 @@ SYM_CODE_START(\asmsym)
 
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
+	PUSH_PTREGS_AUXILIARY
 	call	kernel_\cfunc
+	POP_PTREGS_AUXILIARY
 
 	/*
 	 * No need to switch back to the IST stack. The current stack is either
@@ -584,7 +592,9 @@ SYM_CODE_START(\asmsym)
 	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
 	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
+	PUSH_PTREGS_AUXILIARY
 	call	\cfunc
+	POP_PTREGS_AUXILIARY
 
 	/* For some configurations \cfunc ends up being a noreturn. */
 	REACHABLE
@@ -838,7 +848,9 @@ SYM_CODE_START_LOCAL(exc_xen_hypervisor_callback)
 	movq	%rdi, %rsp			/* we don't return, adjust the stack frame */
 	UNWIND_HINT_REGS
 
+	PUSH_PTREGS_AUXILIARY
 	call	xen_pv_evtchn_do_upcall
+	POP_PTREGS_AUXILIARY
 
 	jmp	error_return
 SYM_CODE_END(exc_xen_hypervisor_callback)
@@ -1062,7 +1074,9 @@ SYM_CODE_START_LOCAL(error_entry)
 .Lerror_entry_from_usermode_after_swapgs:
 
 	/* Put us onto the real thread stack. */
+	PUSH_PTREGS_AUXILIARY
 	call	sync_regs
+	POP_PTREGS_AUXILIARY
 	RET
 
 	/*
@@ -1119,7 +1133,9 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * as if we faulted immediately after IRET.
 	 */
 	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
+	PUSH_PTREGS_AUXILIARY
 	call	fixup_bad_iret
+	POP_PTREGS_AUXILIARY
 	mov	%rax, %rdi
 	jmp	.Lerror_entry_from_usermode_after_swapgs
 SYM_CODE_END(error_entry)
@@ -1229,7 +1245,9 @@ SYM_CODE_START(asm_exc_nmi)
 
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
+	PUSH_PTREGS_AUXILIARY
 	call	exc_nmi
+	POP_PTREGS_AUXILIARY
 
 	/*
 	 * Return back to user mode.  We must *not* do the normal exit
@@ -1265,6 +1283,8 @@ SYM_CODE_START(asm_exc_nmi)
 	 * +---------------------------------------------------------+
 	 * | pt_regs                                                 |
 	 * +---------------------------------------------------------+
+	 * | (Optionally) pt_regs_extended                           |
+	 * +---------------------------------------------------------+
 	 *
 	 * The "original" frame is used by hardware.  Before re-enabling
 	 * NMIs, we need to be done with it, and we need to leave enough
@@ -1443,7 +1463,9 @@ end_repeat_nmi:
 
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
+	PUSH_PTREGS_AUXILIARY
 	call	exc_nmi
+	POP_PTREGS_AUXILIARY
 
 	/* Always restore stashed SPEC_CTRL value (see paranoid_entry) */
 	IBRS_EXIT save_reg=%r15
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 682338e7e2a3..7f1e670f7b06 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -117,7 +117,9 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 .Lsysenter_flags_fixed:
 
 	movq	%rsp, %rdi
+	PUSH_PTREGS_AUXILIARY
 	call	do_SYSENTER_32
+	POP_PTREGS_AUXILIARY
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
@@ -212,7 +214,9 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	UNTRAIN_RET
 
 	movq	%rsp, %rdi
+	PUSH_PTREGS_AUXILIARY
 	call	do_fast_syscall_32
+	POP_PTREGS_AUXILIARY
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
@@ -351,6 +355,8 @@ SYM_CODE_START(entry_INT80_compat)
 	UNTRAIN_RET
 
 	movq	%rsp, %rdi
+	PUSH_PTREGS_AUXILIARY
 	call	do_int80_syscall_32
+	POP_PTREGS_AUXILIARY
 	jmp	swapgs_restore_regs_and_return_to_usermode
 SYM_CODE_END(entry_INT80_compat)
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index f4db78b09c8f..5a9c85893459 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_PTRACE_H
 #define _ASM_X86_PTRACE_H
 
+#include <linux/container_of.h>
 #include <asm/segment.h>
 #include <asm/page_types.h>
 #include <uapi/asm/ptrace.h>
@@ -91,6 +92,23 @@ struct pt_regs {
 /* top of stack page */
 };
 
+/*
+ * NOTE: Features which add data to pt_regs_auxiliary must select
+ * ARCH_HAS_PTREGS_AUXILIARY.  Failure to do so will result in a build failure.
+ */
+struct pt_regs_auxiliary {
+};
+
+struct pt_regs_extended {
+	struct pt_regs_auxiliary aux;
+	struct pt_regs pt_regs __aligned(8);
+};
+
+static inline struct pt_regs_extended *to_extended_pt_regs(struct pt_regs *regs)
+{
+	return container_of(regs, struct pt_regs_extended, pt_regs);
+}
+
 #endif /* !__i386__ */
 
 #ifdef CONFIG_PARAVIRT
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 9b698215d261..413fe632445b 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -4,6 +4,7 @@
 #endif
 
 #include <asm/ia32.h>
+#include <asm/ptrace.h>
 
 #if defined(CONFIG_KVM_GUEST)
 #include <asm/kvm_para.h>
@@ -60,5 +61,19 @@ int main(void)
 	DEFINE(stack_canary_offset, offsetof(struct fixed_percpu_data, stack_canary));
 	BLANK();
 #endif
+
+#ifdef CONFIG_ARCH_HAS_PTREGS_AUXILIARY
+	/* Size of Auxiliary pt_regs data */
+	DEFINE(PTREGS_AUX_SIZE, sizeof(struct pt_regs_extended) -
+				sizeof(struct pt_regs));
+#else
+	/*
+	 * Adding data to struct pt_regs_auxiliary requires setting
+	 * ARCH_HAS_PTREGS_AUXILIARY
+	 */
+	BUILD_BUG_ON((sizeof(struct pt_regs_extended) -
+		      sizeof(struct pt_regs)) != 0);
+#endif
+
 	return 0;
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d860d437631b..3a41273acb1c 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -398,8 +398,10 @@ SYM_CODE_START_NOALIGN(vc_boot_ghcb)
 	movq    %rsp, %rdi
 	movq	ORIG_RAX(%rsp), %rsi
 	movq	initial_vc_handler(%rip), %rax
+	PUSH_PTREGS_AUXILIARY
 	ANNOTATE_RETPOLINE_SAFE
 	call	*%rax
+	POP_PTREGS_AUXILIARY
 
 	/* Unwind pt_regs */
 	POP_REGS
@@ -479,7 +481,9 @@ SYM_CODE_START_LOCAL(early_idt_handler_common)
 	UNWIND_HINT_REGS
 
 	movq %rsp,%rdi		/* RDI = pt_regs; RSI is already trapnr */
+	PUSH_PTREGS_AUXILIARY
 	call do_early_exception
+	POP_PTREGS_AUXILIARY
 
 	decl early_recursion_flag(%rip)
 	jmp restore_regs_and_return_to_kernel
@@ -508,7 +512,9 @@ SYM_CODE_START_NOALIGN(vc_no_ghcb)
 	/* Call C handler */
 	movq    %rsp, %rdi
 	movq	ORIG_RAX(%rsp), %rsi
+	PUSH_PTREGS_AUXILIARY
 	call    do_vc_no_ghcb
+	POP_PTREGS_AUXILIARY
 
 	/* Unwind pt_regs */
 	POP_REGS
-- 
2.35.3

