Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389A65379E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiE3Lah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiE3LaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:30:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206127E1FC
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:30:11 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LBY7h0cYBzgYTP;
        Mon, 30 May 2022 19:28:32 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 30 May
 2022 19:30:08 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <peterx@redhat.com>, <apopple@nvidia.com>, <ying.huang@intel.com>,
        <osalvador@suse.de>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>, <hch@lst.de>, <dhowells@redhat.com>,
        <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v4 4/4] mm/migration: fix potential pte_unmap on an not mapped pte
Date:   Mon, 30 May 2022 19:30:16 +0800
Message-ID: <20220530113016.16663-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220530113016.16663-1-linmiaohe@huawei.com>
References: <20220530113016.16663-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

__migration_entry_wait and migration_entry_wait_on_locked assume pte is
always mapped from caller. But this is not the case when it's called from
migration_entry_wait_huge and follow_huge_pmd. Add a hugetlbfs variant that
calls hugetlb_migration_entry_wait(ptep == NULL) to fix this issue.

Fixes: 30dad30922cc ("mm: migration: add migrate_entry_wait_huge()")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/linux/swapops.h | 12 ++++++++----
 mm/hugetlb.c            |  4 ++--
 mm/migrate.c            | 23 +++++++++++++++++++----
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index f24775b41880..bb7afd03a324 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -244,8 +244,10 @@ extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 					spinlock_t *ptl);
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
-extern void migration_entry_wait_huge(struct vm_area_struct *vma,
-		struct mm_struct *mm, pte_t *pte);
+#ifdef CONFIG_HUGETLB_PAGE
+extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
+extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
+#endif
 #else
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
 {
@@ -271,8 +273,10 @@ static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 					spinlock_t *ptl) { }
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					 unsigned long address) { }
-static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
-		struct mm_struct *mm, pte_t *pte) { }
+#ifdef CONFIG_HUGETLB_PAGE
+static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
+static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
+#endif
 static inline int is_writable_migration_entry(swp_entry_t entry)
 {
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 65ab215b39ee..c092157b896a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5694,7 +5694,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
-			migration_entry_wait_huge(vma, mm, ptep);
+			migration_entry_wait_huge(vma, ptep);
 			return 0;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
@@ -6919,7 +6919,7 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 	} else {
 		if (is_hugetlb_entry_migration(pte)) {
 			spin_unlock(ptl);
-			__migration_entry_wait(mm, (pte_t *)pmd, ptl);
+			__migration_entry_wait_huge((pte_t *)pmd, ptl);
 			goto retry;
 		}
 		/*
diff --git a/mm/migrate.c b/mm/migrate.c
index a14c6d5ceafc..3359a6e169bb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -315,13 +315,28 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	__migration_entry_wait(mm, ptep, ptl);
 }
 
-void migration_entry_wait_huge(struct vm_area_struct *vma,
-		struct mm_struct *mm, pte_t *pte)
+#ifdef CONFIG_HUGETLB_PAGE
+void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
 {
-	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), mm, pte);
-	__migration_entry_wait(mm, pte, ptl);
+	pte_t pte;
+
+	spin_lock(ptl);
+	pte = huge_ptep_get(ptep);
+
+	if (unlikely(!is_hugetlb_entry_migration(pte)))
+		spin_unlock(ptl);
+	else
+		migration_entry_wait_on_locked(pte_to_swp_entry(pte), NULL, ptl);
 }
 
+void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
+{
+	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, pte);
+
+	__migration_entry_wait_huge(pte, ptl);
+}
+#endif
+
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 {
-- 
2.23.0

