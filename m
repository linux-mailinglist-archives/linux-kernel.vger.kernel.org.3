Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEB45472FD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiFKIri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiFKIrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:47:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416861ADB1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 01:47:30 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKrz7716NzjWw6;
        Sat, 11 Jun 2022 16:46:27 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 11 Jun
 2022 16:47:28 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <aarcange@redhat.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <dhowells@redhat.com>, <neilb@suse.de>, <apopple@nvidia.com>,
        <david@redhat.com>, <surenb@google.com>, <peterx@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/7] mm/khugepaged: stop swapping in page when VM_FAULT_RETRY occurs
Date:   Sat, 11 Jun 2022 16:47:26 +0800
Message-ID: <20220611084731.55155-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220611084731.55155-1-linmiaohe@huawei.com>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

When do_swap_page returns VM_FAULT_RETRY, we do not retry here and thus
swap entry will remain in pagetable. This will result in later failure.
So stop swapping in pages in this case to save cpu cycles.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/khugepaged.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 73570dfffcec..a8adb2d1e9c6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1003,19 +1003,16 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 		swapped_in++;
 		ret = do_swap_page(&vmf);
 
-		/* do_swap_page returns VM_FAULT_RETRY with released mmap_lock */
+		/*
+		 * do_swap_page returns VM_FAULT_RETRY with released mmap_lock.
+		 * Note we treat VM_FAULT_RETRY as VM_FAULT_ERROR here because
+		 * we do not retry here and swap entry will remain in pagetable
+		 * resulting in later failure.
+		 */
 		if (ret & VM_FAULT_RETRY) {
 			mmap_read_lock(mm);
-			if (hugepage_vma_revalidate(mm, haddr, &vma)) {
-				/* vma is no longer available, don't continue to swapin */
-				trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
-				return false;
-			}
-			/* check if the pmd is still valid */
-			if (mm_find_pmd(mm, haddr) != pmd) {
-				trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
-				return false;
-			}
+			trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
+			return false;
 		}
 		if (ret & VM_FAULT_ERROR) {
 			trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
-- 
2.23.0

