Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596CF583E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiG1MUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbiG1MUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:20:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8BF69
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:20:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LtqSb2DTSz9svq;
        Thu, 28 Jul 2022 20:18:55 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Jul
 2022 20:20:06 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <almasrymina@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 5/6] hugetlb_cgroup: use helper macro NUMA_NO_NODE
Date:   Thu, 28 Jul 2022 20:19:48 +0800
Message-ID: <20220728121949.20985-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220728121949.20985-1-linmiaohe@huawei.com>
References: <20220728121949.20985-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better to use NUMA_NO_NODE instead of magic number -1. Minor
readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb_cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 7e0bca52c40f..13ec091385af 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -153,9 +153,9 @@ hugetlb_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	 * function.
 	 */
 	for_each_node(node) {
-		/* Set node_to_alloc to -1 for offline nodes. */
+		/* Set node_to_alloc to NUMA_NO_NODE for offline nodes. */
 		int node_to_alloc =
-			node_state(node, N_NORMAL_MEMORY) ? node : -1;
+			node_state(node, N_NORMAL_MEMORY) ? node : NUMA_NO_NODE;
 		h_cgroup->nodeinfo[node] =
 			kzalloc_node(sizeof(struct hugetlb_cgroup_per_node),
 				     GFP_KERNEL, node_to_alloc);
-- 
2.23.0

