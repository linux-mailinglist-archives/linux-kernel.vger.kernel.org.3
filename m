Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1E4FA59D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 09:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbiDIHlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 03:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbiDIHkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 03:40:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E279814016
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 00:38:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kb6RG2zn8zdZj3;
        Sat,  9 Apr 2022 15:38:02 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Apr
 2022 15:38:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ying.huang@intel.com>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <dave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <jhubbard@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <osalvador@suse.de>, <david@redhat.com>, <sfr@canb.auug.org.au>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/4] mm/migration: fix potential pte_unmap on an not mapped pte
Date:   Sat, 9 Apr 2022 15:38:46 +0800
Message-ID: <20220409073846.22286-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220409073846.22286-1-linmiaohe@huawei.com>
References: <20220409073846.22286-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__migration_entry_wait and migration_entry_wait_on_locked assume pte is
always mapped from caller. But this is not the case when it's called from
migration_entry_wait_huge and follow_huge_pmd. And a parameter unmap to
indicate whether pte needs to be unmapped to fix this issue.

Fixes: 30dad30922cc ("mm: migration: add migrate_entry_wait_huge()")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/migrate.h |  2 +-
 include/linux/swapops.h |  4 ++--
 mm/filemap.c            | 10 +++++-----
 mm/hugetlb.c            |  2 +-
 mm/migrate.c            | 14 ++++++++------
 5 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 2707bfd43a0d..2c4de1972f99 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -41,7 +41,7 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
 void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
-				spinlock_t *ptl);
+				spinlock_t *ptl, bool unmap);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
 void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 32d517a28969..3e6a293f88e0 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -231,7 +231,7 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
 }
 
 extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
-					spinlock_t *ptl);
+					spinlock_t *ptl, bool unmap);
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
 extern void migration_entry_wait_huge(struct vm_area_struct *vma,
@@ -258,7 +258,7 @@ static inline int is_migration_entry(swp_entry_t swp)
 }
 
 static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
-					spinlock_t *ptl) { }
+					spinlock_t *ptl, bool unmap) { }
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					 unsigned long address) { }
 static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
diff --git a/mm/filemap.c b/mm/filemap.c
index 3a5ffb5587cd..02f2d920c8cf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1392,6 +1392,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
  * @ptep: mapped pte pointer. Will return with the ptep unmapped. Only required
  *        for pte entries, pass NULL for pmd entries.
  * @ptl: already locked ptl. This function will drop the lock.
+ * @unmap: indicating whether ptep need to be unmapped.
  *
  * Wait for a migration entry referencing the given page to be removed. This is
  * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
@@ -1405,7 +1406,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
  * there.
  */
 void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
-				spinlock_t *ptl)
+				spinlock_t *ptl, bool unmap)
 {
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
@@ -1442,10 +1443,9 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
 	 * a valid reference to the page, and it must take the ptl to remove the
 	 * migration entry. So the page is valid until the ptl is dropped.
 	 */
-	if (ptep)
-		pte_unmap_unlock(ptep, ptl);
-	else
-		spin_unlock(ptl);
+	spin_unlock(ptl);
+	if (unmap && ptep)
+		pte_unmap(ptep);
 
 	for (;;) {
 		unsigned int flags;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fb5a549169ce..3fc61a437c2a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6778,7 +6778,7 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 	} else {
 		if (is_hugetlb_entry_migration(pte)) {
 			spin_unlock(ptl);
-			__migration_entry_wait(mm, (pte_t *)pmd, ptl);
+			__migration_entry_wait(mm, (pte_t *)pmd, ptl, false);
 			goto retry;
 		}
 		/*
diff --git a/mm/migrate.c b/mm/migrate.c
index 044656a14ae2..0bdf27fbc45b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -287,7 +287,7 @@ void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked)
  * When we return from this function the fault will be retried.
  */
 void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
-				spinlock_t *ptl)
+				spinlock_t *ptl, bool unmap)
 {
 	pte_t pte;
 	swp_entry_t entry;
@@ -301,10 +301,12 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 	if (!is_migration_entry(entry))
 		goto out;
 
-	migration_entry_wait_on_locked(entry, ptep, ptl);
+	migration_entry_wait_on_locked(entry, ptep, ptl, unmap);
 	return;
 out:
-	pte_unmap_unlock(ptep, ptl);
+	spin_unlock(ptl);
+	if (unmap)
+		pte_unmap(ptep);
 }
 
 void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
@@ -312,14 +314,14 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 {
 	spinlock_t *ptl = pte_lockptr(mm, pmd);
 	pte_t *ptep = pte_offset_map(pmd, address);
-	__migration_entry_wait(mm, ptep, ptl);
+	__migration_entry_wait(mm, ptep, ptl, true);
 }
 
 void migration_entry_wait_huge(struct vm_area_struct *vma,
 		struct mm_struct *mm, pte_t *pte)
 {
 	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), mm, pte);
-	__migration_entry_wait(mm, pte, ptl);
+	__migration_entry_wait(mm, pte, ptl, false);
 }
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
@@ -330,7 +332,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 	ptl = pmd_lock(mm, pmd);
 	if (!is_pmd_migration_entry(*pmd))
 		goto unlock;
-	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), NULL, ptl);
+	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), NULL, ptl, false);
 	return;
 unlock:
 	spin_unlock(ptl);
-- 
2.23.0

