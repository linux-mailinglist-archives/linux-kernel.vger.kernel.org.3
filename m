Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68D6583E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiG1MUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiG1MUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:20:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9CBDEC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:20:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LtqRq12vlzmVDm;
        Thu, 28 Jul 2022 20:18:15 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Jul
 2022 20:20:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <almasrymina@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/6] hugetlb_cgroup: hugetlbfs: use helper macro SZ_1{K,M,G}
Date:   Thu, 28 Jul 2022 20:19:46 +0800
Message-ID: <20220728121949.20985-4-linmiaohe@huawei.com>
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

Use helper macro SZ_1K, SZ_1M and SZ_1G to do the size conversion. Minor
readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb_cgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 99e9a367e1e5..7e0bca52c40f 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -674,12 +674,12 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
 
 static char *mem_fmt(char *buf, int size, unsigned long hsize)
 {
-	if (hsize >= (1UL << 30))
-		snprintf(buf, size, "%luGB", hsize >> 30);
-	else if (hsize >= (1UL << 20))
-		snprintf(buf, size, "%luMB", hsize >> 20);
+	if (hsize >= SZ_1G)
+		snprintf(buf, size, "%luGB", hsize / SZ_1G);
+	else if (hsize >= SZ_1M)
+		snprintf(buf, size, "%luMB", hsize / SZ_1M);
 	else
-		snprintf(buf, size, "%luKB", hsize >> 10);
+		snprintf(buf, size, "%luKB", hsize / SZ_1K);
 	return buf;
 }
 
-- 
2.23.0

