Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13F146AAC7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbhLFVth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352831AbhLFVtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:49:16 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985A2C061D5F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:45:46 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638827145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5vrmXGtyQkXmrhoONS3mEv98+EJ5a6iWSXEuOfvldi8=;
        b=d7P/LxHyM6jtvQS5baA6aRMBUddHSC/GthpLY39qjL5PfBw71gfmfjspU1S2YvHDAy16Bl
        Ucg99Oq6euUS+VsrWl1+O0ooSG31xZrVY5MgEy4jN1m+XqTp+Eo+buslB8lVSgup+m1mo8
        q1fvvr4mCw4Xw2Xh+F9qARf7zpYn1Do=
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
Subject: [PATCH v2 17/34] kasan, x86, arm64, s390: rename functions for modules shadow
Date:   Mon,  6 Dec 2021 22:43:54 +0100
Message-Id: <11f5a6419f8830fdedc84dca5f847543ef7960f4.1638825394.git.andreyknvl@google.com>
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

Rename kasan_free_shadow to kasan_free_module_shadow and
kasan_module_alloc to kasan_alloc_module_shadow.

These functions are used to allocate/free shadow memory for kernel
modules when KASAN_VMALLOC is not enabled. The new names better
reflect their purpose.

Also reword the comment next to their declaration to improve clarity.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/kernel/module.c |  2 +-
 arch/s390/kernel/module.c  |  2 +-
 arch/x86/kernel/module.c   |  2 +-
 include/linux/kasan.h      | 14 +++++++-------
 mm/kasan/shadow.c          |  4 ++--
 mm/vmalloc.c               |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index b5ec010c481f..f8bd5100efb5 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -58,7 +58,7 @@ void *module_alloc(unsigned long size)
 				PAGE_KERNEL, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 
-	if (p && (kasan_module_alloc(p, size) < 0)) {
+	if (p && (kasan_alloc_module_shadow(p, size) < 0)) {
 		vfree(p);
 		return NULL;
 	}
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index b01ba460b7ca..a753cebedda9 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -44,7 +44,7 @@ void *module_alloc(unsigned long size)
 	p = __vmalloc_node_range(size, MODULE_ALIGN, MODULES_VADDR, MODULES_END,
 				 GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
 				 __builtin_return_address(0));
-	if (p && (kasan_module_alloc(p, size) < 0)) {
+	if (p && (kasan_alloc_module_shadow(p, size) < 0)) {
 		vfree(p);
 		return NULL;
 	}
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 169fb6f4cd2e..dec41d9ba337 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -77,7 +77,7 @@ void *module_alloc(unsigned long size)
 				    MODULES_END, GFP_KERNEL,
 				    PAGE_KERNEL, 0, NUMA_NO_NODE,
 				    __builtin_return_address(0));
-	if (p && (kasan_module_alloc(p, size) < 0)) {
+	if (p && (kasan_alloc_module_shadow(p, size) < 0)) {
 		vfree(p);
 		return NULL;
 	}
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 1031070be3f3..4eec58e6ef82 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -453,17 +453,17 @@ static inline void kasan_populate_early_vm_area_shadow(void *start,
 		!defined(CONFIG_KASAN_VMALLOC)
 
 /*
- * These functions provide a special case to support backing module
- * allocations with real shadow memory. With KASAN vmalloc, the special
- * case is unnecessary, as the work is handled in the generic case.
+ * These functions allocate and free shadow memory for kernel modules.
+ * They are only required when KASAN_VMALLOC is not supported, as otherwise
+ * shadow memory is allocated by the generic vmalloc handlers.
  */
-int kasan_module_alloc(void *addr, size_t size);
-void kasan_free_shadow(const struct vm_struct *vm);
+int kasan_alloc_module_shadow(void *addr, size_t size);
+void kasan_free_module_shadow(const struct vm_struct *vm);
 
 #else /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
 
-static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
-static inline void kasan_free_shadow(const struct vm_struct *vm) {}
+static inline int kasan_alloc_module_shadow(void *addr, size_t size) { return 0; }
+static inline void kasan_free_module_shadow(const struct vm_struct *vm) {}
 
 #endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
 
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 4a4929b29a23..585c2bf1073b 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -498,7 +498,7 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 
 #else /* CONFIG_KASAN_VMALLOC */
 
-int kasan_module_alloc(void *addr, size_t size)
+int kasan_alloc_module_shadow(void *addr, size_t size)
 {
 	void *ret;
 	size_t scaled_size;
@@ -529,7 +529,7 @@ int kasan_module_alloc(void *addr, size_t size)
 	return -ENOMEM;
 }
 
-void kasan_free_shadow(const struct vm_struct *vm)
+void kasan_free_module_shadow(const struct vm_struct *vm)
 {
 	if (vm->flags & VM_KASAN)
 		vfree(kasan_mem_to_shadow(vm->addr));
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d2a00ad4e1dd..c5235e3e5857 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2524,7 +2524,7 @@ struct vm_struct *remove_vm_area(const void *addr)
 		va->vm = NULL;
 		spin_unlock(&vmap_area_lock);
 
-		kasan_free_shadow(vm);
+		kasan_free_module_shadow(vm);
 		free_unmap_vmap_area(va);
 
 		return vm;
-- 
2.25.1

