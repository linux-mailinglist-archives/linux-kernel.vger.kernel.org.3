Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D54AB276
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiBFVsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiBFVr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:47:58 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CE4C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:47:57 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so9698696otq.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 13:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=o6hd5WPRnqjNUJ/qrVIVCaF7/zauB1F4q7+aFBEjnnY=;
        b=JKq16CM6ngC9LgfolpPHKXBhxy6VLJfsWl/WcFQvWHfNnrqQjFelr0KSNDBk/tWfff
         KCtrsdnDjBkVWzTSFqbIuLDma4lqEPYrRMMPl+UHbZqHIc5+h52d47W1p0cANQFdvV/T
         ShyDKVq1IfrMsb31vlYl5V/ORphHXbGHAnt3nZPD45yYoD8/y7bapEyqKSZtjjEsjSjR
         OZNCpm+OhA4ofz/Uo8GzQtOzK5TIRJnH4pNkVpSAYSmGEOwsCKv8xWiqTfVvZePEPP2u
         7lkYeypCvcW/GgpbJ31Ckiik3KSJMf/I3IggXdurlox3HiRHN+VJb+GOwtL0/VBampPn
         2nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=o6hd5WPRnqjNUJ/qrVIVCaF7/zauB1F4q7+aFBEjnnY=;
        b=jG2/z3QKrmWUBrj5AH5ibkNZGOpTTJ/G3crhVGIP8fB1tR05h42nDIUrr+1c4OM7Fz
         KNll4nmVHc+Fjo/U8re/Rw8QKgj2SlVe7L4lkU+5umQqEpzsbUZXvg24s9e2idgau0/W
         ZpAdzOXRyv5+qsCJZIjf2Qt34r553UtbrqSkC1kQotorRecNg/ZaF3Bm9guJ20u+SXvi
         1nde/Vs3dinDhmq3tdFW5GV6yTdSTyHkwJBUvDt/dq9OS8swjJ3LnZRJvgTcwVBUZgeh
         xCTGm10q5q10C9MVUlxd4eUw+OzgKmUhA02pHt9q5zyajyddkuMhIfBzRlUgjL4tKjcB
         G0Sg==
X-Gm-Message-State: AOAM531QnYHfQu5zLNC8qHYlRYMAL6Q+A/5/NVL4KNyqX8L1v22zcmSe
        hBq1I+DmJXcpw+RLBGqEBfexyQ==
X-Google-Smtp-Source: ABdhPJxvhVAdRugWqOxvWMdRR5ZqnSsLPZdZQirwJOX5QwpCr0pa2y2GK9Wd8e0C8WX7YrHCQ6Xf1w==
X-Received: by 2002:a9d:7dd0:: with SMTP id k16mr3386604otn.369.1644184076207;
        Sun, 06 Feb 2022 13:47:56 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2sm3282540ook.33.2022.02.06.13.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:47:55 -0800 (PST)
Date:   Sun, 6 Feb 2022 13:47:53 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 10/13] mm/munlock: mlock_page() munlock_page() batch by
 pagevec
In-Reply-To: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
Message-ID: <eadba522-cfe1-b0d6-56fc-7bc9f649b89d@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A weakness of the page->mlock_count approach is the need for lruvec lock
while holding page table lock.  That is not an overhead we would allow on
normal pages, but I think acceptable just for pages in an mlocked area.
But let's try to amortize the extra cost by gathering on per-cpu pagevec
before acquiring the lruvec lock.

I have an unverified conjecture that the mlock pagevec might work out
well for delaying the mlock processing of new file pages until they have
got off lru_cache_add()'s pagevec and on to LRU.

The initialization of page->mlock_count is subject to races and awkward:
0 or !!PageMlocked or 1?  Was it wrong even in the implementation before
this commit, which just widens the window?  I haven't gone back to think
it through.  Maybe someone can point out a better way to initialize it.

Bringing lru_cache_add_inactive_or_unevictable()'s mlock initialization
into mm/mlock.c has helped: mlock_new_page(), using the mlock pagevec,
rather than lru_cache_add()'s pagevec.

Experimented with various orderings: the right thing seems to be for
mlock_page() and mlock_new_page() to TestSetPageMlocked before adding to
pagevec, but munlock_page() to leave TestClearPageMlocked to the later
pagevec processing.

Dropped the VM_BUG_ON_PAGE(PageTail)s this time around: they have made
their point, and the thp_nr_page()s already contain a VM_BUG_ON_PGFLAGS()
for that.

