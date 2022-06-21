Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7055553CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355801AbiFUVFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356805AbiFUVEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:04:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671926400;
        Tue, 21 Jun 2022 13:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF0F4B81A9A;
        Tue, 21 Jun 2022 20:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E70BC3411C;
        Tue, 21 Jun 2022 20:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655844811;
        bh=20N4ZigNt3ywDZXkpxWcD1TBryesu5HI23JwFB7LT6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ki9Ly2I17JqvfHtT9RHEyv92O0rFsOjs8eDP3o2/BGTxMObJIPpQZgeqVnU/Vn8VT
         +qrGnD6sUvLGN1MjXJtGByEvIB0XWyBMMCbt0IuJN1hocwlnH54YS62IhyT+LYf+is
         01mlP/9fWSPpl+j6bDoLXjDXLRZzJ8Df5WNTKDDE=
Date:   Tue, 21 Jun 2022 13:53:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, david@redhat.com, mike.kravetz@oracle.com,
        osalvador@suse.de, paulmck@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v5 0/2] make hugetlb_optimize_vmemmap compatible with
 memmap_on_memory
Message-Id: <20220621135313.ae6fbc28338f1220328694f7@linux-foundation.org>
In-Reply-To: <20220620110616.12056-1-songmuchun@bytedance.com>
References: <20220620110616.12056-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 19:06:14 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> This series makes hugetlb_optimize_vmemmap compatible with memmap_on_memory
> and is based on mm-stable.  The reason refers to the patch 2's commit log.
> 
> v5:
>  - Replace enum to defines per David.
>  - Walk vmemmap page tables to avoid false-positive.

I can't see this second change in the v3->v5 deltas?



From: Muchun Song <songmuchun@bytedance.com>
Subject: mm-memory_hotplug-enumerate-all-supported-section-flags-v5
Date: Mon, 20 Jun 2022 19:06:15 +0800

replace enum with defines per David
 
Link: https://lkml.kernel.org/r/20220620110616.12056-2-songmuchun@bytedance.com
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/mmzone.h |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/include/linux/mmzone.h~mm-memory_hotplug-enumerate-all-supported-section-flags-v5
+++ a/include/linux/mmzone.h
@@ -1439,16 +1439,13 @@ enum {
 	SECTION_MAP_LAST_BIT,
 };
 
-enum {
-	SECTION_MARKED_PRESENT		= BIT(SECTION_MARKED_PRESENT_BIT),
-	SECTION_HAS_MEM_MAP		= BIT(SECTION_HAS_MEM_MAP_BIT),
-	SECTION_IS_ONLINE		= BIT(SECTION_IS_ONLINE_BIT),
-	SECTION_IS_EARLY		= BIT(SECTION_IS_EARLY_BIT),
+#define SECTION_MARKED_PRESENT		BIT(SECTION_MARKED_PRESENT_BIT)
+#define SECTION_HAS_MEM_MAP		BIT(SECTION_HAS_MEM_MAP_BIT)
+#define SECTION_IS_ONLINE		BIT(SECTION_IS_ONLINE_BIT)
+#define SECTION_IS_EARLY		BIT(SECTION_IS_EARLY_BIT)
 #ifdef CONFIG_ZONE_DEVICE
-	SECTION_TAINT_ZONE_DEVICE	= BIT(SECTION_TAINT_ZONE_DEVICE_BIT),
+#define SECTION_TAINT_ZONE_DEVICE	BIT(SECTION_TAINT_ZONE_DEVICE_BIT)
 #endif
-};
-
 #define SECTION_MAP_MASK		(~(BIT(SECTION_MAP_LAST_BIT) - 1))
 #define SECTION_NID_SHIFT		SECTION_MAP_LAST_BIT
 
_




From: Muchun Song <songmuchun@bytedance.com>
Subject: mm-memory_hotplug-make-hugetlb_optimize_vmemmap-compatible-with-memmap_on_memory-v5
Date: Mon, 20 Jun 2022 19:06:16 +0800

walk vmemmap page tables to avoid false-positive

Link: https://lkml.kernel.org/r/20220620110616.12056-3-songmuchun@bytedance.com
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Co-developed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/hugetlb_vmemmap.c |   69 ++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 25 deletions(-)

--- a/mm/hugetlb_vmemmap.c~mm-memory_hotplug-make-hugetlb_optimize_vmemmap-compatible-with-memmap_on_memory-v5
+++ a/mm/hugetlb_vmemmap.c
@@ -10,6 +10,7 @@
  */
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
+#include <linux/memory.h>
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -99,34 +100,52 @@ int hugetlb_vmemmap_alloc(struct hstate
 static unsigned int vmemmap_optimizable_pages(struct hstate *h,
 					      struct page *head)
 {
-	struct mem_section *ms;
-	struct page *vmemmap_page;
-	unsigned long pfn = page_to_pfn(head);
-
 	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
 		return 0;
 
-	ms = __pfn_to_section(pfn);
-	vmemmap_page = sparse_decode_mem_map(ms->section_mem_map,
-					     pfn_to_section_nr(pfn));
-	/*
-	 * Only the vmemmap pages' vmemmap may be marked as VmemmapSelfHosted.
-	 *
-	 * Due to HugeTLB alignment requirements, and the vmemmap pages being
-	 * at the start of the hotplugged memory region. Checking any vmemmap
-	 * page's vmemmap is fine.
-	 *
-	 * [      hotplugged memory     ]
-	 * [ vmemmap ][  usable memory  ]
-	 *   ^   |      |            |
-	 *   +---+      |            |
-	 *     ^        |            |
-	 *     +--------+            |
-	 *         ^                 |
-	 *         +-----------------+
-	 */
-	if (PageVmemmapSelfHosted(vmemmap_page))
-		return 0;
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
+		pmd_t *pmdp, pmd;
+		struct page *vmemmap_page;
+		unsigned long vaddr = (unsigned long)head;
+
+		/*
+		 * Only the vmemmap page's vmemmap page can be self-hosted.
+		 * Walking the page tables to find the backing page of the
+		 * vmemmap page.
+		 */
+		pmdp = pmd_off_k(vaddr);
+		/*
+		 * The READ_ONCE() is used to stabilize *pmdp in a register or
+		 * on the stack so that it will stop changing under the code.
+		 * The only concurrent operation where it can be changed is
+		 * split_vmemmap_huge_pmd() (*pmdp will be stable after this
+		 * operation).
+		 */
+		pmd = READ_ONCE(*pmdp);
+		if (pmd_leaf(pmd))
+			vmemmap_page = pmd_page(pmd) + pte_index(vaddr);
+		else
+			vmemmap_page = pte_page(*pte_offset_kernel(pmdp, vaddr));
+		/*
+		 * Due to HugeTLB alignment requirements and the vmemmap pages
+		 * being at the start of the hotplugged memory region in
+		 * memory_hotplug.memmap_on_memory case. Checking any vmemmap
+		 * page's vmemmap page if it is marked as VmemmapSelfHosted is
+		 * sufficient.
+		 *
+		 * [                  hotplugged memory                  ]
+		 * [        section        ][...][        section        ]
+		 * [ vmemmap ][              usable memory               ]
+		 *   ^   |     |                                        |
+		 *   +---+     |                                        |
+		 *     ^       |                                        |
+		 *     +-------+                                        |
+		 *          ^                                           |
+		 *          +-------------------------------------------+
+		 */
+		if (PageVmemmapSelfHosted(vmemmap_page))
+			return 0;
+	}
 
 	return hugetlb_optimize_vmemmap_pages(h);
 }
_

