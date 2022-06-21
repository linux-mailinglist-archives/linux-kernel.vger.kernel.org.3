Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B612552E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348701AbiFUJ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347928AbiFUJ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:26:38 -0400
Received: from outbound-smtp51.blacknight.com (outbound-smtp51.blacknight.com [46.22.136.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BC9240A0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:26:36 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp51.blacknight.com (Postfix) with ESMTPS id 53301FAF59
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:26:35 +0100 (IST)
Received: (qmail 8435 invoked from network); 21 Jun 2022 09:26:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Jun 2022 09:26:35 -0000
Date:   Tue, 21 Jun 2022 10:26:33 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
Message-ID: <20220621092633.GD15453@techsingularity.net>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
 <20220613125622.18628-8-mgorman@techsingularity.net>
 <43033655-2e78-621b-cc76-c3dc53024d00@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <43033655-2e78-621b-cc76-c3dc53024d00@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 07:01:53PM +0200, Vlastimil Babka wrote:
> On 6/13/22 14:56, Mel Gorman wrote:
> > struct per_cpu_pages is no longer strictly local as PCP lists can be
> > drained remotely using a lock for protection. While the use of local_lock
> > works, it goes against the intent of local_lock which is for "pure
> > CPU local concurrency control mechanisms and not suited for inter-CPU
> > concurrency control" (Documentation/locking/locktypes.rst)
> > 
> > local_lock protects against migration between when the percpu pointer is
> > accessed and the pcp->lock acquired. The lock acquisition is a preemption
> > point so in the worst case, a task could migrate to another NUMA node
> > and accidentally allocate remote memory. The main requirement is to pin
> > the task to a CPU that is suitable for PREEMPT_RT and !PREEMPT_RT.
> > 
> > Replace local_lock with helpers that pin a task to a CPU, lookup the
> > per-cpu structure and acquire the embedded lock. It's similar to local_lock
> > without breaking the intent behind the API. It is not a complete API
> > as only the parts needed for PCP-alloc are implemented but in theory,
> > the generic helpers could be promoted to a general API if there was
> > demand for an embedded lock within a per-cpu struct with a guarantee
> > that the per-cpu structure locked matches the running CPU and cannot use
> > get_cpu_var due to RT concerns. PCP requires these semantics to avoid
> > accidentally allocating remote memory.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> ...
> 
> > @@ -3367,30 +3429,17 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
> >  	return min(READ_ONCE(pcp->batch) << 2, high);
> >  }
> >  
> > -/* Returns true if the page was committed to the per-cpu list. */
> > -static bool free_unref_page_commit(struct page *page, int migratetype,
> > -				   unsigned int order, bool locked)
> > +static void free_unref_page_commit(struct per_cpu_pages *pcp, struct zone *zone,
> > +				   struct page *page, int migratetype,
> > +				   unsigned int order)
> 
> Hmm given this drops the "bool locked" and bool return value again, my
> suggestion for patch 5/7 would result in less churn as those woudn't need to
> be introduced?
> 

It would. I considered doing exactly that but I didn't want to drop the
reviewed-bys and tested-bys and the change was significant enough to do
that. As multiple fixes are needed, I'll do that.

> ...
> 
> > @@ -3794,19 +3805,29 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
> >  	struct list_head *list;
> >  	struct page *page;
> >  	unsigned long flags;
> > +	unsigned long __maybe_unused UP_flags;
> >  
> > -	local_lock_irqsave(&pagesets.lock, flags);
> > +	/*
> > +	 * spin_trylock_irqsave is not necessary right now as it'll only be
> > +	 * true when contending with a remote drain. It's in place as a
> > +	 * preparation step before converting pcp locking to spin_trylock
> > +	 * to protect against IRQ reentry.
> > +	 */
> > +	pcp_trylock_prepare(UP_flags);
> > +	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
> > +	if (!pcp)
> 
> Besides the missing unpin Andrew fixed, I think also this is missing
> pcp_trylock_finish(UP_flags); ?
> 

Yes.

-- 
Mel Gorman
SUSE Labs
