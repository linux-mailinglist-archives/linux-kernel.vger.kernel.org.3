Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC3051428D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354721AbiD2GoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354669AbiD2Gnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:43:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0252BABBD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:40:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KqNBf5Dt7z1JBqc;
        Fri, 29 Apr 2022 14:39:38 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 14:40:34 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 8/9] mm/z3fold: fix z3fold_reclaim_page races with z3fold_free
Date:   Fri, 29 Apr 2022 14:40:50 +0800
Message-ID: <20220429064051.61552-9-linmiaohe@huawei.com>
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

Think about the below scene:

CPU1				CPU2
z3fold_reclaim_page		z3fold_free
 spin_lock(&pool->lock)		 get_z3fold_header -- hold page_lock
 kref_get_unless_zero
				 kref_put--zhdr->refcount can be 1 now
 !z3fold_page_trylock
  kref_put -- zhdr->refcount is 0 now
   release_z3fold_page
    WARN_ON(!list_empty(&zhdr->buddy)); -- we're on buddy now!
    spin_lock(&pool->lock); -- deadlock here!

z3fold_reclaim_page might race with z3fold_free and will lead to pool lock
deadlock and zhdr buddy non-empty warning. To fix this, defer getting the
refcount until page_lock is held just like what __z3fold_alloc does. Note
this has the side effect that we won't break the reclaim if we meet a soon
to be released z3fold page now.

Fixes: dcf5aedb24f8 ("z3fold: stricter locking and more careful reclaim")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 4a3cd2ff15b0..a7769befd74e 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -519,13 +519,6 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 	atomic64_dec(&pool->pages_nr);
 }
 
-static void release_z3fold_page(struct kref *ref)
-{
-	struct z3fold_header *zhdr = container_of(ref, struct z3fold_header,
-						refcount);
-	__release_z3fold_page(zhdr, false);
-}
-
 static void release_z3fold_page_locked(struct kref *ref)
 {
 	struct z3fold_header *zhdr = container_of(ref, struct z3fold_header,
@@ -1317,12 +1310,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 				break;
 			}
 
-			if (kref_get_unless_zero(&zhdr->refcount) == 0) {
-				zhdr = NULL;
-				break;
-			}
 			if (!z3fold_page_trylock(zhdr)) {
-				kref_put(&zhdr->refcount, release_z3fold_page);
 				zhdr = NULL;
 				continue; /* can't evict at this point */
 			}
@@ -1333,14 +1321,14 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			 */
 			if (zhdr->foreign_handles ||
 			    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
-				if (!kref_put(&zhdr->refcount,
-						release_z3fold_page_locked))
-					z3fold_page_unlock(zhdr);
+				z3fold_page_unlock(zhdr);
 				zhdr = NULL;
 				continue; /* can't evict such page */
 			}
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
+			/* See comment in __z3fold_alloc. */
+			kref_get(&zhdr->refcount);
 			break;
 		}
 
-- 
2.23.0

