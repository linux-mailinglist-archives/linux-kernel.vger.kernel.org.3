Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0264A4AA0AD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiBDUBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbiBDT7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA367C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=i03C4QmR6tkCfUBcEjwkbFXFH/w7J+MEaVtPdVUZUno=; b=b21g4df9MSwecHORuNBY5Sl7wM
        gzXVfWWjXzdTuit6aSgeArQ0Fp/H7CLdsgYwF4CwjS9rNNTNHgdKoU34q0qaOp/jHGvQ3mnTG7Foo
        uOJkMvAHyG5tuUF7J9iWdUreodoaRVYGjMIM90d5EFdHnxY06RKXxRbuob7Hy9YOFP9HYScRvTRuv
        EqOiiFgrNB41oWnjOmO3T8Fusi4Qx2ov/a1LpdAqkTDNWj+jZjh97aXhNgI7SjpsdKWmAR0IqYl4R
        X850Ku09aEa0SqwaDo1x5Borvbeeh/XdMvb0OwMM1J6ODR+wp/L5SFdF3WcFPPHLRdl69f+uVlm62
        iznqo9Yw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4ja-007Lpb-7O; Fri, 04 Feb 2022 19:59:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 59/75] mm/rmap: Convert rmap_walk() to take a folio
Date:   Fri,  4 Feb 2022 19:58:36 +0000
Message-Id: <20220204195852.1751729-60-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ripples all the way through to every calling and called function
from rmap.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/ksm.h  |   4 +-
 include/linux/rmap.h |  11 ++--
 mm/damon/paddr.c     |  17 +++---
 mm/folio-compat.c    |   5 --
 mm/huge_memory.c     |   2 +-
 mm/ksm.c             |  12 ++--
 mm/migrate.c         |  12 ++--
 mm/page_idle.c       |   9 ++-
 mm/rmap.c            | 128 ++++++++++++++++++++-----------------------
 9 files changed, 91 insertions(+), 109 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index a38a5bca1ba5..0b4f17418f64 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -51,7 +51,7 @@ static inline void ksm_exit(struct mm_struct *mm)
 struct page *ksm_might_need_to_copy(struct page *page,
 			struct vm_area_struct *vma, unsigned long address);
 
-void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc);
+void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc);
 void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
 
 #else  /* !CONFIG_KSM */
@@ -78,7 +78,7 @@ static inline struct page *ksm_might_need_to_copy(struct page *page,
 	return page;
 }
 
-static inline void rmap_walk_ksm(struct page *page,
+static inline void rmap_walk_ksm(struct folio *folio,
 			struct rmap_walk_control *rwc)
 {
 }
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 71798112a575..4e4c4412b295 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -268,7 +268,6 @@ void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
 /*
  * Called by memory-failure.c to kill processes.
  */
-struct anon_vma *page_lock_anon_vma_read(struct page *page);
 struct anon_vma *folio_lock_anon_vma_read(struct folio *folio);
 void page_unlock_anon_vma_read(struct anon_vma *anon_vma);
 int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma);
@@ -288,15 +287,15 @@ struct rmap_walk_control {
 	 * Return false if page table scanning in rmap_walk should be stopped.
 	 * Otherwise, return true.
 	 */
-	bool (*rmap_one)(struct page *page, struct vm_area_struct *vma,
+	bool (*rmap_one)(struct folio *folio, struct vm_area_struct *vma,
 					unsigned long addr, void *arg);
-	int (*done)(struct page *page);
-	struct anon_vma *(*anon_lock)(struct page *page);
+	int (*done)(struct folio *folio);
+	struct anon_vma *(*anon_lock)(struct folio *folio);
 	bool (*invalid_vma)(struct vm_area_struct *vma, void *arg);
 };
 
-void rmap_walk(struct page *page, struct rmap_walk_control *rwc);
-void rmap_walk_locked(struct page *page, struct rmap_walk_control *rwc);
+void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc);
+void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc);
 
 #else	/* !CONFIG_MMU */
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 05e85a131a49..d336eafb74f8 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -16,7 +16,7 @@
 #include "../internal.h"
 #include "prmtv-common.h"
 
