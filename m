Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4641B537606
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiE3Hw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiE3HwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:52:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D200CE39
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:51:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gd1so2123102pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHHwRXT4NPA3dNEWLRGKZUfTyeAeKsYLTuXrhRkWfDM=;
        b=yUDMo/O91Wcss4NFsx1qSVoD+u+E4a7NTlFOwfAYtdDPAyAOM4RLYHUyfmKWSN6L5H
         wbJ8HkzAyGQs9WLmn/dPcH5/btuQQX3gnAgxe9c/8mcjYsLfBjQF7/c/u57m3iZElYTX
         kvnS72J1bhZrhf4dAMcv/1wWdoFB7ufe/JKc2NttPWcqnX6xcc9JlDUv/5v3GAVXC1xV
         fiqk66kQaGe53jU1NbeFfaDjNSSuoiFHSqpw0UBOOLNbWl9xuyEVzvIDTJWNgdLpuXj7
         8wTXz6XJ9hdi9HH6ffeCxIv5Yl7tZD+pT20hfopsB/Jkls8VLfSSQXFcaSdl4om5cHrW
         tYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHHwRXT4NPA3dNEWLRGKZUfTyeAeKsYLTuXrhRkWfDM=;
        b=VwtmVaP7Ev2gPMppd80twd124Y751YYZ62O6c9RGB/xVDev+5rEDdjA57PpCHule/T
         pNliprleiZKFgS02Vrp8sJVD321Y6VwJ1ao+QzFQE8me6aU5qjTmiZZGHedW+rukxm7i
         gvcJm2NfHxiZ5XZ9OA/FjDlruCA4MjqFpGltYzVFwk1GzDGoiUzU3Mf9gSBI0ASM4d9b
         EOXIipB9/VzlqNZMAvqzZqE5m93Rjj/xf6wdk6o7/W4OaDazwRM+RqzHNZLjgDCPCOpP
         4BP5uJO4RJS8wTKFUk5zBW/7OLSQf//wD9EJjFFGSBmDpO/U6pWH/Hj+vgeRb7fPlK4d
         FdIA==
X-Gm-Message-State: AOAM530OxlS0I+j80oeY9ZsscQCn5MRJ+ZaN+cRafhdCbAfFipIO3I83
        P1RS6+vRtKIs1SQiJ37kitCY1A==
X-Google-Smtp-Source: ABdhPJxTIdL9pAhUXVIJ5QlkRX1sLVU21czYu6GwIC3LiRO1i7YkmXNmWYWeC/tw/MSQuJgnemPsbg==
X-Received: by 2002:a17:902:704a:b0:161:996e:bf4 with SMTP id h10-20020a170902704a00b00161996e0bf4mr54349648plt.118.1653897096375;
        Mon, 30 May 2022 00:51:36 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:2071:e13a:8aa:cacf])
        by smtp.gmail.com with ESMTPSA id a23-20020a170902b59700b001616c3bd5c2sm8421381pls.162.2022.05.30.00.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 00:51:35 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 09/11] mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
Date:   Mon, 30 May 2022 15:49:17 +0800
Message-Id: <20220530074919.46352-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220530074919.46352-1-songmuchun@bytedance.com>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will reuse the obj_cgroup APIs to charge the LRU pages. Finally,
page->memcg_data will have 2 different meanings.

  - For the slab pages, page->memcg_data points to an object cgroups
    vector.

  - For the kmem pages (exclude the slab pages) and the LRU pages,
    page->memcg_data points to an object cgroup.

In this patch, we reuse obj_cgroup APIs to charge LRU pages. In the end,
The page cache cannot prevent long-living objects from pinning the original
memory cgroup in the memory.

At the same time we also changed the rules of page and objcg or memcg
binding stability. The new rules are as follows.

For a page any of the following ensures page and objcg binding stability:

  - the page lock
  - LRU isolation
  - lock_page_memcg()
  - exclusive reference

Based on the stable binding of page and objcg, for a page any of the
following ensures page and memcg binding stability:

  - objcg_lock
  - cgroup_mutex
  - the lruvec lock
  - the split queue lock (only THP page)

