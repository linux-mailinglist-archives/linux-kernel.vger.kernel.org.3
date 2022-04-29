Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2D51428C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354748AbiD2Goc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354682AbiD2Gn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:43:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A499AB9F1B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:40:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KqN6S5MmNzCsLJ;
        Fri, 29 Apr 2022 14:36:00 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 14:40:35 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 9/9] mm/z3fold: fix z3fold_page_migrate races with z3fold_map
Date:   Fri, 29 Apr 2022 14:40:51 +0800
Message-ID: <20220429064051.61552-10-linmiaohe@huawei.com>
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
 z3fold_page_migrate		z3fold_map
  z3fold_page_trylock
  ...
  z3fold_page_unlock
  /* slots still points to old zhdr*/
				 get_z3fold_header
				  get slots from handle
				  get old zhdr from slots
				  z3fold_page_trylock
				  return *old* zhdr
  encode_handle(new_zhdr, FIRST|LAST|MIDDLE)
  put_page(page) /* zhdr is freed! */
				 but zhdr is still used by caller!

z3fold_map can map freed z3fold page and lead to use-after-free bug.
To fix it, we add PAGE_MIGRATED to indicate z3fold page is migrated
and soon to be released. So get_z3fold_header won't return such page.

Fixes: 1f862989b04a ("mm/z3fold.c: support page migration")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index a7769befd74e..f41f8b0d9e9a 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -181,6 +181,7 @@ enum z3fold_page_flags {
 	NEEDS_COMPACTING,
 	PAGE_STALE,
 	PAGE_CLAIMED, /* by either reclaim or free */
+	PAGE_MIGRATED, /* page is migrated and soon to be released */
 };
 
 /*
@@ -270,8 +271,13 @@ static inline struct z3fold_header *get_z3fold_header(unsigned long handle)
 			zhdr = (struct z3fold_header *)(addr & PAGE_MASK);
 			locked = z3fold_page_trylock(zhdr);
 			read_unlock(&slots->lock);
-			if (locked)
-				break;
+			if (locked) {
+				struct page *page = virt_to_page(zhdr);
+
+				if (!test_bit(PAGE_MIGRATED, &page->private))
+					break;
+				z3fold_page_unlock(zhdr);
+			}
 			cpu_relax();
 		} while (true);
 	} else {
@@ -389,6 +395,7 @@ static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
 	clear_bit(NEEDS_COMPACTING, &page->private);
 	clear_bit(PAGE_STALE, &page->private);
 	clear_bit(PAGE_CLAIMED, &page->private);
+	clear_bit(PAGE_MIGRATED, &page->private);
 	if (headless)
 		return zhdr;
 
@@ -1576,7 +1583,7 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 	new_zhdr = page_address(newpage);
 	memcpy(new_zhdr, zhdr, PAGE_SIZE);
 	newpage->private = page->private;
-	page->private = 0;
+	set_bit(PAGE_MIGRATED, &page->private);
 	z3fold_page_unlock(zhdr);
 	spin_lock_init(&new_zhdr->page_lock);
 	INIT_WORK(&new_zhdr->work, compact_page_work);
@@ -1606,7 +1613,8 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 
 	queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
 
-	clear_bit(PAGE_CLAIMED, &page->private);
+	/* PAGE_CLAIMED and PAGE_MIGRATED are cleared now. */
+	page->private = 0;
 	put_page(page);
 	return 0;
 }
-- 
2.23.0

