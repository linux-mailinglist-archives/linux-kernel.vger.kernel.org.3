Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC5485158
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbiAEKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:45:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56820 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiAEKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:45:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57209B81A0F;
        Wed,  5 Jan 2022 10:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E043EC36AEB;
        Wed,  5 Jan 2022 10:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641379535;
        bh=epw0L1zm/nLJn6FhMCujuVDMIsyZYGTVDtwQZhVZKG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MH3tdHVPwbJgamXMZEUsiFyp8+eLlvfOavQWUcCkJkMFDg/H0Sz/iosJO+6TCCgY9
         TdOLc+5Q1ijSHqTcnQNNKnEX3o1YFeLhrZ1AF2ak7mxDJ078NXAqeyuYzyeLu7s2BZ
         hcno1A8lRqrK1Yus+PORY49iK3iyPFp3W0TtljFABRrkEEQ4bwvV2rSEVNxeI6Y99V
         C8J8EwbXHwlmVVTSfHgNid4o58bYUhTfMc76pBN2uEufDMQYvsw1dFgP5vSYTyvpOT
         xe3zkrey8dZtdg2Z6WwFlmGg4z9vJWg+PcVGTKPa8ezHjdY/EiMJoTHyOeKeDMqybr
         6LoHrz3kxEchg==
Date:   Wed, 5 Jan 2022 10:45:26 +0000
From:   Will Deacon <will@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 1/9] mm: x86, arm64: add arch_has_hw_pte_young()
Message-ID: <20220105104526.GA3015@willie-the-truck>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-2-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104202227.2903605-2-yuzhao@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 01:22:20PM -0700, Yu Zhao wrote:
> Some architectures automatically set the accessed bit in PTEs, e.g.,
> x86 and arm64 v8.2. On architectures that don't have this capability,
> clearing the accessed bit in a PTE usually triggers a page fault
> following the TLB miss of this PTE.
> 
> Being aware of this capability can help make better decisions, e.g.,
> whether to spread the work out over a period of time to avoid bursty
> page faults when trying to clear the accessed bit in a large number of
> PTEs.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> ---
>  arch/arm64/include/asm/cpufeature.h |  5 +++++
>  arch/arm64/include/asm/pgtable.h    | 13 ++++++++-----
>  arch/arm64/kernel/cpufeature.c      | 19 +++++++++++++++++++
>  arch/arm64/tools/cpucaps            |  1 +
>  arch/x86/include/asm/pgtable.h      |  6 +++---
>  include/linux/pgtable.h             | 13 +++++++++++++
>  mm/memory.c                         | 14 +-------------
>  7 files changed, 50 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index ef6be92b1921..99518b4b2a9e 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -779,6 +779,11 @@ static inline bool system_supports_tlb_range(void)
>  		cpus_have_const_cap(ARM64_HAS_TLB_RANGE);
>  }
>  
> +static inline bool system_has_hw_af(void)
> +{
> +	return IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && cpus_have_const_cap(ARM64_HW_AF);
> +}
> +
>  extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>  
>  static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index c4ba047a82d2..e736f47436c7 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -999,13 +999,16 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>   * page after fork() + CoW for pfn mappings. We don't always have a
>   * hardware-managed access flag on arm64.
>   */
> -static inline bool arch_faults_on_old_pte(void)
> +static inline bool arch_has_hw_pte_young(bool local)
>  {
> -	WARN_ON(preemptible());
> +	if (local) {
> +		WARN_ON(preemptible());
> +		return cpu_has_hw_af();
> +	}
>  
> -	return !cpu_has_hw_af();
> +	return system_has_hw_af();
>  }
> -#define arch_faults_on_old_pte		arch_faults_on_old_pte
> +#define arch_has_hw_pte_young		arch_has_hw_pte_young
>  
>  /*
>   * Experimentally, it's cheap to set the access flag in hardware and we
> @@ -1013,7 +1016,7 @@ static inline bool arch_faults_on_old_pte(void)
>   */
>  static inline bool arch_wants_old_prefaulted_pte(void)
>  {
> -	return !arch_faults_on_old_pte();
> +	return arch_has_hw_pte_young(true);
>  }
>  #define arch_wants_old_prefaulted_pte	arch_wants_old_prefaulted_pte
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 6f3e677d88f1..5bb553ee2c0e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2171,6 +2171,25 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_hw_dbm,
>  		.cpu_enable = cpu_enable_hw_dbm,
>  	},
> +	{
> +		/*
> +		 * __cpu_setup always enables this capability. But if the boot
> +		 * CPU has it and a late CPU doesn't, the absent
> +		 * ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU will prevent this late CPU
> +		 * from going online. There is neither known hardware does that
> +		 * nor obvious reasons to design hardware works that way, hence
> +		 * no point leaving the door open here. If the need arises, a
> +		 * new weak system feature flag should do the trick.
> +		 */
> +		.desc = "Hardware update of the Access flag",
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.capability = ARM64_HW_AF,
> +		.sys_reg = SYS_ID_AA64MMFR1_EL1,
> +		.sign = FTR_UNSIGNED,
> +		.field_pos = ID_AA64MMFR1_HADBS_SHIFT,
> +		.min_field_value = 1,
> +		.matches = has_cpuid_feature,
> +	},
>  #endif
>  	{
>  		.desc = "CRC32 instructions",
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 870c39537dd0..56e4ef5d95fa 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -36,6 +36,7 @@ HAS_STAGE2_FWB
>  HAS_SYSREG_GIC_CPUIF
>  HAS_TLB_RANGE
>  HAS_VIRT_HOST_EXTN
> +HW_AF
>  HW_DBM
>  KVM_PROTECTED_MODE
>  MISMATCHED_CACHE_TYPE

As discussed in the previous threads, we really don't need the complexity
of the additional cap for the arm64 part. Please can you just use the
existing code instead? It's both simpler and, as you say, it's equivalent
for existing hardware.

That way, this patch just ends up being a renaming exercise and we're all
good.

Thanks,

Will