If the caller only want to ensure that the page counters of memcg are
updated correctly, ensure that the binding stability of page and objcg
is sufficient.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  89 +++++---------
 mm/huge_memory.c           |  35 ++++++
 mm/memcontrol.c            | 289 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 276 insertions(+), 137 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c2ac98a0ece4..e3a4354e20da 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -386,8 +386,6 @@ enum page_memcg_data_flags {
 
 #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
 
-static inline bool folio_memcg_kmem(struct folio *folio);
-
 /*
  * After the initialization objcg->memcg is always pointing at
  * a valid memcg, but can be atomically swapped to the parent memcg.
@@ -401,43 +399,19 @@ static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 }
 
 /*
- * __folio_memcg - Get the memory cgroup associated with a non-kmem folio
- * @folio: Pointer to the folio.
- *
- * Returns a pointer to the memory cgroup associated with the folio,
- * or NULL. This function assumes that the folio is known to have a
- * proper memory cgroup pointer. It's not safe to call this function
- * against some type of folios, e.g. slab folios or ex-slab folios or
- * kmem folios.
- */
-static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
-{
-	unsigned long memcg_data = folio->memcg_data;
-
-	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_KMEM, folio);
-
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
-}
-
-/*
- * __folio_objcg - get the object cgroup associated with a kmem folio.
+ * folio_objcg - get the object cgroup associated with a folio.
  * @folio: Pointer to the folio.
  *
  * Returns a pointer to the object cgroup associated with the folio,
  * or NULL. This function assumes that the folio is known to have a
- * proper object cgroup pointer. It's not safe to call this function
- * against some type of folios, e.g. slab folios or ex-slab folios or
- * LRU folios.
+ * proper object cgroup pointer.
  */
-static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
+static inline struct obj_cgroup *folio_objcg(struct folio *folio)
 {
 	unsigned long memcg_data = folio->memcg_data;
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
-	VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);
 
 	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
@@ -451,22 +425,33 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
  * proper memory cgroup pointer. It's not safe to call this function
  * against some type of folios, e.g. slab folios or ex-slab folios.
  *
- * For a non-kmem folio any of the following ensures folio and memcg binding
- * stability:
+ * For a folio any of the following ensures folio and objcg binding stability:
  *
  * - the folio lock
  * - LRU isolation
  * - lock_page_memcg()
  * - exclusive reference
  *
