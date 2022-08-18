Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED68598363
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbiHRMqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiHRMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:46:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ACC5EDD4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:46:35 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M7l2B3HtXznTVN;
        Thu, 18 Aug 2022 20:44:18 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 20:46:31 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 18 Aug
 2022 20:46:30 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page
Date:   Thu, 18 Aug 2022 21:21:04 +0800
Message-ID: <20220818132104.2144770-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmemmap pages is marked by kmemleak when allocated from memblock.
Remove it from kmemleak when free the page. Otherwise, when we reuse the
page, kmemleak may report such an error and then stop working.

 kmemleak: Cannot insert 0xffff98fb6eab3d40 into the object search tree (overlaps existing)
 kmemleak: Kernel memory leak detector disabled
 kmemleak: Object 0xffff98fb6be00000 (size 335544320):
 kmemleak:   comm "swapper", pid 0, jiffies 4294892296
 kmemleak:   min_count = 0
 kmemleak:   count = 0
 kmemleak:   flags = 0x1
 kmemleak:   checksum = 0
 kmemleak:   backtrace:

Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 include/linux/bootmem_info.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index cc35d010fa94..899bc56948f7 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -3,6 +3,7 @@
 #define __LINUX_BOOTMEM_INFO_H
 
 #include <linux/mm.h>
+#include <linux/kmemleak.h>
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
@@ -38,9 +39,10 @@ static inline void free_bootmem_page(struct page *page)
 	 */
 	VM_BUG_ON_PAGE(page_ref_count(page) != 2, page);
 
-	if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
+	if (magic == SECTION_INFO || magic == MIX_SECTION_INFO) {
+		kmemleak_free_part(page_to_virt(page), PAGE_SIZE);
 		put_page_bootmem(page);
-	else
+	} else
 		VM_BUG_ON_PAGE(1, page);
 }
 #else
-- 
2.25.1

