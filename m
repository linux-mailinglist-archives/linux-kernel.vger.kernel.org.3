Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4BC547139
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 04:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346873AbiFKCOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 22:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFKCN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 22:13:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154A7240A9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 19:13:58 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LKhBT220kzRhrQ;
        Sat, 11 Jun 2022 10:10:41 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 11 Jun
 2022 10:13:49 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <joao.m.martins@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2] mm/page_alloc: minor clean up for memmap_init_compound()
Date:   Sat, 11 Jun 2022 10:13:52 +0800
Message-ID: <20220611021352.13529-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Since commit 5232c63f46fd ("mm: Make compound_pincount always available"),
compound_pincount_ptr is stored at first tail page now. So we should call
prep_compound_head() after the first tail page is initialized to take
advantage of the likelihood of that tail struct page being cached given
that we will read them right after in prep_compound_head().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
---
v2:
  Don't move prep_compound_head() outside loop per Joao.
---
 mm/page_alloc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4c7d99ee58b4..048df5d78add 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6771,13 +6771,18 @@ static void __ref memmap_init_compound(struct page *head,
 		set_page_count(page, 0);
 
 		/*
-		 * The first tail page stores compound_mapcount_ptr() and
-		 * compound_order() and the second tail page stores
-		 * compound_pincount_ptr(). Call prep_compound_head() after
-		 * the first and second tail pages have been initialized to
-		 * not have the data overwritten.
+		 * The first tail page stores compound_mapcount_ptr(),
+		 * compound_order() and compound_pincount_ptr(). Call
+		 * prep_compound_head() after the first tail page have
+		 * been initialized to not have the data overwritten.
+		 *
+		 * Note the idea to make this right after we initialize
+		 * the offending tail pages is trying to take advantage
+		 * of the likelihood of those tail struct pages being
+		 * cached given that we will read them right after in
+		 * prep_compound_head().
 		 */
-		if (pfn == head_pfn + 2)
+		if (unlikely(pfn == head_pfn + 1))
 			prep_compound_head(head, order);
 	}
 }
-- 
2.23.0

