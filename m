Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745CB49E966
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiA0Rz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:19413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244600AbiA0RzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306116; x=1674842116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2zhhwydmVa+dY1Q4o9BnDwtd7Hf/BcCgIS1cAgT1A78=;
  b=eYhRv+GzEMxAZ7QZt9O/hEHcC0UM3Q4wfY6x1G+zR007JiBY0FYOFw5D
   WiIppzqZzJNHkf1sp0oKMf4fXd6EacUVLKVoCqLefxtyLi5A+we3WPHyZ
   dFyg6iKQM/nE5j38yGoL7qwMwj21MDVSVhGUuqZBJ+DMP5r7ZksOSjwxI
   sxLLbWdaob1HpgWsXA9DivWFw5mcHlzljLgkXOjbQeR6h+nzGeAjWzGko
   iXVi7f7HNjG2kT/EeM4VJMpamKNSWDZjUptPpxbVV3tN0b1SSu3OfOEdW
   NvA3HL8+SXxOORoPSoupB9+4Y++QrjCbHfr/wN8j057igvfyXzPnRJvon
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302433"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302433"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796120"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:10 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 21/44] x86/entry: Add auxiliary pt_regs space
Date:   Thu, 27 Jan 2022 09:54:42 -0800
Message-Id: <20220127175505.851391-22-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PKRS MSR is not managed by XSAVE.  In order for the MSR to be saved
during an exception the current CPU MSR value needs to be saved
somewhere during the exception and restored when returning to the
previous context.

Two possible places for preserving this state were considered,
irqentry_state_t or pt_regs.[1]  pt_regs was much more complicated and
was potentially fraught with unintended consequences.[2] However, Andy
came up with a way to hide additional values on the stack which could be
accessed as "extended_pt_regs".[3] This method allows any place which
has struct pt_regs to get access to the extra information with no extra
information being added to irq_state and pt_regs is left intact for
compatibility with outside tools like BPF.

Prepare the assembly code to add a hidden auxiliary pt_regs space.  To
simplify, the assembly code only adds space on the stack.  The use of
this space is left to the C code which is required to select
ARCH_HAS_PTREGS_AUXILIARY to enable this support.

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

[1] https://lore.kernel.org/lkml/CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com/
[2] https://lore.kernel.org/lkml/874kpxx4jf.fsf@nanos.tec.linutronix.de/#t
[3] https://lore.kernel.org/lkml/CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com/

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8:
	Exclude 32bit
	Introduce ARCH_HAS_PTREGS_AUXILIARY to optimize this away when
		not needed.
	From Thomas
		s/EXTENDED_PT_REGS_SIZE/PT_REGS_AUX_SIZE
		Fix up PTREGS_AUX_SIZE macro to be based on the
			structures and used in assembly code via the
			nifty asm-offset macros
		Bound calls into c code with [PUSH|POP]_RTREGS_AUXILIARY
			instead of using a macro 'call'
	Split this patch out and put the PKS specific stuff in a
		separate patch

Changes for V7:
	Rebased to 5.14 entry code
	declare write_pkrs() in pks.h
	s/INIT_PKRS_VALUE/pkrs_init_value
	Remove unnecessary INIT_PKRS_VALUE def
	s/pkrs_save_set_irq/pkrs_save_irq/
		The inital value for exceptions is best managed
		completely within the pkey code.
---
 arch/x86/Kconfig                 |  4 ++++
 arch/x86/entry/calling.h         | 20 ++++++++++++++++++++
 arch/x86/entry/entry_64.S        | 22 ++++++++++++++++++++++
 arch/x86/entry/entry_64_compat.S |  6 ++++++
 arch/x86/include/asm/ptrace.h    | 19 +++++++++++++++++++
 arch/x86/kernel/asm-offsets_64.c | 15 +++++++++++++++
 arch/x86/kernel/head_64.S        |  6 ++++++
 7 files changed, 92 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a30fe85e27ac..82342f27b218 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1877,6 +1877,10 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 
 	  If unsure, say y.
 
+config ARCH_HAS_PTREGS_AUXILIARY
+	depends on X86_64
+	bool
+
 choice
 	prompt "TSX enable mode"
 	depends on CPU_SUP_INTEL
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a4c061fb7c6e..d0ebf9b069c9 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -63,6 +63,26 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
+
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
 .macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 466df3e50276..0684a8093965 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -332,7 +332,9 @@ SYM_CODE_END(ret_from_fork)
 		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	.endif
 
+	PUSH_PTREGS_AUXILIARY
 	call	\cfunc
+	POP_PTREGS_AUXILIARY
 
 	jmp	error_return
 .endm
@@ -435,7 +437,9 @@ SYM_CODE_START(\asmsym)
 
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
+	PUSH_PTREGS_AUXILIARY
 	call	\cfunc
+	POP_PTREGS_AUXILIARY
 
 	jmp	paranoid_exit
 
@@ -496,7 +500,9 @@ SYM_CODE_START(\asmsym)
 	 * stack.
 	 */
 	movq	%rsp, %rdi		/* pt_regs pointer */
+	PUSH_PTREGS_AUXILIARY
 	call	vc_switch_off_ist
+	POP_PTREGS_AUXILIARY
 	movq	%rax, %rsp		/* Switch to new stack */
 
 	UNWIND_HINT_REGS
@@ -507,7 +513,9 @@ SYM_CODE_START(\asmsym)
 
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
+	PUSH_PTREGS_AUXILIARY
 	call	kernel_\cfunc
