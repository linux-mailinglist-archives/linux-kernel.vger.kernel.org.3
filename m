Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C37E587A52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbiHBKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiHBKIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:08:01 -0400
Received: from spam.unicloud.com (smgmail.unigroup.com.cn [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79972DA8C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:07:58 -0700 (PDT)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 272A7VV3097087;
        Tue, 2 Aug 2022 18:07:31 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Tue, 2
 Aug 2022 18:07:30 +0800
From:   luofei <luofei@unicloud.com>
To:     <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        luofei <luofei@unicloud.com>
Subject: [PATCH] mm, hwpoison, hugetlb: Free hwpoison huge page to list tail and dissolve hwpoison huge page first
Date:   Tue, 2 Aug 2022 06:07:11 -0400
Message-ID: <20220802100711.2425644-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb09.Unicloud.com (10.10.0.24) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 272A7VV3097087
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If free hwpoison huge page to the end of hugepage_freelists, the
loop can exit directly when the hwpoison huge page is traversed,
which can effectively reduce the repeated traversal of the hwpoison
huge page. Meanwhile, when free the free huge pages to lower level
allocators, if hwpoison ones are released first, this can improve
the effecvive utilization rate of huge page.

Signed-off-by: luofei <luofei@unicloud.com>
---
 mm/hugetlb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 28516881a1b2..ca72220eedd9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1116,7 +1116,10 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 	lockdep_assert_held(&hugetlb_lock);
 	VM_BUG_ON_PAGE(page_count(page), page);
 
-	list_move(&page->lru, &h->hugepage_freelists[nid]);
+	if (unlikely(PageHWPoison(page)))
+		list_move_tail(&page->lru, &h->hugepage_freelists[nid]);
+	else
+		list_move(&page->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
 	SetHPageFreed(page);
@@ -1133,7 +1136,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 			continue;
 
 		if (PageHWPoison(page))
-			continue;
+			break;
 
 		list_move(&page->lru, &h->hugepage_activelist);
 		set_page_refcounted(page);
@@ -2045,7 +2048,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 		 */
 		if ((!acct_surplus || h->surplus_huge_pages_node[node]) &&
 		    !list_empty(&h->hugepage_freelists[node])) {
-			page = list_entry(h->hugepage_freelists[node].next,
+			page = list_entry(h->hugepage_freelists[node].prev,
 					  struct page, lru);
 			remove_hugetlb_page(h, page, acct_surplus);
 			break;
@@ -3210,7 +3213,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	for_each_node_mask(i, *nodes_allowed) {
 		struct page *page, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
-		list_for_each_entry_safe(page, next, freel, lru) {
+		list_for_each_entry_safe_reverse(page, next, freel, lru) {
 			if (count >= h->nr_huge_pages)
 				goto out;
 			if (PageHighMem(page))
@@ -3494,7 +3497,7 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
 		list_for_each_entry(page, &h->hugepage_freelists[node], lru) {
 			if (PageHWPoison(page))
-				continue;
+				break;
 
 			return demote_free_huge_page(h, page);
 		}
-- 
2.27.0

