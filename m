Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5FC4B60E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiBOCUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:20:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiBOCUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:20:38 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F61CC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:20:28 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z1so17269313qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=7dzr3D8vhZBGbu28hBnb9n3i6+YNcbfsTesEURk77is=;
        b=LpDY0yb0fXwM9g+7YZhU7ZWaF6lkqSrJ8gJnm6uwjCzFbvsy/DZFkU3Ktlit+sN6ys
         Dx3XoB/IYnKvYLi1Z/wvOGTgAJ0vIez9va+Kvbe0l0aUlmW7O+tMUQiUxfUt6+3dg6d3
         1Nh/eDUjTpBQOR7yZB6HCZBGknSUyxHfGZrIcH043YgGGP7fIjgLMtUSI+GRw9JgpHWY
         SYK/jMBI6+ZU4LTKPTshnlIlNBsOKcN/ZeMNI+iOihbLS+pukgxTP7rNyCEk/tRNGjj/
         rCCkIsD0kMn+FfR1PAJyxAV7ovmBcGI9ueXQ6t4m3jCwxfXhFTBaEqyfKmEdv94eeDtz
         /D5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=7dzr3D8vhZBGbu28hBnb9n3i6+YNcbfsTesEURk77is=;
        b=Ql7IHy/HX801N/O7YOZtDxIfcCesligMlrMfNKu3Y0mWYahf2GTdhrFrqFYiujGKUZ
         bjeRq2wHpNYdJphh1q/lshHi2lqXon2mlPXS1xI3JeQm09ybWZMqyp4u1isU1EnlsDsX
         1Zqd/Gi1ZidYeidDsXwM8UJzB1E5C1Hx2+LWzO/9hp8tnYkKqtxRZXXzpeRD6j3+wGp/
         thmNFc8wcBJCu40tUZXFHZTrKY9QF+3WDZLkzINLY2tGzUXiJMLRx6UXpNuSsCXD1zRH
         qh1tTU8f8SGg2UdQ3iCcjKnItKCEz/XCjWlNfqGHlPoDb68lLC12Y5nHBL3Y8kiyOWfu
         jfFw==
X-Gm-Message-State: AOAM531fn71NpdUQfBklamN0qygxIkjAxNB9brpFdk9SxLhhbyUhSo/q
        s3DtHMBebZwFjr4TO5deecE/Jg==
X-Google-Smtp-Source: ABdhPJzmPpWgHw0ac88YCQVCS+B4j9/OqAwEh89t2lqVY93rmf7V6TsTdEU/rX8hNpYnfVUq2r8Mew==
X-Received: by 2002:ac8:5d8e:: with SMTP id d14mr1333266qtx.278.1644891627156;
        Mon, 14 Feb 2022 18:20:27 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g8sm335837qki.47.2022.02.14.18.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:20:26 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:20:24 -0800 (PST)
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
Subject: [PATCH v2 01/13] mm/munlock: delete page_mlock() and all its works
In-Reply-To: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
Message-ID: <48c44eae-4cf0-a8ce-454c-5ec88457ffea@google.com>
References: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
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

We have recommended some applications to mlock their userspace, but that
turns out to be counter-productive: when many processes mlock the same
file, contention on rmap's i_mmap_rwsem can become intolerable at exit: it
is needed for write, to remove any vma mapping that file from rmap's tree;
but hogged for read by those with mlocks calling page_mlock() (formerly
known as try_to_munlock()) on *each* page mapped from the file (the
purpose being to find out whether another process has the page mlocked,
so therefore it should not be unmlocked yet).

Several optimizations have been made in the past: one is to skip
page_mlock() when mapcount tells that nothing else has this page
mapped; but that doesn't help at all when others do have it mapped.
This time around, I initially intended to add a preliminary search
of the rmap tree for overlapping VM_LOCKED ranges; but that gets
messy with locking order, when in doubt whether a page is actually
present; and risks adding even more contention on the i_mmap_rwsem.

A solution would be much easier, if only there were space in struct page
for an mlock_count... but actually, most of the time, there is space for
it - an mlocked page spends most of its life on an unevictable LRU, but
since 3.18 removed the scan_unevictable_pages sysctl, that "LRU" has
been redundant.  Let's try to reuse its page->lru.

