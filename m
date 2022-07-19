Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B8578F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiGSAPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiGSAPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:15:47 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37470357FC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:15:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzZKkdAFPRpFrhztX0frHyUgTspT1AIBFjL43I0Kz2k=;
        b=iQMr4m8kN9B8J8NXDGuCjhWN8dwRkBDIoFyjAj3tDGkb+9onGD9k1k4oZzd66ioA8BCupJ
        nfKwN/e7p2UKCZOJtAU/XzVNnnjIQbOzWN9kE3pjNkwtmDPSHwt6Lq2kxKkyFB0jYzH6G/
        5h9VdwQMzJf2CMBH+3NY+AZxNRIEopU=
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
Subject: [PATCH mm v2 30/33] kasan: implement stack ring for tag-based modes
Date:   Tue, 19 Jul 2022 02:10:10 +0200
Message-Id: <0e910197bfbcf505122f6dae2ee9b90ff8ee31f7.1658189199.git.andreyknvl@google.com>
In-Reply-To: <cover.1658189199.git.andreyknvl@google.com>
References: <cover.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

The number of entries in the stack ring is fixed in this patch, but one of
the following patches adds a command-line argument to control it.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Only use the atomic type for pos, use READ/WRITE_ONCE() for the rest.
- Rename KASAN_STACK_RING_ENTRIES to KASAN_STACK_RING_SIZE.
- Rename object local variable in kasan_complete_mode_report_info() to
  ptr to match the name in kasan_stack_ring_entry.
- Detect stack ring entry slots that are being written to.
- Use read-write lock to disallow reading half-written stack ring entries.
- Add a comment about the stack ring being best-effort.
---
 mm/kasan/kasan.h       | 21 ++++++++++++
 mm/kasan/report_tags.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 mm/kasan/tags.c        | 50 +++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 7df107dc400a..cfff81139d67 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -2,6 +2,7 @@
 #ifndef __MM_KASAN_KASAN_H
 #define __MM_KASAN_KASAN_H
 
+#include <linux/atomic.h>
 #include <linux/kasan.h>
 #include <linux/kasan-tags.h>
 #include <linux/kfence.h>
@@ -233,6 +234,26 @@ struct kasan_free_meta {
 
 #endif /* CONFIG_KASAN_GENERIC */
 
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+
+struct kasan_stack_ring_entry {
+	void *ptr;
+	size_t size;
+	u32 pid;
+	depot_stack_handle_t stack;
+	bool is_free;
+};
+
+#define KASAN_STACK_RING_SIZE (32 << 10)
+
+struct kasan_stack_ring {
+	rwlock_t lock;
+	atomic64_t pos;
+	struct kasan_stack_ring_entry entries[KASAN_STACK_RING_SIZE];
+};
+
+#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
+
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 /* Used in KUnit-compatible KASAN tests. */
 struct kunit_kasan_status {
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 5cbac2cdb177..a996489e6dac 100644
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
@@ -24,5 +28,77 @@ static const char *get_bug_type(struct kasan_report_info *info)
 
 void kasan_complete_mode_report_info(struct kasan_report_info *info)
 {
+	unsigned long flags;
+	u64 pos;
+	struct kasan_stack_ring_entry *entry;
+	void *ptr;
+	u32 pid;
+	depot_stack_handle_t stack;
+	bool is_free;
+	bool alloc_found = false, free_found = false;
+
 	info->bug_type = get_bug_type(info);
+
+	if (!info->cache || !info->object)
+		return;
+	}
+
+	write_lock_irqsave(&stack_ring.lock, flags);
+
+	pos = atomic64_read(&stack_ring.pos);
+
+	/*
+	 * The loop below tries to find stack ring entries relevant to the
+	 * buggy object. This is a best-effort process.
+	 *
+	 * First, another object with the same tag can be allocated in place of
+	 * the buggy object. Also, since the number of entries is limited, the
+	 * entries relevant to the buggy object can be overwritten.
+	 */
+
+	for (u64 i = pos - 1; i != pos - 1 - KASAN_STACK_RING_SIZE; i--) {
+		if (alloc_found && free_found)
+			break;
+
+		entry = &stack_ring.entries[i % KASAN_STACK_RING_SIZE];
+
+		/* Paired with smp_store_release() in save_stack_info(). */
+		ptr = (void *)smp_load_acquire(&entry->ptr);
+
+		if (kasan_reset_tag(ptr) != info->object ||
+		    get_tag(ptr) != get_tag(info->access_addr))
+			continue;
+
+		pid = READ_ONCE(entry->pid);
+		stack = READ_ONCE(entry->stack);
+		is_free = READ_ONCE(entry->is_free);
+
+		/* Try detecting if the entry was changed while being read. */
+		smp_mb();
+		if (ptr != (void *)READ_ONCE(entry->ptr))
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
+
+	write_unlock_irqrestore(&stack_ring.lock, flags);
 }
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 39a0481e5228..07828021c1f5 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2020 Google, Inc.
  */
 
+#include <linux/atomic.h>
 #include <linux/init.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
@@ -16,11 +17,60 @@
 #include <linux/types.h>
 
 #include "kasan.h"
+#include "../slab.h"
+
+/* Non-zero, as initial pointer values are 0. */
+#define STACK_RING_BUSY_PTR ((void *)1)
+
+struct kasan_stack_ring stack_ring;
+
+static void save_stack_info(struct kmem_cache *cache, void *object,
+			gfp_t gfp_flags, bool is_free)
+{
+	unsigned long flags;
+	depot_stack_handle_t stack;
+	u64 pos;
+	struct kasan_stack_ring_entry *entry;
+	void *old_ptr;
+
+	stack = kasan_save_stack(gfp_flags, true);
+
+	/*
+	 * Prevent save_stack_info() from modifying stack ring
+	 * when kasan_complete_mode_report_info() is walking it.
+	 */
+	read_lock_irqsave(&stack_ring.lock, flags);
+
+next:
+	pos = atomic64_fetch_add(1, &stack_ring.pos);
+	entry = &stack_ring.entries[pos % KASAN_STACK_RING_SIZE];
+
+	/* Detect stack ring entry slots that are being written to. */
+	old_ptr = READ_ONCE(entry->ptr);
+	if (old_ptr == STACK_RING_BUSY_PTR)
+		goto next; /* Busy slot. */
+	if (!try_cmpxchg(&entry->ptr, &old_ptr, STACK_RING_BUSY_PTR))
+		goto next; /* Busy slot. */
+
+	WRITE_ONCE(entry->size, cache->object_size);
+	WRITE_ONCE(entry->pid, current->pid);
+	WRITE_ONCE(entry->stack, stack);
+	WRITE_ONCE(entry->is_free, is_free);
+
+	/*
+	 * Paired with smp_load_acquire() in kasan_complete_mode_report_info().
+	 */
+	smp_store_release(&entry->ptr, (s64)object);
+
+	read_unlock_irqrestore(&stack_ring.lock, flags);
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

