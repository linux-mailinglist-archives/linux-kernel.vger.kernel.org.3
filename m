Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40E55974A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbiHQQ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiHQQ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:59:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5FB61DA0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:59:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5F88B81E57
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61137C433D6;
        Wed, 17 Aug 2022 16:59:05 +0000 (UTC)
Date:   Wed, 17 Aug 2022 17:59:01 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] arm64: errata: add detection for AMEVCNTR01
 incrementing incorrectly
Message-ID: <Yv0eVVmrnPp7fjaB@arm.com>
References: <20220817121551.21790-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817121551.21790-1-ionela.voinescu@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ionela,

On Wed, Aug 17, 2022 at 01:15:51PM +0100, Ionela Voinescu wrote:
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 7e6289e709fc..810dd3c39882 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -654,6 +654,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
>  	},
>  #endif
> +#ifdef CONFIG_ARM64_ERRATUM_2457168
> +	{
> +		.desc = "ARM erratum 2457168",
> +		.capability = ARM64_WORKAROUND_2457168,
> +		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
> +
> +		/* Cortex-A510 r0p0-r1p1 */
> +		CAP_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1)
> +	},
> +#endif
>  #ifdef CONFIG_ARM64_ERRATUM_2038923
>  	{
>  		.desc = "ARM erratum 2038923",
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 907401e4fffb..af4de817d712 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1870,7 +1870,10 @@ static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
>  		pr_info("detected CPU%d: Activity Monitors Unit (AMU)\n",
>  			smp_processor_id());
>  		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
> -		update_freq_counters_refs();
> +
> +		/* 0 reference values signal broken/disabled counters */
> +		if (!this_cpu_has_cap(ARM64_WORKAROUND_2457168))
> +			update_freq_counters_refs();
>  	}
>  }

From a CPU errata workaround, this part looks fine to me.

>  
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 869ffc4d4484..5d7efb15f7cf 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -301,7 +301,8 @@ static void cpu_read_corecnt(void *val)
>  
>  static void cpu_read_constcnt(void *val)
>  {
> -	*(u64 *)val = read_constcnt();
> +	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_2457168) ?
> +		      0UL : read_constcnt();
>  }
>  
>  static inline
> @@ -328,7 +329,12 @@ int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
>   */
>  bool cpc_ffh_supported(void)
>  {
> -	return freq_counters_valid(get_cpu_with_amu_feat());
> +	int cpu = get_cpu_with_amu_feat();
> +
> +	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
> +		return false;
> +
> +	return true;
>  }

So here we tell the core code that FFH is supported but always return 0
via cpc_read_ffh() if the const counter is requested. I assume the core
code figures this out and doesn't use the value on the affected CPUs. I
was hoping cpc_ffh_supported() would be per-CPU and the core code simply
skips calling cpc_read() on the broken cores. Is the other register read
by cpc_read_ffh() still useful without the const one?

While the Kconfig entry describes the behaviour, I'd rather have a
comment in cpc_ffh_supported() and maybe cpu_read_constcnt() on why we
do these tricks.

Thanks.

-- 
Catalin
