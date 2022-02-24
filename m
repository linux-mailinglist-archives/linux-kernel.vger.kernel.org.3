Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0D4C269B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiBXIxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiBXIxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:53:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD40E162020
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:53:13 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 757211F39D;
        Thu, 24 Feb 2022 08:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645692792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8C4+gSdHMlHl52I6AqAMZLL28rQul65Dt9Lg29GnGjM=;
        b=MQpiomIbgDTdVjqGJwF7tPFvgn5lIFIfWTZ9VUzFqhEWYaXMLeshftcyp9ZfkLMLrkjQ68
        udJyj4lixfCRfHTXtwUJkKzUMb5mUIhzEdnP0iJ02wUDKP4R/7rUB9U2EKjwH1ynB4+0gU
        knXl7w5B9i72Rt0X/sQU2D2lMzWFvxA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 43E7CA3B99;
        Thu, 24 Feb 2022 08:53:12 +0000 (UTC)
Date:   Thu, 24 Feb 2022 09:53:11 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, pmladek@suse.com,
        peterz@infradead.org, guro@fb.com, shakeelb@google.com,
        minchan@kernel.org, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
Message-ID: <YhdHd+dXf91FP+K0@dhcp22.suse.cz>
References: <20220223194812.1299646-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223194812.1299646-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-02-22 11:48:12, Suren Baghdasaryan wrote:
> When page allocation in direct reclaim path fails, the system will
> make one attempt to shrink per-cpu page lists and free pages from
> high alloc reserves. Draining per-cpu pages into buddy allocator can
> be a very slow operation because it's done using workqueues and the
> task in direct reclaim waits for all of them to finish before
> proceeding. Currently this time is not accounted as psi memory stall.
> 
> While testing mobile devices under extreme memory pressure, when
> allocations are failing during direct reclaim, we notices that psi
> events which would be expected in such conditions were not triggered.
> After profiling these cases it was determined that the reason for
> missing psi events was that a big chunk of time spent in direct
> reclaim is not accounted as memory stall, therefore psi would not
> reach the levels at which an event is generated. Further investigation
> revealed that the bulk of that unaccounted time was spent inside
> drain_all_pages call.
> 
> A typical captured case when drain_all_pages path gets activated:
> 
> __alloc_pages_slowpath  took 44.644.613ns
>     __perform_reclaim   took    751.668ns (1.7%)
>     drain_all_pages     took 43.887.167ns (98.3%)

Although the draining is done in the slow path these numbers suggest
that we should really reconsider the use of WQ both for draining and
other purposes (like vmstats).

> PSI in this case records the time spent in __perform_reclaim but
> ignores drain_all_pages, IOW it misses 98.3% of the time spent in
> __alloc_pages_slowpath.
> 
> Annotate __alloc_pages_direct_reclaim in its entirety so that delays
> from handling page allocation failure in the direct reclaim path are
> accounted as memory stall.
> 
> Reported-by: Tim Murray <timmurray@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> changes in v3:
> - Moved psi_memstall_leave after the "out" label
> 
>  mm/page_alloc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6d31..029bceb79861 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4595,13 +4595,12 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
>  					const struct alloc_context *ac)
>  {
>  	unsigned int noreclaim_flag;
> -	unsigned long pflags, progress;
> +	unsigned long progress;
>  
>  	cond_resched();
>  
>  	/* We now go into synchronous reclaim */
>  	cpuset_memory_pressure_bump();
> -	psi_memstall_enter(&pflags);
>  	fs_reclaim_acquire(gfp_mask);
>  	noreclaim_flag = memalloc_noreclaim_save();
>  
> @@ -4610,7 +4609,6 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
>  
>  	memalloc_noreclaim_restore(noreclaim_flag);
>  	fs_reclaim_release(gfp_mask);
> -	psi_memstall_leave(&pflags);
>  
>  	cond_resched();
>  
> @@ -4624,11 +4622,13 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
>  		unsigned long *did_some_progress)
>  {
>  	struct page *page = NULL;
> +	unsigned long pflags;
>  	bool drained = false;
>  
> +	psi_memstall_enter(&pflags);
>  	*did_some_progress = __perform_reclaim(gfp_mask, order, ac);
>  	if (unlikely(!(*did_some_progress)))
> -		return NULL;
> +		goto out;
>  
>  retry:
>  	page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
> @@ -4644,6 +4644,8 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
>  		drained = true;
>  		goto retry;
>  	}
> +out:
> +	psi_memstall_leave(&pflags);
>  
>  	return page;
>  }
> -- 
> 2.35.1.473.g83b2b277ed-goog

-- 
Michal Hocko
SUSE Labs
