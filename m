Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FC3481FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbhL3TPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbhL3TPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:15:14 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A32EC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:15:13 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640891712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mVX4Rj9VCh5LXuAxF4z8x/gZeqsD4J17LlYnLyStvnE=;
        b=Jayb3W6vo5irZU7mN2oA6fjCaYSEWqoxhkEjlIu+tJ4EnQNiogmGx3hfEd5tzD+Z5P3qIQ
        n6YwIPqpNFfUPK+1l7LTxNSbcByWiyQFM5s20C1N75qkys8Ga2vwyQ9JBgXL9w8DLFQz4j
        QoQIg5RikXl9sdjlmMbRW5GBZtKtA2A=
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
Subject: [PATCH mm v5 24/39] kasan, vmalloc: add vmalloc tagging for SW_TAGS
Date:   Thu, 30 Dec 2021 20:14:49 +0100
Message-Id: <30d0da01e7ade09f28ed98191a274112408ec3c2.1640891329.git.andreyknvl@google.com>
In-Reply-To: <cover.1640891329.git.andreyknvl@google.com>
References: <cover.1640891329.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add vmalloc tagging support to SW_TAGS KASAN.

- __kasan_unpoison_vmalloc() now assigns a random pointer tag, poisons
  the virtual mapping accordingly, and embeds the tag into the returned
  pointer.

- __get_vm_area_node() (used by vmalloc() and vmap()) and
  pcpu_get_vm_areas() save the tagged pointer into vm_struct->addr
  (note: not into vmap_area->addr). This requires putting
  kasan_unpoison_vmalloc() after setup_vmalloc_vm[_locked]();
  otherwise the latter will overwrite the tagged pointer.
  The tagged pointer then is naturally propagateed to vmalloc()
  and vmap().

- vm_map_ram() returns the tagged pointer directly.

As a result of this change, vm_struct->addr is now tagged.

Enabling KASAN_VMALLOC with SW_TAGS is not yet allowed.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Drop accidentally added kasan_unpoison_vmalloc() argument for when
  KASAN is off.
- Drop __must_check for kasan_unpoison_vmalloc(), as its result is
  sometimes intentionally ignored.
- Move allowing enabling KASAN_VMALLOC with SW_TAGS into a separate
  patch.
- Update patch description.

Changes v1->v2:
- Allow enabling KASAN_VMALLOC with SW_TAGS in this patch.
---
 include/linux/kasan.h | 16 ++++++++++------
 mm/kasan/shadow.c     |  6 ++++--
 mm/vmalloc.c          | 14 ++++++++------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index da320069e7cf..92c5dfa29a35 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -424,12 +424,13 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end);
 
-void __kasan_unpoison_vmalloc(const void *start, unsigned long size);
-static __always_inline void kasan_unpoison_vmalloc(const void *start,
-						   unsigned long size)
+void *__kasan_unpoison_vmalloc(const void *start, unsigned long size);
+static __always_inline void *kasan_unpoison_vmalloc(const void *start,
+						    unsigned long size)
 {
 	if (kasan_enabled())
-		__kasan_unpoison_vmalloc(start, size);
+		return __kasan_unpoison_vmalloc(start, size);
+	return (void *)start;
 }
 
 void __kasan_poison_vmalloc(const void *start, unsigned long size);
@@ -454,8 +455,11 @@ static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long free_region_start,
 					 unsigned long free_region_end) { }
 
-static inline void kasan_unpoison_vmalloc(const void *start, unsigned long size)
-{ }
+static inline void *kasan_unpoison_vmalloc(const void *start,
+					   unsigned long size)
+{
+	return (void *)start;
+}
 static inline void kasan_poison_vmalloc(const void *start, unsigned long size)
 { }
 
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 39d0b32ebf70..5a866f6663fc 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -475,12 +475,14 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	}
 }
 
-void __kasan_unpoison_vmalloc(const void *start, unsigned long size)
+void *__kasan_unpoison_vmalloc(const void *start, unsigned long size)
 {
 	if (!is_vmalloc_or_module_addr(start))
-		return;
+		return (void *)start;
 
+	start = set_tag(start, kasan_random_tag());
 	kasan_unpoison(start, size, false);
+	return (void *)start;
 }
 
 /*
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 52336b034fbb..da419db620ba 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2210,7 +2210,7 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		mem = (void *)addr;
 	}
 
-	kasan_unpoison_vmalloc(mem, size);
+	mem = kasan_unpoison_vmalloc(mem, size);
 
 	if (vmap_pages_range(addr, addr + size, PAGE_KERNEL,
 				pages, PAGE_SHIFT) < 0) {
@@ -2443,10 +2443,10 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 		return NULL;
 	}
 
-	kasan_unpoison_vmalloc((void *)va->va_start, requested_size);
-
 	setup_vmalloc_vm(area, va, flags, caller);
 
+	area->addr = kasan_unpoison_vmalloc(area->addr, requested_size);
+
 	return area;
 }
 
@@ -3802,9 +3802,6 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	for (area = 0; area < nr_vms; area++) {
 		if (kasan_populate_vmalloc(vas[area]->va_start, sizes[area]))
 			goto err_free_shadow;
-
-		kasan_unpoison_vmalloc((void *)vas[area]->va_start,
-				       sizes[area]);
 	}
 
 	/* insert all vm's */
@@ -3817,6 +3814,11 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	}
 	spin_unlock(&vmap_area_lock);
 
+	/* mark allocated areas as accessible */
+	for (area = 0; area < nr_vms; area++)
+		vms[area]->addr = kasan_unpoison_vmalloc(vms[area]->addr,
+							 vms[area]->size);
+
 	kfree(vas);
 	return vms;
 
-- 
2.25.1

