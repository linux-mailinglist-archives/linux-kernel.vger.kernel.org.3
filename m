Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53716464112
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344726AbhK3WON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:14:13 -0500
Received: from out1.migadu.com ([91.121.223.63]:58389 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344615AbhK3WLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:11:37 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638310094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNHQ9BiBKyIqAtWVImrJMYlD8BjFZxN/2CktLIPvhw0=;
        b=e5hYOgE63daSzhorQx9xqkB3uU5LgMm60aa/Hr6EXq7ubqpCA73UnpNNs4TkF1qZhJ3UKg
        XPKKCif92EXNbK4AEx7/5+wTtt3Fyt49dD0+4BfOZ+Q54Mx3TIUEnFgRjqn7VBjPAzBuyi
        lH0orqEWB5TuHTmUnamwQqlsfWyAH2M=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 27/31] kasan, vmalloc: add vmalloc support to HW_TAGS
Date:   Tue, 30 Nov 2021 23:08:12 +0100
Message-Id: <aa90926d11b5977402af4ce6dccea89932006d36.1638308023.git.andreyknvl@google.com>
In-Reply-To: <cover.1638308023.git.andreyknvl@google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

This patch adds vmalloc tagging support to HW_TAGS KASAN.

The key difference between HW_TAGS and the other two KASAN modes
when it comes to vmalloc: HW_TAGS KASAN can only assign tags to
physical memory. The other two modes have shadow memory covering
every mapped virtual memory region.

This patch makes __kasan_unpoison_vmalloc() for HW_TAGS KASAN:

- Skip non-VM_ALLOC mappings as HW_TAGS KASAN can only tag a single
  mapping of normal physical memory; see the comment in the function.
- Generate a random tag, tag the returned pointer and the allocation.
- Propagate the tag into the page stucts to allow accesses through
  page_address(vmalloc_to_page()).

The rest of vmalloc-related KASAN hooks are not needed:

- The shadow-related ones are fully skipped.
- __kasan_poison_vmalloc() is kept as a no-op with a comment.

Poisoning of physical pages that are backing vmalloc() allocations
is skipped via __GFP_SKIP_KASAN_UNPOISON: __kasan_unpoison_vmalloc()
poisons them instead.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/kasan.h | 27 +++++++++++--
 mm/kasan/hw_tags.c    | 92 +++++++++++++++++++++++++++++++++++++++++++
 mm/kasan/shadow.c     |  8 +++-
 mm/vmalloc.c          | 25 +++++++++---
 4 files changed, 143 insertions(+), 9 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 6a2619759e93..df1a09fb7623 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -417,19 +417,40 @@ static inline void kasan_init_hw_tags(void) { }
 
 #ifdef CONFIG_KASAN_VMALLOC
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+
 void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
 int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end);
 
+#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+static inline void kasan_populate_early_vm_area_shadow(void *start,
+						       unsigned long size)
+{ }
+static inline int kasan_populate_vmalloc(unsigned long start,
+					unsigned long size)
+{
+	return 0;
+}
+static inline void kasan_release_vmalloc(unsigned long start,
+					 unsigned long end,
+					 unsigned long free_region_start,
+					 unsigned long free_region_end) { }
+
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
 void * __must_check __kasan_unpoison_vmalloc(const void *start,
-					     unsigned long size);
+					     unsigned long size,
+					     bool vm_alloc);
 static __always_inline void * __must_check kasan_unpoison_vmalloc(
-					const void *start, unsigned long size)
+					const void *start, unsigned long size,
+					bool vm_alloc)
 {
 	if (kasan_enabled())
-		return __kasan_unpoison_vmalloc(start, size);
+		return __kasan_unpoison_vmalloc(start, size, vm_alloc);
 	return (void *)start;
 }
 
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 76cf2b6229c7..fd3a93dfca42 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -192,6 +192,98 @@ void __init kasan_init_hw_tags(void)
 		kasan_stack_collection_enabled() ? "on" : "off");
 }
 
