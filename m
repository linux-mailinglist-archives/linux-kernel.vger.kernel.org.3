Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5304CC5FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiCCT1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiCCT1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:27:44 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722E91903EC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 11:26:58 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id c4so3107411vkq.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 11:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9roPuH2tx3VZLpttt9PGIKSr2H9nS87yUwVf8ZpC4jY=;
        b=SVBk+FPm9yCrNORmtJYPCFK30WzW0iSydGgXwyZuObP1OFyoJhclu5AaIQPIcHPwGt
         +zerKMc1wGsPoe+zzLGrBTYNPkUT/lmDp/rnq+A+fm9FeulpsDg+2u5X3zZ98YsYcxFh
         o/9bgEAI4ppHknK17cqK8M+C8pzzZUtS4G+qZUDEPsTiYC+71pP3BC3QVcZu6teYqucQ
         AchG6poAo7CIXhtckK7157vLRDnAPmnHaUUPdpAERrQP6VNxGW/8boys9L52x6svCF0u
         LhxXU0Ubm2R1G7FvuHVyh4sqh46Od/JyCp2Y1bJbPcZfYp24SnaOj23dL65xMRxHOnI8
         oVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9roPuH2tx3VZLpttt9PGIKSr2H9nS87yUwVf8ZpC4jY=;
        b=LcXa1LoygL5clQ2QKqTVW02GABDzlWnyJQMQB8K9digCE1GigMsOhM8kBAGbpXUriL
         ScWxchsz3bMrmsWmDGEDTPFSMgFFQyUEiEi6Car/u4/q7cd8ZOJ5O4V25RkSBAQylbD6
         QytWoDfLCh1OS8t2FQLiTXjb1kPzRI3fofk789ZZirjtPJPmrzK+LcApHmeyNQETe04b
         tLAH/tzVs7rqkFsQaWap3Tl3P02Ge0dwLWwf1/9sMMbqAOG2TKnvfl3Pzzaa11cMH1xP
         1BfgPZosT4s/9WAeSBW8LtzLvjSrn6L+Wsc+EB6HuXGrpxV+sZjk48gsMvVRFyD4rloV
         ouPA==
X-Gm-Message-State: AOAM5322mefZ3cN/bzHrq7C8q3j7glkkCL3JB6GmhSXJtKTLXGdi93uQ
        hg5t7LTxCxZC3h0s5EHI6pNn1egpnE3qo5GzQxRv+g==
X-Google-Smtp-Source: ABdhPJxfoZyn2zHTiO8LIAaIxrjaYYzVQf+YLG9oERFt/uzxdn12aRC7HrRHBk6UkFrUWV2nHo4CaM0QL7EAMTPWz3k=
X-Received: by 2002:a1f:314b:0:b0:331:fff6:a89e with SMTP id
 x72-20020a1f314b000000b00331fff6a89emr15939424vkx.26.1646335616895; Thu, 03
 Mar 2022 11:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com> <20220208081902.3550911-5-yuzhao@google.com>
 <YgV4lZXc6+jhUdsR@cmpxchg.org> <Ygt1qaQM5YobEZK9@google.com>
 <Ygwg9NXzQ+6U3RON@cmpxchg.org> <YhNJ4LVWpmZgLh4I@google.com> <YiDe6DcLGEfTTKD5@cmpxchg.org>
In-Reply-To: <YiDe6DcLGEfTTKD5@cmpxchg.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 3 Mar 2022 12:26:45 -0700
Message-ID: <CAOUHufYSAUT+t3bTUoNwXTpYPKX0N437m_WQoT79gzWYgnLY9A@mail.gmail.com>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 8:29 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hi Yu,
>
> On Mon, Feb 21, 2022 at 01:14:24AM -0700, Yu Zhao wrote:
> > On Tue, Feb 15, 2022 at 04:53:56PM -0500, Johannes Weiner wrote:
> > > On Tue, Feb 15, 2022 at 02:43:05AM -0700, Yu Zhao wrote:
> > > > On Thu, Feb 10, 2022 at 03:41:57PM -0500, Johannes Weiner wrote:
> > > > > > +static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
> > > > > > +{
> > > > > > +     unsigned long max_seq = lruvec->lrugen.max_seq;
> > > > > > +
> > > > > > +     VM_BUG_ON(gen >= MAX_NR_GENS);
> > > > > > +
> > > > > > +     /* see the comment on MIN_NR_GENS */
> > > > > > +     return gen == lru_gen_from_seq(max_seq) || gen == lru_gen_from_seq(max_seq - 1);
> > > > > > +}
> > > > >
> > > > > I'm still reading the series, so correct me if I'm wrong: the "active"
> > > > > set is split into two generations for the sole purpose of the
> > > > > second-chance policy for fresh faults, right?
> > > >
> > > > To be precise, the active/inactive notion on top of generations is
> > > > just for ABI compatibility, e.g., the counters in /proc/vmstat.
> > > > Otherwise, this function wouldn't be needed.
> > >
> > > Ah! would you mind adding this as a comment to the function?
> >
> > Will do.
> >
> > > But AFAICS there is the lru_gen_del_folio() callsite that maps it to
> > > the PG_active flag - which in turn gets used by add_folio() to place
> > > the thing back on the max_seq generation. So I suppose there is a
> > > secondary purpose of the function for remembering the page's rough age
> > > for non-reclaim isolation.>
> >
> > Yes, e.g., migration.
>
> Ok, thanks for clarifying. That should also be in the comment.

