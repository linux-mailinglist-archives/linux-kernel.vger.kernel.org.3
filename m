Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13D35AFC1C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIGGEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiIGGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:04:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775DEF7A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:04:25 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MMs6G44zVzZdW0;
        Wed,  7 Sep 2022 13:59:50 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 14:04:20 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 14:04:19 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        <linux-kernel@vger.kernel.org>, "Vlastimil Babka" <vbabka@suse.cz>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/3] mm: add pageblock_align() macro
Date:   Wed, 7 Sep 2022 14:08:43 +0800
Message-ID: <20220907060844.126891-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220907060844.126891-1-wangkefeng.wang@huawei.com>
References: <20220907060844.126891-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pageblock_align() macro and use it to simplify code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/pageblock-flags.h | 1 +
 mm/memblock.c                   | 4 ++--
 mm/page_isolation.c             | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index a09b7fe6bbf8..293c76630fa8 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -53,6 +53,7 @@ extern unsigned int pageblock_order;
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #define pageblock_nr_pages	(1UL << pageblock_order)
+#define pageblock_align(pfn)	ALIGN((pfn), pageblock_nr_pages)
 #define pageblock_start_pfn(pfn)	ALIGN_DOWN((pfn), pageblock_nr_pages)
 #define pageblock_end_pfn(pfn)		ALIGN((pfn) + 1, pageblock_nr_pages)
 
diff --git a/mm/memblock.c b/mm/memblock.c
index 46fe7575f03c..511d4783dcf1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2014,12 +2014,12 @@ static void __init free_unused_memmap(void)
 		 * presume that there are no holes in the memory map inside
 		 * a pageblock
 		 */
-		prev_end = ALIGN(end, pageblock_nr_pages);
+		prev_end = pageblock_align(end);
 	}
 
 #ifdef CONFIG_SPARSEMEM
 	if (!IS_ALIGNED(prev_end, PAGES_PER_SECTION)) {
-		prev_end = ALIGN(end, pageblock_nr_pages);
+		prev_end = pageblock_align(end);
 		free_memmap(prev_end, ALIGN(prev_end, PAGES_PER_SECTION));
 	}
 #endif
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 9c75170980ab..abd74bd24a35 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -532,7 +532,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	struct page *page;
 	/* isolation is done at page block granularity */
 	unsigned long isolate_start = pageblock_start_pfn(start_pfn);
-	unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
+	unsigned long isolate_end = pageblock_align(end_pfn);
 	int ret;
 	bool skip_isolation = false;
 
@@ -577,7 +577,7 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long pfn;
 	struct page *page;
 	unsigned long isolate_start = pageblock_start_pfn(start_pfn);
-	unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
+	unsigned long isolate_end = pageblock_align(end_pfn);
 
 	for (pfn = isolate_start;
 	     pfn < isolate_end;
-- 
2.35.3

