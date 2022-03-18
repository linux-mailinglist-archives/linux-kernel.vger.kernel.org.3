Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502244DC91F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiCQOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiCQOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:43:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A77D200962
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:41:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KK8q95h19zcbCl;
        Thu, 17 Mar 2022 22:36:53 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 22:41:53 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>,
        <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <apopple@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 10/11] mm/migration: fix potential invalid node access for reclaim-based migration
Date:   Fri, 18 Mar 2022 19:17:08 +0800
Message-ID: <20220318111709.60311-11-linmiaohe@huawei.com>
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

If we failed to setup hotplug state callbacks for mm/demotion:online in
some corner cases, node_demotion will be left uninitialized. Invalid node
might be returned from the next_demotion_node() when doing reclaim-based
migration. Use kcalloc to allocate node_demotion to fix the issue.

Fixes: ac16ec835314 ("mm: migrate: support multiple target nodes demotion")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/migrate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 97dfd1f4870d..dbd91fbdb127 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2534,9 +2534,9 @@ static int __init migrate_on_reclaim_init(void)
 {
 	int ret;
 
-	node_demotion = kmalloc_array(nr_node_ids,
-				      sizeof(struct demotion_nodes),
-				      GFP_KERNEL);
+	node_demotion = kcalloc(nr_node_ids,
+				sizeof(struct demotion_nodes),
+				GFP_KERNEL);
 	WARN_ON(!node_demotion);
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
-- 
2.23.0

