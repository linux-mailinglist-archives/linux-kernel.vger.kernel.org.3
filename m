Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABEA4A6A5C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiBBCzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:55:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:63937 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232577AbiBBCzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643770512; x=1675306512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k8Dbu3Zj1xkn5QSisxDRl3z0rtt+0HtH31sMPbX2fzU=;
  b=VXugSXoKkFI55/AsmKmMZXsfMp9BU63eOlM+wLw2RZGeTxdMhtfwej/G
   pMBP++8Iss+37kO/21AsTE1NFgsy0e35oRopAinHknHbMgBVrckJwAxWW
   T/Zd/3ghoZEUEtPLNM6ZKfz8FMF0EVY7dU5K82BpHYjEzaGimcDVWqyOP
   Cpg6u4hHouLW55hLEsGXSntr8Xi19vvcV4v9EtnrC6L+RReT1cBSLxaMH
   N42xlAtzZLvOYWvkwdhrITjc7KwoJnbAjIs3IDexxxJt63oLOPXAOy7Xq
   OsVzoeoP3gdFfNewM52c4h/gFdP6Rh25vAQBc9ar9KtZfUAUxMiY4uOgq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="308570230"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="308570230"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 18:55:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="620019757"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Feb 2022 18:55:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D60123B7; Wed,  2 Feb 2022 04:55:19 +0200 (EET)
Date:   Wed, 2 Feb 2022 05:55:19 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@linux.intel.com>
Subject: Re: [PATCHv2 03/29] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
 <87a6faz7cs.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6faz7cs.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 08:58:59PM +0100, Thomas Gleixner wrote:
> And unsurprisingly this function and __seamcall of the other patch set
> are very similar aside of the calling convention (__seamcall has a
> struct for the input parameters) and the obvious difference that one
> issues TDCALL and the other SEAMCALL.
> 
> So can we please have _one_ implementation and the same struct(s) for
> the module call which is exactly the same for host and guest except for
> the instruction used.
> 
> IOW, this begs a macro implementation
> 
> .macro TDX_MODULE_CALL host:req
> 
>        ....
> 
>         .if \host
>         seamcall
>         .else
> 	tdcall
>         .endif
> 
>        ....
> 
> So the actual functions become:
> 
> SYM_FUNC_START(__tdx_module_call)
>         FRAME_BEGIN
>         TDX_MODULE_CALL host=0
>         FRAME_END
>         ret
> SYM_FUNC_END(__tdx_module_call)
> 
> SYM_FUNC_START(__tdx_seam_call)
>         FRAME_BEGIN
>         TDX_MODULE_CALL host=1
>         FRAME_END
>         ret
> SYM_FUNC_END(__tdx_seam_call)
> 
> Hmm?
> 
> > +/*
> > + * Wrapper for standard use of __tdx_hypercall with panic report
> > + * for TDCALL error.
> > + */
> > +static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
> > +				 u64 r15, struct tdx_hypercall_output
> > *out)
> 
> This begs the question whether having a struct hypercall_input similar
> to the way how seamcall input parameters are implemented makes more
> sense than 7 function arguments. Hmm?

Okay, below is my take on addressing feedback for both __tdx_module_call()
and __tdx_hypercall().

It is fixup for whole patchset. It has to be folded accordingly. I wanted
to check if it works and see if I understand your request correctly.

__tdx_module_call() is now implemented by including tdxcall.S can using
the macro defined there. Host side of TDX can do the same on their side.
TDX_MODULE_* offsets are now outside of CONFIG_INTEL_TDX_GUEST and can be
used by both host can guest.

I changed __tdx_hypercall() to take single argument with struct pointer
that used for both input and output.

Is it the right direction? Or did I misunderstand something?

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index f2e1449c74cd..3ff676379947 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -21,20 +21,31 @@ bool early_is_tdx_guest(void)
 
 static inline unsigned int tdx_io_in(int size, int port)
 {
-	struct tdx_hypercall_output out;
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_IO_INSTRUCTION,
+		.r12 = size,
+		.r13  = 0,
+		.r14 = port,
+	};
 
-	__tdx_hypercall(TDX_HYPERCALL_STANDARD, EXIT_REASON_IO_INSTRUCTION,
-			size, 0, port, 0, &out);
+	__tdx_hypercall(&args);
 
