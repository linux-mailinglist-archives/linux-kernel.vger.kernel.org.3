Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546364D5F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbiCKKR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiCKKR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:17:26 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69D21BF92A;
        Fri, 11 Mar 2022 02:16:22 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2dc28791ecbso87574927b3.4;
        Fri, 11 Mar 2022 02:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkTfrsFxHKDL5PJci+9RnNXTnKFy/ywF0+GKH6ksFvY=;
        b=JuyRDEhONKEytUlMx2Ihh8LDdxtQmIq63iPx7jupzGkSHMMGPxZuKD6gnl3cNxsIZW
         pITqYLTqPADWQKNRXhJNtSUgLpVSLP5XaW0V3g56NHCETZBX1PDae68A24qpwZPp1CtY
         eBcLDAeZZlG65Yq31oZ2L5B1dDSIHajuNTC2Gkt6pGuayho310SKgvWVQcOjdzC5MVoE
         ZSg/Vdt7hzMFtcfZZ/Qn5/gPW51S24l4JKf8AjT8DfslfU/xIq1A4EGlyG3/Fv3dweFB
         qCrjmQc6cFES9zL/hg+v3U3Wq3zp4fQlp7YVrMFUzRRF6K3n2ec2fWoWqhKXgEs+cNkK
         nYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkTfrsFxHKDL5PJci+9RnNXTnKFy/ywF0+GKH6ksFvY=;
        b=BEJGq4aitc2unQkKBaF+HN5pkMlmSasypeBPd1Abkg4J2olT2ow+zE4jYb/68v7D5b
         o/7jlms5oIdK4anfkE1NfNmgcgaxEZXx4EKM07wda2qH+l/yuJ9cVT4kn6ePcK8AWmdq
         ++NEsaMR47Z+nJyX8x2vPISIgiErcsTe0khXAn28PDibvz5LuqKRLnlJJojNbWXH1uMO
         X7LROX1SVxz1mcVGMoZGzxV6ACF4x/McsBtDEW5E4supe8Euhb7m3n+ZY7ipJQz2Zq93
         4I+IPrTyxRCzj2D2+KtWRAwpIKpR1x0QBUbEXqMfCiyykaD3R0obyCPU+hjJWvB9b18d
         pb3g==
X-Gm-Message-State: AOAM533rdMGKgLir1jLywsCu9bCyZDqBO+QqiyVde8BPwExyyJVviHXA
        cNo0JvjI4pXmyfkmghXe7/rK0xC3YkVeyQWuvLg=
X-Google-Smtp-Source: ABdhPJyhqcVMIUTVLB97rj1QIFNX2vU83Ttt5lI5RAPsUOHOLhmoFQxrnlYc4YG5Jg+MpsREGSODyrnnd5lwcNdwps0=
X-Received: by 2002:a0d:dcc3:0:b0:2d1:44a4:14be with SMTP id
 f186-20020a0ddcc3000000b002d144a414bemr7554462ywe.76.1646993781529; Fri, 11
 Mar 2022 02:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com> <20220208081902.3550911-5-yuzhao@google.com>
 <YgV4lZXc6+jhUdsR@cmpxchg.org> <Ygt1qaQM5YobEZK9@google.com>
In-Reply-To: <Ygt1qaQM5YobEZK9@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 11 Mar 2022 23:16:10 +1300
Message-ID: <CAGsJ_4wN_CAOsyR3LATE+EUhuV0gO-zhhNiMwEBwyXOp0CbkZg@mail.gmail.com>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
To:     Yu Zhao <yuzhao@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
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
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, page-reclaim@google.com,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 10:43 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Feb 10, 2022 at 03:41:57PM -0500, Johannes Weiner wrote:
>
> Thanks for reviewing.
>
> > > +static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
> > > +{
> > > +   unsigned long max_seq = lruvec->lrugen.max_seq;
> > > +
> > > +   VM_BUG_ON(gen >= MAX_NR_GENS);
> > > +
> > > +   /* see the comment on MIN_NR_GENS */
> > > +   return gen == lru_gen_from_seq(max_seq) || gen == lru_gen_from_seq(max_seq - 1);
> > > +}
> >
> > I'm still reading the series, so correct me if I'm wrong: the "active"
> > set is split into two generations for the sole purpose of the
> > second-chance policy for fresh faults, right?
>
> To be precise, the active/inactive notion on top of generations is
> just for ABI compatibility, e.g., the counters in /proc/vmstat.
> Otherwise, this function wouldn't be needed.

