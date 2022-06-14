Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEFC54B274
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbiFNNnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiFNNnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:43:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E33F321E21
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:43:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C18D21650;
        Tue, 14 Jun 2022 06:43:00 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C2543F73B;
        Tue, 14 Jun 2022 06:43:00 -0700 (PDT)
Date:   Tue, 14 Jun 2022 14:42:58 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: errata: add detection for AMEVCNTR01 incrementing
 incorrectly
Message-ID: <YqiQYikYTFVPE8GG@arm.com>
References: <20220607125340.13635-1-ionela.voinescu@arm.com>
 <YqN1kJlIkhNAEl/K@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqN1kJlIkhNAEl/K@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

Thank you for the review!

On Friday 10 Jun 2022 at 17:47:12 (+0100), Catalin Marinas wrote:
> On Tue, Jun 07, 2022 at 01:53:40PM +0100, Ionela Voinescu wrote:
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index 14a8f3d93add..80e0c700cecf 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -881,11 +881,16 @@ static inline bool cpu_has_pan(void)
> >  #ifdef CONFIG_ARM64_AMU_EXTN
> >  /* Check whether the cpu supports the Activity Monitors Unit (AMU) */
> >  extern bool cpu_has_amu_feat(int cpu);
> > +extern bool cpu_has_broken_amu_constcnt(void);
> >  #else
> >  static inline bool cpu_has_amu_feat(int cpu)
> >  {
> >  	return false;
> >  }
> > +static inline bool cpu_has_broken_amu_constcnt(void)
> > +{
> > +	return false;
> > +}
> >  #endif
> >  
> >  /* Get a cpu that supports the Activity Monitors Unit (AMU) */
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 42ea2bd856c6..b9e4b2bd2c63 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1791,6 +1791,19 @@ int get_cpu_with_amu_feat(void)
> >  	return cpumask_any(&amu_cpus);
> >  }
> >  
> > +bool cpu_has_broken_amu_constcnt(void)
> > +{
> > +	/* List of CPUs which have broken AMEVCNTR01 (constant counter) */
> > +	static const struct midr_range cpus[] = {
> > +#ifdef CONFIG_ARM64_ERRATUM_2457168
> > +		MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
> > +#endif
> > +		{},
> > +	};
> > +
> > +	return is_midr_in_range(read_cpuid_id(), cpus);
> > +}
> 
> I'd rather not have this in cpufeature.c as it's not really a feature.
> We have some precedent with checking errata in cpufeature.c but IIRC we
> did that only to check whether to enable a feature or not in that file
> (DBM).
> 

If it's okay with you I can move this to cpu_errata.c:arm64_errata[], but
the type of the capability would have to be
ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE. I see there are other workarounds
like this so I hope it's not a problem.

> > +
> >  static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
> >  {
> >  	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 9ab78ad826e2..d4b0b0a40515 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -127,7 +127,8 @@ int __init parse_acpi_topology(void)
> >  
> >  #ifdef CONFIG_ARM64_AMU_EXTN
> >  #define read_corecnt()	read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0)
> > -#define read_constcnt()	read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0)
> > +#define read_constcnt()	(cpu_has_broken_amu_constcnt() ? 0UL : \
> > +			read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0))
> 
> How often is this called? You end up reading the cpuid, comparing the
> range on each call. I guess you can't use a cpucap in the arm64_errata[]
> array as you want a check per-CPU? Does it matter if we return 0UL on
> for all CPUs if one is affected?
> 

Yes, ideally we only want to disable the use of the constant counter for
the affected CPUs. In that case some alternative method can be used for
FIE for the affected CPUs (usually cpufreq) while the other CPUs can still
use AMUs. Given that the bigger CPUs usually end up throttled, it would be
useful to maintain the use of AMUs for them even if we have affected
A510s in the system.

Also, I wanted to avoid disabling the feature altogether by not setting
amu_cpus as only one counter is affected, not all. But this would be the
simpler option as it will also remove the need for changes for FFH, we
would end up calling this only once for each CPU in cpu_amu_enable() -
so no additional function would be needed, and functionality will be
unchanged as all usecases for AMUs so far are tied to the use of the
constant counter. But we'd need to change how we handle this erratum in
the future when we add usescases for other counters.

So we do end up calling this function on the tick for CPUs that are not
affected, which is not ideal.

But I have a few ideas about how to make it nicer - clearing
arch_const_cycles_prev before freq_counters_valid() so we disable use of
counters for FIE by checking for affected CPUs only once. Handling FFH
will be more tricky but nonetheless let me see if I can do a better job
in v2.

Thanks,
Ionela.

> -- 
> Catalin
