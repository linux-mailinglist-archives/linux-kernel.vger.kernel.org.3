Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C055115D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiD0LFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiD0LDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:03:32 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D246E1BEAD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:52:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VBSxH83_1651056734;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VBSxH83_1651056734)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Apr 2022 18:52:14 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     almasrymina@google.com, songmuchun@bytedance.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mm: hugetlb: Considering PMD sharing when flushing cache/TLBs
Date:   Wed, 27 Apr 2022 18:52:05 +0800
Message-Id: <0443c8cf20db554d3ff4b439b30e0ff26c0181dd.1651056365.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When moving hugetlb page tables, the cache flushing is called in
move_page_tables() without considering the shared PMDs, which may
be cause cache issues on some architectures.

Thus we should move the hugetlb cache flushing into
move_hugetlb_page_tables() with considering the shared PMDs ranges,
calculated by adjust_range_if_pmd_sharing_possible(). Meanwhile also
expanding the TLBs flushing range in case of shared PMDs.

Note this is discovered via code inspection, and did not meet a real
problem in practice so far.

Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 17 +++++++++++++++--
 mm/mremap.c  |  2 +-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1945dfb..d3a6094 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4937,10 +4937,17 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	unsigned long old_addr_copy;
 	pte_t *src_pte, *dst_pte;
 	struct mmu_notifier_range range;
+	bool shared_pmd = false;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, old_addr,
 				old_end);
 	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
+	/*
+	 * In case of shared PMDs, we should cover the maximum possible
+	 * range.
+	 */
+	flush_cache_range(vma, range.start, range.end);
+
 	mmu_notifier_invalidate_range_start(&range);
 	/* Prevent race with file truncation */
 	i_mmap_lock_write(mapping);
@@ -4957,8 +4964,10 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 		 */
 		old_addr_copy = old_addr;
 
-		if (huge_pmd_unshare(mm, vma, &old_addr_copy, src_pte))
+		if (huge_pmd_unshare(mm, vma, &old_addr_copy, src_pte)) {
+			shared_pmd = true;
 			continue;
+		}
 
 		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
 		if (!dst_pte)
@@ -4966,7 +4975,11 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 
 		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte);
 	}
-	flush_tlb_range(vma, old_end - len, old_end);
+
+	if (shared_pmd)
+		flush_tlb_range(vma, range.start, range.end);
+	else
+		flush_tlb_range(vma, old_end - len, old_end);
 	mmu_notifier_invalidate_range_end(&range);
 	i_mmap_unlock_write(mapping);
 
diff --git a/mm/mremap.c b/mm/mremap.c
index 98f50e6..0970025 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -490,12 +490,12 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		return 0;
 
 	old_end = old_addr + len;
-	flush_cache_range(vma, old_addr, old_end);
 
 	if (is_vm_hugetlb_page(vma))
 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
 						new_addr, len);
 
+	flush_cache_range(vma, old_addr, old_end);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				old_addr, old_end);
 	mmu_notifier_invalidate_range_start(&range);
-- 
1.8.3.1

