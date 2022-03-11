Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA04D5C29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346800AbiCKHV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiCKHV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:21:57 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7659A1B30A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:20:55 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KFHLZ1bbmz9sYw;
        Fri, 11 Mar 2022 15:17:10 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 15:20:53 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] mm: remove unneeded local variable follflags
Date:   Fri, 11 Mar 2022 15:20:02 +0800
Message-ID: <20220311072002.35575-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

We can pass FOLL_GET | FOLL_DUMP to follow_page directly to simplify
the code a bit in add_page_for_migration and split_huge_pages_pid.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
v1->v2:
  do similar instance in add_page_for_migration per Anshuman
  collect Reviewed-by tag. Thanks Anshuman for review.
---
 mm/huge_memory.c | 4 +---
 mm/migrate.c     | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f92791d3cb79..2fe38212e07c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2840,7 +2840,6 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 	 */
 	for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
 		struct vm_area_struct *vma = find_vma(mm, addr);
-		unsigned int follflags;
 		struct page *page;
 
 		if (!vma || addr < vma->vm_start)
@@ -2853,8 +2852,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		}
 
 		/* FOLL_DUMP to ignore special (like zero) pages */
-		follflags = FOLL_GET | FOLL_DUMP;
-		page = follow_page(vma, addr, follflags);
+		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
 
 		if (IS_ERR(page))
 			continue;
diff --git a/mm/migrate.c b/mm/migrate.c
index 47d23d526e64..c1b58832d0f6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1604,7 +1604,6 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 {
 	struct vm_area_struct *vma;
 	struct page *page;
-	unsigned int follflags;
 	int err;
 
 	mmap_read_lock(mm);
@@ -1614,8 +1613,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 		goto out;
 
 	/* FOLL_DUMP to ignore special (like zero) pages */
-	follflags = FOLL_GET | FOLL_DUMP;
-	page = follow_page(vma, addr, follflags);
+	page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
 
 	err = PTR_ERR(page);
 	if (IS_ERR(page))
-- 
2.23.0