-	return out.r10 ? UINT_MAX : out.r11;
+	return args.r10 ? UINT_MAX : args.r11;
 }
 
 static inline void tdx_io_out(int size, int port, u64 value)
 {
-	struct tdx_hypercall_output out;
-
-	__tdx_hypercall(TDX_HYPERCALL_STANDARD, EXIT_REASON_IO_INSTRUCTION,
-			size, 1, port, value, &out);
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_IO_INSTRUCTION,
+		.r12 = size,
+		.r13  = 1,
+		.r14 = port,
+		.r15 = value,
+	};
+
+	__tdx_hypercall(&args);
 }
 
 static inline unsigned char tdx_inb(int port)
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 4a0218bedc75..ce06002346a3 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -9,7 +9,7 @@
  * This is a software only structure and not part of the TDX
  * module/VMM ABI.
  */
-struct tdx_hypercall_output {
+struct tdx_hypercall_args {
 	u64 r10;
 	u64 r11;
 	u64 r12;
@@ -24,7 +24,6 @@ struct tdx_hypercall_output {
 #define TDX_IDENT		"IntelTDX    "
 
 /* Used to request services from the VMM */
-u64 __tdx_hypercall(u64 type, u64 fn, u64 r12, u64 r13, u64 r14,
-		    u64 r15, struct tdx_hypercall_output *out);
+u64 __tdx_hypercall(struct tdx_hypercall_args *out);
 
 #endif
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 8a3c6b34be7d..0b465e7d0a2f 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -66,9 +66,7 @@ static void __used common(void)
 	OFFSET(XEN_vcpu_info_arch_cr2, vcpu_info, arch.cr2);
 #endif
 
-#ifdef CONFIG_INTEL_TDX_GUEST
 	BLANK();
-	/* Offset for fields in tdx_module_output */
 	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
 	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
 	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
@@ -76,13 +74,14 @@ static void __used common(void)
 	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
 	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
 
-	/* Offset for fields in tdx_hypercall_output */
-	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_output, r10);
-	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_output, r11);
-	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_output, r12);
-	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_output, r13);
-	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_output, r14);
-	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_output, r15);
+#ifdef CONFIG_INTEL_TDX_GUEST
+	BLANK();
+	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_args, r10);
+	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_args, r11);
+	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_args, r12);
+	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_args, r13);
+	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_args, r14);
+	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_args, r15);
 #endif
 
 	BLANK();
diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
index ae74da33ccc6..4db79fbbb857 100644
--- a/arch/x86/kernel/tdcall.S
+++ b/arch/x86/kernel/tdcall.S
@@ -9,6 +9,8 @@
 #include <linux/bits.h>
 #include <linux/errno.h>
 
+#include "tdxcall.S"
+
 /*
  * Bitmasks of exposed registers (with VMM).
  */
@@ -19,9 +21,6 @@
 #define TDX_R14		BIT(14)
 #define TDX_R15		BIT(15)
 
-/* Frame offset + 8 (for arg1) */
-#define ARG7_SP_OFFSET		(FRAME_OFFSET + 0x08)
-
 /*
  * These registers are clobbered to hold arguments for each
  * TDVMCALL. They are safe to expose to the VMM.
@@ -33,13 +32,6 @@
 					  TDX_R12 | TDX_R13 | \
 					  TDX_R14 | TDX_R15 )
 
-/*
- * TDX guests use the TDCALL instruction to make requests to the
- * TDX module and hypercalls to the VMM. It is supported in
- * Binutils >= 2.36.
- */
-#define tdcall .byte 0x66,0x0f,0x01,0xcc
-
 /*
  * Used in __tdx_hypercall() to determine whether to enable interrupts
  * before issuing TDCALL for the EXIT_REASON_HLT case.
@@ -86,67 +78,7 @@
  */
 SYM_FUNC_START(__tdx_module_call)
 	FRAME_BEGIN
