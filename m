Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36752578ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbiGSALd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiGSAL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:11:26 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A77133A0D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:11:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hpsrcZa6raPAkQKqOapEqD/IGxCajqUwWoTNw3lCzg=;
        b=fT298j9mNHuv8pXIoRWuKuXeDvbHW4Mc0o5xt3MGoD8b8HH3glQRFTxeTOYqWKmYuPSfvl
        2os8twE4IiFaRtXB86nCQFGmyPG5ASyPmigd1nVovJeECkH5LLXN8QvGxhTYlFj0Qt2SHe
        p4+pWSybRuHoujQ3W8aWjx2MfqKX65Q=
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
Subject: [PATCH mm v2 08/33] kasan: introduce kasan_init_object_meta
Date:   Tue, 19 Jul 2022 02:09:48 +0200
Message-Id: <fab6a675e736c1ef21563a216b09b92383487ff9.1658189199.git.andreyknvl@google.com>
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

Add a kasan_init_object_meta() helper that initializes metadata for a slab
object and use it in the common code.

For now, the implementations of this helper are the same for the Generic
and tag-based modes, but they will diverge later in the series.

This change hides references to alloc_meta from the common code. This is
desired as only the Generic mode will be using per-object metadata after
this series.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c  | 10 +++-------
 mm/kasan/generic.c |  9 +++++++++
 mm/kasan/kasan.h   |  2 ++
 mm/kasan/tags.c    |  9 +++++++++
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6156c6f0e303..f57469b6b346 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -312,13 +312,9 @@ static inline u8 assign_tag(struct kmem_cache *cache,
 void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 						const void *object)
 {
-	struct kasan_alloc_meta *alloc_meta;
-
-	if (kasan_stack_collection_enabled()) {
-		alloc_meta = kasan_get_alloc_meta(cache, object);
-		if (alloc_meta)
-			__memset(alloc_meta, 0, sizeof(*alloc_meta));
-	}
+	/* Initialize per-object metadata if it is present. */
+	if (kasan_stack_collection_enabled())
+		kasan_init_object_meta(cache, object);
 
 	/* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
 	object = set_tag(object, assign_tag(cache, object, true));
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index f212b9ae57b5..5462ddbc21e6 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -328,6 +328,15 @@ DEFINE_ASAN_SET_SHADOW(f3);
 DEFINE_ASAN_SET_SHADOW(f5);
 DEFINE_ASAN_SET_SHADOW(f8);
 
+void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
+{
+	struct kasan_alloc_meta *alloc_meta;
+
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (alloc_meta)
+		__memset(alloc_meta, 0, sizeof(*alloc_meta));
+}
+
 static void __kasan_record_aux_stack(void *addr, bool can_alloc)
 {
 	struct slab *slab = kasan_addr_to_slab(addr);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index b65a51349c51..2c8c3cce7bc6 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -279,6 +279,8 @@ void kasan_report_invalid_free(void *object, unsigned long ip, enum kasan_report
 struct page *kasan_addr_to_page(const void *addr);
 struct slab *kasan_addr_to_slab(const void *addr);
 
+void kasan_init_object_meta(struct kmem_cache *cache, const void *object);
+
 depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
 void kasan_set_track(struct kasan_track *track, gfp_t flags);
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 7b1fc8e7c99c..2e200969a4b8 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -17,6 +17,15 @@
 
 #include "kasan.h"
 
+void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
+{
+	struct kasan_alloc_meta *alloc_meta;
+
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (alloc_meta)
+		__memset(alloc_meta, 0, sizeof(*alloc_meta));
+}
+
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 {
 	struct kasan_alloc_meta *alloc_meta;
-- 
2.25.1

