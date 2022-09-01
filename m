Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1135A962B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiIAMBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiIAMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:01:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5766A79
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:01:04 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJKLz17V4znTZ8;
        Thu,  1 Sep 2022 19:58:35 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 20:01:02 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 03/10] hugetlb: Use LIST_HEAD() to define a list head
Date:   Thu, 1 Sep 2022 20:00:23 +0800
Message-ID: <20220901120030.63318-4-linmiaohe@huawei.com>
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

Use LIST_HEAD() directly to define a list head to simplify the code.
No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0d63a7fda1d9..94cb81e9b4df 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -459,14 +459,12 @@ static int allocate_file_region_entries(struct resv_map *resv,
 					int regions_needed)
 	__must_hold(&resv->lock)
 {
-	struct list_head allocated_regions;
+	LIST_HEAD(allocated_regions);
 	int to_allocate = 0, i = 0;
 	struct file_region *trg = NULL, *rg = NULL;
 
 	VM_BUG_ON(regions_needed < 0);
 
-	INIT_LIST_HEAD(&allocated_regions);
-
 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
 	 * the number of in progress add operations plus regions_needed.
@@ -2352,7 +2350,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 static int gather_surplus_pages(struct hstate *h, long delta)
 	__must_hold(&hugetlb_lock)
 {
-	struct list_head surplus_list;
+	LIST_HEAD(surplus_list);
 	struct page *page, *tmp;
 	int ret;
 	long i;
@@ -2367,7 +2365,6 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	}
 
 	allocated = 0;
-	INIT_LIST_HEAD(&surplus_list);
 
 	ret = -ENOMEM;
 retry:
-- 
2.23.0