-
-	/*
-	 * R12 will be used as temporary storage for
-	 * struct tdx_module_output pointer. Since R12-R15
-	 * registers are not used by TDCALL services supported
-	 * by this function, it can be reused.
-	 */
-
-	/* Callee saved, so preserve it */
-	push %r12
-
-	/*
-	 * Push output pointer to stack.
-	 * After the TDCALL operation, it will be fetched
-	 * into R12 register.
-	 */
-	push %r9
-
-	/* Mangle function call ABI into TDCALL ABI: */
-	/* Move TDCALL Leaf ID to RAX */
-	mov %rdi, %rax
-	/* Move input 4 to R9 */
-	mov %r8,  %r9
-	/* Move input 3 to R8 */
-	mov %rcx, %r8
-	/* Move input 1 to RCX */
-	mov %rsi, %rcx
-	/* Leave input param 2 in RDX */
-
-	tdcall
-
-	/*
-	 * Fetch output pointer from stack to R12 (It is used
-	 * as temporary storage)
-	 */
-	pop %r12
-
-	/* Check for TDCALL success: 0 - Successful, otherwise failed */
-	test %rax, %rax
-	jnz .Lno_output_struct
-
-	/*
-	 * Since this function can be initiated without an output pointer,
-	 * check if caller provided an output struct before storing
-	 * output registers.
-	 */
-	test %r12, %r12
-	jz .Lno_output_struct
-
-	/* Copy TDCALL result registers to output struct: */
-	movq %rcx, TDX_MODULE_rcx(%r12)
-	movq %rdx, TDX_MODULE_rdx(%r12)
-	movq %r8,  TDX_MODULE_r8(%r12)
-	movq %r9,  TDX_MODULE_r9(%r12)
-	movq %r10, TDX_MODULE_r10(%r12)
-	movq %r11, TDX_MODULE_r11(%r12)
-
-.Lno_output_struct:
-	/* Restore the state of R12 register */
-	pop %r12
-
+	TDX_MODULE_CALL host=0
 	FRAME_END
 	ret
 SYM_FUNC_END(__tdx_module_call)
@@ -184,14 +116,7 @@ SYM_FUNC_END(__tdx_module_call)
  *
  * __tdx_hypercall() function ABI:
  *
- * @type  (RDI)        - TD VMCALL type, moved to R10
- * @fn    (RSI)        - TD VMCALL sub function, moved to R11
- * @r12   (RDX)        - Input parameter 1, moved to R12
- * @r13   (RCX)        - Input parameter 2, moved to R13
- * @r14   (R8)         - Input parameter 3, moved to R14
- * @r15   (R9)         - Input parameter 4, moved to R15
- *
- * @out   (stack)      - struct tdx_hypercall_output pointer (cannot be NULL)
+ * @args  (RDI)        - struct tdx_hypercall_output args
  *
  * On successful completion, return TDCALL status or -EINVAL for invalid
  * inputs.
@@ -199,41 +124,23 @@ SYM_FUNC_END(__tdx_module_call)
 SYM_FUNC_START(__tdx_hypercall)
 	FRAME_BEGIN
 
-	/* Move argument 7 from caller stack to RAX */
-	movq ARG7_SP_OFFSET(%rsp), %rax
-
-	/* Check if caller provided an output struct */
-	test %rax, %rax
-	/* If out pointer is NULL, return -EINVAL */
-	jz .Lret_err
-
 	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
 	push %r15
 	push %r14
 	push %r13
 	push %r12
 
-	/*
-	 * Save output pointer (rax) on the stack, it will be used again
-	 * when storing the output registers after the TDCALL operation.
-	 */
-	push %rax
-
 	/* Mangle function call ABI into TDCALL ABI: */
 	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
 	xor %eax, %eax
-	/* Move TDVMCALL type (standard vs vendor) in R10 */
-	mov %rdi, %r10
-	/* Move TDVMCALL sub function id to R11 */
-	mov %rsi, %r11
-	/* Move input 1 to R12 */
-	mov %rdx, %r12
-	/* Move input 2 to R13 */
-	mov %rcx, %r13
-	/* Move input 3 to R14 */
-	mov %r8,  %r14
-	/* Move input 4 to R15 */
-	mov %r9,  %r15
+
+	/* Copy hypercall registers from arg struct: */
+	movq TDX_HYPERCALL_r10(%rdi), %r10
+	movq TDX_HYPERCALL_r11(%rdi), %r11
+	movq TDX_HYPERCALL_r12(%rdi), %r12
+	movq TDX_HYPERCALL_r13(%rdi), %r13
+	movq TDX_HYPERCALL_r14(%rdi), %r14
+	movq TDX_HYPERCALL_r15(%rdi), %r15
 
 	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
 
@@ -263,16 +170,13 @@ SYM_FUNC_START(__tdx_hypercall)
 .Lskip_sti:
 	tdcall
 