Thanks. Will do.

> On scan resistance:
>
> > > The concern isn't the scan overhead, but jankiness from the workingset
> > > being flooded out by streaming IO.
> >
> > Yes, MGLRU uses a different approach to solve this problem, and for
> > its approach, the scan overhead is the concern.
> >
> > MGLRU detects (defines) the working set by scanning the entire memory
> > for each generation, and it counters the flooding by accelerating the
> > creation of generations. IOW, all mapped pages have an equal chance to
> > get scanned, no matter which generation they are in. This is a design
> > difference compared with the active/inactive LRU, which tries to scans
> > the active/inactive lists less/more frequently.
> >
> > > The concrete usecase at the time was a torrent client hashing a
> > > downloaded file and thereby kicking out the desktop environment, which
> > > caused jankiness. The hashing didn't benefit from caching - the file
> > > wouldn't have fit into RAM anyway - so this was pointless to boot.
> > >
> > > Essentially, the tradeoff is this:
> > >
> > > 1) If you treat new pages as hot, you accelerate workingset
> > > transitions, but on the flipside you risk unnecessary refaults in
> > > running applications when those new pages are one-off.
> > >
> > > 2) If you take new pages with a grain of salt, you protect existing
> > > applications better from one-off floods, but risk refaults in NEW
> > > application while they're trying to start up.
> >
> > Agreed.
> >
> > > There are two arguments for why 2) is preferable:
> > >
> > > 1) Users are tolerant of cache misses when applications first launch,
> > >    much less so after they've been running for hours.
> >
> > Our CUJs (Critical User Journeys) respectfully disagree :)
> >
> > They are built on the observation that once users have moved onto
> > another tab/app, they are more likely to stay with the new tab/app
> > rather than go back to the old ones. Speaking for myself, this is
> > generally the case.
>
> That's in line with what I said. Where is the disagreement?

Probably I've misinterpreted what you meant. The reasoning behind 1)
sounds to me like:
Cache misses of existing apps are more detrimental to user experience,
and therefore we choose to sacrifice the performance of newly launched
apps to avoid flooding.

My argument is that (phone/laptop/desktop) users usually care more
about the performance of newly launched apps -- this sounds a
contradiction of  what 1) says -- and therefore sacrificing the
performance of newly launched apps is not generally a good idea.

> > > 2) Workingset transitions (and associated jankiness) are bounded by
> > >    the amount of RAM you need to repopulate. But streaming IO is
> > >    bounded by storage, and datasets are routinely several times the
> > >    amount of RAM. Uncacheable sets in excess of RAM can produce an
> > >    infinite stream of "new" references; not protecting the workingset
> > >    from that means longer or even sustained jankiness.
> >
> > I'd argue the opposite -- we shouldn't risk refaulting fresh hot pages
> > just to accommodate this concrete yet minor use case, especially
> > considering torrent has been given the means (MADV_SEQUENTIAL) to help
> > itself.
> >
> > I appreciate all your points here. The bottom line is we agree this is
> > a trade off. For what disagree about, we could be both right -- it
> > comes down to what workloads we care about *more*.
>
> It's a straight-forward question: How does MGLRU avoid cache pollution
> from scans?
>
> Your answer above seems to be "it just does". Your answer here seems
> to be "it doesn't, but it doesn't matter". Forgive me if I'm
> misreading what you're saying.

This might have gotten lost. At the beginning, I explained:

> > Yes, MGLRU uses a different approach to solve this problem, and for
> > its approach, the scan overhead is the concern.
> >
> > MGLRU detects (defines) the working set by scanning the entire memory
> > for each generation, and it counters the flooding by accelerating the
> > creation of generations. IOW, all mapped pages have an equal chance to
> > get scanned, no matter which generation they are in. This is a design
> > difference compared with the active/inactive LRU, which tries to scan
> > the active/inactive lists less/more frequently.

