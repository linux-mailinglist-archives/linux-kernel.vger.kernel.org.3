Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3653F75E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbiFGHhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237716AbiFGHh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:37:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8651C25EB;
        Tue,  7 Jun 2022 00:37:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id s12so26185856ejx.3;
        Tue, 07 Jun 2022 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kjtclTo6hwcqYED9n/ojCDRC4tEzQKbn61y6dGb/AZ0=;
        b=I+I7kSMOBt0Gn137kC6P4pBul8tKAqzwrPFnoqXzkuW01YPYXa1KcFF07qrY1JKLu8
         u20l2+fyxbA/cB+RQYQu/ljnlX3ZEOnnlW7Y1LLUTNsa5dy69+tFZVHO7ExcJwG04tiS
         htbeXR+9L38o+VOkMbWKl1Y323NcB0e7aYfMV6wnZiM3qmHuWRWCbRUSCtihO8oKagKw
         AFoCX0Hb68mkzp11tj5Lu3FDxaF6rkU54M+71NZky0bf04z8NFyYWcRnqzof92hQdSNH
         DKTmjvJ4cDVIdPM4xbhrlBytMxdQ4cEX0NVvWahmGgtovnNCWPcLwRvxjLXVnvIbR/G9
         Ip5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kjtclTo6hwcqYED9n/ojCDRC4tEzQKbn61y6dGb/AZ0=;
        b=P7VHwWTxZI+lNflt+E1mtr0RNl71kAoGNdLD1vOf4gH8O2txaenbVQO/tJzsq2YJwk
         IshPg9tfZ4n0wHgkNkeJul34haVz6l2+NrUAE2vsxvma/iVZiiP5upsDYmifgaqMeS9Q
         xgwGW3rRpyByQM75Q9zdWcKoZ5en8CkFZpWfWGpEjxjzkC7oc/9kMXqY7+p3IRIbeSJm
         qpOvLD4RKT39CRtyBp/pf/M6PXfaeLtcmoDumTZUabc3RZ813Ac2AmwdgRv6OGh5T1Z4
         5maLRYGEWHAJ7IpQ3j/1lZ8pExoCSmADsAXgmE6w+jRDf+Q6AxnGlFcU7gJPBVv2jx6M
         N9zw==
X-Gm-Message-State: AOAM531Jy+dGlA4XerxrDVxUEQ4t6hEYE1alS4cLgSIJrvLdosKCUmGo
        hPqSFSD3dwDrhO3UIfUhAuEb1Ykz1i+Qa0A4HJ4=
X-Google-Smtp-Source: ABdhPJxq7gbKI8I6h6yB4oDTIAKnbBuIrelPBSTjy52gQCtxjY6Ljn+tWqB6H/gwQOV4kqyiRfbomMke7NXsmekEV7A=
X-Received: by 2002:a17:906:fb07:b0:706:ad5a:db9f with SMTP id
 lz7-20020a170906fb0700b00706ad5adb9fmr25843828ejb.91.1654587441384; Tue, 07
 Jun 2022 00:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com> <20220518014632.922072-8-yuzhao@google.com>
 <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 7 Jun 2022 19:37:10 +1200
