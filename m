Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637AF5A77A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiHaHh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiHaHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:37:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E900CAFAF6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82B38B81FA2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02F1C433C1;
        Wed, 31 Aug 2022 07:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661931470;
        bh=44BdU4sLNGCRQ5AhEHCk9LQYYFBQJX/hcXMrTfgJIFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4t9xf204eWR39NhCBIZ/wlUrKq9FpFvplT2VVWqm+xS4a3S4lklcQG9InjcsIqwq
         fYJJvMlA8gFk66RtsuyLlvT/hOrAU7C5uCZNiLfvXrhLMnbU13W9MlFAIZIiSJ0MSi
         c2dg4eDU2kS+4ujWG2oYo3MJkKvaPNXWfeaLsWp7oXYueeslCw9i5bw9gbv89mferQ
         0muCgix7vrYFOBXt5XYWB8v5NS7CyDJVA0AtuYDqHSA+iA+jbNQDcqto6lUcKL+Rej
         SMtzdI6n/b8/GV1JFWk1+by9vPXZvX1lvvOsy3Pd0zsVQr8amg2kfsqC0D7xsdCrfV
         WBiYPR/+loyQA==
Date:   Wed, 31 Aug 2022 10:37:32 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, ardb@kernel.org,
        guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
        will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <Yw8PvF5d2uuWy6Cl@kernel.org>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828005545.94389-2-bhe@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 08:55:44AM +0800, Baoquan He wrote:
> Problem:
> =======
> On arm64, block and section mapping is supported to build page tables.
> However, currently it enforces to take base page mapping for the whole
> linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
> crashkernel kernel parameter is set. This will cause longer time of the
> linear mapping process during bootup and severe performance degradation
> during running time.
> 
> Root cause:
> ==========
> On arm64, crashkernel reservation relies on knowing the upper limit of
> low memory zone because it needs to reserve memory in the zone so that
> devices' DMA addressing in kdump kernel can be satisfied. However, the
> limit on arm64 is variant. And the upper limit can only be decided late
> till bootmem_init() is called.
> 
> And we need to map the crashkernel region with base page granularity when
> doing linear mapping, because kdump needs to protect the crashkernel region
> via set_memory_valid(,0) after kdump kernel loading. However, arm64 doesn't
> support well on splitting the built block or section mapping due to some
> cpu reststriction [1]. And unfortunately, the linear mapping is done before
> bootmem_init().
> 
> To resolve the above conflict on arm64, the compromise is enforcing to
> take base page mapping for the entire linear mapping if crashkernel is
> set, and CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabed. Hence
> performance is sacrificed.
> 
> Solution:
> =========
> To fix the problem, we should always take 4G as the crashkernel low
> memory end in case CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled.
> With this, we don't need to defer the crashkernel reservation till
> bootmem_init() is called to set the arm64_dma_phys_limit. As long as
> memblock init is done, we can conclude what is the upper limit of low
> memory zone.
> 
> 1) both CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled or memblock_start_of_DRAM() > 4G
>   limit = PHYS_ADDR_MAX+1  (Corner cases)

Why these are corner cases? 
The case when CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled is the
simplest one because it does not require the whole dancing around
arm64_dma_phys_limit initialization.

And AFAIK, memblock_start_of_DRAM() > 4G is not uncommon on arm64, but it
does not matter for device DMA addressing.

The actual corner cases are systems with ZONE_DMA/DMA32 and with <32 bits
limit for device DMA addressing (e.g RPi 4). I think the changelog should
mention that to use kdump on these devices user must specify
crashkernel=X@Y 

> 2) CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are enabled:
>    limit = 4G  (generic case)
> 
> [1]
> https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/mm/init.c | 24 ++++++++++++++----------
>  arch/arm64/mm/mmu.c  | 38 ++++++++++++++++++++++----------------
>  2 files changed, 36 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index b9af30be813e..8ae55afdd11c 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -90,10 +90,22 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
>  phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>  #endif

Please also update the comment above this hunk.

