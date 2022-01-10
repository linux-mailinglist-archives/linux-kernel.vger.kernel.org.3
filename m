Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFAF4896C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbiAJKyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:54:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46496 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244285AbiAJKyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:54:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 97F2E21108;
        Mon, 10 Jan 2022 10:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641812086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oKacWBSN/ZXwXmFrEa9nCB5WmYPzYr2A9hT2GRYd14M=;
        b=Z43I/eSbXXVkSr86SLVEM+mrL1i4j2GQBi70dciJ2aG1HwuNDRMRFM1wjl0kf1gMf8f3HD
        pGZvcIqzVgDrjLyK0elQSOHqU+gH5Jito4dOdMg/I5gMXUZ7j+AGE9cCFRC7QF/kqqU5cV
        jWCNf5Ta3ex9HQcy3swcNF33faKgh2s=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A58EFA3B81;
        Mon, 10 Jan 2022 10:54:45 +0000 (UTC)
Date:   Mon, 10 Jan 2022 11:54:42 +0100
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
Message-ID: <YdwQcl6D5Mbp9Z4h@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdhR4vWdWksBALtM@dhcp22.suse.cz>
 <Ydu6fXg2FmrseQOn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydu6fXg2FmrseQOn@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09-01-22 21:47:57, Yu Zhao wrote:
> On Fri, Jan 07, 2022 at 03:44:50PM +0100, Michal Hocko wrote:
> > On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> > [...]
> > > +static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_mm_walk *walk)
> > > +{
> > > +	static const struct mm_walk_ops mm_walk_ops = {
> > > +		.test_walk = should_skip_vma,
> > > +		.p4d_entry = walk_pud_range,
> > > +	};
> > > +
> > > +	int err;
> > > +#ifdef CONFIG_MEMCG
> > > +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> > > +#endif
> > > +
> > > +	walk->next_addr = FIRST_USER_ADDRESS;
> > > +
> > > +	do {
> > > +		unsigned long start = walk->next_addr;
> > > +		unsigned long end = mm->highest_vm_end;
> > > +
> > > +		err = -EBUSY;
> > > +
> > > +		rcu_read_lock();
> > > +#ifdef CONFIG_MEMCG
> > > +		if (memcg && atomic_read(&memcg->moving_account))
> > > +			goto contended;
> > > +#endif
> > > +		if (!mmap_read_trylock(mm))
> > > +			goto contended;
> > 
> > Have you evaluated the behavior under mmap_sem contention? I mean what
> > would be an effect of some mms being excluded from the walk? This path
> > is called from direct reclaim and we do allocate with exclusive mmap_sem
> > IIRC and the trylock can fail in a presence of pending writer if I am
> > not mistaken so even the read lock holder (e.g. an allocation from the #PF)
> > can bypass the walk.
> 
> You are right. Here it must be a trylock; otherwise it can deadlock.

Yeah, this is clear.

> I think there might be a misunderstanding: the aging doesn't
> exclusively rely on page table walks to gather the accessed bit. It
> prefers page table walks but it can also fallback to the rmap-based
> function, i.e., lru_gen_look_around(), which only gathers the accessed
> bit from at most 64 PTEs and therefore is less efficient. But it still
> retains about 80% of the performance gains.

I have to say that I really have hard time to understand the runtime
behavior depending on that interaction. How does the reclaim behave when
the virtual scan is enabled, partially enabled and almost completely
disabled due to different constrains? I do not see any such an
evaluation described in changelogs and I consider this to be a rather
important information to judge the overall behavior.
 
> > Or is this considered statistically insignificant thus a theoretical
> > problem?
> 
> Yes. People who work on the maple tree and SPF at Google expressed the
> same concern during the design review meeting (all stakeholders on the
> mailing list were also invited). So we had a counter to monitor the
> contention in previous versions, i.e., MM_LOCK_CONTENTION in v4 here:
> https://lore.kernel.org/lkml/20210818063107.2696454-8-yuzhao@google.com/
> 
> And we also combined this patchset with the SPF patchset to see if the
> latter makes any difference. Our conclusion was the contention is
> statistically insignificant to the performance under memory pressure.
> 
> This can be explained by how often we create a new generation. (We
> only walk page tables when we create a new generation. And it's
> similar to the low inactive condition for the active/inactive lru.)
> 
> Usually we only do so every few seconds. We'd run into problems with
> other parts of the kernel, e.g., lru lock contention, i/o congestion,
> etc. if we create more than a few generation every second.

This would be a very good information to have in changelogs. Ideally
with some numbers and analysis.

-- 
Michal Hocko
SUSE Labs
