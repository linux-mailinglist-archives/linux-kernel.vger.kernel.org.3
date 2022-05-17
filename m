Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3382529FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245642AbiEQKlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344446AbiEQKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:41:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B784B49A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:41:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E845A1042;
        Tue, 17 May 2022 03:40:59 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 590E93F66F;
        Tue, 17 May 2022 03:40:58 -0700 (PDT)
Message-ID: <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
Date:   Tue, 17 May 2022 11:40:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, hch@lst.de, m.szyprowski@samsung.com
Cc:     chenxiang66@hisilicon.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        liyihang6@hisilicon.com
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-16 14:06, John Garry wrote:
> For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
> exceeds the IOVA rcache upper limit (meaning that they are not cached),
> performance can be reduced.
> 
> Add the IOMMU callback for DMA mapping API dma_max_mapping_size(), which
> allows the drivers to know the mapping limit and thus limit the requested
> IOVA lengths.
> 
> This resolves the performance issue originally reported in [0] for a SCSI
> HBA driver which was regularly mapping SGLs which required IOVAs in
> excess of the IOVA caching limit. In this case the block layer limits the
> max sectors per request - as configured in __scsi_init_queue() - which
> will limit the total SGL length the driver tries to map and in turn limits
> IOVA lengths requested.
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> Sending as an RFC as iommu_dma_max_mapping_size() is a soft limit, and not
> a hard limit which I expect is the semantics of dma_map_ops.max_mapping_size

Indeed, sorry but NAK for this being nonsense. As I've said at least 
once before, if the unnecessary SAC address allocation attempt slows 
down your workload, make it not do that in the first place. If you don't 
like the existing command-line parameter then fine, there are plenty of 
other options, it just needs to be done in a way that doesn't break x86 
systems with dodgy firmware, as my first attempt turned out to.

Furthermore, if a particular SCSI driver doesn't benefit from mappings 
larger than 256KB, then that driver is also free to limit its own 
mapping size. There are other folks out there with use-cases for mapping 
*gigabytes* at once; you don't get to cripple the API and say that 
that's suddenly not allowed just because it happens to make your thing 
go faster, that's absurd.

Thanks,
Robin.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..e2d5205cde37 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1442,6 +1442,21 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>   	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>   }
>   
> +static size_t iommu_dma_max_mapping_size(struct device *dev)
> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct iommu_dma_cookie *cookie;
> +
> +	if (!domain)
> +		return 0;
> +
> +	cookie = domain->iova_cookie;
> +	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
> +		return 0;
> +
> +	return iova_rcache_range();
> +}
> +
>   static const struct dma_map_ops iommu_dma_ops = {
>   	.alloc			= iommu_dma_alloc,
>   	.free			= iommu_dma_free,
> @@ -1462,6 +1477,7 @@ static const struct dma_map_ops iommu_dma_ops = {
>   	.map_resource		= iommu_dma_map_resource,
>   	.unmap_resource		= iommu_dma_unmap_resource,
>   	.get_merge_boundary	= iommu_dma_get_merge_boundary,
> +	.max_mapping_size	= iommu_dma_max_mapping_size,
>   };
>   
>   /*
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index db77aa675145..9f00b58d546e 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -26,6 +26,11 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>   static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
>   static void free_iova_rcaches(struct iova_domain *iovad);
>   
> +unsigned long iova_rcache_range(void)
> +{
> +	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
> +}
> +
>   static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
>   {
>   	struct iova_domain *iovad;
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 320a70e40233..ae3e18d77e6c 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -79,6 +79,8 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
>   int iova_cache_get(void);
>   void iova_cache_put(void);
>   
> +unsigned long iova_rcache_range(void);
> +
>   void free_iova(struct iova_domain *iovad, unsigned long pfn);
>   void __free_iova(struct iova_domain *iovad, struct iova *iova);
>   struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
> @@ -105,6 +107,11 @@ static inline void iova_cache_put(void)
>   {
>   }
>   
> +static inline unsigned long iova_rcache_range(void)
> +{
> +	return 0;
> +}
> +
>   static inline void free_iova(struct iova_domain *iovad, unsigned long pfn)
>   {
>   }