-static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
+static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long addr, void *arg)
 {
 	struct page_vma_mapped_walk pvmw = {
@@ -24,7 +24,7 @@ static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
 		.address = addr,
 	};
 
-	pvmw_set_page(&pvmw, page);
+	pvmw_set_folio(&pvmw, folio);
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte)
@@ -41,7 +41,7 @@ static void damon_pa_mkold(unsigned long paddr)
 	struct page *page = damon_get_page(PHYS_PFN(paddr));
 	struct rmap_walk_control rwc = {
 		.rmap_one = __damon_pa_mkold,
-		.anon_lock = page_lock_anon_vma_read,
+		.anon_lock = folio_lock_anon_vma_read,
 	};
 	bool need_lock;
 
@@ -58,7 +58,7 @@ static void damon_pa_mkold(unsigned long paddr)
 	if (need_lock && !folio_trylock(folio))
 		goto out;
 
-	rmap_walk(&folio->page, &rwc);
+	rmap_walk(folio, &rwc);
 
 	if (need_lock)
 		folio_unlock(folio);
@@ -91,17 +91,16 @@ struct damon_pa_access_chk_result {
 	bool accessed;
 };
 
-static bool __damon_pa_young(struct page *page, struct vm_area_struct *vma,
+static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long addr, void *arg)
 {
-	struct folio *folio = page_folio(page);
 	struct damon_pa_access_chk_result *result = arg;
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
 		.address = addr,
 	};
 
-	pvmw_set_page(&pvmw, page);
+	pvmw_set_folio(&pvmw, folio);
 	result->accessed = false;
 	result->page_sz = PAGE_SIZE;
 	while (page_vma_mapped_walk(&pvmw)) {
@@ -141,7 +140,7 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 	struct rmap_walk_control rwc = {
 		.arg = &result,
 		.rmap_one = __damon_pa_young,
-		.anon_lock = page_lock_anon_vma_read,
+		.anon_lock = folio_lock_anon_vma_read,
 	};
 	bool need_lock;
 
@@ -164,7 +163,7 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 		return NULL;
 	}
 
-	rmap_walk(&folio->page, &rwc);
+	rmap_walk(folio, &rwc);
 
 	if (need_lock)
 		folio_unlock(folio);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index e04fba5e45e5..3804fd8c1f20 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -185,8 +185,3 @@ void page_mlock(struct page *page)
 {
 	folio_mlock(page_folio(page));
 }
-
-struct anon_vma *page_lock_anon_vma_read(struct page *page)
-{
-	return folio_lock_anon_vma_read(page_folio(page));
-}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7a0f4aaf7838..f711dabc9c62 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2601,7 +2601,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		 * The caller does not necessarily hold an mmap_lock that would
 		 * prevent the anon_vma disappearing so we first we take a
 		 * reference to it and then lock the anon_vma for write. This
-		 * is similar to page_lock_anon_vma_read except the write lock
+		 * is similar to folio_lock_anon_vma_read except the write lock
 		 * is taken to serialise against parallel split or collapse
 		 * operations.
 		 */
diff --git a/mm/ksm.c b/mm/ksm.c
index 212186dbc89f..0ec3d9035419 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2601,21 +2601,21 @@ struct page *ksm_might_need_to_copy(struct page *page,
 	return new_page;
 }
 
-void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc)
+void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
 {
 	struct stable_node *stable_node;
 	struct rmap_item *rmap_item;
 	int search_new_forks = 0;
 
-	VM_BUG_ON_PAGE(!PageKsm(page), page);
+	VM_BUG_ON_FOLIO(!folio_test_ksm(folio), folio);
 
 	/*
 	 * Rely on the page lock to protect against concurrent modifications
 	 * to that page's node of the stable tree.
 	 */
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
-	stable_node = page_stable_node(page);
+	stable_node = folio_stable_node(folio);
 	if (!stable_node)
 		return;
 again:
@@ -2650,11 +2650,11 @@ void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc)
 			if (rwc->invalid_vma && rwc->invalid_vma(vma, rwc->arg))
 				continue;
 
-			if (!rwc->rmap_one(page, vma, addr, rwc->arg)) {
+			if (!rwc->rmap_one(folio, vma, addr, rwc->arg)) {
 				anon_vma_unlock_read(anon_vma);
 				return;
 			}
-			if (rwc->done && rwc->done(page)) {
+			if (rwc->done && rwc->done(folio)) {
 				anon_vma_unlock_read(anon_vma);
 				return;
 			}
diff --git a/mm/migrate.c b/mm/migrate.c
index 4daa8298c79a..e9f369a8ee15 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -173,18 +173,16 @@ void putback_movable_pages(struct list_head *l)
 /*
  * Restore a potential migration pte to a working pte entry
  */
-static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
-				 unsigned long addr, void *old)
+static bool remove_migration_pte(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr, void *old)
 {
-	struct folio *folio = page_folio(page);
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
 		.address = addr,
 		.flags = PVMW_SYNC | PVMW_MIGRATION,
 	};
 
-	VM_BUG_ON_PAGE(PageTail(page), page);
-	pvmw_set_page(&pvmw, old);
+	pvmw_set_folio(&pvmw, old);
 	while (page_vma_mapped_walk(&pvmw)) {
 		pte_t pte;
 		swp_entry_t entry;
@@ -278,9 +276,9 @@ void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked)
 	};
 
 	if (locked)
