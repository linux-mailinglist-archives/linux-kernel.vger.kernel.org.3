Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFC54AB271
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiBFVkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiBFVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:40:31 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2014CC061348
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:40:30 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id a28so2856984qvb.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 13:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=45ik5JHfgpbUMO7+X66xo52U6DkySR/bQEG5IbUVs7M=;
        b=COjW7R5Ar7dY1W4BBFxBelYHSAdqgPoKvPqnz5sN/eD4rJOBjARiVivgUh2GEX9Njf
         j/JH04kkzbnxqpo2+O6onmJNj7BxfhNa4o6TXoXxbELsdPxq8nbrAfhMLKIMrZHGFaBS
         dYYtaIhhJLfHqXIQ3pzvKadIo6WxysMzPzt/7AAlARmV3cbM0jHT7tAOHLaj2NoP1AoC
         z0bJrAbqL0byqAlMKQXGDtbFqup11i4hHhbLFKv0sqAcTREO+uxwupPCYDgOIyEHqZpJ
         zurHj+oArjDO8bSG6HwG0ljmoF41keHlvDWxYDnEfjN6rjGOedYIxzws/goEP0VfzHa+
         EvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=45ik5JHfgpbUMO7+X66xo52U6DkySR/bQEG5IbUVs7M=;
        b=KxPY4fUIJVUW+2yqJZYYzXJM8Kwny+zWIcl54RXomA/51/WoTbIoGKwVrm3L0qloAj
         UKhfEzVxwlvQIzRz95QIq5uMdldyOY5sFghYFJCILMPkuU/hGwRVC7/ew4XAanwje1On
         Wf770ADvXuDy7mH4GLysqd8PbJsTVZB5jl2yaz58TDK85XhNAHdy/j0GKAiq8ExD78k6
         wlJ001Ev3G+4b8W7KjRkbHTCGGbHUTScewyXyH38iT3asEQFbxb+HcWoR/E04OsOhQp1
         PqHTe56ykJpVA/K7/GBFV6jp+GpyvC7mxjB+LK1FPWubzRjkRdsGwXX+/aJ4TlwSe7IS
         /A6g==
X-Gm-Message-State: AOAM531Zj7ezRge8n175LgQAcN7ckI0pCXP3O+mAXQFvIN+P5yM5XzlH
        Js+OWPSiUJSC34jn974AM0VX3g==
X-Google-Smtp-Source: ABdhPJycUkC+4qvyXIz/GWx5LP9qBVFYddmkfXjuRRVtCLecaubD7IIvN4HgyQA4xry8SX9dJ5n/AA==
X-Received: by 2002:a05:6214:c66:: with SMTP id t6mr8886652qvj.19.1644183629077;
        Sun, 06 Feb 2022 13:40:29 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m5sm4447367qkp.132.2022.02.06.13.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:40:28 -0800 (PST)
Date:   Sun, 6 Feb 2022 13:40:26 -0800 (PST)
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
Subject: [PATCH 06/13] mm/munlock: maintain page->mlock_count while
 unevictable
In-Reply-To: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
Message-ID: <3d204af4-664f-e4b0-4781-16718a2efb9c@google.com>
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

Previous patches have been preparatory: now implement page->mlock_count.
The ordering of the "Unevictable LRU" is of no significance, and there is
no point holding unevictable pages on a list: place page->mlock_count to
overlay page->lru.prev (since page->lru.next is overlaid by compound_head,
which needs to be even so as not to satisfy PageTail - though 2 could be
added instead of 1 for each mlock, if that's ever an improvement).

But it's only safe to rely on or modify page->mlock_count while lruvec
lock is held and page is on unevictable "LRU" - we can save lots of edits
by continuing to pretend that there's an imaginary LRU here (there is an
unevictable count which still needs to be maintained, but not a list).

