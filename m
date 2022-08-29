Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518AD5A4442
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiH2Hz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiH2Hzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:55:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFF01AF39
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661759749; x=1693295749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lMLQJwLUrbqI+5Q5kd/ruqcHqe/+ifhPY34+3AYEgh8=;
  b=e0EAlW5asKEtz/I5oIBZMoYHJrSuNIyYBMhbFiTp4+ya30DGwsVnxTn9
   lQyB/x7b752UcIY/2JXu1M7mnj59P5qf0BnWdgJuU98MHrOAzoMRsJWXw
   5ppISK4JXlotYvnX9qpIEji0Z0pIOjf02FnY7dcGOUIF+ThCHWZgHPZsd
   hj923D0mSUQqQovOtpfTUpSJ9BRlC8iYkZO08W2aoiKzmG+hwCZmGIxXH
   IawyuhBIBp6PPFDXXpgzfikhxyI9kg8qLvD25YtiVlYM3I9cCqb8X5sWt
   SRAd/te98kQW5EH9lsXuMvEw9T9bslTbe/UySid2UIi1gWBFjvKs5En8Z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="381140120"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="381140120"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="672283553"
Received: from shbuild999.sh.intel.com ([10.239.147.181])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2022 00:55:46 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of kmalloc
Date:   Mon, 29 Aug 2022 15:56:15 +0800
Message-Id: <20220829075618.69069-2-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220829075618.69069-1-feng.tang@intel.com>
References: <20220829075618.69069-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc's API family is critical for mm, with one nature that it will
round up the request size to a fixed one (mostly power of 2). Say
when user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
could be allocated, so in worst case, there is around 50% memory
space waste.

The wastage is not a big issue for requests that get allocated/freed
quickly, but may cause problems with objects that have longer life
time.

We've met a kernel boot OOM panic (v5.10), and from the dumped slab
info:

    [   26.062145] kmalloc-2k            814056KB     814056KB

From debug we found there are huge number of 'struct iova_magazine',
whose size is 1032 bytes (1024 + 8), so each allocation will waste
1016 bytes. Though the issue was solved by giving the right (bigger)
size of RAM, it is still nice to optimize the size (either use a
kmalloc friendly size or create a dedicated slab for it).

And from lkml archive, there was another crash kernel OOM case [1]
back in 2019, which seems to be related with the similar slab waste
situation, as the log is similar:

    [    4.332648] iommu: Adding device 0000:20:02.0 to group 16
    [    4.338946] swapper/0 invoked oom-killer: gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null), order=0, oom_score_adj=0
    ...
    [    4.857565] kmalloc-2048           59164KB      59164KB

The crash kernel only has 256M memory, and 59M is pretty big here.
(Note: the related code has been changed and optimised in recent
kernel [2], these logs are just picked to demo the problem, also
a patch changing its size to 1024 bytes has been merged)

So add an way to track each kmalloc's memory waste info, and
leverage the existing SLUB debug framework (specifically
SLUB_STORE_USER) to show its call stack of original allocation,
so that user can evaluate the waste situation, identify some hot
spots and optimize accordingly, for a better utilization of memory.

The waste info is integrated into existing interface:
'/sys/kernel/debug/slab/kmalloc-xx/alloc_traces', one example of
'kmalloc-4k' after boot is:

126 ixgbe_alloc_q_vector+0xa5/0x4a0 [ixgbe] waste=233856/1856 age=1493302/1493830/1494358 pid=1284 cpus=32 nodes=1
        __slab_alloc.isra.86+0x52/0x80
        __kmalloc_node+0x143/0x350
        ixgbe_alloc_q_vector+0xa5/0x4a0 [ixgbe]
        ixgbe_init_interrupt_scheme+0x1a6/0x730 [ixgbe]
        ixgbe_probe+0xc8e/0x10d0 [ixgbe]
        local_pci_probe+0x42/0x80
        work_for_cpu_fn+0x13/0x20
        process_one_work+0x1c5/0x390

which means in 'kmalloc-4k' slab, there are 126 requests of
2240 bytes which got a 4KB space (wasting 1856 bytes each
and 233856 bytes in total). And when system starts some real
workload like multiple docker instances, there are more
severe waste.

