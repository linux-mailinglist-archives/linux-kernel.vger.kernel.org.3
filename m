Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D935628D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiGACXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGACXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:23:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB0E33E95
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656642214; x=1688178214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NzvYCUmYC98qq0xLWLj1OrnxdCrEWFmRgn4AJux2ERQ=;
  b=hD0zUpRvDeTl140rR0jvCYehcO1y6Dpnx8vgHA9DJGB7C1CFsW0D/rWb
   B013BzIa+KV+MTezUeGqzokjsJtN7FXrBb/t/dWLZo7hs+rhX0WxULG25
   ubOENnp9OiF5I/5p3PeL2xB8sw4JmXpAqsJl1w40Yif4Wu2t6Djx6BS4G
   wPGKXcjkhi8dh4ClR2bLBZgYUTYO3+7BWBaas7kD5q4TG2DtBFk99iLx6
   QpLiMAK/y6T+6Redp2oyiiRm3vVgfJRfPq/KfLplMT2ySg3p3zibWAcKE
   pj5xz98yDgb92RSfwR3z+ECGHtUcX4zn6s1GZmhSWLJUTA08DWi+y1kcb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="282561497"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="282561497"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 19:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="648150532"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2022 19:23:31 -0700
Date:   Fri, 1 Jul 2022 10:23:30 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: Re: [RFC PATCH] mm/slub: enable debugging memory wasting of kmalloc
Message-ID: <20220701022330.GA14806@shbuild999.sh.intel.com>
References: <20220630014715.73330-1-feng.tang@intel.com>
 <Yr21Ymj5uZfFearE@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr21Ymj5uZfFearE@hyeyoo>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyeonggon,

Thanks for the review!

On Thu, Jun 30, 2022 at 11:38:26PM +0900, Hyeonggon Yoo wrote:
> On Thu, Jun 30, 2022 at 09:47:15AM +0800, Feng Tang wrote:
> > kmalloc's API family is critical for mm, with one shortcoming that
> > its object size is fixed to be power of 2. When user requests memory
> > for '2^n + 1' bytes, actually 2^(n+1) bytes will be allocated, so
> > in worst case, there is around 50% memory space waste.
> > 
> > We've met a kernel boot OOM panic, and from the dumped slab info:
> > 
> >     [   26.062145] kmalloc-2k            814056KB     814056KB
> > 
> > From debug we found there are huge number of 'struct iova_magazine',
> > whose size is 1032 bytes (1024 + 8), so each allocation will waste
> > 1016 bytes. Though the issue is solved by giving the right(bigger)
> > size of RAM, it is still better to optimize the size (either use
> > a kmalloc friendly size or create a dedicated slab for it).
> > 
> > And from lkml archive, there was another crash kernel OOM case [1]
> > back in 2019, which seems to be related with the similar slab waste
> > situation, as the log is similar:
> > 
> >     [    4.332648] iommu: Adding device 0000:20:02.0 to group 16
> >     [    4.338946] swapper/0 invoked oom-killer: gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null), order=0, oom_score_adj=0
> >     ...
> >     [    4.857565] kmalloc-2048           59164KB      59164KB
> > 
> > The crash kernel only has 256M memory, and 59M is pretty big here.
> > 
> > So add an way to track each kmalloc's memory waste info, and leverage
> > the existing SLUB debug framework to show its call stack info, so
> > that user can evaluate the waste situation, identify some hot spots
> > and optimize accordingly, for a better utilization of memory.
> > 
> > The waste info is integrated into existing interface:
> > /sys/kernel/debug/slab/kmalloc-xx/alloc_traces, one example of
> > 'kmalloc-4k' after boot is:
> > 
> > 126 ixgbe_alloc_q_vector+0xa5/0x4a0 [ixgbe] waste: 233856/1856 age=1493302/1493830/1494358 pid=1284 cpus=32 nodes=1
> >         __slab_alloc.isra.86+0x52/0x80
> >         __kmalloc_node+0x143/0x350
> >         ixgbe_alloc_q_vector+0xa5/0x4a0 [ixgbe]
> >         ixgbe_init_interrupt_scheme+0x1a6/0x730 [ixgbe]
> >         ixgbe_probe+0xc8e/0x10d0 [ixgbe]
> >         local_pci_probe+0x42/0x80
> >         work_for_cpu_fn+0x13/0x20
> >         process_one_work+0x1c5/0x390
> >         worker_thread+0x1b9/0x360
> >         kthread+0xe6/0x110
> >         ret_from_fork+0x1f/0x30
> > 
> > which means in 'kmalloc-4k' slab, there are 126 requests of
> > 2240 bytes which got a 4KB space (wasting 1856 bytes each
> > and 233856 bytes in total). And when system starts some real
> > workload like multiple docker instances, there are more
> > severe waste.
> > 
> > [1]. https://lkml.org/lkml/2019/8/12/266
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> > Note:
> >   * this is based on linux-next tree with tag next-20220628
> 
> So this makes use of the fact that orig_size differ from
> s->object_size when allocated from kmalloc, and for non-kmalloc
> caches it doesn't track waste because s->object_size == orig_size.
> Am I following?

