Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5111759F277
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 06:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiHXEQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 00:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiHXEQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 00:16:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EC674DC9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 21:16:30 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MCCPQ5npLzkWRQ;
        Wed, 24 Aug 2022 12:12:58 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 12:16:28 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 12:16:28 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <willy@infradead.org>, <akpm@linux-foundation.org>,
        <Liam.Howlett@Oracle.com>, <vbabka@suse.cz>
Subject: [PATCH -next] mm/nommu: fix error handling in split_vma()
Date:   Wed, 24 Aug 2022 12:24:24 +0800
Message-ID: <20220824042424.2031508-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory allocated before calling mas_preallocate() is leaked if it fails.
'mas' won't be modify until calling mas_preallocate(), so move it up and
add error label for free the memory.

Fixes: 8aff7dbeaeb1 ("nommu: remove uses of VMA linked list")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 mm/nommu.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 6c611a689ec0..214c70e1d059 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1355,9 +1355,13 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	new = vm_area_dup(vma);
-	if (!new) {
-		kmem_cache_free(vm_region_jar, region);
-		return -ENOMEM;
+	if (!new)
+		goto err_vma_dup;
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+			current->pid);
+		goto err_mas_preallocate;
 	}
 
 	/* most fields are the same, copy all, and then fixup */
@@ -1388,11 +1392,6 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	add_nommu_region(vma->vm_region);
 	add_nommu_region(new->vm_region);
 	up_write(&nommu_region_sem);
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
-		pr_warn("Allocation of vma tree for process %d failed\n",
-		       current->pid);
-		return -ENOMEM;
-	}
 
 	setup_vma_to_mm(vma, mm);
 	setup_vma_to_mm(new, mm);
@@ -1400,6 +1399,12 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	mas_store(&mas, vma);
 	vma_mas_store(new, &mas);
 	return 0;
+
+err_mas_preallocate:
+	vm_area_free(new);
+err_vma_dup:
+	kmem_cache_free(vm_region_jar, region);
+	return -ENOMEM;
 }
 
 /*
-- 
2.25.1

