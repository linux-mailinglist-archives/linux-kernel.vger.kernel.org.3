Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965BB489C67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiAJPjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:39:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51354 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiAJPjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:39:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B460421124;
        Mon, 10 Jan 2022 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641829192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FpgD/z1tH1n4z25ssRiC8BwrRHCQmq0t20cgjahtksA=;
        b=a5nL7FD8WAScsrFn7oClSv1bqemNsF2dJoGD/wehxxpMVPytSTcqwnKSQ5wCUv8KKG6s8k
        yn3Yq4JQCE1YyY4GlQKkiO31jokIJkxJ8FCsP95m7oEwzL+LHmPqye4nUZny4PxI+IhEIx
        Lmrz78siT39fe0YgQ6PngSztc4docRw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 46A64A3B83;
        Mon, 10 Jan 2022 15:39:52 +0000 (UTC)
Date:   Mon, 10 Jan 2022 16:39:51 +0100
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
        page-reclaim@google.com, x86@kernel.org
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Message-ID: <YdxTR4+FL08XyFuO@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <YdSuSHa/Vjl6bPkg@google.com>
 <YdgKClGAuHlkzVbQ@dhcp22.suse.cz>
 <YdiKVJlClB3h1Kmg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdiKVJlClB3h1Kmg@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-01-22 11:45:40, Yu Zhao wrote:
[...]
> Next, I argue that the benefits of this patchset outweigh its risks,
> because, drawing from my past experience,
> 1. There have been many larger and/or riskier patchsets taken; I'll
>    assemble a list if you disagree.

No question about that. Changes in the reclaim path are paved with
failures and reverts and fine tuning on top of existing fine tuning.
The difference from your patchset is that they tend to be much much
smaller and go incremental and therefore easier to review.

>    And this patchset is fully guarded
>    by #ifdef; Linus has also assessed on this point.

I appreciate you made the new behavior an opt-in and therefore existing
workloads are less likely to regress. I do not think ifdefs help
all that much, though, because a) realistically the config will
likely be enabled for most distribution kernels and b) the parallel
reclaim implementation adds a maintenance overhead regardless of those
ifdef. The later point is especially worrying because the memory reclaim
is a complex and hard to review beast already. Any future changes would
need to consider both reclaim algorithms of course.

Hence I argue we really need a wider consensus this is the right
direction we want to pursue.

> 2. There have been none that came with the testing/benchmarking
>    coverage as this one did. Please point me to some if I'm mistaken,
>    and I'll gladly match them.

I do appreciate your numbers but you should realize that this is an area
that is really hard to get any conclusive testing for. We keep learning
about fallouts on workloads we haven't really anticipated or where the
runtime effects happen to disagree with our intuition. So while those
numbers are nice there are other important aspects to consider like the
maintenance cost for example.

> The numbers might not materialize in the real world; the code is not
> perfect; and many other risks... But all the top eight open source
> memory hogs were covered, which is unprecedented; memcached and fio
> showed significant improvements and it only takes a few commands to
> see for yourselves.
> 
> Regarding the acks and the reviewed-bys, I certainly can ask people
> who have reaped the benefits of this patchset to do them, if it's
> required. But I see less fun in that. I prefer to provide empirical
> evidence and convince people who are on the other side of the aisle.

I like to hear from users who benefit from your work and that certainly
gives more credit to it. But it will be the MM community to maintain the
code and address future issues.

We do not have a dedicated maintainer for the memory reclaim but
certainly there are people who have helped shaping the existing code and
have learned a lot from the past issues - like Johannes, Rik, Mel just
to name few. If I were you I would be really looking into finding an
agreement with them. I myself can help you with memcg and oom side of
the things (we already have discussions about those).

Thanks!
-- 
Michal Hocko
SUSE Labs
