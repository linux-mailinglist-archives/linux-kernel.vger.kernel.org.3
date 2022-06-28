Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F5A55E48D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbiF1Nal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346396AbiF1N3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:29:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792A52A738
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:28:42 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXQLv1wYpzTgJ6;
        Tue, 28 Jun 2022 21:25:11 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 21:28:40 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 05/16] mm/huge_memory: use helper touch_pmd in huge_pmd_set_accessed
Date:   Tue, 28 Jun 2022 21:28:24 +0800
Message-ID: <20220628132835.8925-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220628132835.8925-1-linmiaohe@huawei.com>
References: <20220628132835.8925-1-linmiaohe@huawei.com>
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

Use helper touch_pmd to set pmd accessed to simplify the code and improve
the readability. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d55d5efa06c8..d9fe9b034783 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1120,15 +1120,15 @@ EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud_prot);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags)
+		      pmd_t *pmd, bool write)
 {
 	pmd_t _pmd;
 
 	_pmd = pmd_mkyoung(*pmd);
-	if (flags & FOLL_WRITE)
+	if (write)
 		_pmd = pmd_mkdirty(_pmd);
 	if (pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
-				pmd, _pmd, flags & FOLL_WRITE))
+				  pmd, _pmd, write))
 		update_mmu_cache_pmd(vma, addr, pmd);
 }
 
@@ -1398,21 +1398,13 @@ void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 
 void huge_pmd_set_accessed(struct vm_fault *vmf)
 {
-	pmd_t entry;
-	unsigned long haddr;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
-	pmd_t orig_pmd = vmf->orig_pmd;
 
 	vmf->ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
-	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd)))
+	if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd)))
 		goto unlock;
 
-	entry = pmd_mkyoung(orig_pmd);
-	if (write)
-		entry = pmd_mkdirty(entry);
-	haddr = vmf->address & HPAGE_PMD_MASK;
-	if (pmdp_set_access_flags(vmf->vma, haddr, vmf->pmd, entry, write))
-		update_mmu_cache_pmd(vmf->vma, vmf->address, vmf->pmd);
+	touch_pmd(vmf->vma, vmf->address, vmf->pmd, write);
 
 unlock:
 	spin_unlock(vmf->ptl);
-- 
2.23.0

