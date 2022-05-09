Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D985201A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbiEIPzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbiEIPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:55:39 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B561B3B97
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:51:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652111501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eJT1KTqzq39O6p9NSa8tv7mPnliZo+mxhdkjwWmbXd4=;
        b=n0gexs5Cn++GK9dkGC5XmksVQLkWk0QHkQKMXn9AnAinoRMj4668cfqG1gs1lWfC6gORjt
        v+oawY8qY5mi/koqh/nJx101QOAjc/AeVHCgemG39KfDXUsydFteH5xU//XjEIaQzhfL9o
        Hm5hasLexJVAuWB4G6XuXUQq5RsqS7o=
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
Subject: [PATCH v2 1/3] kasan: clean up comments in internal kasan.h
Date:   Mon,  9 May 2022 17:51:34 +0200
Message-Id: <a0680ff30035b56cb7bdd5f59fd400e71712ceb5.1652111464.git.andreyknvl@google.com>
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

Clean up comments in mm/kasan/kasan.h: clarify, unify styles, fix
punctuation, etc.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h | 74 +++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index b01b4bbe0409..fed4f7a00d33 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -42,6 +42,7 @@ static inline bool kasan_sync_fault_possible(void)
 {
 	return kasan_mode == KASAN_MODE_SYNC || kasan_mode == KASAN_MODE_ASYMM;
 }
+
 #else
 
 static inline bool kasan_stack_collection_enabled(void)
@@ -73,47 +74,41 @@ static inline bool kasan_sync_fault_possible(void)
 #define KASAN_MEMORY_PER_SHADOW_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
 
 #ifdef CONFIG_KASAN_GENERIC
-#define KASAN_FREE_PAGE         0xFF  /* page was freed */
-#define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
-#define KASAN_KMALLOC_REDZONE   0xFC  /* redzone inside slub object */
-#define KASAN_KMALLOC_FREE      0xFB  /* object was freed (kmem_cache_free/kfree) */
-#define KASAN_VMALLOC_INVALID   0xF8  /* unallocated space in vmapped page */
+#define KASAN_FREE_PAGE         0xFF  /* freed page */
+#define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocation */
+#define KASAN_KMALLOC_REDZONE   0xFC  /* redzone for slab object */
+#define KASAN_KMALLOC_FREE      0xFB  /* freed slab object */
+#define KASAN_VMALLOC_INVALID   0xF8  /* inaccessible space in vmap area */
 #else
 #define KASAN_FREE_PAGE         KASAN_TAG_INVALID
 #define KASAN_PAGE_REDZONE      KASAN_TAG_INVALID
 #define KASAN_KMALLOC_REDZONE   KASAN_TAG_INVALID
 #define KASAN_KMALLOC_FREE      KASAN_TAG_INVALID
-#define KASAN_VMALLOC_INVALID   KASAN_TAG_INVALID /* only for SW_TAGS */
+#define KASAN_VMALLOC_INVALID   KASAN_TAG_INVALID /* only used for SW_TAGS */
 #endif
 
 #ifdef CONFIG_KASAN_GENERIC
 
-#define KASAN_KMALLOC_FREETRACK 0xFA  /* object was freed and has free track set */
+#define KASAN_KMALLOC_FREETRACK 0xFA  /* freed slab object with free track */
 #define KASAN_GLOBAL_REDZONE    0xF9  /* redzone for global variable */
 
-/*
- * Stack redzone shadow values
- * (Those are compiler's ABI, don't change them)
- */
+/* Stack redzone shadow values. Compiler ABI, do not change. */
 #define KASAN_STACK_LEFT        0xF1
 #define KASAN_STACK_MID         0xF2
 #define KASAN_STACK_RIGHT       0xF3
 #define KASAN_STACK_PARTIAL     0xF4
 
-/*
- * alloca redzone shadow values
- */
+/* alloca redzone shadow values. */
 #define KASAN_ALLOCA_LEFT	0xCA
 #define KASAN_ALLOCA_RIGHT	0xCB
 
+/* alloca redzone size. Compiler ABI, do not change. */
 #define KASAN_ALLOCA_REDZONE_SIZE	32
 
-/*
- * Stack frame marker (compiler ABI).
- */
+/* Stack frame marker. Compiler ABI, do not change. */
 #define KASAN_CURRENT_STACK_FRAME_MAGIC 0x41B58AB3
 
-/* Don't break randconfig/all*config builds */
+/* Dummy value to avoid breaking randconfig/all*config builds. */
 #ifndef KASAN_ABI_VERSION
 #define KASAN_ABI_VERSION 1
 #endif
