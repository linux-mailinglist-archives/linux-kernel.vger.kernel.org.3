Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40C25634C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiGAOAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiGAOAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:00:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED5A27B25
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656684013; x=1688220013;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FhViMIHb9UXf1fCnIfkUfjWAO36ZoFbead+Iqeg1OSk=;
  b=AwwnzefGQheZGWGKpDfO2PmzKbKX8NYTonZDoCl+2uphcIfpp1RsXGgE
   P+LYY4NvpuSFRpsJxlsCi64c+dQbN+8NWCijwVc75+JAMF3YDTLQKnPzt
   CPkM/FYj40w4R6TWYxbtj+LsQPh4k9aTCIpsDLvECyb6cr/hgrOeyg4Gf
   8D1ghfGFPVdXs+HhWRd020C0oydbeDL4lxGrkwBSz1CdmpaKCRFP8SvL8
   AaRktzV9TzQXekO5clQTWK0W7nFBpjg79T7bN33rjFxJLdcSinEkZQat+
   CwRaOa7jcCaBBD/RfEf1h0sAqIfskMG7eWpueApEXFMbHuxYHVG36wPvE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="265687291"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="265687291"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 06:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="838052639"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jul 2022 06:59:54 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v1] mm/slub: enable debugging memory wasting of kmalloc
Date:   Fri,  1 Jul 2022 21:59:54 +0800
Message-Id: <20220701135954.45045-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc's API family is critical for mm, with one shortcoming that
its object size is fixed to be power of 2. When user requests memory
for '2^n + 1' bytes, actually 2^(n+1) bytes will be allocated, so
in worst case, there is around 50% memory space waste.

We've met a kernel boot OOM panic (v5.10), and from the dumped slab info:

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
kernel [2], these logs are picked just to demo the problem)

So add an way to track each kmalloc's memory waste info, and leverage
the existing SLUB debug framework to show its call stack info, so
that user can evaluate the waste situation, identify some hot spots
and optimize accordingly, for a better utilization of memory.

The waste info is integrated into existing interface:
/sys/kernel/debug/slab/kmalloc-xx/alloc_traces, one example of
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

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:

  since RFC
    * fix problems in kmem_cache_alloc_bulk() and records sorting,
      improve the print format (Hyeonggon Yoo)
    * fix a compiling issue found by 0Day bot
    * update the commit log based info from iova developers

 mm/slub.c | 52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b1281b8654bd3..97304ea1e6aa5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -271,6 +271,7 @@ struct track {
 #endif
 	int cpu;		/* Was running on cpu */
 	int pid;		/* Pid context */
+	unsigned long waste;	/* memory waste for a kmalloc-ed object */
 	unsigned long when;	/* When did the operation occur */
 };
 
@@ -747,6 +748,7 @@ static inline depot_stack_handle_t set_track_prepare(void)
 
 static void set_track_update(struct kmem_cache *s, void *object,
 			     enum track_item alloc, unsigned long addr,
+			     unsigned long waste,
 			     depot_stack_handle_t handle)
 {
 	struct track *p = get_track(s, object, alloc);
@@ -758,14 +760,16 @@ static void set_track_update(struct kmem_cache *s, void *object,
 	p->cpu = smp_processor_id();
 	p->pid = current->pid;
 	p->when = jiffies;
+	p->waste = waste;
 }
 
 static __always_inline void set_track(struct kmem_cache *s, void *object,
-				      enum track_item alloc, unsigned long addr)
+				      enum track_item alloc, unsigned long addr,
+				      unsigned long waste)
 {
 	depot_stack_handle_t handle = set_track_prepare();
 
-	set_track_update(s, object, alloc, addr, handle);
+	set_track_update(s, object, alloc, addr, waste, handle);
 }
 
 static void init_tracking(struct kmem_cache *s, void *object)
@@ -1325,7 +1329,9 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 
 static noinline int alloc_debug_processing(struct kmem_cache *s,
 					struct slab *slab,
-					void *object, unsigned long addr)
+					void *object, unsigned long addr,
+					unsigned long waste
+					)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!alloc_consistency_checks(s, slab, object))
@@ -1334,7 +1340,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 
 	/* Success perform special debug activities for allocs */
 	if (s->flags & SLAB_STORE_USER)
