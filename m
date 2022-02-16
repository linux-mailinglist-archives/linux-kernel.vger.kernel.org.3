Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF0E4B8727
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiBPLx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:53:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiBPLxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:53:19 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B11257DFC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:53:02 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i6so1930184pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MHJFgQra5OTiNxvXaeWRVaAgr/8YUtDV7NnI9XoVTjM=;
        b=KQeRW5bg1GPoJKeIl+ZeoizI4nPoCXw8IXFjrHJrwx2DE84TFoJvmRg3eadnVyTC7S
         I9MapwGKFJFY9RlN04XHx6NEbPzRaBz13BGN+HFoDyzuvrqub9sGf6rDPPmY7NV9On1r
         V2Qq0dz12K3O9JAyiO9OIgieSs/I40K76x7zPLaAj73AXQF8Ock3RBeRmOMa71ZIhxAO
         mzUgQh7MGSpzhihas/3oHoyM41KOBNXxFXWMsOFw6UnHTy29ohjffqmHEhvuHDnz3pm0
         jBonkHZGqxNo2rVjCGXjK13xkS8yVJnudlE9KFY0wfE722hdGz0dCcemGxkAVln3xOR3
         HaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MHJFgQra5OTiNxvXaeWRVaAgr/8YUtDV7NnI9XoVTjM=;
        b=uPXj8YIhQdlpFOg4LBeOmUmCDF2dscSgy7bupB24m7Z+Fj5NKvOk5sea7boP7d+b3P
         tmGwyIwJI30Ir+dUNxUJk93GbBcF1bBGjVA7f292TnjzX+WBex2l3itkobi7JM8LtXit
         lCVB3IPaXmLqQUdoVGTpJs6jHEUNbINGezM5xxYJD/v5a2f1d52U99hfT+TkP6P4Tyux
         FmqIqGupSqpp6lAXQxKCR7/sZQplKsGDPKJRb6PWTMU36sdB25aqfK9PMNptf2PUaulH
         gElq7DoumcC9BcfgJYC8ykph8DD9bocvIVxENaJtce4mD0YgoDV3ldvSJG+gaxcf15ws
         7Azg==
X-Gm-Message-State: AOAM532e7OMxHxJt4YrfhVFwZICkWnpilV5z2PPpJc0jVcJa0u+VQSBy
        N4ovEw9Kf/TsiGcQnJXMiJzxMw==
X-Google-Smtp-Source: ABdhPJz4TK97YPc3MlqsU/p2i6/eFPFUX7hVk8bmtA54c8wjXd84XTk1S0IkeHGA8XZgPoIYoIXIRA==
X-Received: by 2002:a63:6942:0:b0:372:8da5:e137 with SMTP id e63-20020a636942000000b003728da5e137mr1970679pgc.618.1645012382308;
        Wed, 16 Feb 2022 03:53:02 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id m16sm14790221pfc.156.2022.02.16.03.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:53:02 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 10/12] mm: memcontrol: rename {un}lock_page_memcg() to {un}lock_page_objcg()
Date:   Wed, 16 Feb 2022 19:51:30 +0800
Message-Id: <20220216115132.52602-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220216115132.52602-1-songmuchun@bytedance.com>
References: <20220216115132.52602-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the lock_page_memcg() does not lock a page and memcg binding, it
actually lock a page and objcg binding. So rename lock_page_memcg()
to lock_page_objcg().

This is just code cleanup without any functionality changes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst |  2 +-
 fs/buffer.c                                    |  8 ++++----
 include/linux/memcontrol.h                     | 14 +++++++-------
 mm/filemap.c                                   |  2 +-
 mm/huge_memory.c                               |  4 ++--
 mm/memcontrol.c                                | 20 ++++++++++----------
 mm/page-writeback.c                            |  6 +++---
 mm/rmap.c                                      | 14 +++++++-------
 8 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index faac50149a22..ddb795b2ec7e 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -289,7 +289,7 @@ Lock order is as follows:
 
   Page lock (PG_locked bit of page->flags)
     mm->page_table_lock or split pte_lock
-      lock_page_memcg (memcg->move_lock)
+      lock_page_objcg (memcg->move_lock)
         mapping->i_pages lock
           lruvec->lru_lock.
 
