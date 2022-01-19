Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1E14937A1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353125AbiASJoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:44:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60270 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353101AbiASJoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:44:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 040BC218B1;
        Wed, 19 Jan 2022 09:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642585462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wd3d1acncrN3IVV5mgX/L/jJbqedR5eFN/1PmkMkzAg=;
        b=Kdg2KeeNAASnM5cZJcAIdy1LlLKxEhnP795ZWM/tTUl0SuDKuXKu07ycmgfMZP4eVMdt/8
        hpTrsN+B6Qmr7E79NcMHHeXOsBAYUaHIJmTRW4xNlmLl6Bd10zA9wrSEzBVAuISXaJ4nsD
        auQfHN9ea7Nv7WOWSEnm8oZyZY9sCHs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 92218A3BA7;
        Wed, 19 Jan 2022 09:44:21 +0000 (UTC)
Date:   Wed, 19 Jan 2022 10:44:21 +0100
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
Message-ID: <YefddYm8FAfJalNa@dhcp22.suse.cz>
References: <20220104202227.2903605-7-yuzhao@google.com>
 <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
 <Yddh+APQGg8dKRgw@google.com>
 <Ydf/7DDu94fMs0CG@dhcp22.suse.cz>
 <YdgBL1dRk1KmyXJS@dhcp22.suse.cz>
 <Yduuyrk/AZG717Hs@google.com>
 <YdxEqFPLDf+wI0xX@dhcp22.suse.cz>
 <Yd/0Sgxy+jLm5cqd@google.com>
 <YeAU0n1puxyr4N6Y@dhcp22.suse.cz>
 <YeewK/cYG4MXV4f3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeewK/cYG4MXV4f3@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-01-22 23:31:07, Yu Zhao wrote:
> On Thu, Jan 13, 2022 at 01:02:26PM +0100, Michal Hocko wrote:
> > On Thu 13-01-22 02:43:38, Yu Zhao wrote:
> > [...]
> > > > > The bottom line is I can try various optimizations, e.g., preallocate
> > > > > a few buffers for a limited number of page walkers and if this number
> > > > > has been reached, fallback to the rmap-based function. But I have yet
> > > > > to see evidence that calls for additional complexity.
> > > > 
> > > > I would disagree here. This is not an optimization. You should be
> > > > avoiding allocations from the memory reclaim because any allocation just
> > > > add a runtime behavior complexity and potential corner cases.
> > > 
> > > Would __GFP_NOMEMALLOC address your concern? It prevents allocations
> > > from accessing the reserves even under PF_MEMALLOC.
> > 
> > __GFP_NOMEMALLOC would deal with the complete memory depletion concern
> > for sure but I am not sure how any of these allocations would succeed
> > when called from the direct reclaim. Some access to memory reserves is
> > necessary if you insist on allocating from the reclaim process.
> > 
> > You can have a look at the limited memory reserves access by oom victims
> > for an example of how this can be done.
> 
> Thanks. I'll change GFP_KERNEL to __GFP_HIGH | __GFP_NOMEMALLOC.
> __GFP_HIGH allows some access to memory reserves and __GFP_NOMEMALLOC
> prevents the complete depletion. Basically the combination lower the
> min watermark by 1/2, and we have been using them for
> add_to_swap_cache().

Yes this will prevent the complete memory depletion. There are other
users of this portion of memory reserves so the reclaim might be out of
luck. How this turns out in practice remains to be seen though but it
certainly is an opportunity for corner cases and hard to test behavior.

-- 
Michal Hocko
SUSE Labs
