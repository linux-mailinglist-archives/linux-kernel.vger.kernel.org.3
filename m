Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9FA4A325B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 23:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353345AbiA2Wac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 17:30:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:27050 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243417AbiA2Waa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 17:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643495430; x=1675031430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0YoN78A9G/WwGCZn+KmDESCzV1UuFBL3r+2yfV3uecg=;
  b=H2OmUxazp/YPxA0+xbKPRdvj3salLxMWZqzvs/RxPFqU85jG9ezEVDql
   JyQ/zVpXTTN10Vir4FX7Fpb1Bs2uYLrWl8KztrP8uS04+NY6XkVZeF5j6
   tA4R84nt16xtV/5EfnCxUomjNO0swUR3T+HugxIvWM+LaXjAqJPYEWCnr
   f0aHSL7hWA/1BrfW4W6dHodUnpxM5ENpE7ccQWZY5ofiRFMYPhrWjE8Dw
   xntuoMTjMhlVPGmy/PElBEzEFRQVhAE+u8krVTaPbAKEE+VyCQgHWnrRj
   InptdrMuORSor82SUZ3/hJfIL9JdjZ1N8aBQz+fIl2pjb0uhEOTqsbIqC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="247249876"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="247249876"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 14:30:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="625978430"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2022 14:30:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B160B114; Sun, 30 Jan 2022 00:30:37 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     bp@alien8.de
Cc:     aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: [PATCHv2.1 05/29] x86/tdx: Add HLT support for TDX guests
Date:   Sun, 30 Jan 2022 01:30:21 +0300
Message-Id: <20220129223021.29417-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YfVU01dBD36H0EIv@zn.tnic>
References: <YfVU01dBD36H0EIv@zn.tnic>
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
 arch/x86/kernel/process.c  |  4 +++
 arch/x86/kernel/tdcall.S   | 31 +++++++++++++++++
 arch/x86/kernel/tdx.c      | 70 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index d17143290f0a..9b4714a45bb9 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -74,10 +74,13 @@ bool tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
+void tdx_safe_halt(void);
+
 #else
 
 static inline void tdx_early_init(void) { };
 static inline bool is_tdx_guest(void) { return false; }
+static inline void tdx_safe_halt(void) { };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 81d8ef036637..71aa12082370 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -46,6 +46,7 @@
 #include <asm/proto.h>
 #include <asm/frame.h>
 #include <asm/unwind.h>
+#include <asm/tdx.h>
 
 #include "process.h"
 
@@ -870,6 +871,9 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
 	} else if (prefer_mwait_c1_over_halt(c)) {
 		pr_info("using mwait in idle threads\n");
 		x86_idle = mwait_idle;
+	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		pr_info("using TDX aware idle routine\n");
+		x86_idle = tdx_safe_halt;
 	} else
 		x86_idle = default_idle;
 }
diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
index 46a49a96cf6c..ae74da33ccc6 100644
--- a/arch/x86/kernel/tdcall.S
+++ b/arch/x86/kernel/tdcall.S
@@ -3,6 +3,7 @@
 #include <asm/asm.h>
 #include <asm/frame.h>
 #include <asm/unwind_hints.h>
+#include <uapi/asm/vmx.h>
 
 #include <linux/linkage.h>
 #include <linux/bits.h>
@@ -39,6 +40,12 @@
  */
 #define tdcall .byte 0x66,0x0f,0x01,0xcc
 
+/*
+ * Used in __tdx_hypercall() to determine whether to enable interrupts
+ * before issuing TDCALL for the EXIT_REASON_HLT case.
+ */
+#define ENABLE_IRQS_BEFORE_HLT 0x01
+
 /*
  * __tdx_module_call()  - Used by TDX guests to request services from
  * the TDX module (does not include VMM services).
@@ -230,6 +237,30 @@ SYM_FUNC_START(__tdx_hypercall)
 
 	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
 
+	/*
+	 * For the idle loop STI needs to be called directly before
+	 * the TDCALL that enters idle (EXIT_REASON_HLT case). STI
+	 * instruction enables interrupts only one instruction later.
+	 * If there is a window between STI and the instruction that
+	 * emulates the HALT state, there is a chance for interrupts to
+	 * happen in this window, which can delay the HLT operation
+	 * indefinitely. Since this is the not the desired result,
+	 * conditionally call STI before TDCALL.
+	 *
+	 * Since STI instruction is only required for the idle case
+	 * (a special case of EXIT_REASON_HLT), use the r15 register
+	 * value to identify it. Since the R15 register is not used
+	 * by the VMM as per EXIT_REASON_HLT ABI, re-use it in
+	 * software to identify the STI case.
+	 */
+	cmpl $EXIT_REASON_HLT, %r11d
+	jne .Lskip_sti
+	cmpl $ENABLE_IRQS_BEFORE_HLT, %r15d
+	jne .Lskip_sti
+	/* Set R15 register to 0, it is unused in EXIT_REASON_HLT case */
+	xor %r15, %r15
+	sti
+.Lskip_sti:
 	tdcall
 
 	/* Restore output pointer to R9 */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 5a5b25f9c4d3..eeb456631a65 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -6,6 +6,7 @@
 
 #include <linux/cpufeature.h>
 #include <asm/tdx.h>
+#include <asm/vmx.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_VEINFO			3
@@ -35,6 +36,61 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
 	return out->r10;
 }
 
+static u64 __cpuidle _tdx_halt(const bool irq_disabled, const bool do_sti)
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
+void __cpuidle tdx_safe_halt(void)
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
 bool tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -75,8 +131,18 @@ static bool tdx_virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
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
2.34.1

