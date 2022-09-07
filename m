Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ADF5B00F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiIGJzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiIGJzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:55:12 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC029326C5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:55:07 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 2879r1wO028434
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Wed, 7 Sep 2022 17:53:02 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 7 Sep 2022 17:53:02 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>
Subject: [PATCHv2] mm: introduce __GFP_TRACKLEAK to track in-kernel allocation
Date:   Wed, 7 Sep 2022 17:52:37 +0800
Message-ID: <1662544357-26649-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 2879r1wO028434
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Kthread and drivers could fetch memory via alloc_pages directly which make them
hard to debug when leaking. Solve this by introducing __GFP_TRACELEAK and reuse
kmemleak mechanism which unified most of kernel cosuming pages into kmemleak.

Here is the test result for driver that get memory via invoking alloc_pages directly.
unreferenced object 0xffffff807c620000 (size 65536):
comm "allocator@4.0-s", pid 745, jiffies 4294906308 (age 5136.616s)
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
backtrace:
[<00000000ffefbfdf>] __alloc_pages_nodemask+0x108/0x3a4
[<0000000083595277>] ion_page_pool_alloc+0x178/0x234
[<000000008267995a>] ion_system_heap_allocate+0x13c/0x708
[<00000000d4df5a5e>] ion_buffer_create+0x98/0x67c
[<0000000043fa6683>] ion_dmabuf_alloc+0xcc/0x1c0
[<000000000d1db17e>] ion_ioctl+0x150/0x350
[<00000000a2b89048>] do_vfs_ioctl+0x5d4/0xa94
[<000000008e9b61d3>] __arm64_sys_ioctl+0x14c/0x164
[<00000000114425a9>] el0_svc_common+0xd0/0x23c
[<00000000ec9cb1b1>] el0_svc_handler+0x2c/0x3c
[<00000000e44a2c21>] el0_svc+0x8/0x100
unreferenced object 0xffffff807c189000 (size 4096):
comm "allocator@4.0-s", pid 745, jiffies 4294906309 (age 5136.612s)
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
backtrace:
[<00000000ffefbfdf>] __alloc_pages_nodemask+0x108/0x3a4
[<0000000083595277>] ion_page_pool_alloc+0x178/0x234
[<00000000b30c4562>] ion_system_heap_allocate+0x160/0x708
[<00000000d4df5a5e>] ion_buffer_create+0x98/0x67c
[<0000000043fa6683>] ion_dmabuf_alloc+0xcc/0x1c0
[<000000000d1db17e>] ion_ioctl+0x150/0x350
[<00000000a2b89048>] do_vfs_ioctl+0x5d4/0xa94
[<000000008e9b61d3>] __arm64_sys_ioctl+0x14c/0x164
[<00000000114425a9>] el0_svc_common+0xd0/0x23c
[<00000000ec9cb1b1>] el0_svc_handler+0x2c/0x3c
[<00000000e44a2c21>] el0_svc+0x8/0x100

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: code update
---
---
 include/linux/gfp.h        |  8 +++++++-
 include/linux/page-flags.h |  3 +++
 mm/page_alloc.c            | 14 ++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 2d2ccae..a62938e 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -68,6 +68,11 @@
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+#ifdef CONFIG_HAVE_DEBUG_KMEMLEAK
+#define ___GFP_TRACKLEAK	0x10000000u
+#else
+#define ___GFP_TRACKLEAK	0
+#endif
 /* If the above are modified, __GFP_BITS_SHIFT may need updating */
 
 /*
@@ -259,12 +264,13 @@
 #define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
 #define __GFP_SKIP_KASAN_UNPOISON ((__force gfp_t)___GFP_SKIP_KASAN_UNPOISON)
 #define __GFP_SKIP_KASAN_POISON   ((__force gfp_t)___GFP_SKIP_KASAN_POISON)
+#define __GFP_TRACKLEAK   ((__force gfp_t)___GFP_TRACKLEAK)
 
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (28 + IS_ENABLED(CONFIG_LOCKDEP) + IS_ENABLED(CONFIG_HAVE_DEBUG_KMEMLEAK))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e66f7aa..ef0f814 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -942,6 +942,7 @@ static inline bool is_page_hwpoison(struct page *page)
 #define PG_offline	0x00000100
 #define PG_table	0x00000200
 #define PG_guard	0x00000400
+#define PG_trackleak	0x00000800
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -1012,6 +1013,8 @@ static inline int page_has_type(struct page *page)
  */
 PAGE_TYPE_OPS(Guard, guard)
 
+PAGE_TYPE_OPS(Trackleak, trackleak)
+
 extern bool is_free_buddy_page(struct page *page);
 
 PAGEFLAG(Isolated, isolated, PF_ANY);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3d..d6121b4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1357,6 +1357,10 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		}
 	}
+	if (PageTrackleak(page)) {
+		__ClearPageTrackleak(page);
+		kmemleak_free(page);
+	}
 	if (PageMappingFlags(page))
 		page->mapping = NULL;
 	if (memcg_kmem_enabled() && PageMemcgKmem(page))
@@ -1521,6 +1525,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			if (unlikely(isolated_pageblocks))
 				mt = get_pageblock_migratetype(page);
 
+			if (PageTrackleak(page)) {
+				__ClearPageTrackleak(page);
+				kmemleak_free(page);
+			}
+
 			__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
 			trace_mm_page_pcpu_drain(page, order, mt);
 		} while (count > 0 && !list_empty(list));
@@ -2468,6 +2477,11 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 		set_page_pfmemalloc(page);
 	else
 		clear_page_pfmemalloc(page);
+
+	if (gfp_flags & __GFP_TRACKLEAK) {
+		kmemleak_alloc(page_address(page), PAGE_SIZE << order, 1, gfp_flags & ~__GFP_TRACKLEAK);
+		__SetPageTrackleak(page);
+	}
 }
 
 /*
-- 
1.9.1

