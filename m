Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCDD4B9D90
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbiBQKuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:50:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiBQKuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:50:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1470C1ED1E7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:50:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5E3DB82171
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F75EC340E8;
        Thu, 17 Feb 2022 10:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645095001;
        bh=V5/vdsYX/un8H0kUy8bihughcNy3eq6MQO+YbmfOOTs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JCv3V8gFFGQhVmq6dxfWkx+4qDh93wxw6pGplOggWfW2jWMKWc4SQ/WS4pczozvzg
         mSC/GrCzDyuq1Cbyl6LNwYwZzknV8jhSHtL6gLYHIh7jqpu85RdOZoewW06sOL01ZO
         Dtk3oD5XJfk0scuSuG4eyIXC9c92cMu5VJFWHx+HSrWcwJuXftQN3Ob4M0Y9pahF+w
         nCG0DFuPs/a/ADCoiPbK6ZQM4GLrpMHMQ0vz7ubXFuqsYDjoR0359u7P/lBFYbWNwA
         O97i4LqWkIP3yGpqLIbVWscVGR2epy9KM9OYXDo/9LreHSlE/eb4GKOeakUc67Rdb/
         3XtQXV7Fb070A==
Message-ID: <ed4f4589f322bd3871f825239985410b535df30e.camel@kernel.org>
Subject: Re: [PATCH] arm64: Do not defer reserve_crashkernel() for platforms
 with no DMA memory zones
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 17 Feb 2022 11:49:56 +0100
In-Reply-To: <1645056294-6509-1-git-send-email-vijayb@linux.microsoft.com>
References: <1645056294-6509-1-git-send-email-vijayb@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-16 at 16:04 -0800, Vijay Balakrishna wrote:
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
> [1] https://lore.kernel.org/all/9436d033-579b-55fa-9b00-6f4b661c2dd7@linux.microsoft.com/
> 
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> ---
> Tested changes to confirm no ~150ms boot slowdown on our SoC with IOMMU
> and 8GB memory.  Also tested with ZONE_DMA and/or ZONE_DMA32 configs to confirm
> no regression to deferring scheme of crash kernel memory reservation.
> In both cases successfully collected kernel crash dump.
> ---
>  arch/arm64/mm/init.c | 14 +++++++++++---
>  arch/arm64/mm/mmu.c  | 24 +++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index db63cc885771..f2a982c19b75 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -62,7 +62,11 @@ EXPORT_SYMBOL(memstart_addr);
>   * In such case, ZONE_DMA32 covers the rest of the 32-bit addressable memory,
>   * otherwise it is empty.
>   */
> -phys_addr_t arm64_dma_phys_limit __ro_after_init;
> +#if !defined(CONFIG_ZONE_DMA) && !defined(CONFIG_ZONE_DMA32)
> +phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
> +#else
> +phys_addr_t __ro_after_init arm64_dma_phys_limit;
> +#endif
>  
>  #ifdef CONFIG_KEXEC_CORE
>  /*
> @@ -153,8 +157,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  	if (!arm64_dma_phys_limit)
>  		arm64_dma_phys_limit = dma32_phys_limit;
>  #endif
> -	if (!arm64_dma_phys_limit)
> -		arm64_dma_phys_limit = PHYS_MASK + 1;
>  	max_zone_pfns[ZONE_NORMAL] = max;
>  
>  	free_area_init(max_zone_pfns);
> @@ -315,6 +317,10 @@ void __init arm64_memblock_init(void)
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> +#if !defined(CONFIG_ZONE_DMA) && !defined(CONFIG_ZONE_DMA32)
> +	reserve_crashkernel();
> +#endif
> +
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  }
>  
> @@ -357,11 +363,13 @@ void __init bootmem_init(void)
>  	 */
>  	dma_contiguous_reserve(arm64_dma_phys_limit);
>  
> +#if defined(CONFIG_ZONE_DMA) || defined(CONFIG_ZONE_DMA32)
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
> index acfae9b41cc8..e7faf5edccfc 100644
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
> @@ -528,6 +528,14 @@ static void __init map_mem(pgd_t *pgdp)
>  	 */
>  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>  
> +#ifdef CONFIG_KEXEC_CORE
> +	if (crash_mem_map && !crashk_res.end)
> +		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;

Using IS_ENABLED(ZONE_DMA/DMA32) instead of '!crashk_res.end' would be more
efficient and a bit more explicit IMO.

>  	/* map all the memory banks */
>  	for_each_mem_range(i, &start, &end) {
>  		if (start >= end)
> @@ -554,6 +562,20 @@ static void __init map_mem(pgd_t *pgdp)
>  	__map_memblock(pgdp, kernel_start, kernel_end,
>  		       PAGE_KERNEL, NO_CONT_MAPPINGS);
>  	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> +#ifdef CONFIG_KEXEC_CORE
> +	/*
> +	 * Use page-level mappings here so that we can shrink the region
> +	 * in page granularity and put back unused memory to buddy system
> +	 * through /sys/kernel/kexec_crash_size interface.
> +	 */
> +	if (crashk_res.end) {

Same here.

> +		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
> +			       PAGE_KERNEL,
> +			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> +		memblock_clear_nomap(crashk_res.start,
> +				     resource_size(&crashk_res));
> +	}
> +#endif

Now, I carefully reviewed the patch and it seems to be doing the right thing.
But even while knowlegable on the topic, it took a good amount of effort to
untangle the possible code paths. I suspect it's going to be painful to
maintain. I'd suggest at least introducing a comment explaining the situation.

If there approach if deemed acceptable, I'll test is on the RPi4.

Regards,
Nicolas
