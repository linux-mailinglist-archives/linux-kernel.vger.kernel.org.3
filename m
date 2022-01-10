Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF14489C16
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiAJPV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:21:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44266 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiAJPV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:21:56 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4ABDB1F383;
        Mon, 10 Jan 2022 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641828115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qpTQmsspjI0q4mx2a8NrDJzrYQO5hqA3JJyE7DUO7w4=;
        b=Hk+f4nabnmeaiBbecxvUQ4Nmy+Uhh4ATDM6RvYRe7hK9hNq1S6kXXWWap4j4YzaiczcsM9
        YkhRVBMw3/8j/WBv637mZBeg+c+ttp9boV06pnUZDE01Kn+m4RE5Cj88LFEdZUyqRyiyDu
        +zZDdBtusPwzUPsvl75R/mnJfRw11aw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 56BCFA3B83;
        Mon, 10 Jan 2022 15:21:54 +0000 (UTC)
Date:   Mon, 10 Jan 2022 16:21:53 +0100
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
Subject: Re: [PATCH v6 5/9] mm: multigenerational lru: mm_struct list
Message-ID: <YdxPEdsfl771Z7IX@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-6-yuzhao@google.com>
 <YdgChw4vNb43XsU/@dhcp22.suse.cz>
 <YdjYkFmtMdrYg736@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdjYkFmtMdrYg736@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-01-22 17:19:28, Yu Zhao wrote:
> On Fri, Jan 07, 2022 at 10:06:15AM +0100, Michal Hocko wrote:
> > On Tue 04-01-22 13:22:24, Yu Zhao wrote:
> > > To exploit spatial locality, the aging prefers to walk page tables to
> > > search for young PTEs. And this patch paves the way for that.
> > > 
> > > An mm_struct list is maintained for each memcg, and an mm_struct
> > > follows its owner task to the new memcg when this task is migrated.
> > 
> > How does this work actually for the memcg reclaim? I can see you
> > lru_gen_migrate_mm on the task migration. My concern is, though, that
> > such a task leaves all the memory behind in the previous memcg (in
> > cgroup v2, in v1 you can opt in for charge migration). If you move the
> > mm to a new memcg then you age it somewhere where the memory is not
> > really consumed.
> 
> There are two options to gather the accessed bit: page table walks and
> rmap walks. Page table walks sweep dense hotspots that are NOT
> misplaced in terms of reclaim scope (lruvec); rmap walks cover what
> page table walks miss, e.g., misplaced dense hotspots or sparse ones.
> 
> Dense hotspots are stored in Bloom filters for each lruvec.
> 
> If an mm leaves everything in the old memcg, page table walks in the
> new memcg reclaim path basically ignore this mm after the first scan,
> because everything is misplaced.

OK, so do I get it right that pages mapped from a different memcg than
the reclaimed one are considered effectivelly non-present from the the
reclaim logic POV? This would be worth mentioning in the migration
callback because it is not really that straightforward to put those two
together.
 
> In the old memcg reclaim path, page table walks won't see this mm
> at all. But rmap walks will catch everything later in the eviction
> path, i.e., lru_gen_look_around(). This function is less efficient
> compared with page table walks because, for each rmap walk of a
> non-shared page, it only can gather the accessed bit from 64 PTEs at
> most. But it's still a lot faster than the original rmap, which only
> gathers the accessed bit from a single PTE, for each walk of a
> non-shared page.

Again, something that should be really documented.
-- 
Michal Hocko
SUSE Labs
