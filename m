Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0948AA08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349120AbiAKJAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:00:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41354 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349097AbiAKJAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:00:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1CD5A1F3B6;
        Tue, 11 Jan 2022 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641891634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OeasfAigrOwxNyBh17klLqWDReCRAIT8+9bALhOBBTE=;
        b=OMEOsmUPz8Sg5EGy0PNoyTTlWBHkVa2PxtC09u3JHkWldsYJD3LDsOF2LQXxRkUQ+wrIz9
        kcASeAyImPhvK10QPGGJBnFhD4+6Ifeni3fz+rJutCz7kPryrVDu9fMuWjvffV0B/2cRYu
        QcGlA6B7IXEkYO+V2VC7xQyW7LQxBQ4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 49F73A3B9B;
        Tue, 11 Jan 2022 09:00:33 +0000 (UTC)
Date:   Tue, 11 Jan 2022 10:00:32 +0100
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
Message-ID: <Yd1HMDqiySwVxbF7@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <Ydg8AeE6JIUnC+ps@dhcp22.suse.cz>
 <YdjOazilBEkdUT7x@google.com>
 <YdxSUuDc3OC4pe+f@dhcp22.suse.cz>
 <Ydza/zXKY9ATRoh6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydza/zXKY9ATRoh6@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-01-22 18:18:55, Yu Zhao wrote:
