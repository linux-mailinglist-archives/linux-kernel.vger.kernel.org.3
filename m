Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7984B871E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiBPLwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:52:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiBPLwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:52:20 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1E417E96C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so6186626pjv.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VBuKjaMGz0RKRLNoDxkfNXGbY7zkmBfjt3EnnJ2sbqs=;
        b=Gd/ICDonVA6jL9bUSwNgIKPxrv0uG4ezITWgsUe7/fXPKDiPa/HaVxzEG51b5Pvnsw
         0cjp78q4Q9B9BXqAJZ4H8KWRgRxCnNcHpS7fOxKMmGI2QXNvJPVwUNj4Zzg32txkRWbd
         O7ysn8hOWxTEPakJOBtkdGR0jw7US3pHANmTAr+T3O0Na6wg2eAl10UWW4E4w3klABOo
         l8KeJYULvQHDRKwWlr9hWqS0HWrzNhIH7knZ8Dw3sYW0j+Idn1+BskgZ9mb4x/GzE9ou
         GsmtQtBtjP3zpx9lVQt8JvVYvhKiHLIhYnJoyRDGeAJE8oGljsMUOLxYFrZLZN2RD5AT
         lvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VBuKjaMGz0RKRLNoDxkfNXGbY7zkmBfjt3EnnJ2sbqs=;
        b=1d4CXLUKCVrmHMtw7n7iUJcRQqeeyMiWm0CSt/aPcPTEFWknvraDzYhOacS8b7rhfE
         nIuyh8LeIhmCP0Th3MyN0tq9DlyRcCD5V+CvhrZikLiBWzZ0Ch8BqSqBidx2Pg6YjYmf
         V3fM2iLiUd3EdAyqpYq99l46Lr/fMNyo3faRSAWCGQP0mDUdTHXvorjGfb7KC89274Zd
         B7EWLzcu3bPfA1/2XoSQ1d1mJSfavQbpoiXQsYvGqLdpDndgbMZTneVC2CXeheEo76/s
         idV762hSCxb6fOMSvAcCioVkZY+zdsfoOUUYbKQ3EIHg3nE3hVqTgi8HE2KgCbJPCuD8
         oxvQ==
X-Gm-Message-State: AOAM533fFlGgWvprhQIntCSThoHYLzjgu7sanU5+hiAvRqQZtIeuDSCg
        mBr6i6koHLBSAVf0CpkYSx6F2A==
X-Google-Smtp-Source: ABdhPJw3myGB8oMgHV8KImh6yJzTsuuYP82CElEbDHcyF/480YwZrqTEM4h84W2eSo19n7SdFE5qfA==
X-Received: by 2002:a17:90b:3d0e:b0:1b9:b05f:c7ae with SMTP id pt14-20020a17090b3d0e00b001b9b05fc7aemr1312981pjb.54.1645012327491;
        Wed, 16 Feb 2022 03:52:07 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id m16sm14790221pfc.156.2022.02.16.03.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:52:07 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 01/12] mm: memcontrol: prepare objcg API for non-kmem usage
Date:   Wed, 16 Feb 2022 19:51:21 +0800
Message-Id: <20220216115132.52602-2-songmuchun@bytedance.com>
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

Pagecache pages are charged at the allocation time and holding a
reference to the original memory cgroup until being reclaimed.
Depending on the memory pressure, specific patterns of the page
sharing between different cgroups and the cgroup creation and
destruction rates, a large number of dying memory cgroups can be
pinned by pagecache pages. It makes the page reclaim less efficient
and wastes memory.

We can convert LRU pages and most other raw memcg pins to the objcg
direction to fix this problem, and then the page->memcg will always
point to an object cgroup pointer.

Therefore, the infrastructure of objcg no longer only serves
CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
can reuse it to charge pages.

