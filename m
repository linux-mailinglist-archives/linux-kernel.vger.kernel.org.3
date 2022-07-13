Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A6B572F50
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbiGMHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGMHgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:36:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA8BE43C3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657697804; x=1689233804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=baYNjrINGKubuturZ2TBTersOB6w/jQc+quIfBnQImg=;
  b=U6rORPUnxoGsqO1NFNejUGdz+skrHtMa7DeBvn14wYhUk7UtbKZnzuAC
   +yQsDIPbOTwy0hxdehzSeBeDrUZgPkykXqtIE8FpQ4d/bh27tG+mXRJl5
   DOX3cWSw+30i6jSz+0o23z2sKO/pZA92SH8kWfofOdLYvV6/bsXiYLDVn
   jCZYTD9anaifdfyWFnXwroKvsEOi5F6za+gtNpOJ20zt6xZjZE8UM5wGc
   DLz084n9yAcBR/26EcBIE93Ma7xUf+zUKrmTHnTdw3rcgZcwAXVJ30W70
   aJu5lnCAhctvrnY6kbMHm52mP+8Gk3ztGM2Ql6IhpZCniYfK2M/eWwXhI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="265548907"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="265548907"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 00:36:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="922528570"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2022 00:36:40 -0700
Date:   Wed, 13 Jul 2022 15:36:42 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v1] mm/slub: enable debugging memory wasting of kmalloc
Message-ID: <20220713073642.GA69088@shbuild999.sh.intel.com>
References: <20220701135954.45045-1-feng.tang@intel.com>
 <41763154-f923-ae99-55c0-0f3717636779@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41763154-f923-ae99-55c0-0f3717636779@suse.cz>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil,

On Mon, Jul 11, 2022 at 10:15:21AM +0200, Vlastimil Babka wrote:
> On 7/1/22 15:59, Feng Tang wrote:
> > kmalloc's API family is critical for mm, with one shortcoming that
> > its object size is fixed to be power of 2. When user requests memory
> > for '2^n + 1' bytes, actually 2^(n+1) bytes will be allocated, so
> > in worst case, there is around 50% memory space waste.
> > 
> > We've met a kernel boot OOM panic (v5.10), and from the dumped slab info:
> > 
> >     [   26.062145] kmalloc-2k            814056KB     814056KB
> > 
> > From debug we found there are huge number of 'struct iova_magazine',
> > whose size is 1032 bytes (1024 + 8), so each allocation will waste
> > 1016 bytes. Though the issue was solved by giving the right (bigger)
> > size of RAM, it is still nice to optimize the size (either use a
> > kmalloc friendly size or create a dedicated slab for it).
[...]
> 
> Hi and thanks.
> I would suggest some improvements to consider:
> 
> - don't use the struct track to store orig_size, although it's an obvious
> first choice. It's unused waste for the free_track, and also for any
> non-kmalloc caches. I'd carve out an extra int next to the struct tracks.
> Only for kmalloc caches (probably a new kmem cache flag set on creation will
> be needed to easily distinguish them).
> Besides the saved space, you can then set the field from ___slab_alloc()
> directly and not need to pass the orig_size also to alloc_debug_processing()
> etc.
 
Here is a draft patch fowlling your suggestion, please check if I missed
anything? (Quick test showed it achived similar effect as v1 patch). Thanks!

---
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0fefdf528e0d..d3dacb0f013f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -29,6 +29,8 @@
 #define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
 /* DEBUG: Poison objects */
 #define SLAB_POISON		((slab_flags_t __force)0x00000800U)
+/* Indicate a slab of kmalloc */
+#define SLAB_KMALLOC		((slab_flags_t __force)0x00001000U)
 /* Align objs on cache lines */
 #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
 /* Use GFP_DMA memory */
diff --git a/mm/slub.c b/mm/slub.c
index 26b00951aad1..3b0f80927817 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1030,6 +1030,9 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		/* We also have user information there */
 		off += 2 * sizeof(struct track);
 