But leave that until a later patch: in this patch, clear the ground by
removing page_mlock(), and all the infrastructure that has gathered
around it - which mostly hinders understanding, and will make reviewing
new additions harder.  Don't mind those old comments about THPs, they
date from before 4.5's refcounting rework: splitting is not a risk here.

Just keep a minimal version of munlock_vma_page(), as reminder of what it
should attend to (in particular, the odd way PGSTRANDED is counted out of
PGMUNLOCKED), and likewise a stub for munlock_vma_pages_range().  Move
unchanged __mlock_posix_error_return() out of the way, down to above its
caller: this series then makes no further change after mlock_fixup().

After this and each following commit, the kernel builds, boots and runs;
but with deficiencies which may show up in testing of mlock and munlock.
The system calls succeed or fail as before, and mlock remains effective
in preventing page reclaim; but meminfo's Unevictable and Mlocked amounts
may be shown too low after mlock, grow, then stay too high after munlock:
with previously mlocked pages remaining unevictable for too long, until
finally unmapped and freed and counts corrected. Normal service will be
resumed in "mm/munlock: mlock_pte_range() when mlocking or munlocking".

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
v2: Restore munlock_vma_pages_range() VM_LOCKED_CLEAR_MASK, per Vlastimil.
    Add paragraph to changelog on what does not work yet, per Vlastimil.
    These v2 replacement patches based on 5.17-rc2 like v1.

 include/linux/rmap.h |   6 -
 mm/internal.h        |   2 +-
 mm/mlock.c           | 375 +++----------------------------------------
 mm/rmap.c            |  80 ---------
 4 files changed, 25 insertions(+), 438 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e704b1a4c06c..dc48aa8c2c94 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -237,12 +237,6 @@ unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
  */
 int folio_mkclean(struct folio *);
 
-/*
- * called in munlock()/munmap() path to check for other vmas holding
- * the page mlocked.
- */
-void page_mlock(struct page *page);
-
 void remove_migration_ptes(struct page *old, struct page *new, bool locked);
 
 /*
diff --git a/mm/internal.h b/mm/internal.h
index d80300392a19..e48c486d5ddf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -409,7 +409,7 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
  * must be called with vma's mmap_lock held for read or write, and page locked.
  */
 extern void mlock_vma_page(struct page *page);
-extern unsigned int munlock_vma_page(struct page *page);
+extern void munlock_vma_page(struct page *page);
 
 extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
 			      unsigned long len);
diff --git a/mm/mlock.c b/mm/mlock.c
index 8f584eddd305..aec4ce7919da 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -46,12 +46,6 @@ EXPORT_SYMBOL(can_do_mlock);
  * be placed on the LRU "unevictable" list, rather than the [in]active lists.
  * The unevictable list is an LRU sibling list to the [in]active lists.
  * PageUnevictable is set to indicate the unevictable state.
