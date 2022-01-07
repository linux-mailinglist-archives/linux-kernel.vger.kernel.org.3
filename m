Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD42487931
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347842AbiAGOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:44:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58138 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347793AbiAGOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:44:56 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EFB46212C7;
        Fri,  7 Jan 2022 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641566694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+izeRbXwrcTs43CEeqEXv+4wDW5wqLoC+ZvbrCEav4=;
        b=m3hga6iQl2WdcE2aPXfiLHIDIlm90X2+/UUEe5oBUxt1WKdURAf4jx8f7kkkPymSP1I+ad
        kF55jxo7kAuCghJXeVUMqfESh/pQi0j8mDLAFcbEqvmoARN0dSUHtvsk1sQTwYYomJICL5
        S6BjW+1PsU9wseHfa5980DYfHTG8dr4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3EA46A3B88;
        Fri,  7 Jan 2022 14:44:54 +0000 (UTC)
Date:   Fri, 7 Jan 2022 15:44:50 +0100
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
Message-ID: <YdhR4vWdWksBALtM@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104202227.2903605-7-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-01-22 13:22:25, Yu Zhao wrote:
[...]
> +static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_mm_walk *walk)
> +{
> +	static const struct mm_walk_ops mm_walk_ops = {
> +		.test_walk = should_skip_vma,
> +		.p4d_entry = walk_pud_range,
> +	};
> +
> +	int err;
> +#ifdef CONFIG_MEMCG
> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> +#endif
> +
> +	walk->next_addr = FIRST_USER_ADDRESS;
> +
> +	do {
> +		unsigned long start = walk->next_addr;
> +		unsigned long end = mm->highest_vm_end;
> +
> +		err = -EBUSY;
> +
> +		rcu_read_lock();
> +#ifdef CONFIG_MEMCG
> +		if (memcg && atomic_read(&memcg->moving_account))
> +			goto contended;
> +#endif
> +		if (!mmap_read_trylock(mm))
> +			goto contended;

Have you evaluated the behavior under mmap_sem contention? I mean what
would be an effect of some mms being excluded from the walk? This path
is called from direct reclaim and we do allocate with exclusive mmap_sem
IIRC and the trylock can fail in a presence of pending writer if I am
not mistaken so even the read lock holder (e.g. an allocation from the #PF)
can bypass the walk.

Or is this considered statistically insignificant thus a theoretical
problem?
-- 
Michal Hocko
SUSE Labs
