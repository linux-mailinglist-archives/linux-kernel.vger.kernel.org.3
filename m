Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2E055F562
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 06:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiF2EoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 00:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiF2EoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 00:44:19 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E41055A;
        Tue, 28 Jun 2022 21:44:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r18so12635746edb.9;
        Tue, 28 Jun 2022 21:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EO0JRn/zKNFpzxQ2nPIJJ4B2gnHe09/gTtSjoZOh1ro=;
        b=QzcyfTVCU6Vr4RkDqo7io/83x/0czg+WYnWfTwwVIWuUy2kBoG3y7bp1562QNa9VFj
         L9noCrlVAOybztSyuX/N8D68gZypqdsAdWllJLgLGVMzDf13Hl1vrb55BBiWybjrCWQv
         AC/4ynQ9ZltE8tVVw9TzEliyW8eG6iuCFzB/dm8Pei0pR6apSF82s82Vi9zZK0qbodap
         Zi6M2cI3tJmBb/HJUimO+dk0jUijqACKjAZBBD3mD9xicOYbxou+u2t64hpVC4VnndI3
         91hwzE/qhO0SNkaXE2LNa3bUkF5oCBkxv9Gx2xP0eZCjBuwJtMkO/v6lnQj9FiSUifRi
         UcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EO0JRn/zKNFpzxQ2nPIJJ4B2gnHe09/gTtSjoZOh1ro=;
        b=k0fhGYmeG7zZhJ2aNwvh7zZMJX9oy1UjctL1CS3iEV4a8iUX3Ie/Ie+zx/Gxb28ddW
         ln+h5bcYU35l2/8RMuU+qEngD0NQ4AR3c2wgIlm4DlTtEYgumLqP0Qk2Umvp1R73ptxC
         6ahZlvwu13BQVrkzRbA6j5PRPKKl+v7OnY9U6aV9mOrnw1S4XCcoURAikJQTxteyIDHZ
         L5zt/veKqmRdbkUs8Qx+yZuu3StsbTBC1py9KW3A0L/IAAWq5IYDoDC/IQO58b23r4+g
         uKctWytpKGBz0rZ/+jCVIAFnnhaYMnxZ2w36zSauewxSl8pZ8pRQu8cMQLyogjLNHEhw
         Y32g==
X-Gm-Message-State: AJIora8/KejCqgNpFqzN5Zb6WY+WA5LtRRaYp5aEOx5fUtpT+LeYJGFC
        oucDX38m7b+0zX4Nhl6wS7lyP6IRpnaxcxopfL1zt8Qcw2GHrw==
X-Google-Smtp-Source: AGRyM1uPcQMBhA/xLR07je2tPYIuQwE/L2GAPw0p9p8VbmUBexgOBzN9Xd0DKqh8AEVgwwIBp4YwPMMdkptgocTQDPU=
X-Received: by 2002:a05:6402:510a:b0:435:bcb8:756d with SMTP id
 m10-20020a056402510a00b00435bcb8756dmr1657149edd.277.1656477856080; Tue, 28
 Jun 2022 21:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220614071650.206064-1-yuzhao@google.com> <20220614071650.206064-8-yuzhao@google.com>