-	/* Restore output pointer to R9 */
-	pop  %r9
-
-	/* Copy hypercall result registers to output struct: */
-	movq %r10, TDX_HYPERCALL_r10(%r9)
-	movq %r11, TDX_HYPERCALL_r11(%r9)
-	movq %r12, TDX_HYPERCALL_r12(%r9)
-	movq %r13, TDX_HYPERCALL_r13(%r9)
-	movq %r14, TDX_HYPERCALL_r14(%r9)
-	movq %r15, TDX_HYPERCALL_r15(%r9)
+	/* Copy hypercall result registers to arg struct: */
+	movq %r10, TDX_HYPERCALL_r10(%rdi)
+	movq %r11, TDX_HYPERCALL_r11(%rdi)
+	movq %r12, TDX_HYPERCALL_r12(%rdi)
+	movq %r13, TDX_HYPERCALL_r13(%rdi)
+	movq %r14, TDX_HYPERCALL_r14(%rdi)
+	movq %r15, TDX_HYPERCALL_r15(%rdi)
 
 	/*
 	 * Zero out registers exposed to the VMM to avoid
@@ -290,10 +194,6 @@ SYM_FUNC_START(__tdx_hypercall)
 	pop %r14
 	pop %r15
 
-	jmp .Lhcall_done
-.Lret_err:
-       movq $-EINVAL, %rax
-.Lhcall_done:
        FRAME_END
 
        retq
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index be5465cb81c3..4924c7a1a002 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -35,36 +35,39 @@ static struct {
  * Wrapper for standard use of __tdx_hypercall with panic report
  * for TDCALL error.
  */
-static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
-				 u64 r15, struct tdx_hypercall_output *out)
+static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 {
-	struct tdx_hypercall_output dummy_out;
-	u64 err;
-
-	/* __tdx_hypercall() does not accept NULL output pointer */
-	if (!out)
-		out = &dummy_out;
-
-	/* Non zero return value indicates buggy TDX module, so panic */
-	err = __tdx_hypercall(TDX_HYPERCALL_STANDARD, fn, r12, r13, r14,
-			      r15, out);
-	if (err)
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = fn,
+		.r12 = r12,
+		.r13 = r13,
+		.r14 = r14,
+		.r15 = r15,
+	};
+
+	if (__tdx_hypercall(&args))
 		panic("Hypercall fn %llu failed (Buggy TDX module!)\n", fn);
 
-	return out->r10;
+	return args.r10;
 }
 
 #ifdef CONFIG_KVM_GUEST
 long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 		       unsigned long p3, unsigned long p4)
 {
-	struct tdx_hypercall_output out;
-
-	/* Non zero return value indicates buggy TDX module, so panic */
-	if (__tdx_hypercall(nr, p1, p2, p3, p4, 0, &out))
+	struct tdx_hypercall_args args = {
+		.r10 = nr,
+		.r11 = p1,
+		.r12 = p2,
+		.r13 = p3,
+		.r14 = p4,
+	};
+
+	if (__tdx_hypercall(&args))
 		panic("KVM hypercall %u failed. Buggy TDX module?\n", nr);
 
-	return out.r10;
+	return args.r10;
 }
 EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
 #endif
@@ -146,7 +149,7 @@ int tdx_hcall_request_gpa_type(phys_addr_t start, phys_addr_t end, bool enc)
 	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
 	 * sec "TDG.VP.VMCALL<MapGPA>"
 	 */
-	ret = _tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0, NULL);
+	ret = _tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0);
 
 	if (ret)
 		ret = -EIO;
@@ -192,8 +195,7 @@ static u64 __cpuidle _tdx_halt(const bool irq_disabled, const bool do_sti)
 	 * whether to call the STI instruction before executing the
 	 * TDCALL instruction.
 	 */
-	return _tdx_hypercall(EXIT_REASON_HLT, irq_disabled, 0, 0,
-			      do_sti, NULL);
+	return _tdx_hypercall(EXIT_REASON_HLT, irq_disabled, 0, 0, do_sti);
 }
 
 static bool tdx_halt(void)
@@ -231,47 +233,65 @@ void __cpuidle tdx_safe_halt(void)
 
 static bool tdx_read_msr(unsigned int msr, u64 *val)
 {
-	struct tdx_hypercall_output out;
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_MSR_READ,
+		.r12 = msr,
+	};
 
 	/*
 	 * Emulate the MSR read via hypercall. More info about ABI
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI), sec titled "TDG.VP.VMCALL<Instruction.RDMSR>".
 	 */
-	if (_tdx_hypercall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out))
-		return false;
+	if (__tdx_hypercall(&args))
+		panic("Hypercall failed (Buggy TDX module!)\n");
 
-	*val = out.r11;
+	if (args.r10)
+		return false;
 
