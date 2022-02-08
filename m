Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C4C4AD309
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349265AbiBHIUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349097AbiBHITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:19:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DBFC03FEC3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:19:36 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m10-20020a25800a000000b0061daa5b7151so11730056ybk.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=mlBJxyMkItOu6IgMi+GHvGvX+5G+zwrvhk7GXBAZ5bk=;
        b=RXdHgs+QjQ1IbSZQs8+/R5bHm6h48lbp9WYhrPRLkpRFMDsiZmIsxL1umsK3+Ez+4X
         mXZlUcPgbU1dvKd0nl4yD885R2A5XyhpoxRdiuwFgrdpyTM3xHvG/5gpX/0eDyoDzkP6
         5KqmeRY2K3W4MPiBLEKb0m0rOOwgfRfuoggcoZ3tRN940zaUf1E5FlnUYFRcGxjqibtB
         1K93nUemHaZ4LW35fX6TU+FYjrJ5TkZAp+UXkJkqykYPaX7tBs1WoW9kIPkEDbCZVOhL
         /zA2+tqDDCWbFQtue1NBQnfBomKzIEt+VyAqecJ/FfYIzBMNIxT1+5fqdXOutkV9SyPN
         G0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=mlBJxyMkItOu6IgMi+GHvGvX+5G+zwrvhk7GXBAZ5bk=;
        b=L5FrdehziQAaoxLDEPz0EEwIr4EVjEb+9oaKWKiNemiRPl8bVKSYKepL6oAVKvpVop
         Iak3qo7E/j+536GW5C/MuLH6dctqE5+mnig4sbyU3E/x3PmktVEStQfwdWtwBE3+XJOT
         b/Lr9g35qH2mINU6DgCjwsN5Bc9BfsLGGErvaqZdmfRhvKuhl6Fg7rCBCHQ5bvxOsd7F
         90sTpeKTneDbxgopkHJ1sf5JOSnUhLWAaBfxkjHQAM/M23oFWOmyLskl6OzQEYB76h0/
         2BCM3Br7pZ7O2mYBCT/rC48NzQ8E7IFZ0pN8VQ6OuCTx8EAuzMOn7/+v7VrGW0uKqy7W
         zzkw==
X-Gm-Message-State: AOAM5304wxDx2vvrsGSIM2o5rsrspYojZb7kPhhoMJ/8Ke+SXbNoXFuP
        NONZ1wEn5mRTNJU60r8y+3RZgz+Vicg=
X-Google-Smtp-Source: ABdhPJzKibHc4pzcQGPQRJzl4ovcyubmt0fHiy42kZ9jM5sd+Quj96FPbdHEwtKXbvgY863CeMe5Dq9dTA8=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5f31:19c3:21f5:7300])
 (user=yuzhao job=sendgmr) by 2002:a5b:551:: with SMTP id r17mr3537349ybp.54.1644308375675;
 Tue, 08 Feb 2022 00:19:35 -0800 (PST)
Date:   Tue,  8 Feb 2022 01:18:56 -0700
In-Reply-To: <20220208081902.3550911-1-yuzhao@google.com>
Message-Id: <20220208081902.3550911-7-yuzhao@google.com>
Mime-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 06/12] mm: multigenerational LRU: exploit locality in rmap
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        "=?UTF-8?q?Holger=20Hoffst=C3=A4tte?=" 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Searching the rmap for PTEs mapping each page on an LRU list (to test
and clear the accessed bit) can be expensive because pages from
different VMAs aren't cache friendly to the rmap. For workloads mostly
using mapped pages, the rmap has a high CPU cost in the reclaim path.

This patch exploits spatial locality to reduce the trips into the
rmap. When shrink_page_list() walks the rmap and finds a young PTE, a
new function lru_gen_look_around() scans at most BITS_PER_LONG-1
adjacent PTEs. On finding another young PTE, it clears the accessed
bit and updates the gen counter of the page mapped by this PTE to
(max_seq%MAX_NR_GENS)+1.

