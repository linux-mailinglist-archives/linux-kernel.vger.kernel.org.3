Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63CF4D4D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiCJPcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiCJPb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:31:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E79515A216
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:30:56 -0800 (PST)
Received: from zn.tnic (p200300ea97193878846c1e519efb88e1.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3878:846c:1e51:9efb:88e1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C743D1EC066E;
        Thu, 10 Mar 2022 16:30:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646926250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K88FIo99fFYXfUo0jhgVytRPii2bxFdduXw7N/+cIkw=;
        b=nxVwfjY7ccY/uJh7UJ1vxSYqDBakLSBc9JTINTABRtHMj5BuTW1jMZ81Cs3w2/QA2xgadc
        IS74NIGxAxxpRkwPByuQPnCrYaty3rQVfUvrMfmH1fANglESMQJ7AdOy5yME2RLsC5cLKD
        DV8OQs/M0QsHsUl5mAwfFXJMWRekVTU=
Date:   Thu, 10 Mar 2022 16:30:57 +0100
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
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 03/30] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <YioZnTYahkoy2Mxz@zn.tnic>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220302142806.51844-4-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 05:27:39PM +0300, Kirill A. Shutemov wrote:
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
> layer -- TDX module -- facilitates secure communication between the host
> and the guest. TDX module is loaded like a firmware into a special CPU
> mode called SEAM. TDX guests communicate with the TDX module using the
> TDCALL instruction.
> 
> A guest uses TDCALL to communicate with both the TDX module and VMM.
> The value of the RAX register when executing the TDCALL instruction is
> used to determine the TDCALL type. A variant of TDCALL used to communicate
> with the VMM is called TDVMCALL.
> 
> Add generic interfaces to communicate with the TDX module and VMM
> (using the TDCALL instruction).
> 
> __tdx_hypercall()    - Used by the guest to request services from the
> 		       VMM (via TDVMCALL).
> __tdx_module_call()  - Used to communicate with the TDX module (via
> 		       TDCALL).

Ok, you need to fix this: this sounds to me like there are two insns:
TDCALL and TDVMCALL. But there's only TDCALL.

And I'm not even clear on how the differentiation is done - I guess
with %r11 which contains the VMCALL subfunction number in the
__tdx_hypercall() case but I'm not sure.

And when explaining this, pls put it in the comment over the function so
that it is clear how the distinction is made.

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
> Based on previous patch by Sean Christopherson.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/Makefile        |   2 +-
>  arch/x86/coco/tdcall.S        | 188 ++++++++++++++++++++++++++++++++++
>  arch/x86/coco/tdx.c           |  18 ++++

Those should be

arch/x86/coco/tdx/tdcall.S
arch/x86/coco/tdx/tdx.c

like we said:

"- confidential computing guest stuff: arch/x86/coco/{sev,tdx}"

>  arch/x86/include/asm/tdx.h    |  27 +++++
>  arch/x86/kernel/asm-offsets.c |  10 ++
>  5 files changed, 244 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/coco/tdcall.S

...

> +SYM_FUNC_START(__tdx_hypercall)
> +	FRAME_BEGIN
> +
> +	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
> +	push %r15
> +	push %r14
> +	push %r13
> +	push %r12
> +
> +	/* Mangle function call ABI into TDCALL ABI: */
> +	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
> +	xor %eax, %eax
> +
> +	/* Copy hypercall registers from arg struct: */
> +	movq TDX_HYPERCALL_r10(%rdi), %r10
> +	movq TDX_HYPERCALL_r11(%rdi), %r11
> +	movq TDX_HYPERCALL_r12(%rdi), %r12
> +	movq TDX_HYPERCALL_r13(%rdi), %r13
> +	movq TDX_HYPERCALL_r14(%rdi), %r14
> +	movq TDX_HYPERCALL_r15(%rdi), %r15
> +
> +	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
> +
> +	tdcall
> +
> +	/*
> +	 * RAX==0 indicates a failure of the TDVMCALL mechanism itself and that
> +	 * something has gone horribly wrong with the TDX module.
> +	 *
> +	 * The return status of the hypercall operation is in a separate
> +	 * register (in R10). Hypercall errors are a part of normal operation
> +	 * and are handled by callers.
> +	 */
> +	testq %rax, %rax
> +	jne .Lpanic

Hm, can this call a C function which does the panic so that a proper
error message is dumped to the user so that at least she knows where the
panic comes from?

> +
> +	/* TDVMCALL leaf return code is in R10 */
> +	movq %r10, %rax
> +
> +	/* Copy hypercall result registers to arg struct if needed */
> +	testq $TDX_HCALL_HAS_OUTPUT, %rsi
> +	jz .Lout
> +
> +	movq %r10, TDX_HYPERCALL_r10(%rdi)
> +	movq %r11, TDX_HYPERCALL_r11(%rdi)
> +	movq %r12, TDX_HYPERCALL_r12(%rdi)
> +	movq %r13, TDX_HYPERCALL_r13(%rdi)
> +	movq %r14, TDX_HYPERCALL_r14(%rdi)
> +	movq %r15, TDX_HYPERCALL_r15(%rdi)
> +.Lout:
> +	/*
> +	 * Zero out registers exposed to the VMM to avoid speculative execution
> +	 * with VMM-controlled values. This needs to include all registers
> +	 * present in TDVMCALL_EXPOSE_REGS_MASK (except R12-R15). R12-R15
> +	 * context will be restored.
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
> +	FRAME_END
> +
> +	retq
> +.Lpanic:
> +	ud2
> +SYM_FUNC_END(__tdx_hypercall)

...

> diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
> index 7dca52f5cfc6..0b465e7d0a2f 100644
> --- a/arch/x86/kernel/asm-offsets.c
> +++ b/arch/x86/kernel/asm-offsets.c
> @@ -74,6 +74,16 @@ static void __used common(void)
>  	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
>  	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST

Those have ifdeffery around them - why don't the TDX_MODULE_* ones need
it too?

> +	BLANK();
> +	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_args, r10);
> +	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_args, r11);
> +	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_args, r12);
> +	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_args, r13);
> +	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_args, r14);
> +	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_args, r15);
> +#endif
> +

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
