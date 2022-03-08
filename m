Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D426F4D197F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347248AbiCHNpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347211AbiCHNpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:45:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE1C49C9D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:44:07 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KCc2B74vtzBrcn;
        Tue,  8 Mar 2022 21:42:10 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Mar
 2022 21:44:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 6/8] mm/z3fold: move decrement of pool->pages_nr into __release_z3fold_page()
Date:   Tue, 8 Mar 2022 21:43:09 +0800
Message-ID: <20220308134311.59086-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220308134311.59086-1-linmiaohe@huawei.com>
References: <20220308134311.59086-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The z3fold will always do atomic64_dec(&pool->pages_nr) when the
__release_z3fold_page() is called. Thus we can move decrement of
pool->pages_nr into __release_z3fold_page() to simplify the code.
Also we can reduce the size of z3fold.o ~1k.
Without this patch:
   text	   data	    bss	    dec	    hex	filename
  15444	   1376	      8	  16828	   41bc	mm/z3fold.o
With this patch:
   text	   data	    bss	    dec	    hex	filename
  15044	   1248	      8	  16300	   3fac	mm/z3fold.o

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index adc0b3fa4906..18a697f6fe32 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -520,6 +520,8 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 	list_add(&zhdr->buddy, &pool->stale);
 	queue_work(pool->release_wq, &pool->work);
 	spin_unlock(&pool->stale_lock);
+
+	atomic64_dec(&pool->pages_nr);
 }
 
 static void release_z3fold_page(struct kref *ref)
@@ -737,13 +739,9 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 	return new_zhdr;
 
 out_fail:
-	if (new_zhdr) {
-		if (kref_put(&new_zhdr->refcount, release_z3fold_page_locked))
-			atomic64_dec(&pool->pages_nr);
-		else {
-			add_to_unbuddied(pool, new_zhdr);
-			z3fold_page_unlock(new_zhdr);
-		}
+	if (new_zhdr && !kref_put(&new_zhdr->refcount, release_z3fold_page_locked)) {
+		add_to_unbuddied(pool, new_zhdr);
+		z3fold_page_unlock(new_zhdr);
 	}
 	return NULL;
 
@@ -816,10 +814,8 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 	list_del_init(&zhdr->buddy);
 	spin_unlock(&pool->lock);
 
-	if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
-		atomic64_dec(&pool->pages_nr);
+	if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
 		return;
-	}
 
 	if (test_bit(PAGE_STALE, &page->private) ||
 	    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
@@ -829,9 +825,7 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 
 	if (!zhdr->foreign_handles && buddy_single(zhdr) &&
 	    zhdr->mapped_count == 0 && compact_single_buddy(zhdr)) {
-		if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
-			atomic64_dec(&pool->pages_nr);
-		else {
+		if (!kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
 			clear_bit(PAGE_CLAIMED, &page->private);
 			z3fold_page_unlock(zhdr);
 		}
@@ -1089,10 +1083,8 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 		if (zhdr) {
 			bud = get_free_buddy(zhdr, chunks);
 			if (bud == HEADLESS) {
-				if (kref_put(&zhdr->refcount,
+				if (!kref_put(&zhdr->refcount,
 					     release_z3fold_page_locked))
-					atomic64_dec(&pool->pages_nr);
-				else
 					z3fold_page_unlock(zhdr);
 				pr_err("No free chunks in unbuddied\n");
 				WARN_ON(1);
@@ -1239,10 +1231,8 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 
 	if (!page_claimed)
 		free_handle(handle, zhdr);
-	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list)) {
-		atomic64_dec(&pool->pages_nr);
+	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list))
 		return;
-	}
 	if (page_claimed) {
 		/* the page has not been claimed by us */
 		put_z3fold_header(zhdr);
@@ -1353,9 +1343,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 				break;
 			}
 			if (!z3fold_page_trylock(zhdr)) {
-				if (kref_put(&zhdr->refcount,
-						release_z3fold_page))
-					atomic64_dec(&pool->pages_nr);
+				kref_put(&zhdr->refcount, release_z3fold_page);
 				zhdr = NULL;
 				continue; /* can't evict at this point */
 			}
@@ -1366,10 +1354,8 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			 */
 			if (zhdr->foreign_handles ||
 			    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
-				if (kref_put(&zhdr->refcount,
+				if (!kref_put(&zhdr->refcount,
 						release_z3fold_page_locked))
-					atomic64_dec(&pool->pages_nr);
-				else
 					z3fold_page_unlock(zhdr);
 				zhdr = NULL;
 				continue; /* can't evict such page */
@@ -1447,7 +1433,6 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			if (kref_put(&zhdr->refcount,
 					release_z3fold_page_locked)) {
 				kmem_cache_free(pool->c_handle, slots);
-				atomic64_dec(&pool->pages_nr);
 				return 0;
 			}
 			/*
@@ -1669,10 +1654,8 @@ static void z3fold_page_putback(struct page *page)
 	if (!list_empty(&zhdr->buddy))
 		list_del_init(&zhdr->buddy);
 	INIT_LIST_HEAD(&page->lru);
-	if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
-		atomic64_dec(&pool->pages_nr);
+	if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
 		return;
-	}
 	spin_lock(&pool->lock);
 	list_add(&page->lru, &pool->lru);
 	spin_unlock(&pool->lock);
-- 
2.23.0

