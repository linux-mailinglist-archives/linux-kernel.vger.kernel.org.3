Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874634FED64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiDMDN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiDMDNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:13:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3AA5373B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:11:34 -0700 (PDT)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KdSHq5RTSzgYkk;
        Wed, 13 Apr 2022 11:09:43 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 11:11:32 +0800
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
Subject: [PATCH v3 2/4] hugetlb: Fix hugepages_setup when deal with pernode
Date:   Wed, 13 Apr 2022 03:29:13 +0000
Message-ID: <20220413032915.251254-3-liupeng256@huawei.com>
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

Hugepages can be specified to pernode since "hugetlbfs: extend
the definition of hugepages parameter to support node allocation",
but the following problem is observed.

Confusing behavior is observed when both 1G and 2M hugepage is set
after "numa=off".
 cmdline hugepage settings:
  hugepagesz=1G hugepages=0:3,1:3
  hugepagesz=2M hugepages=0:1024,1:1024
 results:
  HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
  HugeTLB registered 2.00 MiB page size, pre-allocated 1024 pages

Furthermore, confusing behavior can be also observed when an
invalid node behind a valid node. To fix this, never allocate any
typical hugepage when an invalid parameter is received.

Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
Signed-off-by: Peng Liu <liupeng256@huawei.com>
---
 mm/hugetlb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5b5a2a5a742f..1930b6341f7e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4116,6 +4116,20 @@ bool __init __weak hugetlb_node_alloc_supported(void)
 {
 	return true;
 }
+
+static void __init hugepages_clear_pages_in_node(void)
+{
+	if (!hugetlb_max_hstate) {
+		default_hstate_max_huge_pages = 0;
+		memset(default_hugepages_in_node, 0,
+			MAX_NUMNODES * sizeof(unsigned int));
+	} else {
+		parsed_hstate->max_huge_pages = 0;
+		memset(parsed_hstate->max_huge_pages_node, 0,
+			MAX_NUMNODES * sizeof(unsigned int));
+	}
+}
+
 /*
  * hugepages command line processing
  * hugepages normally follows a valid hugepagsz or default_hugepagsz
@@ -4203,6 +4217,7 @@ static int __init hugepages_setup(char *s)
 
 invalid:
 	pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
+	hugepages_clear_pages_in_node();
 	return 0;
 }
 __setup("hugepages=", hugepages_setup);
-- 
2.18.0.huawei.25

