Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49B3480CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 20:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhL1TIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 14:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbhL1TIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 14:08:52 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7D5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 11:08:52 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3EE4A1EC0104;
        Tue, 28 Dec 2021 20:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640718526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ovjkI8HukVtVxXYRgLNgI+6D9nV1/6tdSSgCHMx4n28=;
        b=dQTIYHyQ9wnhFGT/1A10MgJpk24EufhuqG+f4T2d4Ymfp4RCWt8KJ1LdsQkhSmQ3DdiPhH
        vIMJ9XUzwfR2hGUnkeZ7EdID/XwqoEgCBy5wd/7fBqUPReY9iN17Ho0Fkbe2YmLFDK3Ph3
        GrDzl/dBDImos5+yp/716CDfBVrecQQ=
Date:   Tue, 28 Dec 2021 20:08:49 +0100
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
Subject: Re: [PATCH 05/26] x86/tdx: Add HLT support for TDX guests (#VE
 approach)
Message-ID: <YctgwcozwHpzk81+@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214150304.62613-6-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:02:43PM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index e9ee8b526319..273e4266b2c1 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -46,6 +46,7 @@
>  #include <asm/proto.h>
>  #include <asm/frame.h>
>  #include <asm/unwind.h>
> +#include <asm/tdx.h>
>  
>  #include "process.h"
>  
> @@ -864,6 +865,12 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
>  	if (x86_idle || boot_option_idle_override == IDLE_POLL)
>  		return;
>  
> +	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> +		x86_idle = tdx_guest_idle;
> +		pr_info("using TDX aware idle routine\n");
> +		return;
> +	}

Why isn't this part of the following if-else if-else if... noodle?

> +
>  	if (boot_cpu_has_bug(X86_BUG_AMD_E400)) {
>  		pr_info("using AMD E400 aware idle routine\n");
>  		x86_idle = amd_e400_idle;

This one starting here: ^^^^

> diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
> index ee52dde01b24..e19187048be8 100644
> --- a/arch/x86/kernel/tdcall.S
> +++ b/arch/x86/kernel/tdcall.S
> @@ -3,6 +3,7 @@
>  #include <asm/asm.h>
>  #include <asm/frame.h>
>  #include <asm/unwind_hints.h>
> +#include <uapi/asm/vmx.h>
>  
>  #include <linux/linkage.h>
>  #include <linux/bits.h>
> @@ -39,6 +40,13 @@
>   */
>  #define tdcall .byte 0x66,0x0f,0x01,0xcc
>  
> +/*
> + * Used in the __tdx_hypercall() function to test R15 register content
> + * and optionally include the STI instruction before the TDCALL
> + * instruction (for EXIT_REASON_HLT case).

"Used in __tdx_hypercall() to determine whether to enable interrupts
before issuing TDCALL for the EXIT_REASON_HLT case."

Plain and simple.

> + */
> +#define do_sti	0x01

#define ENABLE_IRQS_BEFORE_HLT	0x01

and when you call it that, you don't even need the comment above it
because the name is self-explanatory.

> +
>  /*
>   * __tdx_module_call()  - Used by TDX guests to request services from
>   * the TDX module (does not include VMM services).
> @@ -231,6 +239,30 @@ SYM_FUNC_START(__tdx_hypercall)
>  
>  	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>  
> +	/*
> +	 * For the idle loop STI needs to be called directly before
> +	 * the TDCALL that enters idle (EXIT_REASON_HLT case). STI
> +	 * instruction enables interrupts only one instruction later.
> +	 * If there is a window between STI and the instruction that
> +	 * emulates the HALT state, there is a chance for interrupts to
> +	 * happen in this window, which can delay the HLT operation
> +	 * indefinitely. Since this is the not the desired result, add
> +	 * support to conditionally call STI before TDCALL.

"add support"?

> +	 *
> +	 * Since STI instruction is only required for the idle case
> +	 * (a special case of EXIT_REASON_HLT), use the r15 register
> +	 * value to identify it. Since the R15 register is not used
> +	 * by the VMM as per EXIT_REASON_HLT ABI, re-use it in
> +	 * software to identify the STI case.
> +	 */
> +	cmpl $EXIT_REASON_HLT, %r11d
> +	jne skip_sti
> +	cmpl $do_sti, %r15d
> +	jne skip_sti
> +	/* Set R15 register to 0, it is unused in EXIT_REASON_HLT case */
> +	xor %r15, %r15
> +	sti
> +skip_sti:

.Lskip_sti:

>  	tdcall
>  
>  	/* Restore output pointer to R9 */
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index b6d0e45e6589..6749ca3b2e3d 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/cpufeature.h>
>  #include <asm/tdx.h>
> +#include <asm/vmx.h>
>  
>  /* TDX Module Call Leaf IDs */
>  #define TDX_GET_VEINFO			3

...

> +void __cpuidle tdx_guest_idle(void)
> +{
> +	tdx_safe_halt();
> +}

That wrapper looks useless...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
