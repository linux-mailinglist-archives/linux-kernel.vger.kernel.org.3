Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18BB4C2413
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiBXG1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiBXG1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:27:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24C317AB8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:27:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 541AEB8248C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E96AC340EC;
        Thu, 24 Feb 2022 06:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645684029;
        bh=RfuCCY8zPmsR5Bp17+vtklf5h9j3ms7ZWNwMS/X7RF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4B7jVAyolB6geCsbqCigeUDULujokT8cOt1gy4vqFaRRC794iilYUgF+U1MWtb3W
         3FNYSmtBwV+EbP59MGS3VjT9oHj082T/n4S0kYaaHJFWwGQAZQ0yPgj4jY+SIwNK1k
         i3WnaPwzM3K1FyQ3EWcn98Y1weuI+3Hxp4AvdjBDLEtT3aRyVdPdClWIH4C+CovDE/
         b3wz0eHOnA7p4R5YbceR4MOcHfrX27LDPnLI5OAX5yTssKScPBgFogi4nobrt9coPH
         Saj3gwOv0GJcssfcgFoHckOwiNusCDkHFHV6wivvpMv6eq9HJGPdrzlmixT9tpnuYK
         pd2UuDi4V65gw==
Date:   Thu, 24 Feb 2022 08:26:59 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Do not defer reserve_crashkernel() for
 platforms with no DMA memory zones
