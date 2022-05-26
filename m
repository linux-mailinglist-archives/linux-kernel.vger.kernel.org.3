Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A728534E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347159AbiEZLdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbiEZLdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:33:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903FD6D4C2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:33:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L85Qd30kxzjWvn;
        Thu, 26 May 2022 19:32:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 19:33:41 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <pasha.tatashin@soleen.com>
CC:     <rientjes@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/page_table_check: fix accessing unmapped ptep
Date:   Thu, 26 May 2022 19:33:50 +0800
Message-ID: <20220526113350.30806-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

ptep is unmapped too early, so ptep will be accessed while it's unmapped.
Fix it by deferring pte_unmap() until page table checking is done.

Fixes: 80110bbfbba6 ("mm/page_table_check: check entries at pmd levels")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_table_check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 3692bea2ea2c..971c3129b0e3 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -234,11 +234,11 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
 		pte_t *ptep = pte_offset_map(&pmd, addr);
 		unsigned long i;
 
-		pte_unmap(ptep);
 		for (i = 0; i < PTRS_PER_PTE; i++) {
 			__page_table_check_pte_clear(mm, addr, *ptep);
 			addr += PAGE_SIZE;
 			ptep++;
 		}
+		pte_unmap(ptep);
 	}
 }
-- 
2.23.0