Yes, you are right.


> And then it has overhead of 'waste' field for every non-kmalloc objects
> because track is saved per object. Also the field is not used at free.
> (Maybe that would be okay as it's only for debugging, just noting.)
 
Yes, the field itself is a 'waste' for non-kmalloc objects :) I do
have another patch to add an option for this

	+config SLUB_DEBUG_KMALLOC_WASTE
	+	bool "Enable kmalloc memory waste debug"
	+	depends on SLUB_DEBUG && DEBUG_FS
	...	

And didn't post it due to the same debugging thought as you. And I can
add it back if it's really necessary.

> >  mm/slub.c | 45 ++++++++++++++++++++++++++++++---------------
> >  1 file changed, 30 insertions(+), 15 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 26b00951aad1..bc4f9d4fb1e2 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -271,6 +271,7 @@ struct track {
> >  #endif
> >  	int cpu;		/* Was running on cpu */
> >  	int pid;		/* Pid context */
> > +	unsigned long waste;	/* memory waste for a kmalloc-ed object */
> >  	unsigned long when;	/* When did the operation occur */
> >  };
> >  
> > @@ -747,6 +748,7 @@ static inline depot_stack_handle_t set_track_prepare(void)
> >  
> >  static void set_track_update(struct kmem_cache *s, void *object,
> >  			     enum track_item alloc, unsigned long addr,
> > +			     unsigned long waste,
> >  			     depot_stack_handle_t handle)
> >  {
> >  	struct track *p = get_track(s, object, alloc);
> > @@ -758,14 +760,16 @@ static void set_track_update(struct kmem_cache *s, void *object,
> >  	p->cpu = smp_processor_id();
> >  	p->pid = current->pid;
> >  	p->when = jiffies;
> > +	p->waste = waste;
> >  }
> >  
> >  static __always_inline void set_track(struct kmem_cache *s, void *object,
> > -				      enum track_item alloc, unsigned long addr)
> > +				      enum track_item alloc, unsigned long addr,
> > +				      unsigned long waste)
> >  {
> >  	depot_stack_handle_t handle = set_track_prepare();
> >  
> > -	set_track_update(s, object, alloc, addr, handle);
> > +	set_track_update(s, object, alloc, addr, waste, handle);
> >  }
> >  
> >  static void init_tracking(struct kmem_cache *s, void *object)
> > @@ -1325,7 +1329,9 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
> >  
> >  static noinline int alloc_debug_processing(struct kmem_cache *s,
> >  					struct slab *slab,
> > -					void *object, unsigned long addr)
> > +					void *object, unsigned long addr,
> > +					unsigned long waste
> > +					)
> >  {
> >  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> >  		if (!alloc_consistency_checks(s, slab, object))
> > @@ -1334,7 +1340,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
> >  
> >  	/* Success perform special debug activities for allocs */
> >  	if (s->flags & SLAB_STORE_USER)
> > -		set_track(s, object, TRACK_ALLOC, addr);
> > +		set_track(s, object, TRACK_ALLOC, addr, waste);
> >  	trace(s, slab, object, 1);
> >  	init_object(s, object, SLUB_RED_ACTIVE);
> >  	return 1;
> > @@ -1398,6 +1404,7 @@ static noinline int free_debug_processing(
> >  	int ret = 0;
> >  	depot_stack_handle_t handle = 0;
> >  
> > +	/* TODO: feng: we can slab->waste -= track?) or in set_track */
> >  	if (s->flags & SLAB_STORE_USER)
> >  		handle = set_track_prepare();
> >  
> > @@ -1418,7 +1425,7 @@ static noinline int free_debug_processing(
> >  	}
> >  
> >  	if (s->flags & SLAB_STORE_USER)
> > -		set_track_update(s, object, TRACK_FREE, addr, handle);
> > +		set_track_update(s, object, TRACK_FREE, addr, 0, handle);
> >  	trace(s, slab, object, 0);
> >  	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
> >  	init_object(s, object, SLUB_RED_INACTIVE);
> > @@ -2905,7 +2912,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
> >   * already disabled (which is the case for bulk allocation).
> >   */
> >  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > -			  unsigned long addr, struct kmem_cache_cpu *c)
> > +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> >  {
> >  	void *freelist;
> >  	struct slab *slab;
> > @@ -3048,7 +3055,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  check_new_slab:
> >  
> >  	if (kmem_cache_debug(s)) {
> > -		if (!alloc_debug_processing(s, slab, freelist, addr)) {
> > +		if (!alloc_debug_processing(s, slab, freelist, addr, s->object_size - orig_size)) {
> >  			/* Slab failed checks. Next slab needed */
> >  			goto new_slab;
> >  		} else {
> > @@ -3102,7 +3109,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >   * pointer.
> >   */
> >  static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > -			  unsigned long addr, struct kmem_cache_cpu *c)
> > +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> >  {
> >  	void *p;
> >  
> > @@ -3115,7 +3122,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  	c = slub_get_cpu_ptr(s->cpu_slab);
> >  #endif
> >  
> > -	p = ___slab_alloc(s, gfpflags, node, addr, c);
> > +	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
> >  #ifdef CONFIG_PREEMPT_COUNT
> >  	slub_put_cpu_ptr(s->cpu_slab);
> >  #endif
> > @@ -3206,7 +3213,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
> >  	 */
> >  	if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
> >  	    unlikely(!object || !slab || !node_match(slab, node))) {
> > -		object = __slab_alloc(s, gfpflags, node, addr, c);
> > +		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
> >  	} else {
> >  		void *next_object = get_freepointer_safe(s, object);
> >  
> > @@ -3709,7 +3716,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
> >  			 * of re-populating per CPU c->freelist
> >  			 */
> >  			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
> > -					    _RET_IP_, c);
> > +					    _RET_IP_, c, size);
> 
> This looks wrong. size here is size of array.
> Maybe just s->object_size instead of size?
 
Good catch! should be s->object_size. thanks!

> >  			if (unlikely(!p[i]))
> >  				goto error;
> >  
> > @@ -5068,6 +5075,7 @@ struct location {
> >  	depot_stack_handle_t handle;
> >  	unsigned long count;
> >  	unsigned long addr;
> > +	unsigned long waste;
> >  	long long sum_time;
> >  	long min_time;
> >  	long max_time;
> > @@ -5138,11 +5146,12 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
> >  		if (pos == end)
> >  			break;
> >  
> > -		caddr = t->loc[pos].addr;
> > -		chandle = t->loc[pos].handle;
> > -		if ((track->addr == caddr) && (handle == chandle)) {
> > +		l = &t->loc[pos];
> > +		caddr = l->addr;
> > +		chandle = l->handle;
> > +		if ((track->addr == caddr) && (handle == chandle) &&
> > +			(track->waste == l->waste)) {
> >  
> > -			l = &t->loc[pos];
> >  			l->count++;
> >  			if (track->when) {
> >  				l->sum_time += age;
> > @@ -5190,6 +5199,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
> >  	l->min_pid = track->pid;
> >  	l->max_pid = track->pid;
> >  	l->handle = handle;
> > +	l->waste = track->waste;
> 
> I think this may be fooled when there are different wastes values
> from same caller (i.e. when a kmalloc_track_caller() is used.)

Yes, with the patch, we found quite some cases that the same caller
requests different sizes.

> because the array is sorted by caller address, but not sorted by waste.

In the patch we have in add_location():

+		if ((track->addr == caddr) && (handle == chandle) &&
+			(track->waste == l->waste)) {

Do you mean the following is missed? 

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5176,6 +5176,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 			end = pos;
 		else if (track->addr == caddr && handle < chandle)
 			end = pos;
+		else if (track->addr == caddr && handle == chandle && track->waste < l->waste)
+			end = pos;
 		else
 			start = pos;

> And writing this I noticed that it already can be fooled now :)
> It's also not sorted by handle.
> 
> >  	cpumask_clear(to_cpumask(l->cpus));
> >  	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
> >  	nodes_clear(l->nodes);
> > @@ -6078,6 +6088,11 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
> >  		else
> >  			seq_puts(seq, "<not-available>");
> >  
> > +
> > +		if (l->waste)
> > +			seq_printf(seq, " waste: %lu/%lu",
> 
> Maybe waste=%lu/%lu like others?

Sure, will follow current style.

Thanks,
Feng
