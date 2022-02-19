Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB324BC720
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 10:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbiBSJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 04:26:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbiBSJ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 04:26:40 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAFD24CCDB
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 01:26:22 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K133l1HDTzbbZp;
        Sat, 19 Feb 2022 17:21:55 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 19 Feb
 2022 17:26:20 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vitaly.wool@konsulko.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 4/9] mm/z3fold: remove unneeded page_mapcount_reset and ClearPagePrivate
Date:   Sat, 19 Feb 2022 17:25:28 +0800
Message-ID: <20220219092533.12596-5-linmiaohe@huawei.com>
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

Page->page_type and PagePrivate are not used in z3fold. We should remove
these confusing unneeded operations. The z3fold do these here is due to
referring to zsmalloc's migration code which does need these operations.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index eb89271aea83..2f848ea45b4d 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -420,7 +420,6 @@ static void free_z3fold_page(struct page *page, bool headless)
 		__ClearPageMovable(page);
 		unlock_page(page);
 	}
-	ClearPagePrivate(page);
 	__free_page(page);
 }
 
@@ -1635,7 +1634,6 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 	INIT_LIST_HEAD(&new_zhdr->buddy);
 	new_mapping = page_mapping(page);
 	__ClearPageMovable(page);
-	ClearPagePrivate(page);
 
 	get_page(newpage);
 	z3fold_page_lock(new_zhdr);
@@ -1655,7 +1653,6 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 
 	queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
 
-	page_mapcount_reset(page);
 	clear_bit(PAGE_CLAIMED, &page->private);
 	put_page(page);
 	return 0;
-- 
2.23.0

