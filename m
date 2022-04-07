Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E97A4F8105
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbiDGNys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242816AbiDGNyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:54:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6531179A9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:52:43 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KZ2pL6SPHz67yBh;
        Thu,  7 Apr 2022 21:50:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 15:52:40 +0200
Received: from [10.47.80.129] (10.47.80.129) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 14:52:39 +0100
Message-ID: <300b0973-841a-0dc3-16b4-0028427abe12@huawei.com>
Date:   Thu, 7 Apr 2022 14:52:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RESEND v5 5/5] iova: Add iova_len argument to
 iova_domain_init_rcaches()
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <chenxiang66@hisilicon.com>, <jean-philippe@linaro.org>,
        <linuxarm@huawei.com>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
 <1649071634-188535-6-git-send-email-john.garry@huawei.com>
 <b09aeef5-106c-b477-e16b-a537929cb7c1@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <b09aeef5-106c-b477-e16b-a537929cb7c1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.129]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 09:27, Leizhen (ThunderTown) wrote:
> 

Thanks for having a look....

> 
> On 2022/4/4 19:27, John Garry wrote:
>> Add max opt argument to iova_domain_init_rcaches(), and use it to set the
>> rcaches range.
>>
>> Also fix up all users to set this value (at 0, meaning use default),
>> including a wrapper for that, iova_domain_init_rcaches_default().
>>
>> For dma-iommu.c we derive the iova_len argument from the IOMMU group
>> max opt DMA size.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/iommu/dma-iommu.c            | 15 ++++++++++++++-
>>   drivers/iommu/iova.c                 | 19 ++++++++++++++++---
>>   drivers/vdpa/vdpa_user/iova_domain.c |  4 ++--
>>   include/linux/iova.h                 |  3 ++-
>>   4 files changed, 34 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 42ca42ff1b5d..19f35624611c 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -525,6 +525,8 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>   	unsigned long order, base_pfn;
>>   	struct iova_domain *iovad;
>> +	size_t max_opt_dma_size;
>> +	unsigned long iova_len = 0;
>>   	int ret;
>>   
>>   	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
>> @@ -560,7 +562,18 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>   	}
>>   
>>   	init_iova_domain(iovad, 1UL << order, base_pfn);
>> -	ret = iova_domain_init_rcaches(iovad);
>> +
>> +	max_opt_dma_size = iommu_group_get_max_opt_dma_size(dev->iommu_group);
>> +	if (max_opt_dma_size) {
>> +		unsigned long shift = __ffs(1UL << order);
>> +
>> +		iova_len = roundup_pow_of_two(max_opt_dma_size);
>> +		iova_len >>= shift;
>> +		if (!iova_len)
>> +			iova_len = 1;
> 
> How about move "iovad->rcache_max_size = iova_len_to_rcache_max(iova_len);" here? So that,
> iova_domain_init_rcaches() can remain the same. And iova_domain_init_rcaches_default() does
> not need to be added.
> 

I see your idea. I will say that I would rather not add 
iova_domain_init_rcaches_default(). But personally I think it's better 
to setup all rcache stuff only once and inside 
iova_domain_init_rcaches(), as it is today.

In addition, it doesn't look reasonable to expose iova_len_to_rcache_max().

But maybe it's ok. Other opinion would be welcome...

Thanks,
John

>> +	}
>> +
>> +	ret = iova_domain_init_rcaches(iovad, iova_len);
>>   	if (ret)
>>   		return ret;
>>   
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 5c22b9187b79..d65e79e132ee 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -706,12 +706,20 @@ static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>>   	mag->pfns[mag->size++] = pfn;
>>   }
>>   
>> -int iova_domain_init_rcaches(struct iova_domain *iovad)
>> +static unsigned long iova_len_to_rcache_max(unsigned long iova_len)
>> +{
>> +	return order_base_2(iova_len) + 1;
>> +}
>> +
>> +int iova_domain_init_rcaches(struct iova_domain *iovad, unsigned long iova_len)
>>   {
>>   	unsigned int cpu;
>>   	int i, ret;
>>   
>> -	iovad->rcache_max_size = 6; /* Arbitrarily high default */
>> +	if (iova_len)
>> +		iovad->rcache_max_size = iova_len_to_rcache_max(iova_len);
>> +	else
>> +		iovad->rcache_max_size = 6; /* Arbitrarily high default */
>>   
>>   	iovad->rcaches = kcalloc(iovad->rcache_max_size,
>>   				 sizeof(struct iova_rcache),
>> @@ -755,7 +763,12 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>>   	free_iova_rcaches(iovad);
>>   	return ret;
>>   }
>> -EXPORT_SYMBOL_GPL(iova_domain_init_rcaches);
>> +
>> +int iova_domain_init_rcaches_default(struct iova_domain *iovad)
>> +{
>> +	return iova_domain_init_rcaches(iovad, 0);
>> +}
>> +EXPORT_SYMBOL_GPL(iova_domain_init_rcaches_default);
>>   
>>   /*
>>    * Try inserting IOVA range starting with 'iova_pfn' into 'rcache', and
>> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
>> index 6daa3978d290..3a2acef98a4a 100644
>> --- a/drivers/vdpa/vdpa_user/iova_domain.c
>> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
>> @@ -514,12 +514,12 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
>>   	spin_lock_init(&domain->iotlb_lock);
>>   	init_iova_domain(&domain->stream_iovad,
>>   			PAGE_SIZE, IOVA_START_PFN);
>> -	ret = iova_domain_init_rcaches(&domain->stream_iovad);
>> +	ret = iova_domain_init_rcaches_default(&domain->stream_iovad);
>>   	if (ret)
>>   		goto err_iovad_stream;
>>   	init_iova_domain(&domain->consistent_iovad,
>>   			PAGE_SIZE, bounce_pfns);
>> -	ret = iova_domain_init_rcaches(&domain->consistent_iovad);
>> +	ret = iova_domain_init_rcaches_default(&domain->consistent_iovad);
>>   	if (ret)
>>   		goto err_iovad_consistent;
>>   
>> diff --git a/include/linux/iova.h b/include/linux/iova.h
>> index 02f7222fa85a..56281434ce0c 100644
>> --- a/include/linux/iova.h
>> +++ b/include/linux/iova.h
>> @@ -95,7 +95,8 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
>>   	unsigned long pfn_hi);
>>   void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>>   	unsigned long start_pfn);
>> -int iova_domain_init_rcaches(struct iova_domain *iovad);
>> +int iova_domain_init_rcaches(struct iova_domain *iovad, unsigned long iova_len);
>> +int iova_domain_init_rcaches_default(struct iova_domain *iovad);
>>   struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>>   void put_iova_domain(struct iova_domain *iovad);
>>   #else
>>
> 