[1]. https://lkml.org/lkml/2019/8/12/266
[2]. https://lore.kernel.org/lkml/2920df89-9975-5785-f79b-257d3052dfaf@huawei.com/

[Thanks Hyeonggon for pointing out several bugs about sorting/format]
[Thanks Vlastimil for suggesting way to reduce memory usage of
 orig_size and keep it only for kmalloc objects]

Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/slab.h |  2 +
 mm/slub.c            | 94 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 81 insertions(+), 15 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9b592e611cb1..6dc495f76644 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -29,6 +29,8 @@
 #define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
 /* DEBUG: Poison objects */
 #define SLAB_POISON		((slab_flags_t __force)0x00000800U)
+/* Indicate a kmalloc slab */
+#define SLAB_KMALLOC		((slab_flags_t __force)0x00001000U)
 /* Align objs on cache lines */
 #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
 /* Use GFP_DMA memory */
diff --git a/mm/slub.c b/mm/slub.c
index 5df44e00b1aa..d8bab650ed99 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -199,6 +199,12 @@ static inline bool kmem_cache_debug(struct kmem_cache *s)
 	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
 }
 
+static inline bool slub_debug_orig_size(struct kmem_cache *s)
+{
+	return (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
+			(s->flags & SLAB_KMALLOC));
+}
+
 void *fixup_red_left(struct kmem_cache *s, void *p)
 {
 	if (kmem_cache_debug_flags(s, SLAB_RED_ZONE))
@@ -785,6 +791,33 @@ static void print_slab_info(const struct slab *slab)
 	       folio_flags(folio, 0));
 }
 