In-Reply-To: <20220614071650.206064-8-yuzhao@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 29 Jun 2022 16:44:04 +1200
Message-ID: <CAGsJ_4yi5vv-PmAHXR51rspo1GvV6Jnn0uth67d-y=Zr1AU+HA@mail.gmail.com>
Subject: Re: [PATCH v12 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
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
        Will Deacon <will@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, x86 <x86@kernel.org>,
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
        Vaibhav Jain <vaibhav@linux.ibm.com>
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

On Tue, Jun 14, 2022 at 7:26 PM Yu Zhao <yuzhao@google.com> wrote:
>
> Searching the rmap for PTEs mapping each page on an LRU list (to test
> and clear the accessed bit) can be expensive because pages from
> different VMAs (PA space) are not cache friendly to the rmap (VA
> space). For workloads mostly using mapped pages, searching the rmap
> can incur the highest CPU cost in the reclaim path.
>
> This patch exploits spatial locality to reduce the trips into the
> rmap. When shrink_page_list() walks the rmap and finds a young PTE, a
> new function lru_gen_look_around() scans at most BITS_PER_LONG-1
> adjacent PTEs. On finding another young PTE, it clears the accessed
> bit and updates the gen counter of the page mapped by this PTE to
> (max_seq%MAX_NR_GENS)+1.
>
> Server benchmark results:
>   Single workload:
>     fio (buffered I/O): no change
>
>   Single workload:
>     memcached (anon): +[3, 5]%
>                 Ops/sec      KB/sec
>       patch1-6: 1106168.46   43025.04
>       patch1-7: 1147696.57   44640.29
>
>   Configurations:
>     no change
>
> Client benchmark results:
>   kswapd profiles:
>     patch1-6
>       39.03%  lzo1x_1_do_compress (real work)
>       18.47%  page_vma_mapped_walk (overhead)
>        6.74%  _raw_spin_unlock_irq
>        3.97%  do_raw_spin_lock
>        2.49%  ptep_clear_flush
>        2.48%  anon_vma_interval_tree_iter_first
>        1.92%  folio_referenced_one
>        1.88%  __zram_bvec_write
>        1.48%  memmove
>        1.31%  vma_interval_tree_iter_next
>
>     patch1-7
>       48.16%  lzo1x_1_do_compress (real work)
>        8.20%  page_vma_mapped_walk (overhead)
>        7.06%  _raw_spin_unlock_irq
>        2.92%  ptep_clear_flush
>        2.53%  __zram_bvec_write
>        2.11%  do_raw_spin_lock
>        2.02%  memmove
>        1.93%  lru_gen_look_around
>        1.56%  free_unref_page_list
>        1.40%  memset
>
>   Configurations:
>     no change
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Acked-by: Steven Barrett <steven@liquorix.net>
> Acked-by: Suleiman Souhlal <suleiman@google.com>
> Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> Tested-by: Donald Carr <d@chaos-reins.com>
> Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>

Acked-by: Barry Song <baohua@kernel.org>

I've thought about this for a long time, and over and over again.
We also actually ran it, getting lower overhead on rmap.

I think the solution is right. for example, if one text has 16 pages, and
this text is mapped by 100 processes. while doing rmap for one of
those 16 pages, and if the page is pte_young, all 15 pages
around it will also be checked pte_young, and be upgraded to
new generation if those neighbours are young. so their rmap
are skipped.

However, at the beginning, I had some concerns about some corner
cases as the solution was a little bit shocking to me:-)
A corner case is that one page is mapped to 100 processes,
but it has completely different neighbours in 100 processes.
for example,
process1:  page1 - page2
process2:  page1 - page3
process3:  page1 - page4
process4:  page1 - page5
...
process 100: page1 - page101

Then when we do rmap for page2, only process1 gets the chance
to clear page1's pte referenced bit. page1 is still "young" in
process2- process100. this means after page1 becomes cold,
rmap of page3-page101 will still upgrade page1. Thus, page1 is very
unlikely to be reclaimed.

but i feel this is not practically true as in real life, we always
map regions with spatial locality.  page1 is likely to get
same neighbours in those 100 vmas of 100 processes.

> ---
>  include/linux/memcontrol.h |  31 +++++++
>  include/linux/mm.h         |   5 +
>  include/linux/mmzone.h     |   6 ++
>  mm/internal.h              |   1 +
>  mm/memcontrol.c            |   1 +
>  mm/rmap.c                  |   6 ++
>  mm/swap.c                  |   4 +-
>  mm/vmscan.c                | 184 +++++++++++++++++++++++++++++++++++++
>  8 files changed, 236 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 9ecead1042b9..9d0fea17f9ef 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -444,6 +444,7 @@ static inline struct obj_cgroup *__folio_objcg(struct=
 folio *folio)
