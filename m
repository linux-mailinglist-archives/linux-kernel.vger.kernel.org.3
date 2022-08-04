Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1019589B18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbiHDLeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiHDLeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:34:08 -0400
Received: from spam.unicloud.com (mx.unispc.com [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFA833E22
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:34:05 -0700 (PDT)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 274BXL8d005672;
        Thu, 4 Aug 2022 19:33:21 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Thu, 4
 Aug 2022 19:33:20 +0800
From:   luofei <luofei@unicloud.com>
To:     <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>
CC:     <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, luofei <luofei@unicloud.com>
Subject: [PATCH] mm, hwpoison, hugetlb: Check hugetlb head page hwpoison flag when unpoison page
Date:   Thu, 4 Aug 2022 07:33:08 -0400
Message-ID: <20220804113308.2901178-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb08.Unicloud.com (10.10.0.14) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 274BXL8d005672
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When software-poison a huge page, if dissolve_free_huge_page() failed,
the huge page will be added to hugepage_freelists. In this case, the
head page will hold the hwpoison flag, but the real poisoned tail page
hwpoison flag is not set, this will cause unpoison_memory() fail to
unpoison the previously poisoned page.

So add a check on hugetlb head page, and also need to ensure the
previously poisoned tail page in huge page raw_hwp_list.

Signed-off-by: luofei <luofei@unicloud.com>
---
 mm/memory-failure.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 14439806b5ef..fc571b0ceb9d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2293,6 +2293,28 @@ core_initcall(memory_failure_init);
 		pr_info(fmt, pfn);			\
 })
 
+static bool hugetlb_page_head_poison(struct page *hpage, struct page *page)
+{
+	struct llist_head *head;
+	struct llist_node *t, *tnode;
+	struct raw_hwp_page *p;
+
+	if (PageHuge(page) && PageHWPoison(hpage) && HPageFreed(hpage))
+		return false;
+
+	if (HPageRawHwpUnreliable(hpage))
+		return false;
+
+	head = raw_hwp_list_head(hpage);
+	llist_for_each_safe(tnode, t, head->first) {
+		p = container_of(tnode, struct raw_hwp_page, node);
+		if (p->page == page)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * unpoison_memory - Unpoison a previously poisoned page
  * @pfn: Page number of the to be unpoisoned page
@@ -2330,7 +2352,7 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (!PageHWPoison(p)) {
+	if (!PageHWPoison(p) && !hugetlb_page_head_poison(page, p)) {
 		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
 				 pfn, &unpoison_rs);
 		goto unlock_mutex;
-- 
2.27.0

