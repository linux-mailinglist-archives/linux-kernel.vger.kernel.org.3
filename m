Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9147493535
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiASHET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiASHER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:04:17 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E389EC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:04:16 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id i82so1681130ioa.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WF2XhxdWcahC6NDYs1rosQPA8N+0DlTVNlcv63XewtM=;
        b=khTBgUDeaNd9UcmIIpibbFHM09F3LKlr3TK5ulNywzTejrw/DKsawyIYDnirLCXiTO
         A02mwiiBXy+7XRBWgRcC5E0qynNbb++dGa5R31uCoyzx0k4OJFe6Ssasx+kKrUz9v0Bx
         FbVDqwa21wOF/m1+/hncxDpD26vALVz3nqexAABzIc2WON754Mbt9UOIGi6TUDwf+eS7
         mzVjgjl6jHPGGLWaQloSaaIdKbmGrK2bmRNzsTZWIvqAUZM/LiVrhcNBHvbl2ZQFG5Fz
         CoXEl5NeduyP9Jn4lDbpZh8bDiUmin03FUXBIlIBU9k7QLBqUhTB5WqLZYg5whbArpb2
         +DTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WF2XhxdWcahC6NDYs1rosQPA8N+0DlTVNlcv63XewtM=;
        b=skgocyjklIxDwVx93deuwuCmzJDpDHiNVI3miK4IlOOYgiMJ44PDgeF6Mt6hjartls
         h2Yzj3iDd5DYTOBedLFGlFjapMpHefrBf5zMZQWPw+Gli4ozD1HmNCuJgEJ3OimBwm5o
         6t9thiucoDiOeFwbWCgepJ+FtWsxopfP0idDnKIvoOoMV/rwFNvExoBMPISYEHsVjaGi
         xNxLOzE4HPnT1i7XudKKaTqoDumeFOdKqwyafkxlE2hlm8sJMlAN1NGQT5YPEvJWX4HA
         p7nfsumbg1N39WQoHab1KP+IPBu6i59BzlhTnlrcf/Bhcu7rH3HKTOPHzUyiOheJNUOX
         qF3Q==
X-Gm-Message-State: AOAM530eANDTeh8kuRVzYkM0ck/QD95SuJZ4Gh5j90prcTlgdWy6xu0s
        itxbnbE/1mHZUn/z/3U6LVeqkQ==
X-Google-Smtp-Source: ABdhPJwZIVI0EYafR2e3oyg6eDCnWq2adkd5lzKzCsC1VUUPRKtQvAXZJR5pQTRKLatrdMi5K6n9xQ==
X-Received: by 2002:a02:3b0d:: with SMTP id c13mr13936220jaa.126.1642575855825;
        Tue, 18 Jan 2022 23:04:15 -0800 (PST)
Received: from google.com ([2620:15c:183:200:90fc:e0c9:c69f:bede])
        by smtp.gmail.com with ESMTPSA id j18sm10892127ila.86.2022.01.18.23.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 23:04:15 -0800 (PST)
Date:   Wed, 19 Jan 2022 00:04:10 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <Yee36hPfWSs+jR0m@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdhR4vWdWksBALtM@dhcp22.suse.cz>
 <Ydu6fXg2FmrseQOn@google.com>
 <YdwQcl6D5Mbp9Z4h@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdwQcl6D5Mbp9Z4h@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:54:42AM +0100, Michal Hocko wrote:
> On Sun 09-01-22 21:47:57, Yu Zhao wrote:
> > On Fri, Jan 07, 2022 at 03:44:50PM +0100, Michal Hocko wrote:
> > > On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> > > [...]
> > > > +static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_mm_walk *walk)
> > > > +{
> > > > +	static const struct mm_walk_ops mm_walk_ops = {
> > > > +		.test_walk = should_skip_vma,
> > > > +		.p4d_entry = walk_pud_range,
> > > > +	};
> > > > +
> > > > +	int err;
> > > > +#ifdef CONFIG_MEMCG
> > > > +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> > > > +#endif
> > > > +
> > > > +	walk->next_addr = FIRST_USER_ADDRESS;
> > > > +
> > > > +	do {
> > > > +		unsigned long start = walk->next_addr;
> > > > +		unsigned long end = mm->highest_vm_end;
> > > > +
> > > > +		err = -EBUSY;
> > > > +
> > > > +		rcu_read_lock();
> > > > +#ifdef CONFIG_MEMCG
> > > > +		if (memcg && atomic_read(&memcg->moving_account))
> > > > +			goto contended;
> > > > +#endif
> > > > +		if (!mmap_read_trylock(mm))
> > > > +			goto contended;
> > > 
> > > Have you evaluated the behavior under mmap_sem contention? I mean what
> > > would be an effect of some mms being excluded from the walk? This path
> > > is called from direct reclaim and we do allocate with exclusive mmap_sem
> > > IIRC and the trylock can fail in a presence of pending writer if I am
> > > not mistaken so even the read lock holder (e.g. an allocation from the #PF)
> > > can bypass the walk.
> > 
> > You are right. Here it must be a trylock; otherwise it can deadlock.
> 
> Yeah, this is clear.
> 
> > I think there might be a misunderstanding: the aging doesn't
> > exclusively rely on page table walks to gather the accessed bit. It
> > prefers page table walks but it can also fallback to the rmap-based
> > function, i.e., lru_gen_look_around(), which only gathers the accessed
> > bit from at most 64 PTEs and therefore is less efficient. But it still
> > retains about 80% of the performance gains.
> 
> I have to say that I really have hard time to understand the runtime
> behavior depending on that interaction. How does the reclaim behave when
> the virtual scan is enabled, partially enabled and almost completely
> disabled due to different constrains? I do not see any such an
> evaluation described in changelogs and I consider this to be a rather
> important information to judge the overall behavior.

It doesn't have (partially) enabled/disabled states nor does its
behavior change with different reclaim constraints. Having either
would make its design too complex to implement or benchmark.

There is feedback loop connecting page table walks and rmap walks by
Bloom filters. The Bloom filters hold dense hot areas. Page table walks
test whether virtual areas are in the Bloom filters and scan those that
were tested positive. Anything they miss will be caught by rmap walks
later (shrink_page_list()). And when rmap walks find new dense hot
areas, they add those area to the Bloom filters.

A dense hot area means it has many accessed pages belonging to the
reclaim domain, and clearing the accessed bit in all PTEs within this
area by one page table walk is more efficient than doing it one by one
by many rmap walks, in terms of cacheline utilization.

> > > Or is this considered statistically insignificant thus a theoretical
> > > problem?
> > 
> > Yes. People who work on the maple tree and SPF at Google expressed the
> > same concern during the design review meeting (all stakeholders on the
> > mailing list were also invited). So we had a counter to monitor the
> > contention in previous versions, i.e., MM_LOCK_CONTENTION in v4 here:
> > https://lore.kernel.org/lkml/20210818063107.2696454-8-yuzhao@google.com/
> > 
> > And we also combined this patchset with the SPF patchset to see if the
> > latter makes any difference. Our conclusion was the contention is
> > statistically insignificant to the performance under memory pressure.
> > 
> > This can be explained by how often we create a new generation. (We
> > only walk page tables when we create a new generation. And it's
> > similar to the low inactive condition for the active/inactive lru.)
> > 
> > Usually we only do so every few seconds. We'd run into problems with
> > other parts of the kernel, e.g., lru lock contention, i/o congestion,
> > etc. if we create more than a few generation every second.
> 
> This would be a very good information to have in changelogs. Ideally
> with some numbers and analysis.

Will do. Thanks.