Hi Yu,
I am still quite confused as i am seeing both active/inactive and lru_gen.
eg:

root@ubuntu:~# cat /proc/vmstat | grep active
nr_zone_inactive_anon 22797
nr_zone_active_anon 578405
nr_zone_inactive_file 0
nr_zone_active_file 4156
nr_inactive_anon 22800
nr_active_anon 578574
nr_inactive_file 0
nr_active_file 4215

and:

root@ubuntu:~# cat /sys//kernel/debug/lru_gen

...
memcg    36 /user.slice/user-0.slice/user@0.service
 node     0
         20      18820         22           0
         21       7452          0           0
         22       7448          0           0
memcg    33 /user.slice/user-0.slice/user@0.service/app.slice
 node     0
          0    2171452          0           0
          1    2171452          0           0
          2    2171452          0           0
          3    2171452          0           0
memcg    37 /user.slice/user-0.slice/session-1.scope
 node     0
         42      51804     102127           0
         43      18840     275622           0
         44      16104     216805           1

Does it mean one page could be in both one of the generations and one
of the active/inactive lists?
Do we have some mapping relationship between active/inactive lists
with generations?


>
> > If so, it'd be better to have the comment here instead of down by
> > MIN_NR_GENS. This is the place that defines what "active" is, so this
> > is where the reader asks what it means and what it implies. The
> > definition of MIN_NR_GENS can be briefer: "need at least two for
> > second chance, see lru_gen_is_active() for details".
>
> This could be understood this way. It'd be more appropriate to see
> this function as an auxiliary and MIN_NR_GENS as something fundamental.
> Therefore the former should refer to the latter. Specifically, the
> "see the comment on MIN_NR_GENS" refers to this part:
>   And to be compatible with the active/inactive LRU, these two
>   generations are mapped to the active; the rest of generations, if
>   they exist, are mapped to the inactive.
>
> > > +static inline void lru_gen_update_size(struct lruvec *lruvec, enum lru_list lru,
> > > +                                  int zone, long delta)
> > > +{
> > > +   struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> > > +
> > > +   lockdep_assert_held(&lruvec->lru_lock);
> > > +   WARN_ON_ONCE(delta != (int)delta);
> > > +
> > > +   __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, delta);
> > > +   __mod_zone_page_state(&pgdat->node_zones[zone], NR_ZONE_LRU_BASE + lru, delta);
> > > +}
> >
> > This is a duplicate of update_lru_size(), please use that instead.
> >
> > Yeah technically you don't need the mem_cgroup_update_lru_size() but
> > that's not worth sweating over, better to keep it simple.
>
> I agree we don't need the mem_cgroup_update_lru_size() -- let me spell
> out why:
>   this function is not needed here because it updates the counters used
>   only by the active/inactive lru code, i.e., get_scan_count().
>
> However, we can't reuse update_lru_size() because MGLRU can trip the
> WARN_ONCE() in mem_cgroup_update_lru_size().
>
> Unlike lru_zone_size[], lrugen->nr_pages[] is eventually consistent.
> To move a page to a different generation, the gen counter in page->flags
> is updated first, which doesn't require the LRU lock. The second step,
> i.e., the update of lrugen->nr_pages[], requires the LRU lock, and it
> usually isn't done immediately due to batching. Meanwhile, if this page
> is, for example, isolated, nr_pages[] becomes temporarily unbalanced.
> And this trips the WARN_ONCE().
>
> <snipped>
>
> >       /* Promotion */
> > > +   if (!lru_gen_is_active(lruvec, old_gen) && lru_gen_is_active(lruvec, new_gen)) {
> > > +           lru_gen_update_size(lruvec, lru, zone, -delta);
> > > +           lru_gen_update_size(lruvec, lru + LRU_ACTIVE, zone, delta);
> > > +   }
> > > +
> > > +   /* Promotion is legit while a page is on an LRU list, but demotion isn't. */
> >
> >       /* Demotion happens during aging when pages are isolated, never on-LRU */
> > > +   VM_BUG_ON(lru_gen_is_active(lruvec, old_gen) && !lru_gen_is_active(lruvec, new_gen));
> > > +}
> >
> > On that note, please move introduction of the promotion and demotion
> > bits to the next patch. They aren't used here yet, and I spent some
> > time jumping around patches to verify the promotion callers and
> > confirm the validy of the BUG_ON.
>
> Will do.
>
> > > +static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
> > > +{
> > > +   int gen;
> > > +   unsigned long old_flags, new_flags;
> > > +   int type = folio_is_file_lru(folio);
> > > +   int zone = folio_zonenum(folio);
> > > +   struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > > +
> > > +   if (folio_test_unevictable(folio) || !lrugen->enabled)
> > > +           return false;
> >
> > These two checks should be in the callsite and the function should
> > return void. Otherwise you can't understand the callsite without
> > drilling down into lrugen code, even if lrugen is disabled.
>
> I agree it's a bit of nuisance this way. The alternative is we'd need
> ifdef or another helper at the call sites because lrugen->enabled is
> specific to lrugen.
>
> > > +   /*
> > > +    * There are three common cases for this page:
> > > +    * 1) If it shouldn't be evicted, e.g., it was just faulted in, add it
> > > +    *    to the youngest generation.
> >
> > "shouldn't be evicted" makes it sound like mlock. But they should just
> > be evicted last, right? Maybe:
> >
> >       /*
> >        * Pages start in different generations depending on
> >        * advance knowledge we have about their hotness and
> >        * evictability:
> >        *
> >        * 1. Already active pages start out youngest. This can be
> >        *    fresh faults, or refaults of previously hot pages.
> >        * 2. Cold pages that require writeback before becoming
> >        *    evictable start on the second oldest generation.
> >        * 3. Everything else (clean, cold) starts old.
> >        */
>
> Will do.
>
> > On that note, I think #1 is reintroducing a problem we have fixed
> > before, which is trashing the workingset with a flood of use-once
> > mmapped pages. It's the classic scenario where LFU beats LRU.
> >
> > Mapped streaming IO isn't very common, but it does happen. See these
> > commits:
> >
> > dfc8d636cdb95f7b792d5ba8c9f3b295809c125d
> > 31c0569c3b0b6cc8a867ac6665ca081553f7984c
> > 645747462435d84c6c6a64269ed49cc3015f753d
> >
> > From the changelog:
> >
> >     The used-once mapped file page detection patchset.
> >
> >     It is meant to help workloads with large amounts of shortly used file
> >     mappings, like rtorrent hashing a file or git when dealing with loose
> >     objects (git gc on a bigger site?).
> >
> >     Right now, the VM activates referenced mapped file pages on first
> >     encounter on the inactive list and it takes a full memory cycle to
> >     reclaim them again.  When those pages dominate memory, the system
> >     no longer has a meaningful notion of 'working set' and is required
> >     to give up the active list to make reclaim progress.  Obviously,
> >     this results in rather bad scanning latencies and the wrong pages
> >     being reclaimed.
> >
> >     This patch makes the VM be more careful about activating mapped file
> >     pages in the first place.  The minimum granted lifetime without
> >     another memory access becomes an inactive list cycle instead of the
> >     full memory cycle, which is more natural given the mentioned loads.
> >
> > Translating this to multigen, it seems fresh faults should really
> > start on the second oldest rather than on the youngest generation, to
> > get a second chance but without jeopardizing the workingset if they
> > don't take it.
>
> This is a good point, and I had worked on a similar idea but failed
> to measure its benefits. In addition to placing mmapped file pages in
> older generations, I also tried placing refaulted anon pages in older
> generations. My conclusion was that the initial LRU positions of NFU
> pages are not a bottleneck for workloads I've tested. The efficiency
> of testing/clearing the accessed bit is.
>
> And some applications are smart enough to leverage MADV_SEQUENTIAL.
> In this case, MGLRU does place mmapped file pages in the oldest
> generation.
>
> I have an oversimplified script that uses memcached to mimic a
> non-streaming workload and fio a (mmapped) streaming workload:
>   1. With MADV_SEQUENTIAL, the non-streaming workload is about 5 times
>      faster when using MGLRU. Somehow the baseline (rc3) swapped a lot.
>      (It shouldn't, and I haven't figured out why.)
>   2. Without MADV_SEQUENTIAL, the non-streaming workload is about 1
>      time faster when using MGLRU. Both MGLRU and the baseline swapped
>      a lot.
>
>            MADV_SEQUENTIAL    non-streaming ops/sec (memcached)
>   rc3      yes                 292k
>   rc3      no                  203k
>   rc3+v7   yes                1967k
>   rc3+v7   no                  436k
>
>   cat mmap.sh
>   modprobe brd rd_nr=2 rd_size=56623104
>
>   mkswap /dev/ram0
>   swapon /dev/ram0
>
>   mkfs.ext4 /dev/ram1
>   mount -t ext4 /dev/ram1 /mnt
>
>   memtier_benchmark -S /var/run/memcached/memcached.sock -P memcache_binary \
>     -n allkeys --key-minimum=1 --key-maximum=50000000 --key-pattern=P:P -c 1 \
>     -t 36 --ratio 1:0 --pipeline 8 -d 2000
>
>   # streaming workload: --fadvise_hint=0 disables MADV_SEQUENTIAL
>   fio -name=mglru --numjobs=12 --directory=/mnt --size=4224m --buffered=1 \
>     --ioengine=mmap --iodepth=128 --iodepth_batch_submit=32 \
>     --iodepth_batch_complete=32 --rw=read --time_based --ramp_time=10m \
>     --runtime=180m --group_reporting &
>   pid=$!
>
>   sleep 200
>
>   # non-streaming workload
>   memtier_benchmark -S /var/run/memcached/memcached.sock -P memcache_binary \
>     -n allkeys --key-minimum=1 --key-maximum=50000000 --key-pattern=R:R \
>     -c 1 -t 36 --ratio 0:1 --pipeline 8 --randomize --distinct-client-seed
>
>   kill -INT $pid
>   wait

We used to put a faulted file page in inactive, if we access it a
second time, it can be promoted
to active. then in recent years, we have also applied this to anon
pages while kernel adds
workingset protection for anon pages. so basically both anon and file
pages go into the inactive
list for the 1st time, if we access it for the second time, they go to
the active list. if we don't access
it any more, they are likely to be reclaimed as they are inactive.
we do have some special fastpath for code section, executable file
pages are kept on active list
as long as they are accessed.

so all of the above concerns are actually not that correct?


>
> > > +    * 2) If it can't be evicted immediately, i.e., it's an anon page and
> > > +    *    not in swapcache, or a dirty page pending writeback, add it to the
> > > +    *    second oldest generation.
> > > +    * 3) If it may be evicted immediately, e.g., it's a clean page, add it
> > > +    *    to the oldest generation.
> > > +    */
> > > +   if (folio_test_active(folio))
> > > +           gen = lru_gen_from_seq(lrugen->max_seq);
> > > +   else if ((!type && !folio_test_swapcache(folio)) ||
> > > +            (folio_test_reclaim(folio) &&
> > > +             (folio_test_dirty(folio) || folio_test_writeback(folio))))
> > > +           gen = lru_gen_from_seq(lrugen->min_seq[type] + 1);
> > > +   else
> > > +           gen = lru_gen_from_seq(lrugen->min_seq[type]);
> >
> > Condition #2 is not quite clear to me, and the comment is incomplete:
> > The code does put dirty/writeback pages on the oldest gen as long as
> > they haven't been marked for immediate reclaim by the scanner
> > yet.
>
> Right.
>
> > HOWEVER, once the scanner does see those pages and sets
> > PG_reclaim, it will also activate them to move them out of the way
> > until writeback finishes (see shrink_page_list()) - at which point
> > we'll trigger #1. So that second part of #2 appears unreachable.
>
> Yes, dirty file pages go to #1; dirty pages in swapcache go to #2.
> (Ideally we want dirty file pages go to #2 too. IMO, the code would
>  be cleaner that way.)
>
> > It could be a good exercise to describe how cache pages move through
> > the generations, similar to the comment on lru_deactivate_file_fn().
> > It's a good example of intent vs implementation.
>
> Will do.
>
> > On another note, "!type" meaning "anon" is a bit rough. Please follow
> > the "bool file" convention used elsewhere.
>
> Originally I used "file", e.g., in v2:
> https://lore.kernel.org/linux-mm/20210413065633.2782273-9-yuzhao@google.com/
>
> But I was told to renamed it since "file" usually means file. Let me
> rename it back to "file", unless somebody still objects.
>
> > > @@ -113,6 +298,9 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
> > >  {
> > >     enum lru_list lru = folio_lru_list(folio);
> > >
> > > +   if (lru_gen_add_folio(lruvec, folio, true))
> > > +           return;
> > > +
> >
> > bool parameters are notoriously hard to follow in the callsite. Can
> > you please add lru_gen_add_folio_tail() instead and have them use a
> > common helper?
>
> I'm not sure -- there are several places like this one. My question is
> whether we want to do it throughout this patchset. We'd end up with
> many helpers and duplicate code. E.g., in this file alone, we have two
> functions taking bool parameters:
>   lru_gen_add_folio(..., bool reclaiming)
>   lru_gen_del_folio(..., bool reclaiming)
>
> I can't say they are very readable; at least they are very compact
> right now. My concern is that we might loose the latter without having
> enough of the former.
>
> Perhaps this is something that we could revisit after you've finished
> reviewing the entire patchset?
>
> > > @@ -127,6 +315,9 @@ static __always_inline void add_page_to_lru_list_tail(struct page *page,
> > >  static __always_inline
> > >  void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
> > >  {
> > > +   if (lru_gen_del_folio(lruvec, folio, false))
> > > +           return;
> > > +
> > >     list_del(&folio->lru);
> > >     update_lru_size(lruvec, folio_lru_list(folio), folio_zonenum(folio),
> > >                     -folio_nr_pages(folio));
> > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > index aed44e9b5d89..0f5e8a995781 100644
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -303,6 +303,78 @@ enum lruvec_flags {
> > >                                      */
> > >  };
> > >
> > > +struct lruvec;
> > > +
> > > +#define LRU_GEN_MASK               ((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOFF)
> > > +#define LRU_REFS_MASK              ((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PGOFF)
> > > +
> > > +#ifdef CONFIG_LRU_GEN
> > > +
> > > +#define MIN_LRU_BATCH              BITS_PER_LONG
> > > +#define MAX_LRU_BATCH              (MIN_LRU_BATCH * 128)
> >
> > Those two aren't used in this patch, so it's hard to say whether they
> > are chosen correctly.
>
> Right. They slipped during the v6/v7 refactoring. Will move them to
> the next patch.
>
> > > + * Evictable pages are divided into multiple generations. The youngest and the
> > > + * oldest generation numbers, max_seq and min_seq, are monotonically increasing.
> > > + * They form a sliding window of a variable size [MIN_NR_GENS, MAX_NR_GENS]. An
> > > + * offset within MAX_NR_GENS, gen, indexes the LRU list of the corresponding
> > > + * generation. The gen counter in folio->flags stores gen+1 while a page is on
> > > + * one of lrugen->lists[]. Otherwise it stores 0.
> > > + *
> > > + * A page is added to the youngest generation on faulting. The aging needs to
> > > + * check the accessed bit at least twice before handing this page over to the
> > > + * eviction. The first check takes care of the accessed bit set on the initial
> > > + * fault; the second check makes sure this page hasn't been used since then.
> > > + * This process, AKA second chance, requires a minimum of two generations,
> > > + * hence MIN_NR_GENS. And to be compatible with the active/inactive LRU, these
> > > + * two generations are mapped to the active; the rest of generations, if they
> > > + * exist, are mapped to the inactive. PG_active is always cleared while a page
> > > + * is on one of lrugen->lists[] so that demotion, which happens consequently
> > > + * when the aging produces a new generation, needs not to worry about it.
> > > + */
> > > +#define MIN_NR_GENS                2U
> > > +#define MAX_NR_GENS                ((unsigned int)CONFIG_NR_LRU_GENS)
> > > +
> > > +struct lru_gen_struct {
> >
> > struct lrugen?
> >
> > In fact, "lrugen" for the general function and variable namespace
> > might be better, the _ doesn't seem to pull its weight.
> >
> > CONFIG_LRUGEN
> > struct lrugen
> > lrugen_foo()
> > etc.
>
> No strong opinion here. I usually add underscores to functions and
> types so that grep doesn't end up with tons of local variables.
>
> > > +   /* the aging increments the youngest generation number */
> > > +   unsigned long max_seq;
> > > +   /* the eviction increments the oldest generation numbers */
> > > +   unsigned long min_seq[ANON_AND_FILE];
> >
> > The singular max_seq vs the split min_seq raises questions. Please add
> > a comment that explains or points to an explanation.
>
> Will do.
>
> > > +   /* the birth time of each generation in jiffies */
> > > +   unsigned long timestamps[MAX_NR_GENS];
> >
> > This isn't in use until the thrashing-based OOM killing patch.
>
> Will move it there.
>
> > > +   /* the multigenerational LRU lists */
> > > +   struct list_head lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
> > > +   /* the sizes of the above lists */
> > > +   unsigned long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
> > > +   /* whether the multigenerational LRU is enabled */
> > > +   bool enabled;
> >
> > Not (really) in use until the runtime switch. Best to keep everybody
> > checking the global flag for now, and have the runtime switch patch
> > introduce this flag and switch necessary callsites over.
>
> Will do.
>
> > > +void lru_gen_init_state(struct mem_cgroup *memcg, struct lruvec *lruvec);
> >
> > "state" is what we usually init :) How about lrugen_init_lruvec()?
>
> Same story as "file", lol -- this used to be lru_gen_init_lruvec():
> https://lore.kernel.org/linux-mm/20210413065633.2782273-9-yuzhao@google.com/
>
> Naming is hard. Hopefully we can finalize it this time.
>
> > You can drop the memcg parameter and use lruvec_memcg().
>
> lruvec_memcg() isn't available yet when pgdat_init_internals() calls
> this function because mem_cgroup_disabled() is initialized afterward.
>
> > > +#ifdef CONFIG_MEMCG
> > > +void lru_gen_init_memcg(struct mem_cgroup *memcg);
> > > +void lru_gen_free_memcg(struct mem_cgroup *memcg);
> >
> > This should be either init+exit, or alloc+free.
>
> Will do.

Thanks
Barry
