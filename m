Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4693957A180
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbiGSO2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbiGSO16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:27:58 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AAB1EC63
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:15:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VJsADGy_1658240114;
Received: from 30.30.98.197(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VJsADGy_1658240114)
          by smtp.aliyun-inc.com;
          Tue, 19 Jul 2022 22:15:16 +0800
Message-ID: <5344e023-29f0-9285-a402-19e2a556dbb0@linux.alibaba.com>
Date:   Tue, 19 Jul 2022 22:15:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:103.0)
 Gecko/20100101 Thunderbird/103.0
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <69462916-2d1c-dd50-2e64-b31c2b61690e@suse.cz>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <69462916-2d1c-dd50-2e64-b31c2b61690e@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/22 7:09 PM, Vlastimil Babka wrote:
> 
> On 5/29/22 10:15, Rongwei Wang wrote:
>> In use cases where allocating and freeing slab frequently, some
>> error messages, such as "Left Redzone overwritten", "First byte
>> 0xbb instead of 0xcc" would be printed when validating slabs.
>> That's because an object has been filled with SLAB_RED_INACTIVE,
>> but has not been added to slab's freelist. And between these
>> two states, the behaviour of validating slab is likely to occur.
>>
>> Actually, it doesn't mean the slab can not work stably. But, these
>> confusing messages will disturb slab debugging more or less.
>>
>> Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> 
> As I've said in the sub-thread I had the following kind of fix in mind. I
> think it should cover the cases from your patches 1/3 and 3/3.
> 
> ----8<----
>  From c35fe2a781a7bc4ef37ef3ded289f4ced82562bd Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Mon, 4 Jul 2022 14:09:09 +0200
> Subject: [RFC] mm, slub: restrict sysfs validation to debug caches and make
>   it safe
> 
> Rongwei Wang reports [1] that cache validation triggered by writing to
> /sys/kernel/slab/<cache>/validate is racy against normal cache
> operations (e.g. freeing) in a way that can cause false positive
> inconsistency reports for caches with debugging enabled. The problem is
> that debugging actions that mark object free or active and actual
> freelist operations are not atomic, and the validation can see an
> inconsistent state.
> 
> For caches that don't have debugging enabled, other races are possible
> that result in false reports of wrong slab counts.
> 
> This patch attempts to solve these issues while not adding overhead to
> normal (especially fastpath) operations for caches that do not have
> debugging enabled, just to make possible userspace-triggered validation
> safe. Instead, disable the validation for caches that don't have
> debugging enabled and make the sysfs handler return -EINVAL.
> 
> For caches that do have debugging enabled, we can instead extend the
> existing approach of not using percpu freelists to force all operations
> to the slow paths where debugging is checked for and processed.
> 
> The processing on free in free_debug_processing() already happens under
> n->list_lock and slab_lock() so we can extend it to actually do the
> freeing as well and thus make it atomic against concurrent validation.
> 
> The processing on alloc in alloc_debug_processing() currently doesn't
> take any locks, but we have to first allocate the object from a slab on
> the partial list (as percpu slabs are always non-existent) and thus take
> n->list_lock. Add a function alloc_single_from_partial() that
> additionally takes slab_lock() for the debug processing and then grabs
> just the allocated object instead of the whole freelist. This again
> makes it atomic against validation and it is also ultimately more
> efficient than the current grabbing of freelist immediately followed by
> slab deactivation.
> 
> Neither of these changes affect the fast paths.
> 
> The function free_debug_processing() was moved so that it is placed
> later than the definitions of add_partial(), remove_partial() and
> discard_slab().
> 
> [1] https://lore.kernel.org/all/20220529081535.69275-1-rongwei.wang@linux.alibaba.com/
> 
> Reported-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>   mm/slub.c | 250 +++++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 174 insertions(+), 76 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b1281b8654bd..954fe7ad5ee1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1324,17 +1324,14 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
>   }
>   
>   static noinline int alloc_debug_processing(struct kmem_cache *s,
> -					struct slab *slab,
> -					void *object, unsigned long addr)
> +					struct slab *slab, void *object)
>   {
>   	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>   		if (!alloc_consistency_checks(s, slab, object))
>   			goto bad;
>   	}
>   
> -	/* Success perform special debug activities for allocs */
> -	if (s->flags & SLAB_STORE_USER)
> -		set_track(s, object, TRACK_ALLOC, addr);
> +	/* Success. Perform special debug activities for allocs */
>   	trace(s, slab, object, 1);
>   	init_object(s, object, SLUB_RED_ACTIVE);
>   	return 1;
> @@ -1385,63 +1382,6 @@ static inline int free_consistency_checks(struct kmem_cache *s,
>   	return 1;
>   }
>   
> -/* Supports checking bulk free of a constructed freelist */
> -static noinline int free_debug_processing(
> -	struct kmem_cache *s, struct slab *slab,
> -	void *head, void *tail, int bulk_cnt,
> -	unsigned long addr)
> -{
> -	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> -	void *object = head;
> -	int cnt = 0;
> -	unsigned long flags, flags2;
> -	int ret = 0;
> -	depot_stack_handle_t handle = 0;
> -
> -	if (s->flags & SLAB_STORE_USER)
> -		handle = set_track_prepare();
> -
> -	spin_lock_irqsave(&n->list_lock, flags);
> -	slab_lock(slab, &flags2);
> -
> -	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> -		if (!check_slab(s, slab))
> -			goto out;
> -	}
> -
> -next_object:
> -	cnt++;
> -
> -	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> -		if (!free_consistency_checks(s, slab, object, addr))
> -			goto out;
> -	}
> -
> -	if (s->flags & SLAB_STORE_USER)
> -		set_track_update(s, object, TRACK_FREE, addr, handle);
> -	trace(s, slab, object, 0);
> -	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
> -	init_object(s, object, SLUB_RED_INACTIVE);
> -
> -	/* Reached end of constructed freelist yet? */
> -	if (object != tail) {
> -		object = get_freepointer(s, object);
> -		goto next_object;
> -	}
> -	ret = 1;
> -
> -out:
> -	if (cnt != bulk_cnt)
> -		slab_err(s, slab, "Bulk freelist count(%d) invalid(%d)\n",
> -			 bulk_cnt, cnt);
> -
> -	slab_unlock(slab, &flags2);
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> -	if (!ret)
> -		slab_fix(s, "Object at 0x%p not freed", object);
> -	return ret;
> -}
> -
>   /*
>    * Parse a block of slub_debug options. Blocks are delimited by ';'
>    *
> @@ -1661,7 +1601,7 @@ static inline
>   void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
>   
>   static inline int alloc_debug_processing(struct kmem_cache *s,
> -	struct slab *slab, void *object, unsigned long addr) { return 0; }
> +	struct slab *slab, void *object) { return 0; }
>   
>   static inline int free_debug_processing(
>   	struct kmem_cache *s, struct slab *slab,
> @@ -2102,6 +2042,42 @@ static inline void remove_partial(struct kmem_cache_node *n,
>   	n->nr_partial--;
>   }
>   
> +/*
> + * Called only for kmem_cache_debug() caches instead of acquire_slab(), with a
> + * slab from the n->partial list. Removes only a single object from the slab
> + * under slab_lock(), does the alloc_debug_processing() checks and leaves the
> + * slab on the list, or moves it to full list if it was the last object.
> + */
> +static void *alloc_single_from_partial(struct kmem_cache *s,
> +		struct kmem_cache_node *n, struct slab *slab)
> +{
> +	void *object;
> +	unsigned long flags;
> +
> +	lockdep_assert_held(&n->list_lock);
> +
> +	slab_lock(slab, &flags);
> +
> +	object = slab->freelist;
> +	slab->freelist = get_freepointer(s, object);
> +	slab->inuse++;
> +
> +	if (!alloc_debug_processing(s, slab, object)) {
> +		remove_partial(n, slab);
> +		slab_unlock(slab, &flags);
> +		return NULL;
> +	}
> +
> +	if (slab->inuse == slab->objects) {
> +		remove_partial(n, slab);
> +		add_full(s, n, slab);
> +	}
> +
> +	slab_unlock(slab, &flags);
> +
> +	return object;
> +}
> +
>   /*
>    * Remove slab from the partial list, freeze it and
>    * return the pointer to the freelist.
> @@ -2182,6 +2158,13 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>   		if (!pfmemalloc_match(slab, gfpflags))
>   			continue;
>   
> +		if (kmem_cache_debug(s)) {
> +			object = alloc_single_from_partial(s, n, slab);
> +			if (object)
> +				break;
> +			continue;
> +		}
> +
>   		t = acquire_slab(s, n, slab, object == NULL);
>   		if (!t)
>   			break;
> @@ -2788,6 +2771,104 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
>   {
>   	return atomic_long_read(&n->total_objects);
>   }
> +
> +/* Supports checking bulk free of a constructed freelist */
> +static noinline int free_debug_processing(
> +	struct kmem_cache *s, struct slab *slab,
> +	void *head, void *tail, int bulk_cnt,
> +	unsigned long addr)
> +{
> +	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> +	struct slab *slab_to_discard = NULL;
> +	void *object = head;
> +	int cnt = 0;
> +	unsigned long flags, flags2;
> +	int ret = 0;
> +	depot_stack_handle_t handle = 0;
> +
> +	if (s->flags & SLAB_STORE_USER)
> +		handle = set_track_prepare();
> +
> +	spin_lock_irqsave(&n->list_lock, flags);
> +	slab_lock(slab, &flags2);
> +
> +	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> +		if (!check_slab(s, slab))
> +			goto out;
> +	}
> +
> +	if (slab->inuse < bulk_cnt) {
> +		slab_err(s, slab, "Slab has %d allocated objects but %d are to be freed\n",
> +			 slab->inuse, bulk_cnt);
> +		goto out;
> +	}
> +
> +next_object:
> +
> +	if (++cnt > bulk_cnt)
> +		goto out_cnt;
> +
> +	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> +		if (!free_consistency_checks(s, slab, object, addr))
> +			goto out;
> +	}
> +
> +	if (s->flags & SLAB_STORE_USER)
> +		set_track_update(s, object, TRACK_FREE, addr, handle);
> +	trace(s, slab, object, 0);
> +	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
> +	init_object(s, object, SLUB_RED_INACTIVE);
> +
> +	/* Reached end of constructed freelist yet? */
> +	if (object != tail) {
> +		object = get_freepointer(s, object);
> +		goto next_object;
> +	}
> +	ret = 1;
> +
> +out_cnt:
> +	if (cnt != bulk_cnt)
> +		slab_err(s, slab, "Bulk free expected %d objects but found %d\n",
> +			 bulk_cnt, cnt);
> +
> +out:
> +	if (ret) {
> +		void *prior = slab->freelist;
> +
> +		/* Perform the actual freeing while we still hold the locks */
> +		slab->inuse -= cnt;
> +		set_freepointer(s, tail, prior);
> +		slab->freelist = head;
> +
> +		/* Do we need to remove the slab from full or partial list? */
> +		if (!prior) {
> +			remove_full(s, n, slab);
> +		} else if (slab->inuse == 0) {
> +			remove_partial(n, slab);
> +			stat(s, FREE_REMOVE_PARTIAL);
> +		}
> +
> +		/* Do we need to discard the slab or add to partial list? */
> +		if (slab->inuse == 0) {
> +			slab_to_discard = slab;
> +		} else if (!prior) {
> +			add_partial(n, slab, DEACTIVATE_TO_TAIL);
> +			stat(s, FREE_ADD_PARTIAL);
> +		}
> +
> +	}
> +
> +	slab_unlock(slab, &flags2);
> +	spin_unlock_irqrestore(&n->list_lock, flags);
> +	if (!ret)
> +		slab_fix(s, "Object at 0x%p not freed", object);
> +	if (slab_to_discard) {
> +		stat(s, FREE_SLAB);
> +		discard_slab(s, slab);
> +	}
> +
> +	return ret;
> +}
I had test this patch, and it indeed deal with the bug that I described. 
Though I am also has prepared this part of code, your code is ok to me.

