Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CCB514293
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350978AbiD2GoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354656AbiD2Gnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:43:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28783B9F1B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:40:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KqNCR148kzhYrG;
        Fri, 29 Apr 2022 14:40:19 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 14:40:34 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 7/9] mm/z3fold: always clear PAGE_CLAIMED under z3fold page lock
Date:   Fri, 29 Apr 2022 14:40:49 +0800
Message-ID: <20220429064051.61552-8-linmiaohe@huawei.com>
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

Think about the below race window:

CPU1				CPU2
z3fold_reclaim_page		z3fold_free
 test_and_set_bit PAGE_CLAIMED
 failed to reclaim page
 z3fold_page_lock(zhdr);
 add back to the lru list;
 z3fold_page_unlock(zhdr);
				 get_z3fold_header
				 page_claimed=test_and_set_bit PAGE_CLAIMED

 clear_bit(PAGE_CLAIMED, &page->private);

				 if (!page_claimed) /* it's false true */
				  free_handle is not called

free_handle won't be called in this case. So z3fold_buddy_slots will leak.
Fix it by always clear PAGE_CLAIMED under z3fold page lock.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index a1c150fc8def..4a3cd2ff15b0 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1221,8 +1221,8 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		return;
 	}
 	if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
-		put_z3fold_header(zhdr);
 		clear_bit(PAGE_CLAIMED, &page->private);
+		put_z3fold_header(zhdr);
 		return;
 	}
 	if (zhdr->cpu < 0 || !cpu_online(zhdr->cpu)) {
@@ -1424,8 +1424,8 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			spin_unlock(&pool->lock);
 			if (list_empty(&zhdr->buddy))
 				add_to_unbuddied(pool, zhdr);
-			z3fold_page_unlock(zhdr);
 			clear_bit(PAGE_CLAIMED, &page->private);
+			z3fold_page_unlock(zhdr);
 		}
 
 		/* We started off locked to we need to lock the pool back */
@@ -1577,8 +1577,8 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 	if (!z3fold_page_trylock(zhdr))
 		return -EAGAIN;
 	if (zhdr->mapped_count != 0 || zhdr->foreign_handles != 0) {
-		z3fold_page_unlock(zhdr);
 		clear_bit(PAGE_CLAIMED, &page->private);
+		z3fold_page_unlock(zhdr);
 		return -EBUSY;
 	}
 	if (work_pending(&zhdr->work)) {
-- 
2.23.0

