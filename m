Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E3B4DC915
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiCQOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiCQOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:43:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982F920095D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:41:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KK8v84hfZzfZ7k;
        Thu, 17 Mar 2022 22:40:20 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 22:41:49 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>,
        <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <apopple@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 03/11] mm/migration: remove unneeded local variable page_lru
Date:   Fri, 18 Mar 2022 19:17:01 +0800
Message-ID: <20220318111709.60311-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220318111709.60311-1-linmiaohe@huawei.com>
References: <20220318111709.60311-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use page_is_file_lru() directly to help account the isolated
pages to simplify the code a bit.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index bc1867a5706c..0ea555e4eaae 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2033,7 +2033,6 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
 
 static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 {
-	int page_lru;
 	int nr_pages = thp_nr_pages(page);
 	int order = compound_order(page);
 
@@ -2060,8 +2059,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	if (isolate_lru_page(page))
 		return 0;
 
-	page_lru = page_is_file_lru(page);
-	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
+	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_is_file_lru(page),
 			    nr_pages);
 
 	/*
-- 
2.23.0

