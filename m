Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14705140AB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 04:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiD2Crs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 22:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiD2Crr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 22:47:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC78BAB8D;
        Thu, 28 Apr 2022 19:44:29 -0700 (PDT)
Received: from kwepemi100018.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KqGyC1wT8zfb6t;
        Fri, 29 Apr 2022 10:43:31 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100018.china.huawei.com (7.221.188.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 10:44:27 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 10:44:26 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <mike.kravetz@oracle.com>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <yaozhenguo1@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <songmuchun@bytedance.com>,
        <liuyuntao10@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <dave@stgolabs.net>, <liupeng256@huawei.com>,
        <wangborong@cdjrlc.com>, <linux-ia64@vger.kernel.org>,
        <adobriyan@gmail.com>
Subject: [PATCH v4] mm: Using for_each_online_node and node_online instead of open coding
Date:   Fri, 29 Apr 2022 03:02:18 +0000
Message-ID: <20220429030218.644635-1-liupeng256@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413032915.251254-4-liupeng256@huawei.com>
References: <20220413032915.251254-4-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more generic functions to deal with issues related to online
nodes. The changes will make the code simplified.

Signed-off-by: Peng Liu <liupeng256@huawei.com>
Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
---
v4:
 Clean up all the related issues in one patch as suggested by Andrew.

 arch/ia64/kernel/uncached.c | 2 +-
 mm/hugetlb.c                | 4 ++--
 mm/page_ext.c               | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/kernel/uncached.c b/arch/ia64/kernel/uncached.c
index 816803636a75..a0fec82c56b8 100644
--- a/arch/ia64/kernel/uncached.c
+++ b/arch/ia64/kernel/uncached.c
@@ -261,7 +261,7 @@ static int __init uncached_init(void)
 {
 	int nid;
 
-	for_each_node_state(nid, N_ONLINE) {
+	for_each_online_node(nid) {
 		uncached_pools[nid].pool = gen_pool_create(PAGE_SHIFT, nid);
 		mutex_init(&uncached_pools[nid].add_chunk_mutex);
 	}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 30e1099fd99a..0e5a7764efaa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6951,7 +6951,7 @@ void __init hugetlb_cma_reserve(int order)
 		if (hugetlb_cma_size_in_node[nid] == 0)
 			continue;
 
-		if (!node_state(nid, N_ONLINE)) {
+		if (!node_online(nid)) {
 			pr_warn("hugetlb_cma: invalid node %d specified\n", nid);
 			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
 			hugetlb_cma_size_in_node[nid] = 0;
@@ -6990,7 +6990,7 @@ void __init hugetlb_cma_reserve(int order)
 	}
 
 	reserved = 0;
-	for_each_node_state(nid, N_ONLINE) {
+	for_each_online_node(nid) {
 		int res;
 		char name[CMA_MAX_NAME];
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 2e66d934d63f..3dc715d7ac29 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -320,7 +320,7 @@ static int __meminit online_page_ext(unsigned long start_pfn,
 		 * online__pages(), and start_pfn should exist.
 		 */
 		nid = pfn_to_nid(start_pfn);
-		VM_BUG_ON(!node_state(nid, N_ONLINE));
+		VM_BUG_ON(!node_online(nid));
 	}
 
 	for (pfn = start; !fail && pfn < end; pfn += PAGES_PER_SECTION)
-- 
2.25.1

