Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70929487E0D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiAGVMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiAGVMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:12:50 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8960C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:12:50 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p65so8716730iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/qENwt6av9FoqyUmbkRyUdLHXz0uXpkP35VFB8ZVzzE=;
        b=jfxGfDYOu0dSQMwGr5IAP4X9BaDPuiSk7xjdjsjCrFY2zC+35P/OcN51Cz8yi90OEE
         KFWp0IAy7GbW4Q/wXWeiYV7kmDEZNHZyD8zsQoMEHvWEBQLJGVTyxtTf1XjUfbFMB2bc
         9xhaA1U1RI4zDatJmBaugrtU1M0M1JXkQqZfc2HizWWiOYTOaBKZb4gKG2TuqHdEdyaD
         IrHpHSiL1Iqmiw2hBwl86qmbyuh+UsGjhmXBh1Ga7durRlVhyJYwjNKJcfBw6oXEiqdH
         RzJgxKMVEXHX428t1qnLUHMCx9Dhn5NzTNa83gIhlNFed58zS6pTKeA8ah2G63f5mZGQ
         wo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/qENwt6av9FoqyUmbkRyUdLHXz0uXpkP35VFB8ZVzzE=;
        b=4SV8jzBBOisAbXtevUFdz4crPiMIQ+bqPGPiFmtomhTqiwOVNReKb9ohhCqPGAB6U/
         o0tyTp5NTI0zezcL0yaJnpEWiCKeTGinVzERBYz5aX5X8AEguyPzKbhQc1He9xBKzn1X
         ItlQmDxYyp0mLYiwIv/1wMD3+g1vOSST1Id3DXRoTQkLpj93fnF129F5xn2hY0YOP1ZW
         mF83V6s5+IwFRdZDJTuU/jjZpP0Q1DRd5jCLLudfKv4Tek69ZkH4IOuvYTct9a0Pa0NY
         B7X8kdthUrAKxQU5vTGH2FwDPKgPmpFbLOlYqJLEqvfXFeu2u/FSW2yhG0DeFnjVZBoZ
         S7UA==
X-Gm-Message-State: AOAM530cGFFPYSfEYcoYVIbp+zEeInrkpPsztv6rIcckBon4M/3CFDX0
        Cx4OevMGqDMCYjcUgRi52ip/0Q==
X-Google-Smtp-Source: ABdhPJy0iyR/1W/D1Pa0d93wK2dzWbtMJCV8eAQVzix+/W1m+ArtGufnaVAl4z1KizTD7hp1ws8WOw==
X-Received: by 2002:a05:6602:330e:: with SMTP id b14mr28576817ioz.192.1641589969960;
        Fri, 07 Jan 2022 13:12:49 -0800 (PST)
Received: from google.com ([2620:15c:183:200:8b41:537d:f5d3:269c])
        by smtp.gmail.com with ESMTPSA id s12sm3485688ilv.88.2022.01.07.13.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:12:49 -0800 (PST)
Date:   Fri, 7 Jan 2022 14:12:45 -0700
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
Message-ID: <Ydisze9ZR/QBtjpX@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcTkrl84Xzg2dSz@dhcp22.suse.cz>
 <Ydde2F4Oi0wKx//y@google.com>
 <Ydf9RXPch5ddg/WC@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydf9RXPch5ddg/WC@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 09:43:49AM +0100, Michal Hocko wrote:
