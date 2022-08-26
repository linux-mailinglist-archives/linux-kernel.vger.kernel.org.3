Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2425A2439
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbiHZJZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343652AbiHZJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:24:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891DC402DF
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:24:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MDZBQ5x3XzGprt;
        Fri, 26 Aug 2022 17:23:10 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 17:24:52 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 03/10] hugetlb: Use LIST_HEAD() to define a list head
Date:   Fri, 26 Aug 2022 17:24:15 +0800
Message-ID: <20220826092422.39591-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220826092422.39591-1-linmiaohe@huawei.com>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
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

We can avoid unneeded WRITE_ONCE() overhead by using LIST_HEAD() to define
a list head.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 24f580ddf130..b3e6592247a3 100644
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

