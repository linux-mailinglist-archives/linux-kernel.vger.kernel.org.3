Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9364FED65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiDMDOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiDMDNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:13:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03846424BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:11:34 -0700 (PDT)
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KdSHp6gPbzgYbW;
        Wed, 13 Apr 2022 11:09:42 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 11:11:31 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 11:11:31 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <mike.kravetz@oracle.com>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <yaozhenguo1@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <songmuchun@bytedance.com>,
        <liuyuntao10@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <liupeng256@huawei.com>
Subject: [PATCH v3 1/4] hugetlb: Fix wrong use of nr_online_nodes
Date:   Wed, 13 Apr 2022 03:29:12 +0000
Message-ID: <20220413032915.251254-2-liupeng256@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220413032915.251254-1-liupeng256@huawei.com>
References: <20220413032915.251254-1-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
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
 mm/hugetlb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b34f50156f7e..5b5a2a5a742f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2979,7 +2979,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	struct huge_bootmem_page *m = NULL; /* initialize for clang */
 	int nr_nodes, node;
 
-	if (nid != NUMA_NO_NODE && nid >= nr_online_nodes)
+	if (nid != NUMA_NO_NODE && !node_online(nid))
 		return 0;
 	/* do node specific alloc */
 	if (nid != NUMA_NO_NODE) {
@@ -3088,7 +3088,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	}
 
 	/* do node specific alloc */
-	for (i = 0; i < nr_online_nodes; i++) {
+	for_each_online_node(i) {
 		if (h->max_huge_pages_node[i] > 0) {
 			hugetlb_hstate_alloc_pages_onenode(h, i);
 			node_specific_alloc = true;
@@ -4049,7 +4049,7 @@ static int __init hugetlb_init(void)
 			default_hstate.max_huge_pages =
 				default_hstate_max_huge_pages;
 
-			for (i = 0; i < nr_online_nodes; i++)
+			for_each_online_node(i)
 				default_hstate.max_huge_pages_node[i] =
 					default_hugepages_in_node[i];
 		}
@@ -4164,9 +4164,9 @@ static int __init hugepages_setup(char *s)
 				pr_warn("HugeTLB: architecture can't support node specific alloc, ignoring!\n");
 				return 0;
 			}
-			if (tmp >= nr_online_nodes)
+			if (!node_online(tmp))
 				goto invalid;
-			node = array_index_nospec(tmp, nr_online_nodes);
+			node = array_index_nospec(tmp, MAX_NUMNODES);
 			p += count + 1;
 			/* Parse hugepages */
 			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
@@ -4294,7 +4294,7 @@ static int __init default_hugepagesz_setup(char *s)
 	 */
 	if (default_hstate_max_huge_pages) {
 		default_hstate.max_huge_pages = default_hstate_max_huge_pages;
-		for (i = 0; i < nr_online_nodes; i++)
+		for_each_online_node(i)
 			default_hstate.max_huge_pages_node[i] =
 				default_hugepages_in_node[i];
 		if (hstate_is_gigantic(&default_hstate))
-- 
2.18.0.huawei.25

