Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEBC5551F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376991AbiFVRGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376275AbiFVRGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:06:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D569A3ED3D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:06:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LSqT46cSZzSgrr;
        Thu, 23 Jun 2022 01:03:04 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 01:06:29 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 04/16] mm/huge_memory: use helper touch_pud in huge_pud_set_accessed
Date:   Thu, 23 Jun 2022 01:06:15 +0800
Message-ID: <20220622170627.19786-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220622170627.19786-1-linmiaohe@huawei.com>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Use helper touch_pud to set pud accessed to simplify the code and improve
the readability. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a26580da8011..a0c0e4bf9c1e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1281,21 +1281,15 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 {
-	pud_t entry;
-	unsigned long haddr;
-	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	int flags = 0;
 
 	vmf->ptl = pud_lock(vmf->vma->vm_mm, vmf->pud);
 	if (unlikely(!pud_same(*vmf->pud, orig_pud)))
 		goto unlock;
 
-	entry = pud_mkyoung(orig_pud);
-	if (write)
-		entry = pud_mkdirty(entry);
-	haddr = vmf->address & HPAGE_PUD_MASK;
-	if (pudp_set_access_flags(vmf->vma, haddr, vmf->pud, entry, write))
-		update_mmu_cache_pud(vmf->vma, vmf->address, vmf->pud);
-
+	if (vmf->flags & FAULT_FLAG_WRITE)
+		flags = FOLL_WRITE;
+	touch_pud(vmf->vma, vmf->address, vmf->pud, flags);
 unlock:
 	spin_unlock(vmf->ptl);
 }
-- 
2.23.0