+static inline void set_orig_size(struct kmem_cache *s,
+					void *object, unsigned int orig_size)
+{
+	void *p = kasan_reset_tag(object);
+
+	if (!slub_debug_orig_size(s))
+		return;
+
+	p += get_info_end(s);
+	p += sizeof(struct track) * 2;
+
+	*(unsigned int *)p = orig_size;
+}
+
+static unsigned int get_orig_size(struct kmem_cache *s, void *object)
+{
+	void *p = kasan_reset_tag(object);
+
+	if (!slub_debug_orig_size(s))
+		return s->object_size;
+
+	p += get_info_end(s);
+	p += sizeof(struct track) * 2;
+
+	return *(unsigned int *)p;
+}
+
 static void slab_bug(struct kmem_cache *s, char *fmt, ...)
 {
 	struct va_format vaf;
@@ -844,6 +877,9 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 	if (s->flags & SLAB_STORE_USER)
 		off += 2 * sizeof(struct track);
 
+	if (slub_debug_orig_size(s))
+		off += sizeof(unsigned int);
+
 	off += kasan_metadata_size(s);
 
 	if (off != size_from_object(s))
@@ -995,10 +1031,14 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 {
 	unsigned long off = get_info_end(s);	/* The end of info */
 
-	if (s->flags & SLAB_STORE_USER)
+	if (s->flags & SLAB_STORE_USER) {
 		/* We also have user information there */
 		off += 2 * sizeof(struct track);
 
+		if (s->flags & SLAB_KMALLOC)
+			off += sizeof(unsigned int);
+	}
+
 	off += kasan_metadata_size(s);
 
 	if (size_from_object(s) == off)
@@ -1572,6 +1612,9 @@ void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 static inline int alloc_debug_processing(struct kmem_cache *s,
 	struct slab *slab, void *object) { return 0; }
 
+static inline void set_orig_size(struct kmem_cache *s,
+	void *object, unsigned int orig_size) {}
+
 static inline void free_debug_processing(
 	struct kmem_cache *s, struct slab *slab,
 	void *head, void *tail, int bulk_cnt,
@@ -2974,7 +3017,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
  * already disabled (which is the case for bulk allocation).
  */
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
+			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
 {
 	void *freelist;
 	struct slab *slab;
@@ -3115,6 +3158,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 		if (s->flags & SLAB_STORE_USER)
 			set_track(s, freelist, TRACK_ALLOC, addr);
+		set_orig_size(s, freelist, orig_size);
 
 		return freelist;
 	}
@@ -3140,6 +3184,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		if (s->flags & SLAB_STORE_USER)
 			set_track(s, freelist, TRACK_ALLOC, addr);
+		set_orig_size(s, freelist, orig_size);
+
 		return freelist;
 	}
 
@@ -3182,7 +3228,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
  * pointer.
  */
 static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
+			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
 {
 	void *p;
 
@@ -3195,7 +3241,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	c = slub_get_cpu_ptr(s->cpu_slab);
 #endif
 
-	p = ___slab_alloc(s, gfpflags, node, addr, c);
+	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
 #ifdef CONFIG_PREEMPT_COUNT
 	slub_put_cpu_ptr(s->cpu_slab);
 #endif
@@ -3280,7 +3326,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 
 	if (!USE_LOCKLESS_FAST_PATH() ||
 	    unlikely(!object || !slab || !node_match(slab, node))) {
-		object = __slab_alloc(s, gfpflags, node, addr, c);
+		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
 	} else {
 		void *next_object = get_freepointer_safe(s, object);
 
@@ -3747,7 +3793,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 * of re-populating per CPU c->freelist
 			 */
 			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
-					    _RET_IP_, c);
+					    _RET_IP_, c, s->object_size);
 			if (unlikely(!p[i]))
 				goto error;
 
@@ -4150,12 +4196,17 @@ static int calculate_sizes(struct kmem_cache *s)
 	}
 
 #ifdef CONFIG_SLUB_DEBUG
-	if (flags & SLAB_STORE_USER)
+	if (flags & SLAB_STORE_USER) {
 		/*
 		 * Need to store information about allocs and frees after
 		 * the object.
 		 */
 		size += 2 * sizeof(struct track);
+
+		/* Save the original kmalloc request size */
+		if (flags & SLAB_KMALLOC)
+			size += sizeof(unsigned int);
+	}
 #endif
 
 	kasan_cache_create(s, &size, &s->flags);
@@ -4770,7 +4821,7 @@ void __init kmem_cache_init(void)
 
 	/* Now we can use the kmem_cache to allocate kmalloc slabs */
 	setup_kmalloc_cache_index_table();
-	create_kmalloc_caches(0);
+	create_kmalloc_caches(SLAB_KMALLOC);
 
 	/* Setup random freelists for each cache */
 	init_freelist_randomization();
@@ -4937,6 +4988,7 @@ struct location {
 	depot_stack_handle_t handle;
 	unsigned long count;
 	unsigned long addr;
+	unsigned long waste;
 	long long sum_time;
 	long min_time;
 	long max_time;
@@ -4983,13 +5035,15 @@ static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
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
@@ -5007,11 +5061,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
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
@@ -5036,6 +5092,9 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 			end = pos;
 		else if (track->addr == caddr && handle < chandle)
 			end = pos;
+		else if (track->addr == caddr && handle == chandle &&
+				waste < cwaste)
+			end = pos;
 		else
 			start = pos;
 	}
@@ -5059,6 +5118,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 	l->min_pid = track->pid;
 	l->max_pid = track->pid;
 	l->handle = handle;
+	l->waste = waste;
 	cpumask_clear(to_cpumask(l->cpus));
 	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
 	nodes_clear(l->nodes);
@@ -5077,7 +5137,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
 
 	for_each_object(p, s, addr, slab->objects)
 		if (!test_bit(__obj_to_index(s, addr, p), obj_map))
-			add_location(t, s, get_track(s, p, alloc));
+			add_location(t, s, get_track(s, p, alloc), get_orig_size(s, p));
 }
 #endif  /* CONFIG_DEBUG_FS   */
 #endif	/* CONFIG_SLUB_DEBUG */
@@ -5942,6 +6002,10 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
 		else
 			seq_puts(seq, "<not-available>");
 
+		if (l->waste)
+			seq_printf(seq, " waste=%lu/%lu",
+				l->count * l->waste, l->waste);
+
 		if (l->sum_time != l->min_time) {
 			seq_printf(seq, " age=%ld/%llu/%ld",
 				l->min_time, div_u64(l->sum_time, l->count),
-- 
2.34.1