- *
- * When lazy mlocking via vmscan, it is important to ensure that the
- * vma's VM_LOCKED status is not concurrently being modified, otherwise we
- * may have mlocked a page that is being munlocked. So lazy mlock must take
- * the mmap_lock for read, and verify that the vma really is locked
- * (see mm/rmap.c).
  */
 
 /*
@@ -106,299 +100,28 @@ void mlock_vma_page(struct page *page)
 	}
 }
 
-/*
- * Finish munlock after successful page isolation
- *
- * Page must be locked. This is a wrapper for page_mlock()
- * and putback_lru_page() with munlock accounting.
- */
-static void __munlock_isolated_page(struct page *page)
-{
-	/*
-	 * Optimization: if the page was mapped just once, that's our mapping
-	 * and we don't need to check all the other vmas.
-	 */
-	if (page_mapcount(page) > 1)
-		page_mlock(page);
-
-	/* Did try_to_unlock() succeed or punt? */
-	if (!PageMlocked(page))
-		count_vm_events(UNEVICTABLE_PGMUNLOCKED, thp_nr_pages(page));
-
-	putback_lru_page(page);
-}
-
-/*
- * Accounting for page isolation fail during munlock
- *
- * Performs accounting when page isolation fails in munlock. There is nothing
- * else to do because it means some other task has already removed the page
- * from the LRU. putback_lru_page() will take care of removing the page from
- * the unevictable list, if necessary. vmscan [page_referenced()] will move
- * the page back to the unevictable list if some other vma has it mlocked.
- */
-static void __munlock_isolation_failed(struct page *page)
-{
-	int nr_pages = thp_nr_pages(page);
-
-	if (PageUnevictable(page))
-		__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
-	else
-		__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
-}
-
 /**
  * munlock_vma_page - munlock a vma page
  * @page: page to be unlocked, either a normal page or THP page head
- *
- * returns the size of the page as a page mask (0 for normal page,
- *         HPAGE_PMD_NR - 1 for THP head page)
- *
- * called from munlock()/munmap() path with page supposedly on the LRU.
- * When we munlock a page, because the vma where we found the page is being
- * munlock()ed or munmap()ed, we want to check whether other vmas hold the
- * page locked so that we can leave it on the unevictable lru list and not
- * bother vmscan with it.  However, to walk the page's rmap list in
- * page_mlock() we must isolate the page from the LRU.  If some other
- * task has removed the page from the LRU, we won't be able to do that.
- * So we clear the PageMlocked as we might not get another chance.  If we
- * can't isolate the page, we leave it for putback_lru_page() and vmscan
- * [page_referenced()/try_to_unmap()] to deal with.
  */
-unsigned int munlock_vma_page(struct page *page)
+void munlock_vma_page(struct page *page)
 {
-	int nr_pages;
-
-	/* For page_mlock() and to serialize with page migration */
+	/* Serialize with page migration */
 	BUG_ON(!PageLocked(page));
-	VM_BUG_ON_PAGE(PageTail(page), page);
-
-	if (!TestClearPageMlocked(page)) {
-		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
-		return 0;
-	}
-
-	nr_pages = thp_nr_pages(page);
-	mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
-
-	if (!isolate_lru_page(page))
-		__munlock_isolated_page(page);
-	else
-		__munlock_isolation_failed(page);
-
-	return nr_pages - 1;
-}
-
-/*
- * convert get_user_pages() return value to posix mlock() error
- */
-static int __mlock_posix_error_return(long retval)
-{
-	if (retval == -EFAULT)
-		retval = -ENOMEM;
-	else if (retval == -ENOMEM)
-		retval = -EAGAIN;
-	return retval;
-}
-
-/*
- * Prepare page for fast batched LRU putback via putback_lru_evictable_pagevec()
- *
- * The fast path is available only for evictable pages with single mapping.
- * Then we can bypass the per-cpu pvec and get better performance.
- * when mapcount > 1 we need page_mlock() which can fail.
- * when !page_evictable(), we need the full redo logic of putback_lru_page to
- * avoid leaving evictable page in unevictable list.
- *
- * In case of success, @page is added to @pvec and @pgrescued is incremented
- * in case that the page was previously unevictable. @page is also unlocked.
- */
-static bool __putback_lru_fast_prepare(struct page *page, struct pagevec *pvec,
-		int *pgrescued)
-{
-	VM_BUG_ON_PAGE(PageLRU(page), page);
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-
-	if (page_mapcount(page) <= 1 && page_evictable(page)) {
-		pagevec_add(pvec, page);
-		if (TestClearPageUnevictable(page))
-			(*pgrescued)++;
-		unlock_page(page);
-		return true;
-	}
-
-	return false;
-}
 
