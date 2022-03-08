Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68E54D1981
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347203AbiCHNpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiCHNpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:45:03 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A42849C8D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:44:06 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KCbyr3rzBz1GCFk;
        Tue,  8 Mar 2022 21:39:16 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Mar
 2022 21:44:03 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 3/8] mm/z3fold: minor clean up for z3fold_free
Date:   Tue, 8 Mar 2022 21:43:06 +0800
Message-ID: <20220308134311.59086-4-linmiaohe@huawei.com>
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

Use put_z3fold_header() to pair with get_z3fold_header. Also fix the wrong
comments. Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 mm/z3fold.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 87689f50f709..eb89271aea83 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1187,9 +1187,9 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
  * @handle:	handle associated with the allocation returned by z3fold_alloc()
  *
  * In the case that the z3fold page in which the allocation resides is under
- * reclaim, as indicated by the PG_reclaim flag being set, this function
- * only sets the first|last_chunks to 0.  The page is actually freed
- * once both buddies are evicted (see z3fold_reclaim_page() below).
+ * reclaim, as indicated by the PAGE_CLAIMED flag being set, this function
+ * only sets the first|middle|last_chunks to 0.  The page is actually freed
+ * once all buddies are evicted (see z3fold_reclaim_page() below).
  */
 static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 {
@@ -1247,7 +1247,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 	}
 	if (page_claimed) {
 		/* the page has not been claimed by us */
-		z3fold_page_unlock(zhdr);
+		put_z3fold_header(zhdr);
 		return;
 	}
 	if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
-- 
2.23.0