The mlock_count technique suffers from an unreliability much like with
page_mlock(): while someone else has the page off LRU, not much can
be done.  As before, err on the safe side (behave as if mlock_count 0),
and let try_to_unlock_one() move the page to unevictable if reclaim finds
out later on - a few misplaced pages don't matter, what we want to avoid
is imbalancing reclaim by flooding evictable lists with unevictable pages.

I am not a fan of "if (!isolate_lru_page(page)) putback_lru_page(page);":
if we have taken lruvec lock to get the page off its present list, then
we save everyone trouble (and however many extra atomic ops) by putting
it on its destination list immediately.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mm_inline.h | 11 +++++--
 include/linux/mm_types.h  | 19 +++++++++--
 mm/huge_memory.c          |  5 ++-
 mm/memcontrol.c           |  3 +-
 mm/mlock.c                | 68 +++++++++++++++++++++++++++++++--------
 mm/mmzone.c               |  7 ++++
 mm/swap.c                 |  1 +
 7 files changed, 92 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index b725839dfe71..884d6f6af05b 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -99,7 +99,8 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			folio_nr_pages(folio));
-	list_add(&folio->lru, &lruvec->lists[lru]);
+	if (lru != LRU_UNEVICTABLE)
+		list_add(&folio->lru, &lruvec->lists[lru]);
 }
 
 static __always_inline void add_page_to_lru_list(struct page *page,
@@ -115,6 +116,7 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			folio_nr_pages(folio));
+	/* This is not expected to be used on LRU_UNEVICTABLE */
 	list_add_tail(&folio->lru, &lruvec->lists[lru]);
 }
 
