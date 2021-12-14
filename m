Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA794745DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhLNPEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:04:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:28579 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235189AbhLNPDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225852701"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="225852701"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="754837179"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2021 07:03:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 53BF16B4; Tue, 14 Dec 2021 17:03:09 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 05/26] x86/tdx: Add HLT support for TDX guests (#VE approach)
Date:   Tue, 14 Dec 2021 18:02:43 +0300
Message-Id: <20211214150304.62613-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HLT instruction is a privileged instruction, executing it stops
instruction execution and places the processor in a HALT state. It
is used in kernel for cases like reboot, idle loop and exception fixup
handlers. For the idle case, interrupts will be enabled (using STI)
before the HLT instruction (this is also called safe_halt()).

To support the HLT instruction in TDX guests, it needs to be emulated
using TDVMCALL (hypercall to VMM). More details about it can be found
in Intel Trust Domain Extensions (Intel TDX) Guest-Host-Communication
Interface (GHCI) specification, section TDVMCALL[Instruction.HLT].

In TDX guests, executing HLT instruction will generate a #VE, which is
used to emulate the HLT instruction. But #VE based emulation will not
work for the safe_halt() flavor, because it requires STI instruction to
be executed just before the TDCALL. Since idle loop is the only user of
safe_halt() variant, handle it as a special case.

To avoid *safe_halt() call in the idle function, define the
tdx_guest_idle() and use it to override the "x86_idle" function pointer
for a valid TDX guest.

Alternative choices like PV ops have been considered for adding
safe_halt() support. But it was rejected because HLT paravirt calls
only exist under PARAVIRT_XXL, and enabling it in TDX guest just for
safe_halt() use case is not worth the cost.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/tdx.h |  3 ++
 arch/x86/kernel/process.c  |  7 ++++
 arch/x86/kernel/tdcall.S   | 32 ++++++++++++++++
 arch/x86/kernel/tdx.c      | 75 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 8c33d7439c08..3be9d0e9f7a0 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -72,10 +72,13 @@ bool tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
+void tdx_guest_idle(void);
+
 #else
 
 static inline void tdx_early_init(void) { };
 static inline bool is_tdx_guest(void) { return false; }
+static inline void tdx_guest_idle(void) { };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index e9ee8b526319..273e4266b2c1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -46,6 +46,7 @@
 #include <asm/proto.h>
 #include <asm/frame.h>
 #include <asm/unwind.h>
+#include <asm/tdx.h>
 
 #include "process.h"
 
@@ -864,6 +865,12 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
 	if (x86_idle || boot_option_idle_override == IDLE_POLL)
 		return;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		x86_idle = tdx_guest_idle;
