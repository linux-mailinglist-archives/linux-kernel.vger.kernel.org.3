Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E14C4ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbiBYQe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbiBYQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:34:55 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA881B3A5E;
        Fri, 25 Feb 2022 08:34:21 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 27so5071751pgk.10;
        Fri, 25 Feb 2022 08:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w9ONRF3LnEjzRXwDeX5/dgWHTBakSxQva8h6bFJPXRg=;
        b=QuPO27RcxYGrxzbPYRlTKiJm/trQaVsIAYVTA4EzmEQWrAVc0i1y9ovgG+3gKwjy8T
         i4QsAmrGCixaEPnxIXj84jZPYLgoPFrG6HIDgdfOtE2qsyh/ymJN2BzmUaxltS1lqFEX
         Krpm+2VWaDQJpxf1p3xAaqMVSsXfWkVPzaGm7zrqzUWd9qbZbZTfJEhJMgXyby9OCNOh
         LCbHu2ZRY+7vvcuKZNyLY+HaogXD9IXn1t1u6bUyl0nIsL05fstbKUshqEIuw6Bj/1mG
         7SN2fDfdc88o2hF1PUWHhiC6DAjKtyhpzghutkyXxnKJ/B8/jXV62xX5oCM9oYXUaQNX
         SR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=w9ONRF3LnEjzRXwDeX5/dgWHTBakSxQva8h6bFJPXRg=;
        b=4eB1MTyrNCxQS8nXneEgcM8ghsHL+7odeNwlK2XxUH3p+FJiZpqdvu7ex+Z5RiEkQs
         Cx/gvWurVv+P1PRn+JCWhBZdR0VIqDVLD9R5XGVfhtxaNnJFpplJvzFwlmkgNjWj0cT2
         ZpNqsm9HCTGjdk90Brs7gU4+7E45GTLvP1fcS3mO3oaqScamYwi1qRwIb9Vk4xLyIVKf
         yurwLPwUMO0kZ+O6AWuduoTSdIIkpE+UTG2213Akf0xGbF/dzCpe92u0lZs0ktrEVTuH
         QjQUQZvjUCyBE1mlstlepVCEmyHw5UDng5mhzBNpZjSQx7W3VIj4avlW0ZsrLK5snjIc
         MqjQ==
X-Gm-Message-State: AOAM533cz3gdlmBmC7vBoQpHf/kF60rd8lUq/O5dLIAFLge1q2VEtEhQ
        j7QwT/+SmAowEA0hUsLM790=
X-Google-Smtp-Source: ABdhPJy8ivjHdNQtpIfaHbaST89z2wqO+z9AIVnTkY8udajQgZHJHyvIfs1oFtwBp/XRgfgalpJ6Xw==
X-Received: by 2002:a05:6a00:279e:b0:4ca:91aa:32ce with SMTP id bd30-20020a056a00279e00b004ca91aa32cemr8432848pfb.36.1645806860249;
        Fri, 25 Feb 2022 08:34:20 -0800 (PST)
Received: from google.com ([2620:15c:211:201:a54b:cc05:819:d032])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090a8d8400b001bc386dc44bsm9907630pjo.23.2022.02.25.08.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:34:19 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 25 Feb 2022 08:34:16 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        the arch/x86 maintainers <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
Message-ID: <YhkFCB736pMA0sel@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-5-yuzhao@google.com>
 <YgV4lZXc6+jhUdsR@cmpxchg.org>
 <Ygt1qaQM5YobEZK9@google.com>
 <Ygwg9NXzQ+6U3RON@cmpxchg.org>
 <YhNJ4LVWpmZgLh4I@google.com>
 <CAOUHufbJuh1esDyhepAxX03GOqXeE4a1+1Z8QUsSqnznv7QAHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufbJuh1esDyhepAxX03GOqXeE4a1+1Z8QUsSqnznv7QAHw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 02:18:24PM -0700, Yu Zhao wrote:
