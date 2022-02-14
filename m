Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936714B58AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245174AbiBNRi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:38:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiBNRiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:38:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F236542D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:38:46 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A804C1EC0682;
        Mon, 14 Feb 2022 18:38:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644860320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4Gr0SURmMCE7KOMS1VEZfc7NkaYBC49cdAF8vf923yE=;
        b=RLh+s4kZtNXzEZ8FKzlnriaMn3En2LIMz1GVDXeXXD693zA/zwhEZvJ7o75hzqA//M4rcB
        +8FPgEvTjpfa7vDlmrILUC7s6Nl7KybYHt6rCwVd6gYkLeIsPvMYTVH7FM7VbcWeoOoM4E
        VriEj4+ONQL1qAz6C1FJXOCDwN00rl8=
Date:   Mon, 14 Feb 2022 18:38:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        antonio.gomez.iglesias@linux.intel.com, neelima.krishnan@intel.com
Subject: Re: [PATCH] x86/tsx: Use MSR_TSX_CTRL to clear CPUID bits
Message-ID: <YgqToxbGQluNHABF@zn.tnic>
References: <5bd785a1d6ea0b572250add0c6617b4504bc24d1.1644440311.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5bd785a1d6ea0b572250add0c6617b4504bc24d1.1644440311.git.pawan.kumar.gupta@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 01:04:36PM -0800, Pawan Gupta wrote:
> tsx_clear_cpuid() uses MSR_TSX_FORCE_ABORT to clear CPUID.RTM and
> CPUID.HLE. Not all CPUs support MSR_TSX_FORCE_ABORT, alternatively use
> MSR_IA32_TSX_CTRL when supported.
> 
> Fixes: 293649307ef9 ("x86/tsx: Clear CPUID bits when TSX always force aborts")
> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

<--- I'm assuming this needs to be

Cc: <stable@vger.kernel.org>

?

> @@ -106,13 +110,11 @@ void __init tsx_init(void)
>  	int ret;
>  
>  	/*
> -	 * Hardware will always abort a TSX transaction if both CPUID bits
> -	 * RTM_ALWAYS_ABORT and TSX_FORCE_ABORT are set. In this case, it is
> -	 * better not to enumerate CPUID.RTM and CPUID.HLE bits. Clear them
> -	 * here.
> +	 * Hardware will always abort a TSX transaction when CPUID
> +	 * RTM_ALWAYS_ABORT is set. In this case, it is better not to enumerate
> +	 * CPUID.RTM and CPUID.HLE bits. Clear them here.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT) &&
> -	    boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
> +	if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT)) {

So you test here X86_FEATURE_RTM_ALWAYS_ABORT and tsx_clear_cpuid()
tests it again. Simplify I guess.

>  		tsx_ctrl_state = TSX_CTRL_RTM_ALWAYS_ABORT;
>  		tsx_clear_cpuid();
>  		setup_clear_cpu_cap(X86_FEATURE_RTM);

Also, here you clear X86_FEATURE_RTM and X86_FEATURE_HLE but the other
caller of tsx_clear_cpuid() - init_intel() - doesn't clear those bits.
Why?

IOW, can we concentrate the whole tsx_clear_cpuid() logic inside it and
have callers only call it unconditionally. Then the decision whether
to disable TSX and clear bits will happen all solely in that function
instead of being spread around the boot code and being inconsistent.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
