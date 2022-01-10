Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B74C489C47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiAJPfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:35:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51028 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiAJPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:35:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 389D221124;
        Mon, 10 Jan 2022 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641828948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ou3hccuGrE9JX8ZCJzM6cwwz70DUBXZo8YDkFQ3OmgU=;
        b=PrmKoWzFsbyfvSb85EG+7a+KnQSInEofOGbULgFiRtsmU3oTRlEhCdcAQhbre+XgrNlO0V
        KD+gX50zp9mR5IetyEeduRbpkbVhw9wnQy7KV3M1KkxmgGBiBsV1uPCR4cpKQhL8eX89RG
        2HaSTF3R14e5o/fe0xY1M/5N2z9xQF8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3CB19A3B81;
        Mon, 10 Jan 2022 15:35:47 +0000 (UTC)
Date:   Mon, 10 Jan 2022 16:35:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 6/9] mm: multigenerational lru: aging
Message-ID: <YdxSUuDc3OC4pe+f@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <Ydg8AeE6JIUnC+ps@dhcp22.suse.cz>
 <YdjOazilBEkdUT7x@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdjOazilBEkdUT7x@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-01-22 16:36:11, Yu Zhao wrote:
> On Fri, Jan 07, 2022 at 02:11:29PM +0100, Michal Hocko wrote:
> > On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> > [...]
> > > +static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
> > > +{
> > > +	struct mem_cgroup *memcg;
> > > +	bool success = false;
> > > +	unsigned long min_ttl = READ_ONCE(lru_gen_min_ttl);
> > > +
> > > +	VM_BUG_ON(!current_is_kswapd());
> > > +
> > > +	current->reclaim_state->mm_walk = &pgdat->mm_walk;
> > > +
> > > +	memcg = mem_cgroup_iter(NULL, NULL, NULL);
> > > +	do {
> > > +		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > > +
> > > +		if (age_lruvec(lruvec, sc, min_ttl))
> > > +			success = true;
> > > +
> > > +		cond_resched();
> > > +	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
> > > +
> > > +	if (!success && mutex_trylock(&oom_lock)) {
> > > +		struct oom_control oc = {
> > > +			.gfp_mask = sc->gfp_mask,
> > > +			.order = sc->order,
> > > +		};
> > > +
> > > +		if (!oom_reaping_in_progress())
> > > +			out_of_memory(&oc);
> > > +
> > > +		mutex_unlock(&oom_lock);
> > > +	}
> > 
> > Why do you need to trigger oom killer from this path? Why cannot you
> > rely on the page allocator to do that like we do now?
> 
> This is per desktop users' (repeated) requests. The can't tolerate
> thrashing as servers do because of UI lags; and they usually don't
> have fancy tools like oomd.
> 
> Related discussions I saw:
> https://github.com/zen-kernel/zen-kernel/issues/218
> https://lore.kernel.org/lkml/20101028191523.GA14972@google.com/
> https://lore.kernel.org/lkml/20211213051521.21f02dd2@mail.inbox.lv/
> https://lore.kernel.org/lkml/54C2C89C.8080002@gmail.com/
> https://lore.kernel.org/lkml/d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com/

I do not really see any arguments why an userspace based trashing
detection cannot be used for those. Could you clarify?

Also my question was pointing to why out_of_memory is called from the
reclaim rather than the allocator (memcg charging path). It is the
caller of the reclaim to control different reclaim strategies and tell
when all the hopes are lost and the oom killer should be invoked. This
allows for a different policies at the allocator level and this change
will break that AFAICS. E.g. what if the underlying allocation context
is __GFP_NORETRY?
 
> >From patch 8:
>   Personal computers
>   ------------------
>   :Thrashing prevention: Write ``N`` to
>    ``/sys/kernel/mm/lru_gen/min_ttl_ms`` to prevent the working set of
>    ``N`` milliseconds from getting evicted. The OOM killer is invoked if
>    this working set can't be kept in memory. Based on the average human
>    detectable lag (~100ms), ``N=1000`` usually eliminates intolerable
>    lags due to thrashing. Larger values like ``N=3000`` make lags less
>    noticeable at the cost of more OOM kills.

This is a very good example of something that should be a self contained
patch with its own justification. TBH it is really not all that clear to
me that we want to provide any user visible knob to control OOM behavior
based on a time based QoS.

-- 
Michal Hocko
SUSE Labs
