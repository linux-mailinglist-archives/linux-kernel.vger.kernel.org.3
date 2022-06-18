Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB415503D7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 11:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiFRJFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 05:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiFRJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 05:05:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F055F313BA
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 02:05:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LQ91R3zkmzhYWw;
        Sat, 18 Jun 2022 17:03:23 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 18 Jun
 2022 17:05:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/madvise: minor cleanup for swapin_walk_pmd_entry()
Date:   Sat, 18 Jun 2022 17:05:27 +0800
Message-ID: <20220618090527.37843-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Passing index to pte_offset_map_lock() directly so the below calculation
can be avoided. Rename orig_pte to ptep as it's not changed. Also use
helper is_swap_pte() to improve the readability. No functional change
intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/madvise.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 7a8af04069b3..cf49e123991c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -195,7 +195,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	unsigned long end, struct mm_walk *walk)
 {
-	pte_t *orig_pte;
+	pte_t *ptep;
 	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
 	struct swap_iocb *splug = NULL;
@@ -209,11 +209,11 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		struct page *page;
 		spinlock_t *ptl;
 
-		orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
-		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
-		pte_unmap_unlock(orig_pte, ptl);
+		ptep = pte_offset_map_lock(vma->vm_mm, pmd, index, &ptl);
+		pte = *ptep;
+		pte_unmap_unlock(ptep, ptl);
 
-		if (pte_present(pte) || pte_none(pte))
+		if (!is_swap_pte(pte))
 			continue;
 		entry = pte_to_swp_entry(pte);
 		if (unlikely(non_swap_entry(entry)))
-- 
2.23.0

