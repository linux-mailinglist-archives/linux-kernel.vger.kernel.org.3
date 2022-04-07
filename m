Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB7B4F7214
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbiDGCbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiDGCbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:31:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6338C1F0451;
        Wed,  6 Apr 2022 19:29:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b24so4756992edu.10;
        Wed, 06 Apr 2022 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9mmurDG9lybL8Pw2Faw1uM/80651LMFTL4TL1vf4pzQ=;
        b=oT061DgonumuqvWXvLTX33iwIPcsiBGHY6qGGBTP0zu1wmB1FWPkgGNq0j8R0enSEk
         V5ixrp2FE9N54i+bcThOMik++OPqCtzMihvnxf58ECq4oIFG6HgLL9ETm3Wh3BVIyH7N
         Tjun9aORgqn7J31FTm9Y3bRs0tpFGwqdvnaow+hT8fAnFJgKGpYgnm3+xGn0//6HCHkt
         Th36pvBGeRv5fz9AGzE1dMJoZfHf6kEvdh2xNMYzkWmO9nQ1LW0aVT2R37jR3X/8c4vv
         GfB/8h6ys+2mGWS+ZCgDLwCvbqzIA4YlSCcwQmO8MxBpZJRzHWETG7CWrzwyYCSgnEyO
         CaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9mmurDG9lybL8Pw2Faw1uM/80651LMFTL4TL1vf4pzQ=;
        b=0OfyRDvQmv4xBUULf+2aSpflF49sdjz7lllx+oW/m+yn4CZR2cBRpOTaHIhmfsc+2c
         87f8lYBRX1fXu3ZzIP6Z8yEdUdkUvJ9zNhVMBvqGMMZaTu++82xqmK3RDYVcZIVcO319
         /KBgsvX0p/EHAI/grShdNRKVCr6I3UcyzB8lfJaoJD99kcViF0XITdndl3EDp2JjbA/U
         e7UflpuJ3I0n/IzHUAXTZlZ8W6jOs8XbbPpgiUBAeLrEDyXyKmJBLVOhjR1wGn9eNuYe
         3s5VgZ7l9JWEPvH+cWoMOocaUAmcaB5A7IwFC8ZVHVDIYSB1nxuP4Gyc3I+tKxtny8e/
         LrIQ==
X-Gm-Message-State: AOAM532wW8svMKFQ3jUwxVucxKASTfNLldCFN6vfBFG4eH4BZAmqaeye
        gHi7I41ULNhfdorWpeqfJFkh8pO9Hs5dsv6NCck=
X-Google-Smtp-Source: ABdhPJxxg9pN7j6WgWt9TpifnAqdiun1PEAeMA15FIUcBfRLWowHlmKU4VCi/at+m8IBGO+xu+VQI3Np5fgeQcLpFSs=
X-Received: by 2002:a05:6402:1708:b0:41c:b3e2:c4e7 with SMTP id
 y8-20020a056402170800b0041cb3e2c4e7mr12117557edu.197.1649298590787; Wed, 06
 Apr 2022 19:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-8-yuzhao@google.com>
