Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80B54DC91D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiCQOno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbiCQOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:43:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1588200946
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:41:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KK8vC6qVqzfZFk;
        Thu, 17 Mar 2022 22:40:23 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 22:41:52 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>,
        <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <apopple@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 09/11] mm/migration: fix potential page refcounts leak in migrate_pages
Date:   Fri, 18 Mar 2022 19:17:07 +0800
Message-ID: <20220318111709.60311-10-linmiaohe@huawei.com>
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

In -ENOMEM case, there might be some subpages of fail-to-migrate THPs
left in thp_split_pages list. We should move them back to migration
list so that they could be put back to the right list by the caller
otherwise the page refcnt will be leaked here. Also adjust nr_failed
and nr_thp_failed accordingly to make vm events account more accurate.

Fixes: b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 63a87ef0996f..97dfd1f4870d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1438,6 +1438,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				}
 
 				nr_failed_pages += nr_subpages;
+				/*
+				 * There might be some subpages of fail-to-migrate THPs
+				 * left in thp_split_pages list. Move them back to migration
+				 * list so that they could be put back to the right list by
+				 * the caller otherwise the page refcnt will be leaked.
+				 */
+				list_splice_init(&thp_split_pages, from);
+				nr_thp_failed += thp_retry;
 				goto out;
 			case -EAGAIN:
 				if (is_thp)
-- 
2.23.0

