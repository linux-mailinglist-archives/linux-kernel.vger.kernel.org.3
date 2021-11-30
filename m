Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E151B464110
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbhK3WNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbhK3WL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:11:26 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED93EC06175A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:08:04 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638310083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CceoAuXc8ztt6c/41GK5sR1YQRKzgrFVIEpBFl753js=;
        b=xp8MsUnB5BFCaXQy2k5xnv/wQY4pHXZcBNpppZ/1PrYh0SQUDDYlmoRG/NNRkZXmK0UAWE
        SvLikYAEayl69lqn5gywYTPR07bS5gG61K2RRPu5/WdY2Ce9Jp5cCo9TM8TEEHoFL9kdpf
        s5K1oextKKqxI6p/G02TWr5VgVOiiiw=
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
Subject: [PATCH 25/31] kasan, vmalloc: don't unpoison VM_ALLOC pages before mapping
Date:   Tue, 30 Nov 2021 23:08:01 +0100
Message-Id: <0b79da9e534bfa35d11154b940095df23ee68a16.1638308023.git.andreyknvl@google.com>
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

