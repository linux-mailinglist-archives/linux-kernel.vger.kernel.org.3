Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44343578F19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiGSAPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbiGSAPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:15:47 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C6E37FB8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:15:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dEFlK3m+j6HFWp7YvmqmB+B3IIIjJFQIUVXb6/Nzt7c=;
        b=CZ9H9Xz4JbHfmsg8eEGwUg6SGpvSNwc80fna4TaZB32kOnyhSydBTAU55KWA/7nsU0Yt7T
        Ex2zNjdKIv8Qga4GTTmuTplYiC2D1x20y/fwH3BzvMER/NsIYiWnCzyuEFWp8B7Ibc52cO
        UrYoPoUHwTa46NNY73M1L8U7VWoSdJo=
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
Subject: [PATCH mm v2 32/33] kasan: dynamically allocate stack ring entries
Date:   Tue, 19 Jul 2022 02:10:12 +0200
Message-Id: <4db564768f1cb900b9687849a062156b470eb902.1658189199.git.andreyknvl@google.com>
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

Instead of using a large static array, allocate the stack ring dynamically
via memblock_alloc().

The size of the stack ring is controlled by a new kasan.stack_ring_size
command-line parameter. When kasan.stack_ring_size is not provided, the
default value of 32 << 10 is used.

When the stack trace collection is disabled via kasan.stacktrace=off,
the stack ring is not allocated.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- This is a new patch.
---
 mm/kasan/kasan.h       |  5 +++--
 mm/kasan/report_tags.c |  4 ++--
 mm/kasan/tags.c        | 22 +++++++++++++++++++++-
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 447baf1a7a2e..4afe4db751da 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -252,12 +252,13 @@ struct kasan_stack_ring_entry {
 	bool is_free;
 };
 
-#define KASAN_STACK_RING_SIZE (32 << 10)
+#define KASAN_STACK_RING_SIZE_DEFAULT (32 << 10)
 
 struct kasan_stack_ring {
 	rwlock_t lock;
+	size_t size;
 	atomic64_t pos;
-	struct kasan_stack_ring_entry entries[KASAN_STACK_RING_SIZE];
+	struct kasan_stack_ring_entry *entries;
 };
 
 #endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index a996489e6dac..7e267e69ce19 100644
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
index 0eb6cf6717db..fd8c5f919156 100644
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
@@ -52,6 +53,16 @@ static int __init early_kasan_flag_stacktrace(char *arg)
 }
 early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
 
+/* kasan.stack_ring_size=32768 */
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
@@ -65,6 +76,15 @@ void __init kasan_init_tags(void)
 		static_branch_enable(&kasan_flag_stacktrace);
 		break;
 	}
+
+	if (kasan_stack_collection_enabled()) {
+		if (!stack_ring.size)
+			stack_ring.size = KASAN_STACK_RING_SIZE_DEFAULT;
+		stack_ring.entries = memblock_alloc(
+					sizeof(stack_ring.entries[0]) *
+						stack_ring.size,
+					SMP_CACHE_BYTES);
+	}
 }
 
 static void save_stack_info(struct kmem_cache *cache, void *object,
@@ -86,7 +106,7 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 
 next:
 	pos = atomic64_fetch_add(1, &stack_ring.pos);
-	entry = &stack_ring.entries[pos % KASAN_STACK_RING_SIZE];
+	entry = &stack_ring.entries[pos % stack_ring.size];
 
 	/* Detect stack ring entry slots that are being written to. */
 	old_ptr = READ_ONCE(entry->ptr);
-- 
2.25.1

