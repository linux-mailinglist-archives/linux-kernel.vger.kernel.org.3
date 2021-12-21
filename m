Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3517947C735
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbhLUTLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhLUTLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:11:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0339CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 11:11:49 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58B8B1EC018B;
        Tue, 21 Dec 2021 20:11:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640113903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jt0+pyVNcbqJET3sKvMLCK6HDBrf04h9+iyir1szM+A=;
        b=qp8YIeh56x2qtLNpnrQ152/mxSLR3oDrNvYXaYDnt4nAnCqzR5nyVPT/Xgn7qP5dP08Fhm
        u1NtibSJy03pBETJ0CmfPjPO8Wk16dq9z7zTh2tI4MLLQu5WFyHSfmE6aHjHpbxgiIUkhf
        Gg2HigG4wdXrkQ5Z+WBDV2Al0qPb6CA=
Date:   Tue, 21 Dec 2021 20:11:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/26] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <YcIm8fngUsVulUoI@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211214150304.62613-4-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:02:41PM +0300, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Guests communicate with VMMs with hypercalls. Historically, these
> are implemented using instructions that are known to cause VMEXITs
> like VMCALL, VMLAUNCH, etc. However, with TDX, VMEXITs no longer
> expose the guest state to the host. This prevents the old hypercall
> mechanisms from working. So, to communicate with VMM, TDX
> specification defines a new instruction called TDCALL.
> 
> In a TDX based VM, since the VMM is an untrusted entity, an intermediary
> layer (TDX module) exists in the CPU to facilitate secure communication

in the CPU?!

I think you wanna say, "it is loaded like a firmware into a special CPU
mode called SEAM..." or so.

> between the host and the guest. TDX guests communicate with the TDX module
> using the TDCALL instruction.
> 
> A guest uses TDCALL to communicate with both the TDX module and VMM.
> The value of the RAX register when executing the TDCALL instruction is
> used to determine the TDCALL type. A variant of TDCALL used to communicate
> with the VMM is called TDVMCALL.
> 
> Add generic interfaces to communicate with the TDX Module and VMM

"module"

> (using the TDCALL instruction).
> 
> __tdx_hypercall()    - Used by the guest to request services from the
> 		       VMM (via TDVMCALL).
> __tdx_module_call()  - Used to communicate with the TDX Module (via
> 		       TDCALL).

"module". No need to capitalize every word like in CPU manuals.

> 
> Also define an additional wrapper _tdx_hypercall(), which adds error
> handling support for the TDCALL failure.
> 
> The __tdx_module_call() and __tdx_hypercall() helper functions are
> implemented in assembly in a .S file.  The TDCALL ABI requires
> shuffling arguments in and out of registers, which proved to be
> awkward with inline assembly.
> 
> Just like syscalls, not all TDVMCALL use cases need to use the same
> number of argument registers. The implementation here picks the current
> worst-case scenario for TDCALL (4 registers). For TDCALLs with fewer
> than 4 arguments, there will end up being a few superfluous (cheap)
> instructions. But, this approach maximizes code reuse.
> 
> For registers used by the TDCALL instruction, please check TDX GHCI
> specification, the section titled "TDCALL instruction" and "TDG.VP.VMCALL
> Interface".
> 
> https://www.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface-1.0-344426-002.pdf
> 
> Originally-by: Sean Christopherson <seanjc@google.com>

Just state that in free text in the commit message:

"Based on a previous patch by Sean... "

...

> +	/*
> +	 * Since this function can be initiated without an output pointer,
> +	 * check if caller provided an output struct before storing
> +	 * output registers.
> +	 */
> +	test %r12, %r12
> +	jz mcall_done

All those local label names need to be prefixed with .L so that they
don't appear in the vmlinux symbol table unnecessarily:

	jz .Lno_output_struct
> +
> +	/* Copy TDCALL result registers to output struct: */
> +	movq %rcx, TDX_MODULE_rcx(%r12)
> +	movq %rdx, TDX_MODULE_rdx(%r12)
> +	movq %r8,  TDX_MODULE_r8(%r12)
> +	movq %r9,  TDX_MODULE_r9(%r12)
> +	movq %r10, TDX_MODULE_r10(%r12)
> +	movq %r11, TDX_MODULE_r11(%r12)
> +
> +mcall_done:

.Lno_output_struct:

Ditto below.