Message-ID: <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
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
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, huzhanyuan@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 9:25 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Wed, May 18, 2022 at 4:49 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > Searching the rmap for PTEs mapping each page on an LRU list (to test
> > and clear the accessed bit) can be expensive because pages from
> > different VMAs (PA space) are not cache friendly to the rmap (VA
> > space). For workloads mostly using mapped pages, the rmap has a high
> > CPU cost in the reclaim path.
> >
> > This patch exploits spatial locality to reduce the trips into the
> > rmap. When shrink_page_list() walks the rmap and finds a young PTE, a
> > new function lru_gen_look_around() scans at most BITS_PER_LONG-1
> > adjacent PTEs. On finding another young PTE, it clears the accessed
> > bit and updates the gen counter of the page mapped by this PTE to
> > (max_seq%MAX_NR_GENS)+1.
> >
> > Server benchmark results:
> >   Single workload:
> >     fio (buffered I/O): no change
> >
> >   Single workload:
> >     memcached (anon): +[5.5, 7.5]%
> >                 Ops/sec      KB/sec
> >       patch1-6: 1120643.70   43588.06
> >       patch1-7: 1193918.93   46438.15
> >
> >   Configurations:
> >     no change
> >
> > Client benchmark results:
> >   kswapd profiles:
> >     patch1-6
> >       35.99%  lzo1x_1_do_compress (real work)
> >       19.40%  page_vma_mapped_walk
> >        6.31%  _raw_spin_unlock_irq
> >        3.95%  do_raw_spin_lock
> >        2.39%  anon_vma_interval_tree_iter_first
> >        2.25%  ptep_clear_flush
> >        1.92%  __anon_vma_interval_tree_subtree_search
> >        1.70%  folio_referenced_one
> >        1.68%  __zram_bvec_write
> >        1.43%  anon_vma_interval_tree_iter_next
> >
> >     patch1-7
> >       45.90%  lzo1x_1_do_compress (real work)
> >        9.14%  page_vma_mapped_walk
> >        6.81%  _raw_spin_unlock_irq
> >        2.80%  ptep_clear_flush
> >        2.34%  __zram_bvec_write
> >        2.29%  do_raw_spin_lock
> >        1.84%  lru_gen_look_around
> >        1.78%  memmove
> >        1.74%  obj_malloc
> >        1.50%  free_unref_page_list
> >
> >   Configurations:
> >     no change
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > Acked-by: Brian Geffon <bgeffon@google.com>
> > Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> > Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Acked-by: Steven Barrett <steven@liquorix.net>
> > Acked-by: Suleiman Souhlal <suleiman@google.com>
> > Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> > Tested-by: Donald Carr <d@chaos-reins.com>
> > Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> > Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> > Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> > Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> > Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > ---
> >  include/linux/memcontrol.h |  31 ++++++++
> >  include/linux/mm.h         |   5 ++
> >  include/linux/mmzone.h     |   6 ++
> >  mm/internal.h              |   1 +
> >  mm/memcontrol.c            |   1 +
> >  mm/rmap.c                  |   7 ++
> >  mm/swap.c                  |   4 +-
> >  mm/vmscan.c                | 157 +++++++++++++++++++++++++++++++++++++
> >  8 files changed, 210 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 89b14729d59f..2bfdcc77648a 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -438,6 +438,7 @@ static inline struct obj_cgroup *__folio_objcg(stru=
ct folio *folio)
> >   * - LRU isolation
> >   * - lock_page_memcg()
> >   * - exclusive reference
> > + * - mem_cgroup_trylock_pages()
> >   *
> >   * For a kmem folio a caller should hold an rcu read lock to protect m=
emcg
> >   * associated with a kmem folio from being released.
> > @@ -499,6 +500,7 @@ static inline struct mem_cgroup *folio_memcg_rcu(st=
ruct folio *folio)
> >   * - LRU isolation
> >   * - lock_page_memcg()
> >   * - exclusive reference
> > + * - mem_cgroup_trylock_pages()
> >   *
> >   * For a kmem page a caller should hold an rcu read lock to protect me=
mcg
> >   * associated with a kmem page from being released.
> > @@ -948,6 +950,23 @@ void unlock_page_memcg(struct page *page);
> >
> >  void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
> >
> > +/* try to stablize folio_memcg() for all the pages in a memcg */
> > +static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
> > +{
> > +       rcu_read_lock();
> > +
> > +       if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_accoun=
t))
> > +               return true;
> > +
> > +       rcu_read_unlock();
> > +       return false;
> > +}
> > +
> > +static inline void mem_cgroup_unlock_pages(void)
> > +{
> > +       rcu_read_unlock();
> > +}
> > +
> >  /* idx can be of type enum memcg_stat_item or node_stat_item */
> >  static inline void mod_memcg_state(struct mem_cgroup *memcg,
> >                                    int idx, int val)
> > @@ -1386,6 +1405,18 @@ static inline void folio_memcg_unlock(struct fol=
io *folio)
> >  {
> >  }
> >
> > +static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
> > +{
> > +       /* to match folio_memcg_rcu() */
> > +       rcu_read_lock();
> > +       return true;
> > +}
> > +
> > +static inline void mem_cgroup_unlock_pages(void)
> > +{
> > +       rcu_read_unlock();
> > +}
> > +
> >  static inline void mem_cgroup_handle_over_high(void)
> >  {
> >  }
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 894c289c2c06..4e8ab4ad4473 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1523,6 +1523,11 @@ static inline unsigned long folio_pfn(struct fol=
io *folio)
> >         return page_to_pfn(&folio->page);
> >  }
> >
> > +static inline struct folio *pfn_folio(unsigned long pfn)
> > +{
> > +       return page_folio(pfn_to_page(pfn));
> > +}
> > +
> >  static inline atomic_t *folio_pincount_ptr(struct folio *folio)
> >  {
> >         return &folio_page(folio, 1)->compound_pincount;
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 2d023d243e73..f0b980362186 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -374,6 +374,7 @@ enum lruvec_flags {
> >  #ifndef __GENERATING_BOUNDS_H
> >
> >  struct lruvec;
> > +struct page_vma_mapped_walk;
> >
> >  #define LRU_GEN_MASK           ((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PG=
OFF)
> >  #define LRU_REFS_MASK          ((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_=
PGOFF)
> > @@ -429,6 +430,7 @@ struct lru_gen_struct {
> >  };
> >
> >  void lru_gen_init_lruvec(struct lruvec *lruvec);
> > +void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
> >
> >  #ifdef CONFIG_MEMCG
> >  void lru_gen_init_memcg(struct mem_cgroup *memcg);
> > @@ -441,6 +443,10 @@ static inline void lru_gen_init_lruvec(struct lruv=
ec *lruvec)
> >  {
> >  }
> >
> > +static inline void lru_gen_look_around(struct page_vma_mapped_walk *pv=
mw)
> > +{
> > +}
> > +
> >  #ifdef CONFIG_MEMCG
> >  static inline void lru_gen_init_memcg(struct mem_cgroup *memcg)
> >  {
> > diff --git a/mm/internal.h b/mm/internal.h
> > index cf16280ce132..59d2422b647d 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -68,6 +68,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf);
> >  void folio_rotate_reclaimable(struct folio *folio);
> >  bool __folio_end_writeback(struct folio *folio);
> >  void deactivate_file_folio(struct folio *folio);
> > +void folio_activate(struct folio *folio);
> >
> >  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *star=
t_vma,
> >                 unsigned long floor, unsigned long ceiling);
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 2ee074f80e72..98aa720ac639 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2769,6 +2769,7 @@ static void commit_charge(struct folio *folio, st=
ruct mem_cgroup *memcg)
> >          * - LRU isolation
> >          * - lock_page_memcg()
> >          * - exclusive reference
> > +        * - mem_cgroup_trylock_pages()
> >          */
> >         folio->memcg_data =3D (unsigned long)memcg;
> >  }
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index fedb82371efe..7cb7ef29088a 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -73,6 +73,7 @@
> >  #include <linux/page_idle.h>
> >  #include <linux/memremap.h>
> >  #include <linux/userfaultfd_k.h>
> > +#include <linux/mm_inline.h>
> >
> >  #include <asm/tlbflush.h>
> >
> > @@ -821,6 +822,12 @@ static bool folio_referenced_one(struct folio *fol=
io,
> >                 }
> >
> >                 if (pvmw.pte) {
> > +                       if (lru_gen_enabled() && pte_young(*pvmw.pte) &=
&
> > +                           !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_RE=
AD))) {
> > +                               lru_gen_look_around(&pvmw);
> > +                               referenced++;
> > +                       }
> > +
> >                         if (ptep_clear_flush_young_notify(vma, address,
>
> Hello, Yu.
> look_around() is calling ptep_test_and_clear_young(pvmw->vma, addr, pte +=
 i)
> only without flush and notify. for flush, there is a tlb operation for ar=
m64:
> static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>                                          unsigned long address, pte_t *pt=
ep)
> {
>         int young =3D ptep_test_and_clear_young(vma, address, ptep);
>
>         if (young) {
>                 /*
>                  * We can elide the trailing DSB here since the worst tha=
t can
>                  * happen is that a CPU continues to use the young entry =
in its
>                  * TLB and we mistakenly reclaim the associated page. The
>                  * window for such an event is bounded by the next
>                  * context-switch, which provides a DSB to complete the T=
LB
>                  * invalidation.
>                  */
>                 flush_tlb_page_nosync(vma, address);
>         }
>
>         return young;
> }
>
> Does it mean the current kernel is over cautious?  is it
> safe to call ptep_test_and_clear_young() only?

I can't really explain why we are getting a random app/java vm crash in mon=
key
test by using ptep_test_and_clear_young() only in lru_gen_look_around() on =
an
armv8-a machine without hardware PTE young support.

Moving to  ptep_clear_flush_young() in look_around can make the random
hang disappear according to zhanyuan(Cc-ed).

On x86, ptep_clear_flush_young() is exactly ptep_test_and_clear_young()
after
 'commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case clear
the accessed bit instead of flushing the TLB")'

But on arm64, they are different. according to Will's comments in this
thread which
tried to make arm64 same with x86,
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1793881.html

"
This is blindly copied from x86 and isn't true for us: we don't invalidate
the TLB on context switch. That means our window for keeping the stale
entries around is potentially much bigger and might not be a great idea.

If we roll a TLB invalidation routine without the trailing DSB, what sort o=
f
performance does that get you?
"
We shouldn't think ptep_clear_flush_young() is safe enough in LRU to
clear PTE young? Any comments from Will?

>
> btw, lru_gen_look_around() has already included 'address', are we doing
> pte check for 'address' twice here?
>

Thanks
Barry
