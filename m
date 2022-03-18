Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1597C4DDCFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbiCRPc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbiCRPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:32:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A472A187BA1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647617447; x=1679153447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RoAYLF7wSNigQdVy/C88CKPH34bh1+dOWypwNcODMGs=;
  b=N3qfI6ADymeXL0ON/g7cDdIE6o0w8FGGIZpAgsynUs+eOsNXPU8P+tNS
   KZAC00cgSvnZmKTDXLnQbpvKphfMKP9gUPOtFbNFovrfVSCCBvsRF+2Yo
   5y+Cf1vPU8j8TDn1EP6lEjyLrQRkxSi+uAZogzeRPGpqwrrzpRYTSTTXy
   1mZm2TppRJscNs7Y7TXOM6JxsezceoI/bysUuCQYAJKicBBf7/wfMJcOC
   WH8ePGhup5NmPMKaWvV+cN3MO6En5oEYry0BSDAWKFM6SutIO5Lmn6k9y
   GHyne7iqeNWf+6sKbYdFAhVwdeeIBFawbGQJVQyRekrdpHTzt16hHjjMd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="256883201"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="256883201"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715523725"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 08:30:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 01B12381; Fri, 18 Mar 2022 17:30:49 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv7 07/30] x86/traps: Add #VE support for TDX guest
Date:   Fri, 18 Mar 2022 18:30:25 +0300
Message-Id: <20220318153048.51177-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c         | 38 +++++++++++++++
 arch/x86/include/asm/idtentry.h |  4 ++
 arch/x86/include/asm/tdx.h      | 21 ++++++++
 arch/x86/kernel/idt.c           |  3 ++
 arch/x86/kernel/traps.c         | 86 +++++++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e84f6dd3ed2a..60a3f2ff5b95 100644
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
index 0fd34019416a..ddbe750861f0 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -5,6 +5,7 @@
 
 #include <linux/bits.h>
 #include <linux/init.h>
+#include <asm/ptrace.h>
 
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
@@ -55,6 +56,22 @@ struct tdx_hypercall_args {
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
@@ -69,6 +86,10 @@ u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __tdx_hypercall_failed(void);
 
+void tdx_get_ve_info(struct ve_info *ve);
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
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index bb02faf5a50c..a77103e541bf 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -62,6 +62,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/vdso.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -1272,6 +1273,91 @@ DEFINE_IDTENTRY(exc_device_not_available)
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
-- 
2.34.1

