Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6024982CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbiAXPCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:02:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:64635 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238258AbiAXPCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036533; x=1674572533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YfNJ+Z5jmbyRfVApmGRzvisUXCbBpskwPlYNL4Rp32I=;
  b=iDfVQSGeR40frPkkWaDvpLIVa4Ro1e0uwReQ490czglyovf4/e9cSimN
   0pO9fYg9wrEZwZ4aH7y/bqFuBL1sAx9/pte8IUbYJ5hqqMNaZBt6YDFv8
   Oi2Hbch+nPpLvdp/b6/y5eMPNLRmCYMbvC8Y7suYGlQ/6TdCh/wHBqdRK
   s0HCD5J5/FbU5gw63lLKSDb0/4rn+BWBYvviOp3CAHX+0QuMNA4R9SnQ4
   WKYmTj+XhYNFiVhjslUKMFbmxN3xMsfkZfgJBbGt5HScXQif2qBKXLun5
   GZgXrfdr2behni0oykr5KT8AD3823WA72fMG0uoeMIfXcllmVnMxGn62y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="270498501"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="270498501"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="580395540"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2022 07:02:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 78AC449F; Mon, 24 Jan 2022 17:02:19 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCHv2 04/29] x86/traps: Add #VE support for TDX guest
Date:   Mon, 24 Jan 2022 18:01:50 +0300
Message-Id: <20220124150215.36893-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtualization Exceptions (#VE) are delivered to TDX guests due to
specific guest actions which may happen in either user space or the
kernel:

 * Specific instructions (WBINVD, for example)
 * Specific MSR accesses
 * Specific CPUID leaf accesses
 * Access to unmapped pages (EPT violation)

In the settings that Linux will run in, virtualization exceptions are
never generated on accesses to normal, TD-private memory that has been
accepted.

Syscall entry code has a critical window where the kernel stack is not
yet set up. Any exception in this window leads to hard to debug issues
and can be exploited for privilege escalation. Exceptions in the NMI
entry code also cause issues. Returning from the exception handler with
IRET will re-enable NMIs and nested NMI will corrupt the NMI stack.

For these reasons, the kernel avoids #VEs during the syscall gap and
the NMI entry code. Entry code paths do not access TD-shared memory,
MMIO regions, use #VE triggering MSRs, instructions, or CPUID leaves
that might generate #VE. VMM can remove memory from TD at any point,
but access to unaccepted (or missing) private memory leads to VM
termination, not to #VE.

Similarly to page faults and breakpoints, #VEs are allowed in NMI
handlers once the kernel is ready to deal with nested NMIs.

During #VE delivery, all interrupts, including NMIs, are blocked until
TDGETVEINFO is called. It prevents #VE nesting until the kernel reads
the VE info.

If a guest kernel action which would normally cause a #VE occurs in
the interrupt-disabled region before TDGETVEINFO, a #DF (fault
exception) is delivered to the guest which will result in an oops.

Add basic infrastructure to handle any #VE which occurs in the kernel
or userspace. Later patches will add handling for specific #VE
scenarios.

For now, convert unhandled #VE's (everything, until later in this
series) so that they appear just like a #GP by calling the
ve_raise_fault() directly. The ve_raise_fault() function is similar
to #GP handler and is responsible for sending SIGSEGV to userspace
and CPU die and notifying debuggers and other die chain users.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/idtentry.h |   4 ++
 arch/x86/include/asm/tdx.h      |  21 ++++++
 arch/x86/kernel/idt.c           |   3 +
 arch/x86/kernel/tdx.c           |  63 ++++++++++++++++++
 arch/x86/kernel/traps.c         | 110 ++++++++++++++++++++++++++++++++
 5 files changed, 201 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e9902..8ccc81d653b3 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -625,6 +625,10 @@ DECLARE_IDTENTRY_XENCB(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
 DECLARE_IDTENTRY_RAW(X86_TRAP_OTHER,	exc_xen_unknown_trap);
 #endif
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+DECLARE_IDTENTRY(X86_TRAP_VE,		exc_virtualization_exception);
+#endif
+
 /* Device interrupts common/spurious */
 DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	common_interrupt);
 #ifdef CONFIG_X86_LOCAL_APIC
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 5107a4d9ba8f..d17143290f0a 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -4,6 +4,7 @@
 #define _ASM_X86_TDX_H
 
 #include <linux/init.h>