Server benchmark results:
  Single workload:
    fio (buffered I/O): no change

  Single workload:
    memcached (anon): +[3.5, 5.5]%
                Ops/sec      KB/sec
      patch1-5: 972526.07    37826.95
      patch1-6: 1015292.83   39490.38

  Configurations:
    no change

Client benchmark results:
  kswapd profiles:
    patch1-5
      39.73%  lzo1x_1_do_compress (real work)
      14.96%  page_vma_mapped_walk
       6.97%  _raw_spin_unlock_irq
       3.07%  do_raw_spin_lock
       2.53%  anon_vma_interval_tree_iter_first
       2.04%  ptep_clear_flush
       1.82%  __zram_bvec_write
       1.76%  __anon_vma_interval_tree_subtree_search
       1.57%  memmove
       1.45%  free_unref_page_list

    patch1-6
      45.49%  lzo1x_1_do_compress (real work)
       7.38%  page_vma_mapped_walk
       7.24%  _raw_spin_unlock_irq
       2.64%  ptep_clear_flush
       2.31%  __zram_bvec_write
       2.13%  do_raw_spin_lock
       2.09%  lru_gen_look_around
       1.89%  free_unref_page_list
       1.85%  memmove
       1.74%  obj_malloc

  Configurations:
    no change

Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Brian Geffon <bgeffon@google.com>
Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Acked-by: Steven Barrett <steven@liquorix.net>
Acked-by: Suleiman Souhlal <suleiman@google.com>
Tested-by: Daniel Byrne <djbyrne@mtu.edu>
Tested-by: Donald Carr <d@chaos-reins.com>
Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
Tested-by: Sofia Trinh <sofia.trinh@edi.works>
---
 include/linux/memcontrol.h |  31 ++++++++
 include/linux/mm.h         |   5 ++
 include/linux/mmzone.h     |   6 ++
 include/linux/swap.h       |   1 +
 mm/memcontrol.c            |   1 +
 mm/rmap.c                  |   7 ++
 mm/swap.c                  |   4 +-
 mm/vmscan.c                | 155 +++++++++++++++++++++++++++++++++++++
 8 files changed, 208 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b72d75141e12..51c9bc8e965d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -436,6 +436,7 @@ static inline struct obj_cgroup *__folio_objcg(struct f=
olio *folio)
  * - LRU isolation
  * - lock_page_memcg()
  * - exclusive reference
+ * - mem_cgroup_trylock_pages()
  *
  * For a kmem folio a caller should hold an rcu read lock to protect memcg
  * associated with a kmem folio from being released.
@@ -497,6 +498,7 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct=
 folio *folio)
  * - LRU isolation
  * - lock_page_memcg()
  * - exclusive reference
+ * - mem_cgroup_trylock_pages()
  *
  * For a kmem page a caller should hold an rcu read lock to protect memcg
  * associated with a kmem page from being released.
@@ -934,6 +936,23 @@ void unlock_page_memcg(struct page *page);
=20
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
=20
+/* try to stablize folio_memcg() for all the pages in a memcg */
+static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
+{
+	rcu_read_lock();
+
+	if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_account))
+		return true;
+
+	rcu_read_unlock();
+	return false;
+}
+
+static inline void mem_cgroup_unlock_pages(void)
+{
+	rcu_read_unlock();
+}
+
 /* idx can be of type enum memcg_stat_item or node_stat_item */
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
 				   int idx, int val)
@@ -1371,6 +1390,18 @@ static inline void folio_memcg_unlock(struct folio *=
folio)
 {
 }