> On Thu 06-01-22 14:27:52, Yu Zhao wrote:
> > On Thu, Jan 06, 2022 at 05:06:42PM +0100, Michal Hocko wrote:
> [...]
> > > > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > > > index 2db9a1432511..9c7a4fae0661 100644
> > > > --- a/include/linux/oom.h
> > > > +++ b/include/linux/oom.h
> > > > @@ -57,6 +57,22 @@ struct oom_control {
> > > >  extern struct mutex oom_lock;
> > > >  extern struct mutex oom_adj_mutex;
> > > >  
> > > > +#ifdef CONFIG_MMU
> > > > +extern struct task_struct *oom_reaper_list;
> > > > +extern struct wait_queue_head oom_reaper_wait;
> > > > +
> > > > +static inline bool oom_reaping_in_progress(void)
> > > > +{
> > > > +	/* a racy check can be used to reduce the chance of overkilling */
> > > > +	return READ_ONCE(oom_reaper_list) || !waitqueue_active(&oom_reaper_wait);
> > > > +}
> > > > +#else
> > > > +static inline bool oom_reaping_in_progress(void)
> > > > +{
> > > > +	return false;
> > > > +}
> > > > +#endif
> > > 
> > > I do not like this. These are internal oom reaper's and no code should
> > > really make any decisions based on that. oom_reaping_in_progress is not
> > > telling much anyway.
> > 
> > There is a perfectly legitimate reason for this.
> > 
> > If there is already a oom kill victim and the oom reaper is making
> > progress, the system may still be under memory pressure until the oom
> > reaping is done. The page reclaim has two choices in this transient
> > state: kill more processes or keep reclaiming (a few more) hot pages.
> > 
> > The first choice, AKA overkilling, is generally a bad one. The oom
> > reaper is single threaded and it can't go faster with additional
> > victims. Additional processes are sacrificed for nothing -- this is
> > an overcorrection of a system that tries to strike a balance between
> > the tendencies to release memory pressure and to improve memory
> > utilization.
> > 
> > > This is a global queue for oom reaper that can
> > > contain oom victims from different oom scopes (e.g. global OOM, memcg
> > > OOM or memory policy OOM).
> > 
> > True, but this is a wrong reason to make the conclusion below. Oom
> > kill scopes do NOT matter; only the pool the freed memory goes into
> > does. And there is only one global pool free pages.
> > 
> > > Your lru_gen_age_node uses this to decide whether to trigger
> > > out_of_memory and that is clearly wrong for the above reasons.
> > 
> > I hope my explanation above is clear enough. There is nothing wrong
> > with the purpose and the usage of oom_reaping_in_progress(), and it
> > has been well tested in the Arch Linux Zen kernel.
> 
> I disagree. An ongoing oom kill in one domain (say memcg A) shouldn't be
> any base for any decisions in reclaim in other domain (say memcg B or
> even a global reclaim). Those are fundamentally different conditions.

I agree for the memcg A oom and memcg B reclaim case, because memory
freed from A doesn't go to B.

I still think for the memcg A and the global reclaim case, memory
freed from A can be considered when deciding whether to make more
kills during global reclaim.

But this is something really minor, and I'll go with your suggestion,
i.e., getting rid of oom_reaping_in_progress().

> > Without it, overkills can be easily reproduced by the following simple
> > script. That is additional oom kills happen to processes other than
> > "tail".
> > 
> >   # enable zram
> >   while true;
> >   do
> >       tail /dev/zero
> >   done
> 
> I would be interested to hear more (care to send oom reports?).

I agree with what said below. I think those additional ooms might have
been from different oom domains. I plan to leave this for now and go
with your suggestion as mentioned above.

> > > out_of_memory is designed to skip over any action if there is an oom
> > > victim pending from the oom domain (have a look at oom_evaluate_task).
> > 
> > Where exactly? Point me to the code please.
> > 
> > I don't see such a logic inside out_of_memory() or
> > oom_evaluate_task(). Currently the only thing that could remotely
> > prevent overkills is oom_lock. But it's inadequate.
> 
> OK, let me try to exaplain. The protocol is rather convoluted. Once the
> oom killer is invoked it choses a victim to kill. oom_evaluate_task will
> evaluate _all_ tasks from the oom respective domain (select_bad_process
> which distinguishes memcg vs global oom kill and oom_cpuset_eligible for
> the cpuset domains). If there is any pre-existing oom victim
> (tsk_is_oom_victim) then the scan is aborted and the oom killer bails
> out. OOM victim stops being considered as relevant once the oom reaper
> manages to release its address space (or give up on the mmap_sem
> contention) and sets MMF_OOM_SKIP flag for the mm.
> 
> That being said the out_of_memory automatically backs off and relies on
> the oom reaper to process its queue.
> 
> Does it make more clear for you now?

Yes, you are right, thanks.

> > This is the entire pipeline:
> > low on memory -> out_of_memory() -> oom_reaper() -> free memory
> > 
> > To avoid overkills, we need to consider the later half of it too.
> > oom_reaping_in_progress() is exactly for this purpose.
> > 
> > > > +static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc,
> > > > +		       unsigned long min_ttl)
> > > > +{
> > > > +	bool need_aging;
> > > > +	long nr_to_scan;
> > > > +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> > > > +	int swappiness = get_swappiness(memcg);
> > > > +	DEFINE_MAX_SEQ(lruvec);
> > > > +	DEFINE_MIN_SEQ(lruvec);
> > > > +
> > > > +	if (mem_cgroup_below_min(memcg))
> > > > +		return false;
> > > 
> > > mem_cgroup_below_min requires effective values to be calculated for the
> > > reclaimed hierarchy. Have a look at mem_cgroup_calculate_protection
> > 
> > I always keep that in mind, and age_lruvec() is called *after*
> > mem_cgroup_calculate_protection():
> 
> >   balance_pgdat()
> >     memcgs_need_aging = 0
> >     do {
> >       lru_gen_age_node()
> >         if (!memcgs_need_aging) {
> >             memcgs_need_aging = 1
> >             return
> >         }
> >         age_lruvec()
> > 
> >       shrink_node_memcgs()
> >         mem_cgroup_calculate_protection()
> >         lru_gen_shrink_lruvec()
> >           if ...
> >             memcgs_need_aging = 0
> >     } while ...
> 
> Uff, this is really subtle. I really think you should be following the
> existing pattern when the effective values are calculated right in the
> same context as they are evaluated.

Consider it done.
