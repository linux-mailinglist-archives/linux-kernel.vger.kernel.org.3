Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB2154A090
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351427AbiFMU5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352190AbiFMUyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:16 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832C224977
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:20:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OqOHaer4kC3Iywced9lKgHi/whHdzXvvFFVWcKJPrko=;
        b=f5d/7XtUXAv8RzxuTswTXDO4W9PSq9kdFaPjQuxA4iTVQtefrfkzPW4aGdvzX++CKF10na
        9AUHYQzZLF8H3k/I2Tuha5dUthdwznGRX8KR64xwBQq8nFKELem71xvwCOLuFf1+udE9fO
        uzEbRQXAmCq9BsMMyyvh9Cno2phyuLU=
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
Subject: [PATCH 31/32] kasan: implement stack ring for tag-based modes
Date:   Mon, 13 Jun 2022 22:14:22 +0200
Message-Id: <3cd76121903de13713581687ffa45e668ef1475a.1655150842.git.andreyknvl@google.com>
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

Implement storing stack depot handles for alloc/free stack traces for
slab objects for the tag-based KASAN modes in a ring buffer.

This ring buffer is referred to as the stack ring.

On each alloc/free of a slab object, the tagged address of the object and
the current stack trace are recorded in the stack ring.

On each bug report, if the accessed address belongs to a slab object, the
stack ring is scanned for matching entries. The newest entries are used to
print the alloc/free stack traces in the report: one entry for alloc and
one for free.

The ring buffer is lock-free.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

The number of entries in the stack ring is fixed in this version of the
patch. We could either implement it as a config option or a command-line
argument. I tilt towards the latter option and will implement it in v2
unless there are objections.
---
 mm/kasan/kasan.h       | 20 ++++++++++++++
 mm/kasan/report_tags.c | 61 ++++++++++++++++++++++++++++++++++++++++++
 mm/kasan/tags.c        | 30 +++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index c51cea31ced0..da9a3c56ef4b 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -2,6 +2,7 @@
 #ifndef __MM_KASAN_KASAN_H
 #define __MM_KASAN_KASAN_H
 
+#include <linux/atomic.h>
 #include <linux/kasan.h>
 #include <linux/kasan-tags.h>
 #include <linux/kfence.h>
@@ -227,6 +228,25 @@ struct kasan_free_meta {
 
 #endif /* CONFIG_KASAN_GENERIC */
 
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+
+struct kasan_stack_ring_entry {
+	atomic64_t ptr;		/* void * */
+	atomic64_t size;	/* size_t */
+	atomic_t pid;		/* u32 */
+	atomic_t stack;		/* depot_stack_handle_t */
+	atomic_t is_free;	/* bool */
+};
+
+#define KASAN_STACK_RING_ENTRIES (32 << 10)
+
+struct kasan_stack_ring {
+	atomic64_t pos;
+	struct kasan_stack_ring_entry entries[KASAN_STACK_RING_ENTRIES];
+};
+
+#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
+
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 /* Used in KUnit-compatible KASAN tests. */
 struct kunit_kasan_status {
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 5cbac2cdb177..21911d1883d3 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -4,8 +4,12 @@
  * Copyright (c) 2020 Google, Inc.
  */
 
+#include <linux/atomic.h>
+
 #include "kasan.h"
 
+extern struct kasan_stack_ring stack_ring;
+
 static const char *get_bug_type(struct kasan_report_info *info)
 {
 	/*
@@ -24,5 +28,62 @@ static const char *get_bug_type(struct kasan_report_info *info)
 
 void kasan_complete_mode_report_info(struct kasan_report_info *info)
 {
+	u64 pos;
+	struct kasan_stack_ring_entry *entry;
+	void *object;
+	u32 pid;
+	depot_stack_handle_t stack;
+	bool is_free;
+	bool alloc_found = false, free_found = false;
+
 	info->bug_type = get_bug_type(info);
+
+	if (!info->cache || !info->object)
+		return;
+
+	pos = atomic64_read(&stack_ring.pos);
+
+	for (u64 i = pos - 1; i != pos - 1 - KASAN_STACK_RING_ENTRIES; i--) {
+		if (alloc_found && free_found)
+			break;
+
+		entry = &stack_ring.entries[i % KASAN_STACK_RING_ENTRIES];
+
+		/* Paired with atomic64_set_release() in save_stack_info(). */
+		object = (void *)atomic64_read_acquire(&entry->ptr);
+
+		if (kasan_reset_tag(object) != info->object ||
+		    get_tag(object) != get_tag(info->access_addr))
+			continue;
+
+		pid = atomic_read(&entry->pid);
+		stack = atomic_read(&entry->stack);
+		is_free = atomic_read(&entry->is_free);
+
+		/* Try detecting if the entry was changed while being read. */
+		smp_mb();
+		if (object != (void *)atomic64_read(&entry->ptr))
+			continue;
+
+		if (is_free) {
+			/*
+			 * Second free of the same object.
+			 * Give up on trying to find the alloc entry.
+			 */
+			if (free_found)
+				break;
+
+			info->free_track.pid = pid;
+			info->free_track.stack = stack;
+			free_found = true;
+		} else {
+			/* Second alloc of the same object. Give up. */
+			if (alloc_found)
+				break;
+
+			info->alloc_track.pid = pid;
+			info->alloc_track.stack = stack;
+			alloc_found = true;
+		}
+	}
 }
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 39a0481e5228..286011307695 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2020 Google, Inc.
  */
 
+#include <linux/atomic.h>
 #include <linux/init.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
@@ -16,11 +17,40 @@
 #include <linux/types.h>
 
 #include "kasan.h"
+#include "../slab.h"
+
+struct kasan_stack_ring stack_ring;
+
+void save_stack_info(struct kmem_cache *cache, void *object,
+			gfp_t flags, bool is_free)
+{
+	u64 pos;
+	struct kasan_stack_ring_entry *entry;
+	depot_stack_handle_t stack;
+
+	stack = kasan_save_stack(flags, true);
+
+	pos = atomic64_fetch_add(1, &stack_ring.pos);
+	entry = &stack_ring.entries[pos % KASAN_STACK_RING_ENTRIES];
+
+	atomic64_set(&entry->size, cache->object_size);
+	atomic_set(&entry->pid, current->pid);
+	atomic_set(&entry->stack, stack);
+	atomic_set(&entry->is_free, is_free);
+
+	/*
+	 * Paired with atomic64_read_acquire() in
+	 * kasan_complete_mode_report_info().
+	 */
+	atomic64_set_release(&entry->ptr, (s64)object);
+}
 
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 {
+	save_stack_info(cache, object, flags, false);
 }
 
 void kasan_save_free_info(struct kmem_cache *cache, void *object)
 {
+	save_stack_info(cache, object, GFP_NOWAIT, true);
 }
-- 
2.25.1

