Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65D3564D77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 07:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiGDF4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 01:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGDF4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 01:56:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEAC65AC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 22:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656914165; x=1688450165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7y3Cx5M8UyugyctgSE5CWaH4csKIe5LDHhkFe+VUCoc=;
  b=jO9ZIShnpmW86YdrP44lPuw7tlaKlVAGVticjuq7reWNZt4VFKeWitq7
   UhNIsr90PWRLlsUOarCmQNMP+fW3vaMMKDyI0dNFco0pORh4AfdmU4JS7
   io+9y3n8EpSJoVp9LeKRzzINIrCdOChiO7qWASkuQ9DMfOW2iFg792Fqh
   DYAa3ybynprYlaWH0ga0T4mrsh/ImryM6Pzv/IujX2f50lKWRqIiea8nh
   G/MO/CtsuCFyptRnzW2kC6NT31WZpz80mfOCOiF5tRz9CSAPKm0snyxZQ
   Vutg+ogCz5XU7sYDyVKbrzFwhGikayepBVqj5LY55un8bmqLp8qcsud5q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="281800942"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="281800942"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 22:56:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="624932903"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga001.jf.intel.com with ESMTP; 03 Jul 2022 22:56:00 -0700
Date:   Mon, 4 Jul 2022 13:56:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@gentwo.de>
Cc:     Christoph Lameter <cl@gentwo.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v1] mm/slub: enable debugging memory wasting of kmalloc
Message-ID: <20220704055600.GD62281@shbuild999.sh.intel.com>
References: <20220701135954.45045-1-feng.tang@intel.com>
 <alpine.DEB.2.22.394.2207011635040.588600@gentwo.de>
 <20220701150451.GA62281@shbuild999.sh.intel.com>
 <YsGlAYujuJSTBLLf@ip-172-31-24-42.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsGlAYujuJSTBLLf@ip-172-31-24-42.ap-northeast-1.compute.internal>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 02:17:37PM +0000, Hyeonggon Yoo wrote:
> On Fri, Jul 01, 2022 at 11:04:51PM +0800, Feng Tang wrote:
> > Hi Christoph,
> > 
> > On Fri, Jul 01, 2022 at 04:37:00PM +0200, Christoph Lameter wrote:
> > > On Fri, 1 Jul 2022, Feng Tang wrote:
> > > 
> > > >  static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > > > -			  unsigned long addr, struct kmem_cache_cpu *c)
> > > > +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> > > >  {
> > > 
> > > It would be good to avoid expanding the basic slab handling functions for
> > > kmalloc. Can we restrict the mods to the kmalloc related functions?
> > 
> > Yes, this is the part that concerned me. I tried but haven't figured
> > a way.
> > 
> > I started implemting it several month ago, and stuck with several
> > kmalloc APIs in a hacky way like dump_stack() when there is a waste
> > over 1/4 of the object_size of the kmalloc_caches[][].
> > 
> > Then I found one central API which has all the needed info (object_size &
> > orig_size) that we can yell about the waste :
> > 
> > static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
> >                 gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
> > 
> > which I thought could be still hacky, as the existing 'alloc_traces'
> > can't be resued which already has the count/call-stack info. Current
> > solution leverage it at the cost of adding 'orig_size' parameters, but
> > I don't know how to pass the 'waste' info through as track/location is
> > in the lowest level.
> 
> If adding cost of orig_size parameter for non-debugging case is concern,
> what about doing this in userspace script that makes use of kmalloc
> tracepoints?
> 
> 	kmalloc: call_site=tty_buffer_alloc+0x43/0x90 ptr=00000000b78761e1
> 	bytes_req=1056 bytes_alloc=2048 gfp_flags=GFP_ATOMIC|__GFP_NOWARN
> 	accounted=false
> 
> calculating sum of (bytes_alloc - bytes_req) for each call_site
> may be an alternative solution.

Yes, this is doable, and it will met some of the problems I met before,
one is there are currently 2 alloc path: kmalloc and kmalloc_node, also
we need to consider the free problem to calculate the real waste, and
the free trace point doesn't have size info (Yes, we could compare
the pointer with alloc path, and the user script may need to be more
complexer). That's why I love the current 'alloc_traces' interface,
which has the count (slove the free counting problem) and full call
stack info.

And for the extra parameter cost issue, I rethink about it, and we
can leverage the 'slab_alloc_node()' to solve it, and the patch is 
much simpler now without adding a new parameter:

---
diff --git a/mm/slub.c b/mm/slub.c
index b1281b8654bd3..ce4568dbb0f2d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -271,6 +271,7 @@ struct track {
 #endif
 	int cpu;		/* Was running on cpu */
 	int pid;		/* Pid context */
+	unsigned long waste;	/* memory waste for a kmalloc-ed object */
 	unsigned long when;	/* When did the operation occur */
 };
 
@@ -3240,6 +3241,16 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 	init = slab_want_init_on_alloc(gfpflags, s);
 
 out:
+
+#ifdef CONFIG_SLUB_DEBUG
+	if (object && s->object_size != orig_size) {
+		struct track *track;
+
+		track = get_track(s, object, TRACK_ALLOC);
+		track->waste = s->object_size - orig_size;
+	}
+#endif
+
 	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
 
 	return object;
@@ -5092,6 +5103,7 @@ struct location {
 	depot_stack_handle_t handle;
 	unsigned long count;
 	unsigned long addr;
+	unsigned long waste;
 	long long sum_time;
 	long min_time;
 	long max_time;
@@ -5142,7 +5154,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 {
 	long start, end, pos;
 	struct location *l;
-	unsigned long caddr, chandle;
+	unsigned long caddr, chandle, cwaste;
 	unsigned long age = jiffies - track->when;
 	depot_stack_handle_t handle = 0;
 
@@ -5162,11 +5174,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
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
@@ -5191,6 +5205,9 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 			end = pos;
 		else if (track->addr == caddr && handle < chandle)
 			end = pos;
+		else if (track->addr == caddr && handle == chandle &&
+				track->waste < cwaste)
+			end = pos;
 		else
 			start = pos;
 	}
@@ -5214,6 +5231,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 	l->min_pid = track->pid;
 	l->max_pid = track->pid;
 	l->handle = handle;
+	l->waste = track->waste;
 	cpumask_clear(to_cpumask(l->cpus));
 	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
 	nodes_clear(l->nodes);
@@ -6102,6 +6120,10 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
 		else
 			seq_puts(seq, "<not-available>");
 
+		if (l->waste)
+			seq_printf(seq, " waste=%lu/%lu",
+				l->count * l->waste, l->waste);
+
 		if (l->sum_time != l->min_time) {
 			seq_printf(seq, " age=%ld/%llu/%ld",
 				l->min_time, div_u64(l->sum_time, l->count),

Thanks,
Feng

> Thanks,
> Hyeonggon
> 
> > Thanks,
> > Feng
> > 
> > 
> > 
