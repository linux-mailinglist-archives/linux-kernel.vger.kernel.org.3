Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEFE49819A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiAXOB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:01:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48144 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbiAXOBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:01:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0950F1F38F;
        Mon, 24 Jan 2022 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643032913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/oVUfbULWzKcz6IcOUxqImvz1eec+zp5tb8htvYP5Ec=;
        b=R/mMkFSqw868tgKe1AOIrnmkM4oyJJLFOjbba51a4nt3TgAU/BJkSvVKkmOrGvvocrh8n+
        M17ZEkJZHvJebplEMlHBbi0dE2qj9idOaVWhyNXHk2F8qviIV195vTWni2RHJuvMu6RqSy
        YRkRz+Wpl5M41zBhVtcMjxVgHAQFmJk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1EDEFA3B8D;
        Mon, 24 Jan 2022 14:01:51 +0000 (UTC)
Date:   Mon, 24 Jan 2022 15:01:47 +0100
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
Message-ID: <Ye6xS6xUD1SORdHJ@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdhR4vWdWksBALtM@dhcp22.suse.cz>
 <Ydu6fXg2FmrseQOn@google.com>
 <YdwQcl6D5Mbp9Z4h@dhcp22.suse.cz>
 <Yee36hPfWSs+jR0m@google.com>
 <YefdFwcoX4+ZcDSY@dhcp22.suse.cz>
 <Ye3IfmZGwNYSCgV6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye3IfmZGwNYSCgV6@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 23-01-22 14:28:30, Yu Zhao wrote:
> On Wed, Jan 19, 2022 at 10:42:47AM +0100, Michal Hocko wrote:
> > On Wed 19-01-22 00:04:10, Yu Zhao wrote:
> > > On Mon, Jan 10, 2022 at 11:54:42AM +0100, Michal Hocko wrote:
> > > > On Sun 09-01-22 21:47:57, Yu Zhao wrote:
> > > > > On Fri, Jan 07, 2022 at 03:44:50PM +0100, Michal Hocko wrote:
> > > > > > On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> > > > > > [...]
> > > > > > > +static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_mm_walk *walk)
> > > > > > > +{
> > > > > > > +	static const struct mm_walk_ops mm_walk_ops = {
> > > > > > > +		.test_walk = should_skip_vma,
> > > > > > > +		.p4d_entry = walk_pud_range,
> > > > > > > +	};
> > > > > > > +
> > > > > > > +	int err;
> > > > > > > +#ifdef CONFIG_MEMCG
> > > > > > > +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> > > > > > > +#endif
> > > > > > > +
> > > > > > > +	walk->next_addr = FIRST_USER_ADDRESS;
> > > > > > > +
> > > > > > > +	do {
> > > > > > > +		unsigned long start = walk->next_addr;
> > > > > > > +		unsigned long end = mm->highest_vm_end;
> > > > > > > +
> > > > > > > +		err = -EBUSY;
> > > > > > > +
> > > > > > > +		rcu_read_lock();
> > > > > > > +#ifdef CONFIG_MEMCG
> > > > > > > +		if (memcg && atomic_read(&memcg->moving_account))
> > > > > > > +			goto contended;
> > > > > > > +#endif
> > > > > > > +		if (!mmap_read_trylock(mm))
> > > > > > > +			goto contended;
> > > > > > 
> > > > > > Have you evaluated the behavior under mmap_sem contention? I mean what
> > > > > > would be an effect of some mms being excluded from the walk? This path
> > > > > > is called from direct reclaim and we do allocate with exclusive mmap_sem
> > > > > > IIRC and the trylock can fail in a presence of pending writer if I am
> > > > > > not mistaken so even the read lock holder (e.g. an allocation from the #PF)
> > > > > > can bypass the walk.
> > > > > 
> > > > > You are right. Here it must be a trylock; otherwise it can deadlock.
> > > > 
> > > > Yeah, this is clear.
> > > > 
> > > > > I think there might be a misunderstanding: the aging doesn't
> > > > > exclusively rely on page table walks to gather the accessed bit. It
> > > > > prefers page table walks but it can also fallback to the rmap-based
> > > > > function, i.e., lru_gen_look_around(), which only gathers the accessed
> > > > > bit from at most 64 PTEs and therefore is less efficient. But it still
> > > > > retains about 80% of the performance gains.
> > > > 
> > > > I have to say that I really have hard time to understand the runtime
> > > > behavior depending on that interaction. How does the reclaim behave when
> > > > the virtual scan is enabled, partially enabled and almost completely
> > > > disabled due to different constrains? I do not see any such an
> > > > evaluation described in changelogs and I consider this to be a rather
> > > > important information to judge the overall behavior.
> > > 
> > > It doesn't have (partially) enabled/disabled states nor does its
> > > behavior change with different reclaim constraints. Having either
> > > would make its design too complex to implement or benchmark.
> > 
> > Let me clarify. By "partially enabled" I really meant behavior depedning
> > on runtime conditions. Say mmap_sem cannot be locked for half of scanned
> > tasks and/or allocation for the mm walker fails due to lack of memory.
> > How does this going to affect reclaim efficiency.
> 
> Understood. This is not only possible -- it's the default for our ARM
> hardware that doesn't support the accessed bit, i.e., CPUs that don't
> automatically set the accessed bit.
> 
> In try_to_inc_max_seq(), we have:
>     /*
>      * If the hardware doesn't automatically set the accessed bit, fallback
>      * to lru_gen_look_around(), which only clears the accessed bit in a
>      * handful of PTEs. Spreading the work out over a period of time usually
>      * is less efficient, but it avoids bursty page faults.
>      */
>     if the accessed bit is not supported
>         return
> 
>     if alloc_mm_walk() fails
>         return
> 
>     walk_mm()
>         if mmap_sem contented
>             return
> 
>         scan page tables
> 
> We have a microbenchmark that specifically measures this worst case
> scenario by entirely disabling page table scanning. Its results showed
> that this still retains more than 90% of the optimal performance. I'll
> share this microbenchmark in another email when answering Barry's
> questions regarding the accessed bit.
> 
> Our profiling infra also indirectly confirms this: it collects data
> from real users running on hardware with and without the accessed
> bit. Users running on hardware without the accessed bit indeed suffer
> a small performance degradation, compared with users running on
> hardware with it. But they still benefit almost as much, compared with
> users running on the same hardware but without MGLRU.

This definitely a good information to have in the cover letter.

> > How does a user/admin
> > know that the memory reclaim is in a "degraded" mode because of the
> > contention?
> 
> As we previously discussed here:
> https://lore.kernel.org/linux-mm/Ydu6fXg2FmrseQOn@google.com/
> there used to be a counter measuring the contention, and it was deemed
> unnecessary and removed in v4. But I don't have a problem if we want
> to revive it.

Well, counter might be rather tricky but few trace points would make some
sense to me.

-- 
Michal Hocko
SUSE Labs