diff --git a/fs/buffer.c b/fs/buffer.c
index 30a6e7aa6b7d..3fa1492f057b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -635,14 +635,14 @@ int __set_page_dirty_buffers(struct page *page)
 	 * Lock out page's memcg migration to keep PageDirty
 	 * synchronized with per-memcg dirty page counters.
 	 */
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 	newly_dirty = !TestSetPageDirty(page);
 	spin_unlock(&mapping->private_lock);
 
 	if (newly_dirty)
 		__set_page_dirty(page, mapping, 1);
 
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 
 	if (newly_dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
@@ -1101,13 +1101,13 @@ void mark_buffer_dirty(struct buffer_head *bh)
 		struct page *page = bh->b_page;
 		struct address_space *mapping = NULL;
 
-		lock_page_memcg(page);
+		lock_page_objcg(page);
 		if (!TestSetPageDirty(page)) {
 			mapping = page_mapping(page);
 			if (mapping)
 				__set_page_dirty(page, mapping, 0);
 		}
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 		if (mapping)
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 551fd8b76f9d..9ec428fc4c0b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -411,12 +411,12 @@ static inline struct obj_cgroup *folio_objcg(struct folio *folio)
  * proper memory cgroup pointer. It's not safe to call this function
  * against some type of folios, e.g. slab folios or ex-slab folios.
  *
- * For a folio any of the following ensures folio and memcg binding
- * stability:
+ * For a page any of the following ensures page and objcg binding
+ * stability (But the folio can be reparented to its parent memcg):
  *
  * - the folio lock
  * - LRU isolation
- * - lock_page_memcg()
+ * - lock_page_objcg()
  * - exclusive reference
  *
  * Based on the stable binding of folio and objcg, for a folio any of the
@@ -938,8 +938,8 @@ extern bool cgroup_memory_noswap;
 
 void folio_memcg_lock(struct folio *folio);
 void folio_memcg_unlock(struct folio *folio);
-void lock_page_memcg(struct page *page);
-void unlock_page_memcg(struct page *page);
+void lock_page_objcg(struct page *page);
+void unlock_page_objcg(struct page *page);
 
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
 
@@ -1372,11 +1372,11 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
-static inline void lock_page_memcg(struct page *page)
+static inline void lock_page_objcg(struct page *page)
 {
 }
 
-static inline void unlock_page_memcg(struct page *page)
+static inline void unlock_page_objcg(struct page *page)
 {
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index ad8c39d90bf9..065aee19e168 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -112,7 +112,7 @@
  *    ->i_pages lock		(page_remove_rmap->set_page_dirty)
  *    bdi.wb->list_lock		(page_remove_rmap->set_page_dirty)
  *    ->inode->i_lock		(page_remove_rmap->set_page_dirty)
- *    ->memcg->move_lock	(page_remove_rmap->lock_page_memcg)
+ *    ->memcg->move_lock	(page_remove_rmap->lock_page_objcg)
  *    bdi.wb->list_lock		(zap_pte_range->set_page_dirty)
  *    ->inode->i_lock		(zap_pte_range->set_page_dirty)
  *    ->private_lock		(zap_pte_range->__set_page_dirty_buffers)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d80afc5f14da..4b4af06a1cff 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2227,7 +2227,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				atomic_inc(&page[i]._mapcount);
 		}
 
-		lock_page_memcg(page);
+		lock_page_objcg(page);
 		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
 			/* Last compound_mapcount is gone. */
 			__mod_lruvec_page_state(page, NR_ANON_THPS,
@@ -2238,7 +2238,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 					atomic_dec(&page[i]._mapcount);
 			}
 		}
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 	}
 
 	smp_wmb(); /* make pte visible before pmd */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e4e490690e33..9531bdb6ede3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2194,13 +2194,13 @@ void folio_memcg_lock(struct folio *folio)
 	 * When charge migration first begins, we can have multiple
 	 * critical sections holding the fast-path RCU lock and one
 	 * holding the slowpath move_lock. Track the task who has the
-	 * move_lock for unlock_page_memcg().
+	 * move_lock for unlock_page_objcg().
 	 */
 	memcg->move_lock_task = current;
 	memcg->move_lock_flags = flags;
 }
 
-void lock_page_memcg(struct page *page)
+void lock_page_objcg(struct page *page)
 {
 	folio_memcg_lock(page_folio(page));
 }
@@ -2232,7 +2232,7 @@ void folio_memcg_unlock(struct folio *folio)
 	__folio_memcg_unlock(folio_memcg(folio));
 }
 
-void unlock_page_memcg(struct page *page)
+void unlock_page_objcg(struct page *page)
 {
 	folio_memcg_unlock(page_folio(page));
 }
@@ -2894,7 +2894,7 @@ static void commit_charge(struct folio *folio, struct obj_cgroup *objcg)
 	 *
 	 * - the page lock
 	 * - LRU isolation
-	 * - lock_page_memcg()
+	 * - lock_page_objcg()
 	 * - exclusive reference
 	 */
 	folio->memcg_data = (unsigned long)objcg;
