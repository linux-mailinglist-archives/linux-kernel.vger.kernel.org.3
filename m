Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117A44FED63
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiDMDOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiDMDNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:13:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A51B33EB1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:11:36 -0700 (PDT)
Received: from kwepemi100013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KdSKG74kmzfYng;
        Wed, 13 Apr 2022 11:10:58 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100013.china.huawei.com (7.221.188.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 11:11:34 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 11:11:33 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <mike.kravetz@oracle.com>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <yaozhenguo1@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <songmuchun@bytedance.com>,
        <liuyuntao10@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <liupeng256@huawei.com>
Subject: [PATCH v3 4/4] hugetlb: Clean up hugetlb_cma_reserve
Date:   Wed, 13 Apr 2022 03:29:15 +0000
Message-ID: <20220413032915.251254-5-liupeng256@huawei.com>
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

Use more generic functions to deal with issues related to online
nodes. The changes will make the code simplified.

Signed-off-by: Peng Liu <liupeng256@huawei.com>
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2e4d8d9fb7c6..4c529774cc08 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6953,7 +6953,7 @@ void __init hugetlb_cma_reserve(int order)
 		if (hugetlb_cma_size_in_node[nid] == 0)
 			continue;
 
-		if (!node_state(nid, N_ONLINE)) {
+		if (!node_online(nid)) {
 			pr_warn("hugetlb_cma: invalid node %d specified\n", nid);
 			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
 			hugetlb_cma_size_in_node[nid] = 0;
@@ -6992,7 +6992,7 @@ void __init hugetlb_cma_reserve(int order)
 	}
 
 	reserved = 0;
-	for_each_node_state(nid, N_ONLINE) {
+	for_each_online_node(nid) {
 		int res;
 		char name[CMA_MAX_NAME];
 
-- 
2.18.0.huawei.25