-/*
- * Putback multiple evictable pages to the LRU
- *
- * Batched putback of evictable pages that bypasses the per-cpu pvec. Some of
- * the pages might have meanwhile become unevictable but that is OK.
- */
-static void __putback_lru_fast(struct pagevec *pvec, int pgrescued)
-{
-	count_vm_events(UNEVICTABLE_PGMUNLOCKED, pagevec_count(pvec));
-	/*
-	 *__pagevec_lru_add() calls release_pages() so we don't call
-	 * put_page() explicitly
-	 */
-	__pagevec_lru_add(pvec);
-	count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
-}
-
-/*
- * Munlock a batch of pages from the same zone
- *
- * The work is split to two main phases. First phase clears the Mlocked flag
- * and attempts to isolate the pages, all under a single zone lru lock.
- * The second phase finishes the munlock only for pages where isolation
- * succeeded.
- *
- * Note that the pagevec may be modified during the process.
- */
-static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
-{
-	int i;
-	int nr = pagevec_count(pvec);
-	int delta_munlocked = -nr;
-	struct pagevec pvec_putback;
-	struct lruvec *lruvec = NULL;
-	int pgrescued = 0;
-
-	pagevec_init(&pvec_putback);
-
-	/* Phase 1: page isolation */
-	for (i = 0; i < nr; i++) {
-		struct page *page = pvec->pages[i];
-		struct folio *folio = page_folio(page);
-
-		if (TestClearPageMlocked(page)) {
-			/*
-			 * We already have pin from follow_page_mask()
-			 * so we can spare the get_page() here.
-			 */
-			if (TestClearPageLRU(page)) {
-				lruvec = folio_lruvec_relock_irq(folio, lruvec);
-				del_page_from_lru_list(page, lruvec);
-				continue;
-			} else
-				__munlock_isolation_failed(page);
-		} else {
-			delta_munlocked++;
-		}
+	VM_BUG_ON_PAGE(PageTail(page), page);
 
-		/*
-		 * We won't be munlocking this page in the next phase
-		 * but we still need to release the follow_page_mask()
-		 * pin. We cannot do it under lru_lock however. If it's
-		 * the last pin, __page_cache_release() would deadlock.
-		 */
-		pagevec_add(&pvec_putback, pvec->pages[i]);
-		pvec->pages[i] = NULL;
-	}
-	if (lruvec) {
-		__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
-		unlock_page_lruvec_irq(lruvec);
-	} else if (delta_munlocked) {
-		mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
-	}
+	if (TestClearPageMlocked(page)) {
+		int nr_pages = thp_nr_pages(page);
 
-	/* Now we can release pins of pages that we are not munlocking */
-	pagevec_release(&pvec_putback);
-
-	/* Phase 2: page munlock */
-	for (i = 0; i < nr; i++) {
-		struct page *page = pvec->pages[i];
-
-		if (page) {
-			lock_page(page);
-			if (!__putback_lru_fast_prepare(page, &pvec_putback,
-					&pgrescued)) {
-				/*
-				 * Slow path. We don't want to lose the last
-				 * pin before unlock_page()
-				 */
-				get_page(page); /* for putback_lru_page() */
-				__munlock_isolated_page(page);
-				unlock_page(page);
-				put_page(page); /* from follow_page_mask() */
-			}
+		mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
+		if (!isolate_lru_page(page)) {
+			putback_lru_page(page);
+			count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
+		} else if (PageUnevictable(page)) {
+			count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
 		}
 	}
-
-	/*
-	 * Phase 3: page putback for pages that qualified for the fast path
-	 * This will also call put_page() to return pin from follow_page_mask()
-	 */
-	if (pagevec_count(&pvec_putback))
-		__putback_lru_fast(&pvec_putback, pgrescued);
-}
-
-/*
- * Fill up pagevec for __munlock_pagevec using pte walk
- *
- * The function expects that the struct page corresponding to @start address is
- * a non-TPH page already pinned and in the @pvec, and that it belongs to @zone.
- *
- * The rest of @pvec is filled by subsequent pages within the same pmd and same
- * zone, as long as the pte's are present and vm_normal_page() succeeds. These
- * pages also get pinned.
- *
- * Returns the address of the next page that should be scanned. This equals
- * @start + PAGE_SIZE when no page could be added by the pte walk.
- */
-static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
-			struct vm_area_struct *vma, struct zone *zone,
-			unsigned long start, unsigned long end)
-{
-	pte_t *pte;
-	spinlock_t *ptl;
-
-	/*
-	 * Initialize pte walk starting at the already pinned page where we
-	 * are sure that there is a pte, as it was pinned under the same
-	 * mmap_lock write op.
-	 */
-	pte = get_locked_pte(vma->vm_mm, start,	&ptl);
-	/* Make sure we do not cross the page table boundary */
-	end = pgd_addr_end(start, end);
-	end = p4d_addr_end(start, end);
-	end = pud_addr_end(start, end);
-	end = pmd_addr_end(start, end);
-
-	/* The page next to the pinned page is the first we will try to get */
-	start += PAGE_SIZE;
-	while (start < end) {
-		struct page *page = NULL;
-		pte++;
-		if (pte_present(*pte))
-			page = vm_normal_page(vma, start, *pte);
-		/*
-		 * Break if page could not be obtained or the page's node+zone does not
-		 * match
-		 */
-		if (!page || page_zone(page) != zone)
-			break;
-
-		/*
-		 * Do not use pagevec for PTE-mapped THP,
-		 * munlock_vma_pages_range() will handle them.
-		 */
-		if (PageTransCompound(page))
-			break;
-
-		get_page(page);
-		/*
-		 * Increase the address that will be returned *before* the
-		 * eventual break due to pvec becoming full by adding the page
-		 */
-		start += PAGE_SIZE;
-		if (pagevec_add(pvec, page) == 0)
-			break;
-	}
-	pte_unmap_unlock(pte, ptl);
-	return start;
 }
 
 /*
@@ -413,75 +136,13 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
  *
  * Returns with VM_LOCKED cleared.  Callers must be prepared to
  * deal with this.
- *
- * We don't save and restore VM_LOCKED here because pages are
- * still on lru.  In unmap path, pages might be scanned by reclaim
- * and re-mlocked by page_mlock/try_to_unmap before we unmap and
- * free them.  This will result in freeing mlocked pages.
  */
 void munlock_vma_pages_range(struct vm_area_struct *vma,
 			     unsigned long start, unsigned long end)
 {
 	vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 
-	while (start < end) {
-		struct page *page;
-		unsigned int page_mask = 0;
-		unsigned long page_increm;
-		struct pagevec pvec;
-		struct zone *zone;
-
-		pagevec_init(&pvec);
-		/*
-		 * Although FOLL_DUMP is intended for get_dump_page(),
-		 * it just so happens that its special treatment of the
-		 * ZERO_PAGE (returning an error instead of doing get_page)
-		 * suits munlock very well (and if somehow an abnormal page
-		 * has sneaked into the range, we won't oops here: great).
-		 */
-		page = follow_page(vma, start, FOLL_GET | FOLL_DUMP);
-
-		if (page && !IS_ERR(page)) {
-			if (PageTransTail(page)) {
-				VM_BUG_ON_PAGE(PageMlocked(page), page);
-				put_page(page); /* follow_page_mask() */
-			} else if (PageTransHuge(page)) {
-				lock_page(page);
-				/*
-				 * Any THP page found by follow_page_mask() may
-				 * have gotten split before reaching
-				 * munlock_vma_page(), so we need to compute
-				 * the page_mask here instead.
-				 */
-				page_mask = munlock_vma_page(page);
-				unlock_page(page);
-				put_page(page); /* follow_page_mask() */
-			} else {
-				/*
-				 * Non-huge pages are handled in batches via
-				 * pagevec. The pin from follow_page_mask()
-				 * prevents them from collapsing by THP.
-				 */
-				pagevec_add(&pvec, page);
-				zone = page_zone(page);
-
-				/*
-				 * Try to fill the rest of pagevec using fast
-				 * pte walk. This will also update start to
-				 * the next page to process. Then munlock the
-				 * pagevec.
-				 */
-				start = __munlock_pagevec_fill(&pvec, vma,
-						zone, start, end);
-				__munlock_pagevec(&pvec, zone);
-				goto next;
-			}
-		}
-		page_increm = 1 + page_mask;
-		start += page_increm * PAGE_SIZE;
-next:
-		cond_resched();
-	}
+	/* Reimplementation to follow in later commit */
 }
 
 /*
@@ -645,6 +306,18 @@ static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
 	return count >> PAGE_SHIFT;
 }
 
+/*
+ * convert get_user_pages() return value to posix mlock() error
+ */
+static int __mlock_posix_error_return(long retval)
+{
+	if (retval == -EFAULT)
+		retval = -ENOMEM;
+	else if (retval == -ENOMEM)
+		retval = -EAGAIN;
+	return retval;
+}
+
 static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t flags)
 {
 	unsigned long locked;
diff --git a/mm/rmap.c b/mm/rmap.c
index 6a1e8c7f6213..7ce7f1946cff 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1996,76 +1996,6 @@ void try_to_migrate(struct page *page, enum ttu_flags flags)
 		rmap_walk(page, &rwc);
 }
 
