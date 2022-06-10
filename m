Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E06546ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349728AbiFJQr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiFJQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:47:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE2B6B7C8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:47:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BCCFB83652
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAC1C34114;
        Fri, 10 Jun 2022 16:47:16 +0000 (UTC)
Date:   Fri, 10 Jun 2022 17:47:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: errata: add detection for AMEVCNTR01 incrementing
 incorrectly
Message-ID: <YqN1kJlIkhNAEl/K@arm.com>
References: <20220607125340.13635-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607125340.13635-1-ionela.voinescu@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 01:53:40PM +0100, Ionela Voinescu wrote:
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 14a8f3d93add..80e0c700cecf 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -881,11 +881,16 @@ static inline bool cpu_has_pan(void)
>  #ifdef CONFIG_ARM64_AMU_EXTN
>  /* Check whether the cpu supports the Activity Monitors Unit (AMU) */
>  extern bool cpu_has_amu_feat(int cpu);
> +extern bool cpu_has_broken_amu_constcnt(void);
>  #else
>  static inline bool cpu_has_amu_feat(int cpu)
>  {
>  	return false;
>  }
> +static inline bool cpu_has_broken_amu_constcnt(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  /* Get a cpu that supports the Activity Monitors Unit (AMU) */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 42ea2bd856c6..b9e4b2bd2c63 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1791,6 +1791,19 @@ int get_cpu_with_amu_feat(void)
>  	return cpumask_any(&amu_cpus);
>  }
>  
> +bool cpu_has_broken_amu_constcnt(void)
> +{
> +	/* List of CPUs which have broken AMEVCNTR01 (constant counter) */
> +	static const struct midr_range cpus[] = {
> +#ifdef CONFIG_ARM64_ERRATUM_2457168
> +		MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
> +#endif
> +		{},
> +	};
> +
> +	return is_midr_in_range(read_cpuid_id(), cpus);
> +}

I'd rather not have this in cpufeature.c as it's not really a feature.
We have some precedent with checking errata in cpufeature.c but IIRC we
did that only to check whether to enable a feature or not in that file
(DBM).

> +
>  static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
>  {
>  	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 9ab78ad826e2..d4b0b0a40515 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -127,7 +127,8 @@ int __init parse_acpi_topology(void)
>  
>  #ifdef CONFIG_ARM64_AMU_EXTN
>  #define read_corecnt()	read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0)
> -#define read_constcnt()	read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0)
> +#define read_constcnt()	(cpu_has_broken_amu_constcnt() ? 0UL : \
> +			read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0))

How often is this called? You end up reading the cpuid, comparing the
range on each call. I guess you can't use a cpucap in the arm64_errata[]
array as you want a check per-CPU? Does it matter if we return 0UL on
for all CPUs if one is affected?

-- 
Catalin
