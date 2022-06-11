Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9B547303
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiFKIsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiFKIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:47:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1F65F67
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 01:47:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKryB44FLzgYGf;
        Sat, 11 Jun 2022 16:45:38 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 11 Jun
 2022 16:47:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <aarcange@redhat.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <dhowells@redhat.com>, <neilb@suse.de>, <apopple@nvidia.com>,
        <david@redhat.com>, <surenb@google.com>, <peterx@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 6/7] mm/khugepaged: remove unneeded return value of khugepaged_add_pte_mapped_thp()
Date:   Sat, 11 Jun 2022 16:47:30 +0800
Message-ID: <20220611084731.55155-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220611084731.55155-1-linmiaohe@huawei.com>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
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

The return value of khugepaged_add_pte_mapped_thp() is always 0 and also
ignored. Remove it to clean up the code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/khugepaged.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 142e26e4bdbf..ee0a719c8be9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1372,7 +1372,7 @@ static void collect_mm_slot(struct mm_slot *mm_slot)
  * Notify khugepaged that given addr of the mm is pte-mapped THP. Then
  * khugepaged should try to collapse the page table.
  */
-static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
+static void khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
 					 unsigned long addr)
 {
 	struct mm_slot *mm_slot;
@@ -1384,7 +1384,6 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
 	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP))
 		mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;
 	spin_unlock(&khugepaged_mm_lock);
-	return 0;
 }
 
 static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
-- 
2.23.0

