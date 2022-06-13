Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA354A09E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352068AbiFMU6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352192AbiFMUyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:16 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A4A1F627
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:20:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=elbTPIbPzGd31s7aorwI9rYhjRmEHK3gjeAMkGGimu0=;
        b=h7JWBIF63VjScWnfztbhyKCViyyAtGnpMl/AMGRoKL4V9SJgz13cHxU/JRCpZdHFJ47ZvB
        XMA3MgXcQs5KNAYimET01vZqFTAxYFvXff6GlCirXyjNqpI08YFhYDEPZ2YLpRHH8BHaZN
        7uRZOeI2itAm/C1/N6QVUZKfWJ0p+7Y=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 30/32] kasan: introduce kasan_complete_mode_report_info
Date:   Mon, 13 Jun 2022 22:14:21 +0200
Message-Id: <d8a0a85924bad7714d620f92516d28d4154f5325.1655150842.git.andreyknvl@google.com>
In-Reply-To: <cover.1655150842.git.andreyknvl@google.com>
References: <cover.1655150842.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add bug_type and alloc/free_track fields to kasan_report_info and add a
kasan_complete_mode_report_info() function that fills in these fields.
This function is implemented differently for different KASAN mode.

Change the reporting code to use the filled in fields instead of
invoking kasan_get_bug_type() and kasan_get_alloc/free_track().

For the Generic mode, kasan_complete_mode_report_info() invokes these
functions instead. For the tag-based modes, only the bug_type field is
filled in; alloc/free_track are handled in the next patch.

Using a single function that fills in these fields is required for the
tag-based modes, as the values for all three fields are determined in a
single procedure implemented in the following patch.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h          | 33 +++++++++++++++++----------------
 mm/kasan/report.c         | 29 ++++++++++++++---------------
 mm/kasan/report_generic.c | 32 +++++++++++++++++---------------
 mm/kasan/report_tags.c    | 13 +++----------
 4 files changed, 51 insertions(+), 56 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index b9bd9f1656bf..c51cea31ced0 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -146,6 +146,13 @@ static inline bool kasan_requires_meta(void)
 #define META_MEM_BYTES_PER_ROW (META_BYTES_PER_ROW * KASAN_GRANULE_SIZE)
 #define META_ROWS_AROUND_ADDR 2
 
+#define KASAN_STACK_DEPTH 64
+
+struct kasan_track {
+	u32 pid;
+	depot_stack_handle_t stack;
+};
+
 struct kasan_report_info {
 	/* Filled in by kasan_report_*(). */
 	void *access_addr;
@@ -158,6 +165,11 @@ struct kasan_report_info {
 	void *first_bad_addr;
 	struct kmem_cache *cache;
 	void *object;
+
+	/* Filled in by the mode-specific reporting code. */
+	const char *bug_type;
+	struct kasan_track alloc_track;
+	struct kasan_track free_track;
 };
 
 /* Do not change the struct layout: compiler ABI. */
@@ -183,14 +195,7 @@ struct kasan_global {
 #endif
 };
 
-/* Structures for keeping alloc and free tracks. */
-
-#define KASAN_STACK_DEPTH 64
-
-struct kasan_track {
-	u32 pid;
-	depot_stack_handle_t stack;
-};
+/* Structures for keeping alloc and free meta. */
 
 #ifdef CONFIG_KASAN_GENERIC
 
@@ -264,16 +269,16 @@ static inline bool addr_has_metadata(const void *addr)
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
+void *kasan_find_first_bad_addr(void *addr, size_t size);
+void kasan_complete_mode_report_info(struct kasan_report_info *info);
+void kasan_metadata_fetch_row(char *buffer, void *row);
+
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
 void kasan_print_tags(u8 addr_tag, const void *addr);
 #else
 static inline void kasan_print_tags(u8 addr_tag, const void *addr) { }
 #endif
 
-void *kasan_find_first_bad_addr(void *addr, size_t size);
-const char *kasan_get_bug_type(struct kasan_report_info *info);
-void kasan_metadata_fetch_row(char *buffer, void *row);
-
 #if defined(CONFIG_KASAN_STACK)
 void kasan_print_address_stack_frame(const void *addr);
 #else
@@ -308,10 +313,6 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
 void kasan_set_track(struct kasan_track *track, gfp_t flags);
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
 void kasan_save_free_info(struct kmem_cache *cache, void *object);
-struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
-						void *object);
-struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-						void *object, u8 tag);
 
 #if defined(CONFIG_KASAN_GENERIC) && \
 	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index a2789d4a05dd..206b7fe64e6b 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -176,7 +176,7 @@ static void end_report(unsigned long *flags, void *addr)
 static void print_error_description(struct kasan_report_info *info)
 {
 	const char *bug_type = info->is_free ?
-		"double-free or invalid-free" : kasan_get_bug_type(info);
+		"double-free or invalid-free" : info->bug_type;
 
 	pr_err("BUG: KASAN: %s in %pS\n", bug_type, (void *)info->ip);
 	if (info->is_free)
@@ -236,31 +236,25 @@ static void describe_object_addr(const void *addr, struct kmem_cache *cache,
 		(void *)(object_addr + cache->object_size));
 }
 
