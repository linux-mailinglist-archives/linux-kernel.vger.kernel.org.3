Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B9958D7DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiHILMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbiHILMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:12:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B79D2125B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 04:12:07 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M29LG25FNz1M8bx;
        Tue,  9 Aug 2022 19:08:54 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 19:12:04 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 19:12:04 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] mm: memory-failure: cleanup try_to_split_thp_page()
Date:   Tue, 9 Aug 2022 19:18:13 +0800
Message-ID: <20220809111813.139690-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Since commit 5d1fd5dc877b ("mm,hwpoison: introduce MF_MSG_UNSPLIT_THP"),
the action_result(,MF_MSG_UNSPLIT_THP,) called to show memory error event
in memory_failure(), so the pr_info() in try_to_split_thp_page() is only
needed in soft_offline_in_use_page().

Meanwhile this could also fix the unexpected prefix for "thp split failed"
due to commit 96f96763de26 ("mm: memory-failure: convert to pr_fmt()").

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2: update changelog

 mm/memory-failure.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 14439806b5ef..0dfed9d7b273 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1524,20 +1524,18 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 	return page_action(ps, p, pfn);
 }
 
-static int try_to_split_thp_page(struct page *page, const char *msg)
+static int try_to_split_thp_page(struct page *page)
 {
+	int ret;
+
 	lock_page(page);
-	if (unlikely(split_huge_page(page))) {
-		unsigned long pfn = page_to_pfn(page);
+	ret = split_huge_page(page);
+	unlock_page(page);
 
-		unlock_page(page);
-		pr_info("%s: %#lx: thp split failed\n", msg, pfn);
+	if (unlikely(ret))
 		put_page(page);
-		return -EBUSY;
-	}
-	unlock_page(page);
 
-	return 0;
+	return ret;
 }
 
 static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
@@ -2079,7 +2077,7 @@ int memory_failure(unsigned long pfn, int flags)
 		 * page is a valid handlable page.
 		 */
 		SetPageHasHWPoisoned(hpage);
-		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
+		if (try_to_split_thp_page(p) < 0) {
 			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
 			res = -EBUSY;
 			goto unlock_mutex;
@@ -2505,8 +2503,11 @@ static int soft_offline_in_use_page(struct page *page)
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage))
-		if (try_to_split_thp_page(page, "soft offline") < 0)
+		if (try_to_split_thp_page(page) < 0) {
+			pr_info("soft offline: %#lx: thp split failed\n",
+				page_to_pfn(page));
 			return -EBUSY;
+		}
 	return __soft_offline_page(page);
 }
 
-- 
2.35.3

