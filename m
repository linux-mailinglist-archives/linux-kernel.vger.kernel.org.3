Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8AA47B5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhLTWCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhLTWCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:02:20 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89441C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:02:20 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640037739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yh2u9z3tn4/Tg0QhiqtJYkJa7Ju7wNCufTpXT9TmOy4=;
        b=Gs3TUW08KtRSzewfSYJGF2P9fRS4hS4FJfWB160u0Z1edchW+lmsnK4yQ9IGmHdtS/nzUN
        Ni9DFZx9NBn8NTUmMAVXV99KplZRGaeemuhg5AXOvlATw31NuR/1v0jMHrqKHz7u2UYUyD
        evVJCf4Gly8pEyu7EUf2nMULeylNjaM=
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
Subject: [PATCH mm v4 26/39] kasan, vmalloc: unpoison VM_ALLOC pages after mapping
Date:   Mon, 20 Dec 2021 23:01:58 +0100
Message-Id: <516dc726dc6311d8bb9f1a90258190f628a3b636.1640036051.git.andreyknvl@google.com>
In-Reply-To: <cover.1640036051.git.andreyknvl@google.com>
References: <cover.1640036051.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Make KASAN unpoison vmalloc mappings after they have been mapped in
when it's possible: for vmalloc() (indentified via VM_ALLOC) and
vm_map_ram().

The reasons for this are:

- For vmalloc() and vm_map_ram(): pages don't get unpoisoned in case
  mapping them fails.
- For vmalloc(): HW_TAGS KASAN needs pages to be mapped to set tags via
  kasan_unpoison_vmalloc().

As a part of these changes, the return value of __vmalloc_node_range()
is changed to area->addr. This is a non-functional change, as
__vmalloc_area_node() returns area->addr anyway.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v3->v4:
- Don't forget to save tagged addr to vm_struct->addr for VM_ALLOC
  so that find_vm_area(addr)->addr == addr for vmalloc().
- Reword comments.
- Update patch description.

Changes v2->v3:
- Update patch description.
---
 mm/vmalloc.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 388a17c01376..cc23e181b0ec 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2209,14 +2209,15 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		mem = (void *)addr;
 	}
 
-	mem = kasan_unpoison_vmalloc(mem, size);
-
 	if (vmap_pages_range(addr, addr + size, PAGE_KERNEL,
 				pages, PAGE_SHIFT) < 0) {
 		vm_unmap_ram(mem, count);
 		return NULL;
 	}
 
+	/* Mark the pages as accessible, now that they are mapped. */
+	mem = kasan_unpoison_vmalloc(mem, size);
+
 	return mem;
 }
 EXPORT_SYMBOL(vm_map_ram);
@@ -2444,7 +2445,14 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 
 	setup_vmalloc_vm(area, va, flags, caller);
 
-	area->addr = kasan_unpoison_vmalloc(area->addr, requested_size);
+	/*
+	 * Mark pages for non-VM_ALLOC mappings as accessible. Do it now as a
+	 * best-effort approach, as they can be mapped outside of vmalloc code.
+	 * For VM_ALLOC mappings, the pages are marked as accessible after
+	 * getting mapped in __vmalloc_node_range().
+	 */
+	if (!(flags & VM_ALLOC))
+		area->addr = kasan_unpoison_vmalloc(area->addr, requested_size);
 
 	return area;
 }
@@ -3049,7 +3057,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			const void *caller)
 {
 	struct vm_struct *area;
-	void *addr;
+	void *ret;
 	unsigned long real_size = size;
 	unsigned long real_align = align;
 	unsigned int shift = PAGE_SHIFT;
@@ -3111,10 +3119,13 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		prot = arch_vmap_pgprot_tagged(prot);
 
 	/* Allocate physical pages and map them into vmalloc space. */
-	addr = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
-	if (!addr)
+	ret = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
+	if (!ret)
 		goto fail;
 
+	/* Mark the pages as accessible, now that they are mapped. */
+	area->addr = kasan_unpoison_vmalloc(area->addr, real_size);
+
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
 	 * flag. It means that vm_struct is not fully initialized.
@@ -3126,7 +3137,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	if (!(vm_flags & VM_DEFER_KMEMLEAK))
 		kmemleak_vmalloc(area, size, gfp_mask);
 
-	return addr;
+	return area->addr;
 
 fail:
 	if (shift > PAGE_SHIFT) {
@@ -3818,7 +3829,10 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	}
 	spin_unlock(&vmap_area_lock);
 
-	/* mark allocated areas as accessible */
+	/*
+	 * Mark allocated areas as accessible. Do it now as a best-effort
+	 * approach, as they can be mapped outside of vmalloc code.
+	 */
 	for (area = 0; area < nr_vms; area++)
 		vms[area]->addr = kasan_unpoison_vmalloc(vms[area]->addr,
 							 vms[area]->size);
-- 
2.25.1