-static void describe_object_stacks(u8 tag, struct kasan_report_info *info)
+static void describe_object_stacks(struct kasan_report_info *info)
 {
-	struct kasan_track *alloc_track;
-	struct kasan_track *free_track;
-
-	alloc_track = kasan_get_alloc_track(info->cache, info->object);
-	if (alloc_track) {
-		print_track(alloc_track, "Allocated");
+	if (info->alloc_track.stack) {
+		print_track(&info->alloc_track, "Allocated");
 		pr_err("\n");
 	}
 
-	free_track = kasan_get_free_track(info->cache, info->object, tag);
-	if (free_track) {
-		print_track(free_track, "Freed");
+	if (info->free_track.stack) {
+		print_track(&info->free_track, "Freed");
 		pr_err("\n");
 	}
 
 	kasan_print_aux_stacks(info->cache, info->object);
 }
 
-static void describe_object(const void *addr, u8 tag,
-			    struct kasan_report_info *info)
+static void describe_object(const void *addr, struct kasan_report_info *info)
 {
 	if (kasan_stack_collection_enabled())
-		describe_object_stacks(tag, info);
+		describe_object_stacks(info);
 	describe_object_addr(addr, info->cache, info->object);
 }
 
@@ -289,7 +283,7 @@ static void print_address_description(void *addr, u8 tag,
 	pr_err("\n");
 
 	if (info->cache && info->object) {
-		describe_object(addr, tag, info);
+		describe_object(addr, info);
 		pr_err("\n");
 	}
 
@@ -420,6 +414,9 @@ static void complete_report_info(struct kasan_report_info *info)
 		info->object = nearest_obj(info->cache, slab, addr);
 	} else
 		info->cache = info->object = NULL;
+
+	/* Fill in mode-specific report info fields. */
+	kasan_complete_mode_report_info(info);
 }
 
 void kasan_report_invalid_free(void *ptr, unsigned long ip)
@@ -437,6 +434,7 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip)
 
 	start_report(&flags, true);
 
+	memset(&info, 0, sizeof(info));
 	info.access_addr = ptr;
 	info.access_size = 0;
 	info.is_write = false;
@@ -471,6 +469,7 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 
 	start_report(&irq_flags, true);
 
+	memset(&info, 0, sizeof(info));
 	info.access_addr = ptr;
 	info.access_size = size;
 	info.is_write = is_write;
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 74d21786ef09..087c1d8c8145 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -109,7 +109,7 @@ static const char *get_wild_bug_type(struct kasan_report_info *info)
 	return bug_type;
 }
 
-const char *kasan_get_bug_type(struct kasan_report_info *info)
+static const char *get_bug_type(struct kasan_report_info *info)
 {
 	/*
 	 * If access_size is a negative number, then it has reason to be
@@ -127,25 +127,27 @@ const char *kasan_get_bug_type(struct kasan_report_info *info)
 	return get_wild_bug_type(info);
 }
 
-struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
-						void *object)
+void kasan_complete_mode_report_info(struct kasan_report_info *info)
 {
 	struct kasan_alloc_meta *alloc_meta;
+	struct kasan_free_meta *free_meta;
 
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (!alloc_meta)
-		return NULL;
+	info->bug_type = get_bug_type(info);
 
-	return &alloc_meta->alloc_track;
-}
+	if (!info->cache || !info->object)
+		return;
 
-struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-						void *object, u8 tag)
-{
-	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREETRACK)
-		return NULL;
-	/* Free meta must be present with KASAN_SLAB_FREETRACK. */
-	return &kasan_get_free_meta(cache, object)->free_track;
+	alloc_meta = kasan_get_alloc_meta(info->cache, info->object);
+	if (alloc_meta)
+		memcpy(&info->alloc_track, &alloc_meta->alloc_track,
+		       sizeof(info->alloc_track));
+
+	if (*(u8 *)kasan_mem_to_shadow(info->object) == KASAN_SLAB_FREETRACK) {
+		/* Free meta must be present with KASAN_SLAB_FREETRACK. */
+		free_meta = kasan_get_free_meta(info->cache, info->object);
+		memcpy(&info->free_track, &free_meta->free_track,
+		       sizeof(info->free_track));
+	}
 }
 
 void kasan_metadata_fetch_row(char *buffer, void *row)
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 79b6497d8a81..5cbac2cdb177 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -6,7 +6,7 @@
 
 #include "kasan.h"
 
-const char *kasan_get_bug_type(struct kasan_report_info *info)
+static const char *get_bug_type(struct kasan_report_info *info)
 {
 	/*
 	 * If access_size is a negative number, then it has reason to be
@@ -22,14 +22,7 @@ const char *kasan_get_bug_type(struct kasan_report_info *info)
 	return "invalid-access";
 }
 
-struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
-						void *object)
+void kasan_complete_mode_report_info(struct kasan_report_info *info)
 {
-	return NULL;
-}
-
-struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-						void *object, u8 tag)
-{
-	return NULL;
+	info->bug_type = get_bug_type(info);
 }
-- 
2.25.1

