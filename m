Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818C7592DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbiHOLFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242547AbiHOLFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:05:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2467D24BE5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:04:39 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M5ryK6mjSz6889m;
        Mon, 15 Aug 2022 19:04:25 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 15 Aug 2022 13:04:36 +0200
Received: from [10.48.150.107] (10.48.150.107) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 12:04:35 +0100
Message-ID: <0c58625b-f26c-a6d0-876e-c20d10ed708e@huawei.com>
Date:   Mon, 15 Aug 2022 12:04:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] iova: Re-order code to remove forward declarations
To:     <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <1658849185-158209-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <1658849185-158209-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.150.107]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 16:26, John Garry wrote:

Hi Robin,

Any opinion on this patch?

Thanks,
John

> Now that the FQ code has been moved to dma-iommu.c and also the rcache-
> related structures have been brought into iova.c, let's re-order the code
> to remove all the forward declarations.
> 
> The general order will be as follows:
> - RB tree code
> - iova management
> - magazine helpers
> - rcache code and "fast" APIs
> - iova domain public APIs
> 
> Re-order prototypes in iova.h to follow the same general group ordering.
> 
> A couple of pre-existing checkpatch warnings are also remedied:
> 
> A suspect indentation is also corrected:
> WARNING: suspect code indent for conditional statements (16, 32)
>   #374: FILE: drivers/iommu/iova.c:194:
> +               } else if (overlap)
> +                               break;
> 
> WARNING: Block comments should align the * on each line
>   #1038: FILE: drivers/iommu/iova.c:787:
> + * fails too and the flush_rcache flag is set then the rcache will be flushed.
> +*/
> 
> No functional change intended.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> Differences to v1:
> - tweak ordering a bit
> - rebase
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index e44f565c5319..ddac9dcf97c6 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -17,75 +17,45 @@
>   
>   #define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
>   
> -static bool iova_rcache_insert(struct iova_domain *iovad,
> -			       unsigned long pfn,
> -			       unsigned long size);
> -static unsigned long iova_rcache_get(struct iova_domain *iovad,
> -				     unsigned long size,
> -				     unsigned long limit_pfn);
> -static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
> -static void free_iova_rcaches(struct iova_domain *iovad);
> +/*
> + * Magazine caches for IOVA ranges.  For an introduction to magazines,
> + * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
> + * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
> + * For simplicity, we use a static magazine size and don't implement the
> + * dynamic size tuning described in the paper.
> + */
>   
> -static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
> -{
> -	struct iova_domain *iovad;
> +/*
> + * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
> + * assure size of 'iova_magazine' to be 1024 bytes, so that no memory
> + * will be wasted.
> + */
> +#define IOVA_MAG_SIZE 127
> +#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
>   
> -	iovad = hlist_entry_safe(node, struct iova_domain, cpuhp_dead);
> +struct iova_magazine {
> +	unsigned long size;
> +	unsigned long pfns[IOVA_MAG_SIZE];
> +};
>   
> -	free_cpu_cached_iovas(cpu, iovad);
> -	return 0;
> -}
> +struct iova_cpu_rcache {
> +	spinlock_t lock;
> +	struct iova_magazine *loaded;
> +	struct iova_magazine *prev;
> +};
>   
> -static void free_global_cached_iovas(struct iova_domain *iovad);
> +struct iova_rcache {
> +	spinlock_t lock;
> +	unsigned long depot_size;
> +	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
> +	struct iova_cpu_rcache __percpu *cpu_rcaches;
> +};
>   
>   static struct iova *to_iova(struct rb_node *node)
>   {
>   	return rb_entry(node, struct iova, node);
>   }
>   
> -void
> -init_iova_domain(struct iova_domain *iovad, unsigned long granule,
> -	unsigned long start_pfn)
> -{
> -	/*
> -	 * IOVA granularity will normally be equal to the smallest
> -	 * supported IOMMU page size; both *must* be capable of
> -	 * representing individual CPU pages exactly.
> -	 */
> -	BUG_ON((granule > PAGE_SIZE) || !is_power_of_2(granule));
> -
> -	spin_lock_init(&iovad->iova_rbtree_lock);
> -	iovad->rbroot = RB_ROOT;
> -	iovad->cached_node = &iovad->anchor.node;
> -	iovad->cached32_node = &iovad->anchor.node;
> -	iovad->granule = granule;
> -	iovad->start_pfn = start_pfn;
> -	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
> -	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
> -	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
> -	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
> -	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
> -}
> -EXPORT_SYMBOL_GPL(init_iova_domain);
> -
> -static struct rb_node *
> -__get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
> -{
> -	if (limit_pfn <= iovad->dma_32bit_pfn)
> -		return iovad->cached32_node;
> -
> -	return iovad->cached_node;
> -}
> -
> -static void
> -__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
> -{
> -	if (new->pfn_hi < iovad->dma_32bit_pfn)
> -		iovad->cached32_node = &new->node;
> -	else
> -		iovad->cached_node = &new->node;
> -}
> -
>   static void
>   __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
>   {
> @@ -105,43 +75,6 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
>   		iovad->cached_node = rb_next(&free->node);
>   }
>   
> -static struct rb_node *iova_find_limit(struct iova_domain *iovad, unsigned long limit_pfn)
> -{
> -	struct rb_node *node, *next;
> -	/*
> -	 * Ideally what we'd like to judge here is whether limit_pfn is close
> -	 * enough to the highest-allocated IOVA that starting the allocation
> -	 * walk from the anchor node will be quicker than this initial work to
> -	 * find an exact starting point (especially if that ends up being the
> -	 * anchor node anyway). This is an incredibly crude approximation which
> -	 * only really helps the most likely case, but is at least trivially easy.
> -	 */
> -	if (limit_pfn > iovad->dma_32bit_pfn)
> -		return &iovad->anchor.node;
> -
> -	node = iovad->rbroot.rb_node;
> -	while (to_iova(node)->pfn_hi < limit_pfn)
> -		node = node->rb_right;
> -
> -search_left:
> -	while (node->rb_left && to_iova(node->rb_left)->pfn_lo >= limit_pfn)
> -		node = node->rb_left;
> -
> -	if (!node->rb_left)
> -		return node;
> -
> -	next = node->rb_left;
> -	while (next->rb_right) {
> -		next = next->rb_right;
> -		if (to_iova(next)->pfn_lo >= limit_pfn) {
> -			node = next;
> -			goto search_left;
> -		}
> -	}
> -
> -	return node;
> -}
> -
>   /* Insert the iova into domain rbtree by holding writer lock */
>   static void
>   iova_insert_rbtree(struct rb_root *root, struct iova *iova,
> @@ -170,65 +103,15 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
>   	rb_insert_color(&iova->node, root);
>   }
>   
> -static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
> -		unsigned long size, unsigned long limit_pfn,
> -			struct iova *new, bool size_aligned)
> +static int
> +__is_range_overlap(struct rb_node *node,
> +	unsigned long pfn_lo, unsigned long pfn_hi)
>   {
> -	struct rb_node *curr, *prev;
> -	struct iova *curr_iova;
> -	unsigned long flags;
> -	unsigned long new_pfn, retry_pfn;
> -	unsigned long align_mask = ~0UL;
> -	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
> -
> -	if (size_aligned)
> -		align_mask <<= fls_long(size - 1);
> -
> -	/* Walk the tree backwards */
> -	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> -	if (limit_pfn <= iovad->dma_32bit_pfn &&
> -			size >= iovad->max32_alloc_size)
> -		goto iova32_full;
> -
> -	curr = __get_cached_rbnode(iovad, limit_pfn);
> -	curr_iova = to_iova(curr);
> -	retry_pfn = curr_iova->pfn_hi + 1;
> -
> -retry:
> -	do {
> -		high_pfn = min(high_pfn, curr_iova->pfn_lo);
> -		new_pfn = (high_pfn - size) & align_mask;
> -		prev = curr;
> -		curr = rb_prev(curr);
> -		curr_iova = to_iova(curr);
> -	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
> -
> -	if (high_pfn < size || new_pfn < low_pfn) {
> -		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
> -			high_pfn = limit_pfn;
> -			low_pfn = retry_pfn;
> -			curr = iova_find_limit(iovad, limit_pfn);
> -			curr_iova = to_iova(curr);
> -			goto retry;
> -		}
> -		iovad->max32_alloc_size = size;
> -		goto iova32_full;
> -	}
> -
> -	/* pfn_lo will point to size aligned address if size_aligned is set */
> -	new->pfn_lo = new_pfn;
> -	new->pfn_hi = new->pfn_lo + size - 1;
> -
> -	/* If we have 'prev', it's a valid place to start the insertion. */
> -	iova_insert_rbtree(&iovad->rbroot, new, prev);
> -	__cached_rbnode_insert_update(iovad, new);
> +	struct iova *iova = to_iova(node);
>   
> -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	if ((pfn_lo <= iova->pfn_hi) && (pfn_hi >= iova->pfn_lo))
> +		return 1;
>   	return 0;
> -
> -iova32_full:
> -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -	return -ENOMEM;
>   }
>   
>   static struct kmem_cache *iova_cache;
> @@ -246,88 +129,87 @@ static void free_iova_mem(struct iova *iova)
>   		kmem_cache_free(iova_cache, iova);
>   }
>   
> -int iova_cache_get(void)
> +static inline struct iova *
> +alloc_and_init_iova(unsigned long pfn_lo, unsigned long pfn_hi)
>   {
> -	mutex_lock(&iova_cache_mutex);
> -	if (!iova_cache_users) {
> -		int ret;
> -
> -		ret = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, "iommu/iova:dead", NULL,
> -					iova_cpuhp_dead);
> -		if (ret) {
> -			mutex_unlock(&iova_cache_mutex);
> -			pr_err("Couldn't register cpuhp handler\n");
> -			return ret;
> -		}
> +	struct iova *iova;
>   
> -		iova_cache = kmem_cache_create(
> -			"iommu_iova", sizeof(struct iova), 0,
> -			SLAB_HWCACHE_ALIGN, NULL);
> -		if (!iova_cache) {
> -			cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
> -			mutex_unlock(&iova_cache_mutex);
> -			pr_err("Couldn't create iova cache\n");
> -			return -ENOMEM;
> -		}
> +	iova = alloc_iova_mem();
> +	if (iova) {
> +		iova->pfn_lo = pfn_lo;
> +		iova->pfn_hi = pfn_hi;
>   	}
>   
> -	iova_cache_users++;
> -	mutex_unlock(&iova_cache_mutex);
> +	return iova;
> +}
>   
> -	return 0;
> +static struct iova *
> +__insert_new_range(struct iova_domain *iovad,
> +	unsigned long pfn_lo, unsigned long pfn_hi)
> +{
> +	struct iova *iova;
> +
> +	iova = alloc_and_init_iova(pfn_lo, pfn_hi);
> +	if (iova)
> +		iova_insert_rbtree(&iovad->rbroot, iova, NULL);
> +
> +	return iova;
>   }
> -EXPORT_SYMBOL_GPL(iova_cache_get);
>   
> -void iova_cache_put(void)
> +static void
> +__adjust_overlap_range(struct iova *iova,
> +	unsigned long *pfn_lo, unsigned long *pfn_hi)
>   {
> -	mutex_lock(&iova_cache_mutex);
> -	if (WARN_ON(!iova_cache_users)) {
> -		mutex_unlock(&iova_cache_mutex);
> -		return;
> -	}
> -	iova_cache_users--;
> -	if (!iova_cache_users) {
> -		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
> -		kmem_cache_destroy(iova_cache);
> -	}
> -	mutex_unlock(&iova_cache_mutex);
> +	if (*pfn_lo < iova->pfn_lo)
> +		iova->pfn_lo = *pfn_lo;
> +	if (*pfn_hi > iova->pfn_hi)
> +		*pfn_lo = iova->pfn_hi + 1;
>   }
> -EXPORT_SYMBOL_GPL(iova_cache_put);
>   
>   /**
> - * alloc_iova - allocates an iova
> - * @iovad: - iova domain in question
> - * @size: - size of page frames to allocate
> - * @limit_pfn: - max limit address
> - * @size_aligned: - set if size_aligned address range is required
> - * This function allocates an iova in the range iovad->start_pfn to limit_pfn,
> - * searching top-down from limit_pfn to iovad->start_pfn. If the size_aligned
> - * flag is set then the allocated address iova->pfn_lo will be naturally
> - * aligned on roundup_power_of_two(size).
> - */
> -struct iova *
> -alloc_iova(struct iova_domain *iovad, unsigned long size,
> -	unsigned long limit_pfn,
> -	bool size_aligned)
> + * reserve_iova - reserves an iova in the given range
> + * @iovad: - iova domain pointer
> + * @pfn_lo: - lower page frame address
> + * @pfn_hi:- higher pfn adderss
> + * This function allocates reserves the address range from pfn_lo to pfn_hi so
> + * that this address is not dished out as part of alloc_iova.
> + */
> +struct iova *
> +reserve_iova(struct iova_domain *iovad,
> +	unsigned long pfn_lo, unsigned long pfn_hi)
>   {
> -	struct iova *new_iova;
> -	int ret;
> +	struct rb_node *node;
> +	unsigned long flags;
> +	struct iova *iova;
> +	unsigned int overlap = 0;
>   
> -	new_iova = alloc_iova_mem();
> -	if (!new_iova)
> +	/* Don't allow nonsensical pfns */
> +	if (WARN_ON((pfn_hi | pfn_lo) > (ULLONG_MAX >> iova_shift(iovad))))
>   		return NULL;
>   
> -	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn + 1,
> -			new_iova, size_aligned);
> -
> -	if (ret) {
> -		free_iova_mem(new_iova);
> -		return NULL;
> +	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
> +		if (__is_range_overlap(node, pfn_lo, pfn_hi)) {
> +			iova = to_iova(node);
> +			__adjust_overlap_range(iova, &pfn_lo, &pfn_hi);
> +			if ((pfn_lo >= iova->pfn_lo) &&
> +				(pfn_hi <= iova->pfn_hi))
> +				goto finish;
> +			overlap = 1;
> +		} else if (overlap)
> +			break;
>   	}
>   
> -	return new_iova;
> +	/* We are here either because this is the first reserver node
> +	 * or need to insert remaining non overlap addr range
> +	 */
> +	iova = __insert_new_range(iovad, pfn_lo, pfn_hi);
> +finish:
> +
> +	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	return iova;
>   }
> -EXPORT_SYMBOL_GPL(alloc_iova);
> +EXPORT_SYMBOL_GPL(reserve_iova);
>   
>   static struct iova *
>   private_find_iova(struct iova_domain *iovad, unsigned long pfn)
> @@ -357,6 +239,122 @@ static void remove_iova(struct iova_domain *iovad, struct iova *iova)
>   	rb_erase(&iova->node, &iovad->rbroot);
>   }
>   
> +static struct rb_node *
> +__get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
> +{
> +	if (limit_pfn <= iovad->dma_32bit_pfn)
> +		return iovad->cached32_node;
> +
> +	return iovad->cached_node;
> +}
> +
> +static void
> +__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
> +{
> +	if (new->pfn_hi < iovad->dma_32bit_pfn)
> +		iovad->cached32_node = &new->node;
> +	else
> +		iovad->cached_node = &new->node;
> +}
> +
> +static struct rb_node *iova_find_limit(struct iova_domain *iovad, unsigned long limit_pfn)
> +{
> +	struct rb_node *node, *next;
> +	/*
> +	 * Ideally what we'd like to judge here is whether limit_pfn is close
> +	 * enough to the highest-allocated IOVA that starting the allocation
> +	 * walk from the anchor node will be quicker than this initial work to
> +	 * find an exact starting point (especially if that ends up being the
> +	 * anchor node anyway). This is an incredibly crude approximation which
> +	 * only really helps the most likely case, but is at least trivially easy.
> +	 */
> +	if (limit_pfn > iovad->dma_32bit_pfn)
> +		return &iovad->anchor.node;
> +
> +	node = iovad->rbroot.rb_node;
> +	while (to_iova(node)->pfn_hi < limit_pfn)
> +		node = node->rb_right;
> +
> +search_left:
> +	while (node->rb_left && to_iova(node->rb_left)->pfn_lo >= limit_pfn)
> +		node = node->rb_left;
> +
> +	if (!node->rb_left)
> +		return node;
> +
> +	next = node->rb_left;
> +	while (next->rb_right) {
> +		next = next->rb_right;
> +		if (to_iova(next)->pfn_lo >= limit_pfn) {
> +			node = next;
> +			goto search_left;
> +		}
> +	}
> +
> +	return node;
> +}
> +
> +static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
> +		unsigned long size, unsigned long limit_pfn,
> +			struct iova *new, bool size_aligned)
> +{
> +	struct rb_node *curr, *prev;
> +	struct iova *curr_iova;
> +	unsigned long flags;
> +	unsigned long new_pfn, retry_pfn;
> +	unsigned long align_mask = ~0UL;
> +	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
> +
> +	if (size_aligned)
> +		align_mask <<= fls_long(size - 1);
> +
> +	/* Walk the tree backwards */
> +	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	if (limit_pfn <= iovad->dma_32bit_pfn &&
> +			size >= iovad->max32_alloc_size)
> +		goto iova32_full;
> +
> +	curr = __get_cached_rbnode(iovad, limit_pfn);
> +	curr_iova = to_iova(curr);
> +	retry_pfn = curr_iova->pfn_hi + 1;
> +
> +retry:
> +	do {
> +		high_pfn = min(high_pfn, curr_iova->pfn_lo);
> +		new_pfn = (high_pfn - size) & align_mask;
> +		prev = curr;
> +		curr = rb_prev(curr);
> +		curr_iova = to_iova(curr);
> +	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
> +
> +	if (high_pfn < size || new_pfn < low_pfn) {
> +		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
> +			high_pfn = limit_pfn;
> +			low_pfn = retry_pfn;
> +			curr = iova_find_limit(iovad, limit_pfn);
> +			curr_iova = to_iova(curr);
> +			goto retry;
> +		}
> +		iovad->max32_alloc_size = size;
> +		goto iova32_full;
> +	}
> +
> +	/* pfn_lo will point to size aligned address if size_aligned is set */
> +	new->pfn_lo = new_pfn;
> +	new->pfn_hi = new->pfn_lo + size - 1;
> +
> +	/* If we have 'prev', it's a valid place to start the insertion. */
> +	iova_insert_rbtree(&iovad->rbroot, new, prev);
> +	__cached_rbnode_insert_update(iovad, new);
> +
> +	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	return 0;
> +
> +iova32_full:
> +	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	return -ENOMEM;
> +}
> +
>   /**
>    * find_iova - finds an iova for a given pfn
>    * @iovad: - iova domain in question.
> @@ -377,6 +375,41 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
>   }
>   EXPORT_SYMBOL_GPL(find_iova);
>   
> +/**
> + * alloc_iova - allocates an iova
> + * @iovad: - iova domain in question
> + * @size: - size of page frames to allocate
> + * @limit_pfn: - max limit address
> + * @size_aligned: - set if size_aligned address range is required
> + * This function allocates an iova in the range iovad->start_pfn to limit_pfn,
> + * searching top-down from limit_pfn to iovad->start_pfn. If the size_aligned
> + * flag is set then the allocated address iova->pfn_lo will be naturally
> + * aligned on roundup_power_of_two(size).
> + */
> +struct iova *
> +alloc_iova(struct iova_domain *iovad, unsigned long size,
> +	unsigned long limit_pfn,
> +	bool size_aligned)
> +{
> +	struct iova *new_iova;
> +	int ret;
> +
> +	new_iova = alloc_iova_mem();
> +	if (!new_iova)
> +		return NULL;
> +
> +	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn + 1,
> +			new_iova, size_aligned);
> +
> +	if (ret) {
> +		free_iova_mem(new_iova);
> +		return NULL;
> +	}
> +
> +	return new_iova;
> +}
> +EXPORT_SYMBOL_GPL(alloc_iova);
> +
>   /**
>    * __free_iova - frees the given iova
>    * @iovad: iova domain in question.
> @@ -420,234 +453,51 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
>   }
>   EXPORT_SYMBOL_GPL(free_iova);
>   
> -/**
> - * alloc_iova_fast - allocates an iova from rcache
> - * @iovad: - iova domain in question
> - * @size: - size of page frames to allocate
> - * @limit_pfn: - max limit address
> - * @flush_rcache: - set to flush rcache on regular allocation failure
> - * This function tries to satisfy an iova allocation from the rcache,
> - * and falls back to regular allocation on failure. If regular allocation
> - * fails too and the flush_rcache flag is set then the rcache will be flushed.
> -*/
> -unsigned long
> -alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
> -		unsigned long limit_pfn, bool flush_rcache)
> +static bool iova_magazine_full(struct iova_magazine *mag)
>   {
> -	unsigned long iova_pfn;
> -	struct iova *new_iova;
> -
> -	/*
> -	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -	 * will come back to bite us badly, so we have to waste a bit of space
> -	 * rounding up anything cacheable to make sure that can't happen. The
> -	 * order of the unadjusted size will still match upon freeing.
> -	 */
> -	if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -		size = roundup_pow_of_two(size);
> -
> -	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
> -	if (iova_pfn)
> -		return iova_pfn;
> -
> -retry:
> -	new_iova = alloc_iova(iovad, size, limit_pfn, true);
> -	if (!new_iova) {
> -		unsigned int cpu;
> +	return (mag && mag->size == IOVA_MAG_SIZE);
> +}
>   
> -		if (!flush_rcache)
> -			return 0;
> +static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
> +{
> +	BUG_ON(iova_magazine_full(mag));
>   
> -		/* Try replenishing IOVAs by flushing rcache. */
> -		flush_rcache = false;
> -		for_each_online_cpu(cpu)
> -			free_cpu_cached_iovas(cpu, iovad);
> -		free_global_cached_iovas(iovad);
> -		goto retry;
> -	}
> +	mag->pfns[mag->size++] = pfn;
> +}
>   
> -	return new_iova->pfn_lo;
> +static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
> +{
> +	return kzalloc(sizeof(struct iova_magazine), flags);
>   }
> -EXPORT_SYMBOL_GPL(alloc_iova_fast);
>   
> -/**
> - * free_iova_fast - free iova pfn range into rcache
> - * @iovad: - iova domain in question.
> - * @pfn: - pfn that is allocated previously
> - * @size: - # of pages in range
> - * This functions frees an iova range by trying to put it into the rcache,
> - * falling back to regular iova deallocation via free_iova() if this fails.
> - */
> -void
> -free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
> -{
> -	if (iova_rcache_insert(iovad, pfn, size))
> -		return;
> -
> -	free_iova(iovad, pfn);
> -}
> -EXPORT_SYMBOL_GPL(free_iova_fast);
> -
> -static void iova_domain_free_rcaches(struct iova_domain *iovad)
> -{
> -	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
> -					    &iovad->cpuhp_dead);
> -	free_iova_rcaches(iovad);
> -}
> -
> -/**
> - * put_iova_domain - destroys the iova domain
> - * @iovad: - iova domain in question.
> - * All the iova's in that domain are destroyed.
> - */
> -void put_iova_domain(struct iova_domain *iovad)
> -{
> -	struct iova *iova, *tmp;
> -
> -	if (iovad->rcaches)
> -		iova_domain_free_rcaches(iovad);
> -
> -	rbtree_postorder_for_each_entry_safe(iova, tmp, &iovad->rbroot, node)
> -		free_iova_mem(iova);
> -}
> -EXPORT_SYMBOL_GPL(put_iova_domain);
> -
> -static int
> -__is_range_overlap(struct rb_node *node,
> -	unsigned long pfn_lo, unsigned long pfn_hi)
> -{
> -	struct iova *iova = to_iova(node);
> -
> -	if ((pfn_lo <= iova->pfn_hi) && (pfn_hi >= iova->pfn_lo))
> -		return 1;
> -	return 0;
> -}
> -
> -static inline struct iova *
> -alloc_and_init_iova(unsigned long pfn_lo, unsigned long pfn_hi)
> -{
> -	struct iova *iova;
> -
> -	iova = alloc_iova_mem();
> -	if (iova) {
> -		iova->pfn_lo = pfn_lo;
> -		iova->pfn_hi = pfn_hi;
> -	}
> -
> -	return iova;
> -}
> -
> -static struct iova *
> -__insert_new_range(struct iova_domain *iovad,
> -	unsigned long pfn_lo, unsigned long pfn_hi)
> +static void iova_magazine_free(struct iova_magazine *mag)
>   {
> -	struct iova *iova;
> -
> -	iova = alloc_and_init_iova(pfn_lo, pfn_hi);
> -	if (iova)
> -		iova_insert_rbtree(&iovad->rbroot, iova, NULL);
> -
> -	return iova;
> +	kfree(mag);
>   }
>   
> -static void
> -__adjust_overlap_range(struct iova *iova,
> -	unsigned long *pfn_lo, unsigned long *pfn_hi)
> +static bool iova_magazine_empty(struct iova_magazine *mag)
>   {
> -	if (*pfn_lo < iova->pfn_lo)
> -		iova->pfn_lo = *pfn_lo;
> -	if (*pfn_hi > iova->pfn_hi)
> -		*pfn_lo = iova->pfn_hi + 1;
> +	return (!mag || mag->size == 0);
>   }
>   
> -/**
> - * reserve_iova - reserves an iova in the given range
> - * @iovad: - iova domain pointer
> - * @pfn_lo: - lower page frame address
> - * @pfn_hi:- higher pfn adderss
> - * This function allocates reserves the address range from pfn_lo to pfn_hi so
> - * that this address is not dished out as part of alloc_iova.
> - */
> -struct iova *
> -reserve_iova(struct iova_domain *iovad,
> -	unsigned long pfn_lo, unsigned long pfn_hi)
> +static unsigned long iova_magazine_pop(struct iova_magazine *mag,
> +				       unsigned long limit_pfn)
>   {
> -	struct rb_node *node;
> -	unsigned long flags;
> -	struct iova *iova;
> -	unsigned int overlap = 0;
> -
> -	/* Don't allow nonsensical pfns */
> -	if (WARN_ON((pfn_hi | pfn_lo) > (ULLONG_MAX >> iova_shift(iovad))))
> -		return NULL;
> -
> -	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> -	for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
> -		if (__is_range_overlap(node, pfn_lo, pfn_hi)) {
> -			iova = to_iova(node);
> -			__adjust_overlap_range(iova, &pfn_lo, &pfn_hi);
> -			if ((pfn_lo >= iova->pfn_lo) &&
> -				(pfn_hi <= iova->pfn_hi))
> -				goto finish;
> -			overlap = 1;
> -
> -		} else if (overlap)
> -				break;
> -	}
> -
> -	/* We are here either because this is the first reserver node
> -	 * or need to insert remaining non overlap addr range
> -	 */
> -	iova = __insert_new_range(iovad, pfn_lo, pfn_hi);
> -finish:
> -
> -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -	return iova;
> -}
> -EXPORT_SYMBOL_GPL(reserve_iova);
> -
> -/*
> - * Magazine caches for IOVA ranges.  For an introduction to magazines,
> - * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
> - * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
> - * For simplicity, we use a static magazine size and don't implement the
> - * dynamic size tuning described in the paper.
> - */
> -
> -/*
> - * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
> - * assure size of 'iova_magazine' to be 1024 bytes, so that no memory
> - * will be wasted.
> - */
> -#define IOVA_MAG_SIZE 127
> -#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
> -
> -struct iova_magazine {
> -	unsigned long size;
> -	unsigned long pfns[IOVA_MAG_SIZE];
> -};
> +	int i;
> +	unsigned long pfn;
>   
> -struct iova_cpu_rcache {
> -	spinlock_t lock;
> -	struct iova_magazine *loaded;
> -	struct iova_magazine *prev;
> -};
> +	BUG_ON(iova_magazine_empty(mag));
>   
> -struct iova_rcache {
> -	spinlock_t lock;
> -	unsigned long depot_size;
> -	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
> -	struct iova_cpu_rcache __percpu *cpu_rcaches;
> -};
> +	/* Only fall back to the rbtree if we have no suitable pfns at all */
> +	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
> +		if (i == 0)
> +			return 0;
>   
> -static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
> -{
> -	return kzalloc(sizeof(struct iova_magazine), flags);
> -}
> +	/* Swap it to pop it */
> +	pfn = mag->pfns[i];
> +	mag->pfns[i] = mag->pfns[--mag->size];
>   
> -static void iova_magazine_free(struct iova_magazine *mag)
> -{
> -	kfree(mag);
> +	return pfn;
>   }
>   
>   static void
> @@ -676,91 +526,91 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   	mag->size = 0;
>   }
>   
> -static bool iova_magazine_full(struct iova_magazine *mag)
> -{
> -	return (mag && mag->size == IOVA_MAG_SIZE);
> -}
> -
> -static bool iova_magazine_empty(struct iova_magazine *mag)
> -{
> -	return (!mag || mag->size == 0);
> -}
> -
> -static unsigned long iova_magazine_pop(struct iova_magazine *mag,
> -				       unsigned long limit_pfn)
> +/*
> + * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)
> + */
> +static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>   {
> +	struct iova_cpu_rcache *cpu_rcache;
> +	struct iova_rcache *rcache;
> +	unsigned long flags;
>   	int i;
> -	unsigned long pfn;
> -
> -	BUG_ON(iova_magazine_empty(mag));
> -
> -	/* Only fall back to the rbtree if we have no suitable pfns at all */
> -	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
> -		if (i == 0)
> -			return 0;
> -
> -	/* Swap it to pop it */
> -	pfn = mag->pfns[i];
> -	mag->pfns[i] = mag->pfns[--mag->size];
>   
> -	return pfn;
> +	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +		rcache = &iovad->rcaches[i];
> +		cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
> +		spin_lock_irqsave(&cpu_rcache->lock, flags);
> +		iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
> +		iova_magazine_free_pfns(cpu_rcache->prev, iovad);
> +		spin_unlock_irqrestore(&cpu_rcache->lock, flags);
> +	}
>   }
>   
> -static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
> +static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
>   {
> -	BUG_ON(iova_magazine_full(mag));
> +	struct iova_domain *iovad;
>   
> -	mag->pfns[mag->size++] = pfn;
> +	iovad = hlist_entry_safe(node, struct iova_domain, cpuhp_dead);
> +
> +	free_cpu_cached_iovas(cpu, iovad);
> +	return 0;
>   }
>   
> -int iova_domain_init_rcaches(struct iova_domain *iovad)
> +/*
> + * free all the IOVA ranges of global cache
> + */
> +static void free_global_cached_iovas(struct iova_domain *iovad)
>   {
> -	unsigned int cpu;
> -	int i, ret;
> -
> -	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
> -				 sizeof(struct iova_rcache),
> -				 GFP_KERNEL);
> -	if (!iovad->rcaches)
> -		return -ENOMEM;
> +	struct iova_rcache *rcache;
> +	unsigned long flags;
> +	int i, j;
>   
>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> -		struct iova_cpu_rcache *cpu_rcache;
> -		struct iova_rcache *rcache;
> -
>   		rcache = &iovad->rcaches[i];
> -		spin_lock_init(&rcache->lock);
> -		rcache->depot_size = 0;
> -		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
> -						     cache_line_size());
> -		if (!rcache->cpu_rcaches) {
> -			ret = -ENOMEM;
> -			goto out_err;
> +		spin_lock_irqsave(&rcache->lock, flags);
> +		for (j = 0; j < rcache->depot_size; ++j) {
> +			iova_magazine_free_pfns(rcache->depot[j], iovad);
> +			iova_magazine_free(rcache->depot[j]);
>   		}
> -		for_each_possible_cpu(cpu) {
> -			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
> +		rcache->depot_size = 0;
> +		spin_unlock_irqrestore(&rcache->lock, flags);
> +	}
> +}
>   
> -			spin_lock_init(&cpu_rcache->lock);
> -			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
> -			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
> -			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
> -				ret = -ENOMEM;
> -				goto out_err;
> -			}
> +/*
> + * free rcache data structures.
> + */
> +static void free_iova_rcaches(struct iova_domain *iovad)
> +{
> +	struct iova_rcache *rcache;
> +	struct iova_cpu_rcache *cpu_rcache;
> +	unsigned int cpu;
> +	int i, j;
> +
> +	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +		rcache = &iovad->rcaches[i];
> +		if (!rcache->cpu_rcaches)
> +			break;
> +		for_each_possible_cpu(cpu) {
> +			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
> +			iova_magazine_free(cpu_rcache->loaded);
> +			iova_magazine_free(cpu_rcache->prev);
>   		}
> +		free_percpu(rcache->cpu_rcaches);
> +		for (j = 0; j < rcache->depot_size; ++j)
> +			iova_magazine_free(rcache->depot[j]);
>   	}
>   
> -	ret = cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
> -					       &iovad->cpuhp_dead);
> -	if (ret)
> -		goto out_err;
> -	return 0;
> +	kfree(iovad->rcaches);
> +	iovad->rcaches = NULL;
> +}
>   
> -out_err:
> +static void iova_domain_free_rcaches(struct iova_domain *iovad)
> +{
> +	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
> +					    &iovad->cpuhp_dead);
>   	free_iova_rcaches(iovad);
> -	return ret;
>   }
> -EXPORT_SYMBOL_GPL(iova_domain_init_rcaches);
>   
>   /*
>    * Try inserting IOVA range starting with 'iova_pfn' into 'rcache', and
> @@ -883,73 +733,212 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>   	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
>   }
>   
> -/*
> - * free rcache data structures.
> +/**
> + * alloc_iova_fast - allocates an iova from rcache
> + * @iovad: - iova domain in question
> + * @size: - size of page frames to allocate
> + * @limit_pfn: - max limit address
> + * @flush_rcache: - set to flush rcache on regular allocation failure
> + * This function tries to satisfy an iova allocation from the rcache,
> + * and falls back to regular allocation on failure. If regular allocation
> + * fails too and the flush_rcache flag is set then the rcache will be flushed.
>    */
> -static void free_iova_rcaches(struct iova_domain *iovad)
> +unsigned long
> +alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
> +		unsigned long limit_pfn, bool flush_rcache)
> +{
> +	unsigned long iova_pfn;
> +	struct iova *new_iova;
> +
> +	/*
> +	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
> +	 * will come back to bite us badly, so we have to waste a bit of space
> +	 * rounding up anything cacheable to make sure that can't happen. The
> +	 * order of the unadjusted size will still match upon freeing.
> +	 */
> +	if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> +		size = roundup_pow_of_two(size);
> +
> +	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
> +	if (iova_pfn)
> +		return iova_pfn;
> +
> +retry:
> +	new_iova = alloc_iova(iovad, size, limit_pfn, true);
> +	if (!new_iova) {
> +		unsigned int cpu;
> +
> +		if (!flush_rcache)
> +			return 0;
> +
> +		/* Try replenishing IOVAs by flushing rcache. */
> +		flush_rcache = false;
> +		for_each_online_cpu(cpu)
> +			free_cpu_cached_iovas(cpu, iovad);
> +		free_global_cached_iovas(iovad);
> +		goto retry;
> +	}
> +
> +	return new_iova->pfn_lo;
> +}
> +EXPORT_SYMBOL_GPL(alloc_iova_fast);
> +
> +/**
> + * free_iova_fast - free iova pfn range into rcache
> + * @iovad: - iova domain in question.
> + * @pfn: - pfn that is allocated previously
> + * @size: - # of pages in range
> + * This functions frees an iova range by trying to put it into the rcache,
> + * falling back to regular iova deallocation via free_iova() if this fails.
> + */
> +void
> +free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
> +{
> +	if (iova_rcache_insert(iovad, pfn, size))
> +		return;
> +
> +	free_iova(iovad, pfn);
> +}
> +EXPORT_SYMBOL_GPL(free_iova_fast);
> +
> +int iova_domain_init_rcaches(struct iova_domain *iovad)
>   {
> -	struct iova_rcache *rcache;
> -	struct iova_cpu_rcache *cpu_rcache;
>   	unsigned int cpu;
> -	int i, j;
> +	int i, ret;
> +
> +	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
> +				 sizeof(struct iova_rcache),
> +				 GFP_KERNEL);
> +	if (!iovad->rcaches)
> +		return -ENOMEM;
>   
>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +		struct iova_cpu_rcache *cpu_rcache;
> +		struct iova_rcache *rcache;
> +
>   		rcache = &iovad->rcaches[i];
> -		if (!rcache->cpu_rcaches)
> -			break;
> +		spin_lock_init(&rcache->lock);
> +		rcache->depot_size = 0;
> +		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
> +						     cache_line_size());
> +		if (!rcache->cpu_rcaches) {
> +			ret = -ENOMEM;
> +			goto out_err;
> +		}
>   		for_each_possible_cpu(cpu) {
>   			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
> -			iova_magazine_free(cpu_rcache->loaded);
> -			iova_magazine_free(cpu_rcache->prev);
> +
> +			spin_lock_init(&cpu_rcache->lock);
> +			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
> +			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
> +			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
> +				ret = -ENOMEM;
> +				goto out_err;
> +			}
>   		}
> -		free_percpu(rcache->cpu_rcaches);
> -		for (j = 0; j < rcache->depot_size; ++j)
> -			iova_magazine_free(rcache->depot[j]);
>   	}
>   
> -	kfree(iovad->rcaches);
> -	iovad->rcaches = NULL;
> +	ret = cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
> +					       &iovad->cpuhp_dead);
> +	if (ret)
> +		goto out_err;
> +	return 0;
> +
> +out_err:
> +	free_iova_rcaches(iovad);
> +	return ret;
>   }
> +EXPORT_SYMBOL_GPL(iova_domain_init_rcaches);
>   
> -/*
> - * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)
> - */
> -static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
> +void
> +init_iova_domain(struct iova_domain *iovad, unsigned long granule,
> +	unsigned long start_pfn)
>   {
> -	struct iova_cpu_rcache *cpu_rcache;
> -	struct iova_rcache *rcache;
> -	unsigned long flags;
> -	int i;
> +	/*
> +	 * IOVA granularity will normally be equal to the smallest
> +	 * supported IOMMU page size; both *must* be capable of
> +	 * representing individual CPU pages exactly.
> +	 */
> +	BUG_ON((granule > PAGE_SIZE) || !is_power_of_2(granule));
>   
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> -		rcache = &iovad->rcaches[i];
> -		cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
> -		spin_lock_irqsave(&cpu_rcache->lock, flags);
> -		iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
> -		iova_magazine_free_pfns(cpu_rcache->prev, iovad);
> -		spin_unlock_irqrestore(&cpu_rcache->lock, flags);
> -	}
> +	spin_lock_init(&iovad->iova_rbtree_lock);
> +	iovad->rbroot = RB_ROOT;
> +	iovad->cached_node = &iovad->anchor.node;
> +	iovad->cached32_node = &iovad->anchor.node;
> +	iovad->granule = granule;
> +	iovad->start_pfn = start_pfn;
> +	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
> +	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
> +	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
> +	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
> +	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
>   }
> +EXPORT_SYMBOL_GPL(init_iova_domain);
>   
> -/*
> - * free all the IOVA ranges of global cache
> +/**
> + * put_iova_domain - destroys the iova domain
> + * @iovad: - iova domain in question.
> + * All the iova's in that domain are destroyed.
>    */
> -static void free_global_cached_iovas(struct iova_domain *iovad)
> +void put_iova_domain(struct iova_domain *iovad)
>   {
> -	struct iova_rcache *rcache;
> -	unsigned long flags;
> -	int i, j;
> +	struct iova *iova, *tmp;
>   
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> -		rcache = &iovad->rcaches[i];
> -		spin_lock_irqsave(&rcache->lock, flags);
> -		for (j = 0; j < rcache->depot_size; ++j) {
> -			iova_magazine_free_pfns(rcache->depot[j], iovad);
> -			iova_magazine_free(rcache->depot[j]);
> +	if (iovad->rcaches)
> +		iova_domain_free_rcaches(iovad);
> +
> +	rbtree_postorder_for_each_entry_safe(iova, tmp, &iovad->rbroot, node)
> +		free_iova_mem(iova);
> +}
> +EXPORT_SYMBOL_GPL(put_iova_domain);
> +
> +int iova_cache_get(void)
> +{
> +	mutex_lock(&iova_cache_mutex);
> +	if (!iova_cache_users) {
> +		int ret;
> +
> +		ret = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, "iommu/iova:dead", NULL,
> +					iova_cpuhp_dead);
> +		if (ret) {
> +			mutex_unlock(&iova_cache_mutex);
> +			pr_err("Couldn't register cpuhp handler\n");
> +			return ret;
>   		}
> -		rcache->depot_size = 0;
> -		spin_unlock_irqrestore(&rcache->lock, flags);
> +
> +		iova_cache = kmem_cache_create(
> +			"iommu_iova", sizeof(struct iova), 0,
> +			SLAB_HWCACHE_ALIGN, NULL);
> +		if (!iova_cache) {
> +			cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
> +			mutex_unlock(&iova_cache_mutex);
> +			pr_err("Couldn't create iova cache\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	iova_cache_users++;
> +	mutex_unlock(&iova_cache_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iova_cache_get);
> +
> +void iova_cache_put(void)
> +{
> +	mutex_lock(&iova_cache_mutex);
> +	if (WARN_ON(!iova_cache_users)) {
> +		mutex_unlock(&iova_cache_mutex);
> +		return;
>   	}
> +	iova_cache_users--;
> +	if (!iova_cache_users) {
> +		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
> +		kmem_cache_destroy(iova_cache);
> +	}
> +	mutex_unlock(&iova_cache_mutex);
>   }
> +EXPORT_SYMBOL_GPL(iova_cache_put);
> +
>   MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
>   MODULE_LICENSE("GPL");
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 320a70e40233..a167fb22c899 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -76,35 +76,26 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
>   }
>   
>   #if IS_ENABLED(CONFIG_IOMMU_IOVA)
> -int iova_cache_get(void);
> -void iova_cache_put(void);
> -
>   void free_iova(struct iova_domain *iovad, unsigned long pfn);
>   void __free_iova(struct iova_domain *iovad, struct iova *iova);
>   struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
>   	unsigned long limit_pfn,
>   	bool size_aligned);
> +struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
> +	unsigned long pfn_hi);
> +struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>   void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
>   		    unsigned long size);
>   unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>   			      unsigned long limit_pfn, bool flush_rcache);
> -struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
> -	unsigned long pfn_hi);
> +int iova_domain_init_rcaches(struct iova_domain *iovad);
>   void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>   	unsigned long start_pfn);
> -int iova_domain_init_rcaches(struct iova_domain *iovad);
> -struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>   void put_iova_domain(struct iova_domain *iovad);
> -#else
> -static inline int iova_cache_get(void)
> -{
> -	return -ENOTSUPP;
> -}
> -
> -static inline void iova_cache_put(void)
> -{
> -}
> +int iova_cache_get(void);
> +void iova_cache_put(void);
>   
> +#else
>   static inline void free_iova(struct iova_domain *iovad, unsigned long pfn)
>   {
>   }
> @@ -121,6 +112,19 @@ static inline struct iova *alloc_iova(struct iova_domain *iovad,
>   	return NULL;
>   }
>   
> +static inline struct iova *reserve_iova(struct iova_domain *iovad,
> +					unsigned long pfn_lo,
> +					unsigned long pfn_hi)
> +{
> +	return NULL;
> +}
> +
> +static inline struct iova *find_iova(struct iova_domain *iovad,
> +				     unsigned long pfn)
> +{
> +	return NULL;
> +}
> +
>   static inline void free_iova_fast(struct iova_domain *iovad,
>   				  unsigned long pfn,
>   				  unsigned long size)
> @@ -135,12 +139,6 @@ static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
>   	return 0;
>   }
>   
> -static inline struct iova *reserve_iova(struct iova_domain *iovad,
> -					unsigned long pfn_lo,
> -					unsigned long pfn_hi)
> -{
> -	return NULL;
> -}
>   
>   static inline void init_iova_domain(struct iova_domain *iovad,
>   				    unsigned long granule,
> @@ -148,13 +146,17 @@ static inline void init_iova_domain(struct iova_domain *iovad,
>   {
>   }
>   
> -static inline struct iova *find_iova(struct iova_domain *iovad,
> -				     unsigned long pfn)
> +
> +static inline void put_iova_domain(struct iova_domain *iovad)
>   {
> -	return NULL;
>   }
>   
> -static inline void put_iova_domain(struct iova_domain *iovad)
> +static inline int iova_cache_get(void)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline void iova_cache_put(void)
>   {
>   }
>   

