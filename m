Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD914BC722
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 10:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbiBSJ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 04:26:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241785AbiBSJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 04:26:41 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC87E24CCDE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 01:26:22 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K134y0LKzz8w8r;
        Sat, 19 Feb 2022 17:22:58 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 19 Feb
 2022 17:26:20 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vitaly.wool@konsulko.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 3/9] mm/z3fold: minor clean up for z3fold_free
Date:   Sat, 19 Feb 2022 17:25:27 +0800
Message-ID: <20220219092533.12596-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220219092533.12596-1-linmiaohe@huawei.com>
References: <20220219092533.12596-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use put_z3fold_header() to pair with get_z3fold_header. Also fix the wrong
comments. Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
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

