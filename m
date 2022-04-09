Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741E84FA133
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbiDIBbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbiDIBaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:30:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF339114367;
        Fri,  8 Apr 2022 18:27:40 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467659;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjYZuAQAJzIK0f8n1wN0sLgWr1jwfuUFG12pfmDYFQc=;
        b=3DjZ1bQv48m71H0KapDyKAXfItiFIMq7i/1lCG5Iiq1bKFkhAbWwwbccYd7zjbN0ApEXmj
        wZzoip3AOjiyUzpU5AaqNLoZT8KYvAnAiER1o5j2Rh5lhGYWA/mhunheM8WRQK0sY1Trcn
        TzZXnnKSOShNzKAozpSJT7VxW0GuFw3y7A4GL5yaMkilGCSEE62C23SgQ9YDUllWLOBAbw
        KEnO8bkEDDyTf1Cl/DkgFBu8KhkgyBTZuRXit4N0fncPAXX5SaaezArEPug3h43OVXjI2M
        VvEUDVgmodSZc+K43y2l/tk6bGmLjI3mMEOwNnnpwWfRgCqFz5W0eHQcKVodVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467659;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjYZuAQAJzIK0f8n1wN0sLgWr1jwfuUFG12pfmDYFQc=;
        b=CspUBY/qID/YTjdT3zu8oyWY6RhOZDVGPwT5CaEArXpsEl8yrn1NU8PVGWi/Zhxx8mFNKb
        uszhUOsudlIeabAQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/traps: Add #VE support for TDX guest
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-8-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-8-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946765819.4207.11650494667246044845.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     9a22bf6debbf5169f750af53c7f86eb4e3cd6712
Gitweb:        https://git.kernel.org/tip/9a22bf6debbf5169f750af53c7f86eb4e3cd6712
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:16 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:51 -07:00

x86/traps: Add #VE support for TDX guest

Virtualization Exceptions (#VE) are delivered to TDX guests due to
specific guest actions which may happen in either user space or the
kernel:

 * Specific instructions (WBINVD, for example)
 * Specific MSR accesses
 * Specific CPUID leaf accesses
 * Access to specific guest physical addresses

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

TDGETVEINFO retrieves the #VE info from the TDX module, which also
clears the "#VE valid" flag.  This must be done before anything else as
any #VE that occurs while the valid flag is set escalates to #DF by TDX
module. It will result in an oops.

Virtual NMIs are inhibited if the #VE valid flag is set. NMI will not be
delivered until TDGETVEINFO is called.

For now, convert unhandled #VE's (everything, until later in this
series) so that they appear just like a #GP by calling the
ve_raise_fault() directly. The ve_raise_fault() function is similar
to #GP handler and is responsible for sending SIGSEGV to userspace
and CPU die and notifying debuggers and other die chain users.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220405232939.73860-8-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/tdx/tdx.c         | 38 ++++++++++++++-
 arch/x86/include/asm/idtentry.h |  4 +-
 arch/x86/include/asm/tdx.h      | 21 ++++++++-
 arch/x86/kernel/idt.c           |  3 +-
 arch/x86/kernel/traps.c         | 86 ++++++++++++++++++++++++++++++++-
 5 files changed, 152 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e84f6dd..60a3f2f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -10,6 +10,7 @@
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
+#define TDX_GET_VEINFO			3
 
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
@@ -73,6 +74,43 @@ static u64 get_cc_mask(void)
 	return BIT_ULL(gpa_width - 1);
 }
 
+void tdx_get_ve_info(struct ve_info *ve)
+{
+	struct tdx_module_output out;
+
+	/*
+	 * Called during #VE handling to retrieve the #VE info from the
+	 * TDX module.
+	 *
+	 * This has to be called early in #VE handling.  A "nested" #VE which
+	 * occurs before this will raise a #DF and is not recoverable.
+	 *
+	 * The call retrieves the #VE info from the TDX module, which also
+	 * clears the "#VE valid" flag. This must be done before anything else
+	 * because any #VE that occurs while the valid flag is set will lead to
+	 * #DF.
+	 *
+	 * Note, the TDX module treats virtual NMIs as inhibited if the #VE
+	 * valid flag is set. It means that NMI=>#VE will not result in a #DF.
+	 */
+	tdx_module_call(TDX_GET_VEINFO, 0, 0, 0, 0, &out);
+
+	/* Transfer the output parameters */
+	ve->exit_reason = out.rcx;
+	ve->exit_qual   = out.rdx;
+	ve->gla         = out.r8;
+	ve->gpa         = out.r9;
+	ve->instr_len   = lower_32_bits(out.r10);
+	ve->instr_info  = upper_32_bits(out.r10);
+}
+
+bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
+{
+	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+
+	return false;
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 7924f27..72184b0 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -632,6 +632,10 @@ DECLARE_IDTENTRY_XENCB(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
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
index a33d47a..c4142e7 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -6,6 +6,7 @@
 #include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/bits.h>
+#include <asm/ptrace.h>
 
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
@@ -56,6 +57,22 @@ struct tdx_hypercall_args {
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
+	/* Guest Physical Address */
+	u64 gpa;
+	u32 instr_len;
+	u32 instr_info;
+};
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 void __init tdx_early_init(void);
@@ -70,6 +87,10 @@ u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __tdx_hypercall_failed(void);
 
+void tdx_get_ve_info(struct ve_info *ve);
+
+bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
+
 #else
 
 static inline void tdx_early_init(void) { };
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 608eb63..a58c6bc 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -69,6 +69,9 @@ static const __initconst struct idt_data early_idts[] = {
 	 */
 	INTG(X86_TRAP_PF,		asm_exc_page_fault),
 #endif
+#ifdef CONFIG_INTEL_TDX_GUEST
+	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
+#endif
 };
 
 /*
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index db8d22a..f9fb653 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -62,6 +62,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/vdso.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -1348,6 +1349,91 @@ DEFINE_IDTENTRY(exc_device_not_available)
 	}
 }
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+
+#define VE_FAULT_STR "VE fault"
+
+static void ve_raise_fault(struct pt_regs *regs, long error_code)
+{
+	if (user_mode(regs)) {
+		gp_user_force_sig_segv(regs, X86_TRAP_VE, error_code, VE_FAULT_STR);
+		return;
+	}
+
+	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code, VE_FAULT_STR))
+		return;
+
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
+ *  * Access to specific guest physical addresses
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
+ *
+ * The entry code has been audited carefully for following these expectations.
+ * Changes in the entry code have to be audited for correctness vs. this
+ * aspect. Similarly to #PF, #VE in these places will expose kernel to
+ * privilege escalation or may lead to random crashes.
+ */
+DEFINE_IDTENTRY(exc_virtualization_exception)
+{
+	struct ve_info ve;
+
+	/*
+	 * NMIs/Machine-checks/Interrupts will be in a disabled state
+	 * till TDGETVEINFO TDCALL is executed. This ensures that VE
+	 * info cannot be overwritten by a nested #VE.
+	 */
+	tdx_get_ve_info(&ve);
+
+	cond_local_irq_enable(regs);
+
+	/*
+	 * If tdx_handle_virt_exception() could not process
+	 * it successfully, treat it as #GP(0) and handle it.
+	 */
+	if (!tdx_handle_virt_exception(regs, &ve))
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
