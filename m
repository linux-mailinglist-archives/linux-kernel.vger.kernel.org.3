Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D84492EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349064AbiARUCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:02:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245033AbiARUCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:02:43 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98B8C1EC018C;
        Tue, 18 Jan 2022 21:02:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642536158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJzhlG/XZLRshl/TNOzuwLXpy1AY2QvmCVdCYi4DnC0=;
        b=qV1sdj/NP50o/FgsFvzc+8ZCb1wKPOo6T+dScbwWa301T501gbNLG+JWjQc2ryzUopvFwj
        xhMtkFflv6+Wqyn8Ni+ve5AMcGoF6CM3m5UrJhgKpT4hh9zWqGWfbyb3+FPXRs/jIGnXfY
        kdyWEVRX4rgzmoo1awHEA3YgajePM84=
Date:   Tue, 18 Jan 2022 21:02:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH 1/5] x86/ras: Merge Intel and AMD ppin_init() functions
Message-ID: <YecY/Ri6hvJGqNTT@zn.tnic>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220107225442.1690165-2-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107225442.1690165-2-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 02:54:38PM -0800, Tony Luck wrote:

Make that subject prefix "x86/cpu" please. Same for patches 2 and 3.

Patch 4 is probably topology/sysfs - at least this is what past patches
say. If you're not sure about the prefix, use git log on the files
you're touching.

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 0083464de5e3..a1e29c0844d1 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -88,6 +88,80 @@ EXPORT_SYMBOL_GPL(get_llc_id);
>  /* L2 cache ID of each logical CPU */
>  DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) = BAD_APICID;
>  
> +static struct ppin_info {
> +	int	feature;
> +	int	msr_ppin_ctl;
> +	int	msr_ppin;

That thing is unused in this patch and only accessed in patch 3. Please
add it there.

> +} ppin_info[] = {
> +	[X86_VENDOR_INTEL] = {
> +		.feature = X86_FEATURE_INTEL_PPIN,
> +		.msr_ppin_ctl = MSR_PPIN_CTL,
> +		.msr_ppin = MSR_PPIN
> +	},
> +	[X86_VENDOR_AMD] = {

X86_VENDOR_AMD is index 2 not 1 so ppin_info[1] is empty.

I wouldn't mind swapping the numbers here in a pre-patch:

#define X86_VENDOR_CYRIX        1
#define X86_VENDOR_AMD          2

nothing would depend on those naked numbers, right? :)

> +		.feature = X86_FEATURE_AMD_PPIN,
> +		.msr_ppin_ctl = MSR_AMD_PPIN_CTL,
> +		.msr_ppin = MSR_AMD_PPIN
> +	},
> +};
> +
> +static const struct x86_cpu_id ppin_cpuids[] = {
> +	X86_MATCH_VENDOR_FEATURE(AMD, X86_FEATURE_AMD_PPIN, &ppin_info[X86_VENDOR_AMD]),

X86_MATCH_FEATURE() I guess.

> +	/* Legacy models without CPUID enumeration */
> +	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X, &ppin_info[X86_VENDOR_INTEL]),
> +	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X, &ppin_info[X86_VENDOR_INTEL]),
> +	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D, &ppin_info[X86_VENDOR_INTEL]),
> +	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, &ppin_info[X86_VENDOR_INTEL]),
> +	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, &ppin_info[X86_VENDOR_INTEL]),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, &ppin_info[X86_VENDOR_INTEL]),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, &ppin_info[X86_VENDOR_INTEL]),
> +	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL, &ppin_info[X86_VENDOR_INTEL]),
> +	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM, &ppin_info[X86_VENDOR_INTEL]),
> +
> +	{}
> +};
> +
> +static void ppin_init(struct cpuinfo_x86 *c)
> +{
> +	const struct x86_cpu_id *id;
> +	unsigned long long val;
> +	struct ppin_info *info;
> +
> +	id = x86_match_cpu(ppin_cpuids);
> +	if (!id)
> +		return;
> +
> +	/*
> +	 * Testing the prescence of the MSR is not enough. Need to check

Unknown word [prescence] in comment.
Suggestions: ['presence', 'prescience', 'putrescence', 'prepubescence', 'excrescence', 'concrescence']

> +	 * that the PPIN_CTL allows reading of the PPIN.
> +	 */
> +	info = (struct ppin_info *)id->driver_data;
> +
> +	if (rdmsrl_safe(info->msr_ppin_ctl, &val))
> +		goto clear_ppin;
> +
> +	if ((val & 3UL) == 1UL) {
> +		/* PPIN locked in disabled mode */
> +		goto clear_ppin;
> +	}
> +
> +	/* If PPIN is disabled, try to enable */
> +	if (!(val & 2UL)) {
> +		wrmsrl_safe(info->msr_ppin_ctl,  val | 2UL);
> +		rdmsrl_safe(info->msr_ppin_ctl, &val);
> +	}
> +
> +	/* Is the enable bit set? */
> +	if (val & 2UL) {
> +		set_cpu_cap(c, info->feature);
> +		return;
> +	}
> +
> +clear_ppin:
> +	clear_cpu_cap(c, info->feature);
> +}
> +
>  /* correctly size the local cpu masks */
>  void __init setup_cpu_local_masks(void)
>  {
> @@ -1655,6 +1729,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  			c->x86_capability[i] |= boot_cpu_data.x86_capability[i];
>  	}
>  
> +	ppin_init(c);

I can't say that I'm crazy about all those miscellaneous
feature-initializing functions sprinkled allround here but I don't have
a better idea ... yet.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
