Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E6D4B8723
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiBPLxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:53:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiBPLw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:52:57 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F01B3703D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:44 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id z4so1910135pgh.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehgm4bZ9T8zfc3OBtMyS8a0oj2CsPXwDpvgWKkCOIvY=;
        b=NKqOxmOesPE3d6DrmZfDGvssc9NxEN64pl3DAetzC31QXJ7FUXMKfTKLb7DsI9vo1X
         d4moMpjaj7HOs/Fwj1N6RhiVF4UU1a9x7XfUTdZmVazgMR2Pbo7vCycvYS7U/uSN3gNW
         Kxoo4pzmQY+YS5RNNT/qvjfKxv2NkuwdqzHiHxRlWCny6eNsm7lOoTMHwhi3YA9ycgnv
         v2KiPqEXhMWliQ0oOB9tLT7cUvudWcfQmw6VdyBgwOE8jldGKC0Vkh0+iTfiLAPKbM30
         YjQ/oTh2tUvzPh86jbpUGVfhxn28hvdvuYycUqw+GFaO3wxSvbnKdkkqjEALLEzgvAcW
         yaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehgm4bZ9T8zfc3OBtMyS8a0oj2CsPXwDpvgWKkCOIvY=;
        b=vAGrcRAgUw7C/Ek1kKe+S4agtOTwsBd+ouR9FDFcVI0agi10dQiNtA1xee1B/qUjp1
         Xcnn8z+mmXVAuiG/jfC6Xa6js1RSejhuhF6wgNGap8QD0XtftDW8vgLnyHOInU7nCMvS
         bf+U2L824tFWed2AtPvVUtLo4rgzT6K+7v4JdMHN9KB2IQOJ0OM0+j/uhRKvqOLnOvsK
         cKsd3pRa/7xvFkUDHypKfRao+sSJ9IQsIBC4pvwbU83JDimWrY2ljvAJy3ngnEbrUB5B
         Kw7TVsT5dQzxuk95WGtKcM9H5auc9NWFr6UxwuHc+Ak2b9vnfqFmEE526ODovLTLr8yV
         wfAQ==
X-Gm-Message-State: AOAM532FnPaFUeBt9VQm5LrczsK4HKMZKTvLNXcAlRNQUcZZrj+QE2Wq
        hdhBsSmuMbdUZfSb3NOU19CMNw==
X-Google-Smtp-Source: ABdhPJxSgZOdBmBUY7aCW2+/epfBVifBjz/zVVrsZjAeQuXY9TGBCuNC8vx35vvo6Pu9PdBzcs+Zeg==
X-Received: by 2002:a05:6a00:13a8:b0:4e1:6da6:b7a8 with SMTP id t40-20020a056a0013a800b004e16da6b7a8mr2715170pfg.27.1645012363781;
        Wed, 16 Feb 2022 03:52:43 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id m16sm14790221pfc.156.2022.02.16.03.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:52:43 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 07/12] mm: memcontrol: make all the callers of {folio,page}_memcg() safe
Date:   Wed, 16 Feb 2022 19:51:27 +0800
Message-Id: <20220216115132.52602-8-songmuchun@bytedance.com>
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

When we use objcg APIs to charge the LRU pages, the page will not hold
a reference to the memcg associated with the page. So the caller of the
{folio,page}_memcg() should hold an rcu read lock or obtain a reference
to the memcg associated with the page to protect memcg from being
released. So introduce get_mem_cgroup_from_{page,folio}() to obtain a
reference to the memory cgroup associated with the page.

In this patch, make all the callers hold an rcu read lock or obtain a
reference to the memcg to protect memcg from being released when the LRU
pages reparented.

We do not need to adjust the callers of {folio,page}_memcg() during
the whole process of mem_cgroup_move_task(). Because the cgroup migration
and memory cgroup offlining are serialized by @cgroup_mutex. In this
routine, the LRU pages cannot be reparented to its parent memory cgroup.
So {folio,page}_memcg() is stable and cannot be released.