@@ -5822,7 +5822,7 @@ static int mem_cgroup_move_account(struct page *page,
 	 * with (un)charging, migration, LRU putback, or anything else
 	 * that would rely on a stable page's memory cgroup.
 	 *
-	 * Note that lock_page_memcg is a memcg lock, not a page lock,
+	 * Note that lock_page_objcg is a memcg lock, not a page lock,
 	 * to save space. As soon as we switch page's memory cgroup to a
 	 * new memcg that isn't locked, the above state can change
 	 * concurrently again. Make sure we're truly done with it.
@@ -6279,7 +6279,7 @@ static void mem_cgroup_move_charge(void)
 {
 	lru_add_drain_all();
 	/*
-	 * Signal lock_page_memcg() to take the memcg's move_lock
+	 * Signal lock_page_objcg() to take the memcg's move_lock
 	 * while we're moving its pages to another memcg. Then wait
 	 * for already started RCU-only updates to finish.
 	 */
@@ -6311,14 +6311,14 @@ static void mem_cgroup_move_charge(void)
 	/*
 	 * Moving its pages to another memcg is finished. Wait for already
 	 * started RCU-only updates to finish to make sure that the caller
-	 * of lock_page_memcg() can unlock the correct move_lock. The
+	 * of lock_page_objcg() can unlock the correct move_lock. The
 	 * possible bad scenario would like:
 	 *
 	 * CPU0:				CPU1:
 	 * mem_cgroup_move_charge()
 	 *     walk_page_range()
 	 *
-	 *					lock_page_memcg(page)
+	 *					unlock_page_objcg(page)
 	 *					    memcg = folio_memcg()
 	 *					    spin_lock_irqsave(&memcg->move_lock)
 	 *					    memcg->move_lock_task = current
@@ -6329,14 +6329,14 @@ static void mem_cgroup_move_charge(void)
 	 *     memcg_offline_kmem()
 	 *         memcg_reparent_objcgs() <== reparented
 	 *
-	 *					unlock_page_memcg(page)
+	 *					unlock_page_objcg(page)
 	 *					    memcg = folio_memcg() <== memcg has been changed
 	 *					    if (memcg->move_lock_task == current) <== false
 	 *					        spin_unlock_irqrestore(&memcg->move_lock)
 	 *
 	 * Once mem_cgroup_move_charge() returns (it means that the cgroup_mutex
 	 * would be released soon), the page can be reparented to its parent
-	 * memcg. When the unlock_page_memcg() is called for the page, we will
+	 * memcg. When the unlock_page_objcg() is called for the page, we will
 	 * miss unlock the move_lock. So using synchronize_rcu to wait for
 	 * already started RCU-only updates to finish before this function
 	 * returns (mem_cgroup_move_charge() and mem_cgroup_css_offline() are
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 91d163f8d36b..9886da05ca7f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2441,7 +2441,7 @@ EXPORT_SYMBOL(__set_page_dirty_no_writeback);
 /*
  * Helper function for set_page_dirty family.
  *
- * Caller must hold lock_page_memcg().
+ * Caller must hold lock_page_objcg().
  *
  * NOTE: This relies on being atomic wrt interrupts.
  */
@@ -2475,7 +2475,7 @@ static void folio_account_dirtied(struct folio *folio,
 /*
  * Helper function for deaccounting dirty page without writeback.
  *
- * Caller must hold lock_page_memcg().
+ * Caller must hold lock_page_objcg().
  */
 void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
 			  struct bdi_writeback *wb)
@@ -2496,7 +2496,7 @@ void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
  * If warn is true, then emit a warning if the folio is not uptodate and has
  * not been truncated.
  *
- * The caller must hold lock_page_memcg().  Most callers have the folio
+ * The caller must hold lock_page_objcg().  Most callers have the folio
  * locked.  A few have the folio blocked from truncation through other
  * means (eg zap_page_range() has it mapped and is holding the page table
  * lock).  This can also be called from mark_buffer_dirty(), which I
diff --git a/mm/rmap.c b/mm/rmap.c
index 6a1e8c7f6213..29dcdd4eb76f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -32,7 +32,7 @@
  *                 swap_lock (in swap_duplicate, swap_info_get)
  *                   mmlist_lock (in mmput, drain_mmlist and others)
  *                   mapping->private_lock (in __set_page_dirty_buffers)
- *                     lock_page_memcg move_lock (in __set_page_dirty_buffers)
+ *                     lock_page_objcg move_lock (in __set_page_dirty_buffers)
  *                       i_pages lock (widely used)
  *                         lruvec->lru_lock (in folio_lruvec_lock_irq)
  *                   inode->i_lock (in set_page_dirty's __mark_inode_dirty)
@@ -1154,7 +1154,7 @@ void do_page_add_anon_rmap(struct page *page,
 	bool first;
 
 	if (unlikely(PageKsm(page)))
-		lock_page_memcg(page);
+		lock_page_objcg(page);
 	else
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 
@@ -1182,7 +1182,7 @@ void do_page_add_anon_rmap(struct page *page,
 	}
 
 	if (unlikely(PageKsm(page))) {
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 		return;
 	}
 
@@ -1242,7 +1242,7 @@ void page_add_file_rmap(struct page *page, bool compound)
 	int i, nr = 1;
 
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 	if (compound && PageTransHuge(page)) {
 		int nr_pages = thp_nr_pages(page);
 
@@ -1273,7 +1273,7 @@ void page_add_file_rmap(struct page *page, bool compound)
 	}
 	__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
 out:
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 }
 
 static void page_remove_file_rmap(struct page *page, bool compound)
@@ -1374,7 +1374,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
  */
 void page_remove_rmap(struct page *page, bool compound)
 {
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 
 	if (!PageAnon(page)) {
 		page_remove_file_rmap(page, compound);
@@ -1413,7 +1413,7 @@ void page_remove_rmap(struct page *page, bool compound)
 	 * faster for those pages still in swapcache.
 	 */
 out:
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 }
 
 /*
-- 
2.11.0

