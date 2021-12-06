Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6786A46AAD1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353009AbhLFVuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353039AbhLFVtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:49:49 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D96CC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:46:19 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638827178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ip+mfiCrUsqaU/ZPq/AUCt3O9J1b1z5H3QxOY+5r30=;
        b=jpdwDylT/uL4URAlxZowoEzRKnBJtPW77wI4HMlU8g00LVAfw9613B3AicbBk1BI2NRIot
        K32IXPXhnspxnmJrDkOlWVoY6BtqWM1Svq63bBuOezsDU3FrWLWkFutkZemteUnJR2HKED
        gwUE9lG6TiioKxiDfBP4kpfsNzfPwXg=
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
Subject: [PATCH v2 23/34] kasan, vmalloc: add vmalloc support to SW_TAGS
Date:   Mon,  6 Dec 2021 22:44:00 +0100
Message-Id: <666b9e932dde24df6e1b02493a04530b99ace697.1638825394.git.andreyknvl@google.com>
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

This patch adds vmalloc tagging support to SW_TAGS KASAN.

The changes include:

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

- Allow enabling KASAN_VMALLOC with SW_TAGS.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Allow enabling KASAN_VMALLOC with SW_TAGS in this patch.
---
 include/linux/kasan.h | 17 +++++++++++------
 lib/Kconfig.kasan     |  2 +-
 mm/kasan/shadow.c     |  6 ++++--
 mm/vmalloc.c          | 14 ++++++++------
 4 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index ad4798e77f60..6a2619759e93 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -423,12 +423,14 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end);
 
-void __kasan_unpoison_vmalloc(const void *start, unsigned long size);
-static __always_inline void kasan_unpoison_vmalloc(const void *start,
-						   unsigned long size)
+void * __must_check __kasan_unpoison_vmalloc(const void *start,
+					     unsigned long size);
+static __always_inline void * __must_check kasan_unpoison_vmalloc(
+					const void *start, unsigned long size)
 {
 	if (kasan_enabled())
-		__kasan_unpoison_vmalloc(start, size);
+		return __kasan_unpoison_vmalloc(start, size);
+	return (void *)start;
 }
 
 void __kasan_poison_vmalloc(const void *start, unsigned long size);
@@ -453,8 +455,11 @@ static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long free_region_start,
 					 unsigned long free_region_end) { }
 
-static inline void kasan_unpoison_vmalloc(const void *start, unsigned long size)
-{ }
+static inline void *kasan_unpoison_vmalloc(const void *start,
+					   unsigned long size, bool unique)
+{
+	return (void *)start;
+}
 static inline void kasan_poison_vmalloc(const void *start, unsigned long size)
 { }
 
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index cdc842d090db..3f144a87f8a3 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -179,7 +179,7 @@ config KASAN_TAGS_IDENTIFY
 
 config KASAN_VMALLOC
 	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
+	depends on (KASAN_GENERIC || KASAN_SW_TAGS) && HAVE_ARCH_KASAN_VMALLOC
 	help
 	  By default, the shadow region for vmalloc space is the read-only
 	  zero page. This means that KASAN cannot detect errors involving
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index fa0c8a750d09..4ca280a96fbc 100644
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
index a059b3100c0a..7be18b292679 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2208,7 +2208,7 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		mem = (void *)addr;
 	}
 
-	kasan_unpoison_vmalloc(mem, size);
+	mem = kasan_unpoison_vmalloc(mem, size);
 
 	if (vmap_pages_range(addr, addr + size, PAGE_KERNEL,
 				pages, PAGE_SHIFT) < 0) {
@@ -2441,10 +2441,10 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 		return NULL;
 	}
 
-	kasan_unpoison_vmalloc((void *)va->va_start, requested_size);
-
 	setup_vmalloc_vm(area, va, flags, caller);
 
+	area->addr = kasan_unpoison_vmalloc(area->addr, requested_size);
+
 	return area;
 }
 
@@ -3752,9 +3752,6 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	for (area = 0; area < nr_vms; area++) {
 		if (kasan_populate_vmalloc(vas[area]->va_start, sizes[area]))
 			goto err_free_shadow;
-
-		kasan_unpoison_vmalloc((void *)vas[area]->va_start,
-				       sizes[area]);
 	}
 
 	/* insert all vm's */
@@ -3767,6 +3764,11 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
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