+	if (s->flags & SLAB_KMALLOC)
+		off += sizeof(unsigned int);
+
 	off += kasan_metadata_size(s);
 
 	if (size_from_object(s) == off)
@@ -1323,9 +1326,38 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 	return 1;
 }
 
+
+static inline void set_orig_size(struct kmem_cache *s,
+					void *object, unsigned int orig_size)
+{
+	void *p = kasan_reset_tag(object);
+
+	p = object + get_info_end(s);
+
+	if (s->flags & SLAB_STORE_USER)
+		p += sizeof(struct track) * 2;
+
+	*(unsigned int *)p = orig_size;
+}
+
+static unsigned int get_orig_size(struct kmem_cache *s, void *object)
+{
+	void *p = kasan_reset_tag(object);
+
+	if (!(s->flags & SLAB_KMALLOC))
+		return s->object_size;
+
+	p = object + get_info_end(s);
+	if (s->flags & SLAB_STORE_USER)
+		p += sizeof(struct track) * 2;
+
+	return *(unsigned int *)p;
+}
+
 static noinline int alloc_debug_processing(struct kmem_cache *s,
 					struct slab *slab,
-					void *object, unsigned long addr)
+					void *object, unsigned long addr,
+					unsigned int orig_size)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!alloc_consistency_checks(s, slab, object))
@@ -1335,6 +1367,10 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 	/* Success perform special debug activities for allocs */
 	if (s->flags & SLAB_STORE_USER)
 		set_track(s, object, TRACK_ALLOC, addr);
+
+	if (s->flags & SLAB_KMALLOC)
+		set_orig_size(s, object, orig_size);
+
 	trace(s, slab, object, 1);
 	init_object(s, object, SLUB_RED_ACTIVE);
 	return 1;
