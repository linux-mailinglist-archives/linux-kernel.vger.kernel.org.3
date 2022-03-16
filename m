Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86994DA8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353388AbiCPDRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiCPDRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:17:49 -0400
Received: from spam.unicloud.com (mx.unispc.com [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED55E15C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 20:16:35 -0700 (PDT)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 22G3GIB8054293;
        Wed, 16 Mar 2022 11:16:19 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Wed, 16
 Mar 2022 11:16:18 +0800
From:   luofei <luofei@unicloud.com>
To:     <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        luofei <luofei@unicloud.com>
Subject: [PATCH v2] hugetlb: Fix comments about avoiding atomic allocation of vmemmap pages
Date:   Tue, 15 Mar 2022 23:16:02 -0400
Message-ID: <20220316031602.377452-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb11.Unicloud.com (10.10.0.28) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 22G3GIB8054293
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is no longer an atomic allocation of vmemmap pages,
but a fixed flag(GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE) is
used. The description of atomicity here is some what inappropriate.

And the atomic parameter naming of update_and_free_page() may
be misleading, add a comment here.

Signed-off-by: luofei <luofei@unicloud.com>
---
 mm/hugetlb.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f8ca7cca3c1a..fbf598bbc4e3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1569,10 +1569,12 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 }
 
 /*
- * As update_and_free_page() can be called under any context, so we cannot
- * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
- * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
- * the vmemmap pages.
+ * Freeing hugetlb pages in done in update_and_free_page(). When freeing
+ * a hugetlb page, vmemmap pages may need to be allocated. The routine
+ * alloc_huge_page_vmemmap() can possibly sleep as it uses GFP_KERNEL.
+ * However, update_and_free_page() can be called under any context. To
+ * avoid the possibility of sleeping in a context where sleeping is not
+ * allowed, defer the actual freeing in a workqueue where sleeping is allowed.
  *
  * free_hpage_workfn() locklessly retrieves the linked list of pages to be
  * freed and frees them one-by-one. As the page->mapping pointer is going
@@ -1616,6 +1618,10 @@ static inline void flush_free_hpage_work(struct hstate *h)
 		flush_work(&free_hpage_work);
 }
 
+/*
+ * atomic == true indicates called from a context where sleeping is
+ * not allowed.
+ */
 static void update_and_free_page(struct hstate *h, struct page *page,
 				 bool atomic)
 {
@@ -1625,7 +1631,8 @@ static void update_and_free_page(struct hstate *h, struct page *page,
 	}
 
 	/*
-	 * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap pages.
+	 * Defer freeing to avoid possible sleeping when allocating
+	 * vmemmap pages.
 	 *
 	 * Only call schedule_work() if hpage_freelist is previously
 	 * empty. Otherwise, schedule_work() had been called but the workfn
-- 
2.27.0

