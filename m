Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA2648D710
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiAMMCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:02:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44496 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiAMMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:02:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5EA34210E8;
        Thu, 13 Jan 2022 12:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642075347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LZVuyyTRSpRE6S8FOnrto8JpNJcnle8TpJ/IrQ16lRc=;
        b=keRZklNq4LxORySqWTBm2nBLk9YWgDGDuwL/AQ+Mai2k802cEBoIYsNa3oXRyNH0HTIcwI
        V0Cx9P6UsQ3SnsnAARYqz2HSalqMY0kXU8ZFunLpj8tmOa6xB7yoJbMInasHRJzL0REQLn
        mjW8NuZF0+swe/oGVE1356UI19oPou0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E510FA3B87;
        Thu, 13 Jan 2022 12:02:26 +0000 (UTC)
Date:   Thu, 13 Jan 2022 13:02:26 +0100
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
Message-ID: <YeAU0n1puxyr4N6Y@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
 <Yddh+APQGg8dKRgw@google.com>
 <Ydf/7DDu94fMs0CG@dhcp22.suse.cz>
 <YdgBL1dRk1KmyXJS@dhcp22.suse.cz>
 <Yduuyrk/AZG717Hs@google.com>
 <YdxEqFPLDf+wI0xX@dhcp22.suse.cz>
 <Yd/0Sgxy+jLm5cqd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd/0Sgxy+jLm5cqd@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-01-22 02:43:38, Yu Zhao wrote:
[...]
> > > The bottom line is I can try various optimizations, e.g., preallocate
> > > a few buffers for a limited number of page walkers and if this number
> > > has been reached, fallback to the rmap-based function. But I have yet
> > > to see evidence that calls for additional complexity.
> > 
> > I would disagree here. This is not an optimization. You should be
> > avoiding allocations from the memory reclaim because any allocation just
> > add a runtime behavior complexity and potential corner cases.
> 
> Would __GFP_NOMEMALLOC address your concern? It prevents allocations
> from accessing the reserves even under PF_MEMALLOC.

__GFP_NOMEMALLOC would deal with the complete memory depletion concern
for sure but I am not sure how any of these allocations would succeed
when called from the direct reclaim. Some access to memory reserves is
necessary if you insist on allocating from the reclaim process.

You can have a look at the limited memory reserves access by oom victims
for an example of how this can be done.

-- 
Michal Hocko
SUSE Labs
