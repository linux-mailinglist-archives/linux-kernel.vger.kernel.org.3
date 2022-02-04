Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23134A92CF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 04:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356844AbiBDDnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 22:43:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:61187 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232345AbiBDDnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643946184; x=1675482184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3uTFZobat6+M98NVZ6aOUCNuFdRnUqWsBNK5KQaZHPc=;
  b=RDT53Zrt4c120DtiEWnCbnu9VJrW22nPoHuBRd7JNd2a1DGDT42nNjA0
   GWS+UjfqwNUuh8Umywre3jD/cGFZzwO/qLbYMQfbO/yoeiClNDvFVUMoe
   5fS7bTQ22M5SURAGgB86l1Rnd7Xk68XsVSnTSx5NwXQA6uedvIIqO4auh
   0rbWoYlyaomHIPMQuxw8oDwHvHZE5n73uhrhGNPe3p1+5aSv7RI1ZAztA
   PiqirlNJZH6fFPcVCXowLMB9/jv3/woMPka9qDeHKuCRczoZ+o9c+KSDY
   ceiP5YeYfF78CeBYkA5Jsw6OcCw5w8DWbP1DAgiFDRjAoTI/I7+T5FPyO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="309049291"
X-IronPort-AV: E=Sophos;i="5.88,341,1635231600"; 
   d="scan'208";a="309049291"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 19:43:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,341,1635231600"; 
   d="scan'208";a="620725681"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Feb 2022 19:42:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9E0C018D; Fri,  4 Feb 2022 05:43:12 +0200 (EET)
Date:   Fri, 4 Feb 2022 06:43:12 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 03/29] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <20220204034312.43rotpihciik2gk6@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
 <87a6faz7cs.ffs@tglx>
 <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
 <20220202235910.c512857813ea5b14aa73267f@intel.com>
 <20220203144403.ytyw5vcv4gshxyhn@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203144403.ytyw5vcv4gshxyhn@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 05:44:03PM +0300, Kirill A. Shutemov wrote:
> Any objections?

Below is proper patch of the idea. It can be used to implement both
SEAMCALL and TDCALL wrappers.

It works for TDCALL. Kai, could you check if it is fine for SEAMCALL?

----------------------------------8<-----------------------------------

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 4 Feb 2022 02:03:21 +0300
Subject: [PATCH] x86/tdx: Provide common base for SEAMCALL and TDCALL C
 wrappers

Secure Arbitration Mode (SEAM) is an extension of VMX architecture.  It
defines a new VMX root operation (SEAM VMX root) and a new VMX non-root
operation (SEAM VMX non-root) which are both isolated from the legacy
VMX operation where the host kernel runs.

A CPU-attested software module (called 'TDX module') runs in SEAM VMX
root to manage and protect VMs running in SEAM VMX non-root.  SEAM VMX
root is also used to host another CPU-attested software module (called
'P-SEAMLDR') to load and update the TDX module.

Host kernel transits to either P-SEAMLDR or TDX module via the new
SEAMCALL instruction, which is essentially a VMExit from VMX root mode
to SEAM VMX root mode.  SEAMCALLs are leaf functions defined by
P-SEAMLDR and TDX module around the new SEAMCALL instruction.

A guest kernel can also communicate with TDX module via TDCALL
instruction.

TDCALLs and SEAMCALLs use an ABI different from the x86-64 system-v ABI.
RAX is used to carry both the SEAMCALL leaf function number (input) and
the completion status (output).  Additional GPRs (RCX, RDX, R8-R11) may
be further used as both input and output operands in individual leaf.

TDCALL and SEAMCALL share the same ABI and require the largely same
code to pass down arguments and retrieve results.

Define an assembly macro that can be used to implement C wrapper for
both TDCALL and SEAMCALL.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/tdx.h    | 20 ++++++++
 arch/x86/kernel/asm-offsets.c |  9 ++++
 arch/x86/kernel/tdxcall.S     | 91 +++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 arch/x86/kernel/tdxcall.S

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index ba8042ce61c2..2f8cb1e53e77 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -8,6 +8,25 @@
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+#define TDX_SEAMCALL_VMFAILINVALID     0x8000FF00FFFF0000ULL
+
+#ifndef __ASSEMBLY__
+
+/*
+ * Used to gather the output registers values of the TDCALL and SEAMCALL
+ * instructions when requesting services from the TDX module.
+ *
+ * This is a software only structure and not part of the TDX module/VMM ABI.
+ */
+struct tdx_module_output {
+	u64 rcx;
+	u64 rdx;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+};
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 void __init tdx_early_init(void);
@@ -18,4 +37,5 @@ static inline void tdx_early_init(void) { };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+#endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 9fb0a2f8b62a..7dca52f5cfc6 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -18,6 +18,7 @@
 #include <asm/bootparam.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_XEN
 #include <xen/interface/xen.h>
