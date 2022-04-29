Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE0514522
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356326AbiD2JQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356324AbiD2JQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:16:47 -0400
Received: from outbound-smtp40.blacknight.com (outbound-smtp40.blacknight.com [46.22.139.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F056F491
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:13:26 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id 3EEEA1C3ED0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:13:24 +0100 (IST)
Received: (qmail 15734 invoked from network); 29 Apr 2022 09:13:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Apr 2022 09:13:23 -0000
Date:   Fri, 29 Apr 2022 10:13:21 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Protect PCP lists with a spinlock
Message-ID: <20220429091321.GB3441@techsingularity.net>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
 <20220420095906.27349-6-mgorman@techsingularity.net>
 <0d6bf5a97777bec1e0b425f2fb33dbb80d848621.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <0d6bf5a97777bec1e0b425f2fb33dbb80d848621.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:42:43PM +0200, Nicolas Saenz Julienne wrote:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index dc0fdeb3795c..813c84b67c65 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -132,6 +132,17 @@ static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused = {
> >  	.lock = INIT_LOCAL_LOCK(lock),
> >  };
> >  
> > +#ifdef CONFIG_SMP
> > +/* On SMP, spin_trylock is sufficient protection */
> > +#define pcp_trylock_prepare(flags)	do { } while (0)
> > +#define pcp_trylock_finish(flag)	do { } while (0)
> > +#else
> > +
> > +/* UP spin_trylock always succeeds so disable IRQs to prevent re-entrancy. */
> 
> This is only needed on non-RT kernels. RT UP builds go through
> rt_spin_trylock(), which behaves like its SMP counterpart.
> 

I missed that.

> > +#define pcp_trylock_prepare(flags)	local_irq_save(flags)
> > +#define pcp_trylock_finish(flags)	local_irq_restore(flags)
> > +#endif
> > +
> >  #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
> >  DEFINE_PER_CPU(int, numa_node);
> >  EXPORT_PER_CPU_SYMBOL(numa_node);
> > @@ -3082,15 +3093,22 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
> >   */
> >  void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
> >  {
> > -	unsigned long flags;
> >  	int to_drain, batch;
> >  
> > -	local_lock_irqsave(&pagesets.lock, flags);
> >  	batch = READ_ONCE(pcp->batch);
> >  	to_drain = min(pcp->count, batch);
> > -	if (to_drain > 0)
> > +	if (to_drain > 0) {
> > +		unsigned long flags;
> > +
> > +		/* free_pcppages_bulk expects IRQs disabled for zone->lock */
> > +		local_irq_save(flags);
> 
> Why dropping the local_lock? That approach is nicer to RT builds, and I don't
> think it makes a difference from a non-RT perspective.
> 

The local_lock was dropped because local_lock stabilises the lookup of
pcp but in this context, we are looking at a remote pcp and local_lock
does not protect the pcp reference. It confuses what local_lock is
protecting exactly.

> That said, IIUC, this will eventually disappear with subsequent patches, right?
> 

It would have but this patch as also wrong as pointed out by Vlastimil.
So even if it was eventually correct, it would not be safe to add this
patch as-is and spin_lock_irqsave is required.

> > +
> > +		spin_lock(&pcp->lock);
> >  		free_pcppages_bulk(zone, to_drain, pcp, 0);
> > -	local_unlock_irqrestore(&pagesets.lock, flags);
> > +		spin_unlock(&pcp->lock);
> > +
> > +		local_irq_restore(flags);
> > +	}
> >  }
> >  #endif
> >  
> 
> [...]
> 
> > @@ -3668,9 +3748,30 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
> >  			int migratetype,
> >  			unsigned int alloc_flags,
> >  			struct per_cpu_pages *pcp,
> > -			struct list_head *list)
> > +			struct list_head *list,
> > +			bool locked)
> >  {
> >  	struct page *page;
> > +	unsigned long __maybe_unused UP_flags;
> > +
> > +	/*
> > +	 * spin_trylock is not necessary right now due to due to
> > +	 * local_lock_irqsave and is a preparation step for
> > +	 * a conversion to local_lock using the trylock to prevent
> > +	 * IRQ re-entrancy. If pcp->lock cannot be acquired, the caller
> > +	 * uses rmqueue_buddy.
> > +	 *
> > +	 * TODO: Convert local_lock_irqsave to local_lock. Care
> > +	 * 	 is needed as the type of local_lock would need a
> > +	 * 	 PREEMPT_RT version due to threaded IRQs.
> > +	 */
> 
> I missed this in our previous conversation, but as far as RT is concerned
> local_lock_irqsave() is the same as local_lock(), see in local_lock_internal.h:
> 
> #define __local_lock_irqsave(lock, flags)			\
> 	do {							\
> 		typecheck(unsigned long, flags);		\
> 		flags = 0;					\
> 		__local_lock(lock);				\
> 	} while (0)
> 
> Something similar happens with spin_lock_irqsave(), see in spinlock_rt.h:
> 
> #define spin_lock_irqsave(lock, flags)			 \
> 	do {						 \
> 		typecheck(unsigned long, flags);	 \
> 		flags = 0;				 \
> 		spin_lock(lock);			 \
> 	} while (0)
> 
> IIUC, RT will run this code paths in threaded IRQ context, where we can think
> of RT spinlocks as mutexes (plus some extra priority inheritance magic).
> 

Ah, thanks for the explanation.

Based on your feedback, Vlastimil's and Minchan's, the current delta
between this series and what I'm preparing for testing is

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 17d11eb0413e..4ac39d30ec8f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -132,8 +132,11 @@ static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused = {
 	.lock = INIT_LOCAL_LOCK(lock),
 };
 
-#ifdef CONFIG_SMP
-/* On SMP, spin_trylock is sufficient protection */
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
+/*
+ * On SMP, spin_trylock is sufficient protection.
+ * On PREEMPT_RT, spin_trylock is equivalent on both SMP and UP.
+ */
 #define pcp_trylock_prepare(flags)	do { } while (0)
 #define pcp_trylock_finish(flag)	do { } while (0)
 #else
@@ -3091,14 +3094,14 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 	if (to_drain > 0) {
 		unsigned long flags;
 
-		/* free_pcppages_bulk expects IRQs disabled for zone->lock */
-		local_irq_save(flags);
-
-		spin_lock(&pcp->lock);
+		/*
+		 * free_pcppages_bulk expects IRQs disabled for zone->lock
+		 * so even though pcp->lock is not intended to be IRQ-safe,
+		 * it's needed in this context.
+		 */
+		spin_lock_irqsave(&pcp->lock, flags);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
-		spin_unlock(&pcp->lock);
-
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&pcp->lock, flags);
 	}
 }
 #endif
