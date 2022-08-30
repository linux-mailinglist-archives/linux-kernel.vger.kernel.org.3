Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C7A5A60F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiH3KmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiH3Kl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:41:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCF49D67C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:41:57 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MH3gD6QBkzkWng;
        Tue, 30 Aug 2022 18:38:16 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 18:41:55 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 18:41:54 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: [PATCH v2] mm: memory-failure: kill __soft_offline_page()
Date:   Tue, 30 Aug 2022 18:46:54 +0800
Message-ID: <20220830104654.28234-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
Reply-To: <20220830071514.GA1106752@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Squash the __soft_offline_page() into soft_offline_in_use_page() and kill
__soft_offline_page().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
v2: update hpage when try_to_split_thp_page() success

 mm/memory-failure.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b61f2de9f2a1..df54a6bc9bef 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2434,11 +2434,11 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 }
 
 /*
- * __soft_offline_page handles hugetlb-pages and non-hugetlb pages.
+ * soft_offline_in_use_page handles hugetlb-pages and non-hugetlb pages.
  * If the page is a non-dirty unmapped page-cache page, it simply invalidates.
  * If the page is mapped, it migrates the contents over.
  */
-static int __soft_offline_page(struct page *page)
+static int soft_offline_in_use_page(struct page *page)
 {
 	long ret = 0;
 	unsigned long pfn = page_to_pfn(page);
@@ -2451,6 +2451,14 @@ static int __soft_offline_page(struct page *page)
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 	};
 
+	if (!huge && PageTransHuge(hpage)) {
+		if (try_to_split_thp_page(page)) {
+			pr_info("soft offline: %#lx: thp split failed\n", pfn);
+			return -EBUSY;
+		}
+		hpage = page;
+	}
+
 	lock_page(page);
 	if (!PageHuge(page))
 		wait_on_page_writeback(page);
@@ -2500,19 +2508,6 @@ static int __soft_offline_page(struct page *page)
 	return ret;
 }
 
-static int soft_offline_in_use_page(struct page *page)
-{
-	struct page *hpage = compound_head(page);
-
-	if (!PageHuge(page) && PageTransHuge(hpage))
-		if (try_to_split_thp_page(page) < 0) {
-			pr_info("soft offline: %#lx: thp split failed\n",
-				page_to_pfn(page));
-			return -EBUSY;
-		}
-	return __soft_offline_page(page);
-}
-
 static void put_ref_page(struct page *page)
 {
 	if (page)
-- 
2.35.3