In-Reply-To: <20220309021230.721028-8-yuzhao@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 7 Apr 2022 14:29:39 +1200
Message-ID: <CAGsJ_4wVA6G42y4Oj7ToaCoroZTRbS-tU606ELwra3_Sfrgo7w@mail.gmail.com>
Subject: Re: [PATCH v9 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
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

On Wed, Mar 9, 2022 at 3:48 PM Yu Zhao <yuzhao@google.com> wrote:
>
> Searching the rmap for PTEs mapping each page on an LRU list (to test
> and clear the accessed bit) can be expensive because pages from
> different VMAs (PA space) are not cache friendly to the rmap (VA
> space). For workloads mostly using mapped pages, the rmap has a high
> CPU cost in the reclaim path.
>
> This patch exploits spatial locality to reduce the trips into the
> rmap. When shrink_page_list() walks the rmap and finds a young PTE, a
> new function lru_gen_look_around() scans at most BITS_PER_LONG-1
> adjacent PTEs. On finding another young PTE, it clears the accessed
> bit and updates the gen counter of the page mapped by this PTE to
> (max_seq%MAX_NR_GENS)+1.

Hi Yu,
It seems an interesting feature to save the cost of rmap. but will it lead =
to
possible judging of cold pages as hot pages?
In case a page is mapped by 20 processes,  and it has been accessed
by 5 of them, when we look around one of the 5 processes, the page
will be young and this pte is cleared. but we still have 4 ptes which are n=
ot
cleared. then we don't access the page for a long time, but the 4 uncleared
PTEs will still make the page "hot" since they are not cleared, we will fin=
d
the page is hot either due to look-arounding the 4 processes or rmapping
the page later?

>
> Server benchmark results:
>   Single workload:
>     fio (buffered I/O): no change
>
>   Single workload:
>     memcached (anon): +[3.5, 5.5]%
>                 Ops/sec      KB/sec
>       patch1-5: 972526.07    37826.95
>       patch1-6: 1015292.83   39490.38
>
>   Configurations:
>     no change
>
> Client benchmark results:
>   kswapd profiles:
>     patch1-5
>       39.73%  lzo1x_1_do_compress (real work)
>       14.96%  page_vma_mapped_walk
>        6.97%  _raw_spin_unlock_irq
>        3.07%  do_raw_spin_lock
>        2.53%  anon_vma_interval_tree_iter_first
>        2.04%  ptep_clear_flush
>        1.82%  __zram_bvec_write
>        1.76%  __anon_vma_interval_tree_subtree_search
>        1.57%  memmove
>        1.45%  free_unref_page_list
>
>     patch1-6
>       45.49%  lzo1x_1_do_compress (real work)
>        7.38%  page_vma_mapped_walk
>        7.24%  _raw_spin_unlock_irq
>        2.64%  ptep_clear_flush
>        2.31%  __zram_bvec_write
>        2.13%  do_raw_spin_lock
>        2.09%  lru_gen_look_around
>        1.89%  free_unref_page_list
>        1.85%  memmove
>        1.74%  obj_malloc
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
> ---
>  include/linux/memcontrol.h |  31 ++++++++
>  include/linux/mm.h         |   5 ++
>  include/linux/mmzone.h     |   6 ++
>  include/linux/swap.h       |   1 +
>  mm/memcontrol.c            |   1 +
>  mm/rmap.c                  |   7 ++
>  mm/swap.c                  |   4 +-
>  mm/vmscan.c                | 155 +++++++++++++++++++++++++++++++++++++
>  8 files changed, 208 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0abbd685703b..c8ce74577290 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -437,6 +437,7 @@ static inline struct obj_cgroup *__folio_objcg(struct=
 folio *folio)
>   * - LRU isolation
>   * - lock_page_memcg()
>   * - exclusive reference
> + * - mem_cgroup_trylock_pages()
>   *
>   * For a kmem folio a caller should hold an rcu read lock to protect mem=
cg
>   * associated with a kmem folio from being released.
> @@ -498,6 +499,7 @@ static inline struct mem_cgroup *folio_memcg_rcu(stru=
ct folio *folio)
>   * - LRU isolation
>   * - lock_page_memcg()
>   * - exclusive reference
> + * - mem_cgroup_trylock_pages()
>   *
>   * For a kmem page a caller should hold an rcu read lock to protect memc=
g
>   * associated with a kmem page from being released.
> @@ -935,6 +937,23 @@ void unlock_page_memcg(struct page *page);
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
> @@ -1372,6 +1391,18 @@ static inline void folio_memcg_unlock(struct folio=
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
> index 1e3e6dd90c0f..1f3695e95942 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1588,6 +1588,11 @@ static inline unsigned long folio_pfn(struct folio=
 *folio)
>         return page_to_pfn(&folio->page);
>  }
>
> +static inline struct folio *pfn_folio(unsigned long pfn)
> +{
> +       return page_folio(pfn_to_page(pfn));
> +}
> +
>  /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
>  #ifdef CONFIG_MIGRATION
>  static inline bool is_pinnable_page(struct page *page)
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 307c5c24c7ac..cd64c64a952d 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -359,6 +359,7 @@ enum lruvec_flags {
>  #ifndef __GENERATING_BOUNDS_H
>
>  struct lruvec;
> +struct page_vma_mapped_walk;
>
>  #define LRU_GEN_MASK           ((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOF=
F)
>  #define LRU_REFS_MASK          ((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PG=
OFF)
> @@ -411,6 +412,7 @@ struct lru_gen_struct {
>  };
>
>  void lru_gen_init_lruvec(struct lruvec *lruvec);
> +void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
>
>  #ifdef CONFIG_MEMCG
>  void lru_gen_init_memcg(struct mem_cgroup *memcg);
> @@ -423,6 +425,10 @@ static inline void lru_gen_init_lruvec(struct lruvec=
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
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 1d38d9475c4d..b37520d3ff1d 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -372,6 +372,7 @@ extern void lru_add_drain(void);
>  extern void lru_add_drain_cpu(int cpu);
>  extern void lru_add_drain_cpu_zone(struct zone *zone);
>  extern void lru_add_drain_all(void);
> +extern void folio_activate(struct folio *folio);
>  extern void deactivate_file_page(struct page *page);
>  extern void deactivate_page(struct page *page);
>  extern void mark_page_lazyfree(struct page *page);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3fcbfeda259b..e4c30950aa3c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2744,6 +2744,7 @@ static void commit_charge(struct folio *folio, stru=
ct mem_cgroup *memcg)
>          * - LRU isolation
>          * - lock_page_memcg()
>          * - exclusive reference
> +        * - mem_cgroup_trylock_pages()
>          */
>         folio->memcg_data =3D (unsigned long)memcg;
>  }
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 6a1e8c7f6213..112e77dc62f4 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -73,6 +73,7 @@
>  #include <linux/page_idle.h>
>  #include <linux/memremap.h>
>  #include <linux/userfaultfd_k.h>
> +#include <linux/mm_inline.h>
>
>  #include <asm/tlbflush.h>
>
> @@ -819,6 +820,12 @@ static bool page_referenced_one(struct page *page, s=
truct vm_area_struct *vma,
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
> index f5c0bcac8dcd..e65e7520bebf 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -344,7 +344,7 @@ static bool need_activate_page_drain(int cpu)
>         return pagevec_count(&per_cpu(lru_pvecs.activate_page, cpu)) !=3D=
 0;
>  }
>
> -static void folio_activate(struct folio *folio)
> +void folio_activate(struct folio *folio)
>  {
>         if (folio_test_lru(folio) && !folio_test_active(folio) &&
>             !folio_test_unevictable(folio)) {
> @@ -364,7 +364,7 @@ static inline void activate_page_drain(int cpu)
>  {
>  }
>
> -static void folio_activate(struct folio *folio)
> +void folio_activate(struct folio *folio)
>  {
>         struct lruvec *lruvec;
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 91a827ff665d..2b685aa0379c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1558,6 +1558,11 @@ static unsigned int shrink_page_list(struct list_h=
ead *page_list,
>                 if (!sc->may_unmap && page_mapped(page))
>                         goto keep_locked;
>
> +               /* folio_update_gen() tried to promote this page? */
> +               if (lru_gen_enabled() && !ignore_references &&
> +                   page_mapped(page) && PageReferenced(page))
> +                       goto keep_locked;
> +
>                 may_enter_fs =3D (sc->gfp_mask & __GFP_FS) ||
>                         (PageSwapCache(page) && (sc->gfp_mask & __GFP_IO)=
);
>
> @@ -3225,6 +3230,31 @@ static bool positive_ctrl_err(struct ctrl_pos *sp,=
 struct ctrl_pos *pv)
>   *                          the aging
>   ***********************************************************************=
*******/
>
> +static int folio_update_gen(struct folio *folio, int gen)
> +{
> +       unsigned long old_flags, new_flags;
> +
> +       VM_BUG_ON(gen >=3D MAX_NR_GENS);
> +       VM_BUG_ON(!rcu_read_lock_held());
> +
> +       do {
> +               new_flags =3D old_flags =3D READ_ONCE(folio->flags);
> +
> +               /* for shrink_page_list() */
> +               if (!(new_flags & LRU_GEN_MASK)) {
> +                       new_flags |=3D BIT(PG_referenced);
> +                       continue;
> +               }
> +
> +               new_flags &=3D ~LRU_GEN_MASK;
> +               new_flags |=3D (gen + 1UL) << LRU_GEN_PGOFF;
> +               new_flags &=3D ~(LRU_REFS_MASK | LRU_REFS_FLAGS);
> +       } while (new_flags !=3D old_flags &&
> +                cmpxchg(&folio->flags, old_flags, new_flags) !=3D old_fl=
ags);
> +
> +       return ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> +}
> +
>  static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, boo=
l reclaiming)
>  {
>         unsigned long old_flags, new_flags;
> @@ -3237,6 +3267,10 @@ static int folio_inc_gen(struct lruvec *lruvec, st=
ruct folio *folio, bool reclai
>                 VM_BUG_ON_FOLIO(!(new_flags & LRU_GEN_MASK), folio);
>
>                 new_gen =3D ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF)=
 - 1;
> +               /* folio_update_gen() has promoted this page? */
> +               if (new_gen >=3D 0 && new_gen !=3D old_gen)
> +                       return new_gen;
> +
>                 new_gen =3D (old_gen + 1) % MAX_NR_GENS;
>
>                 new_flags &=3D ~LRU_GEN_MASK;
> @@ -3438,6 +3472,122 @@ static void lru_gen_age_node(struct pglist_data *=
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
> +       struct folio *folio;
> +       unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)] =3D {};
> +       struct mem_cgroup *memcg =3D page_memcg(pvmw->page);
> +       struct pglist_data *pgdat =3D page_pgdat(pvmw->page);
> +       struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
> +       DEFINE_MAX_SEQ(lruvec);
> +       int old_gen, new_gen =3D lru_gen_from_seq(max_seq);
> +
> +       lockdep_assert_held(pvmw->ptl);
> +       VM_BUG_ON_PAGE(PageLRU(pvmw->page), pvmw->page);
> +
> +       start =3D max(pvmw->address & PMD_MASK, pvmw->vma->vm_start);
> +       end =3D pmd_addr_end(pvmw->address, pvmw->vma->vm_end);
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
> +               unsigned long pfn =3D pte_pfn(pte[i]);
> +
> +               VM_BUG_ON(addr < pvmw->vma->vm_start || addr >=3D pvmw->v=
ma->vm_end);
> +
> +               if (!pte_present(pte[i]) || is_zero_pfn(pfn))
> +                       continue;
> +
> +               if (WARN_ON_ONCE(pte_devmap(pte[i]) || pte_special(pte[i]=
)))
> +                       continue;
> +
> +               if (!pte_young(pte[i]))
> +                       continue;
> +
> +               VM_BUG_ON(!pfn_valid(pfn));
> +               if (pfn < pgdat->node_start_pfn || pfn >=3D pgdat_end_pfn=
(pgdat))
> +                       continue;
> +
> +               folio =3D pfn_folio(pfn);
> +               if (folio_nid(folio) !=3D pgdat->node_id)
> +                       continue;
> +
> +               if (folio_memcg_rcu(folio) !=3D memcg)
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
> +                       folio =3D page_folio(pte_page(pte[i]));
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
> +               folio =3D page_folio(pte_page(pte[i]));
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
> @@ -3471,6 +3621,11 @@ static bool sort_folio(struct lruvec *lruvec, stru=
ct folio *folio, int tier_idx)
>                 return true;
>         }
>
> +       if (gen !=3D lru_gen_from_seq(lrugen->min_seq[type])) {
> +               list_move(&folio->lru, &lrugen->lists[gen][type][zone]);
> +               return true;
> +       }
> +
>         if (tier > tier_idx) {
>                 int hist =3D lru_hist_from_seq(lrugen->min_seq[type]);
>
> --
> 2.35.1.616.g0bdcbb4464-goog
>

Thanks
Barry