+ * Based on the stable binding of folio and objcg, for a folio any of the
+ * following ensures folio and memcg binding stability:
+ *
+ * - objcg_lock
+ * - cgroup_mutex
+ * - the lruvec lock
+ * - the split queue lock (only THP page)
+ *
+ * If the caller only want to ensure that the page counters of memcg are
+ * updated correctly, ensure that the binding stability of folio and objcg
+ * is sufficient.
+ *
  * Note: The caller should hold an rcu read lock to protect memcg associated
  * with a folio from being released.
  */
 static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 {
-	if (folio_memcg_kmem(folio))
-		return obj_cgroup_memcg(__folio_objcg(folio));
-	return __folio_memcg(folio);
+	struct obj_cgroup *objcg = folio_objcg(folio);
+
+	return objcg ? obj_cgroup_memcg(objcg) : NULL;
 }
 
 /*
@@ -490,6 +475,8 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
  * folio is known to have a proper memory cgroup pointer. It's not safe
  * to call this function against some type of pages, e.g. slab pages or
  * ex-slab pages.
+ *
+ * The page and objcg or memcg binding rules can refer to folio_memcg().
  */
 static inline struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
 {
@@ -520,22 +507,20 @@ static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
  *
  * Return: A pointer to the memory cgroup associated with the folio,
  * or NULL.
+ *
+ * The folio and objcg or memcg binding rules can refer to folio_memcg().
  */
 static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 {
 	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
+	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
-	if (memcg_data & MEMCG_DATA_KMEM) {
-		struct obj_cgroup *objcg;
+	objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 
-		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
-		return obj_cgroup_memcg(objcg);
-	}
-
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return objcg ? obj_cgroup_memcg(objcg) : NULL;
 }
 
 /*
@@ -548,16 +533,10 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
  * has an associated memory cgroup pointer or an object cgroups vector or
  * an object cgroup.
  *
- * For a non-kmem page any of the following ensures page and memcg binding
- * stability:
+ * The page and objcg or memcg binding rules can refer to page_memcg().
  *
- * - the page lock
- * - LRU isolation
- * - lock_page_memcg()
- * - exclusive reference
- *
- * For a kmem page a caller should hold an rcu read lock to protect memcg
- * associated with a kmem page from being released.
+ * A caller should hold an rcu read lock to protect memcg associated with a
+ * page from being released.
  */
 static inline struct mem_cgroup *page_memcg_check(struct page *page)
 {
@@ -566,18 +545,14 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
 	 * for slab pages, READ_ONCE() should be used here.
 	 */
 	unsigned long memcg_data = READ_ONCE(page->memcg_data);
+	struct obj_cgroup *objcg;
 
 	if (memcg_data & MEMCG_DATA_OBJCGS)
 		return NULL;
 
-	if (memcg_data & MEMCG_DATA_KMEM) {
-		struct obj_cgroup *objcg;
-
-		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
-		return obj_cgroup_memcg(objcg);
-	}
+	objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return objcg ? obj_cgroup_memcg(objcg) : NULL;
 }
 
 static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3411dc291ab..931d0c2ce062 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -503,6 +503,8 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_MEMCG
+static struct shrinker deferred_split_shrinker;
+
 static inline struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
 		struct deferred_split *queue)
 {
@@ -519,6 +521,39 @@ static inline struct deferred_split *folio_memcg_split_queue(struct folio *folio
 
 	return memcg ? &memcg->deferred_split_queue : NULL;
 }
+
+static void thp_sq_reparent_lock(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	spin_lock(&src->deferred_split_queue.split_queue_lock);
+	spin_lock_nested(&dst->deferred_split_queue.split_queue_lock,
+			 SINGLE_DEPTH_NESTING);
+}
+
+static void thp_sq_reparent_relocate(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	int nid;
+	struct deferred_split *src_queue, *dst_queue;
+
+	src_queue = &src->deferred_split_queue;
+	dst_queue = &dst->deferred_split_queue;
+
+	if (!src_queue->split_queue_len)
+		return;
+
+	list_splice_tail_init(&src_queue->split_queue, &dst_queue->split_queue);
+	dst_queue->split_queue_len += src_queue->split_queue_len;
+	src_queue->split_queue_len = 0;
+
+	for_each_node(nid)
+		set_shrinker_bit(dst, nid, deferred_split_shrinker.id);
+}
+
+static void thp_sq_reparent_unlock(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	spin_unlock(&dst->deferred_split_queue.split_queue_lock);
+	spin_unlock(&src->deferred_split_queue.split_queue_lock);
+}
+DEFINE_MEMCG_REPARENT_OPS(thp_sq);
 #else
 static inline struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
 		struct deferred_split *queue)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 059188eeb80c..f4db3cb2aedc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -76,6 +76,7 @@ struct cgroup_subsys memory_cgrp_subsys __read_mostly;
 EXPORT_SYMBOL(memory_cgrp_subsys);
 
 struct mem_cgroup *root_mem_cgroup __read_mostly;
+static struct obj_cgroup *root_obj_cgroup __read_mostly;
 
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
@@ -256,6 +257,11 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 
 static DEFINE_SPINLOCK(objcg_lock);
 
