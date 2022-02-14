Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D6F4B5197
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354303AbiBNN0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:26:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349573AbiBNN0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:26:20 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33D848892
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:26:11 -0800 (PST)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jy4jV4F9Dz6H6r4;
        Mon, 14 Feb 2022 21:25:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 14:26:09 +0100
Received: from [10.47.81.62] (10.47.81.62) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 14 Feb
 2022 13:26:08 +0000
Message-ID: <966c8e40-168c-9ee4-faeb-1f8c942eaea5@huawei.com>
Date:   Mon, 14 Feb 2022 13:26:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] iommu/iova: Separate out rcache init
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <jasowang@redhat.com>,
        <robin.murphy@arm.com>, <xieyongji@bytedance.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <linuxarm@huawei.com>
References: <1643882360-241739-1-git-send-email-john.garry@huawei.com>
 <20220203063345-mutt-send-email-mst@kernel.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220203063345-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.62]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2022 11:34, Michael S. Tsirkin wrote:
> On Thu, Feb 03, 2022 at 05:59:20PM +0800, John Garry wrote:
>> Currently the rcache structures are allocated for all IOVA domains, even if
>> they do not use "fast" alloc+free interface. This is wasteful of memory.
>>
>> In addition, fails in init_iova_rcaches() are not handled safely, which is
>> less than ideal.
>>
>> Make "fast" users call a separate rcache init explicitly, which includes
>> error checking.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> virtio things:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Cheers

Hi Robin,

Can you kindly give this your blessing if you are happy with it?

Thanks!