> +	/* Restore the state of R12 register */
> +	pop %r12
> +
> +	FRAME_END
> +	ret
> +SYM_FUNC_END(__tdx_module_call)
> +
> +/*
> + * __tdx_hypercall() - Make hypercalls to a TDX VMM.
> + *
> + * Transforms function call register arguments into the TDCALL
> + * register ABI.  After TDCALL operation, VMM output is saved in @out.
> + *
> + *-------------------------------------------------------------------------
> + * TD VMCALL ABI:
> + *-------------------------------------------------------------------------
> + *
> + * Input Registers:
> + *
> + * RAX                 - TDCALL instruction leaf number (0 - TDG.VP.VMCALL)
> + * RCX                 - BITMAP which controls which part of TD Guest GPR
> + *                       is passed as-is to the VMM and back.
> + * R10                 - Set 0 to indicate TDCALL follows standard TDX ABI
> + *                       specification. Non zero value indicates vendor
> + *                       specific ABI.
> + * R11                 - VMCALL sub function number
> + * RBX, RBP, RDI, RSI  - Used to pass VMCALL sub function specific arguments.
> + * R8-R9, R12–R15      - Same as above.
		^

massage_diff: Warning: Unicode char [–] (0x2013) in line: + * R8-R9, R12–R15      - Same as above.

All those other '-' are char 0x2d but this one has probably happened due
to copy-paste or whatnot. The second time I see UTF-8 chars in a patch
today.

> +SYM_FUNC_START(__tdx_hypercall)
> +	FRAME_BEGIN
> +
> +	/* Move argument 7 from caller stack to RAX */
> +	movq ARG7_SP_OFFSET(%rsp), %rax
> +
> +	/* Check if caller provided an output struct */
> +	test %rax, %rax
> +	/* If out pointer is NULL, return -EINVAL */
> +	jz ret_err
> +
> +	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
> +	push %r15
> +	push %r14
> +	push %r13
> +	push %r12
> +
> +	/*
> +	 * Save output pointer (rax) in stack, it will be used

"... on the stack... "

> +	 * again when storing the output registers after the
> +	 * TDCALL operation.
> +	 */
> +	push %rax
> +
> +	/* Mangle function call ABI into TDCALL ABI: */
> +	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
> +	xor %eax, %eax
> +	/* Move TDVMCALL type (standard vs vendor) in R10 */
> +	mov %rdi, %r10
> +	/* Move TDVMCALL sub function id to R11 */
> +	mov %rsi, %r11
> +	/* Move input 1 to R12 */
> +	mov %rdx, %r12
> +	/* Move input 2 to R13 */
> +	mov %rcx, %r13
> +	/* Move input 3 to R14 */
> +	mov %r8,  %r14
> +	/* Move input 4 to R15 */
> +	mov %r9,  %r15
> +
> +	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
> +
> +	tdcall
> +
> +	/* Restore output pointer to R9 */
> +	pop  %r9
> +
> +	/* Copy hypercall result registers to output struct: */
> +	movq %r10, TDX_HYPERCALL_r10(%r9)
> +	movq %r11, TDX_HYPERCALL_r11(%r9)
> +	movq %r12, TDX_HYPERCALL_r12(%r9)
> +	movq %r13, TDX_HYPERCALL_r13(%r9)
> +	movq %r14, TDX_HYPERCALL_r14(%r9)
> +	movq %r15, TDX_HYPERCALL_r15(%r9)
> +
> +	/*
> +	 * Zero out registers exposed to the VMM to avoid
> +	 * speculative execution with VMM-controlled values.
> +	 * This needs to include all registers present in
> +	 * TDVMCALL_EXPOSE_REGS_MASK (except R12-R15).
> +	 * R12-R15 context will be restored.
> +	 */
> +	xor %r10d, %r10d
> +	xor %r11d, %r11d
> +
> +	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
> +	pop %r12
> +	pop %r13
> +	pop %r14
> +	pop %r15
> +
> +	jmp hcall_done
> +ret_err:
> +       movq $(-EINVAL), %rax

What are the brackets for?

> +hcall_done:
> +       FRAME_END
> +
> +       retq
> +SYM_FUNC_END(__tdx_hypercall)
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index d32d9d9946d8..1cc850fd03ff 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -9,6 +9,30 @@
>  
>  static bool tdx_guest_detected __ro_after_init;
>  
> +/*
> + * Wrapper for standard use of __tdx_hypercall with panic report
> + * for TDCALL error.
> + */
> +static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
> +				 u64 r15, struct tdx_hypercall_output *out)
> +{
> +	struct tdx_hypercall_output dummy_out;
> +	u64 err;
> +
> +	/* __tdx_hypercall() does not accept NULL output pointer */
> +	if (!out)
> +		out = &dummy_out;
> +
> +	err = __tdx_hypercall(TDX_HYPERCALL_STANDARD, fn, r12, r13, r14,
> +			      r15, out);
> +
> +	/* Non zero return value indicates buggy TDX module, so panic */
> +	if (err)
> +		panic("Hypercall fn %llu failed (Buggy TDX module!)\n", fn);

Use a standard formatted pattern pls:

        /* Non zero return value indicates buggy TDX module, so panic */
        err = __tdx_hypercall(TDX_HYPERCALL_STANDARD, fn, r12, r13, r14, r15, out);
        if (err)              
                panic("Hypercall fn %llu failed (Buggy TDX module!)\n", fn);


> +
> +	return out->r10;
> +}
> +
>  bool is_tdx_guest(void)
>  {
>  	return tdx_guest_detected;
> -- 
> 2.32.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
