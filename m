Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A78486BE1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244236AbiAFV2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244230AbiAFV2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:28:01 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B638BC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:28:00 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id x6so4682870iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eWXKe6ofHR5YtEe8ndfEgo9MmkCiJN00xcKWgTh/Pis=;
        b=BolcB8rWOsXln3zfSDdLRY0wY8sV7BCnJsuEW8CPCdM9aJ6RY9bTUa8knlVhmhYUt8
         NEQrSyQs08aIzjvdat/3newfT1mEmXsSrMZ6su0ICLx4aHSXiSB9u5zf9PRWihodxYV1
         +2iaeoZ1G7VaxI33AnURMolAn4S88Z0iu4FxK3d5Ek2Ky0bLhUCRMhP90iUt2NJLQmvJ
         o/cj5d3ivi9oK5yB5Z2Khq/l3hecz3coEcCOQxJfOszbMtlE3lYaweDMqpvIrxz7CeR8
         SLqCx+lmvrPt7RklREA3WFFi82Hak/gqh8NlDgUoL7QpkiwnJ2XOUckhKwtKkR+PEPpL
         pZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWXKe6ofHR5YtEe8ndfEgo9MmkCiJN00xcKWgTh/Pis=;
        b=IdCMNw5W1giXYM+0FqhOdmC5e4WC8Wi9wfOjFZLKyj4vCgImnsRF9bshXExomPB1o4
         rbIPwMNND2ADqFxGf961bK8AWqXvwXJ0M7rSLg3qvCxea3ct65SaKaMkbfn6HShUuaP0
         fs8gt4PlzmMbdBnS80vA9zp79zD41yJXSoMpQbPeHYXIhWsEFrDCfc6jZQfcUwoQuDQZ
         o0oyoWTHGWTBfg/hoDhvn9uwDoQejY0yAwMLScErJjytwXL6q4KmPQtFo+WxDNTsPVbj
         Vij2CLKpyq8UY8mNCe1GK7vj3EdMnnXtJ3WnD/EEyjhx6DpgEis+F4X+7ALRSTe5p29P
         JHuA==
X-Gm-Message-State: AOAM531WiBlDheSMZQ8dC8UbEB25z6xLm7iyV/St5T6mPeTN/jcIU4A3
        1/o0rBhXzyaWYDCNWqDghur5ZA==
X-Google-Smtp-Source: ABdhPJz3ylKxooCGfJpO0rKP+86X+4pj60biR0zjBJEL77j+Y9m/Z8ljRDcrsoM24gj56IOBzSZTYw==
X-Received: by 2002:a05:6602:2f0e:: with SMTP id q14mr4472905iow.75.1641504479938;
        Thu, 06 Jan 2022 13:27:59 -0800 (PST)
Received: from google.com ([2620:15c:183:200:2e0a:5e5e:fac:e07b])
        by smtp.gmail.com with ESMTPSA id o1sm1656628ilj.41.2022.01.06.13.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:27:56 -0800 (PST)
Date:   Thu, 6 Jan 2022 14:27:52 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <Ydde2F4Oi0wKx//y@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcTkrl84Xzg2dSz@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdcTkrl84Xzg2dSz@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 05:06:42PM +0100, Michal Hocko wrote:
> I am still reading through the series. It is a lot of code and quite
> hard to wrap ones head around so these are mostly random things I have
> run into. More will likely follow up.
> 
> On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> [...]
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index aba18cd101db..028afdb81c10 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1393,18 +1393,24 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
> >  
> >  static inline void lock_page_memcg(struct page *page)
> >  {
> > +	/* to match folio_memcg_rcu() */
> > +	rcu_read_lock();
> >  }
> >  
> >  static inline void unlock_page_memcg(struct page *page)
> >  {
> > +	rcu_read_unlock();
> >  }
> >  
> >  static inline void folio_memcg_lock(struct folio *folio)
> >  {
> > +	/* to match folio_memcg_rcu() */
> > +	rcu_read_lock();
> >  }
> >  
> >  static inline void folio_memcg_unlock(struct folio *folio)
> >  {
> > +	rcu_read_unlock();
> >  }
> 
> This should go into a separate patch and merge it independently. I
> haven't really realized that !MEMCG configuration has a different
> locking scopes.

