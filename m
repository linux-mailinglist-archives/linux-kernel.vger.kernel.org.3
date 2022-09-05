Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136395ACA7F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiIEGWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbiIEGW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:22:26 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1099F2D1F8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:22:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662358943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlE1DFZak7ox33QEkAGjI26kF8cTbXvD0IXu7We9lGI=;
        b=WdSyPOOz6wbs25kknHNuAXt/eyuI8K+6rafCoflwSy7uxe9dFzVuRejvVmp9k2bqJUNn2T
        1iEgkl03EfiXDfAMXUM2URIBaEFt6bwKG/zZ+TXLPR34Om9yQaz+LXwEIy73xJ6IL6T6qd
        yUbLpJ/tapOFE6clrIt5AA8XbgfZMeg=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] mm/hwpoison: introduce per-memory_block hwpoison counter
Date:   Mon,  5 Sep 2022 15:21:37 +0900
Message-Id: <20220905062137.1455537-5-naoya.horiguchi@linux.dev>
In-Reply-To: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
References: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Currently PageHWPoison flag does not behave well when experiencing memory
hotremove/hotplug.  Any data field in struct page is unreliable when the
associated memory is offlined, and the current mechanism can't tell whether
a memory section is onlined because a new memory devices is installed or
because previous failed offline operations are undone.  Especially if
there's a hwpoisoned memory, it's unclear what the best option is.

So introduce a new mechanism to make struct memory_block remember that
a memory block has hwpoisoned memory inside it. And make any online event
fail if the onlined memory block contains hwpoison.  struct memory_block
is freed and reallocated over ACPI-based hotremove/hotplug, but not over
sysfs-based hotremove/hotplug.  So it's desirable to implement hwpoison
counter on this struct.

Note that clear_hwpoisoned_pages() is relocated to be called earlier than
now, just before unregistering struct memory_block.  Otherwise, the
per-memory_block hwpoison counter is freed and we fail to adjust global
hwpoison counter properly.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 drivers/base/memory.c  | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/memory.h |  3 +++
 include/linux/mm.h     |  8 ++++++++
 mm/internal.h          |  8 --------
 mm/memory-failure.c    | 36 +++++++++++-------------------------
 mm/sparse.c            |  2 --
 6 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index bc60c9cd3230..10e45083af52 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -183,6 +183,9 @@ static int memory_block_online(struct memory_block *mem)
 	struct zone *zone;
 	int ret;
 
+	if (atomic_long_read(&mem->nr_hwpoison))
+		return -EHWPOISON;
+
 	zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
 				  start_pfn, nr_pages);
 
@@ -864,6 +867,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 		mem = find_memory_block_by_id(block_id);
 		if (WARN_ON_ONCE(!mem))
 			continue;
+		clear_hwpoisoned_pages(atomic_long_read(&mem->nr_hwpoison));
 		unregister_memory_block_under_nodes(mem);
 		remove_memory_block(mem);
 	}
@@ -1170,3 +1174,35 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 	}
 	return ret;
 }