+static inline bool obj_cgroup_is_root(struct obj_cgroup *objcg)
+{
+	return objcg == root_obj_cgroup;
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 bool mem_cgroup_kmem_disabled(void)
 {
@@ -363,8 +369,77 @@ static void objcg_reparent_unlock(struct mem_cgroup *src, struct mem_cgroup *dst
 
 static DEFINE_MEMCG_REPARENT_OPS(objcg);
 
+static void lruvec_reparent_lock(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	int nid, nest = 0;
+
+	for_each_node(nid) {
+		spin_lock_nested(&mem_cgroup_lruvec(src,
+				 NODE_DATA(nid))->lru_lock, nest++);
+		spin_lock_nested(&mem_cgroup_lruvec(dst,
+				 NODE_DATA(nid))->lru_lock, nest++);
+	}
+}
+
+static void lruvec_reparent_lru(struct lruvec *src, struct lruvec *dst,
+				enum lru_list lru)
+{
+	int zid;
+	struct mem_cgroup_per_node *mz_src, *mz_dst;
+
+	mz_src = container_of(src, struct mem_cgroup_per_node, lruvec);
+	mz_dst = container_of(dst, struct mem_cgroup_per_node, lruvec);
+
+	if (lru != LRU_UNEVICTABLE)
+		list_splice_tail_init(&src->lists[lru], &dst->lists[lru]);
+
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		mz_dst->lru_zone_size[zid][lru] += mz_src->lru_zone_size[zid][lru];
+		mz_src->lru_zone_size[zid][lru] = 0;
+	}
+}
+
+static void lruvec_reparent_relocate(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	int nid;
+
+	for_each_node(nid) {
+		enum lru_list lru;
+		struct lruvec *src_lruvec, *dst_lruvec;
+
+		src_lruvec = mem_cgroup_lruvec(src, NODE_DATA(nid));
+		dst_lruvec = mem_cgroup_lruvec(dst, NODE_DATA(nid));
+
+		dst_lruvec->anon_cost += src_lruvec->anon_cost;
+		dst_lruvec->file_cost += src_lruvec->file_cost;
+
+		for_each_lru(lru)
+			lruvec_reparent_lru(src_lruvec, dst_lruvec, lru);
+	}
+}
+
+static void lruvec_reparent_unlock(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	int nid;
+
+	for_each_node(nid) {
+		spin_unlock(&mem_cgroup_lruvec(dst, NODE_DATA(nid))->lru_lock);
+		spin_unlock(&mem_cgroup_lruvec(src, NODE_DATA(nid))->lru_lock);
+	}
+}
+
+static DEFINE_MEMCG_REPARENT_OPS(lruvec);
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+DECLARE_MEMCG_REPARENT_OPS(thp_sq);
+#endif
+
 static const struct memcg_reparent_ops *memcg_reparent_ops[] = {
 	&memcg_objcg_reparent_ops,
+	&memcg_lruvec_reparent_ops,
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	&memcg_thp_sq_reparent_ops,
+#endif
 };
 
 #define DEFINE_MEMCG_REPARENT_FUNC(phase)				\
@@ -2818,18 +2893,33 @@ static inline void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages
 		page_counter_uncharge(&memcg->memsw, nr_pages);
 }
 
-static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
+static void commit_charge(struct folio *folio, struct obj_cgroup *objcg)
 {
-	VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
+	VM_BUG_ON_FOLIO(folio_objcg(folio), folio);
 	/*
-	 * Any of the following ensures page's memcg stability:
+	 * Any of the following ensures page's objcg stability:
 	 *
 	 * - the page lock
 	 * - LRU isolation
 	 * - lock_page_memcg()
 	 * - exclusive reference
 	 */
-	folio->memcg_data = (unsigned long)memcg;
+	folio->memcg_data = (unsigned long)objcg;
+}
+
+static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
+{
+	struct obj_cgroup *objcg = NULL;
+
+	rcu_read_lock();
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		objcg = rcu_dereference(memcg->objcg);
+		if (objcg && obj_cgroup_tryget(objcg))
+			break;
+	}
+	rcu_read_unlock();
+
+	return objcg;
 }
 
 #ifdef CONFIG_MEMCG_KMEM
@@ -2960,12 +3050,15 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 	else
 		memcg = mem_cgroup_from_task(current);
 
