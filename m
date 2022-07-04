Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D9564B2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiGDBdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiGDBdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:33:43 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878DF63FD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:33:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656898421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rpbedJgsulqq7WLKw/LuC7umOHTHw0EK2BmjIyWdJrs=;
        b=abwdNNB5Pt5x1Gre7UmxEdMhbC0PqQNVY7hAkaUuWsXf98nsUpeTXP9PlYdeLxHs/oe3ZG
        qOilFBALoOv7WtLHy238Vcm6nsRehC4Y+qO1redZpYFBWq2jdHrlPhQvs+5YMGm0dBLcM2
        QoNvNuQlbLckH8mBYeCpswhwAKRDnik=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable PATCH v4 4/9] mm, hwpoison, hugetlb: support saving mechanism of raw error pages
Date:   Mon,  4 Jul 2022 10:33:07 +0900
Message-Id: <20220704013312.2415700-5-naoya.horiguchi@linux.dev>
In-Reply-To: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

When handling memory error on a hugetlb page, the error handler tries to
dissolve and turn it into 4kB pages.  If it's successfully dissolved,
PageHWPoison flag is moved to the raw error page, so that's all right.
However, dissolve sometimes fails, then the error page is left as
hwpoisoned hugepage. It's useful if we can retry to dissolve it to save
healthy pages, but that's not possible now because the information about
where the raw error pages is lost.

Use the private field of a few tail pages to keep that information.  The
code path of shrinking hugepage pool uses this info to try delayed dissolve.
In order to remember multiple errors in a hugepage, a singly-linked list
originated from SUBPAGE_INDEX_HWPOISON-th tail page is constructed.  Only
simple operations (adding an entry or clearing all) are required and the
list is assumed not to be very long, so this simple data structure should
be enough.

If we failed to save raw error info, the hwpoison hugepage has errors on
unknown subpage, then this new saving mechanism does not work any more,
so disable saving new raw error info and freeing hwpoison hugepages.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
v3 -> v4:
- resolve conflict with "mm: hugetlb_vmemmap: improve hugetlb_vmemmap
  code readability", use hugetlb_vmemmap_restore() instead of
  hugetlb_vmemmap_alloc().

v2 -> v3:
- remove duplicate "return ret" lines,
- use GFP_ATOMIC instead of GFP_KERNEL,
- introduce HPageRawHwpUnreliable pseudo flag (suggested by Muchun),
- hugetlb_clear_page_hwpoison removes raw_hwp_page list even if
  HPageRawHwpUnreliable is true, (by Miaohe)

v1 -> v2:
- support hwpoison hugepage with multiple errors,
- moved the new interface functions to mm/memory-failure.c,
- define additional subpage index SUBPAGE_INDEX_HWPOISON_UNRELIABLE,
- stop freeing/dissolving hwpoison hugepages with unreliable raw error info,
- drop hugetlb_clear_page_hwpoison() in dissolve_free_huge_page() because
  that's done in update_and_free_page(),
- move setting/clearing PG_hwpoison flag to the new interfaces,
- checking already hwpoisoned or not on a subpage basis.

ChangeLog since previous post on 4/27:
- fixed typo in patch description (by Miaohe)
- fixed config value in #ifdef statement (by Miaohe)
- added sentences about "multiple hwpoison pages" scenario in patch
  description

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/hugetlb.h | 18 +++++++++-
 mm/hugetlb.c            | 39 ++++++++++----------
 mm/memory-failure.c     | 80 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 114 insertions(+), 23 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index dce46d571575..29c4d0883d36 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -42,6 +42,9 @@ enum {
 	SUBPAGE_INDEX_CGROUP,		/* reuse page->private */
 	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
 	__MAX_CGROUP_SUBPAGE_INDEX = SUBPAGE_INDEX_CGROUP_RSVD,
+#endif
+#ifdef CONFIG_MEMORY_FAILURE
+	SUBPAGE_INDEX_HWPOISON,
 #endif
 	__NR_USED_SUBPAGE,
 };
@@ -551,7 +554,7 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  *	Synchronization:  Initially set after new page allocation with no
  *	locking.  When examined and modified during migration processing
  *	(isolate, migrate, putback) the hugetlb_lock is held.
- * HPG_temporary - - Set on a page that is temporarily allocated from the buddy
+ * HPG_temporary -- Set on a page that is temporarily allocated from the buddy
  *	allocator.  Typically used for migration target pages when no pages
  *	are available in the pool.  The hugetlb free page path will
  *	immediately free pages with this flag set to the buddy allocator.
@@ -561,6 +564,8 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * HPG_freed - Set when page is on the free lists.
  *	Synchronization: hugetlb_lock held for examination and modification.
  * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
