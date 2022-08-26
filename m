Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C11D5A2443
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343755AbiHZJZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343665AbiHZJY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:24:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA25727D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:24:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDZ9h3QwDzmV7R;
        Fri, 26 Aug 2022 17:22:32 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 17:24:53 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 05/10] hugetlb: Use helper {huge_pte|pmd}_lock()
Date:   Fri, 26 Aug 2022 17:24:17 +0800
Message-ID: <20220826092422.39591-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220826092422.39591-1-linmiaohe@huawei.com>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Use helper huge_pte_lock and pmd_lock to simplify the code. No functional
change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 06293da96112..6ea9f73aea84 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6094,8 +6094,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		page_in_pagecache = true;
 	}
 
-	ptl = huge_pte_lockptr(h, dst_mm, dst_pte);
-	spin_lock(ptl);
+	ptl = huge_pte_lock(h, dst_mm, dst_pte);
 
 	/*
 	 * We allow to overwrite a pte marker: consider when both MISSING|WP
@@ -7176,8 +7175,7 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 		return NULL;
 
 retry:
-	ptl = pmd_lockptr(mm, pmd);
-	spin_lock(ptl);
+	ptl = pmd_lock(mm, pmd);
 	/*
 	 * make sure that the address range covered by this pmd is not
 	 * unmapped from other threads.
-- 
2.23.0

