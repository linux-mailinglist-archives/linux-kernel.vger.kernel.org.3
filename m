Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679254B7A36
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbiBOWJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:09:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBOWJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:09:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A150237FF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:08:50 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 666AE1EC054C;
        Tue, 15 Feb 2022 23:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644962924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MUZ94T70jRE4amZ/ajr8yxMTG904QV5NT7kkkixours=;
        b=LkiULF8qK8uaGUDYu7AF60ocQbyC9DAjrtQKSiJ/TSqqTC/HfcDcKpxTBWIBk5+N1q3mLO
        smzWR2CK73TJOhUy2F96IbCVAH3SSZAHurUcf/hgSd367ODfylMBVwNL5HLMJGKD9764xz
        quTTiF2pjco1znIXG6577Hluc4ZxWQE=
Date:   Tue, 15 Feb 2022 23:08:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jue Wang <juew@google.com>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Message-ID: <Ygwka++3eipjQzB2@zn.tnic>
References: <CAPcxDJ7nriZEJHF6dMPR7tQ+dGuueyRjw1NC+4CbjxiAT_S+ZA@mail.gmail.com>
 <20220208150945.266978-1-juew@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220208150945.266978-1-juew@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 07:09:45AM -0800, Jue Wang wrote:
> Subject: Re: [PATCH] x86/mce: Add workaround for SKX/CLX/CPX spurious machine checks

Please rewrite Intel-internal model abbreviations. I guess saying here
the actual model is a lot more precise than those which don't even have
any public mapping which is which.

Also, that subject needs to be more precise - "add workaround for
"spurious MCEs" is too vague.

> The fast string copy instructions ("rep movs*") could consume an

REP MOVS* - we usually spell instructions in all caps. Pls fix
everywhere.

> uncorrectable memory error in the cache line _right after_ the
> desired region to copy and raise an MCE.
> 
> Bit 0 of MSR_IA32_MISC_ENABLE can be cleared to disable fast string copy
> and will avoid such spurious machine checks. However, that is less
> preferrable due to the permanent performance impact. Considering memory

Unknown word [preferrable] in commit message.
Suggestions: ['preferable', 'preferably', 'deferrable']

> poison is rare, it's desirable to keep fast string enabled until an MCE
> is seen.
> 
> Intel has confirmed the following:
> 1. The CPU erratum of fast string copy only applies to
> SKX/CLX/CPL generations.
> 2. Directly return from MCE handler will result in complete execution
> of the fast string copy (rep movs*) with no data loss or corruption.
> 3. Directly return from MCE handler will not result in another MCE
> firing on the next poisoned cache line due to rep movs*.
> 4. Directly return from MCE handler will resume execution from a
> correct point in code.
> 5. Directly return from MCE handler due to any other SRAR MCEs will
> result in the same instruction that triggered the MCE firing a second
> MCE immediately.

Simplify this: "Directly return from MCE handler" in every sentence is
not helping.

> 6. It's not safe to directly return without disabling the fast string
> copy, as the next fast string copy of the same buffer on the same CPU
> would result in a PANIC MCE.
> 
> The mitigation in this patch should mitigate the erratum completely with

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> the only caveat that the fast string copy is disabled on the affected
> hyper thread thus performance degradation.
> 
> This is still better than the OS crashes on MCEs raised on an
> irrelevant process due to 'rep movs*' accesses in a kernel context,
> e.g., copy_page.

Wait a minute: so the MCE will happen for a piece of buffer that REP;
MOVS *wasn't* supposed to copy.

So why are we even disabling fast strings operations? Why aren't we
simply ignoring this MCE with a warn in dmesg since, reportedly, we can
recover safely?

Nothing has gone wrong, has it?

> Since a host drain / fail-over usually starts right after the first

What is a "host drain"?

> MCE is signaled, which results in VM migration or termination, the
> performance degradation is a transient effect.

This sounds like a google-specific policy and doesn't belong in the
commit message.

> Tested:
> 
> Injected errors on 1st cache line of 8 anonymous pages of process
> 'proc1' and observed MCE consumption from 'proc2' with no panic
> (directly returned).
> 
> Without the fix, the host panicked within a few minutes on a
> random 'proc2' process due to kernel access from copy_page.

