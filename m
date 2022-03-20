Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21D44DE716
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 09:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbiCSIjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242519AbiCSIji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 04:39:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172832BE2D3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 01:38:15 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KLDmL57mMz1GCSK;
        Sat, 19 Mar 2022 16:38:10 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 19 Mar
 2022 16:38:13 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <shy828301@gmail.com>, <mike.kravetz@oracle.com>,
        <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v4 2/2] mm/memory-failure.c: make non-LRU movable pages unhandlable
Date:   Sun, 20 Mar 2022 13:13:34 +0800
Message-ID: <20220320051334.44502-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220320051334.44502-1-linmiaohe@huawei.com>
References: <20220320051334.44502-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can not really handle non-LRU movable pages in memory failure. Typically
they are balloon, zsmalloc, etc. Assuming we run into a base (4K) non-LRU
movable page, we could reach as far as identify_page_state(), it should not
fall into any category except me_unknown. For the non-LRU compound movable
pages, they could be taken for transhuge pages but it's unexpected to split
non-LRU  movable pages using split_huge_page_to_list in memory_failure. So
we could just simply make non-LRU  movable pages unhandlable to avoid these
possible nasty cases.

Suggested-by: Yang Shi <shy828301@gmail.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ecf45961f3b6..837ceae90d64 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1176,12 +1176,16 @@ void ClearPageHWPoisonTakenOff(struct page *page)
  * does not return true for hugetlb or device memory pages, so it's assumed
  * to be called only in the context where we never have such pages.
  */
-static inline bool HWPoisonHandlable(struct page *page)
+static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
 {
-	return PageLRU(page) || __PageMovable(page) || is_free_buddy_page(page);
+	/* Soft offline could migrate non-LRU movable pages. */
+	if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
+		return true;
+
+	return PageLRU(page) || is_free_buddy_page(page);
 }
 
-static int __get_hwpoison_page(struct page *page)
+static int __get_hwpoison_page(struct page *page, unsigned long flags)
 {
 	struct page *head = compound_head(page);
 	int ret = 0;
@@ -1196,7 +1200,7 @@ static int __get_hwpoison_page(struct page *page)
 	 * for any unsupported type of page in order to reduce the risk of
 	 * unexpected races caused by taking a page refcount.
 	 */
-	if (!HWPoisonHandlable(head))
+	if (!HWPoisonHandlable(head, flags))
 		return -EBUSY;
 
 	if (get_page_unless_zero(head)) {
@@ -1221,7 +1225,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 
 try_again:
 	if (!count_increased) {
-		ret = __get_hwpoison_page(p);
+		ret = __get_hwpoison_page(p, flags);
 		if (!ret) {
 			if (page_count(p)) {
 				/* We raced with an allocation, retry. */
@@ -1249,7 +1253,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 		}
 	}
 
-	if (PageHuge(p) || HWPoisonHandlable(p)) {
+	if (PageHuge(p) || HWPoisonHandlable(p, flags)) {
 		ret = 1;
 	} else {
 		/*
@@ -2296,7 +2300,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 retry:
 	get_online_mems();
-	ret = get_hwpoison_page(page, flags);
+	ret = get_hwpoison_page(page, flags | MF_SOFT_OFFLINE);
 	put_online_mems();
 
 	if (ret > 0) {
-- 
2.23.0

