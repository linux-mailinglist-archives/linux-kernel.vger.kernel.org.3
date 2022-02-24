Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C8D4C3094
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbiBXP52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbiBXP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:57:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E398712764
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718193; x=1677254193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EDcsdaa3CooVKW3VeAd7SwKOoBvqieWwTDQ5K+cpg/U=;
  b=CiWPajI+jDxF8/UHQ0mVtGMpT5wg6i09fX3YDCZ00wDMRT0R66bXTq4p
   qefXJ5qcODNrD5QEUsEPUDPlEU+LhK7GP4VRodgm2Mn2WrQnOC54RGFhI
   D04LmEh1g/Z86DbkhajJiAVG2zH2JLD6XEeuIi9OCtX0tXxWVK+2h+Hd8
   +JGgyKqqObYF77zDio5VaO9LKy8gHhhN3eoe2IIz/cXzZfDm4xzakVatl
   9vGaG15pWK5G9uYAVJ4Yp9UoZYnQijK8sQPdbbLIQWgGvVGmQF9MT8kw1
   5GYY+yFeuBPUAhe2ogCvo1fCriklqdj9rANoS/xwvGDnIrp9YfyYdO93K
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="251094346"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="251094346"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:56:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="628512993"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2022 07:56:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 8AB627FA; Thu, 24 Feb 2022 17:56:34 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 08/30] x86/tdx: Add HLT support for TDX guests
Date:   Thu, 24 Feb 2022 18:56:08 +0300
Message-Id: <20220224155630.52734-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/x86/coco/tdcall.S     | 13 ++++++++
 arch/x86/coco/tdx.c        | 66 ++++++++++++++++++++++++++++++++++++--
 arch/x86/include/asm/tdx.h |  4 +++
 arch/x86/kernel/process.c  |  4 +++
 4 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdcall.S b/arch/x86/coco/tdcall.S
index c4dd9468e7d9..3c35a056974d 100644
--- a/arch/x86/coco/tdcall.S
+++ b/arch/x86/coco/tdcall.S
@@ -138,6 +138,19 @@ SYM_FUNC_START(__tdx_hypercall)
 
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
diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index 86a2f35e7308..0a2e6be0cdae 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/cpufeature.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
+#include <asm/vmx.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
@@ -59,6 +60,62 @@ static void get_info(void)
 	td_info.attributes = out.rdx;
 }
 
+static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_HLT,
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
@@ -98,8 +155,13 @@ static bool virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 /* Handle the kernel #VE */
 static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 {
-	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-	return false;
+	switch (ve->exit_reason) {
+	case EXIT_REASON_HLT:
+		return handle_halt();
+	default:
+		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+		return false;
+	}
 }
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 34cf998ad534..e6e23ade53a6 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -13,6 +13,7 @@
 #define TDX_HYPERCALL_STANDARD  0
 
 #define TDX_HCALL_HAS_OUTPUT	BIT(0)
+#define TDX_HCALL_ISSUE_STI	BIT(1)
 
 #define TDX_SEAMCALL_VMFAILINVALID     0x8000FF00FFFF0000ULL
 
@@ -79,9 +80,12 @@ void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
+void tdx_safe_halt(void);
+
 #else
 
 static inline void tdx_early_init(void) { };
+static inline void tdx_safe_halt(void) { };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index e131d71b3cae..2e90d57cf86e 100644
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
-- 
2.34.1

