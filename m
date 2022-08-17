Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD315596EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbiHQMua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbiHQMuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:50:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E75718B9A4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:50:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76118152B;
        Wed, 17 Aug 2022 05:50:14 -0700 (PDT)
Received: from [10.57.13.141] (unknown [10.57.13.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A273A3F67D;
        Wed, 17 Aug 2022 05:50:12 -0700 (PDT)
Message-ID: <04790bd9-4f20-4d51-b988-ad4b44eeee98@arm.com>
Date:   Wed, 17 Aug 2022 13:50:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
References: <20220817060647.1032426-1-hch@lst.de>
 <20220817060647.1032426-4-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220817060647.1032426-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-17 07:06, Christoph Hellwig wrote:
> Limit the sizing of the atomic pools for allocations from
> ZONE_DMA and ZONE_DMA32 based on the number of pages actually
> present in those zones instead of the total memory.
> 
> Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
> Reported-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/pool.c | 40 +++++++++++++++++++++++++++++-----------
>   1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 5b07b0379a501..f629c6dfd8555 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -193,28 +193,46 @@ static unsigned long calculate_pool_size(unsigned long zone_pages)
>   	return max_t(unsigned long, nr_pages << PAGE_SHIFT, SZ_128K);
>   }
>   
> +#if defined(CONFIG_ZONE_DMA) || defined(CONFIG_ZONE_DMA32)

This #ifdeffery seems horribly clunky - I think it would be much nicer 
to mark this __maybe_unused, and preserve the has_managed_dma/IS_ENABLED 
logic below.

> +static unsigned long __init nr_managed_pages(int zone_idx)
> +{
> +	struct pglist_data *pgdat;
> +	unsigned long nr_pages = 0;
> +
> +	for_each_online_pgdat(pgdat)
> +		nr_pages += zone_managed_pages(&pgdat->node_zones[zone_idx]);
> +	return nr_pages;
> +}
> +#endif /* CONFIG_ZONE_DMA || CONFIG_ZONE_DMA32 */
> +
>   static int __init dma_atomic_pool_init(void)
>   {
> +	unsigned long nr_zone_dma_pages, nr_zone_dma32_pages;

...otherwise, I expect the buildbots will be along shortly with unused 
variable warnings for these :)

Cheers,
Robin.

> +
> +#ifdef CONFIG_ZONE_DMA
> +	nr_zone_dma_pages = nr_managed_pages(ZONE_DMA);
> +	if (nr_zone_dma_pages)
> +		atomic_pool_dma = __dma_atomic_pool_init(
> +				calculate_pool_size(nr_zone_dma_pages),
> +				GFP_DMA);
> +#endif
> +#ifdef CONFIG_ZONE_DMA32
> +	nr_zone_dma32_pages = nr_managed_pages(ZONE_DMA32);
> +	if (nr_zone_dma32_pages)
> +		atomic_pool_dma32 = __dma_atomic_pool_init(
> +				calculate_pool_size(nr_zone_dma32_pages),
> +				GFP_DMA32);
> +#endif
>   	/*
>   	 * If coherent_pool was not used on the command line, default the pool
>   	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
>   	 */
>   	if (!atomic_pool_size)
>   		atomic_pool_size = calculate_pool_size(totalram_pages());
> -
> -	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
> -
>   	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
>   						    GFP_KERNEL);
> -	if (has_managed_dma()) {
> -		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA);
> -	}
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
> -		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA32);
> -	}
>   
> +	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
>   	dma_atomic_pool_debugfs_init();
>   	return 0;
>   }