-	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
-		objcg = rcu_dereference(memcg->objcg);
-		if (objcg && obj_cgroup_tryget(objcg))
-			break;
+	if (mem_cgroup_is_root(memcg))
+		goto out;
+
+	objcg = __get_obj_cgroup_from_memcg(memcg);
+	if (obj_cgroup_is_root(objcg)) {
+		obj_cgroup_put(objcg);
 		objcg = NULL;
 	}
+out:
 	rcu_read_unlock();
 
 	return objcg;
@@ -3062,13 +3155,13 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
 	struct folio *folio = page_folio(page);
-	struct obj_cgroup *objcg;
+	struct obj_cgroup *objcg = folio_objcg(folio);
 	unsigned int nr_pages = 1 << order;
 
-	if (!folio_memcg_kmem(folio))
+	if (!objcg)
 		return;
 
-	objcg = __folio_objcg(folio);
+	VM_BUG_ON_FOLIO(!folio_memcg_kmem(folio), folio);
 	obj_cgroup_uncharge_pages(objcg, nr_pages);
 	folio->memcg_data = 0;
 	obj_cgroup_put(objcg);
@@ -3322,26 +3415,21 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
- * Because page_memcg(head) is not set on tails, set it now.
+ * Because page_objcg(head) is not set on tails, set it now.
  */
 void split_page_memcg(struct page *head, unsigned int nr)
 {
 	struct folio *folio = page_folio(head);
-	struct mem_cgroup *memcg = get_mem_cgroup_from_folio(folio);
+	struct obj_cgroup *objcg = folio_objcg(folio);
 	int i;
 
-	if (mem_cgroup_disabled() || !memcg)
+	if (mem_cgroup_disabled() || !objcg)
 		return;
 
 	for (i = 1; i < nr; i++)
 		folio_page(folio, i)->memcg_data = folio->memcg_data;
 
-	if (folio_memcg_kmem(folio))
-		obj_cgroup_get_many(__folio_objcg(folio), nr - 1);
-	else
-		css_get_many(&memcg->css, nr - 1);
-
-	css_put(&memcg->css);
+	obj_cgroup_get_many(objcg, nr - 1);
 }
 
 #ifdef CONFIG_MEMCG_SWAP
@@ -5238,6 +5326,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	objcg->memcg = memcg;
 	rcu_assign_pointer(memcg->objcg, objcg);
 
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		root_obj_cgroup = objcg;
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
@@ -5642,10 +5733,12 @@ static int mem_cgroup_move_account(struct page *page,
 	 */
 	smp_mb();
 
-	css_get(&to->css);
-	css_put(&from->css);
+	rcu_read_lock();
+	obj_cgroup_get(rcu_dereference(to->objcg));
+	obj_cgroup_put(rcu_dereference(from->objcg));
+	rcu_read_unlock();
 
-	folio->memcg_data = (unsigned long)to;
+	folio->memcg_data = (unsigned long)rcu_access_pointer(to->objcg);
 
 	__folio_memcg_unlock(from);
 
@@ -6118,6 +6211,42 @@ static void mem_cgroup_move_charge(void)
 
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
+
+	/*
+	 * Moving its pages to another memcg is finished. Wait for already
+	 * started RCU-only updates to finish to make sure that the caller
+	 * of lock_page_memcg() can unlock the correct move_lock. The
+	 * possible bad scenario would like:
+	 *
+	 * CPU0:				CPU1:
+	 * mem_cgroup_move_charge()
+	 *     walk_page_range()
+	 *
+	 *					lock_page_memcg(page)
+	 *					    memcg = folio_memcg()
+	 *					    spin_lock_irqsave(&memcg->move_lock)
+	 *					    memcg->move_lock_task = current
+	 *
+	 *     atomic_dec(&mc.from->moving_account)
+	 *
+	 * mem_cgroup_css_offline()
+	 *     memcg_offline_kmem()
+	 *         memcg_reparent_objcgs() <== reparented
+	 *
+	 *					unlock_page_memcg(page)
+	 *					    memcg = folio_memcg() <== memcg has been changed
+	 *					    if (memcg->move_lock_task == current) <== false
+	 *					        spin_unlock_irqrestore(&memcg->move_lock)
+	 *
+	 * Once mem_cgroup_move_charge() returns (it means that the cgroup_mutex
+	 * would be released soon), the page can be reparented to its parent
+	 * memcg. When the unlock_page_memcg() is called for the page, we will
+	 * miss unlock the move_lock. So using synchronize_rcu to wait for
+	 * already started RCU-only updates to finish before this function
+	 * returns (mem_cgroup_move_charge() and mem_cgroup_css_offline() are
+	 * serialized by cgroup_mutex).
+	 */
+	synchronize_rcu();
 }
 
 /*
@@ -6673,21 +6802,26 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 			gfp_t gfp)
 {
+	struct obj_cgroup *objcg;
 	long nr_pages = folio_nr_pages(folio);
-	int ret;
+	int ret = 0;
 
-	ret = try_charge(memcg, gfp, nr_pages);
+	objcg = __get_obj_cgroup_from_memcg(memcg);
+	/* Do not account at the root objcg level. */
+	if (!obj_cgroup_is_root(objcg))
+		ret = try_charge(memcg, gfp, nr_pages);
 	if (ret)
 		goto out;
 