+#ifdef CONFIG_KASAN_VMALLOC
+
+static void unpoison_vmalloc_pages(const void *addr, u8 tag)
+{
+	struct vm_struct *area;
+	int i;
+
+	/*
+	 * As hardware tag-based KASAN only tags VM_ALLOC vmalloc allocations
+	 * (see the comment in __kasan_unpoison_vmalloc), all of the pages
+	 * should belong to a single area.
+	 */
+	area = find_vm_area((void *)addr);
+	if (WARN_ON(!area))
+		return;
+
+	for (i = 0; i < area->nr_pages; i++) {
+		struct page *page = area->pages[i];
+
+		page_kasan_tag_set(page, tag);
+	}
+}
+
+void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
+				bool vm_alloc)
+{
+	u8 tag;
+	unsigned long redzone_start, redzone_size;
+
+	if (!is_vmalloc_or_module_addr(start))
+		return (void *)start;
+
+	/* Unpoisoning and pointer tag assignment is skipped for non-VM_ALLOC
+	 * mappings as:
+	 *
+	 * 1. Unlike the software KASAN modes, hardware tag-based KASAN only
+	 *    supports tagging physical memory. Therefore, it can only tag a
+	 *    single mapping of normal physical pages.
+	 * 2. Hardware tag-based KASAN can only tag memory mapped with special
+	 *    mapping protection bits, see arch_vmalloc_pgprot_modify().
+	 *    As non-VM_ALLOC mappings can be mapped outside of vmalloc code,
+	 *    providing these bits would require tracking all non-VM_ALLOC
+	 *    mappers.
+	 *
+	 * Thus, for VM_ALLOC mappings, hardware tag-based KASAN only tags
+	 * the first virtual mapping, which is created by vmalloc().
+	 * Tagging the page_alloc memory backing that vmalloc() allocation is
+	 * skipped, see ___GFP_SKIP_KASAN_UNPOISON.
+	 *
+	 * For non-VM_ALLOC allocations, page_alloc memory is tagged as usual.
+	 */
+	if (!vm_alloc)
+		return (void *)start;
+
+	tag = kasan_random_tag();
+	start = set_tag(start, tag);
+
+	/*
+	 * Unpoison but don't initialize. The pages have already been
+	 * initialized by page_alloc.
+	 */
+	kasan_unpoison(start, size, false);
+
+	/*
+	 * Unlike software KASAN modes, hardware tag-based KASAN doesn't
+	 * unpoison memory when populating shadow for vmalloc() space.
+	 * Thus, it needs to explicitly poison the in-page vmalloc() redzone.
+	 */
+	redzone_start = round_up((unsigned long)start + size, KASAN_GRANULE_SIZE);
+	redzone_size = round_up(redzone_start, PAGE_SIZE) - redzone_start;
+	kasan_poison((void *)redzone_start, redzone_size, KASAN_TAG_INVALID, false);
+
+	/*
+	 * Set per-page tag flags to allow accessing physical memory for the
+	 * vmalloc() mapping through page_address(vmalloc_to_page()).
+	 */
+	unpoison_vmalloc_pages(start, tag);
+
+	return (void *)start;
+}
+
+void __kasan_poison_vmalloc(const void *start, unsigned long size)
+{
+	/*
+	 * No tagging here.
+	 * The physical pages backing the vmalloc() allocation are poisoned
+	 * through the usual page_alloc paths.
+	 */
+}
+
+#endif
+
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
 void kasan_enable_tagging_sync(void)
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 4ca280a96fbc..f27d48c24166 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -475,8 +475,14 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	}
 }
 
-void *__kasan_unpoison_vmalloc(const void *start, unsigned long size)
+void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
+				bool vm_alloc)
 {
+	/*
+	 * As software tag-based KASAN tags both VM_ALLOC and non-VM_ALLOC
+	 * mappings, the vm_alloc argument is ignored.
+	 */
+
 	if (!is_vmalloc_or_module_addr(start))
 		return (void *)start;
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 82ef1e27e2e4..409a289dec81 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2214,8 +2214,12 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		return NULL;
 	}
 
-	/* Mark the pages as accessible after they were mapped in. */
-	mem = kasan_unpoison_vmalloc(mem, size);
+	/*
+	 * Mark the pages as accessible after they were mapped in.
+	 * With hardware tag-based KASAN, marking is skipped for
+	 * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc().
+	 */
+	mem = kasan_unpoison_vmalloc(mem, size, false);
 
 	return mem;
 }
@@ -2449,9 +2453,12 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 	 * accessible after they are mapped in.
 	 * Otherwise, as the pages can be mapped outside of vmalloc code,
 	 * mark them now as a best-effort approach.
+	 * With hardware tag-based KASAN, marking is skipped for
+	 * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc().
 	 */
 	if (!(flags & VM_ALLOC))
-		area->addr = kasan_unpoison_vmalloc(area->addr, requested_size);
+		area->addr = kasan_unpoison_vmalloc(area->addr, requested_size,
+							false);
 
 	return area;
 }
@@ -2849,6 +2856,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	struct page *page;
 	int i;
 
+	/*
+	 * Skip page_alloc poisoning for pages backing VM_ALLOC mappings,
+	 * see __kasan_unpoison_vmalloc. Only effective in HW_TAGS mode.
+	 */
+	gfp &= __GFP_SKIP_KASAN_UNPOISON;
+
 	/*
 	 * For order-0 pages we make use of bulk allocator, if
 	 * the page array is partly or not at all populated due
@@ -3084,7 +3097,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	 * Mark the pages for VM_ALLOC mappings as accessible after they were
 	 * mapped in.
 	 */
-	addr = kasan_unpoison_vmalloc(addr, real_size);
+	addr = kasan_unpoison_vmalloc(addr, real_size, true);
 
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
@@ -3784,10 +3797,12 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	 * Mark allocated areas as accessible.
 	 * As the pages are mapped outside of vmalloc code,
 	 * mark them now as a best-effort approach.
+	 * With hardware tag-based KASAN, marking is skipped for
+	 * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc().
 	 */
 	for (area = 0; area < nr_vms; area++)
 		vms[area]->addr = kasan_unpoison_vmalloc(vms[area]->addr,
-							 vms[area]->size);
+							 vms[area]->size, false);
 
 	kfree(vas);
 	return vms;
-- 
2.25.1