This still leaves acquiring lruvec locks under page table lock each time
the pagevec fills (or a THP is added): which I suppose is rather silly,
since they sit on pagevec waiting to be processed long after page table
lock has been dropped; but I'm disinclined to uglify the calling sequence
until some load shows an actual problem with it (nothing wrong with
taking lruvec lock under page table lock, just "nicer" to do it less).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/internal.h |   7 +-
 mm/mlock.c    | 212 ++++++++++++++++++++++++++++++++++++++++++--------
 mm/swap.c     |  27 ++++---
 3 files changed, 199 insertions(+), 47 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b3f0dd3ffba2..5817cabb6343 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -402,7 +402,8 @@ extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
  *
  * mlock is usually called at the end of page_add_*_rmap(),
  * munlock at the end of page_remove_rmap(); but new anon
- * pages are managed in lru_cache_add_inactive_or_unevictable().
+ * pages are managed by lru_cache_add_inactive_or_unevictable()
+ * calling mlock_new_page().
  *
  * @compound is used to include pmd mappings of THPs, but filter out
  * pte mappings of THPs, which cannot be consistently counted: a pte
@@ -425,6 +426,9 @@ static inline void munlock_vma_page(struct page *page,
 	    (compound || !PageTransCompound(page)))
 		munlock_page(page);
 }
+void mlock_new_page(struct page *page);
+bool need_mlock_page_drain(int cpu);
+void mlock_page_drain(int cpu);
 
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
@@ -503,6 +507,7 @@ static inline void mlock_vma_page(struct page *page,
 			struct vm_area_struct *vma, bool compound) { }
 static inline void munlock_vma_page(struct page *page,
 			struct vm_area_struct *vma, bool compound) { }
+static inline void mlock_new_page(struct page *page) { }
 static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
 {
 }
diff --git a/mm/mlock.c b/mm/mlock.c
index f8e5dcff21ae..d50d48961b22 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -28,6 +28,8 @@
 
 #include "internal.h"
 
