Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85A4874DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiAGJiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:38:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59004 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbiAGJiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:38:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 282701F39C;
        Fri,  7 Jan 2022 09:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641548300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nkfXnq2z3Bzy30uRxyBjVD1CQJwqnvsmJPgDU2tAnvU=;
        b=lGgwfy+B7SrRjFNAuYG39p9S314V5PF2hGoHu1so7bh5izsOVYuV1uLWSzdPE/+M5EohMn
        4JFi6fPa/E+AefxEBY6KIb5utYFjE96FYG/eSkNEPJrOiUIE7Jm/qoYB2ziENrK5KXthn9
        UEFzU5f3E5Dd5k9nqVH5qQobXUnkz2Y=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 70CA9A3B84;
        Fri,  7 Jan 2022 09:38:19 +0000 (UTC)
Date:   Fri, 7 Jan 2022 10:38:18 +0100
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
Message-ID: <YdgKClGAuHlkzVbQ@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <YdSuSHa/Vjl6bPkg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdSuSHa/Vjl6bPkg@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-01-22 13:30:00, Yu Zhao wrote:
[...]
> Hi Andrew, Linus,
> 
> Can you please take a look at this patchset and let me know if it's
> 5.17 material?

I am still not done with the review and have seen at least few problems
that would need to be addressed.

But more fundamentally I believe there are really some important
questions to be answered. First and foremost this is a major addition
to the memory reclaim and there should be a wider consensus that we
really want to go that way. The patchset doesn't have a single ack nor
reviewed-by AFAICS. I haven't seen a lot of discussion since v2
(http://lkml.kernel.org/r/20210413065633.2782273-1-yuzhao@google.com)
nor do I see any clarification on how concerns raised there have been
addressed or at least how they are planned to be addressed.

Johannes has made some excellent points
http://lkml.kernel.org/r/YHcpzZYD2fQyWvEQ@cmpxchg.org. Let me quote
for reference part of it I find the most important:
: Realistically, I think incremental changes are unavoidable to get this
: merged upstream.
: 
: Not just in the sense that they need to be smaller changes, but also
: in the sense that they need to replace old code. It would be
: impossible to maintain both, focus development and testing resources,
: and provide a reasonably stable experience with both systems tugging
: at a complicated shared code base.
: 
: On the other hand, the existing code also has billions of hours of
: production testing and tuning. We can't throw this all out overnight -
: it needs to be surgical and the broader consequences of each step need
: to be well understood.
: 
: We also have millions of servers relying on being able to do upgrades
: for drivers and fixes in other subsystems that we can't put on hold
: until we stabilized a new reclaim implementation from scratch.

Fully agreed on all points here.

I do appreciate there is a lot of work behind this patchset and I
also do understand it has gained a considerable amount of testing as
well. Your numbers are impressive but my experience tells me that it is
equally important to understand the worst case behavior and there is not
really much mentioned about those in changelogs.

We also shouldn't ignore costs the code is adding. One of them would be
a further page flags depletion. We have been hitting problems on that
front for years and many features had to be reworked to bypass a lack of
space in page->flags.

I will be looking more into the code (especially the memcg side of it)
but I really believe that a consensus on above Johannes' points need to
be found first before this work can move forward.

Thanks!
-- 
Michal Hocko
SUSE Labs