@@ -65,6 +66,14 @@ static void __used common(void)
 	OFFSET(XEN_vcpu_info_arch_cr2, vcpu_info, arch.cr2);
 #endif
 
+	BLANK();
+	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
+	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
+	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
+	OFFSET(TDX_MODULE_r9,  tdx_module_output, r9);
+	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
+	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
+
 	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
 	OFFSET(BP_secure_boot, boot_params, secure_boot);
diff --git a/arch/x86/kernel/tdxcall.S b/arch/x86/kernel/tdxcall.S
new file mode 100644
index 000000000000..27d6fcc8e44c
--- /dev/null
+++ b/arch/x86/kernel/tdxcall.S
@@ -0,0 +1,91 @@
+#include <asm/asm-offsets.h>
+#include <asm/tdx.h>
+
+/*
+ * TDX guests use the TDCALL instruction to make requests to the
+ * TDX module and hypercalls to the VMM.
+ *
+ * TDX host user SEAMCALL instruction to make requests to TDX module.
+ *
+ * They are supported in Binutils >= 2.36.
+ */
+#define tdcall		.byte 0x66,0x0f,0x01,0xcc
+#define seamcall	.byte 0x66,0x0f,0x01,0xcf
+
+.macro TDX_MODULE_CALL host:req
+	/*
+	 * R12 will be used as temporary storage for struct tdx_module_output
+	 * pointer. Since R12-R15 registers are not used by TDCALL/SEAMCALL
+	 * services supported by this function, it can be reused.
+	 */
+
+	/* Callee saved, so preserve it */
+	push %r12
+
+	/*
+	 * Push output pointer to stack.
+	 * After the operation, it will be fetched into R12 register.
+	 */
+	push %r9
+
+	/* Mangle function call ABI into TDCALL/SEAMCALL ABI: */
+	/* Move Leaf ID to RAX */
+	mov %rdi, %rax
+	/* Move input 4 to R9 */
+	mov %r8,  %r9
+	/* Move input 3 to R8 */
+	mov %rcx, %r8
+	/* Move input 1 to RCX */
+	mov %rsi, %rcx
+	/* Leave input param 2 in RDX */
+
+	.if \host
+	seamcall
+	/*
+	 * SEAMCALL instruction is essentially a VMExit from VMX root
+	 * mode to SEAM VMX root mode.  VMfailInvalid (CF=1) indicates
+	 * that the targeted SEAM firmware is not loaded or disabled,
+	 * or P-SEAMLDR is busy with another SEAMCALL.  %rax is not
+	 * changed in this case.
+	 *
+	 * Set %rax to TDX_SEAMCALL_VMFAILINVALID for VMfailInvalid.
+	 * This value will never be used as actual SEAMCALL error code.
+	 */
+	jnc     .Lno_vmfailinvalid
+	mov     $TDX_SEAMCALL_VMFAILINVALID, %rax
+	jmp     .Lno_output_struct
+.Lno_vmfailinvalid:
+	.else
+	tdcall
+	.endif
+
+	/*
+	 * Fetch output pointer from stack to R12 (It is used
+	 * as temporary storage)
+	 */
+	pop %r12
+
+	/* Check for success: 0 - Successful, otherwise failed */
+	test %rax, %rax
+	jnz .Lno_output_struct
+
+	/*
+	 * Since this function can be initiated without an output pointer,
+	 * check if caller provided an output struct before storing
+	 * output registers.
+	 */
+	test %r12, %r12
+	jz .Lno_output_struct
+
+	/* Copy result registers to output struct: */
+	movq %rcx, TDX_MODULE_rcx(%r12)
+	movq %rdx, TDX_MODULE_rdx(%r12)
+	movq %r8,  TDX_MODULE_r8(%r12)
+	movq %r9,  TDX_MODULE_r9(%r12)
+	movq %r10, TDX_MODULE_r10(%r12)
+	movq %r11, TDX_MODULE_r11(%r12)
+
+.Lno_output_struct:
+	/* Restore the state of R12 register */
+	pop %r12
+.endm
-- 
 Kirill A. Shutemov