To summarize: MGLRU counteracts flooding by shortening the time
interval that defines an entire working set. In contrast, the
active/inactive LRU uses a longer time interval for the active
(established working set) and a shorter one for the inactive (flood or
new working set).

> But it's not a minor concern.

This depends on the POV :)

For what workloads I care about more, i.e., the majority of
phone/laptop/desktop users and top open-source memory hogs running on
servers, I've heard no complaints (yet).

> Read the motivation behind any modern
> cache algorithm - ARC, LIRS, Clock-Pro, LRU-K, 2Q - and scan
> resistance is the reason for why they all exist in the first place.

I agree that flooding is a concern (major from your POV; minor from my
POV). I assume that you agree that the solution is always a tradeoff.
I'm merely suggesting both tradeoffs I summarized above have their
merits and we shouldn't put all eggs in one bucket.

>     "The LRU-K algorithm surpasses conventional buffering algorithms
>      in discriminating between frequently and infrequently referenced
>      pages."
>
>         - The LRU-K page replacement algorithm for database disk
>           buffering, O'Neil et al, 1993
>
>     "Although LRU replacement policy has been commonly used in the
>      buffer cache management, it is well known for its inability to
>      cope with access patterns with weak locality."
>
>         - LIRS: an efficient low inter-reference recency set
>          replacement policy to improve buffer cache performance,
>          Jiang, Zhang, 2002
>
>     "The self-tuning, low-overhead, scan-resistant adaptive
>      replacement cache algorithm outperforms the least-recently-used
>      algorithm by dynamically responding to changing access patterns
>      and continually balancing between workload recency and frequency
>      features."
>
>         - Outperforming LRU with an adaptive replacement cache
>           algorithm, Megiddo, Modha, 2004
>
>     "Over the last three decades, the inability of LRU as well as
>      CLOCK to handle weak locality accesses has become increasingly
>      serious, and an effective fix becomes increasingly desirable.
>
>         - CLOCK-Pro: An Effective Improvement of the CLOCK
>           Replacement, Jiang et al, 2005
>
>
> We can't rely on MADV_SEQUENTIAL alone.

Agreed.

> Not all accesses know in
> advance that they'll be one-off; it can be a group of uncoordinated
> tasks causing the pattern etc.

For what we know, MADV_SEQUENTIAL can be a solution. There are things
we don't know, hence the "agreed" above :)

> This is a pretty fundamental issue.

Agreed.

My points are:
1. The practice value of this fundamental issue (minor or major).
2. The merits of different tradeoffs (better or worse).

IMO, both depend on the POV.

> It would be good to get a more
> satisfying answer on this.

Agreed.

> > > > > You can drop the memcg parameter and use lruvec_memcg().
> > > >
> > > > lruvec_memcg() isn't available yet when pgdat_init_internals() calls
> > > > this function because mem_cgroup_disabled() is initialized afterward.
> > >
> > > Good catch. That'll container_of() into garbage. However, we have to
> > > assume that somebody's going to try that simplification again, so we
> > > should set up the code now to prevent issues.
> > >
> > > cgroup_disable parsing is self-contained, so we can pull it ahead in
> > > the init sequence. How about this?
> > >
> > > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > > index 9d05c3ca2d5e..b544d768edc8 100644
> > > --- a/kernel/cgroup/cgroup.c
> > > +++ b/kernel/cgroup/cgroup.c
> > > @@ -6464,9 +6464,9 @@ static int __init cgroup_disable(char *str)
> > >                     break;
> > >             }
> > >     }
> > > -   return 1;
> > > +   return 0;
> > >  }
> > > -__setup("cgroup_disable=", cgroup_disable);
> > > +early_param("cgroup_disable", cgroup_disable);
> >
> > I think early_param() is still after pgdat_init_internals(), no?
>
> It's called twice for some reason, but AFAICS the first one is always
> called before pgdat_init_internals():
>
> start_kernel()
>   setup_arch()
>     parse_early_param()
>     x86_init.paging.pagetable_init();
>       paging_init()
>         zone_sizes_init()
>           free_area_init()
>             free_area_init_node()
>               free_area_init_core()
>                 pgdat_init_internals()
>   parse_early_param()
>
> It's the same/similar for arm, sparc and mips.

Thanks for checking. But I'd rather live with an additional parameter
than risk breaking some archs.
