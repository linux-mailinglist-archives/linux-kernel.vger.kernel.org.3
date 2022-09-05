Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3C95ADAD2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbiIEVMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiIEVLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:11:53 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72160DECC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:11:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662412281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TeUnHNBM/F1mPxhPvnT4XtbBDScf0nohA/7hT4/VQ8=;
        b=sS1eNoy2SMYloCcoLU9an3Ui4uZVR1zgXqmOep+ffk7Wrxg2WfzMrmOOgO+N3DKLa96UBK
        sjIUivON5r5pAkm7dwWIulzyB5EkWAkDYDckk3yexQ1rRRLoVoRpC5oCXmRkybJnONR4rs
        stnTcTUmA4b6VOa1qLRwIdHQvKRHCB4=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v3 32/34] kasan: dynamically allocate stack ring entries
Date:   Mon,  5 Sep 2022 23:05:47 +0200
Message-Id: <03b82ab60db53427e9818e0b0c1971baa10c3cbc.1662411800.git.andreyknvl@google.com>
In-Reply-To: <cover.1662411799.git.andreyknvl@google.com>
References: <cover.1662411799.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Instead of using a large static array, allocate the stack ring dynamically
via memblock_alloc().

The size of the stack ring is controlled by a new kasan.stack_ring_size
command-line parameter. When kasan.stack_ring_size is not provided, the
default value of 32 << 10 is used.

When the stack trace collection is disabled via kasan.stacktrace=off,
the stack ring is not allocated.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Move KASAN_STACK_RING_SIZE_DEFAULT definition to tags.c
- Improve comment for early_kasan_flag_stack_ring_size().
- WARN_ON and disable stack traces on failed memblock_alloc.
- Add kasan.stack_ring_size to documentation.

Changes v1->v2:
- This is a new patch.
---
 Documentation/dev-tools/kasan.rst |  4 +++-
 mm/kasan/kasan.h                  |  5 ++---
 mm/kasan/report_tags.c            |  4 ++--
 mm/kasan/tags.c                   | 25 ++++++++++++++++++++++++-
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 7bd38c181018..5c93ab915049 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -112,10 +112,12 @@ parameter can be used to control panic and reporting behaviour:
   if ``kasan_multi_shot`` is enabled.
 
 Software and Hardware Tag-Based KASAN modes (see the section about various
-modes below) support disabling stack trace collection:
+modes below) support altering stack trace collection behavior:
 
 - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
   traces collection (default: ``on``).
+- ``kasan.stack_ring_size=<number of entries>`` specifies the number of entries
+  in the stack ring (default: ``32768``).
 
 Hardware Tag-Based KASAN mode is intended for use in production as a security
 mitigation. Therefore, it supports additional boot parameters that allow
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 447baf1a7a2e..abbcc1b0eec5 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -252,12 +252,11 @@ struct kasan_stack_ring_entry {
 	bool is_free;
 };
 
-#define KASAN_STACK_RING_SIZE (32 << 10)
-
 struct kasan_stack_ring {
 	rwlock_t lock;
+	size_t size;
 	atomic64_t pos;
-	struct kasan_stack_ring_entry entries[KASAN_STACK_RING_SIZE];
+	struct kasan_stack_ring_entry *entries;
 };
 
 #endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 1b78136542bb..57f7355377f1 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -56,11 +56,11 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 	 * entries relevant to the buggy object can be overwritten.
 	 */
 
-	for (u64 i = pos - 1; i != pos - 1 - KASAN_STACK_RING_SIZE; i--) {
+	for (u64 i = pos - 1; i != pos - 1 - stack_ring.size; i--) {
 		if (alloc_found && free_found)
 			break;
 
-		entry = &stack_ring.entries[i % KASAN_STACK_RING_SIZE];
+		entry = &stack_ring.entries[i % stack_ring.size];
 
 		/* Paired with smp_store_release() in save_stack_info(). */
 		ptr = (void *)smp_load_acquire(&entry->ptr);
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 0eb6cf6717db..9d867cae1b7b 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/memory.h>
 #include <linux/mm.h>
 #include <linux/static_key.h>
@@ -19,6 +20,8 @@
 #include "kasan.h"
 #include "../slab.h"
 
+#define KASAN_STACK_RING_SIZE_DEFAULT (32 << 10)
+
 enum kasan_arg_stacktrace {
 	KASAN_ARG_STACKTRACE_DEFAULT,
 	KASAN_ARG_STACKTRACE_OFF,
@@ -52,6 +55,16 @@ static int __init early_kasan_flag_stacktrace(char *arg)
 }
 early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
 
+/* kasan.stack_ring_size=<number of entries> */
+static int __init early_kasan_flag_stack_ring_size(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	return kstrtoul(arg, 0, &stack_ring.size);
+}
+early_param("kasan.stack_ring_size", early_kasan_flag_stack_ring_size);
+
 void __init kasan_init_tags(void)
 {
 	switch (kasan_arg_stacktrace) {
@@ -65,6 +78,16 @@ void __init kasan_init_tags(void)
 		static_branch_enable(&kasan_flag_stacktrace);
 		break;
 	}
+
+	if (kasan_stack_collection_enabled()) {
+		if (!stack_ring.size)
+			stack_ring.size = KASAN_STACK_RING_SIZE_DEFAULT;
+		stack_ring.entries = memblock_alloc(
+			sizeof(stack_ring.entries[0]) * stack_ring.size,
+			SMP_CACHE_BYTES);
+		if (WARN_ON(!stack_ring.entries))
+			static_branch_disable(&kasan_flag_stacktrace);
+	}
 }
 
 static void save_stack_info(struct kmem_cache *cache, void *object,
@@ -86,7 +109,7 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 
 next:
 	pos = atomic64_fetch_add(1, &stack_ring.pos);
-	entry = &stack_ring.entries[pos % KASAN_STACK_RING_SIZE];
+	entry = &stack_ring.entries[pos % stack_ring.size];
 
 	/* Detect stack ring entry slots that are being written to. */
 	old_ptr = READ_ONCE(entry->ptr);
-- 
2.25.1

