Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3497F587569
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiHBCIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiHBCIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:08:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0B341D10
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:08:02 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lxdd93KQqzmVnK;
        Tue,  2 Aug 2022 10:06:05 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 10:08:00 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 10:08:00 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: memory-failure: cleanup try_to_split_thp_page()
Date:   Tue, 2 Aug 2022 10:12:56 +0800
Message-ID: <20220802021256.162269-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <e699cd23-3eeb-7920-accd-b30622efa551@huawei.com>
References: <e699cd23-3eeb-7920-accd-b30622efa551@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 5d1fd5dc877b ("mm,hwpoison: introduce MF_MSG_UNSPLIT_THP"),
the action_result() called to show memory error event in memory_failure(),
so the pr_info() in try_to_split_thp_page() is only needed in
soft_offline_in_use_page().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory-failure.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f0e1961d4482..59633a617a0a 100644
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
@@ -2503,8 +2501,11 @@ static int soft_offline_in_use_page(struct page *page)
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