@@ -1661,7 +1697,8 @@ static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 
 static inline int alloc_debug_processing(struct kmem_cache *s,
-	struct slab *slab, void *object, unsigned long addr) { return 0; }
+	struct slab *slab, void *object, unsigned long addr,
+	unsigned int orig_size) { return 0; }
 
 static inline int free_debug_processing(
 	struct kmem_cache *s, struct slab *slab,
@@ -2905,7 +2942,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
  * already disabled (which is the case for bulk allocation).
  */
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
+			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
 {
 	void *freelist;
 	struct slab *slab;
@@ -3048,7 +3085,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 check_new_slab:
 
 	if (kmem_cache_debug(s)) {
-		if (!alloc_debug_processing(s, slab, freelist, addr)) {
+		if (!alloc_debug_processing(s, slab, freelist, addr, orig_size)) {
 			/* Slab failed checks. Next slab needed */
 			goto new_slab;
 		} else {
@@ -3102,7 +3139,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
  * pointer.
  */
 static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
+			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
 {
 	void *p;
 
@@ -3115,7 +3152,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	c = slub_get_cpu_ptr(s->cpu_slab);
 #endif
 
-	p = ___slab_alloc(s, gfpflags, node, addr, c);
+	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
 #ifdef CONFIG_PREEMPT_COUNT
 	slub_put_cpu_ptr(s->cpu_slab);
 #endif
@@ -3206,7 +3243,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
 	    unlikely(!object || !slab || !node_match(slab, node))) {
-		object = __slab_alloc(s, gfpflags, node, addr, c);
+		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
 	} else {
 		void *next_object = get_freepointer_safe(s, object);
 
@@ -3709,7 +3746,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 * of re-populating per CPU c->freelist
 			 */
 			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
-					    _RET_IP_, c);
+					    _RET_IP_, c, s->object_size);
 			if (unlikely(!p[i]))
 				goto error;
 
@@ -4118,6 +4155,10 @@ static int calculate_sizes(struct kmem_cache *s)
 		 * the object.
 		 */
 		size += 2 * sizeof(struct track);
+
+	/* Save the original requsted kmalloc size */
+	if (flags & SLAB_KMALLOC)
+		size += sizeof(unsigned int);
 #endif
 
 	kasan_cache_create(s, &size, &s->flags);
@@ -4842,7 +4883,7 @@ void __init kmem_cache_init(void)
 
 	/* Now we can use the kmem_cache to allocate kmalloc slabs */
 	setup_kmalloc_cache_index_table();
-	create_kmalloc_caches(0);
+	create_kmalloc_caches(SLAB_KMALLOC);
 
 	/* Setup random freelists for each cache */
 	init_freelist_randomization();
@@ -5068,6 +5109,7 @@ struct location {
 	depot_stack_handle_t handle;
 	unsigned long count;
 	unsigned long addr;
+	unsigned long waste;
 	long long sum_time;
 	long min_time;
 	long max_time;
@@ -5114,13 +5156,15 @@ static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
 }
 
 static int add_location(struct loc_track *t, struct kmem_cache *s,
-				const struct track *track)
+				const struct track *track,
+				unsigned int orig_size)
 {
 	long start, end, pos;
 	struct location *l;
-	unsigned long caddr, chandle;
+	unsigned long caddr, chandle, cwaste;
 	unsigned long age = jiffies - track->when;
 	depot_stack_handle_t handle = 0;
+	unsigned int waste = s->object_size - orig_size;
 
 #ifdef CONFIG_STACKDEPOT
 	handle = READ_ONCE(track->handle);
@@ -5138,11 +5182,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 		if (pos == end)
 			break;
 
-		caddr = t->loc[pos].addr;
-		chandle = t->loc[pos].handle;
-		if ((track->addr == caddr) && (handle == chandle)) {
+		l = &t->loc[pos];
+		caddr = l->addr;
+		chandle = l->handle;
+		cwaste = l->waste;
+		if ((track->addr == caddr) && (handle == chandle) &&
+			(waste == cwaste)) {
 
-			l = &t->loc[pos];
 			l->count++;
 			if (track->when) {
 				l->sum_time += age;
@@ -5167,6 +5213,9 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 			end = pos;
 		else if (track->addr == caddr && handle < chandle)
 			end = pos;
+		else if (track->addr == caddr && handle == chandle &&
+				waste < cwaste)
+			end = pos;
 		else
 			start = pos;
 	}
@@ -5190,6 +5239,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 	l->min_pid = track->pid;
 	l->max_pid = track->pid;
 	l->handle = handle;
+	l->waste = waste;
 	cpumask_clear(to_cpumask(l->cpus));
 	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
 	nodes_clear(l->nodes);
@@ -5208,7 +5258,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
 
 	for_each_object(p, s, addr, slab->objects)
 		if (!test_bit(__obj_to_index(s, addr, p), obj_map))
-			add_location(t, s, get_track(s, p, alloc));
+			add_location(t, s, get_track(s, p, alloc), get_orig_size(s, p));
 }
 #endif  /* CONFIG_DEBUG_FS   */
 #endif	/* CONFIG_SLUB_DEBUG */
@@ -6078,6 +6128,10 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
 		else
 			seq_puts(seq, "<not-available>");
 
+		if (l->waste)
+			seq_printf(seq, " waste=%lu/%lu",
+				l->count * l->waste, l->waste);
+
 		if (l->sum_time != l->min_time) {
 			seq_printf(seq, " age=%ld/%llu/%ld",
 				l->min_time, div_u64(l->sum_time, l->count),

> - the knowledge of actual size could be used to improve poisoning checks as
> well, detect cases when there's buffer overrun over the orig_size but not
> cache's size. e.g. if you kmalloc(48) and overrun up to 64 we won't detect
> it now, but with orig_size stored we could?

The above patch doesn't touch this. As I have a question, for the
[orib_size, object_size) area, shall we fill it with POISON_XXX no matter
REDZONE flag is set or not?

Thanks,
Feng

> Thanks!
> Vlastimil
