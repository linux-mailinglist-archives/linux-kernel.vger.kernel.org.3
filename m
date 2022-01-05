Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9A484F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiAEIzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiAEIzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:55:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8FFC061761;
        Wed,  5 Jan 2022 00:55:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF9636167C;
        Wed,  5 Jan 2022 08:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40542C36AED;
        Wed,  5 Jan 2022 08:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641372939;
        bh=8g2/BPq40vc0NB9YrpqVmK/MOPITFPSqe8IDisKitYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=RhlC90KRwV78uVdBiA0YhKQFavgF1UGclkv2HRA99uEzfv/1Ohf7wWXR1DCOmJwdX
         aZQayzLZ0i3HGIycHmFH7u6kK7dYQzmLliPYYH3l5Zf7Hr3N+gLloYw7M4+2zC4wNd
         pu3RUfIzIai7MzOFl7KdUgS/qvI730/nCYneNqMQkTSLZczGyT8yGXD0v4MYgyXBmQ
         FlMQeSqH+tPmJpqIjlOWkppbyF4Ejv3WaqwhlcyJcRpS1DVFiRsIk/DUX7COleX4Nl
         xuWw5stqjVgl5WOrX8JOPSLw4FgD2azP+z09MWNl1fdU7nFnRCzVhrqiblUxQPrSC1
         Ahpc97PzKVbqw==
From:   SeongJae Park <sj@kernel.org>
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
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Date:   Wed,  5 Jan 2022 08:55:34 +0000
Message-Id: <20220105085534.22981-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220104202227.2903605-1-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

On Tue, 4 Jan 2022 13:22:19 -0700 Yu Zhao <yuzhao@google.com> wrote:

> TLDR
> ====
> The current page reclaim is too expensive in terms of CPU usage and it
> often makes poor choices about what to evict. This patchset offers an
> alternative solution that is performant, versatile and
> straightforward.
>  
[...]
> Summery
> =======
> The facts are:
> 1. The independent lab results and the real-world applications
>    indicate substantial improvements; there are no known regressions.

So impressive results!

> 2. Thrashing prevention, working set estimation and proactive reclaim
>    work out of the box; there are no equivalent solutions.

I think similar works are already available out of the box with the latest
mainline tree, though it might be suboptimal in some cases.

First, you can do thrashing prevention using DAMON-based Operation Scheme
(DAMOS)[1] with MADV_COLD action.  Second, for working set estimation, you can
either use the DAMOS again with statistics action, or the damon_aggregated
tracepoint[2].  The DAMON user space tool[3] helps the tracepoint analysis and
visualization.  Finally, for the proactive reclaim, you can again use the DAMOS
with MADV_PAGEOUT action, or simply the DAMON-based proactive reclaim
module (DAMON_RECLAIM)[4].

Nevertheless, as noted above, current DAMON based solutions might be suboptimal
for some cases.  First of all, DAMON currently doesn't provide page granularity
monitoring.  Though its monitoring results were useful for our users'
production usages, there could be different requirements and situations.
Secondly, the DAMON-based thrashing prevention wouldn't reduce the CPU usage of
the reclamation logic's access scanning.

So, to me, MGLRU patchset looks providing something that DAMON doesn't provide,
but also something that DAMON is already providing.  Specifically, the
efficient page granularity access scanning is what DAMON doesn't provide for
now.  However, the utilization of the access information for LRU list
manipulation (thrashing prevention) and proactive reclamation is similar to
what DAMON (specifically, DAMOS) provides.  Also, this patchset is reducing the
reclamation logic's CPU usage using the efficient page granularity access
scanning.

IMHO, we might be able to reduce the duplicates by integrating MGLRU in DAMON.
What I'm saying is, we could 1) introduce the efficient page granularity access
scanning, 2) reduce the reclamation logic's CPU usage by making it to use the
efficient page granularity access scanning, and 3) extend DAMON for page
granularity monitoring with the efficient access sacanning[5].  Then, users
could get the benefit of MGLRU by using DAMOS but setting it to use your
efficient page granularity access scanning.  To make it more simple, we can
extend existing kernel logics to use DAMON in the way, or implement a new
kernel module.  Additional advantages of this approach would be 1) reducing the
changes to the existing code, and 2) making the efficient page granularity
access information be utilized for more general cases.

Of course, the integration might not be so simple as seems to me now.  We could
put DAMON and MGLRU together as those are for now, and let users select what
they really want.  I think it's up to you.

I didn't read this patchset thoroughly yet, so I might missing many things.  If
so, please feel free to let me know.

[1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes
[2] https://docs.kernel.org/admin-guide/mm/damon/usage.html#tracepoint-for-monitoring-results
[3] https://github.com/awslabs/damo
[4] https://docs.kernel.org/admin-guide/mm/damon/reclaim.html
[5] https://docs.kernel.org/vm/damon/design.html#configurable-layers


Thanks,
SJ

[...]