-		rmap_walk_locked(&dst->page, &rwc);
+		rmap_walk_locked(dst, &rwc);
 	else
-		rmap_walk(&dst->page, &rwc);
+		rmap_walk(dst, &rwc);
 }
 
 /*
diff --git a/mm/page_idle.c b/mm/page_idle.c
index 35e53db430df..3563c3850795 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -46,18 +46,17 @@ static struct page *page_idle_get_page(unsigned long pfn)
 	return page;
 }
 
-static bool page_idle_clear_pte_refs_one(struct page *page,
+static bool page_idle_clear_pte_refs_one(struct folio *folio,
 					struct vm_area_struct *vma,
 					unsigned long addr, void *arg)
 {
-	struct folio *folio = page_folio(page);
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
 		.address = addr,
 	};
 	bool referenced = false;
 
-	pvmw_set_page(&pvmw, page);
+	pvmw_set_folio(&pvmw, folio);
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
@@ -97,7 +96,7 @@ static void page_idle_clear_pte_refs(struct page *page)
 	 */
 	static const struct rmap_walk_control rwc = {
 		.rmap_one = page_idle_clear_pte_refs_one,
-		.anon_lock = page_lock_anon_vma_read,
+		.anon_lock = folio_lock_anon_vma_read,
 	};
 	bool need_lock;
 
@@ -108,7 +107,7 @@ static void page_idle_clear_pte_refs(struct page *page)
 	if (need_lock && !folio_trylock(folio))
 		return;
 
-	rmap_walk(&folio->page, (struct rmap_walk_control *)&rwc);
+	rmap_walk(folio, (struct rmap_walk_control *)&rwc);
 
 	if (need_lock)
 		folio_unlock(folio);
diff --git a/mm/rmap.c b/mm/rmap.c
index 8bbbbea483cf..1ade44970ab1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -107,15 +107,15 @@ static inline void anon_vma_free(struct anon_vma *anon_vma)
 	VM_BUG_ON(atomic_read(&anon_vma->refcount));
 
 	/*
-	 * Synchronize against page_lock_anon_vma_read() such that
+	 * Synchronize against folio_lock_anon_vma_read() such that
 	 * we can safely hold the lock without the anon_vma getting
 	 * freed.
 	 *
 	 * Relies on the full mb implied by the atomic_dec_and_test() from
 	 * put_anon_vma() against the acquire barrier implied by
-	 * down_read_trylock() from page_lock_anon_vma_read(). This orders:
+	 * down_read_trylock() from folio_lock_anon_vma_read(). This orders:
 	 *
-	 * page_lock_anon_vma_read()	VS	put_anon_vma()
+	 * folio_lock_anon_vma_read()	VS	put_anon_vma()
 	 *   down_read_trylock()		  atomic_dec_and_test()
 	 *   LOCK				  MB
 	 *   atomic_read()			  rwsem_is_locked()
@@ -168,7 +168,7 @@ static void anon_vma_chain_link(struct vm_area_struct *vma,
  * allocate a new one.
  *
  * Anon-vma allocations are very subtle, because we may have
- * optimistically looked up an anon_vma in page_lock_anon_vma_read()
+ * optimistically looked up an anon_vma in folio_lock_anon_vma_read()
  * and that may actually touch the rwsem even in the newly
  * allocated vma (it depends on RCU to make sure that the
  * anon_vma isn't actually destroyed).
@@ -799,10 +799,9 @@ struct page_referenced_arg {
 /*
  * arg: page_referenced_arg will be passed
  */
-static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
+static bool page_referenced_one(struct folio *folio, struct vm_area_struct *vma,
 			unsigned long address, void *arg)
 {
-	struct folio *folio = page_folio(page);
 	struct page_referenced_arg *pra = arg;
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
@@ -810,7 +809,7 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 	};
 	int referenced = 0;
 
