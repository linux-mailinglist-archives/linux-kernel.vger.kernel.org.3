Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BB04987D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245023AbiAXSHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:07:44 -0500
Received: from out0.migadu.com ([94.23.1.103]:19450 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235662AbiAXSH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:07:28 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643047647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KUJZNJV1O4hNGiPaFWjJZ6YP4SR64jSFKwdeaC+81U=;
        b=fR9nfxovI5mUNUsCx+1176TEHlvQs8TLQ6uwZ+x2GptsqtdAOJTUX+mGMICbNPu6IkO/rS
        F2jHs8qBxY5vQVs1WqVr5EGEdOK7jGXkvDhXbP/GNitO5hdpRQO6cGvQmkpMhKmQbC0yBq
        43z/GcU6rw7HTTFiXhVL6P/JTUdnFnA=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
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
Subject: [PATCH v6 31/39] kasan, vmalloc: only tag normal vmalloc allocations
Date:   Mon, 24 Jan 2022 19:05:05 +0100
Message-Id: <fbfd9939a4dc375923c9a5c6b9e7ab05c26b8c6b.1643047180.git.andreyknvl@google.com>
In-Reply-To: <cover.1643047180.git.andreyknvl@google.com>
References: <cover.1643047180.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

The kernel can use to allocate executable memory. The only supported way
to do that is via __vmalloc_node_range() with the executable bit set in
the prot argument. (vmap() resets the bit via pgprot_nx()).

Once tag-based KASAN modes start tagging vmalloc allocations, executing
code from such allocations will lead to the PC register getting a tag,
which is not tolerated by the kernel.

Only tag the allocations for normal kernel pages.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v3->v4:
- Rename KASAN_VMALLOC_NOEXEC to KASAN_VMALLOC_PROT_NORMAL.
- Compare with PAGE_KERNEL instead of using pgprot_nx().
- Update patch description.

Changes v2->v3:
- Add this patch.
---
 include/linux/kasan.h |  7 ++++---
 mm/kasan/hw_tags.c    |  7 +++++++
 mm/kasan/shadow.c     |  7 +++++++
 mm/vmalloc.c          | 49 +++++++++++++++++++++++++------------------
 4 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 499f1573dba4..3593c95d1fa5 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -27,9 +27,10 @@ struct kunit_kasan_expectation {
 
 typedef unsigned int __bitwise kasan_vmalloc_flags_t;
 
-#define KASAN_VMALLOC_NONE	0x00u
-#define KASAN_VMALLOC_INIT	0x01u
-#define KASAN_VMALLOC_VM_ALLOC	0x02u
+#define KASAN_VMALLOC_NONE		0x00u
+#define KASAN_VMALLOC_INIT		0x01u
+#define KASAN_VMALLOC_VM_ALLOC		0x02u
+#define KASAN_VMALLOC_PROT_NORMAL	0x04u
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 21104fd51872..2e9378a4f07f 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -247,6 +247,13 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	if (!(flags & KASAN_VMALLOC_VM_ALLOC))
 		return (void *)start;
 
+	/*
+	 * Don't tag executable memory.
+	 * The kernel doesn't tolerate having the PC register tagged.
+	 */
+	if (!(flags & KASAN_VMALLOC_PROT_NORMAL))
+		return (void *)start;
+
 	tag = kasan_random_tag();
 	start = set_tag(start, tag);
 
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index b958babc8fed..7272e248db87 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -488,6 +488,13 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	if (!is_vmalloc_or_module_addr(start))
 		return (void *)start;
 
+	/*
+	 * Don't tag executable memory.
+	 * The kernel doesn't tolerate having the PC register tagged.
+	 */
+	if (!(flags & KASAN_VMALLOC_PROT_NORMAL))
+		return (void *)start;
+
 	start = set_tag(start, kasan_random_tag());
 	kasan_unpoison(start, size, false);
 	return (void *)start;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6dcdf815576b..375b53fd939f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2221,7 +2221,7 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 	 * With hardware tag-based KASAN, marking is skipped for
 	 * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc().
 	 */
-	mem = kasan_unpoison_vmalloc(mem, size, KASAN_VMALLOC_NONE);
+	mem = kasan_unpoison_vmalloc(mem, size, KASAN_VMALLOC_PROT_NORMAL);
 
 	return mem;
 }
@@ -2460,7 +2460,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 	 */
 	if (!(flags & VM_ALLOC))
 		area->addr = kasan_unpoison_vmalloc(area->addr, requested_size,
-							KASAN_VMALLOC_NONE);
+						    KASAN_VMALLOC_PROT_NORMAL);
 
 	return area;
 }
