Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C64B6100
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiBOC2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:28:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiBOC2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:28:19 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EA28E1A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:28:10 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a28so16406507qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=WrirEeDxktGoFoKuWopzdOwWJ3BwcY0ugVm1nQfgOwo=;
        b=Z1l+Sif++U+qod3cX1xih6XIWKDMOr7jF2YtjAmActgSqsfZ3qw5UCyIsJW4Z9W4oD
         0YJ0AGOmJVQbtriCIcVPOb1k5ri1y+mY44CRhFA3XPIZODSUhlPOa4/BLszFJ3I8jCCg
         EvrFjA+/oTU5vP8c0lrqk/1usT4My2LzlNCzY8QxP7B5aQe7FtFgJBKR3k2BUSkNlGuA
         9ARTC7WLTN1ruwxCe52wL3Ryu0hOGs2vK7Nn/3xT7xbMk9zBjfl+muQ6pox2EWVJwL6z
         i43JwUVzleMcaubKf0DkGT/RExiycL+gOQtsGxzXspA4dkJNdCI34GwGQmAPUq/oKj+W
         ZTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=WrirEeDxktGoFoKuWopzdOwWJ3BwcY0ugVm1nQfgOwo=;
        b=KFVenJlgrr4Zjlj47sY2Mz+i0sF2QrDA2KjZ2LRvaabYDliVHAy8jrZzDsVLlN6E8e
         AH2e0+kUv7f6pfBMfxEjoL5PnD7KekWm23yiQRwoeOEvX9CjvN3lfoJiI0uVzMIiTnVw
         eP/C8WclwIEaV/ZziXIiw+pTJ8MqCJXyr4VgnGcbAKfoDr4WfEuCSvIUzFxpYy4bvye/
         mhj1AWPy1Q3S/rcIHMfLjW3z8SFiLZUzY0RLvEfQdAmWEfj6VIV83wbchmCUK0i986lM
         JaBDgZxewvenM2/cXZMsZewHujeeBk+bnIE7mcCNp4EgMYznYbbomq6eCYuoBTF+4m8a
         o8iA==
X-Gm-Message-State: AOAM531TuYsN81Pc9K37BztSmGuQBv8V2fqpZAe3uNNwvBLXoqTxsHNJ
        bBj7EoX5aRONGb5jmF8L4K9puA==
X-Google-Smtp-Source: ABdhPJyUzoK9gED/txNJoOCGRekNw9dzEp4dB3JogIqFN0ZOacHeCuqePDmPX+2O3Rm1Jqc+X9CUyQ==
X-Received: by 2002:a0c:aa10:: with SMTP id d16mr1081983qvb.71.1644892088670;
        Mon, 14 Feb 2022 18:28:08 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v19sm17163332qkp.131.2022.02.14.18.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:28:07 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:28:05 -0800 (PST)
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
Subject: [PATCH v2 05/13] mm/munlock: replace clear_page_mlock() by final
 clearance
In-Reply-To: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
Message-ID: <ba15e6e-bdd5-7712-76b9-6278209e827a@google.com>
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

Placing munlock_vma_page() at the end of page_remove_rmap() shifts most
of the munlocking to clear_page_mlock(), since PageMlocked is typically
still set when mapcount has fallen to 0.  That is not what we want: we
want /proc/vmstat's unevictable_pgs_cleared to remain as a useful check
on the integrity of of the mlock/munlock protocol - small numbers are
not surprising, but big numbers mean the protocol is not working.

That could be easily fixed by placing munlock_vma_page() at the start of
page_remove_rmap(); but later in the series we shall want to batch the
munlocking, and that too would tend to leave PageMlocked still set at
the point when it is checked.

So delete clear_page_mlock() now: leave it instead to release_pages()
(and __page_cache_release()) to do this backstop clearing of Mlocked,
when page refcount has fallen to 0.  If a pinned page occasionally gets
counted as Mlocked and Unevictable until it is unpinned, that's okay.

A slightly regrettable side-effect of this change is that, since
release_pages() and __page_cache_release() may be called at interrupt
time, those places which update NR_MLOCK with interrupts enabled
had better use mod_zone_page_state() than __mod_zone_page_state()
(but holding the lruvec lock always has interrupts disabled).

This change, forcing Mlocked off when refcount 0 instead of earlier
when mapcount 0, is not fundamental: it can be reversed if performance
or something else is found to suffer; but this is the easiest way to
separate the stats - let's not complicate that without good reason.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
v2: same as v1.

 mm/internal.h | 12 ------------
 mm/mlock.c    | 30 ------------------------------
 mm/rmap.c     |  9 ---------
 mm/swap.c     | 32 ++++++++++++++++++++++++--------
 4 files changed, 24 insertions(+), 59 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3d7dfc8bc471..a43d79335c16 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -425,17 +425,6 @@ static inline void munlock_vma_page(struct page *page,
 		munlock_page(page);
 }
 
