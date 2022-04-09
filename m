Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFB04FA151
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbiDIBbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbiDIBaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:30:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE708111DFC;
        Fri,  8 Apr 2022 18:27:39 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467658;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPOCW0wGTUUx+QgRit9q7DcN+Re50iMoq3WnU79jdnA=;
        b=MKzcVHdtoSC6WLW3xanPJQjWMVIgRRGpofhYoMVSKSU01UYnugx9Yhtrz9dMJ7ZPzurk13
        QyEhh5SSlEAeW5NEkjjZzRufqLeDLjC7hvUgeGrPkstzOczNGAdv9VuWyPf43HkxXKs6vi
        2VaxlxZjfNYTMOdeqf3W2iEtrcdiZHsAyc0NFD5r8NT6sGskPjbMc3+tG/wLeOktP7pE6J
        HHxkAvUJEsOb7Qmks/TjmnUBob8UAmODN9TcZVEAe9JVS1B9k7RDPjwcxyo5hbnypEg6U7
        QLLTRX2KB1yVDRj6wvwHeGGJ32aApY+fv8R1lHbXtqWXRwiITMQyU0DFNPX+1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467658;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPOCW0wGTUUx+QgRit9q7DcN+Re50iMoq3WnU79jdnA=;
        b=syWZFLeZaGgvhgPdmQN0eADV2F0gOs+SznyhId4VtbLesAOKB+jtUCV/a0kJ/qRerpzJt6
        Ar2FCLnfth8DAyDQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Add HLT support for TDX guests
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-9-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-9-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946765734.4207.8704764815955880448.tip-bot2@tip-bot2>
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

Commit-ID:     bfe6ed0c672782ac2a8edffac93b1ba84b0ff984
Gitweb:        https://git.kernel.org/tip/bfe6ed0c672782ac2a8edffac93b1ba84b0ff984
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:17 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:51 -07:00

x86/tdx: Add HLT support for TDX guests

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
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220405232939.73860-9-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/tdx/tdcall.S | 13 +++++-
 arch/x86/coco/tdx/tdx.c    | 93 ++++++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/tdx.h |  4 ++-
 arch/x86/kernel/process.c  |  4 ++-
 4 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 662479c..2458882 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -139,6 +139,19 @@ SYM_FUNC_START(__tdx_hypercall)
 
 	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
 
+	/*
+	 * For the idle loop STI needs to be called directly before the TDCALL
+	 * that enters idle (EXIT_REASON_HLT case). STI instruction enables
+	 * interrupts only one instruction later. If there is a window between
+	 * STI and the instruction that emulates the HALT state, there is a
+	 * chance for interrupts to happen in this window, which can delay the
+	 * HLT operation indefinitely. Since this is the not the desired
+	 * result, conditionally call STI before TDCALL.
+	 */
+	testq $TDX_HCALL_ISSUE_STI, %rsi
+	jz .Lskip_sti
+	sti
+.Lskip_sti:
 	tdcall
 
 	/*
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 60a3f2f..ed73025 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/cpufeature.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
+#include <asm/vmx.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
@@ -37,6 +38,17 @@ void __tdx_hypercall_failed(void)
 }
 
 /*
+ * The TDG.VP.VMCALL-Instruction-execution sub-functions are defined
+ * independently from but are currently matched 1:1 with VMX EXIT_REASONs.
+ * Reusing the KVM EXIT_REASON macros makes it easier to connect the host and
+ * guest sides of these calls.
+ */
+static u64 hcall_func(u64 exit_reason)
+{
+	return exit_reason;
+}
+
+/*
  * Used for TDX guests to make calls directly to the TD module.  This
  * should only be used for calls that have no legitimate reason to fail
  * or where the kernel can not survive the call failing.
@@ -74,6 +86,62 @@ static u64 get_cc_mask(void)
 	return BIT_ULL(gpa_width - 1);
 }
 
+static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = hcall_func(EXIT_REASON_HLT),
+		.r12 = irq_disabled,
+	};
+
+	/*
+	 * Emulate HLT operation via hypercall. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI), section 3.8 TDG.VP.VMCALL<Instruction.HLT>.
+	 *
+	 * The VMM uses the "IRQ disabled" param to understand IRQ
+	 * enabled status (RFLAGS.IF) of the TD guest and to determine
+	 * whether or not it should schedule the halted vCPU if an
+	 * IRQ becomes pending. E.g. if IRQs are disabled, the VMM
+	 * can keep the vCPU in virtual HLT, even if an IRQ is
+	 * pending, without hanging/breaking the guest.
+	 */
+	return __tdx_hypercall(&args, do_sti ? TDX_HCALL_ISSUE_STI : 0);
+}
+
+static bool handle_halt(void)
+{
+	/*
+	 * Since non safe halt is mainly used in CPU offlining
+	 * and the guest will always stay in the halt state, don't
+	 * call the STI instruction (set do_sti as false).
+	 */
+	const bool irq_disabled = irqs_disabled();
+	const bool do_sti = false;
+
+	if (__halt(irq_disabled, do_sti))
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
+	if (__halt(irq_disabled, do_sti))
+		WARN_ONCE(1, "HLT instruction emulation failed\n");
+}
+
 void tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -104,11 +172,32 @@ void tdx_get_ve_info(struct ve_info *ve)
 	ve->instr_info  = upper_32_bits(out.r10);
 }
 
+/* Handle the kernel #VE */
+static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
+{
+	switch (ve->exit_reason) {
+	case EXIT_REASON_HLT:
+		return handle_halt();
+	default:
+		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+		return false;
+	}
+}
+
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 {
-	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+	bool ret;
+
+	if (user_mode(regs))
+		ret = false;
+	else
+		ret = virt_exception_kernel(regs, ve);
+
+	/* After successful #VE handling, move the IP */
+	if (ret)
+		regs->ip += ve->instr_len;
 
-	return false;
+	return ret;
 }
 
 void __init tdx_early_init(void)
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index c4142e7..cbd61e1 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -14,6 +14,7 @@
 #define TDX_HYPERCALL_STANDARD  0
 
 #define TDX_HCALL_HAS_OUTPUT	BIT(0)
+#define TDX_HCALL_ISSUE_STI	BIT(1)
 
 /*
  * SW-defined error codes.
@@ -91,9 +92,12 @@ void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
+void tdx_safe_halt(void);
+
 #else
 
 static inline void tdx_early_init(void) { };
+static inline void tdx_safe_halt(void) { };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b370767..dbaf12c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -46,6 +46,7 @@
 #include <asm/proto.h>
 #include <asm/frame.h>
 #include <asm/unwind.h>
+#include <asm/tdx.h>
 
 #include "process.h"
 
@@ -873,6 +874,9 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
 	} else if (prefer_mwait_c1_over_halt(c)) {
 		pr_info("using mwait in idle threads\n");
 		x86_idle = mwait_idle;
+	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		pr_info("using TDX aware idle routine\n");
+		x86_idle = tdx_safe_halt;
 	} else
 		x86_idle = default_idle;
 }
