Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6DC54BD9E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344866AbiFNW0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbiFNW0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:26:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26C506C5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655245573; x=1686781573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1JcRJtvf1cqzATPkll8v8tW75scjLiK/F3DEZ16TkYw=;
  b=Ubybomb36vgEKGJfYNWM50CzIwywrqNDU4nc5ad/qSHfcnK0K29z156g
   yCB3iGXtgYuC9SiDoLydio4Os4Mrx2bfG9QwpC4nmH0eoMLXUfRdFrNPj
   IJ4YezAuwfRgwsKcCnSboaCgGNR6N0FvdTs0OU6DDRLlcGEYUVOTusDeX
   ErGHcyZu1YPGbeah4BqSfzNRiSoVENNCFV4DIl5qvn+tI3Nu6qVkUWJYt
   B3RF9Sf0myRTSdAcf2Ck3E2N4q+MyeE27Urf++c9Y60qdiNcGSn/fvvP2
   nNTKmushInDWcM9C7tY869ADhvCtdaz7RSJ44+6ms+XpBTfQcXUYw5OgJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="340422017"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="340422017"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 15:26:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588724728"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2022 15:26:12 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: [RFC PATCH 2/3] mm/memory-tiers: Use page counter to track toptier memory usage
Date:   Tue, 14 Jun 2022 15:25:34 -0700
Message-Id: <cefeb63173fa0fac7543315a2abbd4b5a1b25af8.1655242024.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1655242024.git.tim.c.chen@linux.intel.com>
References: <cover.1655242024.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we need to restrict toptier memory usage for a cgroup,
we need to retrieve usage of toptier memory efficiently.
Add a page counter to track toptier memory usage directly
so its value can be returned right away.
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 50 ++++++++++++++++++++++++++++++++------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9ecead1042b9..b4f727cba1de 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -241,6 +241,7 @@ struct mem_cgroup {
 
 	/* Accounted resources */
 	struct page_counter memory;		/* Both v1 & v2 */
+	struct page_counter toptier;
 
 	union {
 		struct page_counter swap;	/* v2 only */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2f6e95e6d200..2f20ec2712b8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -848,6 +848,23 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
 }
 
+static inline void mem_cgroup_charge_toptier(struct mem_cgroup *memcg,
+					     int nid,
+					     int nr_pages)
+{
+	if (!node_is_toptier(nid) || !memcg)
+		return;
+
+	if (nr_pages >= 0) {
+		page_counter_charge(&memcg->toptier,
+				(unsigned long) nr_pages);
+	} else {
+		nr_pages = -nr_pages;
+		page_counter_uncharge(&memcg->toptier,
+				(unsigned long) nr_pages);
+	}
+}
+
 static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				       enum mem_cgroup_events_target target)
 {
@@ -3027,6 +3044,8 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 		if (!ret) {
 			page->memcg_data = (unsigned long)objcg |
 				MEMCG_DATA_KMEM;
+			mem_cgroup_charge_toptier(page_memcg(page),
+					page_to_nid(page), 1 << order);
 			return 0;
 		}
 		obj_cgroup_put(objcg);
@@ -3050,6 +3069,8 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 
 	objcg = __folio_objcg(folio);
 	obj_cgroup_uncharge_pages(objcg, nr_pages);
+	mem_cgroup_charge_toptier(page_memcg(page),
+			page_to_nid(page), -nr_pages);
 	folio->memcg_data = 0;
 	obj_cgroup_put(objcg);
 }
@@ -3947,13 +3968,10 @@ unsigned long mem_cgroup_memtier_usage(struct mem_cgroup *memcg,
 
 unsigned long mem_cgroup_toptier_usage(struct mem_cgroup *memcg)
 {
-	struct memory_tier *top_tier;
-
-	top_tier = list_first_entry(&memory_tiers, struct memory_tier, list);
-	if (top_tier)
-		return mem_cgroup_memtier_usage(memcg, top_tier);
-	else
+	if (!memcg)
 		return 0;
+
+	return page_counter_read(&memcg->toptier);
 }
 
 #endif /* CONFIG_NUMA */
@@ -5228,11 +5246,13 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		memcg->oom_kill_disable = parent->oom_kill_disable;
 
 		page_counter_init(&memcg->memory, &parent->memory);
+		page_counter_init(&memcg->toptier, &parent->toptier);
 		page_counter_init(&memcg->swap, &parent->swap);
 		page_counter_init(&memcg->kmem, &parent->kmem);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
 	} else {
 		page_counter_init(&memcg->memory, NULL);
+		page_counter_init(&memcg->toptier, NULL);
 		page_counter_init(&memcg->swap, NULL);
 		page_counter_init(&memcg->kmem, NULL);
 		page_counter_init(&memcg->tcpmem, NULL);
@@ -5678,6 +5698,8 @@ static int mem_cgroup_move_account(struct page *page,
 	memcg_check_events(to, nid);
 	mem_cgroup_charge_statistics(from, -nr_pages);
 	memcg_check_events(from, nid);
+	mem_cgroup_charge_toptier(to, nid, nr_pages);
+	mem_cgroup_charge_toptier(from, nid, -nr_pages);
 	local_irq_enable();
 out_unlock:
 	folio_unlock(folio);
@@ -6761,6 +6783,7 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
+	mem_cgroup_charge_toptier(memcg, folio_nid(folio), nr_pages);
 	memcg_check_events(memcg, folio_nid(folio));
 	local_irq_enable();
 out:
@@ -6853,6 +6876,7 @@ struct uncharge_gather {
 	unsigned long nr_memory;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
+	unsigned long nr_toptier;
 	int nid;
 };
 
@@ -6867,6 +6891,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 
 	if (ug->nr_memory) {
 		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
+		page_counter_uncharge(&ug->memcg->toptier, ug->nr_toptier);
 		if (do_memsw_account())
 			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
 		if (ug->nr_kmem)
@@ -6929,12 +6954,18 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
 
+		if (node_is_toptier(folio_nid(folio)))
+			ug->nr_toptier += nr_pages;
+
 		folio->memcg_data = 0;
 		obj_cgroup_put(objcg);
 	} else {
 		/* LRU pages aren't accounted at the root level */
-		if (!mem_cgroup_is_root(memcg))
+		if (!mem_cgroup_is_root(memcg)) {
 			ug->nr_memory += nr_pages;
+			if (node_is_toptier(folio_nid(folio)))
+				ug->nr_toptier += nr_pages;
+		}
 		ug->pgpgout++;
 
 		folio->memcg_data = 0;
@@ -7011,6 +7042,7 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	/* Force-charge the new page. The old one will be freed soon */
 	if (!mem_cgroup_is_root(memcg)) {
 		page_counter_charge(&memcg->memory, nr_pages);
+		mem_cgroup_charge_toptier(memcg, folio_nid(new), nr_pages);
 		if (do_memsw_account())
 			page_counter_charge(&memcg->memsw, nr_pages);
 	}
@@ -7231,8 +7263,10 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 
 	folio->memcg_data = 0;
 
-	if (!mem_cgroup_is_root(memcg))
+	if (!mem_cgroup_is_root(memcg)) {
 		page_counter_uncharge(&memcg->memory, nr_entries);
+		mem_cgroup_charge_toptier(memcg, folio_nid(folio), -nr_entries);
+	}
 
 	if (!cgroup_memory_noswap && memcg != swap_memcg) {
 		if (!mem_cgroup_is_root(swap_memcg))
-- 
2.35.1

