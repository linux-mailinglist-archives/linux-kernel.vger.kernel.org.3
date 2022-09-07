Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76BC5AFD25
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiIGHLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiIGHKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:10:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8934D760DC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662534653; x=1694070653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=44FkICj2Q2hF/44sbvgWE3hfzh2B6Ni+ClwxuXKV8io=;
  b=Sg1u/UkD2SdIPldczTGP9I3lp6Q8UR/un3Nr7IySj4ZbYQNexCtTQ3pT
   XNksOOFFJ36dH2foT7TaxEYGtkar6g6ejJkdupaox/A+yh+XsfmkzML4E
   JpF0wrl0POQ/V9idfFOK/xCg1fpx8CrW4XL9FB5j6NCPyOe39ucjUloWL
   fY39AXKE633djMkwZHosTMdD4jPHab4opdGPjC/NAj4BgnwIbqFF6ORfw
   1UCnNDTAFA3rT5f06FWPO2GZXPud/LlKInKJe+3JWJnpGaq3Tofb6s979
   6KuUMqwy8VDwPfuk2zc5evH3FLHMovTww3KtT7EeWrUqbtAURdS/DFjJH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="298115275"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="298115275"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 00:10:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676053379"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2022 00:10:49 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Feng Tang <feng.tang@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 1/4] mm/slub: enable debugging memory wasting of kmalloc
Date:   Wed,  7 Sep 2022 15:10:20 +0800
Message-Id: <20220907071023.3838692-2-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907071023.3838692-1-feng.tang@intel.com>
References: <20220907071023.3838692-1-feng.tang@intel.com>
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

 126 ixgbe_alloc_q_vector+0xbe/0x830 [ixgbe] waste=233856/1856 age=280763/281414/282065 pid=1330 cpus=32 nodes=1
     __kmem_cache_alloc_node+0x11f/0x4e0
     __kmalloc_node+0x4e/0x140
     ixgbe_alloc_q_vector+0xbe/0x830 [ixgbe]
     ixgbe_init_interrupt_scheme+0x2ae/0xc90 [ixgbe]
     ixgbe_probe+0x165f/0x1d20 [ixgbe]
     local_pci_probe+0x78/0xc0
     work_for_cpu_fn+0x26/0x40
     ...

which means in 'kmalloc-4k' slab, there are 126 requests of
2240 bytes which got a 4KB space (wasting 1856 bytes each
and 233856 bytes in total), from ixgbe_alloc_q_vector().

And when system starts some real workload like multiple docker
instances, there could are more severe waste.

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
 Documentation/mm/slub.rst |  33 +++++---
 include/linux/slab.h      |   2 +
 mm/slub.c                 | 156 ++++++++++++++++++++++++++++----------
 3 files changed, 141 insertions(+), 50 deletions(-)

diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
index 43063ade737a..4e1578186b4f 100644
--- a/Documentation/mm/slub.rst
+++ b/Documentation/mm/slub.rst
@@ -400,21 +400,30 @@ information:
     allocated objects. The output is sorted by frequency of each trace.
 
     Information in the output:
-    Number of objects, allocating function, minimal/average/maximal jiffies since alloc,
-    pid range of the allocating processes, cpu mask of allocating cpus, and stack trace.
+    Number of objects, allocating function, possible memory wastage of
+    kmalloc objects(total/per-object), minimal/average/maximal jiffies
+    since alloc, pid range of the allocating processes, cpu mask of
+    allocating cpus, numa node mask of origins of memory, and stack trace.
 
     Example:::
 
