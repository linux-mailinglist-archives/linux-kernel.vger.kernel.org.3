Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29C59D2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbiHWHuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbiHWHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:50:23 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A824C6556A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:50:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VN0jApx_1661241015;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VN0jApx_1661241015)
          by smtp.aliyun-inc.com;
          Tue, 23 Aug 2022 15:50:16 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] mm/hugetlb: use PMD page lock to protect CONT-PTE entries
Date:   Tue, 23 Aug 2022 15:50:04 +0800
Message-Id: <88c8a8c68d87429f0fc48e81100f19b71f6e664f.1661240170.git.baolin.wang@linux.alibaba.com>
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

Considering the pmd entries of a CONT-PMD hugetlb can not span on
multiple PMDs, we can change to use the PMD page lock, which can
be much finer grain that lock in the mm.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/hugetlb.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3a96f67..d4803a89 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -892,9 +892,17 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
-	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
+	unsigned long hp_size = huge_page_size(h);
 
-	if (huge_page_size(h) == PMD_SIZE) {
+	VM_BUG_ON(hp_size == PAGE_SIZE);
+
+	/*
+	 * Considering CONT-PMD size hugetlb, since the CONT-PMD entry
+	 * can not span multiple PMDs, then we can use the fine grained
+	 * PMD page lock.
+	 */
+	if (hp_size == PMD_SIZE ||
+	    (hp_size > PMD_SIZE && hp_size < PUD_SIZE)) {
 		return pmd_lockptr(mm, (pmd_t *) pte);
 	} else if (huge_page_size(h) < PMD_SIZE) {
 		unsigned long mask = ~(PTRS_PER_PTE * sizeof(pte_t) - 1);
-- 
1.8.3.1