This is a preparation for reparenting the LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/buffer.c                      |  4 +--
 fs/fs-writeback.c                | 23 ++++++++--------
 include/linux/memcontrol.h       | 49 ++++++++++++++++++++++++++++++---
 include/trace/events/writeback.h |  5 ++++
 mm/memcontrol.c                  | 58 ++++++++++++++++++++++++++++++----------
 mm/migrate.c                     |  4 +++
 mm/page_io.c                     |  5 ++--
 7 files changed, 116 insertions(+), 32 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8e112b6bd371..30a6e7aa6b7d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -822,8 +822,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 	if (retry)
 		gfp |= __GFP_NOFAIL;
 
-	/* The page lock pins the memcg */
-	memcg = page_memcg(page);
+	memcg = get_mem_cgroup_from_page(page);
 	old_memcg = set_active_memcg(memcg);
 
 	head = NULL;
@@ -843,6 +842,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		set_bh_page(bh, page, offset);
 	}
 out:
+	mem_cgroup_put(memcg);
 	set_active_memcg(old_memcg);
 	return head;
 /*
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f8d7fe6db989..d6059676fc7b 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -243,15 +243,13 @@ void __inode_attach_wb(struct inode *inode, struct page *page)
 	if (inode_cgwb_enabled(inode)) {
 		struct cgroup_subsys_state *memcg_css;
 
-		if (page) {
-			memcg_css = mem_cgroup_css_from_page(page);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
-		} else {
-			/* must pin memcg_css, see wb_get_create() */
+		/* must pin memcg_css, see wb_get_create() */
+		if (page)
+			memcg_css = get_mem_cgroup_css_from_page(page);
+		else
 			memcg_css = task_get_css(current, memory_cgrp_id);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
-			css_put(memcg_css);
-		}
+		wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+		css_put(memcg_css);
 	}
 
 	if (!wb)
@@ -868,16 +866,16 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 	if (!wbc->wb || wbc->no_cgroup_owner)
 		return;
 
-	css = mem_cgroup_css_from_page(page);
+	css = get_mem_cgroup_css_from_page(page);
 	/* dead cgroups shouldn't contribute to inode ownership arbitration */
 	if (!(css->flags & CSS_ONLINE))
-		return;
+		goto out;
 
 	id = css->id;
 
 	if (id == wbc->wb_id) {
 		wbc->wb_bytes += bytes;
-		return;
+		goto out;
 	}
 
 	if (id == wbc->wb_lcand_id)
@@ -890,6 +888,9 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 		wbc->wb_tcand_bytes += bytes;
 	else
 		wbc->wb_tcand_bytes -= min(bytes, wbc->wb_tcand_bytes);
+
+out:
+	css_put(css);
 }
 EXPORT_SYMBOL_GPL(wbc_account_cgroup_owner);
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index df607c9de500..6e0f7104f2fa 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -372,7 +372,7 @@ static inline bool folio_memcg_kmem(struct folio *folio);
  * a valid memcg, but can be atomically swapped to the parent memcg.
  *
  * The caller must ensure that the returned memcg won't be released:
