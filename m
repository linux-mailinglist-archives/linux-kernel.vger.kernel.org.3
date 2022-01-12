Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0497C48C24F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352544AbiALK3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:29:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35690 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbiALK3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:29:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EE1A51F3CA;
        Wed, 12 Jan 2022 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641983338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ioyVnpN3K6fNhs+IEe7aVsyN+KrufIvhdGNWWrmI3JA=;
        b=qA94ONzIs4uB2pR3BTbt8lg3/96/Y38YAMcV7cOYTaUW8EuHvMn5oJsISzeqOjc26MBK/0
        H92wU1dghL/np4cg9lwZeon9d2awSYlsbKrolCzdJObL0Zw8ywEXHX4w6vT+gkQ5QjI/H1
        cNQn+crVBa9yWVlPheo9PWGsEYHgcz8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3E91FA3B83;
        Wed, 12 Jan 2022 10:28:58 +0000 (UTC)
Date:   Wed, 12 Jan 2022 11:28:57 +0100
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
Message-ID: <Yd6tafG3CS7BoRYn@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
 <YdxKORU9OWCv114O@dhcp22.suse.cz>
 <Yd4P6bEJI8YlXq0H@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd4P6bEJI8YlXq0H@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-01-22 16:16:57, Yu Zhao wrote:
> On Mon, Jan 10, 2022 at 04:01:13PM +0100, Michal Hocko wrote:
> > On Thu 06-01-22 17:12:18, Michal Hocko wrote:
> > > On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> > > > +static struct lru_gen_mm_walk *alloc_mm_walk(void)
> > > > +{
> > > > +	if (!current->reclaim_state || !current->reclaim_state->mm_walk)
> > > > +		return kvzalloc(sizeof(struct lru_gen_mm_walk), GFP_KERNEL);
> > 
> > One thing I have overlooked completely.
> 
> I appreciate your attention to details but GFP_KERNEL is legit in the
> reclaim path. It's been used many years in our production, e.g.,
>   page reclaim
>     swap_writepage()
>       frontswap_store()
>         zswap_frontswap_store()
>           zswap_entry_cache_alloc(GFP_KERNEL)
> 
> (And I always test my changes with lockdep, kasan, DEBUG_VM, etc., no
>  warnings ever seen from using GFP_KERNEL in the reclaim path.)

OK, I can see it now. __need_reclaim will check for PF_MEMALLOC and skip
the fs_reclaim tracking.

I still maintain I am not really happy about (nor in the zswap example)
allocations from the direct reclaim context. I would really recommend
using a pre-allocated pool of objects.

If there are strong reasons for not doing so then at lease change that
to kzalloc.

Thanks!
-- 
Michal Hocko
SUSE Labs
