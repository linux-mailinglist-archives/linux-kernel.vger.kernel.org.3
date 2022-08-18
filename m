Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523505982E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbiHRMD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244479AbiHRMDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:03:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C3C582855
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:03:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB685106F;
        Thu, 18 Aug 2022 05:03:54 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F18643F70D;
        Thu, 18 Aug 2022 05:03:52 -0700 (PDT)
Date:   Thu, 18 Aug 2022 13:03:51 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] arm64: errata: add detection for AMEVCNTR01
 incrementing incorrectly
Message-ID: <Yv4qp9xar9EBQaD8@arm.com>
References: <20220817121551.21790-1-ionela.voinescu@arm.com>
 <Yv0eVVmrnPp7fjaB@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv0eVVmrnPp7fjaB@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Wednesday 17 Aug 2022 at 17:59:01 (+0100), Catalin Marinas wrote:
> Hi Ionela,
> 
> On Wed, Aug 17, 2022 at 01:15:51PM +0100, Ionela Voinescu wrote:
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > index 7e6289e709fc..810dd3c39882 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -654,6 +654,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
> >  		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
> >  	},
> >  #endif
> > +#ifdef CONFIG_ARM64_ERRATUM_2457168
> > +	{
> > +		.desc = "ARM erratum 2457168",
> > +		.capability = ARM64_WORKAROUND_2457168,
> > +		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
> > +
> > +		/* Cortex-A510 r0p0-r1p1 */
> > +		CAP_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1)
> > +	},
> > +#endif
> >  #ifdef CONFIG_ARM64_ERRATUM_2038923
> >  	{
> >  		.desc = "ARM erratum 2038923",
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 907401e4fffb..af4de817d712 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1870,7 +1870,10 @@ static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
> >  		pr_info("detected CPU%d: Activity Monitors Unit (AMU)\n",
> >  			smp_processor_id());
> >  		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
> > -		update_freq_counters_refs();
> > +
> > +		/* 0 reference values signal broken/disabled counters */
> > +		if (!this_cpu_has_cap(ARM64_WORKAROUND_2457168))
> > +			update_freq_counters_refs();
> >  	}
> >  }
> 
> From a CPU errata workaround, this part looks fine to me.
> 
> >  
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 869ffc4d4484..5d7efb15f7cf 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -301,7 +301,8 @@ static void cpu_read_corecnt(void *val)
> >  
> >  static void cpu_read_constcnt(void *val)
> >  {
> > -	*(u64 *)val = read_constcnt();
> > +	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_2457168) ?
> > +		      0UL : read_constcnt();
> >  }
> >  
> >  static inline
> > @@ -328,7 +329,12 @@ int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
> >   */
> >  bool cpc_ffh_supported(void)
> >  {
> > -	return freq_counters_valid(get_cpu_with_amu_feat());
> > +	int cpu = get_cpu_with_amu_feat();
> > +
> > +	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
> > +		return false;
> > +
> > +	return true;
> >  }
> 
> So here we tell the core code that FFH is supported but always return 0
> via cpc_read_ffh() if the const counter is requested. I assume the core
> code figures this out and doesn't use the value on the affected CPUs. I
> was hoping cpc_ffh_supported() would be per-CPU and the core code simply
> skips calling cpc_read() on the broken cores.

I used to think the same, but I've realised that the current approach is
best, in my opinion.

There are two users of these counters exposed though FFH in the kernel:
CPPC-based frequency invariance(FIE) and reading current frequency through
sysfs. If AMU counters are disabled or the CPU is affected by this
erratum, a single read of 0 for any of the counters will result in
cppc_get_perf_ctrs() returning -EFAULT which:

- (cppc_cpufreq_cpu_fie_init()) Will disable the use of FIE for that
  policy, and those counters will never be read again for that CPU, for
  the purpose of FIE. This is the operation that would result in reading
  those counters most often, which in this case won't happen.

- Will return -EFAULT from cppc_cpufreq_get_rate() signaling to the user
  that it cannot return a proper frequency using those counters. That's
  cast to unsigned int so the user would have to be knowledgeable on the
  matter :), but that's an existing problem.

Therefore, error checking based on a counter read of 0 would be
equivalent here to checking a potential ffh_supported(cpu). Also, in the
future we might use FFH to not only read these counters. So it's better
to keep ffh_supported() to just reflect whether generically FFH is
supported, even if in some cases the "backend" (AMUs here) is disabled
or broken.

Also, given that it's most likely for a platform to use the same method
for all CPU for reading counters, forgetting or not considering errata,
together with the current use of ffh_supported() as gate-keeper of a CPU
probe based on validity of all CPC methods, even if cpc_ffh_supported()
was per-CPU, it's still better to probe the CPU and let the users of
counters deal with breakage, especially given that these usecases are
not critical.

> Is the other register read by cpc_read_ffh() still useful without the
> const one?

Not for the current uses, and unlikely to be in the future - I don't see
how the core counter value can be useful without a constant reference.


> While the Kconfig entry describes the behaviour, I'd rather have a
> comment in cpc_ffh_supported() and maybe cpu_read_constcnt() on why we
> do these tricks.
> 

Will do!

Thanks,
Ionela.

> Thanks.
> 
> -- 
> Catalin
