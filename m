Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B014745D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhLNPDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:03:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:28570 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235158AbhLNPDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225852666"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="225852666"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="583474826"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 14 Dec 2021 07:03:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 48051673; Tue, 14 Dec 2021 17:03:09 +0200 (EET)
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
Subject: [PATCH 04/26] x86/traps: Add #VE support for TDX guest
Date:   Tue, 14 Dec 2021 18:02:42 +0300
Message-Id: <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
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

In the settings that Linux will run in, virtual exceptions are never
generated on accesses to normal, TD-private memory that has been
accepted.

The #VE handler implementation is simplified by the fact that entry
paths do not trigger #VE and that the handler may not be interrupted.
Specifically, the implementation assumes that the entry paths do not
access TD-shared memory, MMIO regions, use #VE triggering MSRs,
instructions, or CPUID leaves that might generate #VE. Interrupts,
including NMIs, are blocked by the hardware starting with #VE delivery
until TDGETVEINFO is called. All of this combined  eliminates the
chance of a #VE during the syscall gap, or paranoid entry paths.

After TDGETVEINFO, #VE could happen in theory (e.g. through an NMI),
but it is expected not to happen because TDX expects NMIs not to
trigger #VEs. Another case where #VE could happen is if the #VE
exception panics, but in this case, since the platform is already in
a panic state, nested #VE is not a concern.

If a guest kernel action which would normally cause a #VE occurs in
the interrupt-disabled region before TDGETVEINFO, a #DF (fault
exception) is delivered to the guest which will result in an oops
(and should eventually be a panic, as it is expected panic_on_oops is
set to 1 for TDX guests).

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
 arch/x86/include/asm/idtentry.h |  4 ++
 arch/x86/include/asm/tdx.h      | 21 +++++++++
 arch/x86/kernel/idt.c           |  3 ++
 arch/x86/kernel/tdx.c           | 66 +++++++++++++++++++++++++++
 arch/x86/kernel/traps.c         | 79 +++++++++++++++++++++++++++++++++
 5 files changed, 173 insertions(+)

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
index 78bfd7dc9b2f..8c33d7439c08 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -4,6 +4,7 @@
 #define _ASM_X86_TDX_H
 
 #include <linux/init.h>
+#include <asm/ptrace.h>
 
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_HYPERCALL_STANDARD  0
@@ -38,6 +39,22 @@ struct tdx_hypercall_output {
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
@@ -51,6 +68,10 @@ u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
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
index 1cc850fd03ff..b6d0e45e6589 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -7,6 +7,9 @@
 #include <linux/cpufeature.h>
 #include <asm/tdx.h>
 
+/* TDX Module Call Leaf IDs */
+#define TDX_GET_VEINFO			3
+
 static bool tdx_guest_detected __ro_after_init;
 
 /*
@@ -33,6 +36,69 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
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
+ * For example, executing the CPUID instruction from the user
+ * space is a valid case and hence the resulting #VE had to
+ * be handled.
+ *
+ * For dis-allowed or invalid #VE just return failure.
+ *
+ * Return True on success and False on failure.
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
index c9d566dcf89a..24791a8bcd63 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/vdso.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -1212,6 +1213,84 @@ DEFINE_IDTENTRY(exc_device_not_available)
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
+ * In TDX guests, specific MSRs, instructions, CPUID leaves, shared
+ * memory access triggers #VE. The tdx_handle_virt_exception() will
+ * try to handle the #VE using appropriate hypercalls. For unhandled
+ * or failed #VEs, attempt recovery using fixups or raise fault if
+ * failed.
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
2.32.0

