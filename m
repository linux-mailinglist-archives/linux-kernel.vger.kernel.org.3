Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD15514288
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354739AbiD2Go2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354668AbiD2Gnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:43:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F743B9F29
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:40:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KqNCJ4bp4zhYWh;
        Fri, 29 Apr 2022 14:40:12 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 14:40:33 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 5/9] revert "mm/z3fold.c: allow __GFP_HIGHMEM in z3fold_alloc"
Date:   Fri, 29 Apr 2022 14:40:47 +0800
Message-ID: <20220429064051.61552-6-linmiaohe@huawei.com>
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

Revert commit f1549cb5ab2b ("mm/z3fold.c: allow __GFP_HIGHMEM in
z3fold_alloc").

z3fold can't support GFP_HIGHMEM page now. page_address is used
directly at all places. Moreover, z3fold_header is on per cpu
unbuddied list which could be access anytime. So we should rid
the support of GFP_HIGHMEM allocation for z3fold.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index b3b4e65c107f..5f5d5f1556be 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -212,10 +212,8 @@ static int size_to_chunks(size_t size)
 static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
 							gfp_t gfp)
 {
-	struct z3fold_buddy_slots *slots;
-
-	slots = kmem_cache_zalloc(pool->c_handle,
-				 (gfp & ~(__GFP_HIGHMEM | __GFP_MOVABLE)));
+	struct z3fold_buddy_slots *slots = kmem_cache_zalloc(pool->c_handle,
+							     gfp);
 
 	if (slots) {
 		/* It will be freed separately in free_handle(). */
@@ -1075,7 +1073,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 	enum buddy bud;
 	bool can_sleep = gfpflags_allow_blocking(gfp);
 
-	if (!size)
+	if (!size || (gfp & __GFP_HIGHMEM))
 		return -EINVAL;
 
 	if (size > PAGE_SIZE)
-- 
2.23.0

