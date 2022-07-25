Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA17D57FEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiGYMTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiGYMTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:19:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC1FE08A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:19:18 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LrzWv6mlGzWf9Q;
        Mon, 25 Jul 2022 20:15:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 20:19:16 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 20:19:15 +0800
Message-ID: <f1ee3bd6-d068-b401-04ef-e14ca55529ac@huawei.com>
Date:   Mon, 25 Jul 2022 20:19:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] mm/slub: enable debugging memory wasting of
 kmalloc
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Christoph Lameter" <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
References: <20220725112025.22625-1-feng.tang@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220725112025.22625-1-feng.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/25 19:20, Feng Tang wrote:
> kmalloc's API family is critical for mm, with one shortcoming that
> its object size is fixed to be power of 2. When user requests memory
> for '2^n + 1' bytes, actually 2^(n+1) bytes will be allocated, so
> in worst case, there is around 50% memory space waste.
>
> We've met a kernel boot OOM panic (v5.10), and from the dumped slab info:
>
>      [   26.062145] kmalloc-2k            814056KB     814056KB
>
> >From debug we found there are huge number of 'struct iova_magazine',
> whose size is 1032 bytes (1024 + 8), so each allocation will waste
> 1016 bytes. Though the issue was solved by giving the right (bigger)
> size of RAM, it is still nice to optimize the size (either use a
> kmalloc friendly size or create a dedicated slab for it).
>
> And from lkml archive, there was another crash kernel OOM case [1]
> back in 2019, which seems to be related with the similar slab waste
> situation, as the log is similar:
>
>      [    4.332648] iommu: Adding device 0000:20:02.0 to group 16
>      [    4.338946] swapper/0 invoked oom-killer: gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null), order=0, oom_score_adj=0
>      ...
>      [    4.857565] kmalloc-2048           59164KB      59164KB
>
> The crash kernel only has 256M memory, and 59M is pretty big here.
> (Note: the related code has been changed and optimised in recent
> kernel [2], these logs are picked just to demo the problem)
>
> So add an way to track each kmalloc's memory waste info, and leverage
> the existing SLUB debug framework to show its call stack info, so
> that user can evaluate the waste situation, identify some hot spots
> and optimize accordingly, for a better utilization of memory.
>
> The waste info is integrated into existing interface:
> /sys/kernel/debug/slab/kmalloc-xx/alloc_traces, one example of
> 'kmalloc-4k' after boot is:
>
> 126 ixgbe_alloc_q_vector+0xa5/0x4a0 [ixgbe] waste=233856/1856 age=1493302/1493830/1494358 pid=1284 cpus=32 nodes=1
>          __slab_alloc.isra.86+0x52/0x80
>          __kmalloc_node+0x143/0x350
>          ixgbe_alloc_q_vector+0xa5/0x4a0 [ixgbe]
>          ixgbe_init_interrupt_scheme+0x1a6/0x730 [ixgbe]
>          ixgbe_probe+0xc8e/0x10d0 [ixgbe]
>          local_pci_probe+0x42/0x80
>          work_for_cpu_fn+0x13/0x20
>          process_one_work+0x1c5/0x390
>
> which means in 'kmalloc-4k' slab, there are 126 requests of
> 2240 bytes which got a 4KB space (wasting 1856 bytes each
> and 233856 bytes in total). And when system starts some real
> workload like multiple docker instances, there are more
> severe waste.
>
> [1]. https://lkml.org/lkml/2019/8/12/266
> [2]. https://lore.kernel.org/lkml/2920df89-9975-5785-f79b-257d3052dfaf@huawei.com/
>
> [Thanks Hyeonggon for pointing out several bugs about sorting/format]
> [Thanks Vlastimil for suggesting way to reduce memory usage of
>   orig_size and keep it only for kmalloc objects]
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>    since v1:
>      * limit the 'orig_size' to kmalloc objects only, and save
>        it after track in metadata (Vlastimil Babka)
>      * fix a offset calculation problem in print_trailer
>
>    since RFC:
>      * fix problems in kmem_cache_alloc_bulk() and records sorting,
>        improve the print format (Hyeonggon Yoo)
>      * fix a compiling issue found by 0Day bot
>      * update the commit log based info from iova developers
>
>
>
>   include/linux/slab.h |  2 +
>   mm/slub.c            | 96 ++++++++++++++++++++++++++++++++++++--------
>   2 files changed, 82 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0fefdf528e0d..a713b0e5bbcd 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -29,6 +29,8 @@
>   #define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
>   /* DEBUG: Poison objects */
>   #define SLAB_POISON		((slab_flags_t __force)0x00000800U)
> +/* Indicate a kmalloc slab */
> +#define SLAB_KMALLOC		((slab_flags_t __force)0x00001000U)
>   /* Align objs on cache lines */
>   #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
>   /* Use GFP_DMA memory */
> diff --git a/mm/slub.c b/mm/slub.c
> index b1281b8654bd..9763a38bc4f0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -191,6 +191,12 @@ static inline bool kmem_cache_debug(struct kmem_cache *s)
>   	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
>   }
>   
> +static inline bool slub_debug_orig_size(struct kmem_cache *s)
> +{
> +	return (s->flags & SLAB_KMALLOC &&
> +			kmem_cache_debug_flags(s, SLAB_STORE_USER));
Swap two judgments to reduce the SLAB_KMALLOC check if no SLAB_STORE_USER.

> +}
> +
>   void *fixup_red_left(struct kmem_cache *s, void *p)
>   {
>   	if (kmem_cache_debug_flags(s, SLAB_RED_ZONE))
> @@ -814,6 +820,36 @@ static void print_slab_info(const struct slab *slab)
>   	pr_err("Slab 0x%p objects=%u used=%u fp=0x%p flags=%pGp\n",
>   	       slab, slab->objects, slab->inuse, slab->freelist,
>   	       folio_flags(folio, 0));
> +
> +}
> +static inline void set_orig_size(struct kmem_cache *s,
> +					void *object, unsigned int orig_size)
> +{
> +	void *p = kasan_reset_tag(object);
> +
> +	if (!slub_debug_orig_size(s))
> +		return;
> +
> +	p = object + get_info_end(s);
Look like p += get_info_end(s);  ?
> +
> +	if (s->flags & SLAB_STORE_USER)
> +		p += sizeof(struct track) * 2;
> +
> +	*(unsigned int *)p = orig_size;
> +}
> +
> +static unsigned int get_orig_size(struct kmem_cache *s, void *object)
> +{
> +	void *p = kasan_reset_tag(object);
> +
> +	if (!slub_debug_orig_size(s))
> +		return s->object_size;
> +
> +	p = object + get_info_end(s);
ditto...
> +	if (s->flags & SLAB_STORE_USER)
> +		p += sizeof(struct track) * 2;
> +
> +	return *(unsigned int *)p;
>   }
>   
>   static void slab_bug(struct kmem_cache *s, char *fmt, ...)
> @@ -875,6 +911,9 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
>   	if (s->flags & SLAB_STORE_USER)
>   		off += 2 * sizeof(struct track);
>   
> +	if (slub_debug_orig_size(s))
> +		off += sizeof(unsigned int);
> +
>   	off += kasan_metadata_size(s);
>   
>   	if (off != size_from_object(s))
> @@ -1030,6 +1069,9 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
>   		/* We also have user information there */
>   		off += 2 * sizeof(struct track);
>   
> +	if (slub_debug_orig_size(s))
> +		off += sizeof(unsigned int);
> +
>   	off += kasan_metadata_size(s);
>   
>   	if (size_from_object(s) == off)
> @@ -1325,7 +1367,8 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
>   
>   static noinline int alloc_debug_processing(struct kmem_cache *s,
>   					struct slab *slab,
> -					void *object, unsigned long addr)
> +					void *object, unsigned long addr,
> +					unsigned int orig_size)
>   {
>   	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>   		if (!alloc_consistency_checks(s, slab, object))
> @@ -1335,6 +1378,9 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
>   	/* Success perform special debug activities for allocs */
>   	if (s->flags & SLAB_STORE_USER)
>   		set_track(s, object, TRACK_ALLOC, addr);
> +
> +	set_orig_size(s, object, orig_size);
> +
>   	trace(s, slab, object, 1);
>   	init_object(s, object, SLUB_RED_ACTIVE);
>   	return 1;
> @@ -1661,7 +1707,8 @@ static inline
>   void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
>   
>   static inline int alloc_debug_processing(struct kmem_cache *s,
> -	struct slab *slab, void *object, unsigned long addr) { return 0; }
> +	struct slab *slab, void *object, unsigned long addr,
> +	unsigned int orig_size) { return 0; }
>   
>   static inline int free_debug_processing(
>   	struct kmem_cache *s, struct slab *slab,
> @@ -2905,7 +2952,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
>    * already disabled (which is the case for bulk allocation).
>    */
>   static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -			  unsigned long addr, struct kmem_cache_cpu *c)
> +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>   {
>   	void *freelist;
>   	struct slab *slab;
> @@ -3048,7 +3095,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>   check_new_slab:
>   
>   	if (kmem_cache_debug(s)) {
> -		if (!alloc_debug_processing(s, slab, freelist, addr)) {
> +		if (!alloc_debug_processing(s, slab, freelist, addr, orig_size)) {
>   			/* Slab failed checks. Next slab needed */
>   			goto new_slab;
>   		} else {
> @@ -3102,7 +3149,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>    * pointer.
>    */
>   static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -			  unsigned long addr, struct kmem_cache_cpu *c)
> +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>   {
>   	void *p;
>   
> @@ -3115,7 +3162,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>   	c = slub_get_cpu_ptr(s->cpu_slab);
>   #endif
>   
> -	p = ___slab_alloc(s, gfpflags, node, addr, c);
> +	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
>   #ifdef CONFIG_PREEMPT_COUNT
>   	slub_put_cpu_ptr(s->cpu_slab);
>   #endif
> @@ -3206,7 +3253,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
>   	 */
>   	if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
>   	    unlikely(!object || !slab || !node_match(slab, node))) {
> -		object = __slab_alloc(s, gfpflags, node, addr, c);
> +		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
>   	} else {
>   		void *next_object = get_freepointer_safe(s, object);
>   
> @@ -3731,7 +3778,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>   			 * of re-populating per CPU c->freelist
>   			 */
>   			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
> -					    _RET_IP_, c);
> +					    _RET_IP_, c, s->object_size);
>   			if (unlikely(!p[i]))
>   				goto error;
>   
> @@ -4140,6 +4187,10 @@ static int calculate_sizes(struct kmem_cache *s)
>   		 * the object.
>   		 */
>   		size += 2 * sizeof(struct track);
> +
> +	/* Save the original requested kmalloc size */
> +	if (slub_debug_orig_size(s))
> +		size += sizeof(unsigned int);
>   #endif
>   
>   	kasan_cache_create(s, &size, &s->flags);
> @@ -4864,7 +4915,7 @@ void __init kmem_cache_init(void)
>   
>   	/* Now we can use the kmem_cache to allocate kmalloc slabs */
>   	setup_kmalloc_cache_index_table();
> -	create_kmalloc_caches(0);
> +	create_kmalloc_caches(SLAB_KMALLOC);
>   
>   	/* Setup random freelists for each cache */
>   	init_freelist_randomization();
> @@ -5092,6 +5143,7 @@ struct location {
>   	depot_stack_handle_t handle;
>   	unsigned long count;
>   	unsigned long addr;
> +	unsigned long waste;
>   	long long sum_time;
>   	long min_time;
>   	long max_time;
> @@ -5138,13 +5190,15 @@ static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
>   }
>   
>   static int add_location(struct loc_track *t, struct kmem_cache *s,
> -				const struct track *track)
> +				const struct track *track,
> +				unsigned int orig_size)
>   {
>   	long start, end, pos;
>   	struct location *l;
> -	unsigned long caddr, chandle;
> +	unsigned long caddr, chandle, cwaste;
>   	unsigned long age = jiffies - track->when;
>   	depot_stack_handle_t handle = 0;
> +	unsigned int waste = s->object_size - orig_size;
>   
>   #ifdef CONFIG_STACKDEPOT
>   	handle = READ_ONCE(track->handle);
> @@ -5162,11 +5216,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>   		if (pos == end)
>   			break;
>   
> -		caddr = t->loc[pos].addr;
> -		chandle = t->loc[pos].handle;
> -		if ((track->addr == caddr) && (handle == chandle)) {
> +		l = &t->loc[pos];
> +		caddr = l->addr;
> +		chandle = l->handle;
> +		cwaste = l->waste;
> +		if ((track->addr == caddr) && (handle == chandle) &&
> +			(waste == cwaste)) {
>   
> -			l = &t->loc[pos];
>   			l->count++;
>   			if (track->when) {
>   				l->sum_time += age;
> @@ -5191,6 +5247,9 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>   			end = pos;
>   		else if (track->addr == caddr && handle < chandle)
>   			end = pos;
> +		else if (track->addr == caddr && handle == chandle &&
> +				waste < cwaste)
> +			end = pos;
>   		else
>   			start = pos;
>   	}
> @@ -5214,6 +5273,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>   	l->min_pid = track->pid;
>   	l->max_pid = track->pid;
>   	l->handle = handle;
> +	l->waste = waste;
>   	cpumask_clear(to_cpumask(l->cpus));
>   	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
>   	nodes_clear(l->nodes);
> @@ -5232,7 +5292,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
>   
>   	for_each_object(p, s, addr, slab->objects)
>   		if (!test_bit(__obj_to_index(s, addr, p), obj_map))
> -			add_location(t, s, get_track(s, p, alloc));
> +			add_location(t, s, get_track(s, p, alloc), get_orig_size(s, p));
>   }
>   #endif  /* CONFIG_DEBUG_FS   */
>   #endif	/* CONFIG_SLUB_DEBUG */
> @@ -6102,6 +6162,10 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
>   		else
>   			seq_puts(seq, "<not-available>");
>   
> +		if (l->waste)
> +			seq_printf(seq, " waste=%lu/%lu",
> +				l->count * l->waste, l->waste);
> +
>   		if (l->sum_time != l->min_time) {
>   			seq_printf(seq, " age=%ld/%llu/%ld",
>   				l->min_time, div_u64(l->sum_time, l->count),
