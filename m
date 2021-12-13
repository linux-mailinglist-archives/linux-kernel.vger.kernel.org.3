Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C204736FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbhLMVy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243324AbhLMVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:54:58 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B52BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:54:57 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639432496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYiuCpANmF2hofVD+qkF0AskHe4DKzJGyvoujTMdBZA=;
        b=o4YA6eJprrCL4lY7eTsrQrWx9M90h4bNBITLO5GNivbTnvygCpUFmtSALVdpcFPDFsgRLh
        6/HQ8OUSfY1TWdX4vS/BDpNH/OWFNi1YceZOjCwg7vxvoS22U9rC95Dkh4w9VC4oAnoWZS
        375KpV8kZQWEua8WwoJArBRyf7ATNtM=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v3 29/38] kasan, vmalloc: add vmalloc tagging for HW_TAGS
Date:   Mon, 13 Dec 2021 22:54:25 +0100
Message-Id: <af3819749624603ed5cb0cbd869d5e4b3ed116b3.1639432170.git.andreyknvl@google.com>
In-Reply-To: <cover.1639432170.git.andreyknvl@google.com>
References: <cover.1639432170.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: andrey.konovalov@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add vmalloc tagging support to HW_TAGS KASAN.

The key difference between HW_TAGS and the other two KASAN modes
when it comes to vmalloc: HW_TAGS KASAN can only assign tags to
physical memory. The other two modes have shadow memory covering
every mapped virtual memory region.

Make __kasan_unpoison_vmalloc() for HW_TAGS KASAN:

- Skip non-VM_ALLOC mappings as HW_TAGS KASAN can only tag a single
  mapping of normal physical memory; see the comment in the function.
- Generate a random tag, tag the returned pointer and the allocation,
  and initialize the allocation at the same time.
- Propagate the tag into the page stucts to allow accesses through
  page_address(vmalloc_to_page()).

The rest of vmalloc-related KASAN hooks are not needed:

- The shadow-related ones are fully skipped.
- __kasan_poison_vmalloc() is kept as a no-op with a comment.

Poisoning and zeroing of physical pages that are backing vmalloc()
allocations are skipped via __GFP_SKIP_KASAN_UNPOISON and
__GFP_SKIP_ZERO: __kasan_unpoison_vmalloc() does that instead.

Enabling CONFIG_KASAN_VMALLOC with HW_TAGS is not yet allowed.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

---

Changes v2->v3:
- Switch kasan_unpoison_vmalloc() to using a single flags argument.
- Update kasan_unpoison_vmalloc() arguments in kernel/scs.c.
- Move allowing enabling KASAN_VMALLOC with SW_TAGS into a separate
  patch.
- Minor comments fixes.
- Update patch description.

Changes v1->v2:
- Allow enabling CONFIG_KASAN_VMALLOC with HW_TAGS in this patch.
- Move memory init for page_alloc pages backing vmalloc() into
  kasan_unpoison_vmalloc().
---
 include/linux/kasan.h | 36 +++++++++++++++--
 kernel/scs.c          |  4 +-
 mm/kasan/hw_tags.c    | 91 +++++++++++++++++++++++++++++++++++++++++++
 mm/kasan/shadow.c     | 10 ++++-
 mm/vmalloc.c          | 34 +++++++++++++---
 5 files changed, 163 insertions(+), 12 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 92c5dfa29a35..499f1573dba4 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -25,6 +25,12 @@ struct kunit_kasan_expectation {
 
 #endif
 
+typedef unsigned int __bitwise kasan_vmalloc_flags_t;
+
+#define KASAN_VMALLOC_NONE	0x00u
+#define KASAN_VMALLOC_INIT	0x01u
+#define KASAN_VMALLOC_VM_ALLOC	0x02u
+
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 #include <linux/pgtable.h>
@@ -418,18 +424,39 @@ static inline void kasan_init_hw_tags(void) { }
 
 #ifdef CONFIG_KASAN_VMALLOC
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+
 void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
 int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end);
 
-void *__kasan_unpoison_vmalloc(const void *start, unsigned long size);
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
+void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
+			       kasan_vmalloc_flags_t flags);
 static __always_inline void *kasan_unpoison_vmalloc(const void *start,
-						    unsigned long size)
+						unsigned long size,
+						kasan_vmalloc_flags_t flags)
 {
 	if (kasan_enabled())
-		return __kasan_unpoison_vmalloc(start, size);
+		return __kasan_unpoison_vmalloc(start, size, flags);
 	return (void *)start;
 }
 
@@ -456,7 +483,8 @@ static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long free_region_end) { }
 
 static inline void *kasan_unpoison_vmalloc(const void *start,
-					   unsigned long size)
+					   unsigned long size,
+					   kasan_vmalloc_flags_t flags)
 {
 	return (void *)start;
 }
