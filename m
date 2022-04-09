Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9781A4FA689
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbiDIJgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbiDIJgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:36:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164FC51583
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 02:34:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kb8zb3pxBzgY9K;
        Sat,  9 Apr 2022 17:32:43 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Apr
 2022 17:34:29 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <hch@infradead.org>, <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 2/9] mm/vmscan: remove unneeded can_split_huge_page check
Date:   Sat, 9 Apr 2022 17:34:53 +0800
Message-ID: <20220409093500.10329-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220409093500.10329-1-linmiaohe@huawei.com>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

We don't need to check can_split_folio() because folio_maybe_dma_pinned()
is checked before. It will avoid the long term pinned pages to be swapped
out. And we can live with short term pinned pages. Without can_split_folio
checking we can simplify the code. Also activate_locked can be changed to
keep_locked as it's just short term pinning.

Suggested-by: Huang, Ying <ying.huang@intel.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4a76be47bed1..01f5db75a507 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1711,20 +1711,14 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 					goto keep_locked;
 				if (folio_maybe_dma_pinned(folio))
 					goto keep_locked;
-				if (PageTransHuge(page)) {
-					/* cannot split THP, skip it */
-					if (!can_split_folio(folio, NULL))
-						goto activate_locked;
-					/*
-					 * Split pages without a PMD map right
-					 * away. Chances are some or all of the
-					 * tail pages can be freed without IO.
-					 */
-					if (!folio_entire_mapcount(folio) &&
-					    split_folio_to_list(folio,
-								page_list))
-						goto activate_locked;
-				}
+				/*
+				 * Split pages without a PMD map right
+				 * away. Chances are some or all of the
+				 * tail pages can be freed without IO.
+				 */
+				if (PageTransHuge(page) && !folio_entire_mapcount(folio) &&
+				    split_folio_to_list(folio, page_list))
+					goto keep_locked;
 				if (!add_to_swap(page)) {
 					if (!PageTransHuge(page))
 						goto activate_locked_split;
-- 
2.23.0

