Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B184E5F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348529AbiCXH14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348558AbiCXH1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:27:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B3398F5D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:26:15 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KPGtY2zFZzCql5;
        Thu, 24 Mar 2022 15:24:05 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500011.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 15:26:13 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 15:26:12 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>,
        <yaozhenguo1@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <liupeng256@huawei.com>
Subject: [PATCH] hugetlb: Fix hugepages_setup when deal with pernode
Date:   Thu, 24 Mar 2022 07:40:37 +0000
Message-ID: <20220324074037.2024608-1-liupeng256@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
but the following two problems are observed.

1) Confusing behavior is observed when both 1G and 2M hugepage
is set after "numa=off".
 cmdline hugepage settings:
  hugepagesz=1G hugepages=0:3,1:3
  hugepagesz=2M hugepages=0:1024,1:1024
 results:
  HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
  HugeTLB registered 2.00 MiB page size, pre-allocated 1024 pages

2) Using invalid option values causes the entire kernel boot option
string to be reported as Unknown.
 Unknown kernel command line parameters "hugepages=0:1024,1:1024"

To fix "1)", hugetlb_hstate_alloc_pages should be called even when
hugepages_setup going to invalid. To fix "2)", return 1 so that
init's environment is not polluted with kernel boot options.

Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
Signed-off-by: Peng Liu <liupeng256@huawei.com>
---
 mm/hugetlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b34f50156f7e..de8e1d8a2c66 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4189,6 +4189,7 @@ static int __init hugepages_setup(char *s)
 		}
 	}
 
+out:
 	/*
 	 * Global state is always initialized later in hugetlb_init.
 	 * But we need to allocate gigantic hstates here early to still
@@ -4203,7 +4204,7 @@ static int __init hugepages_setup(char *s)
 
 invalid:
 	pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
-	return 0;
+	goto out;
 }
 __setup("hugepages=", hugepages_setup);
 
-- 
2.18.0.huawei.25