Message-ID: <YhclM0atq4oRHn/8@kernel.org>
References: <1645646253-16072-1-git-send-email-vijayb@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645646253-16072-1-git-send-email-vijayb@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 11:57:33AM -0800, Vijay Balakrishna wrote:
> The following patches resulted in deferring crash kernel reservation to
> mem_init(), mainly aimed at platforms with DMA memory zones (no IOMMU),
> in particular Raspberry Pi 4.
> 
> commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> commit 8424ecdde7df ("arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges")
> commit 0a30c53573b0 ("arm64: mm: Move reserve_crashkernel() into mem_init()")
> commit 2687275a5843 ("arm64: Force NO_BLOCK_MAPPINGS if crashkernel reservation is required")
> 
> Above changes introduced boot slowdown due to linear map creation for
> all the memory banks with NO_BLOCK_MAPPINGS, see discussion[1].  The proposed
> changes restore crash kernel reservation to earlier behavior thus avoids
> slow boot, particularly for platforms with IOMMU (no DMA memory zones).
> 
> Tested changes to confirm no ~150ms boot slowdown on our SoC with IOMMU
> and 8GB memory.  Also tested with ZONE_DMA and/or ZONE_DMA32 configs to confirm
> no regression to deferring scheme of crash kernel memory reservation.
> In both cases successfully collected kernel crash dump.
> 
> [1] https://lore.kernel.org/all/9436d033-579b-55fa-9b00-6f4b661c2dd7@linux.microsoft.com/
> 
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> ---
> Changes from v1 -> v2
> ---------------------
> - replaced '!crashk_res.end' with IS_ENABLED(ZONE_DMA/DMA32) (Nicolas's comment)
> - minor change to make it uniform -- replaced #if defined(..) -> #if IS_ENABLED(..)
> - added new comment in arch/arm64/mm/init.c to ease future maintenance (Nicolas's comment)
> - test performed comment moved to commit message
> 
> [v1] https://lore.kernel.org/all/1645056294-6509-1-git-send-email-vijayb@linux.microsoft.com/
> ---
>  arch/arm64/mm/init.c | 36 +++++++++++++++++++++++++++++++++---
>  arch/arm64/mm/mmu.c  | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index db63cc885771..51869f9dfc33 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -61,8 +61,34 @@ EXPORT_SYMBOL(memstart_addr);
>   * unless restricted on specific platforms (e.g. 30-bit on Raspberry Pi 4).
>   * In such case, ZONE_DMA32 covers the rest of the 32-bit addressable memory,
>   * otherwise it is empty.
> + *
> + * Memory reservation for crash kernel either done early or deferred
> + * depending on DMA memory zones configs (ZONE_DMA) --
> + *
> + * In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
> + * here instead of max_zone_phys().  This lets early reservation of
> + * crash kernel memory which has a dependency on arm64_dma_phys_limit.
> + * Reserving memory early for crash kernel allows linear creation of block
> + * mappings (greater than page-granularity) for all the memory bank rangs.
> + * In this scheme a comparatively quicker boot is observed.
> + *
> + * If ZONE_DMA configs are defined, crash kernel memory reservation
> + * is delayed until DMA zone memory range size initilazation performed in
> + * zone_sizes_init().  The defer is necessary to steer clear of DMA zone
> + * memory range to avoid overlap allocation.  So crash kernel memory boundaries
> + * are not known when mapping all bank memory ranges, which otherwise means
> + * not possible to exclude crash kernel range from creating block mappings
> + * so page-granularity mappings are created for the entire memory range.
> + * Hence a slightly slower boot is observed.
> + *
> + * Note: Page-granularity mapppings are necessary for crash kernel memory
> + * range for shrinking its size via /sys/kernel/kexec_crash_size interface.
>   */
> -phys_addr_t arm64_dma_phys_limit __ro_after_init;
> +#if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
> +phys_addr_t __ro_after_init arm64_dma_phys_limit;
> +#else
> +phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
> +#endif
>  
>  #ifdef CONFIG_KEXEC_CORE
>  /*
> @@ -153,8 +179,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  	if (!arm64_dma_phys_limit)
>  		arm64_dma_phys_limit = dma32_phys_limit;
>  #endif
> -	if (!arm64_dma_phys_limit)
> -		arm64_dma_phys_limit = PHYS_MASK + 1;
>  	max_zone_pfns[ZONE_NORMAL] = max;
>  
>  	free_area_init(max_zone_pfns);
> @@ -315,6 +339,10 @@ void __init arm64_memblock_init(void)
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> +#if !IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)
> +	reserve_crashkernel();
> +#endif

Nit: with IS_ENABLED() this does not need to be an #ifdef, but rather

	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
		reserve_crashkernel();

The same applies to the cases below.

> +
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  }
>  
> @@ -357,11 +385,13 @@ void __init bootmem_init(void)
>  	 */
>  	dma_contiguous_reserve(arm64_dma_phys_limit);
>  
> +#if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
>  	/*
>  	 * request_standard_resources() depends on crashkernel's memory being
>  	 * reserved, so do it here.
>  	 */
>  	reserve_crashkernel();
> +#endif
>  
>  	memblock_dump_all();
>  }
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index acfae9b41cc8..884b2c6d6cd9 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -517,7 +517,7 @@ static void __init map_mem(pgd_t *pgdp)
>  	 */
>  	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
>  
> -	if (can_set_direct_map() || crash_mem_map || IS_ENABLED(CONFIG_KFENCE))
> +	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
>  	/*
> @@ -528,6 +528,18 @@ static void __init map_mem(pgd_t *pgdp)
>  	 */
>  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>  
> +#if IS_ENABLED(CONFIG_KEXEC_CORE)
> +
> +#if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
> +	if (crash_mem_map)
> +		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> +#else
> +	if (crashk_res.end)
> +		memblock_mark_nomap(crashk_res.start,
> +				    resource_size(&crashk_res));
> +#endif
> +
> +#endif
>  	/* map all the memory banks */
>  	for_each_mem_range(i, &start, &end) {
>  		if (start >= end)
> @@ -554,6 +566,21 @@ static void __init map_mem(pgd_t *pgdp)
>  	__map_memblock(pgdp, kernel_start, kernel_end,
>  		       PAGE_KERNEL, NO_CONT_MAPPINGS);
>  	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> +#if IS_ENABLED(CONFIG_KEXEC_CORE) && \
> +    !IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)
> +	/*
> +	 * Use page-level mappings here so that we can shrink the region
> +	 * in page granularity and put back unused memory to buddy system
> +	 * through /sys/kernel/kexec_crash_size interface.
> +	 */
> +	if (crashk_res.end) {
> +		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
> +			       PAGE_KERNEL,
> +			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> +		memblock_clear_nomap(crashk_res.start,
> +				     resource_size(&crashk_res));
> +	}
> +#endif
>  }
>  
>  void mark_rodata_ro(void)
> -- 
> 2.35.1
> 

-- 
Sincerely yours,
Mike.