We know that the LRU pages are not accounted at the root level. But
the page->memcg_data points to the root_mem_cgroup. So the
page->memcg_data of the LRU pages always points to a valid pointer.
But the root_mem_cgroup dose not have an object cgroup. If we use
obj_cgroup APIs to charge the LRU pages, we should set the
page->memcg_data to a root object cgroup. So we also allocate an
object cgroup for the root_mem_cgroup.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  2 +-
 mm/memcontrol.c            | 66 +++++++++++++++++++++++++++++-----------------
 2 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0abbd685703b..81a2720653d0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -314,10 +314,10 @@ struct mem_cgroup {
 
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
+#endif
 	struct obj_cgroup __rcu *objcg;
 	/* list of inherited objcgs, protected by objcg_lock */
 	struct list_head objcg_list;
-#endif
 
 	MEMCG_PADDING(_pad2_);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 36e9f38c919d..6501f5b6df4b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -253,9 +253,9 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 	return container_of(vmpr, struct mem_cgroup, vmpressure);
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 static DEFINE_SPINLOCK(objcg_lock);
 
+#ifdef CONFIG_MEMCG_KMEM
 bool mem_cgroup_kmem_disabled(void)
 {
 	return cgroup_memory_nokmem;
@@ -264,12 +264,10 @@ bool mem_cgroup_kmem_disabled(void)
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 				      unsigned int nr_pages);
 
-static void obj_cgroup_release(struct percpu_ref *ref)
+static void obj_cgroup_release_bytes(struct obj_cgroup *objcg)
 {
-	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
 	unsigned int nr_bytes;
 	unsigned int nr_pages;
-	unsigned long flags;
 
 	/*
 	 * At this point all allocated objects are freed, and
@@ -283,9 +281,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	 * 3) CPU1: a process from another memcg is allocating something,
 	 *          the stock if flushed,
 	 *          objcg->nr_charged_bytes = PAGE_SIZE - 92
-	 * 5) CPU0: we do release this object,
+	 * 4) CPU0: we do release this object,
 	 *          92 bytes are added to stock->nr_bytes
-	 * 6) CPU0: stock is flushed,
+	 * 5) CPU0: stock is flushed,
 	 *          92 bytes are added to objcg->nr_charged_bytes
 	 *
 	 * In the result, nr_charged_bytes == PAGE_SIZE.
@@ -297,6 +295,19 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
+}
+#else
+static inline void obj_cgroup_release_bytes(struct obj_cgroup *objcg)
+{
+}
+#endif
+
+static void obj_cgroup_release(struct percpu_ref *ref)
+{
+	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
+	unsigned long flags;
+
+	obj_cgroup_release_bytes(objcg);
 
 	spin_lock_irqsave(&objcg_lock, flags);
 	list_del(&objcg->list);
@@ -325,10 +336,14 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
-static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
-				  struct mem_cgroup *parent)
+static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg, *iter;
+	struct mem_cgroup *parent;
+
+	parent = parent_mem_cgroup(memcg);
+	if (!parent)
+		parent = root_mem_cgroup;
 
 	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
 
@@ -347,6 +362,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 	percpu_ref_kill(&objcg->refcnt);
 }
 
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be used as a shrinker list's index.
  * The main reason for not using cgroup id for this:
@@ -3624,7 +3640,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
-	struct obj_cgroup *objcg;
 	int memcg_id;
 
 	if (cgroup_memory_nokmem)
@@ -3636,14 +3651,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (memcg_id < 0)
 		return memcg_id;
 
-	objcg = obj_cgroup_alloc();
-	if (!objcg) {
-		memcg_free_cache_id(memcg_id);
-		return -ENOMEM;
-	}
-	objcg->memcg = memcg;
-	rcu_assign_pointer(memcg->objcg, objcg);
-
 	static_branch_enable(&memcg_kmem_enabled_key);
 
 	memcg->kmemcg_id = memcg_id;
@@ -3663,8 +3670,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	if (!parent)
 		parent = root_mem_cgroup;
 
-	memcg_reparent_objcgs(memcg, parent);
-
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
 
@@ -5166,8 +5171,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
-	INIT_LIST_HEAD(&memcg->objcg_list);
 #endif
+	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
@@ -5239,16 +5244,22 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	struct obj_cgroup *objcg;
 
 	/*
 	 * A memcg must be visible for expand_shrinker_info()
 	 * by the time the maps are allocated. So, we allocate maps
 	 * here, when for_each_mem_cgroup() can't skip it.
 	 */
-	if (alloc_shrinker_info(memcg)) {
-		mem_cgroup_id_remove(memcg);
-		return -ENOMEM;
-	}
+	if (alloc_shrinker_info(memcg))
+		goto remove_id;
+
+	objcg = obj_cgroup_alloc();
+	if (!objcg)
+		goto free_shrinker;
+
+	objcg->memcg = memcg;
+	rcu_assign_pointer(memcg->objcg, objcg);
 
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
@@ -5258,6 +5269,12 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
 				   2UL*HZ);
 	return 0;
+
+free_shrinker:
+	free_shrinker_info(memcg);
+remove_id:
+	mem_cgroup_id_remove(memcg);
+	return -ENOMEM;
 }
 
 static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
@@ -5281,6 +5298,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
+	memcg_reparent_objcgs(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 
-- 
2.11.0