- * e.g. acquire the rcu_read_lock or css_set_lock.
+ * e.g. acquire the rcu_read_lock or css_set_lock or cgroup_mutex.
  */
 static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 {
@@ -454,6 +454,36 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 }
 
 /**
+ * get_mem_cgroup_from_folio - Obtain a reference on the memory cgroup
+ *			       associated with a folio.
+ * @folio: Pointer to the folio.
+ *
+ * Returns a pointer to the memory cgroup (and obtain a reference on it)
+ * associated with the folio, or NULL. This function assumes that the
+ * folio is known to have a proper memory cgroup pointer. It's not safe
+ * to call this function against some type of pages, e.g. slab pages or
+ * ex-slab pages.
+ */
+static inline struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+retry:
+	memcg = folio_memcg(folio);
+	if (unlikely(memcg && !css_tryget(&memcg->css)))
+		goto retry;
+	rcu_read_unlock();
+
+	return memcg;
+}
+
+static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
+{
+	return get_mem_cgroup_from_folio(page_folio(page));
+}
+
+/**
  * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
  * @folio: Pointer to the folio.
  *
@@ -861,7 +891,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
 	return match;
 }
 
-struct cgroup_subsys_state *mem_cgroup_css_from_page(struct page *page);
+struct cgroup_subsys_state *get_mem_cgroup_css_from_page(struct page *page);
 ino_t page_cgroup_ino(struct page *page);
 
 static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
@@ -1034,10 +1064,13 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
 static inline void count_memcg_page_event(struct page *page,
 					  enum vm_event_item idx)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
+	memcg = page_memcg(page);
 	if (memcg)
 		count_memcg_events(memcg, idx, 1);
+	rcu_read_unlock();
 }
 
 static inline void count_memcg_event_mm(struct mm_struct *mm,
@@ -1116,6 +1149,16 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 	return NULL;
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
+{
+	return NULL;
+}
+
+static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index a345b1e12daf..b5e9b07e5edb 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -258,6 +258,11 @@ TRACE_EVENT(track_foreign_dirty,
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
+		/*
+		 * TP_fast_assign() is under preemption disabled which can
+		 * serve as an RCU read-side critical section so that the
+		 * memcg returned by folio_memcg() cannot be freed.
+		 */
 		__entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);
 	),
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7c7672631456..dd2602149ef3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -416,7 +416,7 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 #endif
 
 /**
- * mem_cgroup_css_from_page - css of the memcg associated with a page
+ * get_mem_cgroup_css_from_page - get css of the memcg associated with a page
  * @page: page of interest
  *
  * If memcg is bound to the default hierarchy, css of the memcg associated
@@ -426,13 +426,15 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
  * If memcg is bound to a traditional hierarchy, the css of root_mem_cgroup
  * is returned.
  */
-struct cgroup_subsys_state *mem_cgroup_css_from_page(struct page *page)
+struct cgroup_subsys_state *get_mem_cgroup_css_from_page(struct page *page)
 {
 	struct mem_cgroup *memcg;
 
-	memcg = page_memcg(page);
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return &root_mem_cgroup->css;
 
-	if (!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	memcg = get_mem_cgroup_from_page(page);
+	if (!memcg)
 		memcg = root_mem_cgroup;
 
 	return &memcg->css;
@@ -754,13 +756,13 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
 			     int val)
 {
-	struct page *head = compound_head(page); /* rmap on tail pages */
+	struct folio *folio = page_folio(page); /* rmap on tail pages */
 	struct mem_cgroup *memcg;
 	pg_data_t *pgdat = page_pgdat(page);
 	struct lruvec *lruvec;
 
 	rcu_read_lock();
-	memcg = page_memcg(head);
+	memcg = folio_memcg(folio);
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
 	if (!memcg) {
 		rcu_read_unlock();
@@ -2046,7 +2048,9 @@ void folio_memcg_lock(struct folio *folio)
 	 * The RCU lock is held throughout the transaction.  The fast
 	 * path can get away without acquiring the memcg->move_lock
 	 * because page moving starts with an RCU grace period.
-         */
+	 *
+	 * The RCU lock also protects the memcg from being freed.
+	 */
 	rcu_read_lock();
 
 	if (mem_cgroup_disabled())
@@ -3336,7 +3340,7 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 void split_page_memcg(struct page *head, unsigned int nr)
 {
 	struct folio *folio = page_folio(head);
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg = get_mem_cgroup_from_folio(folio);
 	int i;
 
 	if (mem_cgroup_disabled() || !memcg)
@@ -3349,6 +3353,8 @@ void split_page_memcg(struct page *head, unsigned int nr)
 		obj_cgroup_get_many(__folio_objcg(folio), nr - 1);
 	else
 		css_get_many(&memcg->css, nr - 1);
+
+	css_put(&memcg->css);
 }
 
 #ifdef CONFIG_MEMCG_SWAP
@@ -4562,7 +4568,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 					     struct bdi_writeback *wb)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg = get_mem_cgroup_from_folio(folio);
 	struct memcg_cgwb_frn *frn;
 	u64 now = get_jiffies_64();
 	u64 oldest_at = now;
@@ -4609,6 +4615,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 		frn->memcg_id = wb->memcg_css->id;
 		frn->at = now;
 	}
+	css_put(&memcg->css);
 }
 
 /* issue foreign writeback flushes for recorded foreign dirtying events */