> .
> On Mon, Feb 21, 2022 at 1:14 AM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Tue, Feb 15, 2022 at 04:53:56PM -0500, Johannes Weiner wrote:
> > > Hi Yu,
> > >
> > > On Tue, Feb 15, 2022 at 02:43:05AM -0700, Yu Zhao wrote:
> > > > On Thu, Feb 10, 2022 at 03:41:57PM -0500, Johannes Weiner wrote:
> > > > > > +static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
> > > > > > +{
> > > > > > +       unsigned long max_seq = lruvec->lrugen.max_seq;
> > > > > > +
> > > > > > +       VM_BUG_ON(gen >= MAX_NR_GENS);
> > > > > > +
> > > > > > +       /* see the comment on MIN_NR_GENS */
> > > > > > +       return gen == lru_gen_from_seq(max_seq) || gen == lru_gen_from_seq(max_seq - 1);
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
> >
> > > It would be good to capture that as well in a comment on the function.
> >
> > Will do.
> >
> > > > > > +static inline void lru_gen_update_size(struct lruvec *lruvec, enum lru_list lru,
> > > > > > +                                      int zone, long delta)
> > > > > > +{
> > > > > > +       struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> > > > > > +
> > > > > > +       lockdep_assert_held(&lruvec->lru_lock);
> > > > > > +       WARN_ON_ONCE(delta != (int)delta);
> > > > > > +
> > > > > > +       __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, delta);
> > > > > > +       __mod_zone_page_state(&pgdat->node_zones[zone], NR_ZONE_LRU_BASE + lru, delta);
> > > > > > +}
> > > > >
> > > > > This is a duplicate of update_lru_size(), please use that instead.
> > > > >
> > > > > Yeah technically you don't need the mem_cgroup_update_lru_size() but
> > > > > that's not worth sweating over, better to keep it simple.
> > > >
> > > > I agree we don't need the mem_cgroup_update_lru_size() -- let me spell
> > > > out why:
> > > >   this function is not needed here because it updates the counters used
> > > >   only by the active/inactive lru code, i.e., get_scan_count().
> > > >
> > > > However, we can't reuse update_lru_size() because MGLRU can trip the
> > > > WARN_ONCE() in mem_cgroup_update_lru_size().
> > > >
> > > > Unlike lru_zone_size[], lrugen->nr_pages[] is eventually consistent.
> > > > To move a page to a different generation, the gen counter in page->flags
> > > > is updated first, which doesn't require the LRU lock. The second step,
> > > > i.e., the update of lrugen->nr_pages[], requires the LRU lock, and it
> > > > usually isn't done immediately due to batching. Meanwhile, if this page
> > > > is, for example, isolated, nr_pages[] becomes temporarily unbalanced.
> > > > And this trips the WARN_ONCE().
> > >
> > > Good insight.
> > >
> > > But in that case, I'd still think it's better to use update_lru_size()
> > > and gate the memcg update on lrugen-enabled, with a short comment
> > > saying that lrugen has its own per-cgroup counts already. It's just a
> > > bit too error prone to duplicate the stat updates.
> > >
> > > Even better would be:
> > >
> > > static __always_inline
> > > void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
> > > {
> > >       enum lru_list lru = folio_lru_list(folio);
> > >
> > >       update_lru_size(lruvec, lru, folio_zonenum(folio),
> > >                       folio_nr_pages(folio));
> > >       if (lrugen_enabled(lruvec))
> > >               lrugen_add_folio(lruvec, folio);
> > >       else
> > >               list_add(&folio->lru, &lruvec->lists[lru]);
> > > }
> > >
> > > But it does mean you'd have to handle unevictable pages. I'm reviewing
> > > from the position that mglru is going to supplant the existing reclaim
> > > algorithm in the long term, though, so being more comprehensive and
> > > eliminating special cases where possible is all-positive, IMO.
> > >
> > > Up to you. I'd only insist on reusing update_lru_size() at least.
> >
> > Will do.
> >
> > > > > > +static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
> > > > > > +{
> > > > > > +       int gen;
> > > > > > +       unsigned long old_flags, new_flags;
> > > > > > +       int type = folio_is_file_lru(folio);
> > > > > > +       int zone = folio_zonenum(folio);
> > > > > > +       struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > > > > > +
> > > > > > +       if (folio_test_unevictable(folio) || !lrugen->enabled)
> > > > > > +               return false;
> > > > >
> > > > > These two checks should be in the callsite and the function should
> > > > > return void. Otherwise you can't understand the callsite without
> > > > > drilling down into lrugen code, even if lrugen is disabled.
> > > >
> > > > I agree it's a bit of nuisance this way. The alternative is we'd need
> > > > ifdef or another helper at the call sites because lrugen->enabled is
> > > > specific to lrugen.
> > >
> > > Coming from memcg, my experience has been that when you have a compile
> > > time-optional MM extension like this, you'll sooner or later need a
> > > config-independent helper to gate callbacks in generic code. So I
> > > think it's a good idea to add one now.
> > >
> > > One of these?
> > >
> > > lruvec_on_lrugen()
> >
> > SGTM.
> >
> > Personally I'd reuse lru_gen_enabled(), by passing NULL/lruvec. But
> > my guess is you wouldn't like it.
> >
> > > lruvec_using_lrugen()
> > > lruvec_lrugen_enabled()
> > >
> > > lruvec_has_generations() :-)
> > >
> > > > > On that note, I think #1 is reintroducing a problem we have fixed
> > > > > before, which is trashing the workingset with a flood of use-once
> > > > > mmapped pages. It's the classic scenario where LFU beats LRU.
> > > > >
> > > > > Mapped streaming IO isn't very common, but it does happen. See these
> > > > > commits:
> > > > >
> > > > > dfc8d636cdb95f7b792d5ba8c9f3b295809c125d
> > > > > 31c0569c3b0b6cc8a867ac6665ca081553f7984c
> > > > > 645747462435d84c6c6a64269ed49cc3015f753d
> > > > >
> > > > > From the changelog:
> > > > >
> > > > >     The used-once mapped file page detection patchset.
> > > > >
> > > > >     It is meant to help workloads with large amounts of shortly used file
> > > > >     mappings, like rtorrent hashing a file or git when dealing with loose
> > > > >     objects (git gc on a bigger site?).
> > > > >
> > > > >     Right now, the VM activates referenced mapped file pages on first
> > > > >     encounter on the inactive list and it takes a full memory cycle to
> > > > >     reclaim them again.  When those pages dominate memory, the system
> > > > >     no longer has a meaningful notion of 'working set' and is required
> > > > >     to give up the active list to make reclaim progress.  Obviously,
> > > > >     this results in rather bad scanning latencies and the wrong pages
> > > > >     being reclaimed.
> > > > >
> > > > >     This patch makes the VM be more careful about activating mapped file
> > > > >     pages in the first place.  The minimum granted lifetime without
> > > > >     another memory access becomes an inactive list cycle instead of the
> > > > >     full memory cycle, which is more natural given the mentioned loads.
> > > > >
> > > > > Translating this to multigen, it seems fresh faults should really
> > > > > start on the second oldest rather than on the youngest generation, to
> > > > > get a second chance but without jeopardizing the workingset if they
> > > > > don't take it.
> > > >
> > > > This is a good point, and I had worked on a similar idea but failed
> > > > to measure its benefits. In addition to placing mmapped file pages in
> > > > older generations, I also tried placing refaulted anon pages in older
> > > > generations. My conclusion was that the initial LRU positions of NFU
> > > > pages are not a bottleneck for workloads I've tested. The efficiency
> > > > of testing/clearing the accessed bit is.
> > >
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
> >
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
> >
> > To move forward, I propose we look at it from a non-technical POV:
> > would we want to offer users an alternative trade off so that they can
> > have greater flexibility?
> >
> > > > And some applications are smart enough to leverage MADV_SEQUENTIAL.
> > > > In this case, MGLRU does place mmapped file pages in the oldest
> > > > generation.
> > >
> > > Yes, it makes sense to optimize when MADV_SEQUENTIAL is requested. But
> > > that hint isn't reliably there, so it matters that we don't do poorly
> > > when it's missing.
> >
> > Agreed.
> >
> > > > I have an oversimplified script that uses memcached to mimic a
> > > > non-streaming workload and fio a (mmapped) streaming workload:
> > >
> > > Looking at the paramters and observed behavior, let me say up front
> > > that this looks like a useful benchmark, but doesn't capture the
> > > scenario I was talking about above.
> > >
> > > For one, the presence of swapping in both kernels suggests that the
> > > "streaming IO" component actually has repeat access that could benefit
> > > from caching. Second, I would expect memcache is accessing its memory
> > > frequently and consistently, and so could withstand workingset
> > > challenges from streaming IO better than, say, a desktop environment.
> >
> > The fio workload is a real streaming workload, but the memcached
> > workload might have been too large to be a typical desktop workload.
> >
> > More below.
> >
> > > More on that below.
> > >
> > > >   1. With MADV_SEQUENTIAL, the non-streaming workload is about 5 times
> > > >      faster when using MGLRU. Somehow the baseline (rc3) swapped a lot.
> > > >      (It shouldn't, and I haven't figured out why.)
> > >
> > > Baseline swaps when there are cache refaults. This is regardless of
> > > the hint: you may say you're accessing these pages sequentially, but
> > > the refaults say you're reusing them, with a frequency that suggests
> > > they might be cacheable. So it tries to cache them.
> > >
> > > I'd be curious if that results in fio being faster, or whether it's
> > > all just pointless thrashing. Can you share the fio results too?
> >
> > More below.
> >
> > > We could patch baseline to prioritize MADV_SEQUENTIAL more, but...
> > >
> > > >   2. Without MADV_SEQUENTIAL, the non-streaming workload is about 1
> > > >      time faster when using MGLRU. Both MGLRU and the baseline swapped
> > > >      a lot.
> > >
> > > ...in practice I think this scenario will matter to a lot more users.
> >
> > I strongly feel we should prioritize what's advertised on a man page
> > over an unspecified (performance) behavior.
> >
> > > I would again be interested in the fio results.
> > >
> > > >            MADV_SEQUENTIAL    non-streaming ops/sec (memcached)
> > > >   rc3      yes                 292k
> > > >   rc3      no                  203k
> > > >   rc3+v7   yes                1967k
> > > >   rc3+v7   no                  436k
> 
> Appending a few notes on the baseline results:
> 1. Apparently FADV_DONTNEED rejects mmaped pages -- I found no reasons
> from the man page or the original commit why it should. I propose we
> remove the page_mapped() check in lru_deactivate_file_fn(). Adding
> Minchan to see how he thinks about this.

Hi Yu,

It's quite old code. I already forgot all the details. Maybe, I wanted t
minimize behavior changes since invalidate_inode_page already fiter mapped
pages out.

I don't have any strong reason not to move mapped pages for deactivation
but if we do, it would be better to move them into head of inactive list
instead of tail to give a promote chance  since other processes are still
mappping the page in their address space.

Thanks.