-    1085 populate_error_injection_list+0x97/0x110 age=166678/166680/166682 pid=1 cpus=1::
-	__slab_alloc+0x6d/0x90
-	kmem_cache_alloc_trace+0x2eb/0x300
-	populate_error_injection_list+0x97/0x110
-	init_error_injection+0x1b/0x71
-	do_one_initcall+0x5f/0x2d0
-	kernel_init_freeable+0x26f/0x2d7
-	kernel_init+0xe/0x118
-	ret_from_fork+0x22/0x30
-
+    338 pci_alloc_dev+0x2c/0xa0 waste=521872/1544 age=290837/291891/293509 pid=1 cpus=106 nodes=0-1
+        __kmem_cache_alloc_node+0x11f/0x4e0
+        kmalloc_trace+0x26/0xa0
+        pci_alloc_dev+0x2c/0xa0
+        pci_scan_single_device+0xd2/0x150
+        pci_scan_slot+0xf7/0x2d0
+        pci_scan_child_bus_extend+0x4e/0x360
+        acpi_pci_root_create+0x32e/0x3b0
+        pci_acpi_scan_root+0x2b9/0x2d0
+        acpi_pci_root_add.cold.11+0x110/0xb0a
+        acpi_bus_attach+0x262/0x3f0
+        device_for_each_child+0xb7/0x110
+        acpi_dev_for_each_child+0x77/0xa0
+        acpi_bus_attach+0x108/0x3f0
+        device_for_each_child+0xb7/0x110
+        acpi_dev_for_each_child+0x77/0xa0
+        acpi_bus_attach+0x108/0x3f0
 
 2. free_traces::
 
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
index fe4fe0e72daf..effd994438e6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -194,11 +194,24 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
 #endif		/* CONFIG_SLUB_DEBUG */
 
+/* Structure holding parameters for get_partial() call chain */
+struct partial_context {
+	struct slab **slab;
+	gfp_t flags;
+	int orig_size;
+};
+
 static inline bool kmem_cache_debug(struct kmem_cache *s)
 {
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
@@ -785,6 +798,39 @@ static void print_slab_info(const struct slab *slab)
 	       folio_flags(folio, 0));
 }
 
+/*
+ * kmalloc caches has fixed sizes (mostly power of 2), and kmalloc() API
+ * family will round up the real request size to these fixed ones, so
+ * there could be an extra area than what is requested. Save the original
+ * request size in the meta data area, for better debug and sanity check.
+ */
+static inline void set_orig_size(struct kmem_cache *s,
+				void *object, unsigned int orig_size)
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
@@ -844,6 +890,9 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 	if (s->flags & SLAB_STORE_USER)
 		off += 2 * sizeof(struct track);
 
+	if (slub_debug_orig_size(s))
+		off += sizeof(unsigned int);
+
 	off += kasan_metadata_size(s);
 
 	if (off != size_from_object(s))
@@ -977,7 +1026,8 @@ static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
  *
  * 	A. Free pointer (if we cannot overwrite object on free)
  * 	B. Tracking data for SLAB_STORE_USER
- *	C. Padding to reach required alignment boundary or at minimum
+ *	C. Original request size for kmalloc object (SLAB_STORE_USER enabled)
+ *	D. Padding to reach required alignment boundary or at minimum
  * 		one word if debugging is on to be able to detect writes
  * 		before the word boundary.
  *
@@ -995,10 +1045,14 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
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
@@ -1293,7 +1347,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 }
 
 static noinline int alloc_debug_processing(struct kmem_cache *s,
-					struct slab *slab, void *object)
+			struct slab *slab, void *object, int orig_size)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!alloc_consistency_checks(s, slab, object))
@@ -1302,6 +1356,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 
 	/* Success. Perform special debug activities for allocs */
 	trace(s, slab, object, 1);
+	set_orig_size(s, object, orig_size);
 	init_object(s, object, SLUB_RED_ACTIVE);
 	return 1;
 
