Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17B949D14F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiAZR6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:58:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4519 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiAZR6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:58:40 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JkWZ23WBCz6FGPH;
        Thu, 27 Jan 2022 01:54:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 18:58:38 +0100
Received: from [10.47.86.172] (10.47.86.172) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 26 Jan
 2022 17:58:37 +0000
Subject: Re: [PATCH] iommu/iova: Separate out rcache init
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC:     "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1643205319-51669-1-git-send-email-john.garry@huawei.com>
 <ee4593b8-cdf6-935a-0eaf-48a8bfeae912@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0ec8829e-aef3-eee7-17cf-416b28db3c4c@huawei.com>
Date:   Wed, 26 Jan 2022 17:58:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <ee4593b8-cdf6-935a-0eaf-48a8bfeae912@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.172]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

>>
>> Signed-off-by: John Garry<john.garry@huawei.com>
> Mangled patch? (no "---" separator here)

hmm... not sure. As an experiment, I just downloaded this patch from 
lore.kernel.org and it applies ok.

> 
> Overall this looks great, just a few comments further down...
> 

...

>> +}
>> +EXPORT_SYMBOL_GPL(iova_domain_init_rcaches);
>> +
>> +void iova_domain_free_rcaches(struct iova_domain *iovad)
>> +{
>> +	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
>> +					    &iovad->cpuhp_dead);
>> +	free_iova_rcaches(iovad);
>>    }
>> +EXPORT_SYMBOL_GPL(iova_domain_free_rcaches);
> I think we should continue to expect external callers to clean up with
> put_iova_domain(). 

ok, fine, makes sense

> If they aren't doing that already they have a bug
> (albeit minor), and we don't want to give the impression that it's OK to
> free the caches at any point*other*  than tearing down the whole
> iova_domain, since the implementation really wouldn't expect that.
> 
>>    /*
>>     * Try inserting IOVA range starting with 'iova_pfn' into 'rcache', and
>> @@ -831,7 +872,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>>    {
>>    	unsigned int log_size = order_base_2(size);
>>    
>> -	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
>> +	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
>>    		return 0;
>>    

..

>> @@ -102,6 +92,8 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
>>    	unsigned long pfn_hi);
>>    void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>>    	unsigned long start_pfn);
>> +int iova_domain_init_rcaches(struct iova_domain *iovad);
>> +void iova_domain_free_rcaches(struct iova_domain *iovad);
> As above, I vote for just forward-declaring the free routine in iova.c
> and keeping it entirely private.

ok

> 
>>    struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>>    void put_iova_domain(struct iova_domain *iovad);
>>    #else
>> @@ -157,6 +149,15 @@ static inline void init_iova_domain(struct iova_domain *iovad,
>>    {
>>    }
>>    
>> +static inline int iova_domain_init_rcaches(struct iova_domain *iovad)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline void iova_domain_free_rcaches(struct iova_domain *iovad)
>> +{
>> +}
>> +
> I'd be inclined not to add stubs at all - I think it's a reasonable
> assumption that anyone involved enough to care about rcaches has a hard
> dependency on IOMMU_IOVA already.

So iova_domain_free_rcaches() would disappear from here as a result of 
the changes discussed above.

As for iova_domain_init_rcaches(), I was just following the IOMMU/IOVA 
coding practice - that is, always stub.

> It's certainly the case today, and I'd
> hardly want to encourage more users anyway.

I think that stronger deterrents would be needed :)

Anyway, I can remove it.

Thanks,
John




