Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ECE48743B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346094AbiAGInw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:43:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53456 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiAGInw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:43:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9EA401F397;
        Fri,  7 Jan 2022 08:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641545030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mYtWK3NjT/UMmQ55+kFPwDq0jgmChClDh7F4/L21/cg=;
        b=YjEOoNH3Kz7vCj9nZzBnWrSqxmPAX5BADwKrCLPBT7WuKbNGJ9ZoGm7EcmPJ+NJgu52cY6
        7S1uWr8Ta1jBdcqrG1mu8nhJx964JLT2GlfgzwgYY+IzLQ+zCjC9UIX0p05Iem5PcLWzoi
        ml2V+klUHBrUb2L89YCp3fWCSC0aFwc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6E757A3B8B;
        Fri,  7 Jan 2022 08:43:49 +0000 (UTC)
Date:   Fri, 7 Jan 2022 09:43:49 +0100
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
Message-ID: <Ydf9RXPch5ddg/WC@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcTkrl84Xzg2dSz@dhcp22.suse.cz>
 <Ydde2F4Oi0wKx//y@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydde2F4Oi0wKx//y@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-01-22 14:27:52, Yu Zhao wrote:
> On Thu, Jan 06, 2022 at 05:06:42PM +0100, Michal Hocko wrote:
[...]
> > > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > > index 2db9a1432511..9c7a4fae0661 100644
> > > --- a/include/linux/oom.h
> > > +++ b/include/linux/oom.h
> > > @@ -57,6 +57,22 @@ struct oom_control {
> > >  extern struct mutex oom_lock;
> > >  extern struct mutex oom_adj_mutex;
> > >  
> > > +#ifdef CONFIG_MMU
> > > +extern struct task_struct *oom_reaper_list;
> > > +extern struct wait_queue_head oom_reaper_wait;
> > > +
> > > +static inline bool oom_reaping_in_progress(void)
> > > +{
> > > +	/* a racy check can be used to reduce the chance of overkilling */
> > > +	return READ_ONCE(oom_reaper_list) || !waitqueue_active(&oom_reaper_wait);
> > > +}
> > > +#else
> > > +static inline bool oom_reaping_in_progress(void)
> > > +{
> > > +	return false;
> > > +}
> > > +#endif
> > 
> > I do not like this. These are internal oom reaper's and no code should
> > really make any decisions based on that. oom_reaping_in_progress is not
> > telling much anyway.
> 
> There is a perfectly legitimate reason for this.
> 
> If there is already a oom kill victim and the oom reaper is making
> progress, the system may still be under memory pressure until the oom
> reaping is done. The page reclaim has two choices in this transient
> state: kill more processes or keep reclaiming (a few more) hot pages.
> 
> The first choice, AKA overkilling, is generally a bad one. The oom
> reaper is single threaded and it can't go faster with additional
> victims. Additional processes are sacrificed for nothing -- this is
> an overcorrection of a system that tries to strike a balance between
> the tendencies to release memory pressure and to improve memory
> utilization.
> 
> > This is a global queue for oom reaper that can
> > contain oom victims from different oom scopes (e.g. global OOM, memcg
> > OOM or memory policy OOM).
> 
> True, but this is a wrong reason to make the conclusion below. Oom
> kill scopes do NOT matter; only the pool the freed memory goes into
> does. And there is only one global pool free pages.
> 
> > Your lru_gen_age_node uses this to decide whether to trigger
> > out_of_memory and that is clearly wrong for the above reasons.
> 
> I hope my explanation above is clear enough. There is nothing wrong
> with the purpose and the usage of oom_reaping_in_progress(), and it
> has been well tested in the Arch Linux Zen kernel.

I disagree. An ongoing oom kill in one domain (say memcg A) shouldn't be
any base for any decisions in reclaim in other domain (say memcg B or
even a global reclaim). Those are fundamentally different conditions.

> Without it, overkills can be easily reproduced by the following simple
> script. That is additional oom kills happen to processes other than
> "tail".
> 
>   # enable zram
>   while true;
>   do
>       tail /dev/zero
>   done

I would be interested to hear more (care to send oom reports?).

> > out_of_memory is designed to skip over any action if there is an oom
> > victim pending from the oom domain (have a look at oom_evaluate_task).
> 
> Where exactly? Point me to the code please.
> 
> I don't see such a logic inside out_of_memory() or
> oom_evaluate_task(). Currently the only thing that could remotely
> prevent overkills is oom_lock. But it's inadequate.

OK, let me try to exaplain. The protocol is rather convoluted. Once the
oom killer is invoked it choses a victim to kill. oom_evaluate_task will
evaluate _all_ tasks from the oom respective domain (select_bad_process
which distinguishes memcg vs global oom kill and oom_cpuset_eligible for
the cpuset domains). If there is any pre-existing oom victim
(tsk_is_oom_victim) then the scan is aborted and the oom killer bails
out. OOM victim stops being considered as relevant once the oom reaper
manages to release its address space (or give up on the mmap_sem
contention) and sets MMF_OOM_SKIP flag for the mm.

That being said the out_of_memory automatically backs off and relies on
the oom reaper to process its queue.

Does it make more clear for you now?

> This is the entire pipeline:
> low on memory -> out_of_memory() -> oom_reaper() -> free memory
> 
> To avoid overkills, we need to consider the later half of it too.
> oom_reaping_in_progress() is exactly for this purpose.
> 
> > > +static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc,
> > > +		       unsigned long min_ttl)
> > > +{
> > > +	bool need_aging;
> > > +	long nr_to_scan;
> > > +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> > > +	int swappiness = get_swappiness(memcg);
> > > +	DEFINE_MAX_SEQ(lruvec);
> > > +	DEFINE_MIN_SEQ(lruvec);
> > > +
> > > +	if (mem_cgroup_below_min(memcg))
> > > +		return false;
> > 
> > mem_cgroup_below_min requires effective values to be calculated for the
> > reclaimed hierarchy. Have a look at mem_cgroup_calculate_protection
> 
> I always keep that in mind, and age_lruvec() is called *after*
> mem_cgroup_calculate_protection():

>   balance_pgdat()
>     memcgs_need_aging = 0
>     do {
>       lru_gen_age_node()
>         if (!memcgs_need_aging) {
>             memcgs_need_aging = 1
>             return
>         }
>         age_lruvec()
> 
>       shrink_node_memcgs()
>         mem_cgroup_calculate_protection()
>         lru_gen_shrink_lruvec()
>           if ...
>             memcgs_need_aging = 0
>     } while ...

Uff, this is really subtle. I really think you should be following the
existing pattern when the effective values are calculated right in the
same context as they are evaluated.
-- 
Michal Hocko
SUSE Labs
