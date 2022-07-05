Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B965356636E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiGEGw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGEGw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:52:26 -0400
X-Greylist: delayed 1199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Jul 2022 23:52:23 PDT
Received: from spam.unicloud.com (unknown [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFC162F2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:52:22 -0700 (PDT)
Received: from spam.unicloud.com (localhost [127.0.0.2] (may be forged))
        by spam.unicloud.com with ESMTP id 2656WPwS083309
        for <linux-kernel@vger.kernel.org>; Tue, 5 Jul 2022 14:32:25 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 2656W1qk083104;
        Tue, 5 Jul 2022 14:32:01 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Tue, 5
 Jul 2022 14:32:01 +0800
From:   luofei <luofei@unicloud.com>
To:     <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        luofei <luofei@unicloud.com>
Subject: [PATCH] mm,hwpoison,hugetlb: defer dissolve hwpoison hugepage when allocating vmemmap failed
Date:   Tue, 5 Jul 2022 02:29:53 -0400
Message-ID: <20220705062953.914256-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb10.Unicloud.com (10.10.0.6) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 2656WPwS083309
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dissolving hwpoison hugepage, if the allocation of vmemmap page
failed, the faulty page should not be put back on the hugepage free
list, which will cause the faulty pages to be reused. It's better to
postpone the reexecution of dissolve operation.

Meanwhile when the page fault handling program calls
dissolve_free_huge_page() to dissolve the faulty page, the basic page
fault processing operation(such as migration pages and unmap etc)
has actually completed. There is no need to return -ENOMEM error code
to the upper layer for temporarily vmemmap page allocation failure,
which will cause the caller to make a wrong judgment. So just defer
dissolve and return success.

Signed-off-by: luofei <luofei@unicloud.com>
---
 mm/hugetlb.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ca081078e814..db25458eb0a5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -90,6 +90,9 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
+static LLIST_HEAD(hpage_freelist);
+static void free_hpage_workfn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(free_hpage_work, free_hpage_workfn);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -1535,15 +1538,21 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	if (hugetlb_vmemmap_restore(h, page))
+	if (hugetlb_vmemmap_restore(h, page)) {
+		if (unlikely(PageHWPoison(page))) {
+			llist_add((struct llist_node *)&page->mapping, &hpage_freelist);
+			schedule_delayed_work(&free_hpage_work, HZ);
+			goto out;
+		}
 		goto fail;
+	}
 
 	/*
 	 * Move PageHWPoison flag from head page to the raw error pages,
 	 * which makes any healthy subpages reusable.
 	 */
 	if (unlikely(PageHWPoison(page) && hugetlb_clear_page_hwpoison(page)))
-		goto fail;
+		goto out;
 
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
@@ -1574,6 +1583,8 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 */
 	add_hugetlb_page(h, page, true);
 	spin_unlock_irq(&hugetlb_lock);
+out:
+	return;
 }
 
 /*
@@ -1587,8 +1598,6 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
  * to be cleared in free_hpage_workfn() anyway, it is reused as the llist_node
  * structure of a lockless linked list of huge pages to be freed.
  */
-static LLIST_HEAD(hpage_freelist);
-
 static void free_hpage_workfn(struct work_struct *work)
 {
 	struct llist_node *node;
@@ -1616,12 +1625,11 @@ static void free_hpage_workfn(struct work_struct *work)
 		cond_resched();
 	}
 }
-static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
 
 static inline void flush_free_hpage_work(struct hstate *h)
 {
 	if (hugetlb_vmemmap_optimizable(h))
-		flush_work(&free_hpage_work);
+		flush_delayed_work(&free_hpage_work);
 }
 
 static void update_and_free_page(struct hstate *h, struct page *page,
@@ -1634,13 +1642,9 @@ static void update_and_free_page(struct hstate *h, struct page *page,
 
 	/*
 	 * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap pages.
-	 *
-	 * Only call schedule_work() if hpage_freelist is previously
-	 * empty. Otherwise, schedule_work() had been called but the workfn
-	 * hasn't retrieved the list yet.
 	 */
-	if (llist_add((struct llist_node *)&page->mapping, &hpage_freelist))
-		schedule_work(&free_hpage_work);
+	llist_add((struct llist_node *)&page->mapping, &hpage_freelist);
+	schedule_delayed_work(&free_hpage_work, 0);
 }
 
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
@@ -2118,11 +2122,15 @@ int dissolve_free_huge_page(struct page *page)
 		rc = hugetlb_vmemmap_restore(h, head);
 		if (!rc) {
 			update_and_free_page(h, head, false);
-		} else {
+		} else if (!PageHWPoison(head)) {
 			spin_lock_irq(&hugetlb_lock);
 			add_hugetlb_page(h, head, false);
 			h->max_huge_pages++;
 			spin_unlock_irq(&hugetlb_lock);
+		} else {
+			llist_add((struct llist_node *)&head->mapping, &hpage_freelist);
+			schedule_delayed_work(&free_hpage_work, HZ);
+			rc = 0;
 		}
 
 		return rc;
-- 
2.27.0

