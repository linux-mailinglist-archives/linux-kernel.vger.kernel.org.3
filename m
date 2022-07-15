Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52D7575E82
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiGOJZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiGOJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:25:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E227A519
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:25:01 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lkm8t1mzJzjWyB;
        Fri, 15 Jul 2022 17:22:22 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Jul
 2022 17:24:59 +0800
From:   Zhou Guanghui <zhouguanghui1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <zhouguanghui1@huawei.com>
Subject: [PATCH] mm/huge_memory: Return from zap_huge_pmd after WARN_ONCE.
Date:   Fri, 15 Jul 2022 09:22:38 +0000
Message-ID: <20220715092238.22663-1-zhouguanghui1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After WARN_ONCE is processed, the subsequent page judgment results
in NULL pointer access. It is more reasonable to return from the
function here.

Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
---
 mm/huge_memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 834f288b3769..7f5ccca6792a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1601,8 +1601,11 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			entry = pmd_to_swp_entry(orig_pmd);
 			page = pfn_swap_entry_to_page(entry);
 			flush_needed = 0;
-		} else
+		} else {
+			spin_unlock(ptl);
 			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
+			return 1;
+		}
 
 		if (PageAnon(page)) {
 			zap_deposited_table(tlb->mm, pmd);
-- 
2.17.1

