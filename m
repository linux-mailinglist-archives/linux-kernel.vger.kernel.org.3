Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D147A63B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhLTIuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:50:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4309 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbhLTIuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:50:20 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JHYBf2Mtgz67brF;
        Mon, 20 Dec 2021 16:47:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 09:50:17 +0100
Received: from [10.47.87.38] (10.47.87.38) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 20 Dec
 2021 08:50:16 +0000
Subject: Re: [PATCH 4/5] iommu: Separate IOVA rcache memories from iova_domain
 structure
To:     <joro@8bytes.org>, <will@kernel.org>, <mst@redhat.com>,
        <jasowang@redhat.com>, <robin.murphy@arm.com>
CC:     <xieyongji@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <virtualization@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <thunder.leizhen@huawei.com>, <baolu.lu@linux.intel.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-5-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2c58036f-d9aa-61f9-ae4b-f6938a135de5@huawei.com>
Date:   Mon, 20 Dec 2021 08:49:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1632477717-5254-5-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.38]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2021 11:01, John Garry wrote:
> Only dma-iommu.c and vdpa actually use the "fast" mode of IOVA alloc and
> free. As such, it's wasteful that all other IOVA domains hold the rcache
> memories.
> 
> In addition, the current IOVA domain init implementation is poor
> (init_iova_domain()), in that errors are ignored and not passed to the
> caller. The only errors can come from the IOVA rcache init, and fixing up
> all the IOVA domain init callsites to handle the errors would take some
> work.
> 
> Separate the IOVA rache out of the IOVA domain, and create a new IOVA
> domain structure, iova_caching_domain.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Hi Robin,

Do you have any thoughts on this patch? The decision is whether we stick 
with a single iova domain structure or support this super structure for 
iova domains which support the rcache. I did not try the former - it 
would be do-able but I am not sure on how it would look.

Thanks,
John

EOM