+		pr_info("using TDX aware idle routine\n");
+		return;
+	}
+
 	if (boot_cpu_has_bug(X86_BUG_AMD_E400)) {
 		pr_info("using AMD E400 aware idle routine\n");
 		x86_idle = amd_e400_idle;
diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
index ee52dde01b24..e19187048be8 100644
--- a/arch/x86/kernel/tdcall.S
+++ b/arch/x86/kernel/tdcall.S
@@ -3,6 +3,7 @@
 #include <asm/asm.h>
 #include <asm/frame.h>
 #include <asm/unwind_hints.h>
+#include <uapi/asm/vmx.h>
 
 #include <linux/linkage.h>
 #include <linux/bits.h>
@@ -39,6 +40,13 @@
  */
 #define tdcall .byte 0x66,0x0f,0x01,0xcc
 
+/*
+ * Used in the __tdx_hypercall() function to test R15 register content
+ * and optionally include the STI instruction before the TDCALL
+ * instruction (for EXIT_REASON_HLT case).
+ */
+#define do_sti	0x01
+
 /*
  * __tdx_module_call()  - Used by TDX guests to request services from
  * the TDX module (does not include VMM services).
@@ -231,6 +239,30 @@ SYM_FUNC_START(__tdx_hypercall)
 
 	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
 
+	/*
+	 * For the idle loop STI needs to be called directly before
+	 * the TDCALL that enters idle (EXIT_REASON_HLT case). STI
+	 * instruction enables interrupts only one instruction later.
+	 * If there is a window between STI and the instruction that
+	 * emulates the HALT state, there is a chance for interrupts to
+	 * happen in this window, which can delay the HLT operation
+	 * indefinitely. Since this is the not the desired result, add
+	 * support to conditionally call STI before TDCALL.
+	 *
+	 * Since STI instruction is only required for the idle case
+	 * (a special case of EXIT_REASON_HLT), use the r15 register
+	 * value to identify it. Since the R15 register is not used
+	 * by the VMM as per EXIT_REASON_HLT ABI, re-use it in
+	 * software to identify the STI case.
+	 */
+	cmpl $EXIT_REASON_HLT, %r11d
+	jne skip_sti
+	cmpl $do_sti, %r15d
+	jne skip_sti
+	/* Set R15 register to 0, it is unused in EXIT_REASON_HLT case */
+	xor %r15, %r15
+	sti
+skip_sti:
 	tdcall
 
 	/* Restore output pointer to R9 */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index b6d0e45e6589..6749ca3b2e3d 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -6,6 +6,7 @@
 
 #include <linux/cpufeature.h>
 #include <asm/tdx.h>
+#include <asm/vmx.h>
 
 /* TDX Module Call Leaf IDs */
 #define TDX_GET_VEINFO			3
@@ -36,6 +37,66 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
 	return out->r10;
 }
 
+static __cpuidle u64 _tdx_halt(const bool irq_disabled, const bool do_sti)
+{
+	/*
+	 * Emulate HLT operation via hypercall. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI), sec 3.8 TDG.VP.VMCALL<Instruction.HLT>.
+	 *
+	 * The VMM uses the "IRQ disabled" param to understand IRQ
+	 * enabled status (RFLAGS.IF) of the TD guest and to determine
+	 * whether or not it should schedule the halted vCPU if an
+	 * IRQ becomes pending. E.g. if IRQs are disabled, the VMM
+	 * can keep the vCPU in virtual HLT, even if an IRQ is
+	 * pending, without hanging/breaking the guest.
+	 *
+	 * do_sti parameter is used by the __tdx_hypercall() to decide
+	 * whether to call the STI instruction before executing the
+	 * TDCALL instruction.
+	 */
+	return _tdx_hypercall(EXIT_REASON_HLT, irq_disabled, 0, 0,
+			      do_sti, NULL);
+}
+
+static bool tdx_halt(void)
+{
+	/*
+	 * Since non safe halt is mainly used in CPU offlining
+	 * and the guest will always stay in the halt state, don't
+	 * call the STI instruction (set do_sti as false).
+	 */
+	const bool irq_disabled = irqs_disabled();
+	const bool do_sti = false;
+
+	if (_tdx_halt(irq_disabled, do_sti))
+		return false;
+
+	return true;
+}
+
+static __cpuidle void tdx_safe_halt(void)
+{
+	 /*
+	  * For do_sti=true case, __tdx_hypercall() function enables
+	  * interrupts using the STI instruction before the TDCALL. So
+	  * set irq_disabled as false.
+	  */
+	const bool irq_disabled = false;
+	const bool do_sti = true;
+
+	/*
+	 * Use WARN_ONCE() to report the failure.
+	 */
+	if (_tdx_halt(irq_disabled, do_sti))
+		WARN_ONCE(1, "HLT instruction emulation failed\n");
+}
+
+void __cpuidle tdx_guest_idle(void)
+{
+	tdx_safe_halt();
+}
+
 bool tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -79,8 +140,18 @@ static bool tdx_virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 /* Handle the kernel #VE */
 static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 {
-	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-	return false;
+	bool ret = false;
+
+	switch (ve->exit_reason) {
+	case EXIT_REASON_HLT:
+		ret = tdx_halt();
+		break;
+	default:
+		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+		break;
+	}
+
+	return ret;
 }
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
-- 
2.32.0

