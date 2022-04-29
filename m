Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987C4514291
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354732AbiD2GoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354665AbiD2Gnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:43:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D81B9F31
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:40:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KqN8f4HK2zGpPK;
        Fri, 29 Apr 2022 14:37:54 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 14:40:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/9] mm/z3fold: remove buggy use of stale list for allocation
Date:   Fri, 29 Apr 2022 14:40:45 +0800
Message-ID: <20220429064051.61552-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220429064051.61552-1-linmiaohe@huawei.com>
References: <20220429064051.61552-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if z3fold couldn't find an unbuddied page it would first try to
pull a page off the stale list. But this approach is problematic. If init
z3fold page fails later, the page should be freed via free_z3fold_page to
clean up the relevant resource instead of using __free_page directly. And
if page is successfully reused, it will BUG_ON later in __SetPageMovable
because it's already non-lru movable page, i.e. PAGE_MAPPING_MOVABLE is
already set in page->mapping. In order to fix all of these issues, we can
simply remove the buggy use of stale list for allocation because can_sleep
should always be false and we never really hit the reusing code path now.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 5d8c21f2bc59..4e6814c5694f 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1102,28 +1102,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 		bud = FIRST;
 	}
 
-	page = NULL;
-	if (can_sleep) {
-		spin_lock(&pool->stale_lock);
-		zhdr = list_first_entry_or_null(&pool->stale,
-						struct z3fold_header, buddy);
-		/*
-		 * Before allocating a page, let's see if we can take one from
-		 * the stale pages list. cancel_work_sync() can sleep so we
-		 * limit this case to the contexts where we can sleep
-		 */
-		if (zhdr) {
-			list_del(&zhdr->buddy);
-			spin_unlock(&pool->stale_lock);
-			cancel_work_sync(&zhdr->work);
-			page = virt_to_page(zhdr);
-		} else {
-			spin_unlock(&pool->stale_lock);
-		}
-	}
-	if (!page)
-		page = alloc_page(gfp);
-
+	page = alloc_page(gfp);
 	if (!page)
 		return -ENOMEM;
 
-- 
2.23.0