Considered it done.

> > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > index 2db9a1432511..9c7a4fae0661 100644
> > --- a/include/linux/oom.h
> > +++ b/include/linux/oom.h
> > @@ -57,6 +57,22 @@ struct oom_control {
> >  extern struct mutex oom_lock;
> >  extern struct mutex oom_adj_mutex;
> >  
> > +#ifdef CONFIG_MMU
> > +extern struct task_struct *oom_reaper_list;
> > +extern struct wait_queue_head oom_reaper_wait;
> > +
> > +static inline bool oom_reaping_in_progress(void)
> > +{
> > +	/* a racy check can be used to reduce the chance of overkilling */
> > +	return READ_ONCE(oom_reaper_list) || !waitqueue_active(&oom_reaper_wait);
> > +}
> > +#else
> > +static inline bool oom_reaping_in_progress(void)
> > +{
> > +	return false;
> > +}
> > +#endif
> 
> I do not like this. These are internal oom reaper's and no code should
> really make any decisions based on that. oom_reaping_in_progress is not
> telling much anyway.

There is a perfectly legitimate reason for this.

If there is already a oom kill victim and the oom reaper is making
progress, the system may still be under memory pressure until the oom
reaping is done. The page reclaim has two choices in this transient
state: kill more processes or keep reclaiming (a few more) hot pages.

The first choice, AKA overkilling, is generally a bad one. The oom
reaper is single threaded and it can't go faster with additional
victims. Additional processes are sacrificed for nothing -- this is
an overcorrection of a system that tries to strike a balance between
the tendencies to release memory pressure and to improve memory
utilization.

> This is a global queue for oom reaper that can
> contain oom victims from different oom scopes (e.g. global OOM, memcg
> OOM or memory policy OOM).

True, but this is a wrong reason to make the conclusion below. Oom
kill scopes do NOT matter; only the pool the freed memory goes into
does. And there is only one global pool free pages.

> Your lru_gen_age_node uses this to decide whether to trigger
> out_of_memory and that is clearly wrong for the above reasons.

I hope my explanation above is clear enough. There is nothing wrong
with the purpose and the usage of oom_reaping_in_progress(), and it
has been well tested in the Arch Linux Zen kernel.

Without it, overkills can be easily reproduced by the following simple
script. That is additional oom kills happen to processes other than
"tail".

  # enable zram
  while true;
  do
      tail /dev/zero
  done

> out_of_memory is designed to skip over any action if there is an oom
> victim pending from the oom domain (have a look at oom_evaluate_task).

Where exactly? Point me to the code please.

I don't see such a logic inside out_of_memory() or
oom_evaluate_task(). Currently the only thing that could remotely
prevent overkills is oom_lock. But it's inadequate.

This is the entire pipeline:
low on memory -> out_of_memory() -> oom_reaper() -> free memory

To avoid overkills, we need to consider the later half of it too.
oom_reaping_in_progress() is exactly for this purpose.

> > +static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc,
> > +		       unsigned long min_ttl)
> > +{
> > +	bool need_aging;
> > +	long nr_to_scan;
> > +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> > +	int swappiness = get_swappiness(memcg);
> > +	DEFINE_MAX_SEQ(lruvec);
> > +	DEFINE_MIN_SEQ(lruvec);
> > +
> > +	if (mem_cgroup_below_min(memcg))
> > +		return false;
> 
> mem_cgroup_below_min requires effective values to be calculated for the
> reclaimed hierarchy. Have a look at mem_cgroup_calculate_protection

I always keep that in mind, and age_lruvec() is called *after*
mem_cgroup_calculate_protection():

  balance_pgdat()
    memcgs_need_aging = 0
    do {
      lru_gen_age_node()
        if (!memcgs_need_aging) {
            memcgs_need_aging = 1
            return
        }
        age_lruvec()

      shrink_node_memcgs()
        mem_cgroup_calculate_protection()
        lru_gen_shrink_lruvec()
          if ...
            memcgs_need_aging = 0
    } while ...
