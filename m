Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF124D934E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 05:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbiCOEZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 00:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbiCOEZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 00:25:47 -0400
Received: from spam.unicloud.com (smgmail.unigroup.com.cn [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71631FCDF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 21:24:33 -0700 (PDT)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 22F4OAbb021710;
        Tue, 15 Mar 2022 12:24:10 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Tue, 15
 Mar 2022 12:24:09 +0800
From:   luofei <luofei@unicloud.com>
To:     <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        luofei <luofei@unicloud.com>
Subject: [PATCH] hugetlbfs: fix description about atomic allocation of vmemmap pages when free huge page
Date:   Tue, 15 Mar 2022 00:23:55 -0400
Message-ID: <20220315042355.362810-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb10.Unicloud.com (10.10.0.6) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 22F4OAbb021710
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No matter what context update_and_free_page() is called in,
the flag for allocating the vmemmap page is fixed
(GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE), and no atomic
allocation is involved, so the description of atomicity here
is somewhat inappropriate.

and the atomic parameter naming of update_and_free_page() is
somewhat misleading.

Signed-off-by: luofei <luofei@unicloud.com>
---
 mm/hugetlb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f8ca7cca3c1a..239ef82b7897 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1570,8 +1570,8 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 
 /*
  * As update_and_free_page() can be called under any context, so we cannot
- * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
- * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
+ * use GFP_ATOMIC to allocate vmemmap pages. However, we can defer the
+ * actual freeing in a workqueue to prevent waits caused by allocating
  * the vmemmap pages.
  *
  * free_hpage_workfn() locklessly retrieves the linked list of pages to be
@@ -1617,16 +1617,14 @@ static inline void flush_free_hpage_work(struct hstate *h)
 }
 
 static void update_and_free_page(struct hstate *h, struct page *page,
-				 bool atomic)
+				 bool delay)
 {
-	if (!HPageVmemmapOptimized(page) || !atomic) {
+	if (!HPageVmemmapOptimized(page) || !delay) {
 		__update_and_free_page(h, page);
 		return;
 	}
 
 	/*
-	 * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap pages.
-	 *
 	 * Only call schedule_work() if hpage_freelist is previously
 	 * empty. Otherwise, schedule_work() had been called but the workfn
 	 * hasn't retrieved the list yet.
-- 
2.27.0