-	css_get(&memcg->css);
-	commit_charge(folio, memcg);
+	obj_cgroup_get(objcg);
+	commit_charge(folio, objcg);
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(folio));
 	local_irq_enable();
 out:
+	obj_cgroup_put(objcg);
 	return ret;
 }
 
@@ -6773,7 +6907,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
 }
 
 struct uncharge_gather {
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	unsigned long nr_memory;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
@@ -6788,63 +6922,56 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 static void uncharge_batch(const struct uncharge_gather *ug)
 {
 	unsigned long flags;
+	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(ug->objcg);
 	if (ug->nr_memory) {
-		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
+		page_counter_uncharge(&memcg->memory, ug->nr_memory);
 		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
+			page_counter_uncharge(&memcg->memsw, ug->nr_memory);
 		if (ug->nr_kmem)
-			memcg_account_kmem(ug->memcg, -ug->nr_kmem);
-		memcg_oom_recover(ug->memcg);
+			memcg_account_kmem(memcg, -ug->nr_kmem);
+		memcg_oom_recover(memcg);
 	}
 
 	local_irq_save(flags);
-	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
-	memcg_check_events(ug->memcg, ug->nid);
+	__count_memcg_events(memcg, PGPGOUT, ug->pgpgout);
+	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
+	memcg_check_events(memcg, ug->nid);
 	local_irq_restore(flags);
+	rcu_read_unlock();
 
 	/* drop reference from uncharge_folio */
-	css_put(&ug->memcg->css);
+	obj_cgroup_put(ug->objcg);
 }
 
 static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 {
 	long nr_pages;
-	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
-	 * folio memcg or objcg at this point, we have fully
-	 * exclusive access to the folio.
+	 * folio objcg at this point, we have fully exclusive
+	 * access to the folio.
 	 */
-	if (folio_memcg_kmem(folio)) {
-		objcg = __folio_objcg(folio);
-		/*
-		 * This get matches the put at the end of the function and
-		 * kmem pages do not hold memcg references anymore.
-		 */
-		memcg = get_mem_cgroup_from_objcg(objcg);
-	} else {
-		memcg = __folio_memcg(folio);
-	}
-
-	if (!memcg)
+	objcg = folio_objcg(folio);
+	if (!objcg)
 		return;
 
-	if (ug->memcg != memcg) {
-		if (ug->memcg) {
+	if (ug->objcg != objcg) {
+		if (ug->objcg) {
 			uncharge_batch(ug);
 			uncharge_gather_clear(ug);
 		}
-		ug->memcg = memcg;
+		ug->objcg = objcg;
 		ug->nid = folio_nid(folio);
 
-		/* pairs with css_put in uncharge_batch */
-		css_get(&memcg->css);
+		/* pairs with obj_cgroup_put in uncharge_batch */
+		obj_cgroup_get(objcg);
 	}
 
 	nr_pages = folio_nr_pages(folio);
@@ -6852,19 +6979,15 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 	if (folio_memcg_kmem(folio)) {
 		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
-
-		folio->memcg_data = 0;
-		obj_cgroup_put(objcg);
 	} else {
 		/* LRU pages aren't accounted at the root level */
-		if (!mem_cgroup_is_root(memcg))
+		if (!obj_cgroup_is_root(objcg))
 			ug->nr_memory += nr_pages;
 		ug->pgpgout++;
-
-		folio->memcg_data = 0;
 	}
 
-	css_put(&memcg->css);
+	folio->memcg_data = 0;
+	obj_cgroup_put(objcg);
 }
 
 void __mem_cgroup_uncharge(struct folio *folio)
@@ -6872,7 +6995,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
 	struct uncharge_gather ug;
 
 	/* Don't touch folio->lru of any random page, pre-check: */
-	if (!folio_memcg(folio))
+	if (!folio_objcg(folio))
 		return;
 
 	uncharge_gather_clear(&ug);
@@ -6895,7 +7018,7 @@ void __mem_cgroup_uncharge_list(struct list_head *page_list)
 	uncharge_gather_clear(&ug);
 	list_for_each_entry(folio, page_list, lru)
 		uncharge_folio(folio, &ug);
-	if (ug.memcg)
+	if (ug.objcg)
 		uncharge_batch(&ug);
 }
 
@@ -6912,6 +7035,7 @@ void __mem_cgroup_uncharge_list(struct list_head *page_list)
 void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	long nr_pages = folio_nr_pages(new);
 	unsigned long flags;
 
@@ -6924,30 +7048,33 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 		return;
 
 	/* Page cache replacement: new folio already charged? */
-	if (folio_memcg(new))
+	if (folio_objcg(new))
 		return;
 
-	memcg = get_mem_cgroup_from_folio(old);
-	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
-	if (!memcg)
+	objcg = folio_objcg(old);
+	VM_WARN_ON_ONCE_FOLIO(!objcg, old);
+	if (!objcg)
 		return;
 
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+
 	/* Force-charge the new page. The old one will be freed soon */
-	if (!mem_cgroup_is_root(memcg)) {
+	if (!obj_cgroup_is_root(objcg)) {
 		page_counter_charge(&memcg->memory, nr_pages);
 		if (do_memsw_account())
 			page_counter_charge(&memcg->memsw, nr_pages);
 	}
 
-	css_get(&memcg->css);
-	commit_charge(new, memcg);
+	obj_cgroup_get(objcg);
+	commit_charge(new, objcg);
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(new));
 	local_irq_restore(flags);
 
-	css_put(&memcg->css);
+	rcu_read_unlock();
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
@@ -7120,6 +7247,7 @@ static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
 void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 {
 	struct mem_cgroup *memcg, *swap_memcg;
+	struct obj_cgroup *objcg;
 	unsigned int nr_entries;
 	unsigned short oldid;
 
@@ -7132,15 +7260,16 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	objcg = folio_objcg(folio);
+	VM_WARN_ON_ONCE_FOLIO(!objcg, folio);
+	if (!objcg)
+		return;
+
 	/*
 	 * Interrupts should be disabled by the caller (see the comments below),
 	 * which can serve as RCU read-side critical sections.
 	 */
-	memcg = folio_memcg(folio);
-
-	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
-	if (!memcg)
-		return;
+	memcg = obj_cgroup_memcg(objcg);
 
 	/*
 	 * In case the memcg owning these pages has been offlined and doesn't
@@ -7159,7 +7288,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 
 	folio->memcg_data = 0;
 
-	if (!mem_cgroup_is_root(memcg))
+	if (!obj_cgroup_is_root(objcg))
 		page_counter_uncharge(&memcg->memory, nr_entries);
 
 	if (!cgroup_memory_noswap && memcg != swap_memcg) {
@@ -7179,7 +7308,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	memcg_stats_unlock();
 	memcg_check_events(memcg, folio_nid(folio));
 
-	css_put(&memcg->css);
+	obj_cgroup_put(objcg);
 }
 
 /**
-- 
2.11.0