+
+#ifdef CONFIG_MEMORY_FAILURE
+
+void memblk_nr_poison_inc(unsigned long pfn)
+{
+	const unsigned long block_id = pfn_to_block_id(pfn);
+	struct memory_block *mem = find_memory_block_by_id(block_id);
+
+	if (mem)
+		atomic_long_inc(&mem->nr_hwpoison);
+}
+
+void memblk_nr_poison_sub(unsigned long pfn, long i)
+{
+	const unsigned long block_id = pfn_to_block_id(pfn);
+	struct memory_block *mem = find_memory_block_by_id(block_id);
+
+	if (mem)
+		atomic_long_sub(i, &mem->nr_hwpoison);
+}
+
+unsigned long memblk_nr_poison(unsigned long pfn)
+{
+	const unsigned long block_id = pfn_to_block_id(pfn);
+	struct memory_block *mem = find_memory_block_by_id(block_id);
+
+	if (mem)
+		return atomic_long_read(&mem->nr_hwpoison);
+	return 0;
+}
+
+#endif
diff --git a/include/linux/memory.h b/include/linux/memory.h
index aa619464a1df..74e6b3ad947f 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -85,6 +85,9 @@ struct memory_block {
 	unsigned long nr_vmemmap_pages;
 	struct memory_group *group;	/* group (if any) for this block */
 	struct list_head group_next;	/* next block inside memory group */
+#ifdef CONFIG_MEMORY_FAILURE
+	atomic_long_t nr_hwpoison;
+#endif
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6316973afd1d..951c3cdd7683 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3197,6 +3197,10 @@ extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
 #ifdef CONFIG_MEMORY_FAILURE
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
+extern void memblk_nr_poison_inc(unsigned long pfn);
+extern void memblk_nr_poison_sub(unsigned long pfn, long i);
+extern unsigned long memblk_nr_poison(unsigned long pfn);
+extern void clear_hwpoisoned_pages(long nr_poison);
 #else
 static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 {
@@ -3206,6 +3210,10 @@ static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 static inline void num_poisoned_pages_inc(unsigned long pfn)
 {
 }
+
+static inline void clear_hwpoisoned_pages(long nr_poison)
+{
+}
 #endif
 
 #ifndef arch_memory_failure
diff --git a/mm/internal.h b/mm/internal.h
index 785409805ed7..fa481fc04fb7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -738,14 +738,6 @@ extern u64 hwpoison_filter_flags_value;
 extern u64 hwpoison_filter_memcg;
 extern u32 hwpoison_filter_enable;
 
-#ifdef CONFIG_MEMORY_FAILURE
-void clear_hwpoisoned_pages(struct page *memmap, int nr_pages);
-#else
-static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
-{
-}
-#endif
-
 extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
         unsigned long, unsigned long);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7dd4e403e634..5f3a0351a200 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -74,19 +74,17 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool hw_memory_failure __read_mostly = false;
 
-static inline void num_poisoned_pages_inc(unsigned long pfn)
+void num_poisoned_pages_inc(unsigned long pfn)
 {
 	atomic_long_inc(&num_poisoned_pages);
+	memblk_nr_poison_inc(pfn);
 }
 
-static inline void num_poisoned_pages_dec(unsigned long pfn)
-{
-	atomic_long_dec(&num_poisoned_pages);
-}
-
-static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
+void num_poisoned_pages_sub(unsigned long pfn, long i)
 {
 	atomic_long_sub(i, &num_poisoned_pages);
+	if (pfn != -1UL)
+		memblk_nr_poison_sub(pfn, i);
 }
 
 /*
@@ -2408,6 +2406,10 @@ int unpoison_memory(unsigned long pfn)
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
 	if (!ret || freeit) {
+		/*
+		 * TODO: per-memory_block counter might break when the page
+		 * size to be unpoisoned is larger than a memory_block.
+		 */
 		num_poisoned_pages_sub(pfn, count);
 		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
 				 page_to_pfn(p), &unpoison_rs);
@@ -2610,23 +2612,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 	return ret;
 }
 
-void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
+void clear_hwpoisoned_pages(long nr_poison)
 {
-	int i;
-
-	/*
-	 * A further optimization is to have per section refcounted
-	 * num_poisoned_pages.  But that would need more space per memmap, so
-	 * for now just do a quick global check to speed up this routine in the
-	 * absence of bad pages.
-	 */
-	if (atomic_long_read(&num_poisoned_pages) == 0)
-		return;
-
-	for (i = 0; i < nr_pages; i++) {
-		if (PageHWPoison(&memmap[i])) {
-			num_poisoned_pages_dec(page_to_pfn(&memmap[i]));
-			ClearPageHWPoison(&memmap[i]);
-		}
-	}
+	num_poisoned_pages_sub(-1UL, nr_poison);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index e5a8a3a0edd7..2779b419ef2a 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -926,8 +926,6 @@ void sparse_remove_section(struct mem_section *ms, unsigned long pfn,
 		unsigned long nr_pages, unsigned long map_offset,
 		struct vmem_altmap *altmap)
 {
-	clear_hwpoisoned_pages(pfn_to_page(pfn) + map_offset,
-			nr_pages - map_offset);
 	section_deactivate(pfn, nr_pages, altmap);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
-- 
2.25.1