@@ -6167,6 +6174,14 @@ static void mem_cgroup_move_charge(void)
 	atomic_dec(&mc.from->moving_account);
 }
 
+/*
+ * The cgroup migration and memory cgroup offlining are serialized by
+ * @cgroup_mutex. If we reach here, it means that the LRU pages cannot
+ * be reparented to its parent memory cgroup. So during the whole process
+ * of mem_cgroup_move_task(), page_memcg(page) is stable. So we do not
+ * need to worry about the memcg (returned from page_memcg()) being
+ * released even if we do not hold an rcu read lock.
+ */
 static void mem_cgroup_move_task(void)
 {
 	if (mc.to) {
@@ -6971,7 +6986,7 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	if (folio_memcg(new))
 		return;
 
-	memcg = folio_memcg(old);
+	memcg = get_mem_cgroup_from_folio(old);
 	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
 	if (!memcg)
 		return;
@@ -6990,6 +7005,8 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(new));
 	local_irq_restore(flags);
+
+	css_put(&memcg->css);
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
@@ -7176,6 +7193,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	/*
+	 * Interrupts should be disabled by the caller (see the comments below),
+	 * which can serve as RCU read-side critical sections.
+	 */
 	memcg = page_memcg(page);
 
 	VM_WARN_ON_ONCE_PAGE(!memcg, page);
@@ -7240,15 +7261,16 @@ int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return 0;
 
+	rcu_read_lock();
 	memcg = page_memcg(page);
 
 	VM_WARN_ON_ONCE_PAGE(!memcg, page);
 	if (!memcg)
-		return 0;
+		goto out;
 
 	if (!entry.val) {
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		return 0;
+		goto out;
 	}
 
 	memcg = mem_cgroup_id_get_online(memcg);
@@ -7258,6 +7280,7 @@ int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
 		mem_cgroup_id_put(memcg);
+		rcu_read_unlock();
 		return -ENOMEM;
 	}
 
@@ -7267,6 +7290,8 @@ int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	oldid = swap_cgroup_record(entry, mem_cgroup_id(memcg), nr_pages);
 	VM_BUG_ON_PAGE(oldid, page);
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
+out:
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -7321,17 +7346,22 @@ bool mem_cgroup_swap_full(struct page *page)
 	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return false;
 
+	rcu_read_lock();
 	memcg = page_memcg(page);
 	if (!memcg)
-		return false;
+		goto out;
 
 	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
 		unsigned long usage = page_counter_read(&memcg->swap);
 
 		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
-		    usage * 2 >= READ_ONCE(memcg->swap.max))
+		    usage * 2 >= READ_ONCE(memcg->swap.max)) {
+			rcu_read_unlock();
 			return true;
+		}
 	}
+out:
+	rcu_read_unlock();
 
 	return false;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..04838c98b2ea 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -442,6 +442,10 @@ int folio_migrate_mapping(struct address_space *mapping,
 		struct lruvec *old_lruvec, *new_lruvec;
 		struct mem_cgroup *memcg;
 
+		/*
+		 * Irq is disabled, which can serve as RCU read-side critical
+		 * sections.
+		 */
 		memcg = folio_memcg(folio);
 		old_lruvec = mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
 		new_lruvec = mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
diff --git a/mm/page_io.c b/mm/page_io.c
index 0bf8e40f4e57..3d823be3445a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -270,13 +270,14 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 	struct cgroup_subsys_state *css;
 	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
 	memcg = page_memcg(page);
 	if (!memcg)
-		return;
+		goto out;
 
-	rcu_read_lock();
 	css = cgroup_e_css(memcg->css.cgroup, &io_cgrp_subsys);
 	bio_associate_blkg_from_css(bio, css);
+out:
 	rcu_read_unlock();
 }
 #else
-- 
2.11.0

