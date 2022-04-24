Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6261750D0BB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbiDXJNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238798AbiDXJNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:13:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDF266F8C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:10:44 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KmMmJ41hYz1JBMN;
        Sun, 24 Apr 2022 17:09:52 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 17:10:41 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <david@redhat.com>, <apopple@nvidia.com>,
        <surenb@google.com>, <minchan@kernel.org>, <peterx@redhat.com>,
        <sfr@canb.auug.org.au>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 2/3] mm/swapfile: Fix lost swap bits in unuse_pte()
Date:   Sun, 24 Apr 2022 17:11:04 +0800
Message-ID: <20220424091105.48374-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220424091105.48374-1-linmiaohe@huawei.com>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is observed by code review only but not any real report.

When we turn off swapping we could have lost the bits stored in the swap
ptes. The new rmap-exclusive bit is fine since that turned into a page
flag, but not for soft-dirty and uffd-wp. Add them.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swapfile.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 95b63f69f388..522a0eb16bf1 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1783,7 +1783,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 {
 	struct page *swapcache;
 	spinlock_t *ptl;
-	pte_t *pte;
+	pte_t *pte, new_pte;
 	int ret = 1;
 
 	swapcache = page;
@@ -1832,8 +1832,12 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		page_add_new_anon_rmap(page, vma, addr);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	}
-	set_pte_at(vma->vm_mm, addr, pte,
-		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
+	new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
+	if (pte_swp_soft_dirty(*pte))
+		new_pte = pte_mksoft_dirty(new_pte);
+	if (pte_swp_uffd_wp(*pte))
+		new_pte = pte_mkuffd_wp(new_pte);
+	set_pte_at(vma->vm_mm, addr, pte, new_pte);
 	swap_free(entry);
 out:
 	pte_unmap_unlock(pte, ptl);
-- 
2.23.0