> 
>> ---
>> Differences to v1:
>> - Drop stubs for iova_domain_init_rcaches() and iova_domain_free_rcaches()
>> - Use put_iova_domain() in vdpa code
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index d85d54f2b549..b22034975301 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -525,6 +525,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>   	unsigned long order, base_pfn;
>>   	struct iova_domain *iovad;
>> +	int ret;
>>   
>>   	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
>>   		return -EINVAL;
>> @@ -559,6 +560,9 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>   	}
>>   
>>   	init_iova_domain(iovad, 1UL << order, base_pfn);
>> +	ret = iova_domain_init_rcaches(iovad);
>> +	if (ret)
>> +		return ret;
>>   
>>   	/* If the FQ fails we can simply fall back to strict mode */
>>   	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index b28c9435b898..7e9c3a97c040 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -15,13 +15,14 @@
>>   /* The anchor node sits above the top of the usable address space */
>>   #define IOVA_ANCHOR	~0UL
>>   
>> +#define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
>> +
>>   static bool iova_rcache_insert(struct iova_domain *iovad,
>>   			       unsigned long pfn,
>>   			       unsigned long size);
>>   static unsigned long iova_rcache_get(struct iova_domain *iovad,
>>   				     unsigned long size,
>>   				     unsigned long limit_pfn);
>> -static void init_iova_rcaches(struct iova_domain *iovad);
>>   static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
>>   static void free_iova_rcaches(struct iova_domain *iovad);
>>   
>> @@ -64,8 +65,6 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>>   	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
>>   	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
>>   	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
>> -	cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD, &iovad->cpuhp_dead);
>> -	init_iova_rcaches(iovad);
>>   }
>>   EXPORT_SYMBOL_GPL(init_iova_domain);
>>   
>> @@ -488,6 +487,13 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
>>   }
>>   EXPORT_SYMBOL_GPL(free_iova_fast);
>>   
>> +static void iova_domain_free_rcaches(struct iova_domain *iovad)
>> +{
>> +	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
>> +					    &iovad->cpuhp_dead);
>> +	free_iova_rcaches(iovad);
>> +}
>> +
>>   /**
>>    * put_iova_domain - destroys the iova domain
>>    * @iovad: - iova domain in question.
>> @@ -497,9 +503,9 @@ void put_iova_domain(struct iova_domain *iovad)
>>   {
>>   	struct iova *iova, *tmp;
>>   
>> -	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
>> -					    &iovad->cpuhp_dead);
>> -	free_iova_rcaches(iovad);
>> +	if (iovad->rcaches)
>> +		iova_domain_free_rcaches(iovad);
>> +
>>   	rbtree_postorder_for_each_entry_safe(iova, tmp, &iovad->rbroot, node)
>>   		free_iova_mem(iova);
>>   }
>> @@ -608,6 +614,7 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>>    */
>>   
>>   #define IOVA_MAG_SIZE 128
>> +#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
>>   
>>   struct iova_magazine {
>>   	unsigned long size;
>> @@ -620,6 +627,13 @@ struct iova_cpu_rcache {
>>   	struct iova_magazine *prev;
>>   };
>>   
>> +struct iova_rcache {
>> +	spinlock_t lock;
>> +	unsigned long depot_size;
>> +	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
>> +	struct iova_cpu_rcache __percpu *cpu_rcaches;
>> +};
>> +
>>   static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
>>   {
>>   	return kzalloc(sizeof(struct iova_magazine), flags);
>> @@ -693,28 +707,54 @@ static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>>   	mag->pfns[mag->size++] = pfn;
>>   }
>>   
>> -static void init_iova_rcaches(struct iova_domain *iovad)
>> +int iova_domain_init_rcaches(struct iova_domain *iovad)
>>   {
>> -	struct iova_cpu_rcache *cpu_rcache;
>> -	struct iova_rcache *rcache;
>>   	unsigned int cpu;
>> -	int i;
>> +	int i, ret;
>> +
>> +	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
>> +				 sizeof(struct iova_rcache),
>> +				 GFP_KERNEL);
>> +	if (!iovad->rcaches)
>> +		return -ENOMEM;
>>   
>>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>> +		struct iova_cpu_rcache *cpu_rcache;
>> +		struct iova_rcache *rcache;
>> +
>>   		rcache = &iovad->rcaches[i];
>>   		spin_lock_init(&rcache->lock);
>>   		rcache->depot_size = 0;
>> -		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
>> -		if (WARN_ON(!rcache->cpu_rcaches))
>> -			continue;
>> +		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
>> +						     cache_line_size());
>> +		if (!rcache->cpu_rcaches) {
>> +			ret = -ENOMEM;
>> +			goto out_err;
>> +		}
>>   		for_each_possible_cpu(cpu) {
>>   			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>> +
>>   			spin_lock_init(&cpu_rcache->lock);
>>   			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
>>   			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
>> +			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
>> +				ret = -ENOMEM;
>> +				goto out_err;
>> +			}
>>   		}
>>   	}
>> +
>> +	ret = cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
>> +					       &iovad->cpuhp_dead);
>> +	if (ret)
>> +		goto out_err;
>> +	return 0;
>> +
>> +out_err:
>> +	free_iova_rcaches(iovad);
>> +	return ret;
>>   }
>> +EXPORT_SYMBOL_GPL(iova_domain_init_rcaches);
>>   
>>   /*
>>    * Try inserting IOVA range starting with 'iova_pfn' into 'rcache', and
>> @@ -831,7 +871,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>>   {
>>   	unsigned int log_size = order_base_2(size);
>>   
>> -	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
>> +	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
>>   		return 0;
>>   
>>   	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
>> @@ -849,6 +889,8 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>>   
>>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>>   		rcache = &iovad->rcaches[i];
>> +		if (!rcache->cpu_rcaches)
>> +			break;
>>   		for_each_possible_cpu(cpu) {
>>   			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>>   			iova_magazine_free(cpu_rcache->loaded);
>> @@ -858,6 +900,9 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>>   		for (j = 0; j < rcache->depot_size; ++j)
>>   			iova_magazine_free(rcache->depot[j]);
>>   	}
>> +
>> +	kfree(iovad->rcaches);
>> +	iovad->rcaches = NULL;
>>   }
>>   
>>   /*
>> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
>> index 2b1143f11d8f..22f7d43f8a68 100644
>> --- a/drivers/vdpa/vdpa_user/iova_domain.c
>> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
>> @@ -480,6 +480,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
>>   	struct file *file;
>>   	struct vduse_bounce_map *map;
>>   	unsigned long pfn, bounce_pfns;
>> +	int ret;
>>   
>>   	bounce_pfns = PAGE_ALIGN(bounce_size) >> PAGE_SHIFT;
>>   	if (iova_limit <= bounce_size)
>> @@ -513,10 +514,20 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
>>   	spin_lock_init(&domain->iotlb_lock);
>>   	init_iova_domain(&domain->stream_iovad,
>>   			PAGE_SIZE, IOVA_START_PFN);
>> +	ret = iova_domain_init_rcaches(&domain->stream_iovad);
>> +	if (ret)
>> +		goto err_iovad_stream;
>>   	init_iova_domain(&domain->consistent_iovad,
>>   			PAGE_SIZE, bounce_pfns);
>> +	ret = iova_domain_init_rcaches(&domain->consistent_iovad);
>> +	if (ret)
>> +		goto err_iovad_consistent;
>>   
>>   	return domain;
>> +err_iovad_consistent:
>> +	put_iova_domain(&domain->stream_iovad);
>> +err_iovad_stream:
>> +	fput(file);
>>   err_file:
>>   	vfree(domain->bounce_maps);
>>   err_map:
>> diff --git a/include/linux/iova.h b/include/linux/iova.h
>> index cea79cb9f26c..320a70e40233 100644
>> --- a/include/linux/iova.h
>> +++ b/include/linux/iova.h
>> @@ -21,18 +21,8 @@ struct iova {
>>   	unsigned long	pfn_lo; /* Lowest allocated pfn */
>>   };
>>   
>> -struct iova_magazine;
>> -struct iova_cpu_rcache;
>>   
>> -#define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
>> -#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
>> -
>> -struct iova_rcache {
>> -	spinlock_t lock;
>> -	unsigned long depot_size;
>> -	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
>> -	struct iova_cpu_rcache __percpu *cpu_rcaches;
>> -};
>> +struct iova_rcache;
>>   
>>   /* holds all the iova translations for a domain */
>>   struct iova_domain {
>> @@ -46,7 +36,7 @@ struct iova_domain {
>>   	unsigned long	max32_alloc_size; /* Size of last failed allocation */
>>   	struct iova	anchor;		/* rbtree lookup anchor */
>>   
>> -	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
>> +	struct iova_rcache	*rcaches;
>>   	struct hlist_node	cpuhp_dead;
>>   };
>>   
>> @@ -102,6 +92,7 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
>>   	unsigned long pfn_hi);
>>   void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>>   	unsigned long start_pfn);
>> +int iova_domain_init_rcaches(struct iova_domain *iovad);
>>   struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>>   void put_iova_domain(struct iova_domain *iovad);
>>   #else
>> -- 
>> 2.26.2
> 
> .