> ---
>   drivers/iommu/dma-iommu.c            |  56 +++++++-----
>   drivers/iommu/iova.c                 | 125 ++++++++++++++++++---------
>   drivers/vdpa/vdpa_user/iova_domain.c |  53 +++++++-----
>   drivers/vdpa/vdpa_user/iova_domain.h |   4 +-
>   include/linux/iova.h                 |  18 ++--
>   5 files changed, 166 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index fd669bad96e1..70651f1a688d 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -92,8 +92,8 @@ struct iommu_dma_cookie {
>   	union {
>   		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
>   		struct {
> -			struct iova_domain	iovad;
> -			struct fq_domain	fq;
> +			struct iova_caching_domain	rcached;
> +			struct fq_domain		fq;
>   		};
>   		/* Trivial linear page allocator for IOMMU_DMA_MSI_COOKIE */
>   		dma_addr_t		msi_iova;
> @@ -197,7 +197,6 @@ static void fq_ring_free(struct fq_domain *fq_domain, struct fq *fq)
>   	struct iommu_dma_cookie *cookie = container_of(fq_domain,
>   						       struct iommu_dma_cookie,
>   						       fq);
> -	struct iova_domain *iovad = &cookie->iovad;
>   	u64 counter = atomic64_read(&fq_domain->fq_flush_finish_cnt);
>   	unsigned idx;
>   
> @@ -211,7 +210,7 @@ static void fq_ring_free(struct fq_domain *fq_domain, struct fq *fq)
>   		if (fq_domain->entry_dtor)
>   			fq_domain->entry_dtor(fq->entries[idx].data);
>   
> -		free_iova_fast(iovad,
> +		free_iova_fast(&cookie->rcached,
>   			       fq->entries[idx].iova_pfn,
>   			       fq->entries[idx].pages);
>   
> @@ -330,7 +329,7 @@ static int init_flush_queue(struct fq_domain *fq_domain,
>   static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
>   {
>   	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
> -		return cookie->iovad.granule;
> +		return cookie->rcached.iovad.granule;
>   	return PAGE_SIZE;
>   }
>   
> @@ -413,9 +412,10 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>   	if (!cookie)
>   		return;
>   
> -	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule) {
> +	if (cookie->type == IOMMU_DMA_IOVA_COOKIE &&
> +	    cookie->rcached.iovad.granule) {
>   		free_flush_queue(&cookie->fq);
> -		put_iova_domain(&cookie->iovad);
> +		put_iova_caching_domain(&cookie->rcached);
>   	}
>   
>   	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list) {
> @@ -449,7 +449,7 @@ EXPORT_SYMBOL(iommu_dma_get_resv_regions);
>   static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
>   		phys_addr_t start, phys_addr_t end)
>   {
> -	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova_domain *iovad = &cookie->rcached.iovad;
>   	struct iommu_dma_msi_page *msi_page;
>   	int i, num_pages;
>   
> @@ -520,7 +520,8 @@ static int iova_reserve_iommu_regions(struct device *dev,
>   		struct iommu_domain *domain)
>   {
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova_caching_domain *rcached = &cookie->rcached;
> +	struct iova_domain *iovad = &rcached->iovad;
>   	struct iommu_resv_region *region;
>   	LIST_HEAD(resv_regions);
>   	int ret = 0;
> @@ -612,14 +613,17 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   				 dma_addr_t limit, struct device *dev)
>   {
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_caching_domain *rcached;
>   	unsigned long order, base_pfn;
>   	struct iova_domain *iovad;
>   	struct fq_domain *fq;
> +	int ret;
>   
>   	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
>   		return -EINVAL;
>   
> -	iovad = &cookie->iovad;
> +	rcached = &cookie->rcached;
> +	iovad = &rcached->iovad;
>   	fq = &cookie->fq;
>   
>   	/* Use the smallest supported page size for IOVA granularity */
> @@ -652,7 +656,11 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	fq->flush_cb = NULL;
>   	fq->fq = NULL;
>   
> -	init_iova_domain(iovad, 1UL << order, base_pfn);
> +	ret = init_iova_caching_domain(rcached, 1UL << order, base_pfn);
> +	if (ret) {
> +		dev_err(dev, "init_iova_caching_domain failed (%d)\n", ret);
> +		return ret;
> +	}
>   
>   	/* If the FQ fails we can simply fall back to strict mode */
>   	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
> @@ -694,13 +702,16 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>   		size_t size, u64 dma_limit, struct device *dev)
>   {
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova_caching_domain *rcached;
> +	struct iova_domain *iovad;
>   	unsigned long shift, iova_len, iova = 0;
>   
>   	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
>   		cookie->msi_iova += size;
>   		return cookie->msi_iova - size;
>   	}
> +	rcached = &cookie->rcached;
> +	iovad = &rcached->iovad;
>   
>   	shift = iova_shift(iovad);
>   	iova_len = size >> shift;
> @@ -712,11 +723,11 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>   
>   	/* Try to get PCI devices a SAC address */
>   	if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev))
> -		iova = alloc_iova_fast(iovad, iova_len,
> +		iova = alloc_iova_fast(rcached, iova_len,
>   				       DMA_BIT_MASK(32) >> shift, false);
>   
>   	if (!iova)
> -		iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift,
> +		iova = alloc_iova_fast(rcached, iova_len, dma_limit >> shift,
>   				       true);
>   
>   	return (dma_addr_t)iova << shift;
> @@ -725,7 +736,8 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>   static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
>   		dma_addr_t iova, size_t size, struct iommu_iotlb_gather *gather)
>   {
> -	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova_caching_domain *rcached = &cookie->rcached;
> +	struct iova_domain *iovad = &rcached->iovad;
>   
>   	/* The MSI case is only ever cleaning up its most recent allocation */
>   	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
> @@ -735,7 +747,7 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
>   			   size >> iova_shift(iovad),
>   			   (unsigned long)gather->freelist);
>   	} else {
> -		free_iova_fast(iovad, iova_pfn(iovad, iova),
> +		free_iova_fast(rcached, iova_pfn(iovad, iova),
>   				size >> iova_shift(iovad));
>   	}
>   }
> @@ -745,7 +757,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova_domain *iovad = &cookie->rcached.iovad;
>   	size_t iova_off = iova_offset(iovad, dma_addr);
>   	struct iommu_iotlb_gather iotlb_gather;
>   	size_t unmapped;
> @@ -785,7 +797,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova_domain *iovad = &cookie->rcached.iovad;
>   	size_t iova_off = iova_offset(iovad, phys);
>   	dma_addr_t iova;
>   
> @@ -813,7 +825,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>   	int prot = dma_info_to_prot(dir, coherent, attrs);
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova_domain *iovad = &cookie->rcached.iovad;
>   	size_t aligned_size = org_size;
>   	void *padding_start;
>   	size_t padding_size;
> @@ -924,7 +936,8 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova_caching_domain *rcached = &cookie->rcached;
> +	struct iova_domain *iovad = &rcached->iovad;
>   	bool coherent = dev_is_dma_coherent(dev);
>   	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
>   	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
> @@ -1258,7 +1271,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova_caching_domain *rcached = &cookie->rcached;
> +	struct iova_domain *iovad = &rcached->iovad;
>   	struct scatterlist *s, *prev = NULL;
>   	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
>   	dma_addr_t iova;
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 104fdc9d6c6a..30eb128b1581 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -15,27 +15,29 @@
>   /* The anchor node sits above the top of the usable address space */
>   #define IOVA_ANCHOR	~0UL
>   
> -static bool iova_rcache_insert(struct iova_domain *iovad,
> +static bool iova_rcache_insert(struct iova_caching_domain *rcached,
>   			       unsigned long pfn,
>   			       unsigned long size);
> -static unsigned long iova_rcache_get(struct iova_domain *iovad,
> +static unsigned long iova_rcache_get(struct iova_caching_domain *rcached,
>   				     unsigned long size,
>   				     unsigned long limit_pfn);
> -static void init_iova_rcaches(struct iova_domain *iovad);
> -static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
> -static void free_iova_rcaches(struct iova_domain *iovad);
> +static int init_iova_rcaches(struct iova_caching_domain *rcached);
> +static void free_cpu_cached_iovas(unsigned int cpu,
> +				  struct iova_caching_domain *rcached);
> +static void free_iova_rcaches(struct iova_caching_domain *rcached);
>   
>   static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
>   {
> -	struct iova_domain *iovad;
> +	struct iova_caching_domain *rcached;
>   
> -	iovad = hlist_entry_safe(node, struct iova_domain, cpuhp_dead);
> +	rcached = hlist_entry_safe(node, struct iova_caching_domain,
> +				   cpuhp_dead);
>   
> -	free_cpu_cached_iovas(cpu, iovad);
> +	free_cpu_cached_iovas(cpu, rcached);
>   	return 0;
>   }
>   
> -static void free_global_cached_iovas(struct iova_domain *iovad);
> +static void free_global_cached_iovas(struct iova_caching_domain *rcached);
>   
>   static struct iova *to_iova(struct rb_node *node)
>   {
> @@ -64,11 +66,32 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>   	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
>   	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
>   	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
> -	cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD, &iovad->cpuhp_dead);
> -	init_iova_rcaches(iovad);
>   }
>   EXPORT_SYMBOL_GPL(init_iova_domain);
>   
> +int init_iova_caching_domain(struct iova_caching_domain *rcached,
> +			     unsigned long granule, unsigned long start_pfn)
> +{
> +	int ret;
> +
> +	ret = cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
> +					       &rcached->cpuhp_dead);
> +	if (ret)
> +		return ret;
> +
> +	ret = init_iova_rcaches(rcached);
> +	if (ret) {
> +		cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
> +						    &rcached->cpuhp_dead);
> +		return ret;
> +	}
> +
> +	init_iova_domain(&rcached->iovad, granule, start_pfn);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(init_iova_caching_domain);
> +
>   static struct rb_node *
>   __get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
>   {
> @@ -422,7 +445,7 @@ EXPORT_SYMBOL_GPL(free_iova);
>   
>   /**
>    * alloc_iova_fast - allocates an iova from rcache
> - * @iovad: - iova domain in question
> + * @rcached: - iova caching domain in question
>    * @size: - size of page frames to allocate
>    * @limit_pfn: - max limit address
>    * @flush_rcache: - set to flush rcache on regular allocation failure
> @@ -431,7 +454,7 @@ EXPORT_SYMBOL_GPL(free_iova);
>    * fails too and the flush_rcache flag is set then the rcache will be flushed.
>   */
>   unsigned long
> -alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
> +alloc_iova_fast(struct iova_caching_domain *rcached, unsigned long size,
>   		unsigned long limit_pfn, bool flush_rcache)
>   {
>   	unsigned long iova_pfn;
> @@ -446,12 +469,12 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>   	if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
>   		size = roundup_pow_of_two(size);
>   
> -	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
> +	iova_pfn = iova_rcache_get(rcached, size, limit_pfn + 1);
>   	if (iova_pfn)
>   		return iova_pfn;
>   
>   retry:
> -	new_iova = alloc_iova(iovad, size, limit_pfn, true);
> +	new_iova = alloc_iova(&rcached->iovad, size, limit_pfn, true);
>   	if (!new_iova) {
>   		unsigned int cpu;
>   
> @@ -461,8 +484,8 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>   		/* Try replenishing IOVAs by flushing rcache. */
>   		flush_rcache = false;
>   		for_each_online_cpu(cpu)
> -			free_cpu_cached_iovas(cpu, iovad);
> -		free_global_cached_iovas(iovad);
> +			free_cpu_cached_iovas(cpu, rcached);
> +		free_global_cached_iovas(rcached);
>   		goto retry;
>   	}
>   
> @@ -472,21 +495,22 @@ EXPORT_SYMBOL_GPL(alloc_iova_fast);
>   
>   /**
>    * free_iova_fast - free iova pfn range into rcache
> - * @iovad: - iova domain in question.
> + * @rcached: - iova caching domain in question.
>    * @pfn: - pfn that is allocated previously
>    * @size: - # of pages in range
>    * This functions frees an iova range by trying to put it into the rcache,
>    * falling back to regular iova deallocation via free_iova() if this fails.
>    */
> -void
> -free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
> +void free_iova_fast(struct iova_caching_domain *rcached, unsigned long pfn,
> +		    unsigned long size)
>   {
> -	if (iova_rcache_insert(iovad, pfn, size))
> +	if (iova_rcache_insert(rcached, pfn, size))
>   		return;
>   
> -	free_iova(iovad, pfn);
> +	free_iova(&rcached->iovad, pfn);
>   }
>   EXPORT_SYMBOL_GPL(free_iova_fast);
> +
>   /**
>    * put_iova_domain - destroys the iova domain
>    * @iovad: - iova domain in question.
> @@ -496,15 +520,23 @@ void put_iova_domain(struct iova_domain *iovad)
>   {
>   	struct iova *iova, *tmp;
>   
> -	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
> -					    &iovad->cpuhp_dead);
> -
> -	free_iova_rcaches(iovad);
>   	rbtree_postorder_for_each_entry_safe(iova, tmp, &iovad->rbroot, node)
>   		free_iova_mem(iova);
>   }
>   EXPORT_SYMBOL_GPL(put_iova_domain);
>   
> +void put_iova_caching_domain(struct iova_caching_domain *rcached)
> +{
> +	struct iova_domain *iovad = &rcached->iovad;
> +
> +	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
> +					    &rcached->cpuhp_dead);
> +	free_iova_rcaches(rcached);
> +
> +	put_iova_domain(iovad);
> +}
> +EXPORT_SYMBOL_GPL(put_iova_caching_domain);
> +
>   static int
>   __is_range_overlap(struct rb_node *node,
>   	unsigned long pfn_lo, unsigned long pfn_hi)
> @@ -693,7 +725,7 @@ static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>   	mag->pfns[mag->size++] = pfn;
>   }
>   
> -static void init_iova_rcaches(struct iova_domain *iovad)
> +static int init_iova_rcaches(struct iova_caching_domain *rcached)
>   {
>   	struct iova_cpu_rcache *cpu_rcache;
>   	struct iova_rcache *rcache;
> @@ -701,12 +733,12 @@ static void init_iova_rcaches(struct iova_domain *iovad)
>   	int i;
>   
>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> -		rcache = &iovad->rcaches[i];
> +		rcache = &rcached->rcaches[i];
>   		spin_lock_init(&rcache->lock);
>   		rcache->depot_size = 0;
>   		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
> -		if (WARN_ON(!rcache->cpu_rcaches))
> -			continue;
> +		if (!rcache->cpu_rcaches)
> +			goto err;
>   		for_each_possible_cpu(cpu) {
>   			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>   			spin_lock_init(&cpu_rcache->lock);
> @@ -714,6 +746,12 @@ static void init_iova_rcaches(struct iova_domain *iovad)
>   			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
>   		}
>   	}
> +
> +	return 0;
> +
> +err:
> +	free_iova_rcaches(rcached);
> +	return -ENOMEM;
>   }
>   
>   /*
> @@ -722,7 +760,7 @@ static void init_iova_rcaches(struct iova_domain *iovad)
>    * space, and free_iova() (our only caller) will then return the IOVA
>    * range to the rbtree instead.
>    */
> -static bool __iova_rcache_insert(struct iova_domain *iovad,
> +static bool __iova_rcache_insert(struct iova_caching_domain *rcached,
>   				 struct iova_rcache *rcache,
>   				 unsigned long iova_pfn)
>   {
> @@ -763,14 +801,14 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>   
>   	if (mag_to_free) {
> -		iova_magazine_free_pfns(mag_to_free, iovad);
> +		iova_magazine_free_pfns(mag_to_free, &rcached->iovad);
>   		iova_magazine_free(mag_to_free);
>   	}
>   
>   	return can_insert;
>   }
>   
> -static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pfn,
> +static bool iova_rcache_insert(struct iova_caching_domain *rcached, unsigned long pfn,
>   			       unsigned long size)
>   {
>   	unsigned int log_size = order_base_2(size);
> @@ -778,7 +816,7 @@ static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pfn,
>   	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
>   		return false;
>   
> -	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
> +	return __iova_rcache_insert(rcached, &rcached->rcaches[log_size], pfn);
>   }
>   
>   /*
> @@ -825,7 +863,7 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
>    * size is too big or the DMA limit we are given isn't satisfied by the
>    * top element in the magazine.
>    */
> -static unsigned long iova_rcache_get(struct iova_domain *iovad,
> +static unsigned long iova_rcache_get(struct iova_caching_domain *rcached,
>   				     unsigned long size,
>   				     unsigned long limit_pfn)
>   {
> @@ -834,13 +872,13 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>   	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
>   		return 0;
>   
> -	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
> +	return __iova_rcache_get(&rcached->rcaches[log_size], limit_pfn - size);
>   }
>   
>   /*
>    * free rcache data structures.
>    */
> -static void free_iova_rcaches(struct iova_domain *iovad)
> +static void free_iova_rcaches(struct iova_caching_domain *rcached)
>   {
>   	struct iova_rcache *rcache;
>   	struct iova_cpu_rcache *cpu_rcache;
> @@ -848,7 +886,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   	int i, j;
>   
>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> -		rcache = &iovad->rcaches[i];
> +		rcache = &rcached->rcaches[i];
>   		for_each_possible_cpu(cpu) {
>   			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>   			iova_magazine_free(cpu_rcache->loaded);
> @@ -863,15 +901,17 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   /*
>    * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)
>    */
> -static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
> +static void free_cpu_cached_iovas(unsigned int cpu,
> +				  struct iova_caching_domain *rcached)
>   {
> +	struct iova_domain *iovad = &rcached->iovad;
>   	struct iova_cpu_rcache *cpu_rcache;
>   	struct iova_rcache *rcache;
>   	unsigned long flags;
>   	int i;
>   
>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> -		rcache = &iovad->rcaches[i];
> +		rcache = &rcached->rcaches[i];
>   		cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>   		spin_lock_irqsave(&cpu_rcache->lock, flags);
>   		iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
> @@ -883,14 +923,15 @@ static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>   /*
>    * free all the IOVA ranges of global cache
>    */
> -static void free_global_cached_iovas(struct iova_domain *iovad)
> +static void free_global_cached_iovas(struct iova_caching_domain *rcached)
>   {
> +	struct iova_domain *iovad = &rcached->iovad;
>   	struct iova_rcache *rcache;
>   	unsigned long flags;
>   	int i, j;
>   
>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> -		rcache = &iovad->rcaches[i];
> +		rcache = &rcached->rcaches[i];
>   		spin_lock_irqsave(&rcache->lock, flags);
>   		for (j = 0; j < rcache->depot_size; ++j) {
>   			iova_magazine_free_pfns(rcache->depot[j], iovad);
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 2b1143f11d8f..d2ffdbf5f29c 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -285,25 +285,28 @@ static int vduse_domain_init_bounce_map(struct vduse_iova_domain *domain)
>   }
>   
>   static dma_addr_t
> -vduse_domain_alloc_iova(struct iova_domain *iovad,
> +vduse_domain_alloc_iova(struct iova_caching_domain *rcached,
>   			unsigned long size, unsigned long limit)
>   {
> +	struct iova_domain *iovad = &rcached->iovad;
>   	unsigned long shift = iova_shift(iovad);
>   	unsigned long iova_len = iova_align(iovad, size) >> shift;
>   	unsigned long iova_pfn;
>   
> -	iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
> +	iova_pfn = alloc_iova_fast(rcached, iova_len, limit >> shift, true);
>   
>   	return iova_pfn << shift;
>   }
>   
> -static void vduse_domain_free_iova(struct iova_domain *iovad,
> +static void vduse_domain_free_iova(struct iova_caching_domain *rcached,
>   				   dma_addr_t iova, size_t size)
>   {
> +	struct iova_domain *iovad = &rcached->iovad;
> +
>   	unsigned long shift = iova_shift(iovad);
>   	unsigned long iova_len = iova_align(iovad, size) >> shift;
>   
> -	free_iova_fast(iovad, iova >> shift, iova_len);
> +	free_iova_fast(rcached, iova >> shift, iova_len);
>   }
>   
>   dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
> @@ -311,10 +314,10 @@ dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
>   				 size_t size, enum dma_data_direction dir,
>   				 unsigned long attrs)
>   {
> -	struct iova_domain *iovad = &domain->stream_iovad;
> +	struct iova_caching_domain *rcached = &domain->stream_iovad;
>   	unsigned long limit = domain->bounce_size - 1;
>   	phys_addr_t pa = page_to_phys(page) + offset;
> -	dma_addr_t iova = vduse_domain_alloc_iova(iovad, size, limit);
> +	dma_addr_t iova = vduse_domain_alloc_iova(rcached, size, limit);
>   
>   	if (!iova)
>   		return DMA_MAPPING_ERROR;
> @@ -330,7 +333,7 @@ dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
>   
>   	return iova;
>   err:
> -	vduse_domain_free_iova(iovad, iova, size);
> +	vduse_domain_free_iova(rcached, iova, size);
>   	return DMA_MAPPING_ERROR;
>   }
>   
> @@ -338,22 +341,22 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
>   			     dma_addr_t dma_addr, size_t size,
>   			     enum dma_data_direction dir, unsigned long attrs)
>   {
> -	struct iova_domain *iovad = &domain->stream_iovad;
> +	struct iova_caching_domain *rcached = &domain->stream_iovad;
>   
>   	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
>   		vduse_domain_bounce(domain, dma_addr, size, DMA_FROM_DEVICE);
>   
>   	vduse_domain_unmap_bounce_page(domain, (u64)dma_addr, (u64)size);
> -	vduse_domain_free_iova(iovad, dma_addr, size);
> +	vduse_domain_free_iova(rcached, dma_addr, size);
>   }
>   
>   void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
>   				  size_t size, dma_addr_t *dma_addr,
>   				  gfp_t flag, unsigned long attrs)
>   {
> -	struct iova_domain *iovad = &domain->consistent_iovad;
> +	struct iova_caching_domain *rcached = &domain->consistent_iovad;
>   	unsigned long limit = domain->iova_limit;
> -	dma_addr_t iova = vduse_domain_alloc_iova(iovad, size, limit);
> +	dma_addr_t iova = vduse_domain_alloc_iova(rcached, size, limit);
>   	void *orig = alloc_pages_exact(size, flag);
>   
>   	if (!iova || !orig)
> @@ -376,7 +379,7 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
>   	if (orig)
>   		free_pages_exact(orig, size);
>   	if (iova)
> -		vduse_domain_free_iova(iovad, iova, size);
> +		vduse_domain_free_iova(rcached, iova, size);
>   
>   	return NULL;
>   }
> @@ -385,7 +388,7 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
>   				void *vaddr, dma_addr_t dma_addr,
>   				unsigned long attrs)
>   {
> -	struct iova_domain *iovad = &domain->consistent_iovad;
> +	struct iova_caching_domain *rcached = &domain->consistent_iovad;
>   	struct vhost_iotlb_map *map;
>   	struct vdpa_map_file *map_file;
>   	phys_addr_t pa;
> @@ -404,7 +407,7 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
>   	vhost_iotlb_map_free(domain->iotlb, map);
>   	spin_unlock(&domain->iotlb_lock);
>   
> -	vduse_domain_free_iova(iovad, dma_addr, size);
> +	vduse_domain_free_iova(rcached, dma_addr, size);
>   	free_pages_exact(phys_to_virt(pa), size);
>   }
>   
> @@ -453,8 +456,8 @@ static int vduse_domain_release(struct inode *inode, struct file *file)
>   	vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
>   	vduse_domain_free_bounce_pages(domain);
>   	spin_unlock(&domain->iotlb_lock);
> -	put_iova_domain(&domain->stream_iovad);
> -	put_iova_domain(&domain->consistent_iovad);
> +	put_iova_caching_domain(&domain->stream_iovad);
> +	put_iova_caching_domain(&domain->consistent_iovad);
>   	vhost_iotlb_free(domain->iotlb);
>   	vfree(domain->bounce_maps);
>   	kfree(domain);
> @@ -480,6 +483,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
>   	struct file *file;
>   	struct vduse_bounce_map *map;
>   	unsigned long pfn, bounce_pfns;
> +	int ret;
>   
>   	bounce_pfns = PAGE_ALIGN(bounce_size) >> PAGE_SHIFT;
>   	if (iova_limit <= bounce_size)
> @@ -511,12 +515,21 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
>   
>   	domain->file = file;
>   	spin_lock_init(&domain->iotlb_lock);
> -	init_iova_domain(&domain->stream_iovad,
> -			PAGE_SIZE, IOVA_START_PFN);
> -	init_iova_domain(&domain->consistent_iovad,
> -			PAGE_SIZE, bounce_pfns);
> +	ret = init_iova_caching_domain(&domain->stream_iovad,
> +				       PAGE_SIZE, IOVA_START_PFN);
> +	if (ret)
> +		goto err_stream_domain;
> +	ret = init_iova_caching_domain(&domain->consistent_iovad,
> +				       PAGE_SIZE, bounce_pfns);
> +	if (ret)
> +		goto err_consistent_domain;
>   
>   	return domain;
> +
> +err_consistent_domain:
> +	put_iova_caching_domain(&domain->stream_iovad);
> +err_stream_domain:
> +	fput(domain->file);
>   err_file:
>   	vfree(domain->bounce_maps);
>   err_map:
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
> index 2722d9b8e21a..38576e1d3b2c 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -25,8 +25,8 @@ struct vduse_bounce_map {
>   };
>   
>   struct vduse_iova_domain {
> -	struct iova_domain stream_iovad;
> -	struct iova_domain consistent_iovad;
> +	struct iova_caching_domain stream_iovad;
> +	struct iova_caching_domain consistent_iovad;
>   	struct vduse_bounce_map *bounce_maps;
>   	size_t bounce_size;
>   	unsigned long iova_limit;
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index ef3b0f8f8a31..858ca7a5f1fa 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -48,6 +48,10 @@ struct iova_domain {
>   	unsigned long	dma_32bit_pfn;
>   	unsigned long	max32_alloc_size; /* Size of last failed allocation */
>   	struct iova	anchor;		/* rbtree lookup anchor */
> +};
> +
> +struct iova_caching_domain {
> +	struct iova_domain	iovad;
>   	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
>   	struct hlist_node	cpuhp_dead;
>   };
> @@ -96,16 +100,20 @@ void __free_iova(struct iova_domain *iovad, struct iova *iova);
>   struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
>   	unsigned long limit_pfn,
>   	bool size_aligned);
> -void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
> +void free_iova_fast(struct iova_caching_domain *rcached, unsigned long pfn,
>   		    unsigned long size);
> -unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
> -			      unsigned long limit_pfn, bool flush_rcache);
> +unsigned long alloc_iova_fast(struct iova_caching_domain *rcached,
> +			      unsigned long size, unsigned long limit_pfn,
> +			      bool flush_rcache);
>   struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
>   	unsigned long pfn_hi);
>   void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>   	unsigned long start_pfn);
>   struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>   void put_iova_domain(struct iova_domain *iovad);
> +void put_iova_caching_domain(struct iova_caching_domain *rcached);
> +int init_iova_caching_domain(struct iova_caching_domain *rcached,
> +			     unsigned long granule, unsigned long start_pfn);
>   #else
>   static inline int iova_cache_get(void)
>   {
> @@ -132,13 +140,13 @@ static inline struct iova *alloc_iova(struct iova_domain *iovad,
>   	return NULL;
>   }
>   
> -static inline void free_iova_fast(struct iova_domain *iovad,
> +static inline void free_iova_fast(struct iova_caching_domain *rcached,
>   				  unsigned long pfn,
>   				  unsigned long size)
>   {
>   }
>   
> -static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
> +static inline unsigned long alloc_iova_fast(struct iova_caching_domain *rcached,
>   					    unsigned long size,
>   					    unsigned long limit_pfn,
>   					    bool flush_rcache)
> 

