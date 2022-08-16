Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC2595EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiHPPCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiHPPCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:02:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5094C8670E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:00:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF3E51424;
        Tue, 16 Aug 2022 08:00:33 -0700 (PDT)
Received: from [10.57.13.180] (unknown [10.57.13.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB3EC3F66F;
        Tue, 16 Aug 2022 08:00:31 -0700 (PDT)
Message-ID: <413d8666-7a82-efd7-6716-13658016ca10@arm.com>
Date:   Tue, 16 Aug 2022 16:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] mm/dmapool.c: avoid duplicate memset within
 dma_pool_alloc
Content-Language: en-GB
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liu Song <liusong@linux.alibaba.com>,
        akpm@linux-foundation.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <1658125690-76930-1-git-send-email-liusong@linux.alibaba.com>
 <CGME20220816123958eucas1p1b03a5efa1f5804245a5c1a9b27529015@eucas1p1.samsung.com>
 <1dbe63ff-5575-745b-653a-a992ae53e1aa@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1dbe63ff-5575-745b-653a-a992ae53e1aa@samsung.com>
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

On 2022-08-16 13:39, Marek Szyprowski wrote:
> Hi,
> 
> On 18.07.2022 08:28, Liu Song wrote:
>> From: Liu Song <liusong@linux.alibaba.com>
>>
>> In "dma_alloc_from_dev_coherent" and "dma_direct_alloc",
>> the allocated memory is explicitly set to 0.
>>
>> A helper function "use_dev_coherent_memory" is introduced here to
>> determine whether the memory is allocated by "dma_alloc_from_dev_coherent".
>>
>> And use "get_dma_ops" to determine whether the memory is allocated by
>> "dma_direct_alloc".
>>
>> After this modification, memory allocated using "dma_pool_zalloc" can avoid
>> duplicate memset.
>>
>> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> 
> This patch landed linux next-20220816. Unfortunately it causes serious
> issues on ARM 32bit systems. I've observed it on ARM 32bit Samsung
> Exynos 5422 based Odroid XU4 board with USB r8152 driver. After applying
> this patch and loading r8152 driver I only the following endless
> messages in the log:
> 
> xhci-hcd xhci-hcd.9.auto: WARN Event TRB for slot 1 ep 0 with no TDs queued?
> xhci-hcd xhci-hcd.9.auto: WARN Event TRB for slot 1 ep 0 with no TDs queued?
> xhci-hcd xhci-hcd.9.auto: WARN Event TRB for slot 1 ep 0 with no TDs queued?
> 
> It looks that there are drivers which rely on the fact that the dma
> coherent buffers are always zeroed.

It's not even that, the change here is just obviously broken, since it 
ends up entirely ignoring want_init_on_alloc() for devices using 
dma-direct. Sure, the memory backing a dma_page is zeroed *once* by its 
initial dma-coherent allocation, but who says we're not not reallocating 
pool entries from an existing dma_page?

I'm not convinced it's worth trying to special-case this at all, since 
we can only do it reliably for the first pool entry allocated from a new 
dma_page, and that will only happen as the pool initially grows to a 
suitable size for its working set, after which no further new pages are 
likely to be allocated for the lifetime of the pool. Even if there is a 
case to be made for doing so, it would need to be based on the flow 
through dma_pool_alloc() itself, not some nonsense heuristic on the device.

Andrew, please drop this patch.

Thanks,
Robin.

>> ---
>>    include/linux/dma-map-ops.h | 5 +++++
>>    mm/dmapool.c                | 5 ++++-
>>    2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
>> index 0d5b06b..c29948d 100644
>> --- a/include/linux/dma-map-ops.h
>> +++ b/include/linux/dma-map-ops.h
>> @@ -171,6 +171,10 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
>>    int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
>>    int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
>>    		void *cpu_addr, size_t size, int *ret);
>> +static inline bool use_dev_coherent_memory(struct device *dev)
>> +{
>> +	return dev->dma_mem ? true : false;
>> +}
>>    #else
>>    static inline int dma_declare_coherent_memory(struct device *dev,
>>    		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
>> @@ -180,6 +184,7 @@ static inline int dma_declare_coherent_memory(struct device *dev,
>>    #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
>>    #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
>>    #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
>> +#define use_dev_coherent_memory(dev) (0)
>>    #endif /* CONFIG_DMA_DECLARE_COHERENT */
>>    
>>    #ifdef CONFIG_DMA_GLOBAL_POOL
>> diff --git a/mm/dmapool.c b/mm/dmapool.c
>> index a7eb5d0..6e03530 100644
>> --- a/mm/dmapool.c
>> +++ b/mm/dmapool.c
>> @@ -21,6 +21,7 @@
>>    
>>    #include <linux/device.h>
>>    #include <linux/dma-mapping.h>
>> +#include <linux/dma-map-ops.h>
>>    #include <linux/dmapool.h>
>>    #include <linux/kernel.h>
>>    #include <linux/list.h>
>> @@ -372,7 +373,9 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
>>    #endif
>>    	spin_unlock_irqrestore(&pool->lock, flags);
>>    
>> -	if (want_init_on_alloc(mem_flags))
>> +	if (want_init_on_alloc(mem_flags) &&
>> +		!use_dev_coherent_memory(pool->dev) &&
>> +		get_dma_ops(pool->dev))
>>    		memset(retval, 0, pool->size);
>>    
>>    	return retval;
> 
> Best regards