+	POP_PTREGS_AUXILIARY
 
 	/*
 	 * No need to switch back to the IST stack. The current stack is either
@@ -542,7 +550,9 @@ SYM_CODE_START(\asmsym)
 	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
 	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
+	PUSH_PTREGS_AUXILIARY
 	call	\cfunc
+	POP_PTREGS_AUXILIARY
 
 	jmp	paranoid_exit
 
@@ -784,7 +794,9 @@ SYM_CODE_START_LOCAL(exc_xen_hypervisor_callback)
 	movq	%rdi, %rsp			/* we don't return, adjust the stack frame */
 	UNWIND_HINT_REGS
 
+	PUSH_PTREGS_AUXILIARY
 	call	xen_pv_evtchn_do_upcall
+	POP_PTREGS_AUXILIARY
 
 	jmp	error_return
 SYM_CODE_END(exc_xen_hypervisor_callback)
@@ -984,7 +996,9 @@ SYM_CODE_START_LOCAL(error_entry)
 	/* Put us onto the real thread stack. */
 	popq	%r12				/* save return addr in %12 */
 	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
+	PUSH_PTREGS_AUXILIARY
 	call	sync_regs
+	POP_PTREGS_AUXILIARY
 	movq	%rax, %rsp			/* switch stack */
 	ENCODE_FRAME_POINTER
 	pushq	%r12
@@ -1040,7 +1054,9 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * as if we faulted immediately after IRET.
 	 */
 	mov	%rsp, %rdi
+	PUSH_PTREGS_AUXILIARY
 	call	fixup_bad_iret
+	POP_PTREGS_AUXILIARY
 	mov	%rax, %rsp
 	jmp	.Lerror_entry_from_usermode_after_swapgs
 SYM_CODE_END(error_entry)
@@ -1146,7 +1162,9 @@ SYM_CODE_START(asm_exc_nmi)
 
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
+	PUSH_PTREGS_AUXILIARY
 	call	exc_nmi
+	POP_PTREGS_AUXILIARY
 
 	/*
 	 * Return back to user mode.  We must *not* do the normal exit
@@ -1182,6 +1200,8 @@ SYM_CODE_START(asm_exc_nmi)
 	 * +---------------------------------------------------------+
 	 * | pt_regs                                                 |
 	 * +---------------------------------------------------------+
+	 * | (Optionally) pt_regs_extended                           |
+	 * +---------------------------------------------------------+
 	 *
 	 * The "original" frame is used by hardware.  Before re-enabling
 	 * NMIs, we need to be done with it, and we need to leave enough
@@ -1358,7 +1378,9 @@ end_repeat_nmi:
 
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
+	PUSH_PTREGS_AUXILIARY
 	call	exc_nmi
+	POP_PTREGS_AUXILIARY
 
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 0051cf5c792d..c6859d8acae4 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -136,7 +136,9 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 .Lsysenter_flags_fixed:
 
 	movq	%rsp, %rdi
+	PUSH_PTREGS_AUXILIARY
 	call	do_SYSENTER_32
+	POP_PTREGS_AUXILIARY
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
@@ -253,7 +255,9 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi
+	PUSH_PTREGS_AUXILIARY
 	call	do_fast_syscall_32
+	POP_PTREGS_AUXILIARY
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
@@ -410,6 +414,8 @@ SYM_CODE_START(entry_INT80_compat)
 	cld
 
 	movq	%rsp, %rdi
+	PUSH_PTREGS_AUXILIARY
 	call	do_int80_syscall_32
+	POP_PTREGS_AUXILIARY
 	jmp	swapgs_restore_regs_and_return_to_usermode
 SYM_CODE_END(entry_INT80_compat)
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 703663175a5a..79541682e7f7 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -2,11 +2,13 @@
 #ifndef _ASM_X86_PTRACE_H
 #define _ASM_X86_PTRACE_H
 
+#include <linux/container_of.h>
 #include <asm/segment.h>
 #include <asm/page_types.h>
 #include <uapi/asm/ptrace.h>
 
 #ifndef __ASSEMBLY__
+
 #ifdef __i386__
 
 struct pt_regs {
@@ -91,6 +93,23 @@ struct pt_regs {
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
index b14533af7676..66f08ac3507a 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -4,6 +4,7 @@
 #endif
 
 #include <asm/ia32.h>
+#include <asm/ptrace.h>
 
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_PARAVIRT_SPINLOCKS)
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
index 9c63fc5988cd..8418d9de8d70 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -336,8 +336,10 @@ SYM_CODE_START_NOALIGN(vc_boot_ghcb)
 	movq    %rsp, %rdi
 	movq	ORIG_RAX(%rsp), %rsi
 	movq	initial_vc_handler(%rip), %rax
+	PUSH_PTREGS_AUXILIARY
 	ANNOTATE_RETPOLINE_SAFE
 	call	*%rax
+	POP_PTREGS_AUXILIARY
 
 	/* Unwind pt_regs */
 	POP_REGS
@@ -414,7 +416,9 @@ SYM_CODE_START_LOCAL(early_idt_handler_common)
 	UNWIND_HINT_REGS
 
 	movq %rsp,%rdi		/* RDI = pt_regs; RSI is already trapnr */
+	PUSH_PTREGS_AUXILIARY
 	call do_early_exception
+	POP_PTREGS_AUXILIARY
 
 	decl early_recursion_flag(%rip)
 	jmp restore_regs_and_return_to_kernel
@@ -438,7 +442,9 @@ SYM_CODE_START_NOALIGN(vc_no_ghcb)
 	/* Call C handler */
 	movq    %rsp, %rdi
 	movq	ORIG_RAX(%rsp), %rsi
+	PUSH_PTREGS_AUXILIARY
 	call    do_vc_no_ghcb
+	POP_PTREGS_AUXILIARY
 
 	/* Unwind pt_regs */
 	POP_REGS
-- 
2.31.1