-wrw

>   #endif /* CONFIG_SLUB_DEBUG */
>   
>   #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
> @@ -3045,19 +3126,35 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>   
>   	stat(s, ALLOC_SLAB);
>   
> -check_new_slab:
> -
>   	if (kmem_cache_debug(s)) {
> -		if (!alloc_debug_processing(s, slab, freelist, addr)) {
> -			/* Slab failed checks. Next slab needed */
> -			goto new_slab;
> -		} else {
> +		if (!alloc_debug_processing(s, slab, freelist))
>   			/*
> -			 * For debug case, we don't load freelist so that all
> -			 * allocations go through alloc_debug_processing()
> +			 * It's not really expected that this would fail on a
> +			 * freshly allocated slab, but a concurrent memory
> +			 * corruption in theory could cause that.
>   			 */
> -			goto return_single;
> -		}
> +			goto new_slab;
> +
> +		/*
> +		 * For debug caches we don't load the freelist so that all
> +		 * allocations have to go through alloc_debug_processing()
> +		 */
> +		if (s->flags & SLAB_STORE_USER)
> +			set_track(s, freelist, TRACK_ALLOC, addr);
> +		goto return_single;
> +	}
> +
> +check_new_slab:
> +
> +	if (kmem_cache_debug(s)) {
> +		/*
> +		 * For debug caches here we had to go through
> +		 * alloc_single_from_partial() so just store the tracking info
> +		 * and return the object
> +		 */
> +		if (s->flags & SLAB_STORE_USER)
> +			set_track(s, freelist, TRACK_ALLOC, addr);
> +		return freelist;
>   	}
>   
>   	if (unlikely(!pfmemalloc_match(slab, gfpflags)))
> @@ -3341,9 +3438,10 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>   	if (kfence_free(head))
>   		return;
>   
> -	if (kmem_cache_debug(s) &&
> -	    !free_debug_processing(s, slab, head, tail, cnt, addr))
> +	if (kmem_cache_debug(s)) {
> +		free_debug_processing(s, slab, head, tail, cnt, addr);
>   		return;
> +	}
>   
>   	do {
>   		if (unlikely(n)) {
> @@ -5625,7 +5723,7 @@ static ssize_t validate_store(struct kmem_cache *s,
>   {
>   	int ret = -EINVAL;
>   
> -	if (buf[0] == '1') {
> +	if (buf[0] == '1' && kmem_cache_debug(s)) {
>   		ret = validate_slab_cache(s);
>   		if (ret >= 0)
>   			ret = length;
