Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10597489B64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiAJOhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:37:42 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39718 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbiAJOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:37:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 41A451F393;
        Mon, 10 Jan 2022 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641825460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mGGXSmE2PGygicaDWyiQyfMTNMx7JPl01oF8oV8kkA=;
        b=XIwYmwtDh92mzMIVu5FZEt3+OPKR/NAJ6DV+zvetwm3/2DGdCR6BCgOlzaRxQ1jCaPT1rY
        clXp4SNhHcrPfxpWaI3GUTcY5SYCzklup7cwrqJTKK48ks8Mh+UqFAr1KQLNoHhhiZyWl/
        AwvIMNAA+CuiR2rs63UiCeL9gAId7JI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 24235A3B83;
        Mon, 10 Jan 2022 14:37:38 +0000 (UTC)
Date:   Mon, 10 Jan 2022 15:37:28 +0100
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
Message-ID: <YdxEqFPLDf+wI0xX@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
 <Yddh+APQGg8dKRgw@google.com>
 <Ydf/7DDu94fMs0CG@dhcp22.suse.cz>
 <YdgBL1dRk1KmyXJS@dhcp22.suse.cz>
 <Yduuyrk/AZG717Hs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yduuyrk/AZG717Hs@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09-01-22 20:58:02, Yu Zhao wrote:
> On Fri, Jan 07, 2022 at 10:00:31AM +0100, Michal Hocko wrote:
> > On Fri 07-01-22 09:55:09, Michal Hocko wrote:
> > [...]
> > > > In this case, lru_gen_mm_walk is small (160 bytes); it's per direct
> > > > reclaimer; and direct reclaimers rarely come here, i.e., only when
> > > > kswapd can't keep up in terms of the aging, which is similar to the
> > > > condition where the inactive list is empty for the active/inactive
> > > > lru.
> > > 
> > > Well, this is not a strong argument to be honest. Kswapd being stuck
> > > and the majority of the reclaim being done in the direct reclaim
> > > context is a situation I have seen many many times.
> > 
> > Also do not forget that memcg reclaim is effectivelly only direct
> > reclaim. Not that the memcg reclaim indicates a global memory shortage
> > but it can add up and race with the global reclaim as well.
> 
> I don't dispute any of the above, and I probably don't like this code
> more than you do.
> 
> But let's not forget the purposes of PF_MEMALLOC, besides preventing
> recursive reclaims, include letting reclaim dip into reserves so that
> it can make more free memory. So I think it's acceptable if the
> following conditions are met:
> 1. The allocation size is small.
> 2. The number of allocations is bounded.
> 3. Its failure doesn't stall reclaim.
> And it'd be nice if
> 4. The allocation happens rarely, e.g., slow path only.

I would add 
  0. The allocation should be done only if absolutely _necessary_.

Please keep in mind that whatever you allocate from that context will be
consuming a very precious memory reserves which are shared with other
components of the system. Even worse these can go all the way to
depleting memory completely where other things can fall apart.

> The code in question meets all of them.
> 
> 1. This allocation is 160 bytes.
> 2. It's bounded by the number of page table walkers which, in the
>    worst, is same as the number of mm_struct's.
> 3. Most importantly, its failure doesn't stall the aging. The aging
>    will fallback to the rmap-based function lru_gen_look_around().
>    But this function only gathers the accessed bit from at most 64
>    PTEs, meaning it's less efficient (retains ~80% performance gains).
> 4. This allocation is rare, i.e., only when the aging is required,
>    which is similar to the low inactive case for the active/inactive
>    lru.

I think this fallback behavior deserves much more detailed explanation
in changelogs.

> The bottom line is I can try various optimizations, e.g., preallocate
> a few buffers for a limited number of page walkers and if this number
> has been reached, fallback to the rmap-based function. But I have yet
> to see evidence that calls for additional complexity.

I would disagree here. This is not an optimization. You should be
avoiding allocations from the memory reclaim because any allocation just
add a runtime behavior complexity and potential corner cases.
-- 
Michal Hocko
SUSE Labs