diff --git a/kernel/scs.c b/kernel/scs.c
index 579841be8864..b83bc9251f99 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -32,7 +32,7 @@ static void *__scs_alloc(int node)
 	for (i = 0; i < NR_CACHED_SCS; i++) {
 		s = this_cpu_xchg(scs_cache[i], NULL);
 		if (s) {
-			kasan_unpoison_vmalloc(s, SCS_SIZE);
+			kasan_unpoison_vmalloc(s, SCS_SIZE, KASAN_VMALLOC_NONE);
 			memset(s, 0, SCS_SIZE);
 			return s;
 		}
@@ -78,7 +78,7 @@ void scs_free(void *s)
 		if (this_cpu_cmpxchg(scs_cache[i], 0, s) == NULL)
 			return;
 
-	kasan_unpoison_vmalloc(s, SCS_SIZE);
+	kasan_unpoison_vmalloc(s, SCS_SIZE, KASAN_VMALLOC_NONE);
 	vfree_atomic(s);
 }
 
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 76cf2b6229c7..de564a6187e1 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -192,6 +192,97 @@ void __init kasan_init_hw_tags(void)
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
+				kasan_vmalloc_flags_t flags)
+{
+	u8 tag;
+	unsigned long redzone_start, redzone_size;
+
+	if (!is_vmalloc_or_module_addr(start))
+		return (void *)start;
+
+	/* Skip unpoisoning and assigning a pointer tag for non-VM_ALLOC
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
+	if (!(flags & KASAN_VMALLOC_VM_ALLOC))
+		return (void *)start;
+
+	tag = kasan_random_tag();
+	start = set_tag(start, tag);
+
+	/* Unpoison and initialize memory up to size. */
+	kasan_unpoison(start, size, flags & KASAN_VMALLOC_INIT);
+
+	/*
+	 * Explicitly poison and initialize the in-page vmalloc() redzone.
+	 * Unlike software KASAN modes, hardware tag-based KASAN doesn't
+	 * unpoison memory when populating shadow for vmalloc() space.
+	 */
+	redzone_start = round_up((unsigned long)start + size,
+				 KASAN_GRANULE_SIZE);
+	redzone_size = round_up(redzone_start, PAGE_SIZE) - redzone_start;
+	kasan_poison((void *)redzone_start, redzone_size, KASAN_TAG_INVALID,
+		     flags & KASAN_VMALLOC_INIT);
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
index 5a866f6663fc..b958babc8fed 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -475,8 +475,16 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	}
 }
 
-void *__kasan_unpoison_vmalloc(const void *start, unsigned long size)
+void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
+			       kasan_vmalloc_flags_t flags)
 {
+	/*
+	 * Software KASAN modes unpoison both VM_ALLOC and non-VM_ALLOC
+	 * mappings, so the KASAN_VMALLOC_VM_ALLOC flag is ignored.
+	 * Software KASAN modes can't optimize zeroing memory by combining it
+	 * with setting memory tags, so the KASAN_VMALLOC_INIT flag is ignored.
+	 */
+
 	if (!is_vmalloc_or_module_addr(start))
 		return (void *)start;
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9a6862e274df..4171778922cc 100644
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
+	mem = kasan_unpoison_vmalloc(mem, size, KASAN_VMALLOC_NONE);
 
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
+							KASAN_VMALLOC_NONE);
 
 	return area;
 }
@@ -2849,6 +2856,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	struct page *page;
 	int i;
 
+	/*
+	 * Skip page_alloc poisoning and zeroing for pages backing VM_ALLOC
+	 * mappings. Only effective in HW_TAGS mode.
+	 */
+	gfp &= __GFP_SKIP_KASAN_UNPOISON & __GFP_SKIP_ZERO;
+
 	/*
 	 * For order-0 pages we make use of bulk allocator, if
 	 * the page array is partly or not at all populated due
@@ -3054,6 +3067,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 {
 	struct vm_struct *area;
 	void *addr;
+	kasan_vmalloc_flags_t kasan_flags;
 	unsigned long real_size = size;
 	unsigned long real_align = align;
 	unsigned int shift = PAGE_SHIFT;
@@ -3115,8 +3129,15 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	/*
 	 * Mark the pages for VM_ALLOC mappings as accessible after they were
 	 * mapped in.
+	 * The init condition should match the one in post_alloc_hook()
+	 * (except for the should_skip_init() check) to make sure that memory
+	 * is initialized under the same conditions regardless of the enabled
+	 * KASAN mode.
 	 */
-	addr = kasan_unpoison_vmalloc(addr, real_size);
+	kasan_flags = KASAN_VMALLOC_VM_ALLOC;
+	if (!want_init_on_free() && want_init_on_alloc(gfp_mask))
+		kasan_flags |= KASAN_VMALLOC_INIT;
+	addr = kasan_unpoison_vmalloc(addr, real_size, kasan_flags);
 
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
@@ -3817,10 +3838,13 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	 * Mark allocated areas as accessible.
 	 * As the pages are mapped outside of vmalloc code,
 	 * mark them now as a best-effort approach.
+	 * With hardware tag-based KASAN, marking is skipped for
+	 * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc().
 	 */
 	for (area = 0; area < nr_vms; area++)
 		vms[area]->addr = kasan_unpoison_vmalloc(vms[area]->addr,
-							 vms[area]->size);
+							 vms[area]->size,
+							 KASAN_VMALLOC_NONE);
 
 	kfree(vas);
 	return vms;
-- 
2.25.1