-		set_track(s, object, TRACK_ALLOC, addr);
+		set_track(s, object, TRACK_ALLOC, addr, waste);
 	trace(s, slab, object, 1);
 	init_object(s, object, SLUB_RED_ACTIVE);
 	return 1;
@@ -1418,7 +1424,7 @@ static noinline int free_debug_processing(
 	}
 
 	if (s->flags & SLAB_STORE_USER)
-		set_track_update(s, object, TRACK_FREE, addr, handle);
+		set_track_update(s, object, TRACK_FREE, addr, 0, handle);
 	trace(s, slab, object, 0);
 	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
 	init_object(s, object, SLUB_RED_INACTIVE);
@@ -1661,7 +1667,8 @@ static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 
 static inline int alloc_debug_processing(struct kmem_cache *s,
-	struct slab *slab, void *object, unsigned long addr) { return 0; }
+	struct slab *slab, void *object, unsigned long addr,
+	unsigned long waste) { return 0; }
 
 static inline int free_debug_processing(
 	struct kmem_cache *s, struct slab *slab,
@@ -2905,7 +2912,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
  * already disabled (which is the case for bulk allocation).
  */
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
+			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
 {
 	void *freelist;
 	struct slab *slab;
@@ -3048,7 +3055,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 check_new_slab:
 
 	if (kmem_cache_debug(s)) {
-		if (!alloc_debug_processing(s, slab, freelist, addr)) {
+		if (!alloc_debug_processing(s, slab, freelist, addr, s->object_size - orig_size)) {
 			/* Slab failed checks. Next slab needed */
 			goto new_slab;
 		} else {
@@ -3102,7 +3109,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
  * pointer.
  */
 static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
+			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
 {
 	void *p;
 
@@ -3115,7 +3122,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	c = slub_get_cpu_ptr(s->cpu_slab);
 #endif
 
-	p = ___slab_alloc(s, gfpflags, node, addr, c);
+	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
 #ifdef CONFIG_PREEMPT_COUNT
 	slub_put_cpu_ptr(s->cpu_slab);
 #endif
@@ -3206,7 +3213,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
 	    unlikely(!object || !slab || !node_match(slab, node))) {
-		object = __slab_alloc(s, gfpflags, node, addr, c);
+		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
 	} else {
 		void *next_object = get_freepointer_safe(s, object);
 
@@ -3731,7 +3738,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 * of re-populating per CPU c->freelist
 			 */
 			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
-					    _RET_IP_, c);
+					    _RET_IP_, c, s->object_size);
 			if (unlikely(!p[i]))
 				goto error;
 
@@ -5092,6 +5099,7 @@ struct location {
 	depot_stack_handle_t handle;
 	unsigned long count;
 	unsigned long addr;
+	unsigned long waste;
 	long long sum_time;
 	long min_time;
 	long max_time;
@@ -5142,7 +5150,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 {
 	long start, end, pos;
 	struct location *l;
-	unsigned long caddr, chandle;
+	unsigned long caddr, chandle, cwaste;
 	unsigned long age = jiffies - track->when;
 	depot_stack_handle_t handle = 0;
 
@@ -5162,11 +5170,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
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
+			(track->waste == cwaste)) {
 
-			l = &t->loc[pos];
 			l->count++;
 			if (track->when) {
 				l->sum_time += age;
@@ -5191,6 +5201,9 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 			end = pos;
 		else if (track->addr == caddr && handle < chandle)
 			end = pos;
+		else if (track->addr == caddr && handle == chandle &&
+				track->waste < cwaste)
+			end = pos;
 		else
 			start = pos;
 	}
@@ -5214,6 +5227,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 	l->min_pid = track->pid;
 	l->max_pid = track->pid;
 	l->handle = handle;
+	l->waste = track->waste;
 	cpumask_clear(to_cpumask(l->cpus));
 	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
 	nodes_clear(l->nodes);
@@ -6102,6 +6116,10 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
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
2.27.0