>   * - LRU isolation
>   * - lock_page_memcg()
>   * - exclusive reference
> + * - mem_cgroup_trylock_pages()
>   *
>   * For a kmem folio a caller should hold an rcu read lock to protect mem=
cg
>   * associated with a kmem folio from being released.
> @@ -505,6 +506,7 @@ static inline struct mem_cgroup *folio_memcg_rcu(stru=
ct folio *folio)
>   * - LRU isolation
>   * - lock_page_memcg()
>   * - exclusive reference
> + * - mem_cgroup_trylock_pages()
>   *
>   * For a kmem page a caller should hold an rcu read lock to protect memc=
g
>   * associated with a kmem page from being released.
> @@ -950,6 +952,23 @@ void unlock_page_memcg(struct page *page);
>
>  void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
>
> +/* try to stablize folio_memcg() for all the pages in a memcg */
> +static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
> +{
> +       rcu_read_lock();
> +
> +       if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_account)=
)
> +               return true;
> +
> +       rcu_read_unlock();
> +       return false;
> +}
> +
> +static inline void mem_cgroup_unlock_pages(void)
> +{
> +       rcu_read_unlock();
> +}
> +
>  /* idx can be of type enum memcg_stat_item or node_stat_item */
>  static inline void mod_memcg_state(struct mem_cgroup *memcg,
>                                    int idx, int val)
> @@ -1401,6 +1420,18 @@ static inline void folio_memcg_unlock(struct folio=
 *folio)
>  {
>  }
>
> +static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
> +{
> +       /* to match folio_memcg_rcu() */
> +       rcu_read_lock();
> +       return true;
> +}
> +
> +static inline void mem_cgroup_unlock_pages(void)
> +{
> +       rcu_read_unlock();
> +}
> +
>  static inline void mem_cgroup_handle_over_high(void)
>  {
>  }
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9f05eb5d06c0..a48727fdacf8 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1523,6 +1523,11 @@ static inline unsigned long folio_pfn(struct folio=
 *folio)
>         return page_to_pfn(&folio->page);
>  }
>
> +static inline struct folio *pfn_folio(unsigned long pfn)
> +{
> +       return page_folio(pfn_to_page(pfn));
> +}
> +
>  static inline atomic_t *folio_pincount_ptr(struct folio *folio)
>  {
>         return &folio_page(folio, 1)->compound_pincount;
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 0d76222501ed..4fd7fc16eeb4 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -372,6 +372,7 @@ enum lruvec_flags {
>  #ifndef __GENERATING_BOUNDS_H
>
>  struct lruvec;
> +struct page_vma_mapped_walk;
>
>  #define LRU_GEN_MASK           ((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOF=
F)
>  #define LRU_REFS_MASK          ((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PG=
OFF)
> @@ -427,6 +428,7 @@ struct lru_gen_struct {
>  };
>
>  void lru_gen_init_lruvec(struct lruvec *lruvec);
> +void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
>
>  #ifdef CONFIG_MEMCG
>  void lru_gen_init_memcg(struct mem_cgroup *memcg);
> @@ -439,6 +441,10 @@ static inline void lru_gen_init_lruvec(struct lruvec=
 *lruvec)