@@ -3071,7 +3071,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 {
 	struct vm_struct *area;
 	void *ret;
-	kasan_vmalloc_flags_t kasan_flags;
+	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_NONE;
 	unsigned long real_size = size;
 	unsigned long real_align = align;
 	unsigned int shift = PAGE_SHIFT;
@@ -3124,21 +3124,28 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		goto fail;
 	}
 
-	/* Prepare arguments for __vmalloc_area_node(). */
-	if (kasan_hw_tags_enabled() &&
-	    pgprot_val(prot) == pgprot_val(PAGE_KERNEL)) {
-		/*
-		 * Modify protection bits to allow tagging.
-		 * This must be done before mapping in __vmalloc_area_node().
-		 */
-		prot = arch_vmap_pgprot_tagged(prot);
+	/*
+	 * Prepare arguments for __vmalloc_area_node() and
+	 * kasan_unpoison_vmalloc().
+	 */
+	if (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)) {
+		if (kasan_hw_tags_enabled()) {
+			/*
+			 * Modify protection bits to allow tagging.
+			 * This must be done before mapping.
+			 */
+			prot = arch_vmap_pgprot_tagged(prot);
 
-		/*
-		 * Skip page_alloc poisoning and zeroing for physical pages
-		 * backing VM_ALLOC mapping. Memory is instead poisoned and
-		 * zeroed by kasan_unpoison_vmalloc().
-		 */
-		gfp_mask |= __GFP_SKIP_KASAN_UNPOISON | __GFP_SKIP_ZERO;
+			/*
+			 * Skip page_alloc poisoning and zeroing for physical
+			 * pages backing VM_ALLOC mapping. Memory is instead
+			 * poisoned and zeroed by kasan_unpoison_vmalloc().
+			 */
+			gfp_mask |= __GFP_SKIP_KASAN_UNPOISON | __GFP_SKIP_ZERO;
+		}
+
+		/* Take note that the mapping is PAGE_KERNEL. */
+		kasan_flags |= KASAN_VMALLOC_PROT_NORMAL;
 	}
 
 	/* Allocate physical pages and map them into vmalloc space. */
@@ -3152,10 +3159,13 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	 * (except for the should_skip_init() check) to make sure that memory
 	 * is initialized under the same conditions regardless of the enabled
 	 * KASAN mode.
+	 * Tag-based KASAN modes only assign tags to normal non-executable
+	 * allocations, see __kasan_unpoison_vmalloc().
 	 */
-	kasan_flags = KASAN_VMALLOC_VM_ALLOC;
+	kasan_flags |= KASAN_VMALLOC_VM_ALLOC;
 	if (!want_init_on_free() && want_init_on_alloc(gfp_mask))
 		kasan_flags |= KASAN_VMALLOC_INIT;
+	/* KASAN_VMALLOC_PROT_NORMAL already set if required. */
 	area->addr = kasan_unpoison_vmalloc(area->addr, real_size, kasan_flags);
 
 	/*
@@ -3861,8 +3871,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	 */
 	for (area = 0; area < nr_vms; area++)
 		vms[area]->addr = kasan_unpoison_vmalloc(vms[area]->addr,
-							 vms[area]->size,
-							 KASAN_VMALLOC_NONE);
+				vms[area]->size, KASAN_VMALLOC_PROT_NORMAL);
 
 	kfree(vas);
 	return vms;
-- 
2.25.1