> +static phys_addr_t __init crash_addr_low_max(void)
> +{
> +	phys_addr_t low_mem_mask = U32_MAX;
> +	phys_addr_t phys_start = memblock_start_of_DRAM();
> +
> +	if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
> +	     (phys_start > U32_MAX))
> +		low_mem_mask = PHYS_ADDR_MAX;
> +
> +	return min(low_mem_mask, memblock_end_of_DRAM() - 1) + 1;

Since RAM frequently starts on non-zero address the limit for systems with
ZONE_DMA/DMA32 should be memblock_start_of_DRAM() + 4G. There is no need to
take into the account the end of DRAM, memblock allocation will take care
of that. I'd suggest to simplify crash_addr_low_max() to be

static phys_addr_t __init crash_addr_low_max(void)
{
	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
		return memblock_start_of_DRAM() + SZ_4G;

	return PHYS_ADDR_MAX;
}

> +}
> +
>  /* Current arm64 boot protocol requires 2MB alignment */
>  #define CRASH_ALIGN			SZ_2M
>  
> -#define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
> +#define CRASH_ADDR_LOW_MAX		crash_addr_low_max()

With introduction of crash_addr_low_max() I think it's better to get rid of
the CRASH_ADDR_LOW_MAX and use local variables in reserve_crashkernel() and
reserve_crashkernel_low() that would get initialized to
crash_addr_low_max().

Besides, #ifdef around arm64_dma_phys_limit declaration can go away because
this variable will be used only after it is initialized in
zone_sizes_init().

>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
>  
>  static int __init reserve_crashkernel_low(unsigned long long low_size)
> @@ -389,8 +401,7 @@ void __init arm64_memblock_init(void)
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> -	if (!defer_reserve_crashkernel())
> -		reserve_crashkernel();
> +	reserve_crashkernel();
>  
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  }
> @@ -434,13 +445,6 @@ void __init bootmem_init(void)
>  	 */
>  	dma_contiguous_reserve(arm64_dma_phys_limit);
>  
> -	/*
> -	 * request_standard_resources() depends on crashkernel's memory being
> -	 * reserved, so do it here.
> -	 */
> -	if (defer_reserve_crashkernel())
> -		reserve_crashkernel();
> -
>  	memblock_dump_all();
>  }
>  
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e7ad44585f40..cdd338fa2115 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -547,13 +547,12 @@ static void __init map_mem(pgd_t *pgdp)
>  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>  
>  #ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map) {
> -		if (defer_reserve_crashkernel())
> -			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> -		else if (crashk_res.end)
> -			memblock_mark_nomap(crashk_res.start,
> -			    resource_size(&crashk_res));
> -	}
> +	if (crashk_res.end)
> +		memblock_mark_nomap(crashk_res.start,
> +				    resource_size(&crashk_res));
> +	if (crashk_low_res.end)
> +		memblock_mark_nomap(crashk_low_res.start,
> +				    resource_size(&crashk_low_res));
>  #endif
>  
>  	/* map all the memory banks */
> @@ -589,16 +588,23 @@ static void __init map_mem(pgd_t *pgdp)
>  	 * through /sys/kernel/kexec_crash_size interface.
>  	 */
>  #ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map && !defer_reserve_crashkernel()) {
> -		if (crashk_res.end) {
> -			__map_memblock(pgdp, crashk_res.start,
> -				       crashk_res.end + 1,
> -				       PAGE_KERNEL,
> -				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> -			memblock_clear_nomap(crashk_res.start,
> -					     resource_size(&crashk_res));
> -		}
> +	if (crashk_res.end) {
> +		__map_memblock(pgdp, crashk_res.start,
> +			       crashk_res.end + 1,
> +			       PAGE_KERNEL,
> +			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> +		memblock_clear_nomap(crashk_res.start,
> +				     resource_size(&crashk_res));
>  	}
> +	if (crashk_low_res.end) {
> +		__map_memblock(pgdp, crashk_low_res.start,
> +			       crashk_low_res.end + 1,
> +			       PAGE_KERNEL,
> +			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> +		memblock_clear_nomap(crashk_low_res.start,
> +				     resource_size(&crashk_low_res));
> +	}
> +
>  #endif
>  }
>  
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
