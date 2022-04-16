Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054B25035EC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiDPKT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiDPKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:19:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A2865BF
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 03:17:23 -0700 (PDT)
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KgTdq0Yx5zRdv8;
        Sat, 16 Apr 2022 18:17:19 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 18:17:21 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 18:17:20 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <mike.kravetz@oracle.com>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <yaozhenguo1@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <songmuchun@bytedance.com>,
        <liuyuntao10@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <dave@stgolabs.net>, <liupeng256@huawei.com>
Subject: [PATCH v4] hugetlb: Fix wrong use of nr_online_nodes
Date:   Sat, 16 Apr 2022 10:35:26 +0000
Message-ID: <20220416103526.3287348-1-liupeng256@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413032915.251254-2-liupeng256@huawei.com>
References: <20220413032915.251254-2-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain systems are designed to have sparse/discontiguous nodes. In
this case, nr_online_nodes can not be used to walk through numa node.
Also, a valid node may be greater than nr_online_nodes.

However, in hugetlb, it is assumed that nodes are contiguous. Recheck
all the places that use nr_online_nodes, and repair them one by one.

Suggested-by: David Hildenbrand <david@redhat.com>
Fixes: 4178158ef8ca ("hugetlbfs: fix issue of preallocation of gigantic pages can't work")
Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
Fixes: e79ce9832316 ("hugetlbfs: fix a truncation issue in hugepages parameter")
Fixes: f9317f77a6e0 ("hugetlb: clean up potential spectre issue warnings")
Signed-off-by: Peng Liu <liupeng256@huawei.com>
---
v3->v4:
 Make sure nid is valid before use node_online, and __alloc_bootmem_huge_page
 is no need to check node_online, which is suggested by Kefeng.

 mm/hugetlb.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b34f50156f7e..a386c5f94932 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2979,8 +2979,6 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	struct huge_bootmem_page *m = NULL; /* initialize for clang */
 	int nr_nodes, node;
 
-	if (nid != NUMA_NO_NODE && nid >= nr_online_nodes)
-		return 0;
 	/* do node specific alloc */
 	if (nid != NUMA_NO_NODE) {
 		m = memblock_alloc_try_nid_raw(huge_page_size(h), huge_page_size(h),
@@ -3088,7 +3086,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	}
 
 	/* do node specific alloc */
-	for (i = 0; i < nr_online_nodes; i++) {
+	for_each_online_node(i) {
 		if (h->max_huge_pages_node[i] > 0) {
 			hugetlb_hstate_alloc_pages_onenode(h, i);
 			node_specific_alloc = true;
@@ -4049,7 +4047,7 @@ static int __init hugetlb_init(void)
 			default_hstate.max_huge_pages =
 				default_hstate_max_huge_pages;
 
-			for (i = 0; i < nr_online_nodes; i++)
+			for_each_online_node(i)
 				default_hstate.max_huge_pages_node[i] =
 					default_hugepages_in_node[i];
 		}
@@ -4164,9 +4162,9 @@ static int __init hugepages_setup(char *s)
 				pr_warn("HugeTLB: architecture can't support node specific alloc, ignoring!\n");
 				return 0;
 			}
-			if (tmp >= nr_online_nodes)
+			if (tmp >= MAX_NUMNODES || !node_online(tmp))
 				goto invalid;
-			node = array_index_nospec(tmp, nr_online_nodes);
+			node = array_index_nospec(tmp, MAX_NUMNODES);
 			p += count + 1;
 			/* Parse hugepages */
 			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
@@ -4294,7 +4292,7 @@ static int __init default_hugepagesz_setup(char *s)
 	 */
 	if (default_hstate_max_huge_pages) {
 		default_hstate.max_huge_pages = default_hstate_max_huge_pages;
-		for (i = 0; i < nr_online_nodes; i++)
+		for_each_online_node(i)
 			default_hstate.max_huge_pages_node[i] =
 				default_hugepages_in_node[i];
 		if (hstate_is_gigantic(&default_hstate))
-- 
2.25.1

