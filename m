Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708944BC71D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 10:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbiBSJ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 04:27:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241801AbiBSJ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 04:26:44 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABCC24CCE6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 01:26:24 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K133n25lYzbbZ2;
        Sat, 19 Feb 2022 17:21:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 19 Feb
 2022 17:26:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vitaly.wool@konsulko.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 9/9] mm/z3fold: remove unneeded return value of z3fold_compact_page()
Date:   Sat, 19 Feb 2022 17:25:33 +0800
Message-ID: <20220219092533.12596-10-linmiaohe@huawei.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unneeded return value of z3fold_compact_page() as it's
never checked.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 83b5a3514427..db41b4227ec7 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -746,18 +746,18 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 
 #define BIG_CHUNK_GAP	3
 /* Has to be called with lock held */
-static int z3fold_compact_page(struct z3fold_header *zhdr)
+static void z3fold_compact_page(struct z3fold_header *zhdr)
 {
 	struct page *page = virt_to_page(zhdr);
 
 	if (test_bit(MIDDLE_CHUNK_MAPPED, &page->private))
-		return 0; /* can't move middle chunk, it's used */
+		return; /* can't move middle chunk, it's used */
 
 	if (unlikely(PageIsolated(page)))
-		return 0;
+		return;
 
 	if (zhdr->middle_chunks == 0)
-		return 0; /* nothing to compact */
+		return; /* nothing to compact */
 
 	if (zhdr->first_chunks == 0 && zhdr->last_chunks == 0) {
 		/* move to the beginning */
@@ -766,7 +766,7 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
 		zhdr->middle_chunks = 0;
 		zhdr->start_middle = 0;
 		zhdr->first_num++;
-		return 1;
+		return;
 	}
 
 	/*
@@ -778,7 +778,6 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
 			BIG_CHUNK_GAP) {
 		mchunk_memmove(zhdr, zhdr->first_chunks + ZHDR_CHUNKS);
 		zhdr->start_middle = zhdr->first_chunks + ZHDR_CHUNKS;
-		return 1;
 	} else if (zhdr->last_chunks != 0 && zhdr->first_chunks == 0 &&
 		   TOTAL_CHUNKS - (zhdr->last_chunks + zhdr->start_middle
 					+ zhdr->middle_chunks) >=
@@ -787,10 +786,7 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
 			zhdr->middle_chunks;
 		mchunk_memmove(zhdr, new_start);
 		zhdr->start_middle = new_start;
-		return 1;
 	}
-
-	return 0;
 }
 
 static void do_compact_page(struct z3fold_header *zhdr, bool locked)
-- 
2.23.0

