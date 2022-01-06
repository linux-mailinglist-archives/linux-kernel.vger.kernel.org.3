Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F0B486751
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbiAFQGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:06:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52142 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiAFQGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:06:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 19C65210FC;
        Thu,  6 Jan 2022 16:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641485207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RtoCfNAhUTMD7n6fEJCAHly/WPU+7j3b+mlIU1gzqng=;
        b=uI39ZR/8sDfX53S41ZinBWBnL/XbeSWkHXP4pRymICOw/8hpvqRvWAuLgIeSIpRnesZ6Ob
        Jm3gRwp8M6MmgiR3DAqbbcRENm6jsEuhc1Lb5+FG8J7aQV8/XGdRu96NillSuyFK4DG8dd
        tmyYNALcMjS7AIuGuRoocWCb90JZTPs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 02BE6A3B83;
        Thu,  6 Jan 2022 16:06:45 +0000 (UTC)
Date:   Thu, 6 Jan 2022 17:06:42 +0100
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
Message-ID: <YdcTkrl84Xzg2dSz@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104202227.2903605-7-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am still reading through the series. It is a lot of code and quite
hard to wrap ones head around so these are mostly random things I have
run into. More will likely follow up.

On Tue 04-01-22 13:22:25, Yu Zhao wrote:
[...]
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index aba18cd101db..028afdb81c10 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1393,18 +1393,24 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>  
>  static inline void lock_page_memcg(struct page *page)
>  {
> +	/* to match folio_memcg_rcu() */
> +	rcu_read_lock();
>  }
>  
>  static inline void unlock_page_memcg(struct page *page)
>  {
> +	rcu_read_unlock();
>  }
>  
>  static inline void folio_memcg_lock(struct folio *folio)
>  {
> +	/* to match folio_memcg_rcu() */
> +	rcu_read_lock();
>  }
>  
>  static inline void folio_memcg_unlock(struct folio *folio)
>  {
> +	rcu_read_unlock();
>  }

This should go into a separate patch and merge it independently. I
haven't really realized that !MEMCG configuration has a different
locking scopes.

[...]
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 2db9a1432511..9c7a4fae0661 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -57,6 +57,22 @@ struct oom_control {
>  extern struct mutex oom_lock;
>  extern struct mutex oom_adj_mutex;
>  
> +#ifdef CONFIG_MMU
> +extern struct task_struct *oom_reaper_list;
> +extern struct wait_queue_head oom_reaper_wait;
> +
> +static inline bool oom_reaping_in_progress(void)
> +{
> +	/* a racy check can be used to reduce the chance of overkilling */
> +	return READ_ONCE(oom_reaper_list) || !waitqueue_active(&oom_reaper_wait);
> +}
> +#else
> +static inline bool oom_reaping_in_progress(void)
> +{
> +	return false;
> +}
> +#endif

I do not like this. These are internal oom reaper's and no code should
really make any decisions based on that. oom_reaping_in_progress is not
telling much anyway. This is a global queue for oom reaper that can
contain oom victims from different oom scopes (e.g. global OOM, memcg
OOM or memory policy OOM).

Your lru_gen_age_node uses this to decide whether to trigger
out_of_memory and that is clearly wrong for the above reasons.
out_of_memory is designed to skip over any action if there is an oom
victim pending from the oom domain (have a look at oom_evaluate_task).

[...]

> +static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc,
> +		       unsigned long min_ttl)
> +{
> +	bool need_aging;
> +	long nr_to_scan;
> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> +	int swappiness = get_swappiness(memcg);
> +	DEFINE_MAX_SEQ(lruvec);
> +	DEFINE_MIN_SEQ(lruvec);
> +
> +	if (mem_cgroup_below_min(memcg))
> +		return false;

mem_cgroup_below_min requires effective values to be calculated for the
reclaimed hierarchy. Have a look at mem_cgroup_calculate_protection
-- 
Michal Hocko
SUSE Labs