+	*val = args.r11;
 	return true;
 }
 
 static bool tdx_write_msr(unsigned int msr, unsigned int low,
 			       unsigned int high)
 {
-	u64 ret;
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_MSR_WRITE,
+		.r12 = msr,
+		.r13 = (u64)high << 32 | low,
+	};
 
 	/*
 	 * Emulate the MSR write via hypercall. More info about ABI
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI) sec titled "TDG.VP.VMCALL<Instruction.WRMSR>".
 	 */
-	ret = _tdx_hypercall(EXIT_REASON_MSR_WRITE, msr, (u64)high << 32 | low,
-			     0, 0, NULL);
+	if (__tdx_hypercall(&args))
+		panic("Hypercall failed (Buggy TDX module!)\n");
 
-	return ret ? false : true;
+	return args.r10 ? false : true;
 }
 
 static bool tdx_handle_cpuid(struct pt_regs *regs)
 {
-	struct tdx_hypercall_output out;
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_CPUID,
+		.r12 = regs->ax,
+		.r13 = regs->cx,
+	};
 
 	/*
 	 * Emulate the CPUID instruction via a hypercall. More info about
 	 * ABI can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
 	 */
-	if (_tdx_hypercall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out))
+	if (__tdx_hypercall(&args))
+		panic("Hypercall failed (Buggy TDX module!)\n");
+	if (args.r10)
 		return false;
 
 	/*
@@ -279,10 +299,10 @@ static bool tdx_handle_cpuid(struct pt_regs *regs)
 	 * EAX, EBX, ECX, EDX registers after the CPUID instruction execution.
 	 * So copy the register contents back to pt_regs.
 	 */
-	regs->ax = out.r12;
-	regs->bx = out.r13;
-	regs->cx = out.r14;
-	regs->dx = out.r15;
+	regs->ax = args.r12;
+	regs->bx = args.r13;
+	regs->cx = args.r14;
+	regs->dx = args.r15;
 
 	return true;
 }
@@ -290,15 +310,21 @@ static bool tdx_handle_cpuid(struct pt_regs *regs)
 static int tdx_mmio(int size, bool write, unsigned long addr,
 		     unsigned long *val)
 {
-	struct tdx_hypercall_output out;
-	u64 err;
-
-	err = _tdx_hypercall(EXIT_REASON_EPT_VIOLATION, size, write,
-			     addr, *val, &out);
-	if (err)
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_EPT_VIOLATION,
+		.r12 = size,
+		.r13 = write,
+		.r14 = addr,
+		.r15 = *val,
+	};
+
+	if (__tdx_hypercall(&args))
+		panic("Hypercall failed (Buggy TDX module!)\n");
+	if (args.r10)
 		return -EFAULT;
 
-	*val = out.r11;
+	*val = args.r11;
 	return 0;
 }
 
@@ -402,8 +428,11 @@ static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
  */
 static bool tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
 {
-	struct tdx_hypercall_output out;
-	int size, port, ret;
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_IO_INSTRUCTION,
+	};
+	int size, port;
 	u64 mask;
 	bool in;
 
@@ -415,20 +444,25 @@ static bool tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
 	port = VE_GET_PORT_NUM(exit_qual);
 	mask = GENMASK(BITS_PER_BYTE * size, 0);
 
+	args.r12 = size;
+	args.r13 = !in;
+	args.r14 = port;
+	args.r15 = in ? 0 : regs->ax;
+
 	/*
 	 * Emulate the I/O read/write via hypercall. More info about
 	 * ABI can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI) sec titled "TDG.VP.VMCALL<Instruction.IO>".
 	 */
-	ret = _tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, !in, port,
-			     in ? 0 : regs->ax, &out);
+	if (__tdx_hypercall(&args))
+		panic("Hypercall failed (Buggy TDX module!)\n");
 	if (!in)
-		return !ret;
+		return !args.r10;
 
 	regs->ax &= ~mask;
-	regs->ax |= ret ? UINT_MAX : out.r11 & mask;
+	regs->ax |= args.r10 ? UINT_MAX : args.r11 & mask;
 
-	return !ret;
+	return !args.r10;
 }
 
 /*
diff --git a/arch/x86/kernel/tdxcall.S b/arch/x86/kernel/tdxcall.S
new file mode 100644
index 000000000000..ba5e8e35de36
--- /dev/null
+++ b/arch/x86/kernel/tdxcall.S
@@ -0,0 +1,76 @@
+#include <asm/asm-offsets.h>
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