-/*
- * Clear the page's PageMlocked().  This can be useful in a situation where
- * we want to unconditionally remove a page from the pagecache -- e.g.,
- * on truncation or freeing.
- *
- * It is legal to call this function for any page, mlocked or not.
- * If called for a page that is still mapped by mlocked vmas, all we do
- * is revert to lazy LRU behaviour -- semantics are not broken.
- */
-extern void clear_page_mlock(struct page *page);
-
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
 /*
@@ -509,7 +498,6 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 }
 #else /* !CONFIG_MMU */
 static inline void unmap_mapping_folio(struct folio *folio) { }
-static inline void clear_page_mlock(struct page *page) { }
 static inline void mlock_vma_page(struct page *page,
 			struct vm_area_struct *vma, bool compound) { }
 static inline void munlock_vma_page(struct page *page,
diff --git a/mm/mlock.c b/mm/mlock.c
index 92f28258b4ae..3c26473050a3 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -48,36 +48,6 @@ EXPORT_SYMBOL(can_do_mlock);
  * PageUnevictable is set to indicate the unevictable state.
  */
 
-/*
- *  LRU accounting for clear_page_mlock()
- */
-void clear_page_mlock(struct page *page)
-{
-	int nr_pages;
-
-	if (!TestClearPageMlocked(page))
-		return;
-
-	nr_pages = thp_nr_pages(page);
-	mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
-	count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
-	/*
-	 * The previous TestClearPageMlocked() corresponds to the smp_mb()
-	 * in __pagevec_lru_add_fn().
-	 *
-	 * See __pagevec_lru_add_fn for more explanation.
-	 */
-	if (!isolate_lru_page(page)) {
-		putback_lru_page(page);
-	} else {
-		/*
-		 * We lost the race. the page already moved to evictable list.
-		 */
-		if (PageUnevictable(page))
-			count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
-	}
-}
-
 /**
  * mlock_page - mlock a page
  * @page: page to be mlocked, either a normal page or a THP head.
diff --git a/mm/rmap.c b/mm/rmap.c
index 6cc8bf129f18..5442a5c97a85 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1315,9 +1315,6 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 	 * pte lock(a spinlock) is held, which implies preemption disabled.
 	 */
 	__mod_lruvec_page_state(page, NR_FILE_MAPPED, -nr);
-
-	if (unlikely(PageMlocked(page)))
-		clear_page_mlock(page);
 }
 
 static void page_remove_anon_compound_rmap(struct page *page)
@@ -1357,9 +1354,6 @@ static void page_remove_anon_compound_rmap(struct page *page)
 		nr = thp_nr_pages(page);
 	}
 
-	if (unlikely(PageMlocked(page)))
-		clear_page_mlock(page);
-
 	if (nr)
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, -nr);
 }
@@ -1398,9 +1392,6 @@ void page_remove_rmap(struct page *page,
 	 */
 	__dec_lruvec_page_state(page, NR_ANON_MAPPED);
 
-	if (unlikely(PageMlocked(page)))
-		clear_page_mlock(page);
-
 	if (PageTransCompound(page))
 		deferred_split_huge_page(compound_head(page));
 
diff --git a/mm/swap.c b/mm/swap.c
index bcf3ac288b56..ff4810e4a4bc 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -74,8 +74,8 @@ static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) = {
 };
 
 /*
- * This path almost never happens for VM activity - pages are normally
- * freed via pagevecs.  But it gets used by networking.
+ * This path almost never happens for VM activity - pages are normally freed
+ * via pagevecs.  But it gets used by networking - and for compound pages.
  */
 static void __page_cache_release(struct page *page)
 {
@@ -89,6 +89,14 @@ static void __page_cache_release(struct page *page)
 		__clear_page_lru_flags(page);
 		unlock_page_lruvec_irqrestore(lruvec, flags);
 	}
+	/* See comment on PageMlocked in release_pages() */
+	if (unlikely(PageMlocked(page))) {
+		int nr_pages = thp_nr_pages(page);
+
+		__ClearPageMlocked(page);
+		mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
+		count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
+	}
 	__ClearPageWaiters(page);
 }
 
@@ -489,12 +497,8 @@ void lru_cache_add_inactive_or_unevictable(struct page *page,
 	unevictable = (vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED;
 	if (unlikely(unevictable) && !TestSetPageMlocked(page)) {
 		int nr_pages = thp_nr_pages(page);
-		/*
-		 * We use the irq-unsafe __mod_zone_page_state because this
-		 * counter is not modified from interrupt context, and the pte
-		 * lock is held(spinlock), which implies preemption disabled.
-		 */
-		__mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
+
+		mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
 		count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 	}
 	lru_cache_add(page);
@@ -969,6 +973,18 @@ void release_pages(struct page **pages, int nr)
 			__clear_page_lru_flags(page);
 		}
 
+		/*
+		 * In rare cases, when truncation or holepunching raced with
+		 * munlock after VM_LOCKED was cleared, Mlocked may still be
+		 * found set here.  This does not indicate a problem, unless
+		 * "unevictable_pgs_cleared" appears worryingly large.
+		 */
+		if (unlikely(PageMlocked(page))) {
+			__ClearPageMlocked(page);
+			dec_zone_page_state(page, NR_MLOCK);
+			count_vm_event(UNEVICTABLE_PGCLEARED);
+		}
+
 		__ClearPageWaiters(page);
 
 		list_add(&page->lru, &pages_to_free);
-- 
2.34.1

