Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666D859D29D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbiHWHun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241286AbiHWHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:50:22 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0AB6555A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:50:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VN0jAoy_1661241014;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VN0jAoy_1661241014)
          by smtp.aliyun-inc.com;
          Tue, 23 Aug 2022 15:50:14 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] mm/hugetlb: use PTE page lock to protect CONT-PTE entries
Date:   Tue, 23 Aug 2022 15:50:02 +0800
Message-Id: <064489292e6e224ef4406af990c7cdc3c054ca77.1661240170.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the pte entries of a CONT-PTE hugetlb can not span on
multiple PTEs, we can change to use the PTE page lock, which can
be much finer grain that lock in the mm.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/hugetlb.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d491138..4b172a7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -892,9 +892,23 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
-	if (huge_page_size(h) == PMD_SIZE)
-		return pmd_lockptr(mm, (pmd_t *) pte);
 	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
+
+	if (huge_page_size(h) == PMD_SIZE) {
+		return pmd_lockptr(mm, (pmd_t *) pte);
+	} else if (huge_page_size(h) < PMD_SIZE) {
+		unsigned long mask = ~(PTRS_PER_PTE * sizeof(pte_t) - 1);
+		struct page *page =
+			virt_to_page((void *)((unsigned long)pte & mask));
+
+		/*
+		 * Considering CONT-PTE size hugetlb, since the CONT-PTE
+		 * entry can not span multiple PTEs, we can use the PTE
+		 * page lock to get a fine grained lock.
+		 */
+		return ptlock_ptr(page);
+	}
+
 	return &mm->page_table_lock;
 }
 
-- 
1.8.3.1