@@ -1570,7 +1625,10 @@ static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 
 static inline int alloc_debug_processing(struct kmem_cache *s,
-	struct slab *slab, void *object) { return 0; }
+	struct slab *slab, void *object, int orig_size) { return 0; }
+
+static inline void set_orig_size(struct kmem_cache *s,
+	void *object, unsigned int orig_size) {}
 
 static inline void free_debug_processing(
 	struct kmem_cache *s, struct slab *slab,
@@ -1999,7 +2057,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
  * it to full list if it was the last free object.
  */
 static void *alloc_single_from_partial(struct kmem_cache *s,
-		struct kmem_cache_node *n, struct slab *slab)
+		struct kmem_cache_node *n, struct slab *slab, int orig_size)
 {
 	void *object;
 
@@ -2009,7 +2067,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 	slab->freelist = get_freepointer(s, object);
 	slab->inuse++;
 
-	if (!alloc_debug_processing(s, slab, object)) {
+	if (!alloc_debug_processing(s, slab, object, orig_size)) {
 		remove_partial(n, slab);
 		return NULL;
 	}
@@ -2028,7 +2086,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
  * and put the slab to the partial (or full) list.
  */
 static void *alloc_single_from_new_slab(struct kmem_cache *s,
-					struct slab *slab)
+					struct slab *slab, int orig_size)
 {
 	int nid = slab_nid(slab);
 	struct kmem_cache_node *n = get_node(s, nid);
@@ -2040,7 +2098,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
 	slab->freelist = get_freepointer(s, object);
 	slab->inuse = 1;
 
-	if (!alloc_debug_processing(s, slab, object))
+	if (!alloc_debug_processing(s, slab, object, orig_size))
 		/*
 		 * It's not really expected that this would fail on a
 		 * freshly allocated slab, but a concurrent memory
@@ -2118,7 +2176,7 @@ static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
  * Try to allocate a partial slab from a specific node.
  */
 static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
-			      struct slab **ret_slab, gfp_t gfpflags)
+			      struct partial_context *pc)
 {
 	struct slab *slab, *slab2;
 	void *object = NULL;
@@ -2138,11 +2196,12 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
 		void *t;
 
-		if (!pfmemalloc_match(slab, gfpflags))
+		if (!pfmemalloc_match(slab, pc->flags))
 			continue;
 
 		if (kmem_cache_debug(s)) {
-			object = alloc_single_from_partial(s, n, slab);
+			object = alloc_single_from_partial(s, n, slab,
+							pc->orig_size);
 			if (object)
 				break;
 			continue;
@@ -2153,7 +2212,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 			break;
 
 		if (!object) {
-			*ret_slab = slab;
+			*pc->slab = slab;
 			stat(s, ALLOC_FROM_PARTIAL);
 			object = t;
 		} else {
@@ -2177,14 +2236,13 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 /*
  * Get a slab from somewhere. Search in increasing NUMA distances.
  */
-static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
-			     struct slab **ret_slab)
+static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
 {
 #ifdef CONFIG_NUMA
 	struct zonelist *zonelist;
 	struct zoneref *z;
 	struct zone *zone;
-	enum zone_type highest_zoneidx = gfp_zone(flags);
+	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
 	void *object;
 	unsigned int cpuset_mems_cookie;
 
@@ -2212,15 +2270,15 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 
 	do {
 		cpuset_mems_cookie = read_mems_allowed_begin();
-		zonelist = node_zonelist(mempolicy_slab_node(), flags);
+		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
 		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
 			struct kmem_cache_node *n;
 
 			n = get_node(s, zone_to_nid(zone));
 
-			if (n && cpuset_zone_allowed(zone, flags) &&
+			if (n && cpuset_zone_allowed(zone, pc->flags) &&
 					n->nr_partial > s->min_partial) {
-				object = get_partial_node(s, n, ret_slab, flags);
+				object = get_partial_node(s, n, pc);
 				if (object) {
 					/*
 					 * Don't check read_mems_allowed_retry()
@@ -2241,8 +2299,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 /*
  * Get a partial slab, lock it and return it.
  */
-static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
-			 struct slab **ret_slab)
+static void *get_partial(struct kmem_cache *s, int node, struct partial_context *pc)
 {
 	void *object;
 	int searchnode = node;
@@ -2250,11 +2307,11 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
 	if (node == NUMA_NO_NODE)
 		searchnode = numa_mem_id();
 
-	object = get_partial_node(s, get_node(s, searchnode), ret_slab, flags);
+	object = get_partial_node(s, get_node(s, searchnode), pc);
 	if (object || node != NUMA_NO_NODE)
 		return object;
 
-	return get_any_partial(s, flags, ret_slab);
+	return get_any_partial(s, pc);
 }
 
 #ifdef CONFIG_PREEMPTION
@@ -2974,11 +3031,12 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
  * already disabled (which is the case for bulk allocation).
  */
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
+			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
 {
 	void *freelist;
 	struct slab *slab;
 	unsigned long flags;
+	struct partial_context pc;
 
 	stat(s, ALLOC_SLOWPATH);
 
@@ -3092,7 +3150,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 new_objects:
 
-	freelist = get_partial(s, gfpflags, node, &slab);
+	pc.flags = gfpflags;
+	pc.slab = &slab;
+	pc.orig_size = orig_size;
+	freelist = get_partial(s, node, &pc);
 	if (freelist)
 		goto check_new_slab;
 
@@ -3108,7 +3169,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	stat(s, ALLOC_SLAB);
 
 	if (kmem_cache_debug(s)) {
-		freelist = alloc_single_from_new_slab(s, slab);
+		freelist = alloc_single_from_new_slab(s, slab, orig_size);
 
 		if (unlikely(!freelist))
 			goto new_objects;
@@ -3140,6 +3201,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		if (s->flags & SLAB_STORE_USER)
 			set_track(s, freelist, TRACK_ALLOC, addr);
+
 		return freelist;
 	}
 
@@ -3182,7 +3244,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
  * pointer.
  */
 static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
+			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
 {
 	void *p;
 
@@ -3195,7 +3257,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	c = slub_get_cpu_ptr(s->cpu_slab);
 #endif
 
-	p = ___slab_alloc(s, gfpflags, node, addr, c);
+	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
 #ifdef CONFIG_PREEMPT_COUNT
 	slub_put_cpu_ptr(s->cpu_slab);
 #endif
@@ -3280,7 +3342,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 
 	if (!USE_LOCKLESS_FAST_PATH() ||
 	    unlikely(!object || !slab || !node_match(slab, node))) {
-		object = __slab_alloc(s, gfpflags, node, addr, c);
+		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
 	} else {
 		void *next_object = get_freepointer_safe(s, object);
 
@@ -3747,7 +3809,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 * of re-populating per CPU c->freelist
 			 */
 			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
-					    _RET_IP_, c);
+					    _RET_IP_, c, s->object_size);
 			if (unlikely(!p[i]))
 				goto error;
 
@@ -4150,12 +4212,17 @@ static int calculate_sizes(struct kmem_cache *s)
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
@@ -4770,7 +4837,7 @@ void __init kmem_cache_init(void)
 
 	/* Now we can use the kmem_cache to allocate kmalloc slabs */
 	setup_kmalloc_cache_index_table();
-	create_kmalloc_caches(0);
+	create_kmalloc_caches(SLAB_KMALLOC);
 
 	/* Setup random freelists for each cache */
 	init_freelist_randomization();
@@ -4937,6 +5004,7 @@ struct location {
 	depot_stack_handle_t handle;
 	unsigned long count;
 	unsigned long addr;
+	unsigned long waste;
 	long long sum_time;
 	long min_time;
 	long max_time;
@@ -4983,13 +5051,15 @@ static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
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
@@ -5007,11 +5077,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
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
@@ -5036,6 +5108,9 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 			end = pos;
 		else if (track->addr == caddr && handle < chandle)
 			end = pos;
+		else if (track->addr == caddr && handle == chandle &&
+				waste < cwaste)
+			end = pos;
 		else
 			start = pos;
 	}
@@ -5059,6 +5134,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 	l->min_pid = track->pid;
 	l->max_pid = track->pid;
 	l->handle = handle;
+	l->waste = waste;
 	cpumask_clear(to_cpumask(l->cpus));
 	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
 	nodes_clear(l->nodes);
@@ -5077,7 +5153,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
 
 	for_each_object(p, s, addr, slab->objects)
 		if (!test_bit(__obj_to_index(s, addr, p), obj_map))
-			add_location(t, s, get_track(s, p, alloc));
+			add_location(t, s, get_track(s, p, alloc), get_orig_size(s, p));
 }
 #endif  /* CONFIG_DEBUG_FS   */
 #endif	/* CONFIG_SLUB_DEBUG */
@@ -5942,6 +6018,10 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
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

