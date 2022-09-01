Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236295A9626
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiIAMBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIAMBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:01:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEAC66A66
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:01:03 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJKLy1n84znTTk;
        Thu,  1 Sep 2022 19:58:34 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 20:01:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 01/10] hugetlb: make hugetlb_cma_check() static
Date:   Thu, 1 Sep 2022 20:00:21 +0800
Message-ID: <20220901120030.63318-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220901120030.63318-1-linmiaohe@huawei.com>
References: <20220901120030.63318-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make hugetlb_cma_check() static as it's only used inside mm/hugetlb.c.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  4 ----
 mm/hugetlb.c            | 10 +++++++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 852f911d676e..c2abbd7950de 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1155,14 +1155,10 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
 
 #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
 extern void __init hugetlb_cma_reserve(int order);
-extern void __init hugetlb_cma_check(void);
 #else
 static inline __init void hugetlb_cma_reserve(int order)
 {
 }
-static inline __init void hugetlb_cma_check(void)
-{
-}
 #endif
 
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0617d64d718..2f5008c67624 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4058,6 +4058,14 @@ static void hugetlb_register_all_nodes(void) { }
 
 #endif
 
+#ifdef CONFIG_CMA
+static void __init hugetlb_cma_check(void);
+#else
+static inline __init void hugetlb_cma_check(void)
+{
+}
+#endif
+
 static int __init hugetlb_init(void)
 {
 	int i;
@@ -7546,7 +7554,7 @@ void __init hugetlb_cma_reserve(int order)
 		hugetlb_cma_size = 0;
 }
 
-void __init hugetlb_cma_check(void)
+static void __init hugetlb_cma_check(void)
 {
 	if (!hugetlb_cma_size || cma_reserve_called)
 		return;
-- 
2.23.0