-	pvmw_set_page(&pvmw, page);
+	pvmw_set_folio(&pvmw, folio);
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
@@ -895,7 +894,7 @@ int folio_referenced(struct folio *folio, int is_locked,
 	struct rmap_walk_control rwc = {
 		.rmap_one = page_referenced_one,
 		.arg = (void *)&pra,
-		.anon_lock = page_lock_anon_vma_read,
+		.anon_lock = folio_lock_anon_vma_read,
 	};
 
 	*vm_flags = 0;
@@ -920,7 +919,7 @@ int folio_referenced(struct folio *folio, int is_locked,
 		rwc.invalid_vma = invalid_page_referenced_vma;
 	}
 
-	rmap_walk(&folio->page, &rwc);
+	rmap_walk(folio, &rwc);
 	*vm_flags = pra.vm_flags;
 
 	if (we_locked)
@@ -929,10 +928,9 @@ int folio_referenced(struct folio *folio, int is_locked,
 	return pra.referenced;
 }
 
-static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
+static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
 			    unsigned long address, void *arg)
 {
-	struct folio *folio = page_folio(page);
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
 		.address = address,
@@ -941,7 +939,7 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	int *cleaned = arg;
 
-	pvmw_set_page(&pvmw, page);
+	pvmw_set_folio(&pvmw, folio);
 	/*
 	 * We have to assume the worse case ie pmd for invalidation. Note that
 	 * the folio can not be freed from this function.
@@ -1031,7 +1029,7 @@ int folio_mkclean(struct folio *folio)
 	if (!mapping)
 		return 0;
 
-	rmap_walk(&folio->page, &rwc);
+	rmap_walk(folio, &rwc);
 
 	return cleaned;
 }
@@ -1422,10 +1420,9 @@ void page_remove_rmap(struct page *page, bool compound)
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
-static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
+static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		     unsigned long address, void *arg)
 {
-	struct folio *folio = page_folio(page);
 	struct mm_struct *mm = vma->vm_mm;
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
@@ -1437,7 +1434,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 
-	pvmw_set_page(&pvmw, page);
+	pvmw_set_folio(&pvmw, folio);
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
 	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
@@ -1690,9 +1687,9 @@ static bool invalid_migration_vma(struct vm_area_struct *vma, void *arg)
 	return vma_is_temporary_stack(vma);
 }
 
-static int page_not_mapped(struct page *page)
+static int page_not_mapped(struct folio *folio)
 {
-	return !page_mapped(page);
+	return !folio_mapped(folio);
 }
 
 /**
@@ -1712,13 +1709,13 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
 		.rmap_one = try_to_unmap_one,
 		.arg = (void *)flags,
 		.done = page_not_mapped,
-		.anon_lock = page_lock_anon_vma_read,
+		.anon_lock = folio_lock_anon_vma_read,
 	};
 
 	if (flags & TTU_RMAP_LOCKED)
-		rmap_walk_locked(&folio->page, &rwc);
+		rmap_walk_locked(folio, &rwc);
 	else
-		rmap_walk(&folio->page, &rwc);
+		rmap_walk(folio, &rwc);
 }
 
 /*
@@ -1727,10 +1724,9 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
  * If TTU_SPLIT_HUGE_PMD is specified any PMD mappings will be split into PTEs
  * containing migration entries.
  */
-static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
+static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		     unsigned long address, void *arg)
 {
-	struct folio *folio = page_folio(page);
 	struct mm_struct *mm = vma->vm_mm;
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
@@ -1742,7 +1738,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 
-	pvmw_set_page(&pvmw, page);
+	pvmw_set_folio(&pvmw, folio);
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
 	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
@@ -1976,7 +1972,7 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 		.rmap_one = try_to_migrate_one,
 		.arg = (void *)flags,
 		.done = page_not_mapped,
-		.anon_lock = page_lock_anon_vma_read,
+		.anon_lock = folio_lock_anon_vma_read,
 	};
 
 	/*
@@ -2002,25 +1998,24 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 		rwc.invalid_vma = invalid_migration_vma;
 
 	if (flags & TTU_RMAP_LOCKED)
-		rmap_walk_locked(&folio->page, &rwc);
+		rmap_walk_locked(folio, &rwc);
 	else
-		rmap_walk(&folio->page, &rwc);
+		rmap_walk(folio, &rwc);
 }
 
 /*
  * Walks the vma's mapping a page and mlocks the page if any locked vma's are
  * found. Once one is found the page is locked and the scan can be terminated.
  */