+#include <asm/ptrace.h>
 
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
@@ -40,6 +41,22 @@ struct tdx_hypercall_output {
 	u64 r15;
 };
 
+/*
+ * Used by the #VE exception handler to gather the #VE exception
+ * info from the TDX module. This is a software only structure
+ * and not part of the TDX module/VMM ABI.
+ */
+struct ve_info {
+	u64 exit_reason;
+	u64 exit_qual;
+	/* Guest Linear (virtual) Address */
+	u64 gla;
+	/* Guest Physical (virtual) Address */
+	u64 gpa;
+	u32 instr_len;
+	u32 instr_info;
+};
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 void __init tdx_early_init(void);
@@ -53,6 +70,10 @@ u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 u64 __tdx_hypercall(u64 type, u64 fn, u64 r12, u64 r13, u64 r14,
 		    u64 r15, struct tdx_hypercall_output *out);
 
+bool tdx_get_ve_info(struct ve_info *ve);
+
+bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
+
 #else
 
 static inline void tdx_early_init(void) { };
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index df0fa695bb09..1da074123c16 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -68,6 +68,9 @@ static const __initconst struct idt_data early_idts[] = {
 	 */
 	INTG(X86_TRAP_PF,		asm_exc_page_fault),
 #endif
+#ifdef CONFIG_INTEL_TDX_GUEST
+	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
+#endif
 };
 
 /*
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index d40b6df51e26..5a5b25f9c4d3 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -7,6 +7,9 @@
 #include <linux/cpufeature.h>
 #include <asm/tdx.h>
 
+/* TDX module Call Leaf IDs */
+#define TDX_GET_VEINFO			3
+
 static bool tdx_guest_detected __ro_after_init;
 
 /*
@@ -32,6 +35,66 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
 	return out->r10;
 }
 
+bool tdx_get_ve_info(struct ve_info *ve)
+{
+	struct tdx_module_output out;
+
+	/*
+	 * NMIs and machine checks are suppressed. Before this point any
+	 * #VE is fatal. After this point (TDGETVEINFO call), NMIs and
+	 * additional #VEs are permitted (but it is expected not to
+	 * happen unless kernel panics).
+	 */
+	if (__tdx_module_call(TDX_GET_VEINFO, 0, 0, 0, 0, &out))
+		return false;
+
+	ve->exit_reason = out.rcx;
+	ve->exit_qual   = out.rdx;
+	ve->gla         = out.r8;
+	ve->gpa         = out.r9;
+	ve->instr_len   = lower_32_bits(out.r10);
+	ve->instr_info  = upper_32_bits(out.r10);
+
+	return true;
+}
+
+/*
+ * Handle the user initiated #VE.
+ *
+ * For example, executing the CPUID instruction from user space
+ * is a valid case and hence the resulting #VE has to be handled.
+ *
+ * For dis-allowed or invalid #VE just return failure.
+ */
+static bool tdx_virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
+{
+	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+	return false;
+}
+
+/* Handle the kernel #VE */
+static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
+{
+	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+	return false;
+}
+
+bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
+{
+	bool ret;
+
+	if (user_mode(regs))
+		ret = tdx_virt_exception_user(regs, ve);
+	else
+		ret = tdx_virt_exception_kernel(regs, ve);
+
+	/* After successful #VE handling, move the IP */
+	if (ret)
+		regs->ip += ve->instr_len;
+
+	return ret;
+}
+
 bool is_tdx_guest(void)
 {
 	return tdx_guest_detected;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c9d566dcf89a..428504535912 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/vdso.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -1212,6 +1213,115 @@ DEFINE_IDTENTRY(exc_device_not_available)
 	}
 }
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+
+#define VE_FAULT_STR "VE fault"
+
+static void ve_raise_fault(struct pt_regs *regs, long error_code)
+{
+	struct task_struct *tsk = current;
+
+	if (user_mode(regs)) {
+		tsk->thread.error_code = error_code;
+		tsk->thread.trap_nr = X86_TRAP_VE;
+		show_signal(tsk, SIGSEGV, "", VE_FAULT_STR, regs, error_code);
+		force_sig(SIGSEGV);
+		return;
+	}
+
+	/*
+	 * Attempt to recover from #VE exception failure without
+	 * triggering OOPS (useful for MSR read/write failures)
+	 */
+	if (fixup_exception(regs, X86_TRAP_VE, error_code, 0))
+		return;
+
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = X86_TRAP_VE;
+
+	/*
+	 * To be potentially processing a kprobe fault and to trust the result
+	 * from kprobe_running(), it should be non-preemptible.
+	 */
+	if (!preemptible() && kprobe_running() &&
+	    kprobe_fault_handler(regs, X86_TRAP_VE))
+		return;
+
+	/* Notify about #VE handling failure, useful for debugger hooks */
+	if (notify_die(DIE_GPF, VE_FAULT_STR, regs, error_code,
+		       X86_TRAP_VE, SIGSEGV) == NOTIFY_STOP)
+		return;
+
+	/* Trigger OOPS and panic */
+	die_addr(VE_FAULT_STR, regs, error_code, 0);
+}
+
+/*
+ * Virtualization Exceptions (#VE) are delivered to TDX guests due to
+ * specific guest actions which may happen in either user space or the
+ * kernel:
+ *
+ *  * Specific instructions (WBINVD, for example)
+ *  * Specific MSR accesses
+ *  * Specific CPUID leaf accesses
+ *  * Access to unmapped pages (EPT violation)
+ *
+ * In the settings that Linux will run in, virtualization exceptions are
+ * never generated on accesses to normal, TD-private memory that has been
+ * accepted.
+ *
+ * Syscall entry code has a critical window where the kernel stack is not
+ * yet set up. Any exception in this window leads to hard to debug issues
+ * and can be exploited for privilege escalation. Exceptions in the NMI
+ * entry code also cause issues. Returning from the exception handler with
+ * IRET will re-enable NMIs and nested NMI will corrupt the NMI stack.
+ *
+ * For these reasons, the kernel avoids #VEs during the syscall gap and
+ * the NMI entry code. Entry code paths do not access TD-shared memory,
+ * MMIO regions, use #VE triggering MSRs, instructions, or CPUID leaves
+ * that might generate #VE. VMM can remove memory from TD at any point,
+ * but access to unaccepted (or missing) private memory leads to VM
+ * termination, not to #VE.
+ *
+ * Similarly to page faults and breakpoints, #VEs are allowed in NMI
+ * handlers once the kernel is ready to deal with nested NMIs.
+ *
+ * During #VE delivery, all interrupts, including NMIs, are blocked until
+ * TDGETVEINFO is called. It prevents #VE nesting until the kernel reads
+ * the VE info.
+ *
+ * If a guest kernel action which would normally cause a #VE occurs in
+ * the interrupt-disabled region before TDGETVEINFO, a #DF (fault
+ * exception) is delivered to the guest which will result in an oops.
+ */
+DEFINE_IDTENTRY(exc_virtualization_exception)
+{
+	struct ve_info ve;
+	bool ret;
+
+	/*
+	 * NMIs/Machine-checks/Interrupts will be in a disabled state
+	 * till TDGETVEINFO TDCALL is executed. This ensures that VE
+	 * info cannot be overwritten by a nested #VE.
+	 */
+	ret = tdx_get_ve_info(&ve);
+
+	cond_local_irq_enable(regs);
+
+	if (ret)
+		ret = tdx_handle_virt_exception(regs, &ve);
+	/*
+	 * If tdx_handle_virt_exception() could not process
+	 * it successfully, treat it as #GP(0) and handle it.
+	 */
+	if (!ret)
+		ve_raise_fault(regs, 0);
+
+	cond_local_irq_disable(regs);
+}
+
+#endif
+
 #ifdef CONFIG_X86_32
 DEFINE_IDTENTRY_SW(iret_error)
 {
-- 
2.34.1