> On Mon, Jan 10, 2022 at 04:35:46PM +0100, Michal Hocko wrote:
> > On Fri 07-01-22 16:36:11, Yu Zhao wrote:
> > > On Fri, Jan 07, 2022 at 02:11:29PM +0100, Michal Hocko wrote:
> > > > On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> > > > [...]
> > > > > +static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
> > > > > +{
> > > > > +	struct mem_cgroup *memcg;
> > > > > +	bool success = false;
> > > > > +	unsigned long min_ttl = READ_ONCE(lru_gen_min_ttl);
> > > > > +
> > > > > +	VM_BUG_ON(!current_is_kswapd());
> > > > > +
> > > > > +	current->reclaim_state->mm_walk = &pgdat->mm_walk;
> > > > > +
> > > > > +	memcg = mem_cgroup_iter(NULL, NULL, NULL);
> > > > > +	do {
> > > > > +		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > > > > +
> > > > > +		if (age_lruvec(lruvec, sc, min_ttl))
> > > > > +			success = true;
> > > > > +
> > > > > +		cond_resched();
> > > > > +	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
> > > > > +
> > > > > +	if (!success && mutex_trylock(&oom_lock)) {
> > > > > +		struct oom_control oc = {
> > > > > +			.gfp_mask = sc->gfp_mask,
> > > > > +			.order = sc->order,
> > > > > +		};
> > > > > +
> > > > > +		if (!oom_reaping_in_progress())
> > > > > +			out_of_memory(&oc);
> > > > > +
> > > > > +		mutex_unlock(&oom_lock);
> > > > > +	}
> > > > 
> > > > Why do you need to trigger oom killer from this path? Why cannot you
> > > > rely on the page allocator to do that like we do now?
> > > 
> > > This is per desktop users' (repeated) requests. The can't tolerate
> > > thrashing as servers do because of UI lags; and they usually don't
> > > have fancy tools like oomd.
> > > 
> > > Related discussions I saw:
> > > https://github.com/zen-kernel/zen-kernel/issues/218
> > > https://lore.kernel.org/lkml/20101028191523.GA14972@google.com/
> > > https://lore.kernel.org/lkml/20211213051521.21f02dd2@mail.inbox.lv/
> > > https://lore.kernel.org/lkml/54C2C89C.8080002@gmail.com/
> > > https://lore.kernel.org/lkml/d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com/
> > 
> > I do not really see any arguments why an userspace based trashing
> > detection cannot be used for those. Could you clarify?
> 
> It definitely can be done. But who is going to do it for every distro
> and all individual users? AFAIK, not a single distro provides such a
> solution for desktop/laptop/phone users.

If existing interfaces provides sufficient information to make those
calls then I would definitely prefer a userspace solution.

> And also there is the theoretical question how reliable a userspace
> solution can be. What if this usespace solution itself gets stuck in
> the direct reclaim path. I'm sure if nobody has done some search to
> prove or debunk it.

I have to confess I haven't checked oomd or other solutions but with a
sufficient care (all the code mlocked in + no allocations done while
collecting data) I believe this should be achieveable.

> In addition, what exactly PSI values should be used on different
> models of consumer electronics? Nobody knows. We have a team working
> on this and we haven't figured it out for all our Chromebook models.

I believe this is a matter of tuning for a specific deployment. We do
not have only psi but also refault counters that can be used.

> As Andrew said, "a blunt instrument like this would be useful".
> https://lore.kernel.org/lkml/20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org/
> 
> I'd like to have less code in kernel too, but I've learned never to
> walk over users. If I remove this and they come after me asking why,
> I'd have a hard time convincing them.
> 
> > Also my question was pointing to why out_of_memory is called from the
> > reclaim rather than the allocator (memcg charging path). It is the
> > caller of the reclaim to control different reclaim strategies and tell
> > when all the hopes are lost and the oom killer should be invoked. This
> > allows for a different policies at the allocator level and this change
> > will break that AFAICS. E.g. what if the underlying allocation context
> > is __GFP_NORETRY?
> 
> This is called in kswapd only, and by default (min_ttl=0) it doesn't
> do anything. So __GFP_NORETRY doesn't apply.

My bad. I must have got lost when traversing the code but I can see you
are enforcing that by a VM_BUG_ON. So the limited scope reclaim is not a
problem indeed.

> The question would be
> more along the lines of long-term ABI support.
> 
> And I'll add the following comments, if you think we can keep this
> logic:
>    OOM kill if every generation from all memcgs is younger than min_ttl.
>    Another theoretical possibility is all memcgs are either below min or
>    ineligible at priority 0, but this isn't the main goal.
> 
> (Please read my reply at the bottom to decide whether we should keep
>  it or not. Thanks.)
> 
> > > >From patch 8:
> > >   Personal computers
> > >   ------------------
> > >   :Thrashing prevention: Write ``N`` to
> > >    ``/sys/kernel/mm/lru_gen/min_ttl_ms`` to prevent the working set of
> > >    ``N`` milliseconds from getting evicted. The OOM killer is invoked if
> > >    this working set can't be kept in memory. Based on the average human
> > >    detectable lag (~100ms), ``N=1000`` usually eliminates intolerable
> > >    lags due to thrashing. Larger values like ``N=3000`` make lags less
> > >    noticeable at the cost of more OOM kills.
> > 
> > This is a very good example of something that should be a self contained
> > patch with its own justification.
> 
> Consider it done.
> 
> > TBH it is really not all that clear to
> > me that we want to provide any user visible knob to control OOM behavior
> > based on a time based QoS.
> 
> Agreed, and it didn't exist until v4, i.e., after I was demanded to
> provide it for several times.
> 
> For example:
> https://github.com/zen-kernel/zen-kernel/issues/223
> 
> And another example:
>    Your Multigenerational LRU patchset is pretty complex and
>    effective, but does not eliminate thrashing condition fully on an
>    old PCs with slow HDD.
> 
>    I'm kindly asking you to cooperate with hakavlad if it's possible
>    and maybe re-implement parts of le9 patch in your patchset wherever
>    acceptable, as they are quite similar in the core concept.
> 
> This is excerpt of an email from iam@valdikss.org.ru, and he has
> posted demo videos in this discussion:
> https://lore.kernel.org/lkml/2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru/

That is all an interesting feedback but we should be really craful about
ABI constrains and future maintainability of the knob. I still stand
behind my statement that kernel should implement such features only if
it is clear that we cannot really implement a similar logic in the
userspace.

-- 
Michal Hocko
SUSE Labs