>  {
>  }
>
> +static inline void lru_gen_look_around(struct page_vma_mapped_walk *pvmw=
)
> +{
> +}
> +
>  #ifdef CONFIG_MEMCG
>  static inline void lru_gen_init_memcg(struct mem_cgroup *memcg)
>  {
> diff --git a/mm/internal.h b/mm/internal.h
> index c0f8fbe0445b..3d070582052e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -83,6 +83,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf);
>  void folio_rotate_reclaimable(struct folio *folio);
>  bool __folio_end_writeback(struct folio *folio);
>  void deactivate_file_folio(struct folio *folio);
> +void folio_activate(struct folio *folio);
>
>  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_=
vma,
>                 unsigned long floor, unsigned long ceiling);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ecdc0401f298..dece7722ed85 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2777,6 +2777,7 @@ static void commit_charge(struct folio *folio, stru=
ct mem_cgroup *memcg)
>          * - LRU isolation
>          * - lock_page_memcg()
>          * - exclusive reference
> +        * - mem_cgroup_trylock_pages()
>          */
>         folio->memcg_data =3D (unsigned long)memcg;
>  }
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 5bcb334cd6f2..dce1a56b02f8 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -830,6 +830,12 @@ static bool folio_referenced_one(struct folio *folio=
,
>                 }
>
>                 if (pvmw.pte) {
> +                       if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
> +                           !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ=
))) {
> +                               lru_gen_look_around(&pvmw);
> +                               referenced++;
> +                       }
> +
>                         if (ptep_clear_flush_young_notify(vma, address,
>                                                 pvmw.pte)) {
>                                 /*
> diff --git a/mm/swap.c b/mm/swap.c
> index 8d09609cfb5e..87b9abf246d7 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -342,7 +342,7 @@ static bool need_activate_page_drain(int cpu)
>         return pagevec_count(&per_cpu(lru_pvecs.activate_page, cpu)) !=3D=
 0;
>  }
>
> -static void folio_activate(struct folio *folio)
> +void folio_activate(struct folio *folio)
>  {
>         if (folio_test_lru(folio) && !folio_test_active(folio) &&
>             !folio_test_unevictable(folio)) {
> @@ -362,7 +362,7 @@ static inline void activate_page_drain(int cpu)
>  {
>  }
>
> -static void folio_activate(struct folio *folio)
> +void folio_activate(struct folio *folio)
>  {
>         struct lruvec *lruvec;
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 60019e7e1ad8..95f14878da76 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1574,6 +1574,11 @@ static unsigned int shrink_page_list(struct list_h=
ead *page_list,
>                 if (!sc->may_unmap && folio_mapped(folio))
>                         goto keep_locked;
>
> +               /* folio_update_gen() tried to promote this page? */
> +               if (lru_gen_enabled() && !ignore_references &&
> +                   folio_mapped(folio) && folio_test_referenced(folio))
> +                       goto keep_locked;
> +
>                 /*
>                  * The number of dirty pages determines if a node is mark=
ed
>                  * reclaim_congested. kswapd will stall and start writing
> @@ -3161,6 +3166,29 @@ static bool positive_ctrl_err(struct ctrl_pos *sp,=
 struct ctrl_pos *pv)
>   *                          the aging
>   ***********************************************************************=
*******/
>
> +/* promote pages accessed through page tables */
> +static int folio_update_gen(struct folio *folio, int gen)
> +{
> +       unsigned long new_flags, old_flags =3D READ_ONCE(folio->flags);
> +
> +       VM_WARN_ON_ONCE(gen >=3D MAX_NR_GENS);
> +       VM_WARN_ON_ONCE(!rcu_read_lock_held());
> +
> +       do {
> +               /* lru_gen_del_folio() has isolated this page? */
> +               if (!(old_flags & LRU_GEN_MASK)) {
> +                       /* for shrink_page_list() */
> +                       new_flags =3D old_flags | BIT(PG_referenced);
> +                       continue;
> +               }
> +
> +               new_flags =3D old_flags & ~(LRU_GEN_MASK | LRU_REFS_MASK =
| LRU_REFS_FLAGS);
> +               new_flags |=3D (gen + 1UL) << LRU_GEN_PGOFF;
> +       } while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
> +
> +       return ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> +}
> +
>  /* protect pages accessed multiple times through file descriptors */
>  static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, boo=
l reclaiming)
>  {
> @@ -3172,6 +3200,11 @@ static int folio_inc_gen(struct lruvec *lruvec, st=
ruct folio *folio, bool reclai
>         VM_WARN_ON_ONCE_FOLIO(!(old_flags & LRU_GEN_MASK), folio);
>
>         do {
> +               new_gen =3D ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF)=
 - 1;
> +               /* folio_update_gen() has promoted this page? */
> +               if (new_gen >=3D 0 && new_gen !=3D old_gen)
> +                       return new_gen;
> +
>                 new_gen =3D (old_gen + 1) % MAX_NR_GENS;
>
>                 new_flags =3D old_flags & ~(LRU_GEN_MASK | LRU_REFS_MASK =
| LRU_REFS_FLAGS);
> @@ -3186,6 +3219,43 @@ static int folio_inc_gen(struct lruvec *lruvec, st=
ruct folio *folio, bool reclai
>         return new_gen;
>  }
>
> +static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, =
unsigned long addr)
> +{
> +       unsigned long pfn =3D pte_pfn(pte);
> +
> +       VM_WARN_ON_ONCE(addr < vma->vm_start || addr >=3D vma->vm_end);
> +
> +       if (!pte_present(pte) || is_zero_pfn(pfn))
> +               return -1;
> +
> +       if (WARN_ON_ONCE(pte_devmap(pte) || pte_special(pte)))
> +               return -1;
> +
> +       if (WARN_ON_ONCE(!pfn_valid(pfn)))
> +               return -1;
> +
> +       return pfn;
> +}
> +
> +static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup =
*memcg,
> +                                  struct pglist_data *pgdat)
> +{
> +       struct folio *folio;
> +
> +       /* try to avoid unnecessary memory loads */
> +       if (pfn < pgdat->node_start_pfn || pfn >=3D pgdat_end_pfn(pgdat))
> +               return NULL;
> +
> +       folio =3D pfn_folio(pfn);
> +       if (folio_nid(folio) !=3D pgdat->node_id)
> +               return NULL;
> +
> +       if (folio_memcg_rcu(folio) !=3D memcg)
> +               return NULL;
> +
> +       return folio;
> +}
> +
>  static void inc_min_seq(struct lruvec *lruvec, int type)
>  {
>         struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
> @@ -3387,6 +3457,114 @@ static void lru_gen_age_node(struct pglist_data *=
pgdat, struct scan_control *sc)
>         } while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)));
>  }
>
> +/*
> + * This function exploits spatial locality when shrink_page_list() walks=
 the
> + * rmap. It scans the adjacent PTEs of a young PTE and promotes hot page=
s.
> + */
> +void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
> +{
> +       int i;
> +       pte_t *pte;
> +       unsigned long start;
> +       unsigned long end;
> +       unsigned long addr;
> +       unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)] =3D {};
> +       struct folio *folio =3D pfn_folio(pvmw->pfn);
> +       struct mem_cgroup *memcg =3D folio_memcg(folio);
> +       struct pglist_data *pgdat =3D folio_pgdat(folio);
> +       struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
> +       DEFINE_MAX_SEQ(lruvec);
> +       int old_gen, new_gen =3D lru_gen_from_seq(max_seq);
> +
> +       lockdep_assert_held(pvmw->ptl);
> +       VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
> +
> +       if (spin_is_contended(pvmw->ptl))
> +               return;
> +
> +       start =3D max(pvmw->address & PMD_MASK, pvmw->vma->vm_start);
> +       end =3D min(pvmw->address | ~PMD_MASK, pvmw->vma->vm_end - 1) + 1=
;
> +
> +       if (end - start > MIN_LRU_BATCH * PAGE_SIZE) {
> +               if (pvmw->address - start < MIN_LRU_BATCH * PAGE_SIZE / 2=
)
> +                       end =3D start + MIN_LRU_BATCH * PAGE_SIZE;
> +               else if (end - pvmw->address < MIN_LRU_BATCH * PAGE_SIZE =
/ 2)
> +                       start =3D end - MIN_LRU_BATCH * PAGE_SIZE;
> +               else {
> +                       start =3D pvmw->address - MIN_LRU_BATCH * PAGE_SI=
ZE / 2;
> +                       end =3D pvmw->address + MIN_LRU_BATCH * PAGE_SIZE=
 / 2;
> +               }
> +       }
> +
> +       pte =3D pvmw->pte - (pvmw->address - start) / PAGE_SIZE;
> +
> +       rcu_read_lock();
> +       arch_enter_lazy_mmu_mode();
> +
> +       for (i =3D 0, addr =3D start; addr !=3D end; i++, addr +=3D PAGE_=
SIZE) {
> +               unsigned long pfn;
> +
> +               pfn =3D get_pte_pfn(pte[i], pvmw->vma, addr);
> +               if (pfn =3D=3D -1)
> +                       continue;
> +
> +               if (!pte_young(pte[i]))
> +                       continue;
> +
> +               folio =3D get_pfn_folio(pfn, memcg, pgdat);
> +               if (!folio)
> +                       continue;
> +
> +               if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
> +                       continue;
> +
> +               if (pte_dirty(pte[i]) && !folio_test_dirty(folio) &&
> +                   !(folio_test_anon(folio) && folio_test_swapbacked(fol=
io) &&
> +                     !folio_test_swapcache(folio)))
> +                       folio_mark_dirty(folio);
> +
> +               old_gen =3D folio_lru_gen(folio);
> +               if (old_gen < 0)
> +                       folio_set_referenced(folio);
> +               else if (old_gen !=3D new_gen)
> +                       __set_bit(i, bitmap);
> +       }
> +
> +       arch_leave_lazy_mmu_mode();
> +       rcu_read_unlock();
> +
> +       if (bitmap_weight(bitmap, MIN_LRU_BATCH) < PAGEVEC_SIZE) {
> +               for_each_set_bit(i, bitmap, MIN_LRU_BATCH) {
> +                       folio =3D pfn_folio(pte_pfn(pte[i]));
> +                       folio_activate(folio);
> +               }
> +               return;
> +       }
> +
> +       /* folio_update_gen() requires stable folio_memcg() */
> +       if (!mem_cgroup_trylock_pages(memcg))
> +               return;
> +
> +       spin_lock_irq(&lruvec->lru_lock);
> +       new_gen =3D lru_gen_from_seq(lruvec->lrugen.max_seq);
> +
> +       for_each_set_bit(i, bitmap, MIN_LRU_BATCH) {
> +               folio =3D pfn_folio(pte_pfn(pte[i]));
> +               if (folio_memcg_rcu(folio) !=3D memcg)
> +                       continue;
> +
> +               old_gen =3D folio_update_gen(folio, new_gen);
> +               if (old_gen < 0 || old_gen =3D=3D new_gen)
> +                       continue;
> +
> +               lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> +       }
> +
> +       spin_unlock_irq(&lruvec->lru_lock);
> +
> +       mem_cgroup_unlock_pages();
> +}
> +
>  /***********************************************************************=
*******
>   *                          the eviction
>   ***********************************************************************=
*******/
> @@ -3423,6 +3601,12 @@ static bool sort_folio(struct lruvec *lruvec, stru=
ct folio *folio, int tier_idx)
>                 return true;
>         }
>
> +       /* promoted */
> +       if (gen !=3D lru_gen_from_seq(lrugen->min_seq[type])) {
> +               list_move(&folio->lru, &lrugen->lists[gen][type][zone]);
> +               return true;
> +       }
> +
>         /* protected */
>         if (tier > tier_idx) {
>                 int hist =3D lru_hist_from_seq(lrugen->min_seq[type]);
> --
> 2.36.1.476.g0c4daa206d-goog
>

Thanks
Barry