@@ -141,21 +136,21 @@ struct kasan_report_info {
 	unsigned long ip;
 };
 
-/* The layout of struct dictated by compiler */
+/* Do not change the struct layout: compiler ABI. */
 struct kasan_source_location {
 	const char *filename;
 	int line_no;
 	int column_no;
 };
 
-/* The layout of struct dictated by compiler */
+/* Do not change the struct layout: compiler ABI. */
 struct kasan_global {
 	const void *beg;		/* Address of the beginning of the global variable. */
 	size_t size;			/* Size of the global variable. */
-	size_t size_with_redzone;	/* Size of the variable + size of the red zone. 32 bytes aligned */
+	size_t size_with_redzone;	/* Size of the variable + size of the redzone. 32 bytes aligned. */
 	const void *name;
 	const void *module_name;	/* Name of the module where the global variable is declared. */
-	unsigned long has_dynamic_init;	/* This needed for C++ */
+	unsigned long has_dynamic_init;	/* This is needed for C++. */
 #if KASAN_ABI_VERSION >= 4
 	struct kasan_source_location *location;
 #endif
@@ -164,9 +159,7 @@ struct kasan_global {
 #endif
 };
 
-/**
- * Structures to keep alloc and free tracks *
- */
+/* Structures for keeping alloc and free tracks. */
 
 #define KASAN_STACK_DEPTH 64
 
@@ -183,11 +176,8 @@ struct kasan_track {
 
 struct kasan_alloc_meta {
 	struct kasan_track alloc_track;
+	/* Generic mode stores free track in kasan_free_meta. */
 #ifdef CONFIG_KASAN_GENERIC
-	/*
-	 * The auxiliary stack is stored into struct kasan_alloc_meta.
-	 * The free stack is stored into struct kasan_free_meta.
-	 */
 	depot_stack_handle_t aux_stack[2];
 #else
 	struct kasan_track free_track[KASAN_NR_FREE_STACKS];
@@ -203,18 +193,18 @@ struct qlist_node {
 };
 
 /*
- * Generic mode either stores free meta in the object itself or in the redzone
- * after the object. In the former case free meta offset is 0, in the latter
- * case it has some sane value smaller than INT_MAX. Use INT_MAX as free meta
- * offset when free meta isn't present.
+ * Free meta is stored either in the object itself or in the redzone after the
+ * object. In the former case, free meta offset is 0. In the latter case, the
+ * offset is between 0 and INT_MAX. INT_MAX marks that free meta is not present.
  */
 #define KASAN_NO_FREE_META INT_MAX
 
+/*
+ * Free meta is only used by Generic mode while the object is in quarantine.
+ * After that, slab allocator stores the freelist pointer in the object.
+ */
 struct kasan_free_meta {
 #ifdef CONFIG_KASAN_GENERIC
-	/* This field is used while the object is in the quarantine.
-	 * Otherwise it might be used for the allocator freelist.
-	 */
 	struct qlist_node quarantine_link;
 	struct kasan_track free_track;
 #endif
@@ -417,9 +407,10 @@ static inline void kasan_unpoison(const void *addr, size_t size, bool init)
 		return;
 	/*
 	 * Explicitly initialize the memory with the precise object size to
-	 * avoid overwriting the SLAB redzone. This disables initialization in
-	 * the arch code and may thus lead to performance penalty. The penalty
-	 * is accepted since SLAB redzones aren't enabled in production builds.
+	 * avoid overwriting the slab redzone. This disables initialization in
+	 * the arch code and may thus lead to performance penalty. This penalty
+	 * does not affect production builds, as slab redzones are not enabled
+	 * there.
 	 */
 	if (__slub_debug_enabled() &&
 	    init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
@@ -503,8 +494,9 @@ void kasan_restore_multi_shot(bool enabled);
 
 /*
  * Exported functions for interfaces called from assembly or from generated
- * code. Declarations here to avoid warning about missing declarations.
+ * code. Declared here to avoid warnings about missing declarations.
  */
+
 asmlinkage void kasan_unpoison_task_stack_below(const void *watermark);
 void __asan_register_globals(struct kasan_global *globals, size_t size);
 void __asan_unregister_globals(struct kasan_global *globals, size_t size);
@@ -573,4 +565,4 @@ void __hwasan_storeN_noabort(unsigned long addr, size_t size);
 
 void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size);
 
-#endif
+#endif /* __MM_KASAN_KASAN_H */
-- 
2.25.1

