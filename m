Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79A4A6E63
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245718AbiBBKJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:09:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235899AbiBBKJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:09:47 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26F631EC0518;
        Wed,  2 Feb 2022 11:09:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643796582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=M4VktWFFIKUJAt6FYwzKVXHa8pwQPqrvJ0IYPtJZfc8=;
        b=AbVsopQoa+KuH7xDGyom3d9zV7bGF11SEBS8qs907+enlvk/uGaq3Y+US1sexL4p3DcFb1
        d39UkYf/vGxkv5L7ruZFA4U2uGlHfezt/7FHeOUjfLHaIshcNz1vBYTs7I17THmnxhIFIa
        861Dh+YUCq5+9JY37CQKYOWPi/4j80c=
Date:   Wed, 2 Feb 2022 11:09:37 +0100
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
Subject: Re: [PATCHv2 14/29] x86/tdx: Early boot handling of port I/O
Message-ID: <YfpYYdD2Fsw9TlqO@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-15-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124150215.36893-15-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:02:00PM +0300, Kirill A. Shutemov wrote:
> Subject: Re: [PATCHv2 14/29] x86/tdx: Early boot handling of port I/O

The condensed patch description in the subject line should start with a
uppercase letter and should be written in imperative tone:

	... Handle early boot port I/O

or so.

> From: Andi Kleen <ak@linux.intel.com>
> 
> TDX guests cannot do port I/O directly. The TDX module triggers a #VE
> exception to let the guest kernel emulate port I/O, by converting them

s/,//

> into TDCALLs to call the host.
> 
> But before IDT handlers are set up, port I/O cannot be emulated using
> normal kernel #VE handlers. To support the #VE-based emulation during
> this boot window, add a minimal early #VE handler support in early
> exception handlers. This is similar to what AMD SEV does. This is
> mainly to support earlyprintk's serial driver, as well as potentially
> the VGA driver (although it is expected not to be used).

expectations, shmexpectations...

...

> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 1cb6346ec3d1..76d298ddfe75 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -417,6 +417,9 @@ void __init do_early_exception(struct pt_regs *regs, int trapnr)
>  	    trapnr == X86_TRAP_VC && handle_vc_boot_ghcb(regs))
>  		return;
>  


	if (IS_ENABLED(CONFIG_INTEL_TDX_GUEST)) &&

> +	if (trapnr == X86_TRAP_VE && tdx_early_handle_ve(regs))
> +		return;
> +
>  	early_fixup_exception(regs, trapnr);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
