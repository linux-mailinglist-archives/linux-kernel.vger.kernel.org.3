Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73E74AC8F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiBGS4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbiBGSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:53:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC7C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:53:03 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EAA081EC02B9;
        Mon,  7 Feb 2022 19:52:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644259978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LICMfza50xLNOKuEZvCy0lQik7Nk+cU+hUWDxRSuwD0=;
        b=LPT2AUZeTvjMXsvQMIFmTVT6m8+83DAkM9Jb9ymRG02o911J4RcqNZc500jRIugpHS/daj
        DtVQ5TB/3fLZbEnBft9RUg74C2RsiCEgSEyY2YRLZ61n+k99De89+BoszEMq/+l55ENQTG
        62jCORLku4DwDhzwb2PS43Fuebag6ek=
Date:   Mon, 7 Feb 2022 19:52:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jue Wang <juew@google.com>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Message-ID: <YgFqiJOU5tZsHbY6@zn.tnic>
References: <20220207043640.2829295-1-juew@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220207043640.2829295-1-juew@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And while you're working in Tony's request...

On Sun, Feb 06, 2022 at 08:36:40PM -0800, Jue Wang wrote:
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 5818b837fd4d..06001e3b2ff2 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -834,6 +834,57 @@ static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
>  	m->cs = regs->cs;
>  }
>  
> +static bool is_intel_srar(u64 mci_status)

You don't need this separate function - stick it all in quirk_skylake_repmov()

> +	return (mci_status &
> +		(MCI_STATUS_VAL|MCI_STATUS_OVER|MCI_STATUS_UC|MCI_STATUS_EN|
> +		 MCI_STATUS_ADDRV|MCI_STATUS_MISCV|MCI_STATUS_PCC|
> +		 MCI_STATUS_AR|MCI_STATUS_S)) ==
> +		(MCI_STATUS_VAL|MCI_STATUS_UC|MCI_STATUS_EN|MCI_STATUS_ADDRV|
> +		 MCI_STATUS_MISCV|MCI_STATUS_AR|MCI_STATUS_S);
> +}
> +
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
> + */
> +static bool quirk_skylake_repmov(void)
> +{
> +	/*
> +	 * State that represents if an SRAR MCE has already signaled on the DCU bank.
> +	 */
> +	static DEFINE_PER_CPU(bool, srar_dcu_signaled);

What's that needed for?

If the MSR write below clears the CPUID bit, you clear the corresponding
X86_FEATURE flag. And this test becomes a X86_FEATURE flag test:

	if (this_cpu_has(X86_FEATURE_FSRM))

I'd guess...

> +	if (unlikely(!__this_cpu_read(srar_dcu_signaled))) {
> +		u64 mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
> +
> +		if (is_intel_srar(mc1_status)) {
> +			__this_cpu_write(srar_dcu_signaled, true);
> +			msr_clear_bit(MSR_IA32_MISC_ENABLE,
> +				      MSR_IA32_MISC_ENABLE_FAST_STRING_BIT);
> +			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> +			mce_wrmsrl(MSR_IA32_MCx_STATUS(1), 0);
> +			pr_err("First SRAR MCE on DCU, CPU: %d, disable fast string copy.\n",

That error message can be understood probably only by a handful dozen of
people on the planet. Is it write-only or is it supposed to be consumed
by humans and if so, what would be the use case?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
