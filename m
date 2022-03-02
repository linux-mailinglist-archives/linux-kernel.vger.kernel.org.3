Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F14C9F0E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbiCBIXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiCBIXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:23:19 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C932538786
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:22:35 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K7n6n1tJBzbc0g;
        Wed,  2 Mar 2022 16:17:53 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 2 Mar
 2022 16:22:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <shy828301@gmail.com>,
        <william.kucharski@oracle.com>, <hughd@google.com>,
        <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/huge_memory: make is_transparent_hugepage() static
Date:   Wed, 2 Mar 2022 16:21:45 +0800
Message-ID: <20220302082145.12028-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used inside the huge_memory.c now. Don't export it and make
it static. We can thus reduce the size of huge_memory.o a bit.

Without this patch:
   text	   data	    bss	    dec	    hex	filename
  32319	   2965	      4	  35288	   89d8	mm/huge_memory.o

With this patch:
   text	   data	    bss	    dec	    hex	filename
  32042	   2957	      4	  35003	   88bb	mm/huge_memory.o

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/huge_mm.h | 6 ------
 mm/huge_memory.c        | 3 +--
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0734aff8fa19..2999190adc22 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -183,7 +183,6 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 
 void prep_transhuge_page(struct page *page);
 void free_transhuge_page(struct page *page);
-bool is_transparent_hugepage(struct page *page);
 
 bool can_split_folio(struct folio *folio, int *pextra_pins);
 int split_huge_page_to_list(struct page *page, struct list_head *list);
@@ -341,11 +340,6 @@ static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
 
 static inline void prep_transhuge_page(struct page *page) {}
 
-static inline bool is_transparent_hugepage(struct page *page)
-{
-	return false;
-}
-
 #define transparent_hugepage_flags 0UL
 
 #define thp_get_unmapped_area	NULL
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b49e1a11df2e..592588825c07 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -533,7 +533,7 @@ void prep_transhuge_page(struct page *page)
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
 }
 
-bool is_transparent_hugepage(struct page *page)
+static inline bool is_transparent_hugepage(struct page *page)
 {
 	if (!PageCompound(page))
 		return false;
@@ -542,7 +542,6 @@ bool is_transparent_hugepage(struct page *page)
 	return is_huge_zero_page(page) ||
 	       page[1].compound_dtor == TRANSHUGE_PAGE_DTOR;
 }
-EXPORT_SYMBOL_GPL(is_transparent_hugepage);
 
 static unsigned long __thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len,
-- 
2.23.0