=20
+static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
+{
+	/* to match folio_memcg_rcu() */
+	rcu_read_lock();
+	return true;
+}
+
+static inline void mem_cgroup_unlock_pages(void)
+{
+	rcu_read_unlock();
+}
+
 static inline void mem_cgroup_handle_over_high(void)
 {
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b4b9886ba277..7d70b42b67e1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1588,6 +1588,11 @@ static inline unsigned long folio_pfn(struct folio *=
folio)
 	return page_to_pfn(&folio->page);
 }
=20
+static inline struct folio *pfn_folio(unsigned long pfn)
+{
+	return page_folio(pfn_to_page(pfn));
+}
+
 /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
 #ifdef CONFIG_MIGRATION
 static inline bool is_pinnable_page(struct page *page)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3870dd9246a2..3d6ea30a2bdb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -304,6 +304,7 @@ enum lruvec_flags {
 };
=20
 struct lruvec;
+struct page_vma_mapped_walk;
=20
 #define LRU_GEN_MASK		((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOFF)
 #define LRU_REFS_MASK		((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PGOFF)
@@ -386,6 +387,7 @@ struct lru_gen_struct {
 };
=20
 void lru_gen_init_state(struct mem_cgroup *memcg, struct lruvec *lruvec);
+void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
=20
 #ifdef CONFIG_MEMCG
 void lru_gen_init_memcg(struct mem_cgroup *memcg);
@@ -398,6 +400,10 @@ static inline void lru_gen_init_state(struct mem_cgrou=
p *memcg, struct lruvec *l
 {
 }
=20
+static inline void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
+{
+}
+
 #ifdef CONFIG_MEMCG
 static inline void lru_gen_init_memcg(struct mem_cgroup *memcg)
 {
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1d38d9475c4d..b37520d3ff1d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -372,6 +372,7 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
+extern void folio_activate(struct folio *folio);
 extern void deactivate_file_page(struct page *page);
 extern void deactivate_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cabb5085531b..74373df19d84 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2744,6 +2744,7 @@ static void commit_charge(struct folio *folio, struct=
 mem_cgroup *memcg)
 	 * - LRU isolation
 	 * - lock_page_memcg()
 	 * - exclusive reference
+	 * - mem_cgroup_trylock_pages()
 	 */
 	folio->memcg_data =3D (unsigned long)memcg;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 6a1e8c7f6213..112e77dc62f4 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -73,6 +73,7 @@
 #include <linux/page_idle.h>
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/mm_inline.h>
=20
 #include <asm/tlbflush.h>
=20
@@ -819,6 +820,12 @@ static bool page_referenced_one(struct page *page, str=
uct vm_area_struct *vma,
 		}
=20
 		if (pvmw.pte) {
+			if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
+			    !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
+				lru_gen_look_around(&pvmw);
+				referenced++;
+			}
+
 			if (ptep_clear_flush_young_notify(vma, address,
 						pvmw.pte)) {
 				/*
diff --git a/mm/swap.c b/mm/swap.c
index f5c0bcac8dcd..e65e7520bebf 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -344,7 +344,7 @@ static bool need_activate_page_drain(int cpu)
 	return pagevec_count(&per_cpu(lru_pvecs.activate_page, cpu)) !=3D 0;
 }
=20
-static void folio_activate(struct folio *folio)
+void folio_activate(struct folio *folio)
 {
 	if (folio_test_lru(folio) && !folio_test_active(folio) &&
 	    !folio_test_unevictable(folio)) {
@@ -364,7 +364,7 @@ static inline void activate_page_drain(int cpu)
 {
 }
=20
-static void folio_activate(struct folio *folio)
+void folio_activate(struct folio *folio)
 {
 	struct lruvec *lruvec;
=20
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5f0d92838712..933d46ae2f68 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1556,6 +1556,11 @@ static unsigned int shrink_page_list(struct list_hea=
d *page_list,
 		if (!sc->may_unmap && page_mapped(page))
 			goto keep_locked;
=20
+		/* folio_update_gen() tried to promote this page? */
+		if (lru_gen_enabled() && !ignore_references &&
+		    page_mapped(page) && PageReferenced(page))
+			goto keep_locked;
+
 		may_enter_fs =3D (sc->gfp_mask & __GFP_FS) ||
 			(PageSwapCache(page) && (sc->gfp_mask & __GFP_IO));
=20
@@ -3227,6 +3232,31 @@ static bool positive_ctrl_err(struct ctrl_pos *sp, s=
truct ctrl_pos *pv)
  *                          the aging
  *************************************************************************=
*****/
=20
+static int folio_update_gen(struct folio *folio, int gen)
+{
+	unsigned long old_flags, new_flags;
+
+	VM_BUG_ON(gen >=3D MAX_NR_GENS);
+	VM_BUG_ON(!rcu_read_lock_held());
+
+	do {
+		new_flags =3D old_flags =3D READ_ONCE(folio->flags);
+
+		/* for shrink_page_list() */
+		if (!(new_flags & LRU_GEN_MASK)) {
+			new_flags |=3D BIT(PG_referenced);
+			continue;
+		}
+
+		new_flags &=3D ~LRU_GEN_MASK;
+		new_flags |=3D (gen + 1UL) << LRU_GEN_PGOFF;
+		new_flags &=3D ~(LRU_REFS_MASK | LRU_REFS_FLAGS);
+	} while (new_flags !=3D old_flags &&
+		 cmpxchg(&folio->flags, old_flags, new_flags) !=3D old_flags);
+
+	return ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
+}
+
 static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool =
reclaiming)
 {
 	unsigned long old_flags, new_flags;
@@ -3239,6 +3269,10 @@ static int folio_inc_gen(struct lruvec *lruvec, stru=
ct folio *folio, bool reclai
 		VM_BUG_ON_FOLIO(!(new_flags & LRU_GEN_MASK), folio);
=20
 		new_gen =3D ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
+		/* folio_update_gen() has promoted this page? */
+		if (new_gen >=3D 0 && new_gen !=3D old_gen)
+			return new_gen;
+
 		new_gen =3D (old_gen + 1) % MAX_NR_GENS;
=20
 		new_flags &=3D ~LRU_GEN_MASK;
@@ -3434,6 +3468,122 @@ static void lru_gen_age_node(struct pglist_data *pg=
dat, struct scan_control *sc)
 	} while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)));
 }
