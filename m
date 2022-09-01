Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0D05A962C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiIAMBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiIAMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:01:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783AF74CF3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:01:06 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJKKt3TQ9zlWdm;
        Thu,  1 Sep 2022 19:57:38 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 20:01:04 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 07/10] hugetlb: kill hugetlbfs_pagecache_page()
Date:   Thu, 1 Sep 2022 20:00:27 +0800
Message-ID: <20220901120030.63318-8-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220901120030.63318-1-linmiaohe@huawei.com>
References: <20220901120030.63318-1-linmiaohe@huawei.com>
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

Fold hugetlbfs_pagecache_page() into its sole caller to remove some
duplicated code. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bb65b7fdca25..26bcc85715eb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5467,19 +5467,6 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ret;
 }
 
-/* Return the pagecache page at a given address within a VMA */
-static struct page *hugetlbfs_pagecache_page(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long address)
-{
-	struct address_space *mapping;
-	pgoff_t idx;
-
-	mapping = vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, vma, address);
-
-	return find_lock_page(mapping, idx);
-}
-
 /*
  * Return whether there is a pagecache page to back given address within VMA.
  * Caller follow_hugetlb_page() holds page_table_lock so we cannot lock_page.
@@ -5885,7 +5872,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_page = hugetlbfs_pagecache_page(h, vma, haddr);
+		pagecache_page = find_lock_page(mapping, idx);
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
-- 
2.23.0

