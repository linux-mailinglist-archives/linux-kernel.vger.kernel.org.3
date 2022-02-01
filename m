Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6754A653F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiBAT7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:59:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41286 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiBAT7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:59:01 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643745540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klPixv6/72wnTPtFYXz1v5gh5a58fePNQYPjDZleMIE=;
        b=OA5gr6otPC8nfYbW7xx25hTsjLGF1qkQsLb++dHpp6qeM8kYiyPxU5I+CgAutuD1trD18+
        gdfwdWUfVqn5eBVZgt1gJTFvmyataqBfunk+HHYh0SKMdV/Kvx3URUViT9K+o3ASm2xrsr
        /dhkQB52cyCSUhe2fQKEOOI5Jbspn3YK1BEIwv1NiZ6S90RAuNOxCHjmdQ0kZsBsejHEwn
        DD8rD92tmqfcEfx5T2DzCFolxrlzqekWu7sApxdTdjvpXQHx3H99mrUUOEXlZ8jkanazb/
        est0nWouI/t3JxzydJqTnWIuE607k6ZvIvA9NTrIlGk0YiVgghSL0xbFK3XVcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643745540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klPixv6/72wnTPtFYXz1v5gh5a58fePNQYPjDZleMIE=;
        b=dTM5/GV0vzYtNLkS10p3HpzdIfrX6HqxRcO8tKhUINyiYMk+Yf/IWeKjnu1hlvU/Gcb/x7
        pCsX2VohIUfszfCQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Kai Huang <kai.huang@linux.intel.com>
Subject: Re: [PATCHv2 03/29] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
In-Reply-To: <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
Date:   Tue, 01 Feb 2022 20:58:59 +0100
Message-ID: <87a6faz7cs.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill,

On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -8,11 +8,51 @@
>  #define TDX_CPUID_LEAF_ID	0x21
>  #define TDX_IDENT		"IntelTDX    "
>  
> +#define TDX_HYPERCALL_STANDARD  0
> +
> +/*
> + * Used in __tdx_module_call() to gather the output registers'
> + * values of the TDCALL instruction when requesting services from
> + * the TDX module. This is a software only structure and not part
> + * of the TDX module/VMM ABI
> + */
> +struct tdx_module_output {
> +	u64 rcx;
> +	u64 rdx;
> +	u64 r8;
> +	u64 r9;
> +	u64 r10;
> +	u64 r11;
> +};

I've seen exactly the same struct named seamcall_regs_out in the TDX
host series. I assume that's not coincidence which begs the question why
this is required twice with different names.

> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	BLANK();
> +	/* Offset for fields in tdx_module_output */
> +	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
> +	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
> +	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
> +	OFFSET(TDX_MODULE_r9,  tdx_module_output, r9);
> +	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
> +	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);

Which obviously duplicates the above part as well.

> + *-------------------------------------------------------------------------
> + * TDCALL ABI:
> + *-------------------------------------------------------------------------
> + * Input Registers:
> + *
> + * RAX                 - TDCALL Leaf number.
> + * RCX,RDX,R8-R9       - TDCALL Leaf specific input registers.
> + *
> + * Output Registers:
> + *
> + * RAX                 - TDCALL instruction error code.
> + * RCX,RDX,R8-R11      - TDCALL Leaf specific output registers.
> + *
> + *-------------------------------------------------------------------------
> + *
> + * __tdx_module_call() function ABI:
> + *
> + * @fn  (RDI)          - TDCALL Leaf ID,    moved to RAX
> + * @rcx (RSI)          - Input parameter 1, moved to RCX
> + * @rdx (RDX)          - Input parameter 2, moved to RDX
> + * @r8  (RCX)          - Input parameter 3, moved to R8
> + * @r9  (R8)           - Input parameter 4, moved to R9
> + *
> + * @out (R9)           - struct tdx_module_output pointer
> + *                       stored temporarily in R12 (not
> + *                       shared with the TDX module). It
> + *                       can be NULL.
> + *
> + * Return status of TDCALL via RAX.
> + */

And unsurprisingly this function and __seamcall of the other patch set
are very similar aside of the calling convention (__seamcall has a
struct for the input parameters) and the obvious difference that one
issues TDCALL and the other SEAMCALL.

So can we please have _one_ implementation and the same struct(s) for
the module call which is exactly the same for host and guest except for
the instruction used.

IOW, this begs a macro implementation

.macro TDX_MODULE_CALL host:req

       ....

        .if \host
        seamcall
        .else
	tdcall
        .endif

       ....

So the actual functions become:

SYM_FUNC_START(__tdx_module_call)
        FRAME_BEGIN
        TDX_MODULE_CALL host=0
        FRAME_END
        ret
SYM_FUNC_END(__tdx_module_call)

SYM_FUNC_START(__tdx_seam_call)
        FRAME_BEGIN
        TDX_MODULE_CALL host=1
        FRAME_END
        ret
SYM_FUNC_END(__tdx_seam_call)

Hmm?

> +/*
> + * Wrapper for standard use of __tdx_hypercall with panic report
> + * for TDCALL error.
> + */
> +static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
> +				 u64 r15, struct tdx_hypercall_output
> *out)

This begs the question whether having a struct hypercall_input similar
to the way how seamcall input parameters are implemented makes more
sense than 7 function arguments. Hmm?

Thanks,

        tglx
