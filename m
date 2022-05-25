Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C60533836
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiEYISy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiEYISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:18:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9762237A08
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:18:17 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L7P6h6G4Gz1JCP1;
        Wed, 25 May 2022 16:16:44 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 16:18:14 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <naoya.horiguchi@nec.com>
CC:     <peterx@redhat.com>, <apopple@nvidia.com>, <ying.huang@intel.com>,
        <david@redhat.com>, <songmuchun@bytedance.com>, <hch@lst.de>,
        <dhowells@redhat.com>, <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3 3/4] mm/migration: return errno when isolate_huge_page failed
Date:   Wed, 25 May 2022 16:18:21 +0800
Message-ID: <20220525081822.53547-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220525081822.53547-1-linmiaohe@huawei.com>
References: <20220525081822.53547-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We might fail to isolate huge page due to e.g. the page is under migration
which cleared HPageMigratable. We should return errno in this case rather
than always return 1 which could confuse the user, i.e. the caller might
think all of the memory is migrated while the hugetlb page is left behind.
We make the prototype of isolate_huge_page consistent with isolate_lru_page
as suggested by Huang Ying and rename isolate_huge_page to isolate_hugetlb
as suggested by Muchun to improve the readability.

Fixes: e8db67eb0ded ("mm: migrate: move_pages() supports thp migration")
Suggested-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/hugetlb.h |  6 +++---
 mm/gup.c                |  2 +-
 mm/hugetlb.c            | 11 +++++------
 mm/memory-failure.c     |  2 +-
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  5 +++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e4cff27d1198..756b66ff025e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -170,7 +170,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
-bool isolate_huge_page(struct page *page, struct list_head *list);
+int isolate_hugetlb(struct page *page, struct list_head *list);
 int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 void putback_active_hugepage(struct page *page);
@@ -376,9 +376,9 @@ static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 	return NULL;
 }
 
-static inline bool isolate_huge_page(struct page *page, struct list_head *list)
+static inline int isolate_hugetlb(struct page *page, struct list_head *list)
 {
-	return false;
+	return -EBUSY;
 }
 
 static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
diff --git a/mm/gup.c b/mm/gup.c
index 551264407624..3899dcb288a6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1898,7 +1898,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 		 * Try to move out any movable page before pinning the range.
 		 */
 		if (folio_test_hugetlb(folio)) {
-			if (!isolate_huge_page(&folio->page,
+			if (isolate_hugetlb(&folio->page,
 						&movable_page_list))
 				isolation_error_count++;
 			continue;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 01f0e2e5ab48..2026fcfc8886 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2765,8 +2765,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Fail with -EBUSY if not possible.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		if (!isolate_huge_page(old_page, list))
-			ret = -EBUSY;
+		ret = isolate_hugetlb(old_page, list);
 		spin_lock_irq(&hugetlb_lock);
 		goto free_new;
 	} else if (!HPageFreed(old_page)) {
@@ -2842,7 +2841,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	if (page_count(head) && isolate_huge_page(head, list))
+	if (page_count(head) && !isolate_hugetlb(head, list))
 		ret = 0;
 	else if (!page_count(head))
 		ret = alloc_and_dissolve_huge_page(h, head, list);
@@ -6945,15 +6944,15 @@ follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int fla
 	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
 }
 
-bool isolate_huge_page(struct page *page, struct list_head *list)
+int isolate_hugetlb(struct page *page, struct list_head *list)
 {
-	bool ret = true;
+	int ret = 0;
 
 	spin_lock_irq(&hugetlb_lock);
 	if (!PageHeadHuge(page) ||
 	    !HPageMigratable(page) ||
 	    !get_page_unless_zero(page)) {
-		ret = false;
+		ret = -EBUSY;
 		goto unlock;
 	}
 	ClearHPageMigratable(page);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b85661cbdc4a..5deb1b1cb2fd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2166,7 +2166,7 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 	bool lru = PageLRU(page);
 
 	if (PageHuge(page)) {
-		isolated = isolate_huge_page(page, pagelist);
+		isolated = !isolate_hugetlb(page, pagelist);
 	} else {
 		if (lru)
 			isolated = !isolate_lru_page(page);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2dad094177bf..f96d55131689 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -602,7 +602,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 	/* With MPOL_MF_MOVE, we migrate only unshared hugepage. */
 	if (flags & (MPOL_MF_MOVE_ALL) ||
 	    (flags & MPOL_MF_MOVE && page_mapcount(page) == 1)) {
-		if (!isolate_huge_page(page, qp->pagelist) &&
+		if (isolate_hugetlb(page, qp->pagelist) &&
 			(flags & MPOL_MF_STRICT))
 			/*
 			 * Failed to isolate page but allow migrating pages
diff --git a/mm/migrate.c b/mm/migrate.c
index 337336115e43..97c31b87d1a2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1627,8 +1627,9 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 
 	if (PageHuge(page)) {
 		if (PageHead(page)) {
-			isolate_huge_page(page, pagelist);
-			err = 1;
+			err = isolate_hugetlb(page, pagelist);
+			if (!err)
+				err = 1;
 		}
 	} else {
 		struct page *head;
-- 
2.23.0