@@ -3114,14 +3117,10 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 	if (pcp->count) {
 		unsigned long flags;
 
-		/* free_pcppages_bulk expects IRQs disabled for zone->lock */
-		local_irq_save(flags);
-
-		spin_lock(&pcp->lock);
+		/* See drain_zone_pages on why this is disabling IRQs */
+		spin_lock_irqsave(&pcp->lock, flags);
 		free_pcppages_bulk(zone, pcp->count, pcp, 0);
-		spin_unlock(&pcp->lock);
-
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&pcp->lock, flags);
 	}
 }
 
@@ -3480,6 +3479,13 @@ void free_unref_page_list(struct list_head *list)
 		}
 	}
 
+	/*
+	 * Preparation could have drained the list due to failing to prepare
+	 * or all pages are being isolated.
+	 */
+	if (list_empty(list))
+		return;
+
 	VM_BUG_ON(in_hardirq());
 
 	local_lock_irqsave(&pagesets.lock, flags);
@@ -3515,6 +3521,9 @@ void free_unref_page_list(struct list_head *list)
 		 * allocator directly. This is expensive as the zone lock will
 		 * be acquired multiple times but if a drain is in progress
 		 * then an expensive operation is already taking place.
+		 *
+		 * TODO: Always false at the moment due to local_lock_irqsave
+		 *       and is preparation for converting to local_lock.
 		 */
 		if (unlikely(!free_unref_page_commit(page, migratetype, 0, true)))
 			free_one_page(page_zone(page), page, page_to_pfn(page), 0, migratetype, FPI_NONE);
@@ -3717,9 +3726,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 	 * IRQ re-entrancy. If pcp->lock cannot be acquired, the caller
 	 * uses rmqueue_buddy.
 	 *
-	 * TODO: Convert local_lock_irqsave to local_lock. Care
-	 * 	 is needed as the type of local_lock would need a
-	 * 	 PREEMPT_RT version due to threaded IRQs.
+	 * TODO: Convert local_lock_irqsave to local_lock.
 	 */
 	if (unlikely(!locked)) {
 		pcp_trylock_prepare(UP_flags);

-- 
Mel Gorman
SUSE Labs
