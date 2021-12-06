Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D751646AAD5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353102AbhLFVuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:50:09 -0500
Received: from out2.migadu.com ([188.165.223.204]:64824 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353654AbhLFVuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:50:00 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638827190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CceoAuXc8ztt6c/41GK5sR1YQRKzgrFVIEpBFl753js=;
        b=M9OKKoZeQ9QP7msj10cO90weY6/5kMTde7yVB3UKk03n8tkNr3GzxhxMhOwyTPDJ3eYzFP
        c//+1GM2DRuo/ZAQo8QWKTzW4/gPIXUbKXbm+qCzXBgo0y6nEomsoaSQ6VtyzAaAumgxNt
        ya1i1WBCg5uK+FnuH9zrz5God4EzzGg=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 25/34] kasan, vmalloc: don't unpoison VM_ALLOC pages before mapping
Date:   Mon,  6 Dec 2021 22:44:02 +0100
Message-Id: <af074f0ed424b2530982cf41391dc6e8265b4a7e.1638825394.git.andreyknvl@google.com>
In-Reply-To: <cover.1638825394.git.andreyknvl@google.com>
References: <cover.1638825394.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

This patch makes KASAN unpoison vmalloc mappings after that have been
mapped in when it's possible: for vmalloc() (indentified via VM_ALLOC)
and vm_map_ram().

The reasons for this are:

- For vmalloc() and vm_map_ram(): pages don't get unpoisoned in case
  mapping them fails.
- For vmalloc(): HW_TAGS KASAN needs pages to be mapped to set tags via
  kasan_unpoison_vmalloc().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/vmalloc.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f37d0ed99bf9..82ef1e27e2e4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2208,14 +2208,15 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		mem = (void *)addr;
 	}
 
-	mem = kasan_unpoison_vmalloc(mem, size);
-
 	if (vmap_pages_range(addr, addr + size, PAGE_KERNEL,
 				pages, PAGE_SHIFT) < 0) {
 		vm_unmap_ram(mem, count);
 		return NULL;
 	}
 
+	/* Mark the pages as accessible after they were mapped in. */
+	mem = kasan_unpoison_vmalloc(mem, size);
+
 	return mem;
 }
 EXPORT_SYMBOL(vm_map_ram);
@@ -2443,7 +2444,14 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 
 	setup_vmalloc_vm(area, va, flags, caller);
 
-	area->addr = kasan_unpoison_vmalloc(area->addr, requested_size);
+	/*
+	 * For VM_ALLOC mappings, __vmalloc_node_range() mark the pages as
+	 * accessible after they are mapped in.
+	 * Otherwise, as the pages can be mapped outside of vmalloc code,
+	 * mark them now as a best-effort approach.
+	 */
+	if (!(flags & VM_ALLOC))
+		area->addr = kasan_unpoison_vmalloc(area->addr, requested_size);
 
 	return area;
 }
@@ -3072,6 +3080,12 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	if (!addr)
 		goto fail;
 
+	/*
+	 * Mark the pages for VM_ALLOC mappings as accessible after they were
+	 * mapped in.
+	 */
+	addr = kasan_unpoison_vmalloc(addr, real_size);
+
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
 	 * flag. It means that vm_struct is not fully initialized.
@@ -3766,7 +3780,11 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	}
 	spin_unlock(&vmap_area_lock);
 
-	/* mark allocated areas as accessible */
+	/*
+	 * Mark allocated areas as accessible.
+	 * As the pages are mapped outside of vmalloc code,
+	 * mark them now as a best-effort approach.
+	 */
 	for (area = 0; area < nr_vms; area++)
 		vms[area]->addr = kasan_unpoison_vmalloc(vms[area]->addr,
 							 vms[area]->size);
-- 
2.25.1

