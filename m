Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ADF4C398A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiBXXKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiBXXKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:10:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D2727027C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645744201; x=1677280201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BOArgsa4aUV5lPfkHXwxYs0DYnCrWTrgKgUJvm2WhmM=;
  b=XkaNvY5YFeyGKND8cJlblFShprVBCbKV4Df0GN0b+nOD79uu1YLRbiEH
   g4PQpYEy6OFDPdOQ9xBvq6cmT3tm8gCO99kMBf9wtUuNhtLPqzfx6gBFg
   V7s1pDJZCapU71g5bUUCOQ6B/XOk/9/fS8OHcSu7vF1Teu3wzk1+69zr6
   PiTffYTxpjdpjgQ3ymZailVL7RR1Abti89rYWfTzt4SFAKwestlDekl2m
   IYUdTZ/rJEptOaQ9s195OCPrMdf7plQP/vuZ9n7/pYoD926HMr1iccniW
   +OAH9hrHzgtkVF3iuacjgbIgujQqRyISpxa9nV7ySOJL5jKja2qbzDSf4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="277004200"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="277004200"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="628657740"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2022 15:09:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 07B7D94; Fri, 25 Feb 2022 01:10:11 +0200 (EET)
Date:   Fri, 25 Feb 2022 02:10:11 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 03/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
Message-ID: <20220224231011.c6mbmsj2ahtw4wmt@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-4-kirill.shutemov@linux.intel.com>
 <faeb3c16-55a9-912d-1222-9dab364f56c7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faeb3c16-55a9-912d-1222-9dab364f56c7@intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 08:35:32AM -0800, Dave Hansen wrote:
> ...
> >  arch/x86/include/asm/tdx.h    | 20 ++++++++
> >  arch/x86/kernel/asm-offsets.c |  9 ++++
> >  arch/x86/virt/tdxcall.S       | 91 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 120 insertions(+)
> >  create mode 100644 arch/x86/virt/tdxcall.S
> > 
> > diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> > index ba8042ce61c2..2f8cb1e53e77 100644
> > --- a/arch/x86/include/asm/tdx.h
> > +++ b/arch/x86/include/asm/tdx.h
> > @@ -8,6 +8,25 @@
> >  #define TDX_CPUID_LEAF_ID	0x21
> >  #define TDX_IDENT		"IntelTDX    "
> >  
> > +#define TDX_SEAMCALL_VMFAILINVALID     0x8000FF00FFFF0000ULL
> 
> This needs a comment.  It's a completely software-defined value, right?

Right, bits 47:40 indicate "Status Code Class" and 0xFF reserved for SW
usage. (It is not reflected in the current public spec, but it will be in
the next.)

> > diff --git a/arch/x86/virt/tdxcall.S b/arch/x86/virt/tdxcall.S
> > new file mode 100644
> > index 000000000000..90569faedacc
> > --- /dev/null
> > +++ b/arch/x86/virt/tdxcall.S
> > @@ -0,0 +1,91 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#include <asm/asm-offsets.h>
> > +#include <asm/tdx.h>
> > +
> > +/*
> > + * TDX guests use the TDCALL instruction to make requests to the
> > + * TDX module and hypercalls to the VMM.
> > + *
> > + * TDX host user SEAMCALL instruction to make requests to TDX module.
> 
> 		^ uses??
> 
> 
> > + * They are supported in Binutils >= 2.36.
> > + */
> 
> While you're in there, could we make this a little more structured, please?
> 
> /*
>  * TDX_MODULE_CALL - common helper macro for both
>  *		     TDCALL and SEAMCALL instructions.
>  * 		
>  * TDCALL   - used by TDX guests to make requests to the
>  * 	      TDX module and hypercalls to the VMM.
>  * SEAMCALL - used by TDX hosts to make requests to the
>  *	      TDX module.
>  *
>  * Both instruction are supported in Binutils >= 2.36.
>  */

Sure.

 > +	/*
> > +	 * SEAMCALL instruction is essentially a VMExit from VMX root
> > +	 * mode to SEAM VMX root mode.  VMfailInvalid (CF=1) indicates
> > +	 * that the targeted SEAM firmware is not loaded or disabled,
> > +	 * or P-SEAMLDR is busy with another SEAMCALL.  %rax is not
> > +	 * changed in this case.
> > +	 *
> > +	 * Set %rax to TDX_SEAMCALL_VMFAILINVALID for VMfailInvalid.
> > +	 * This value will never be used as actual SEAMCALL error code.
> > +	 */
> 
> Why can TDX_SEAMCALL_VMFAILINVALID never be used as an actual SEAMCALL
> error code?  Would it be more accurate to say that today's P-SEAMLDR and
> TDX module never use TDX_SEAMCALL_VMFAILINVALID as an actual SEAMCALL
> error code?

No, see above. There's actual guarantee.

> There's an important distinction there.  It's possible that the SEAMCALL
> instruction architecture says or implies that it can never have
> TDX_SEAMCALL_VMFAILINVALID as a return value.  It's also possible that
> this "never" comes from a guess about what P-SEAMLDRs or TDX modules can do.
> 

...

> 
> That doesn't look too bad.  Please just send an updated version with the
> revised comments.

How about this:

From 3e10e826d5a7059f4eb4d4a8fb0cd950fac86b6f Mon Sep 17 00:00:00 2001
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
 arch/x86/include/asm/tdx.h    | 26 ++++++++++
 arch/x86/kernel/asm-offsets.c |  9 ++++
 arch/x86/virt/tdxcall.S       | 95 +++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 arch/x86/virt/tdxcall.S

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index ba8042ce61c2..e59c7960cc0d 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -8,6 +8,31 @@
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+/*
+ * SW-defined error codes.
+ *
+ * Bits 47:40 == 0xFF indicate Reserved status code class that never used by
+ * TDX module.
+ */
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
@@ -18,4 +43,5 @@ static inline void tdx_early_init(void) { };
 
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
diff --git a/arch/x86/virt/tdxcall.S b/arch/x86/virt/tdxcall.S
new file mode 100644
index 000000000000..b9ec23c95fd5
--- /dev/null
+++ b/arch/x86/virt/tdxcall.S
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/asm-offsets.h>
+#include <asm/tdx.h>
+
+/*
+ * TDX_MODULE_CALL - common helper macro for both
+ *                 TDCALL and SEAMCALL instructions.
+ *
+ * TDCALL   - used by TDX guests to make requests to the
+ *            TDX module and hypercalls to the VMM.
+ * SEAMCALL - used by TDX hosts to make requests to the
+ *            TDX module.
+ *
+ * Both instruction are supported in Binutils >= 2.36.
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
+	 * This value will never be used as actual SEAMCALL error code as
+	 * it is from the Reserved status code class.
+	 */
+	jnc .Lno_vmfailinvalid
+	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
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
