Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D684DBB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbiCPXfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiCPXfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:35:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB189AE63
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:34:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647473639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2GryFkB1dgZgZSqpGGOfeLWHK3kOlc0ZY6tliFW5tjY=;
        b=i9UXGI5zY+83qU3gwG/iOxk8bfzzANkyE4w3tEYZ6ICEEFBdQK/qrMzWmYuzSn9UHsFqEW
        qqaiPCWbHfUX8gmTR0271NXFdmV2y3EWxFC/l2l/Jka2xfqB/VRtPM1BcAl7SB1DfNf2pI
        Zftqi+qnEMSGqukOkG/c2YGMw2/8V1cyT/tDtOz+t85HrUripQTQldJBF45X9bEofw8uV0
        Jy+zRuLHtqd3eJhKKqpTbGW91BY66xT4g/RvZXLc7C57MiMLxxAjQkZvaLFRfomqgS4Yyc
        7lXqKZuUh8/RspguVQuA9nsnNj5LJT360Rl7BjUrbRtl9XouVUd8KhNKW6YFvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647473639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2GryFkB1dgZgZSqpGGOfeLWHK3kOlc0ZY6tliFW5tjY=;
        b=mI4a7x9aOuphAbMwIQSw6y/Ay0HsSNJoqqrzWxxF2vO8hN/D5pw24Qev1PfP7HcHp4gEWM
        8B/N2R3q+i9kdlAg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 02/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
In-Reply-To: <20220316020856.24435-3-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-3-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 00:33:58 +0100
Message-ID: <87lex9321l.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirrill,

On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> Define an assembly macro that can be used to implement C wrapper for
> both TDCALL and SEAMCALL.
>

> TDCALL wrapper will be implemented using the macro later in the series.
> SEAMCALL wrapper is out-of-scope for the series and will be implemented
> as part of TDX host enabling.

This paragraph makes no sense in the changelog once it's merged. That's
a reviewer/maintainer info which wants to be below the ---

> +/*
> + * TDX_MODULE_CALL - common helper macro for both
> + *                 TDCALL and SEAMCALL instructions.
> + *
> + * TDCALL   - used by TDX guests to make requests to the
> + *            TDX module and hypercalls to the VMM.
> + * SEAMCALL - used by TDX hosts to make requests to the
> + *            TDX module.
> + *
> + * Both instruction are supported in Binutils >= 2.36.
> + */
> +#define tdcall		.byte 0x66,0x0f,0x01,0xcc
> +#define seamcall	.byte 0x66,0x0f,0x01,0xcf

Bah. I really hate this #define glue. The comment documents
TDX_MODULE_CALL. The defines for the instructions are a seperate
problem. So please move them above the whole thing with their own
comment.

> +.macro TDX_MODULE_CALL host:req
> +	/*
> +	 * R12 will be used as temporary storage for struct tdx_module_output
> +	 * pointer. Since R12-R15 registers are not used by TDCALL/SEAMCALL
> +	 * services supported by this function, it can be reused.
> +	 */
> +
> +	/* Callee saved, so preserve it */
> +	push %r12
> +
> +	/*
> +	 * Push output pointer to stack.
> +	 * After the operation, it will be fetched into R12 register.
> +	 */
> +	push %r9
> +
> +	/* Mangle function call ABI into TDCALL/SEAMCALL ABI: */
> +	/* Move Leaf ID to RAX */
> +	mov %rdi, %rax
> +	/* Move input 4 to R9 */
> +	mov %r8,  %r9
> +	/* Move input 3 to R8 */
> +	mov %rcx, %r8
> +	/* Move input 1 to RCX */
> +	mov %rsi, %rcx
> +	/* Leave input param 2 in RDX */
> +
> +	.if \host
> +	seamcall
> +	/*
> +	 * SEAMCALL instruction is essentially a VMExit from VMX root
> +	 * mode to SEAM VMX root mode.  VMfailInvalid (CF=1) indicates
> +	 * that the targeted SEAM firmware is not loaded or disabled,
> +	 * or P-SEAMLDR is busy with another SEAMCALL.  %rax is not
> +	 * changed in this case.
> +	 *
> +	 * Set %rax to TDX_SEAMCALL_VMFAILINVALID for VMfailInvalid.
> +	 * This value will never be used as actual SEAMCALL error code as
> +	 * it is from the Reserved status code class.
> +	 */
> +	jnc .Lno_vmfailinvalid
> +	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
> +.Lno_vmfailinvalid:

Please add a new line between the label and the .else for readability sake.

> +	.else
> +	tdcall
> +	.endif
> +
> +	/*
> +	 * Fetch output pointer from stack to R12 (It is used
> +	 * as temporary storage)
> +	 */
> +	pop %r12
> +
> +	/*
> +	 * Since this function can be initiated without an output pointer,
> +	 * check if caller provided an output struct before storing output
> +	 * registers.

The function is a macro. It's not initiated, it's invoked. It always has
an output pointer in R12, but that can be NULL.

With those nitpicks addressed:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