@@ -127,8 +129,11 @@ static __always_inline void add_page_to_lru_list_tail(struct page *page,
 static __always_inline
 void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 {
-	list_del(&folio->lru);
-	update_lru_size(lruvec, folio_lru_list(folio), folio_zonenum(folio),
+	enum lru_list lru = folio_lru_list(folio);
+
+	if (lru != LRU_UNEVICTABLE)
+		list_del(&folio->lru);
+	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			-folio_nr_pages(folio));
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5140e5feb486..475bdb282769 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -85,7 +85,16 @@ struct page {
 			 * lruvec->lru_lock.  Sometimes used as a generic list
 			 * by the page owner.
 			 */
-			struct list_head lru;
+			union {
+				struct list_head lru;
+				/* Or, for the Unevictable "LRU list" slot */
+				struct {
+					/* Always even, to negate PageTail */
+					void *__filler;
+					/* Count page's or folio's mlocks */
+					unsigned int mlock_count;
+				};
+			};
 			/* See page-flags.h for PAGE_MAPPING_FLAGS */
 			struct address_space *mapping;
 			pgoff_t index;		/* Our offset within mapping. */
@@ -241,7 +250,13 @@ struct folio {
 		struct {
 	/* public: */
 			unsigned long flags;
-			struct list_head lru;
+			union {
+				struct list_head lru;
+				struct {
+					void *__filler;
+					unsigned int mlock_count;
+				};
+			};
 			struct address_space *mapping;
 			pgoff_t index;
 			void *private;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d6477f48a27e..9afca0122723 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2300,8 +2300,11 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
 	} else {
 		/* head is still on lru (and we have it frozen) */
 		VM_WARN_ON(!PageLRU(head));
+		if (PageUnevictable(tail))
+			tail->mlock_count = 0;
+		else
+			list_add_tail(&tail->lru, &head->lru);
 		SetPageLRU(tail);
-		list_add_tail(&tail->lru, &head->lru);
 	}
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09d342c7cbd0..b10590926177 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1257,8 +1257,7 @@ struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
  * @nr_pages: positive when adding or negative when removing
  *
  * This function must be called under lru_lock, just before a page is added
- * to or just after a page is removed from an lru list (that ordering being
- * so as to allow it to check that lru_size 0 is consistent with list_empty).
+ * to or just after a page is removed from an lru list.
  */
 void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 				int zid, int nr_pages)
diff --git a/mm/mlock.c b/mm/mlock.c
index db936288b8a0..0d3ae04b1f4e 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -54,16 +54,35 @@ EXPORT_SYMBOL(can_do_mlock);
  */
 void mlock_page(struct page *page)
 {
+	struct lruvec *lruvec;
+	int nr_pages = thp_nr_pages(page);
+
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
 	if (!TestSetPageMlocked(page)) {
-		int nr_pages = thp_nr_pages(page);
-
 		mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
-		count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
-		if (!isolate_lru_page(page))
-			putback_lru_page(page);
+		__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
+	}
+
+	/* There is nothing more we can do while it's off LRU */
+	if (!TestClearPageLRU(page))
+		return;
+
+	lruvec = folio_lruvec_lock_irq(page_folio(page));
+	if (PageUnevictable(page)) {
+		page->mlock_count++;
+		goto out;
 	}
+
+	del_page_from_lru_list(page, lruvec);
+	ClearPageActive(page);
+	SetPageUnevictable(page);
+	page->mlock_count = 1;
+	add_page_to_lru_list(page, lruvec);
+	__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
+out:
+	SetPageLRU(page);
+	unlock_page_lruvec_irq(lruvec);
 }
 
 /**
@@ -72,19 +91,40 @@ void mlock_page(struct page *page)
  */
 void munlock_page(struct page *page)
 {
+	struct lruvec *lruvec;
+	int nr_pages = thp_nr_pages(page);
+
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
+	lock_page_memcg(page);
+	lruvec = folio_lruvec_lock_irq(page_folio(page));
+	if (PageLRU(page) && PageUnevictable(page)) {
+		/* Then mlock_count is maintained, but might undercount */
+		if (page->mlock_count)
+			page->mlock_count--;
+		if (page->mlock_count)
+			goto out;
+	}
+	/* else assume that was the last mlock: reclaim will fix it if not */
+
 	if (TestClearPageMlocked(page)) {
-		int nr_pages = thp_nr_pages(page);
-
-		mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
-		if (!isolate_lru_page(page)) {
-			putback_lru_page(page);
-			count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
-		} else if (PageUnevictable(page)) {
-			count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
-		}
+		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
+		if (PageLRU(page) || !PageUnevictable(page))
+			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
+		else
+			__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
+	}
+
+	/* page_evictable() has to be checked *after* clearing Mlocked */
+	if (PageLRU(page) && PageUnevictable(page) && page_evictable(page)) {
+		del_page_from_lru_list(page, lruvec);
+		ClearPageUnevictable(page);
+		add_page_to_lru_list(page, lruvec);
+		__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	}
+out:
+	unlock_page_lruvec_irq(lruvec);
+	unlock_page_memcg(page);
 }
 
 /*
diff --git a/mm/mmzone.c b/mm/mmzone.c
index eb89d6e018e2..40e1d9428300 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -81,6 +81,13 @@ void lruvec_init(struct lruvec *lruvec)
 
 	for_each_lru(lru)
 		INIT_LIST_HEAD(&lruvec->lists[lru]);
+	/*
+	 * The "Unevictable LRU" is imaginary: though its size is maintained,
+	 * it is never scanned, and unevictable pages are not threaded on it
+	 * (so that their lru fields can be reused to hold mlock_count).
+	 * Poison its list head, so that any operations on it would crash.
+	 */
+	list_del(&lruvec->lists[LRU_UNEVICTABLE]);
 }
 
 #if defined(CONFIG_NUMA_BALANCING) && !defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS)
diff --git a/mm/swap.c b/mm/swap.c
index ff4810e4a4bc..682a03301a2c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1062,6 +1062,7 @@ static void __pagevec_lru_add_fn(struct folio *folio, struct lruvec *lruvec)
 	} else {
 		folio_clear_active(folio);
 		folio_set_unevictable(folio);
+		folio->mlock_count = !!folio_test_mlocked(folio);
 		if (!was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
 	}
-- 
2.34.1

