Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9254A4DC917
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiCQOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiCQOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:43:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3297D20095D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:41:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KK8rV41Jjz9sh1;
        Thu, 17 Mar 2022 22:38:02 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 22:41:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>,
        <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <apopple@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 08/11] mm/migration: remove some duplicated codes in migrate_pages
Date:   Fri, 18 Mar 2022 19:17:06 +0800
Message-ID: <20220318111709.60311-9-linmiaohe@huawei.com>
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

Remove the duplicated codes in migrate_pages to simplify the code. Minor
readability improvement. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index bb36f6b40f18..63a87ef0996f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1414,14 +1414,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 						nr_thp_split++;
 						goto retry;
 					}
-
-					nr_failed_pages += nr_subpages;
-					break;
-				}
-
 				/* Hugetlb migration is unsupported */
-				if (!no_subpage_counting)
+				} else if (!no_subpage_counting) {
 					nr_failed++;
+				}
+
 				nr_failed_pages += nr_subpages;
 				break;
 			case -ENOMEM:
@@ -1436,28 +1433,22 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 						nr_thp_split++;
 						goto retry;
 					}
-
-					nr_failed_pages += nr_subpages;
-					goto out;
+				} else if (!no_subpage_counting) {
+					nr_failed++;
 				}
 
-				if (!no_subpage_counting)
-					nr_failed++;
 				nr_failed_pages += nr_subpages;
 				goto out;
 			case -EAGAIN:
-				if (is_thp) {
+				if (is_thp)
 					thp_retry++;
-					break;
-				}
-				retry++;
+				else
+					retry++;
 				break;
 			case MIGRATEPAGE_SUCCESS:
 				nr_succeeded += nr_subpages;
-				if (is_thp) {
+				if (is_thp)
 					nr_thp_succeeded++;
-					break;
-				}
 				break;
 			default:
 				/*
@@ -1466,14 +1457,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 * removed from migration page list and not
 				 * retried in the next outer loop.
 				 */
-				if (is_thp) {
+				if (is_thp)
 					nr_thp_failed++;
-					nr_failed_pages += nr_subpages;
-					break;
-				}
-
-				if (!no_subpage_counting)
+				else if (!no_subpage_counting)
 					nr_failed++;
+
 				nr_failed_pages += nr_subpages;
 				break;
 			}
-- 
2.23.0