+static DEFINE_PER_CPU(struct pagevec, mlock_pvec);
+
 bool can_do_mlock(void)
 {
 	if (rlimit(RLIMIT_MEMLOCK) != 0)
@@ -49,57 +51,79 @@ EXPORT_SYMBOL(can_do_mlock);
  * PageUnevictable is set to indicate the unevictable state.
  */
 
-/**
- * mlock_page - mlock a page
- * @page - page to be mlocked, either a normal page or a THP head.
- */
-void mlock_page(struct page *page)
+static struct lruvec *__mlock_page(struct page *page, struct lruvec *lruvec)
 {
-	struct lruvec *lruvec;
-	int nr_pages = thp_nr_pages(page);
+	/* There is nothing more we can do while it's off LRU */
+	if (!TestClearPageLRU(page))
+		return lruvec;
 
-	VM_BUG_ON_PAGE(PageTail(page), page);
+	lruvec = folio_lruvec_relock_irq(page_folio(page), lruvec);
 
-	if (!TestSetPageMlocked(page)) {
-		mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
-		__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
+	if (unlikely(page_evictable(page))) {
+		/*
+		 * This is a little surprising, but quite possible:
+		 * PageMlocked must have got cleared already by another CPU.
+		 * Could this page be on the Unevictable LRU?  I'm not sure,
+		 * but move it now if so.
+		 */
+		if (PageUnevictable(page)) {
+			del_page_from_lru_list(page, lruvec);
+			ClearPageUnevictable(page);
+			add_page_to_lru_list(page, lruvec);
+			__count_vm_events(UNEVICTABLE_PGRESCUED,
+					  thp_nr_pages(page));
+		}
+		goto out;
 	}
 
-	/* There is nothing more we can do while it's off LRU */
-	if (!TestClearPageLRU(page))
-		return;
-
-	lruvec = folio_lruvec_lock_irq(page_folio(page));
 	if (PageUnevictable(page)) {
-		page->mlock_count++;
+		if (PageMlocked(page))
+			page->mlock_count++;
 		goto out;
 	}
 
 	del_page_from_lru_list(page, lruvec);
 	ClearPageActive(page);
 	SetPageUnevictable(page);
-	page->mlock_count = 1;
+	page->mlock_count = !!PageMlocked(page);
 	add_page_to_lru_list(page, lruvec);
-	__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
+	__count_vm_events(UNEVICTABLE_PGCULLED, thp_nr_pages(page));
 out:
 	SetPageLRU(page);
-	unlock_page_lruvec_irq(lruvec);
+	return lruvec;
 }
 
-/**
- * munlock_page - munlock a page
- * @page: page to be munlocked, either a normal page or a THP head.
- */
-void munlock_page(struct page *page)
+static struct lruvec *__mlock_new_page(struct page *page, struct lruvec *lruvec)
+{
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+
+	lruvec = folio_lruvec_relock_irq(page_folio(page), lruvec);
+
+	/* As above, this is a little surprising, but possible */
+	if (unlikely(page_evictable(page)))
+		goto out;
+
+	SetPageUnevictable(page);
+	page->mlock_count = !!PageMlocked(page);
+	__count_vm_events(UNEVICTABLE_PGCULLED, thp_nr_pages(page));
+out:
+	add_page_to_lru_list(page, lruvec);
+	SetPageLRU(page);
+	return lruvec;
+}
+
+static struct lruvec *__munlock_page(struct page *page, struct lruvec *lruvec)
 {
-	struct lruvec *lruvec;
 	int nr_pages = thp_nr_pages(page);
+	bool isolated = false;
+
+	if (!TestClearPageLRU(page))
+		goto munlock;
 
-	VM_BUG_ON_PAGE(PageTail(page), page);
+	isolated = true;
+	lruvec = folio_lruvec_relock_irq(page_folio(page), lruvec);
 
-	lock_page_memcg(page);
-	lruvec = folio_lruvec_lock_irq(page_folio(page));
-	if (PageLRU(page) && PageUnevictable(page)) {
+	if (PageUnevictable(page)) {
 		/* Then mlock_count is maintained, but might undercount */
 		if (page->mlock_count)
 			page->mlock_count--;
@@ -108,24 +132,144 @@ void munlock_page(struct page *page)
 	}
 	/* else assume that was the last mlock: reclaim will fix it if not */
 
+munlock:
 	if (TestClearPageMlocked(page)) {
 		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
-		if (PageLRU(page) || !PageUnevictable(page))
+		if (isolated || !PageUnevictable(page))
 			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
 		else
 			__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
 	}
 
 	/* page_evictable() has to be checked *after* clearing Mlocked */
-	if (PageLRU(page) && PageUnevictable(page) && page_evictable(page)) {
+	if (isolated && PageUnevictable(page) && page_evictable(page)) {
 		del_page_from_lru_list(page, lruvec);
 		ClearPageUnevictable(page);
 		add_page_to_lru_list(page, lruvec);
 		__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	}
 out:
-	unlock_page_lruvec_irq(lruvec);
-	unlock_page_memcg(page);
+	if (isolated)
+		SetPageLRU(page);
+	return lruvec;
+}
+
+/*
+ * Flags held in the low bits of a struct page pointer on the mlock_pvec.
+ */
+#define LRU_PAGE 0x1
+#define NEW_PAGE 0x2
+#define mlock_lru(page) ((struct page *)((unsigned long)page + LRU_PAGE))
+#define mlock_new(page) ((struct page *)((unsigned long)page + NEW_PAGE))
+
+/*
+ * mlock_pagevec() is derived from pagevec_lru_move_fn():
+ * perhaps that can make use of such page pointer flags in future,
+ * but for now just keep it for mlock.  We could use three separate
+ * pagevecs instead, but one feels better (munlocking a full pagevec
+ * does not need to drain mlocking pagevecs first).
+ */
+static void mlock_pagevec(struct pagevec *pvec)
+{
+	struct lruvec *lruvec = NULL;
+	unsigned long mlock;
+	struct page *page;
+	int i;
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		page = pvec->pages[i];
+		mlock = (unsigned long)page & (LRU_PAGE | NEW_PAGE);
+		page = (struct page *)((unsigned long)page - mlock);
+		pvec->pages[i] = page;
+
+		if (mlock & LRU_PAGE)
+			lruvec = __mlock_page(page, lruvec);
+		else if (mlock & NEW_PAGE)
+			lruvec = __mlock_new_page(page, lruvec);
+		else
+			lruvec = __munlock_page(page, lruvec);
+	}
+
+	if (lruvec)
+		unlock_page_lruvec_irq(lruvec);
+	release_pages(pvec->pages, pvec->nr);
+	pagevec_reinit(pvec);
+}
+
+void mlock_page_drain(int cpu)
+{
+	struct pagevec *pvec;
+
+	pvec = &per_cpu(mlock_pvec, cpu);
+	if (pagevec_count(pvec))
+		mlock_pagevec(pvec);
+}
+
+bool need_mlock_page_drain(int cpu)
+{
+	return pagevec_count(&per_cpu(mlock_pvec, cpu));
+}
+
+/**
+ * mlock_page - mlock a page already on (or temporarily off) LRU
+ * @page - page to be mlocked, either a normal page or a THP head.
+ */
+void mlock_page(struct page *page)
+{
+	struct pagevec *pvec = &get_cpu_var(mlock_pvec);
+
+	if (!TestSetPageMlocked(page)) {
+		int nr_pages = thp_nr_pages(page);
+
+		mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
+		__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
+	}
+
+	get_page(page);
+	if (!pagevec_add(pvec, mlock_lru(page)) ||
+	    PageHead(page) || lru_cache_disabled())
+		mlock_pagevec(pvec);
+	put_cpu_var(mlock_pvec);
+}
+
+/**
+ * mlock_new_page - mlock a newly allocated page not yet on LRU
+ * @page - page to be mlocked, either a normal page or a THP head.
+ */
+void mlock_new_page(struct page *page)
+{
+	struct pagevec *pvec = &get_cpu_var(mlock_pvec);
+	int nr_pages = thp_nr_pages(page);
+
+	SetPageMlocked(page);
+	mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
+	__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
+
+	get_page(page);
+	if (!pagevec_add(pvec, mlock_new(page)) ||
+	    PageHead(page) || lru_cache_disabled())
+		mlock_pagevec(pvec);
+	put_cpu_var(mlock_pvec);
+}
+
+/**
+ * munlock_page - munlock a page
+ * @page - page to be munlocked, either a normal page or a THP head.
+ */
+void munlock_page(struct page *page)
+{
+	struct pagevec *pvec = &get_cpu_var(mlock_pvec);
+
+	/*
+	 * TestClearPageMlocked(page) must be left to __munlock_page(),
+	 * which will check whether the page is multiply mlocked.
+	 */
+
+	get_page(page);
+	if (!pagevec_add(pvec, page) ||
+	    PageHead(page) || lru_cache_disabled())
+		mlock_pagevec(pvec);
+	put_cpu_var(mlock_pvec);
 }
 
 static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
diff --git a/mm/swap.c b/mm/swap.c
index 3f770b1ea2c1..842d5cd92cf6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -490,18 +490,12 @@ EXPORT_SYMBOL(folio_add_lru);
 void lru_cache_add_inactive_or_unevictable(struct page *page,
 					 struct vm_area_struct *vma)
 {
-	bool unevictable;
-
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
-	unevictable = (vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED;
-	if (unlikely(unevictable) && !TestSetPageMlocked(page)) {
-		int nr_pages = thp_nr_pages(page);
-
-		mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
-		count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
-	}
-	lru_cache_add(page);
+	if (unlikely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED))
+		mlock_new_page(page);
+	else
+		lru_cache_add(page);
 }
 
 /*
@@ -640,6 +634,7 @@ void lru_add_drain_cpu(int cpu)
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 
 	activate_page_drain(cpu);
+	mlock_page_drain(cpu);
 }
 
 /**
@@ -842,6 +837,7 @@ inline void __lru_add_drain_all(bool force_all_cpus)
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_lazyfree, cpu)) ||
 		    need_activate_page_drain(cpu) ||
+		    need_mlock_page_drain(cpu) ||
 		    has_bh_in_lru(cpu, NULL)) {
 			INIT_WORK(work, lru_add_drain_per_cpu);
 			queue_work_on(cpu, mm_percpu_wq, work);
@@ -1030,7 +1026,7 @@ static void __pagevec_lru_add_fn(struct folio *folio, struct lruvec *lruvec)
 	 * Is an smp_mb__after_atomic() still required here, before
 	 * folio_evictable() tests PageMlocked, to rule out the possibility
 	 * of stranding an evictable folio on an unevictable LRU?  I think
-	 * not, because munlock_page() only clears PageMlocked while the LRU
+	 * not, because __munlock_page() only clears PageMlocked while the LRU
 	 * lock is held.
 	 *
 	 * (That is not true of __page_cache_release(), and not necessarily
@@ -1043,7 +1039,14 @@ static void __pagevec_lru_add_fn(struct folio *folio, struct lruvec *lruvec)
 	} else {
 		folio_clear_active(folio);
 		folio_set_unevictable(folio);
-		folio->mlock_count = !!folio_test_mlocked(folio);
+		/*
+		 * folio->mlock_count = !!folio_test_mlocked(folio)?
+		 * But that leaves __mlock_page() in doubt whether another
+		 * actor has already counted the mlock or not.  Err on the
+		 * safe side, underestimate, let page reclaim fix it, rather
+		 * than leaving a page on the unevictable LRU indefinitely.
+		 */
+		folio->mlock_count = 0;
 		if (!was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
 	}
-- 
2.34.1

