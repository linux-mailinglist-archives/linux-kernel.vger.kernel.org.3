Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335314BB4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiBRJDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:03:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiBRJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:02:31 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F79656211
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:02:11 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K0QZK602dz1FDHj;
        Fri, 18 Feb 2022 16:57:45 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Feb
 2022 17:02:09 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 6/8] mm/memory-failure.c: rework the try_to_unmap logic in hwpoison_user_mappings()
Date:   Fri, 18 Feb 2022 17:01:16 +0800
Message-ID: <20220218090118.1105-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220218090118.1105-1-linmiaohe@huawei.com>
References: <20220218090118.1105-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Only for hugetlb pages in shared mappings, try_to_unmap should take
semaphore in write mode here. Rework the code to make it clear.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a6f6fdf708ae..365384c41da1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1404,26 +1404,22 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (kill)
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
-	if (!PageHuge(hpage)) {
-		try_to_unmap(hpage, ttu);
+	if (PageHuge(hpage) && !PageAnon(hpage)) {
+		/*
+		 * For hugetlb pages in shared mappings, try_to_unmap
+		 * could potentially call huge_pmd_unshare.  Because of
+		 * this, take semaphore in write mode here and set
+		 * TTU_RMAP_LOCKED to indicate we have taken the lock
+		 * at this higher level.
+		 */
+		mapping = hugetlb_page_mapping_lock_write(hpage);
+		if (mapping) {
+			try_to_unmap(hpage, ttu|TTU_RMAP_LOCKED);
+			i_mmap_unlock_write(mapping);
+		} else
+			pr_info("Memory failure: %#lx: could not lock mapping for mapped huge page\n", pfn);
 	} else {
-		if (!PageAnon(hpage)) {
-			/*
-			 * For hugetlb pages in shared mappings, try_to_unmap
-			 * could potentially call huge_pmd_unshare.  Because of
-			 * this, take semaphore in write mode here and set
-			 * TTU_RMAP_LOCKED to indicate we have taken the lock
-			 * at this higher level.
-			 */
-			mapping = hugetlb_page_mapping_lock_write(hpage);
-			if (mapping) {
-				try_to_unmap(hpage, ttu|TTU_RMAP_LOCKED);
-				i_mmap_unlock_write(mapping);
-			} else
-				pr_info("Memory failure: %#lx: could not lock mapping for mapped huge page\n", pfn);
-		} else {
-			try_to_unmap(hpage, ttu);
-		}
+		try_to_unmap(hpage, ttu);
 	}
 
 	unmap_success = !page_mapped(hpage);
-- 
2.23.0

