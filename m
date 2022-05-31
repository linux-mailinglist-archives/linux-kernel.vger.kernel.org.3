Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E0539431
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345853AbiEaPoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345829AbiEaPoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:44:01 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD878CB13
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:43:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654011835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKpEOAmZCRxRoXVhww36jQag5lkjQ3WmgRmPB/KuwNI=;
        b=c59EypVaB2zGdyrfSQ3HAwEl/BbwwaHxKd6DMjfYAuxMDrVsjyp1KGSo7WhJqfW6IYPp6I
        nE5jgnW5onO5dZuSkd1dI8hDnO24eKUJ73YEjDmcQQdIioGGMDovkWpOGVEvzdT69vuU31
        +wPU4O05ZwI8fcXCG1DNNAShs/eTc1I=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 3/3] kasan: fix zeroing vmalloc memory with HW_TAGS
Date:   Tue, 31 May 2022 17:43:50 +0200
Message-Id: <bbc30451228f670abeaf1b8aad678b9f6dda4ad3.1654011120.git.andreyknvl@google.com>
In-Reply-To: <4c76a95aff79723de76df146a10888a5a9196faf.1654011120.git.andreyknvl@google.com>
References: <4c76a95aff79723de76df146a10888a5a9196faf.1654011120.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

HW_TAGS KASAN skips zeroing page_alloc allocations backing vmalloc
mappings via __GFP_SKIP_ZERO. Instead, these pages are zeroed via
kasan_unpoison_vmalloc() by passing the KASAN_VMALLOC_INIT flag.

The problem is that __kasan_unpoison_vmalloc() does not zero pages
when either kasan_vmalloc_enabled() or is_vmalloc_or_module_addr() fail.

Thus:

1. Change __vmalloc_node_range() to only set KASAN_VMALLOC_INIT when
   __GFP_SKIP_ZERO is set.

2. Change __kasan_unpoison_vmalloc() to always zero pages when the
   KASAN_VMALLOC_INIT flag is set.

3. Add WARN_ON() asserts to check that KASAN_VMALLOC_INIT cannot be set
   in other early return paths of __kasan_unpoison_vmalloc().

Also clean up the comment in __kasan_unpoison_vmalloc.

Fixes: 23689e91fb22 ("kasan, vmalloc: add vmalloc tagging for HW_TAGS")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/hw_tags.c | 30 ++++++++++++++++++++++--------
 mm/vmalloc.c       | 10 +++++-----
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 9e1b6544bfa8..c0ec01eadf20 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -263,21 +263,31 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	u8 tag;
 	unsigned long redzone_start, redzone_size;
 
-	if (!kasan_vmalloc_enabled())
-		return (void *)start;
+	if (!kasan_vmalloc_enabled() || !is_vmalloc_or_module_addr(start)) {
+		struct page *page;
+		const void *addr;
+
+		/* Initialize memory if required. */
+
+		if (!(flags & KASAN_VMALLOC_INIT))
+			return (void *)start;
+
+		for (addr = start; addr < start + size; addr += PAGE_SIZE) {
+			page = virt_to_page(addr);
+			clear_highpage_tagged(page);
+		}
 
-	if (!is_vmalloc_or_module_addr(start))
 		return (void *)start;
+	}
 
 	/*
-	 * Skip unpoisoning and assigning a pointer tag for non-VM_ALLOC
-	 * mappings as:
+	 * Don't tag non-VM_ALLOC mappings, as:
 	 *
 	 * 1. Unlike the software KASAN modes, hardware tag-based KASAN only
 	 *    supports tagging physical memory. Therefore, it can only tag a
 	 *    single mapping of normal physical pages.
 	 * 2. Hardware tag-based KASAN can only tag memory mapped with special
-	 *    mapping protection bits, see arch_vmalloc_pgprot_modify().
+	 *    mapping protection bits, see arch_vmap_pgprot_tagged().
 	 *    As non-VM_ALLOC mappings can be mapped outside of vmalloc code,
 	 *    providing these bits would require tracking all non-VM_ALLOC
 	 *    mappers.
@@ -289,15 +299,19 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	 *
 	 * For non-VM_ALLOC allocations, page_alloc memory is tagged as usual.
 	 */
-	if (!(flags & KASAN_VMALLOC_VM_ALLOC))
+	if (!(flags & KASAN_VMALLOC_VM_ALLOC)) {
+		WARN_ON(flags & KASAN_VMALLOC_INIT);
 		return (void *)start;
+	}
 
 	/*
 	 * Don't tag executable memory.
 	 * The kernel doesn't tolerate having the PC register tagged.
 	 */
-	if (!(flags & KASAN_VMALLOC_PROT_NORMAL))
+	if (!(flags & KASAN_VMALLOC_PROT_NORMAL)) {
+		WARN_ON(flags & KASAN_VMALLOC_INIT);
 		return (void *)start;
+	}
 
 	tag = kasan_random_tag();
 	start = set_tag(start, tag);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 07db42455dd4..0adf4aa1514d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3168,15 +3168,15 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 
 	/*
 	 * Mark the pages as accessible, now that they are mapped.
-	 * The init condition should match the one in post_alloc_hook()
-	 * (except for the should_skip_init() check) to make sure that memory
-	 * is initialized under the same conditions regardless of the enabled
-	 * KASAN mode.
+	 * The condition for setting KASAN_VMALLOC_INIT should complement the
+	 * one in post_alloc_hook() with regards to the __GFP_SKIP_ZERO check
+	 * to make sure that memory is initialized under the same conditions.
 	 * Tag-based KASAN modes only assign tags to normal non-executable
 	 * allocations, see __kasan_unpoison_vmalloc().
 	 */
 	kasan_flags |= KASAN_VMALLOC_VM_ALLOC;
-	if (!want_init_on_free() && want_init_on_alloc(gfp_mask))
+	if (!want_init_on_free() && want_init_on_alloc(gfp_mask) &&
+	    (gfp_mask & __GFP_SKIP_ZERO))
 		kasan_flags |= KASAN_VMALLOC_INIT;
 	/* KASAN_VMALLOC_PROT_NORMAL already set if required. */
 	area->addr = kasan_unpoison_vmalloc(area->addr, real_size, kasan_flags);
-- 
2.25.1