We usually do not keep in the commit message how a patch has been tested
but I guess with MCE that is important enough.

> 
> Signed-off-by: Jue Wang <juew@google.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c     | 53 ++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/mce/internal.h |  5 ++-
>  2 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 5818b837fd4d..abbd4936dfa8 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -834,6 +834,49 @@ static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
>  	m->cs = regs->cs;
>  }
>  
> +/*
> + * Disable fast string copy and return from the MCE handler upon the first SRAR
> + * MCE on bank 1 due to a CPU erratum on Intel SKX/CLX/CPL CPUs.
> + * The fast string copy instructions ("rep movs*") could consume an
> + * uncorrectable memory error in the cache line _right after_ the
> + * desired region to copy and raise an MCE with RIP pointing to the
> + * instruction _after_ the "rep movs*".
> + * This mitigation addresses the issue completely with the caveat of
> + * performance degradation on the CPU affected. This is still better
> + * than the OS crashes on MCEs raised on an irrelevant process due to
> + * 'rep movs*' accesses in a kernel context (e.g., copy_page).
> + * Since a host drain / fail-over usually starts right after the first
> + * MCE is signaled, which results in VM migration or termination, the
> + * performance degradation is a transient effect.
> + *
> + * Returns true when fast string copy on cpu should be disabled.

Unknown word [cpu] in comment.
Suggestions: ['CPU', 'cup', 'cp', 'cu', 'cps', 'cru', 'cpl', 'cpd', 'APU', 'vCPU']

> + */
> +static bool quirk_skylake_repmov(void)
> +{
> +	u64 mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
> +	u64 misc_enable = __rdmsr(MSR_IA32_MISC_ENABLE);
> +
> +	if ((mcgstatus & MCG_STATUS_LMCES) &&
> +	    unlikely(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
> +		u64 mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
> +
> +		if ((mc1_status &
> +		     (MCI_STATUS_VAL|MCI_STATUS_OVER|MCI_STATUS_UC|MCI_STATUS_EN|
> +		      MCI_STATUS_ADDRV|MCI_STATUS_MISCV|MCI_STATUS_PCC|
> +		      MCI_STATUS_AR|MCI_STATUS_S)) ==
> +		    (MCI_STATUS_VAL|MCI_STATUS_UC|MCI_STATUS_EN|MCI_STATUS_ADDRV|
> +		     MCI_STATUS_MISCV|MCI_STATUS_AR|MCI_STATUS_S)) {

You can write that by paying attention to the vertical alignment so that
it is visible which bits we're looking at:

                if ((mc1_status &
                     (MCI_STATUS_VAL | MCI_STATUS_OVER | MCI_STATUS_UC | MCI_STATUS_EN |
                      MCI_STATUS_ADDRV | MCI_STATUS_MISCV | MCI_STATUS_PCC |
                      MCI_STATUS_AR | MCI_STATUS_S)) == 

                     (MCI_STATUS_VAL   |                 MCI_STATUS_UC | MCI_STATUS_EN |
                      MCI_STATUS_ADDRV | MCI_STATUS_MISCV |
                      MCI_STATUS_AR | MCI_STATUS_S)) {

i.e., MCI_STATUS_OVER and MCI_STATUS_PCC must *not* be set.


> +			msr_clear_bit(MSR_IA32_MISC_ENABLE,
> +				      MSR_IA32_MISC_ENABLE_FAST_STRING_BIT);
> +			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> +			mce_wrmsrl(MSR_IA32_MCx_STATUS(1), 0);
> +			pr_err_once("Errata detected, disable fast string copy instructions.\n");
> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
>  /*
>   * Do a quick check if any of the events requires a panic.
>   * This decides if we keep the events around or clear them.
> @@ -1403,6 +1446,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  	else if (unlikely(!mca_cfg.initialized))
>  		return unexpected_machine_check(regs);
>  
> +	if (mce_flags.skx_repmov_quirk && quirk_skylake_repmov())

What about the MCE broadcasting synchronization? This is bypassing
everything. There's mce_exception_count which counts stuff too.

In any case, if this function is gonna be called by do_machine_check, it
needs to be noinstr. You can test with CONFIG_DEBUG_ENTRY=y.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