=20
+/*
+ * This function exploits spatial locality when shrink_page_list() walks t=
he
+ * rmap. It scans the adjacent PTEs of a young PTE and promotes hot pages.
+ */
+void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
+{
+	int i;
+	pte_t *pte;
+	unsigned long start;
+	unsigned long end;
+	unsigned long addr;
+	struct folio *folio;
+	unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)] =3D {};
+	struct mem_cgroup *memcg =3D page_memcg(pvmw->page);
+	struct pglist_data *pgdat =3D page_pgdat(pvmw->page);
+	struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
+	DEFINE_MAX_SEQ(lruvec);
+	int old_gen, new_gen =3D lru_gen_from_seq(max_seq);
+
+	lockdep_assert_held(pvmw->ptl);
+	VM_BUG_ON_PAGE(PageLRU(pvmw->page), pvmw->page);
+
+	start =3D max(pvmw->address & PMD_MASK, pvmw->vma->vm_start);
+	end =3D pmd_addr_end(pvmw->address, pvmw->vma->vm_end);
+
+	if (end - start > MIN_LRU_BATCH * PAGE_SIZE) {
+		if (pvmw->address - start < MIN_LRU_BATCH * PAGE_SIZE / 2)
+			end =3D start + MIN_LRU_BATCH * PAGE_SIZE;
+		else if (end - pvmw->address < MIN_LRU_BATCH * PAGE_SIZE / 2)
+			start =3D end - MIN_LRU_BATCH * PAGE_SIZE;
+		else {
+			start =3D pvmw->address - MIN_LRU_BATCH * PAGE_SIZE / 2;
+			end =3D pvmw->address + MIN_LRU_BATCH * PAGE_SIZE / 2;
+		}
+	}
+
+	pte =3D pvmw->pte - (pvmw->address - start) / PAGE_SIZE;
+
+	rcu_read_lock();
+	arch_enter_lazy_mmu_mode();
+
+	for (i =3D 0, addr =3D start; addr !=3D end; i++, addr +=3D PAGE_SIZE) {
+		unsigned long pfn =3D pte_pfn(pte[i]);
+
+		VM_BUG_ON(addr < pvmw->vma->vm_start || addr >=3D pvmw->vma->vm_end);
+
+		if (!pte_present(pte[i]) || is_zero_pfn(pfn))
+			continue;
+
+		if (WARN_ON_ONCE(pte_devmap(pte[i]) || pte_special(pte[i])))
+			continue;
+
+		if (!pte_young(pte[i]))
+			continue;
+
+		VM_BUG_ON(!pfn_valid(pfn));
+		if (pfn < pgdat->node_start_pfn || pfn >=3D pgdat_end_pfn(pgdat))
+			continue;
+
+		folio =3D pfn_folio(pfn);
+		if (folio_nid(folio) !=3D pgdat->node_id)
+			continue;
+
+		if (folio_memcg_rcu(folio) !=3D memcg)
+			continue;
+
+		if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
+			continue;
+
+		if (pte_dirty(pte[i]) && !folio_test_dirty(folio) &&
+		    !(folio_test_anon(folio) && folio_test_swapbacked(folio) &&
+		      !folio_test_swapcache(folio)))
+			folio_mark_dirty(folio);
+
+		old_gen =3D folio_lru_gen(folio);
+		if (old_gen < 0)
+			folio_set_referenced(folio);
+		else if (old_gen !=3D new_gen)
+			__set_bit(i, bitmap);
+	}
+
+	arch_leave_lazy_mmu_mode();
+	rcu_read_unlock();
+
+	if (bitmap_weight(bitmap, MIN_LRU_BATCH) < PAGEVEC_SIZE) {
+		for_each_set_bit(i, bitmap, MIN_LRU_BATCH) {
+			folio =3D page_folio(pte_page(pte[i]));
+			folio_activate(folio);
+		}
+		return;
+	}
+
+	/* folio_update_gen() requires stable folio_memcg() */
+	if (!mem_cgroup_trylock_pages(memcg))
+		return;
+
+	spin_lock_irq(&lruvec->lru_lock);
+	new_gen =3D lru_gen_from_seq(lruvec->lrugen.max_seq);
+
+	for_each_set_bit(i, bitmap, MIN_LRU_BATCH) {
+		folio =3D page_folio(pte_page(pte[i]));
+		if (folio_memcg_rcu(folio) !=3D memcg)
+			continue;
+
+		old_gen =3D folio_update_gen(folio, new_gen);
+		if (old_gen < 0 || old_gen =3D=3D new_gen)
+			continue;
+
+		lru_gen_balance_size(lruvec, folio, old_gen, new_gen);
+	}
+
+	spin_unlock_irq(&lruvec->lru_lock);
+
+	mem_cgroup_unlock_pages();
+}
+
 /*************************************************************************=
*****
  *                          the eviction
  *************************************************************************=
*****/
@@ -3467,6 +3617,11 @@ static bool sort_folio(struct lruvec *lruvec, struct=
 folio *folio, int tier_idx)
 		return true;
 	}
=20
+	if (gen !=3D lru_gen_from_seq(lrugen->min_seq[type])) {
+		list_move(&folio->lru, &lrugen->lists[gen][type][zone]);
+		return true;
+	}
+
 	if (tier > tier_idx) {
 		int hist =3D lru_hist_from_seq(lrugen->min_seq[type]);
=20
--=20
2.35.0.263.gb82422642f-goog