-static bool page_mlock_one(struct page *page, struct vm_area_struct *vma,
+static bool page_mlock_one(struct folio *folio, struct vm_area_struct *vma,
 				 unsigned long address, void *unused)
 {
-	struct folio *folio = page_folio(page);
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
 		.address = address,
 	};
 
-	pvmw_set_page(&pvmw, page);
+	pvmw_set_folio(&pvmw, folio);
 	/* An un-locked vma doesn't have any pages to lock, continue the scan */
 	if (!(vma->vm_flags & VM_LOCKED))
 		return true;
@@ -2064,7 +2059,7 @@ void folio_mlock(struct folio *folio)
 	struct rmap_walk_control rwc = {
 		.rmap_one = page_mlock_one,
 		.done = page_not_mapped,
-		.anon_lock = page_lock_anon_vma_read,
+		.anon_lock = folio_lock_anon_vma_read,
 
 	};
 
@@ -2077,7 +2072,7 @@ void folio_mlock(struct folio *folio)
 	if (folio_test_large(folio) && folio_test_anon(folio))
 		return;
 
-	rmap_walk(&folio->page, &rwc);
+	rmap_walk(folio, &rwc);
 }
 
 #ifdef CONFIG_DEVICE_PRIVATE
@@ -2088,10 +2083,9 @@ struct make_exclusive_args {
 	bool valid;
 };
 