+ * HPG_raw_hwp_unreliable - Set when the hugetlb page has a hwpoison sub-page
+ *     that is not tracked by raw_hwp_page list.
  */
 enum hugetlb_page_flags {
 	HPG_restore_reserve = 0,
@@ -568,6 +573,7 @@ enum hugetlb_page_flags {
 	HPG_temporary,
 	HPG_freed,
 	HPG_vmemmap_optimized,
+	HPG_raw_hwp_unreliable,
 	__NR_HPAGEFLAGS,
 };
 
@@ -614,6 +620,7 @@ HPAGEFLAG(Migratable, migratable)
 HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
 HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
+HPAGEFLAG(RawHwpUnreliable, raw_hwp_unreliable)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
@@ -796,6 +803,15 @@ extern int dissolve_free_huge_page(struct page *page);
 extern int dissolve_free_huge_pages(unsigned long start_pfn,
 				    unsigned long end_pfn);
 
+#ifdef CONFIG_MEMORY_FAILURE
+extern int hugetlb_clear_page_hwpoison(struct page *hpage);
+#else
+static inline int hugetlb_clear_page_hwpoison(struct page *hpage)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 #ifndef arch_hugetlb_migration_supported
 static inline bool arch_hugetlb_migration_supported(struct hstate *h)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 66bb39e0fce8..ccd470f0194c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1535,17 +1535,15 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	if (hugetlb_vmemmap_restore(h, page)) {
-		spin_lock_irq(&hugetlb_lock);
-		/*
-		 * If we cannot allocate vmemmap pages, just refuse to free the
-		 * page and put the page back on the hugetlb free list and treat
-		 * as a surplus page.
-		 */
-		add_hugetlb_page(h, page, true);
-		spin_unlock_irq(&hugetlb_lock);
-		return;
-	}
+	if (hugetlb_vmemmap_restore(h, page))
+		goto fail;
+
+	/*
+	 * Move PageHWPoison flag from head page to the raw error pages,
+	 * which makes any healthy subpages reusable.
+	 */
+	if (unlikely(PageHWPoison(page) && hugetlb_clear_page_hwpoison(page)))
+		goto fail;
 
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
@@ -1566,6 +1564,16 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
+	return;
+fail:
+	spin_lock_irq(&hugetlb_lock);
+	/*
+	 * If we cannot allocate vmemmap pages or cannot identify raw hwpoison
+	 * subpages reliably, just refuse to free the page and put the page
+	 * back on the hugetlb free list and treat as a surplus page.
+	 */
+	add_hugetlb_page(h, page, true);
+	spin_unlock_irq(&hugetlb_lock);
 }
 
 /*
@@ -2109,15 +2117,6 @@ int dissolve_free_huge_page(struct page *page)
 		 */
 		rc = hugetlb_vmemmap_restore(h, head);
 		if (!rc) {
-			/*
-			 * Move PageHWPoison flag from head page to the raw
-			 * error page, which makes any subpages rather than
-			 * the error page reusable.
-			 */
-			if (PageHWPoison(head) && page != head) {
-				SetPageHWPoison(page);
-				ClearPageHWPoison(head);
-			}
 			update_and_free_page(h, head, false);
 		} else {
 			spin_lock_irq(&hugetlb_lock);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c9931c676335..53bf7486a245 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1664,6 +1664,82 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
 #endif /* CONFIG_FS_DAX */
 
+/*
+ * Struct raw_hwp_page represents information about "raw error page",
+ * constructing singly linked list originated from ->private field of
+ * SUBPAGE_INDEX_HWPOISON-th tail page.
+ */
+struct raw_hwp_page {
+	struct llist_node node;
+	struct page *page;
+};
+
+static inline struct llist_head *raw_hwp_list_head(struct page *hpage)
+{
+	return (struct llist_head *)&page_private(hpage + SUBPAGE_INDEX_HWPOISON);
+}
+
+static inline int hugetlb_set_page_hwpoison(struct page *hpage,
+					struct page *page)
+{
+	struct llist_head *head;
+	struct raw_hwp_page *raw_hwp;
+	struct llist_node *t, *tnode;
+	int ret;
+
+	/*
+	 * Once the hwpoison hugepage has lost reliable raw error info,
+	 * there is little meaning to keep additional error info precisely,
+	 * so skip to add additional raw error info.
+	 */
+	if (HPageRawHwpUnreliable(hpage))
+		return -EHWPOISON;
+	head = raw_hwp_list_head(hpage);
+	llist_for_each_safe(tnode, t, head->first) {
+		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
+
+		if (p->page == page)
+			return -EHWPOISON;
+	}
+
+	ret = TestSetPageHWPoison(hpage) ? -EHWPOISON : 0;
+	/* the first error event will be counted in action_result(). */
+	if (ret)
+		num_poisoned_pages_inc();
+
+	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
+	if (raw_hwp) {
+		raw_hwp->page = page;
+		llist_add(&raw_hwp->node, head);
+	} else {
+		/*
+		 * Failed to save raw error info.  We no longer trace all
+		 * hwpoisoned subpages, and we need refuse to free/dissolve
+		 * this hwpoisoned hugepage.
+		 */
+		SetHPageRawHwpUnreliable(hpage);
+	}
+	return ret;
+}
+
+inline int hugetlb_clear_page_hwpoison(struct page *hpage)
+{
+	struct llist_head *head;
+	struct llist_node *t, *tnode;
+
+	if (!HPageRawHwpUnreliable(hpage))
+		ClearPageHWPoison(hpage);
+	head = raw_hwp_list_head(hpage);
+	llist_for_each_safe(tnode, t, head->first) {
+		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
+
+		SetPageHWPoison(p->page);
+		kfree(p);
+	}
+	llist_del_all(head);
+	return 0;
+}
+
 /*
  * Called from hugetlb code with hugetlb_lock held.
  *
@@ -1698,7 +1774,7 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 		goto out;
 	}
 
-	if (TestSetPageHWPoison(head)) {
+	if (hugetlb_set_page_hwpoison(head, page)) {
 		ret = -EHWPOISON;
 		goto out;
 	}
@@ -1751,7 +1827,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	lock_page(head);
 
 	if (hwpoison_filter(p)) {
-		ClearPageHWPoison(head);
+		hugetlb_clear_page_hwpoison(head);
 		res = -EOPNOTSUPP;
 		goto out;
 	}
-- 
2.25.1