-/*
- * Walks the vma's mapping a page and mlocks the page if any locked vma's are
- * found. Once one is found the page is locked and the scan can be terminated.
- */
-static bool page_mlock_one(struct page *page, struct vm_area_struct *vma,
-				 unsigned long address, void *unused)
-{
-	struct page_vma_mapped_walk pvmw = {
-		.page = page,
-		.vma = vma,
-		.address = address,
-	};
-
-	/* An un-locked vma doesn't have any pages to lock, continue the scan */
-	if (!(vma->vm_flags & VM_LOCKED))
-		return true;
-
-	while (page_vma_mapped_walk(&pvmw)) {
-		/*
-		 * Need to recheck under the ptl to serialise with
-		 * __munlock_pagevec_fill() after VM_LOCKED is cleared in
-		 * munlock_vma_pages_range().
-		 */
-		if (vma->vm_flags & VM_LOCKED) {
-			/*
-			 * PTE-mapped THP are never marked as mlocked; but
-			 * this function is never called on a DoubleMap THP,
-			 * nor on an Anon THP (which may still be PTE-mapped
-			 * after DoubleMap was cleared).
-			 */
-			mlock_vma_page(page);
-			/*
-			 * No need to scan further once the page is marked
-			 * as mlocked.
-			 */
-			page_vma_mapped_walk_done(&pvmw);
-			return false;
-		}
-	}
-
-	return true;
-}
-
-/**
- * page_mlock - try to mlock a page
- * @page: the page to be mlocked
- *
- * Called from munlock code. Checks all of the VMAs mapping the page and mlocks
- * the page if any are found. The page will be returned with PG_mlocked cleared
- * if it is not mapped by any locked vmas.
- */
-void page_mlock(struct page *page)
-{
-	struct rmap_walk_control rwc = {
-		.rmap_one = page_mlock_one,
-		.done = page_not_mapped,
-		.anon_lock = page_lock_anon_vma_read,
-
-	};
-
-	VM_BUG_ON_PAGE(!PageLocked(page) || PageLRU(page), page);
-	VM_BUG_ON_PAGE(PageCompound(page) && PageDoubleMap(page), page);
-
-	/* Anon THP are only marked as mlocked when singly mapped */
-	if (PageTransCompound(page) && PageAnon(page))
-		return;
-
-	rmap_walk(page, &rwc);
-}
-
 #ifdef CONFIG_DEVICE_PRIVATE
 struct make_exclusive_args {
 	struct mm_struct *mm;
@@ -2291,11 +2221,6 @@ static struct anon_vma *rmap_walk_anon_lock(struct page *page,
  *
  * Find all the mappings of a page using the mapping pointer and the vma chains
  * contained in the anon_vma struct it points to.
- *
- * When called from page_mlock(), the mmap_lock of the mm containing the vma
- * where the page was found will be held for write.  So, we won't recheck
- * vm_flags for that VMA.  That should be OK, because that vma shouldn't be
- * LOCKED.
  */
 static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
 		bool locked)
@@ -2344,11 +2269,6 @@ static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
  *
  * Find all the mappings of a page using the mapping pointer and the vma chains
  * contained in the address_space struct it points to.
- *
- * When called from page_mlock(), the mmap_lock of the mm containing the vma
- * where the page was found will be held for write.  So, we won't recheck
- * vm_flags for that VMA.  That should be OK, because that vma shouldn't be
- * LOCKED.
  */
 static void rmap_walk_file(struct page *page, struct rmap_walk_control *rwc,
 		bool locked)
-- 
2.34.1

