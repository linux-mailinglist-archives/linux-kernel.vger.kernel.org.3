Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA65575A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiFWIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiFWIiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:38:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD75A1FCEB;
        Thu, 23 Jun 2022 01:38:09 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LTD9f6t10z67wtW;
        Thu, 23 Jun 2022 16:36:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 23 Jun 2022 10:38:07 +0200
Received: from [10.195.245.183] (10.195.245.183) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:38:06 +0100
Message-ID: <ebe0ce98-4a02-1e94-d21b-ccb010abfd2d@huawei.com>
Date:   Thu, 23 Jun 2022 09:38:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-scsi@vger.kernel.org>, <liyihang6@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>,
        <damien.lemoal@opensource.wdc.com>, <m.szyprowski@samsung.com>,
        <martin.petersen@oracle.com>, <jejb@linux.ibm.com>, <hch@lst.de>
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-3-git-send-email-john.garry@huawei.com>
 <4a3ab043-f609-22cb-895f-e67c8dd8f6ab@huawei.com>
In-Reply-To: <4a3ab043-f609-22cb-895f-e67c8dd8f6ab@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.245.183]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2022 14:12, John Garry wrote:
> On 06/06/2022 10:30, John Garry wrote:
>> Add the IOMMU callback for DMA mapping API dma_opt_mapping_size(), which
>> allows the drivers to know the optimal mapping limit and thus limit the
>> requested IOVA lengths.
>>
>> This value is based on the IOVA rcache range limit, as IOVAs allocated
>> above this limit must always be newly allocated, which may be quite slow.
>>
> 
> Can I please get some sort of ack from the IOMMU people on this one?
> 

Another request for an ack please.

Thanks,
john

> 
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 6 ++++++
>>   drivers/iommu/iova.c      | 5 +++++
>>   include/linux/iova.h      | 2 ++
>>   3 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index f90251572a5d..9e1586447ee8 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -1459,6 +1459,11 @@ static unsigned long 
>> iommu_dma_get_merge_boundary(struct device *dev)
>>       return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>>   }
>> +static size_t iommu_dma_opt_mapping_size(void)
>> +{
>> +    return iova_rcache_range();
>> +}
>> +
>>   static const struct dma_map_ops iommu_dma_ops = {
>>       .alloc            = iommu_dma_alloc,
>>       .free            = iommu_dma_free,
>> @@ -1479,6 +1484,7 @@ static const struct dma_map_ops iommu_dma_ops = {
>>       .map_resource        = iommu_dma_map_resource,
>>       .unmap_resource        = iommu_dma_unmap_resource,
>>       .get_merge_boundary    = iommu_dma_get_merge_boundary,
>> +    .opt_mapping_size    = iommu_dma_opt_mapping_size,
>>   };
>>   /*
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index db77aa675145..9f00b58d546e 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -26,6 +26,11 @@ static unsigned long iova_rcache_get(struct 
>> iova_domain *iovad,
>>   static void free_cpu_cached_iovas(unsigned int cpu, struct 
>> iova_domain *iovad);
>>   static void free_iova_rcaches(struct iova_domain *iovad);
>> +unsigned long iova_rcache_range(void)
>> +{
>> +    return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
>> +}
>> +
>>   static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
>>   {
>>       struct iova_domain *iovad;
>> diff --git a/include/linux/iova.h b/include/linux/iova.h
>> index 320a70e40233..c6ba6d95d79c 100644
>> --- a/include/linux/iova.h
>> +++ b/include/linux/iova.h
>> @@ -79,6 +79,8 @@ static inline unsigned long iova_pfn(struct 
>> iova_domain *iovad, dma_addr_t iova)
>>   int iova_cache_get(void);
>>   void iova_cache_put(void);
>> +unsigned long iova_rcache_range(void);
>> +
>>   void free_iova(struct iova_domain *iovad, unsigned long pfn);
>>   void __free_iova(struct iova_domain *iovad, struct iova *iova);
>>   struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
> 

