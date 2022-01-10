Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C402489DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiAJQ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:57:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55510 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiAJQ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:57:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CFA021F383;
        Mon, 10 Jan 2022 16:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641833860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Q3VneSzRzr1tMKys6OuzhnqfTODjqh+I/QGvIA7t4c=;
        b=sjrJdQfK5ogRfjLj7zf+oKJm3J8qz0ZUW3JBjqps4bf+8+lgdxW0cNaMnBuIk7OaEZdt2d
        vDuPgoJosJ++R+M8b9H236s8QmjpGCeQRBSj/MeNWcOLNOeAYIDIu0KKpJ2iJnGPn1ba8b
        LQVCeMQWyiwofj/Lp3jt7kKerFGu0tM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F0CD9A3B8F;
        Mon, 10 Jan 2022 16:57:39 +0000 (UTC)
Date:   Mon, 10 Jan 2022 17:57:39 +0100
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
Message-ID: <Ydxlg5rI4ZvODQvF@dhcp22.suse.cz>
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

Why do you need to check for moving_account?
-- 
Michal Hocko
SUSE Labs