-static bool page_make_device_exclusive_one(struct page *page,
+static bool page_make_device_exclusive_one(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long address, void *priv)
 {
-	struct folio *folio = page_folio(page);
 	struct mm_struct *mm = vma->vm_mm;
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
@@ -2105,7 +2099,7 @@ static bool page_make_device_exclusive_one(struct page *page,
 	swp_entry_t entry;
 	pte_t swp_pte;
 
-	pvmw_set_page(&pvmw, page);
+	pvmw_set_folio(&pvmw, folio);
 	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_EXCLUSIVE, 0, vma,
 				      vma->vm_mm, address, min(vma->vm_end,
 				      address + folio_size(folio)),
@@ -2199,7 +2193,7 @@ static bool folio_make_device_exclusive(struct folio *folio,
 	struct rmap_walk_control rwc = {
 		.rmap_one = page_make_device_exclusive_one,
 		.done = page_not_mapped,
-		.anon_lock = page_lock_anon_vma_read,
+		.anon_lock = folio_lock_anon_vma_read,
 		.arg = &args,
 	};
 
@@ -2210,7 +2204,7 @@ static bool folio_make_device_exclusive(struct folio *folio,
 	if (!folio_test_anon(folio))
 		return false;
 
-	rmap_walk(&folio->page, &rwc);
+	rmap_walk(folio, &rwc);
 
 	return args.valid && !folio_mapcount(folio);
 }
@@ -2278,17 +2272,16 @@ void __put_anon_vma(struct anon_vma *anon_vma)
 		anon_vma_free(root);
 }
 
-static struct anon_vma *rmap_walk_anon_lock(struct page *page,
+static struct anon_vma *rmap_walk_anon_lock(struct folio *folio,
 					struct rmap_walk_control *rwc)
 {
-	struct folio *folio = page_folio(page);
 	struct anon_vma *anon_vma;
 
 	if (rwc->anon_lock)
-		return rwc->anon_lock(page);
+		return rwc->anon_lock(folio);
 
 	/*
-	 * Note: remove_migration_ptes() cannot use page_lock_anon_vma_read()
+	 * Note: remove_migration_ptes() cannot use folio_lock_anon_vma_read()
 	 * because that depends on page_mapped(); but not all its usages
 	 * are holding mmap_lock. Users without mmap_lock are required to
 	 * take a reference count to prevent the anon_vma disappearing
@@ -2315,10 +2308,9 @@ static struct anon_vma *rmap_walk_anon_lock(struct page *page,
  * vm_flags for that VMA.  That should be OK, because that vma shouldn't be
  * LOCKED.
  */
-static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
+static void rmap_walk_anon(struct folio *folio, struct rmap_walk_control *rwc,
 		bool locked)
 {
-	struct folio *folio = page_folio(page);
 	struct anon_vma *anon_vma;
 	pgoff_t pgoff_start, pgoff_end;
 	struct anon_vma_chain *avc;
@@ -2328,17 +2320,17 @@ static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
 		/* anon_vma disappear under us? */
 		VM_BUG_ON_FOLIO(!anon_vma, folio);
 	} else {
-		anon_vma = rmap_walk_anon_lock(page, rwc);
+		anon_vma = rmap_walk_anon_lock(folio, rwc);
 	}
 	if (!anon_vma)
 		return;
 
-	pgoff_start = page_to_pgoff(page);
-	pgoff_end = pgoff_start + thp_nr_pages(page) - 1;
+	pgoff_start = folio_pgoff(folio);
+	pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
 	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
 			pgoff_start, pgoff_end) {
 		struct vm_area_struct *vma = avc->vma;
-		unsigned long address = vma_address(page, vma);
+		unsigned long address = vma_address(&folio->page, vma);
 
 		VM_BUG_ON_VMA(address == -EFAULT, vma);
 		cond_resched();
@@ -2346,9 +2338,9 @@ static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
 		if (rwc->invalid_vma && rwc->invalid_vma(vma, rwc->arg))
 			continue;
 
-		if (!rwc->rmap_one(page, vma, address, rwc->arg))
+		if (!rwc->rmap_one(folio, vma, address, rwc->arg))
 			break;
-		if (rwc->done && rwc->done(page))
+		if (rwc->done && rwc->done(folio))
 			break;
 	}
 
@@ -2369,10 +2361,10 @@ static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
  * vm_flags for that VMA.  That should be OK, because that vma shouldn't be
  * LOCKED.
  */
-static void rmap_walk_file(struct page *page, struct rmap_walk_control *rwc,
+static void rmap_walk_file(struct folio *folio, struct rmap_walk_control *rwc,
 		bool locked)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping = folio_mapping(folio);
 	pgoff_t pgoff_start, pgoff_end;
 	struct vm_area_struct *vma;
 
@@ -2382,18 +2374,18 @@ static void rmap_walk_file(struct page *page, struct rmap_walk_control *rwc,
 	 * structure at mapping cannot be freed and reused yet,
 	 * so we can safely take mapping->i_mmap_rwsem.
 	 */
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	if (!mapping)
 		return;
 
-	pgoff_start = page_to_pgoff(page);
-	pgoff_end = pgoff_start + thp_nr_pages(page) - 1;
+	pgoff_start = folio_pgoff(folio);
+	pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
 	if (!locked)
 		i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap,
 			pgoff_start, pgoff_end) {
-		unsigned long address = vma_address(page, vma);
+		unsigned long address = vma_address(&folio->page, vma);
 
 		VM_BUG_ON_VMA(address == -EFAULT, vma);
 		cond_resched();
@@ -2401,9 +2393,9 @@ static void rmap_walk_file(struct page *page, struct rmap_walk_control *rwc,
 		if (rwc->invalid_vma && rwc->invalid_vma(vma, rwc->arg))
 			continue;
 
-		if (!rwc->rmap_one(page, vma, address, rwc->arg))
+		if (!rwc->rmap_one(folio, vma, address, rwc->arg))
 			goto done;
-		if (rwc->done && rwc->done(page))
+		if (rwc->done && rwc->done(folio))
 			goto done;
 	}
 
@@ -2412,25 +2404,25 @@ static void rmap_walk_file(struct page *page, struct rmap_walk_control *rwc,
 		i_mmap_unlock_read(mapping);
 }
 
-void rmap_walk(struct page *page, struct rmap_walk_control *rwc)
+void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc)
 {
-	if (unlikely(PageKsm(page)))
-		rmap_walk_ksm(page, rwc);
-	else if (PageAnon(page))
-		rmap_walk_anon(page, rwc, false);
+	if (unlikely(folio_test_ksm(folio)))
+		rmap_walk_ksm(folio, rwc);
+	else if (folio_test_anon(folio))
+		rmap_walk_anon(folio, rwc, false);
 	else
-		rmap_walk_file(page, rwc, false);
+		rmap_walk_file(folio, rwc, false);
 }
 
 /* Like rmap_walk, but caller holds relevant rmap lock */
-void rmap_walk_locked(struct page *page, struct rmap_walk_control *rwc)
+void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
 {
 	/* no ksm support for now */
-	VM_BUG_ON_PAGE(PageKsm(page), page);
-	if (PageAnon(page))
-		rmap_walk_anon(page, rwc, true);
+	VM_BUG_ON_FOLIO(folio_test_ksm(folio), folio);
+	if (folio_test_anon(folio))
+		rmap_walk_anon(folio, rwc, true);
 	else
-		rmap_walk_file(page, rwc, true);
+		rmap_walk_file(folio, rwc, true);
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-- 
2.34.1

