Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B545551EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377063AbiFVRGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376911AbiFVRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:06:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCF63ED3D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:06:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LSqW52NY4zkWLh;
        Thu, 23 Jun 2022 01:04:49 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 01:06:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 07/16] mm/huge_memory: minor cleanup for split_huge_pages_pid
Date:   Thu, 23 Jun 2022 01:06:18 +0800
Message-ID: <20220622170627.19786-8-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220622170627.19786-1-linmiaohe@huawei.com>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
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

Use helper function vma_lookup to lookup the needed vma and use help macro
IS_ERR_OR_NULL to check the validity of page to simplify the code. Minor
readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fb5c484dfa39..7cfa003b1789 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2942,10 +2942,10 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 	 * table filled with PTE-mapped THPs, each of which is distinct.
 	 */
 	for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
-		struct vm_area_struct *vma = find_vma(mm, addr);
+		struct vm_area_struct *vma = vma_lookup(mm, addr);
 		struct page *page;
 
-		if (!vma || addr < vma->vm_start)
+		if (!vma)
 			break;
 
 		/* skip special VMA and hugetlb VMA */
@@ -2957,9 +2957,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		/* FOLL_DUMP to ignore special (like zero) pages */
 		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP | FOLL_LRU);
 
-		if (IS_ERR(page))
-			continue;
-		if (!page)
+		if (IS_ERR_OR_NULL(page))
 			continue;
 
 		if (!is_transparent_hugepage(page))
-- 
2.23.0

