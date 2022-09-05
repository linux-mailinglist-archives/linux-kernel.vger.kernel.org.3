Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3D15ADAA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiIEVIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiIEVII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:08:08 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599E45AC56
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:08:07 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662412085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seyO/qcSJYVowkIOZCiExEBVBp5SOVzPECSR5PeA5GE=;
        b=boGTz93IKCuAp9MZBS3z5EPdFtr9zrEXrhfbCz1kD7m0PuGq7e/2nHYrHbE62NTLkgES+d
        gTZvpRCpsD7qtd97yfRbSj45snQGqtOoxIMmwJd3i3j+neE4NIMg18FZrDV5EnFsFOIBUP
        qu7hNmX1Fh+SziSVwe6uMNHIaRFsqn4=
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
Subject: [PATCH mm v3 15/34] kasan: only define kasan_never_merge for Generic mode
Date:   Mon,  5 Sep 2022 23:05:30 +0200
Message-Id: <81ed01f29ff3443580b7e2fe362a8b47b1e8006d.1662411799.git.andreyknvl@google.com>
In-Reply-To: <cover.1662411799.git.andreyknvl@google.com>
References: <cover.1662411799.git.andreyknvl@google.com>
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

KASAN prevents merging of slab caches whose objects have per-object
metadata stored in redzones.

As now only the Generic mode uses per-object metadata, define
kasan_never_merge() only for this mode.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 18 ++++++------------
 mm/kasan/common.c     |  8 --------
 mm/kasan/generic.c    |  8 ++++++++
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 027df7599573..9743d4b3a918 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -103,14 +103,6 @@ struct kasan_cache {
 	bool is_kmalloc;
 };
 
-slab_flags_t __kasan_never_merge(void);
-static __always_inline slab_flags_t kasan_never_merge(void)
-{
-	if (kasan_enabled())
-		return __kasan_never_merge();
-	return 0;
-}
-
 void __kasan_unpoison_range(const void *addr, size_t size);
 static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
 {
@@ -261,10 +253,6 @@ static __always_inline bool kasan_check_byte(const void *addr)
 
 #else /* CONFIG_KASAN */
 
-static inline slab_flags_t kasan_never_merge(void)
-{
-	return 0;
-}
 static inline void kasan_unpoison_range(const void *address, size_t size) {}
 static inline void kasan_poison_pages(struct page *page, unsigned int order,
 				      bool init) {}
@@ -325,6 +313,7 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 #ifdef CONFIG_KASAN_GENERIC
 
 size_t kasan_metadata_size(struct kmem_cache *cache);
+slab_flags_t kasan_never_merge(void);
 
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
@@ -338,6 +327,11 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache)
 {
 	return 0;
 }
+/* And thus nothing prevents cache merging. */
+static inline slab_flags_t kasan_never_merge(void)
+{
+	return 0;
+}
 
 static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
 static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 7c79c560315d..c2690e938030 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -88,14 +88,6 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
 }
 #endif /* CONFIG_KASAN_STACK */
 
-/* Only allow cache merging when no per-object metadata is present. */
-slab_flags_t __kasan_never_merge(void)
-{
-	if (kasan_requires_meta())
-		return SLAB_KASAN;
-	return 0;
-}
-
 void __kasan_unpoison_pages(struct page *page, unsigned int order, bool init)
 {
 	u8 tag;
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 806ab92032c3..25333bf3c99f 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -328,6 +328,14 @@ DEFINE_ASAN_SET_SHADOW(f3);
 DEFINE_ASAN_SET_SHADOW(f5);
 DEFINE_ASAN_SET_SHADOW(f8);
 
+/* Only allow cache merging when no per-object metadata is present. */
+slab_flags_t kasan_never_merge(void)
+{
+	if (!kasan_requires_meta())
+		return 0;
+	return SLAB_KASAN;
+}
+
 /*
  * Adaptive redzone policy taken from the userspace AddressSanitizer runtime.
  * For larger allocations larger redzones are used.
-- 
2.25.1

