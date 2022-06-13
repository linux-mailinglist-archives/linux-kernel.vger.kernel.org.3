Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6892C54A04F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351163AbiFMUyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350736AbiFMUxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:18 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A63EE012
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:15:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJyI1q6f80wQzyJSQxJLFHolqTP9cxvpgBekekTg5FA=;
        b=oRiXY173+rNYu9q5ejUgqLAcQxKtVVJJwv/RkKdPidlw+963fu7HySl5B3NwUyGb14+Vdm
        TfaMNGMDf5tUsTrPX5fXXhelmd+jti809gcNElHE51Esui7T68FxKcLzBmi6JDiCS4+Mwn
        vuiAG7lL1+J8tR2Y56hhGqg1dw5pd5s=
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
Subject: [PATCH 05/32] kasan: drop CONFIG_KASAN_TAGS_IDENTIFY
Date:   Mon, 13 Jun 2022 22:13:56 +0200
Message-Id: <cfc1744f4a5eb6f50eddee53238af1a2fb4e8583.1655150842.git.andreyknvl@google.com>
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

Drop CONFIG_KASAN_TAGS_IDENTIFY and related code to simplify making
changes to the reporting code.

The dropped functionality will be restored in the following patches in
this series.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/Kconfig.kasan      |  8 --------
 mm/kasan/kasan.h       | 12 +-----------
 mm/kasan/report_tags.c | 28 ----------------------------
 mm/kasan/tags.c        | 21 ++-------------------
 4 files changed, 3 insertions(+), 66 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index f0973da583e0..ca09b1cf8ee9 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -167,14 +167,6 @@ config KASAN_STACK
 	  as well, as it adds inline-style instrumentation that is run
 	  unconditionally.
 
-config KASAN_TAGS_IDENTIFY
-	bool "Memory corruption type identification"
-	depends on KASAN_SW_TAGS || KASAN_HW_TAGS
-	help
-	  Enables best-effort identification of the bug types (use-after-free
-	  or out-of-bounds) at the cost of increased memory consumption.
-	  Only applicable for the tag-based KASAN modes.
-
 config KASAN_VMALLOC
 	bool "Check accesses to vmalloc allocations"
 	depends on HAVE_ARCH_KASAN_VMALLOC
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 610057e651d2..aa6b43936f8d 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -168,23 +168,13 @@ struct kasan_track {
 	depot_stack_handle_t stack;
 };
 
-#if defined(CONFIG_KASAN_TAGS_IDENTIFY) && defined(CONFIG_KASAN_SW_TAGS)
-#define KASAN_NR_FREE_STACKS 5
-#else
-#define KASAN_NR_FREE_STACKS 1
-#endif
-
 struct kasan_alloc_meta {
 	struct kasan_track alloc_track;
 	/* Generic mode stores free track in kasan_free_meta. */
 #ifdef CONFIG_KASAN_GENERIC
 	depot_stack_handle_t aux_stack[2];
 #else
-	struct kasan_track free_track[KASAN_NR_FREE_STACKS];
-#endif
-#ifdef CONFIG_KASAN_TAGS_IDENTIFY
-	u8 free_pointer_tag[KASAN_NR_FREE_STACKS];
-	u8 free_track_idx;
+	struct kasan_track free_track;
 #endif
 };
 
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index e25d2166e813..35cf3cae4aa4 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -5,37 +5,9 @@
  */
 
 #include "kasan.h"
-#include "../slab.h"
 
 const char *kasan_get_bug_type(struct kasan_report_info *info)
 {
-#ifdef CONFIG_KASAN_TAGS_IDENTIFY
-	struct kasan_alloc_meta *alloc_meta;
-	struct kmem_cache *cache;
-	struct slab *slab;
-	const void *addr;
-	void *object;
-	u8 tag;
-	int i;
-
-	tag = get_tag(info->access_addr);
-	addr = kasan_reset_tag(info->access_addr);
-	slab = kasan_addr_to_slab(addr);
-	if (slab) {
-		cache = slab->slab_cache;
-		object = nearest_obj(cache, slab, (void *)addr);
-		alloc_meta = kasan_get_alloc_meta(cache, object);
-
-		if (alloc_meta) {
-			for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
-				if (alloc_meta->free_pointer_tag[i] == tag)
-					return "use-after-free";
-			}
-		}
-		return "out-of-bounds";
-	}
-#endif
-
 	/*
 	 * If access_size is a negative number, then it has reason to be
 	 * defined as out-of-bounds bug type.
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 1ba3c8399f72..e0e5de8ce834 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -30,39 +30,22 @@ void kasan_save_free_info(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
 	struct kasan_alloc_meta *alloc_meta;
-	u8 idx = 0;
 
 	alloc_meta = kasan_get_alloc_meta(cache, object);
 	if (!alloc_meta)
 		return;
 
-#ifdef CONFIG_KASAN_TAGS_IDENTIFY
-	idx = alloc_meta->free_track_idx;
-	alloc_meta->free_pointer_tag[idx] = tag;
-	alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
-#endif
-
-	kasan_set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
+	kasan_set_track(&alloc_meta->free_track, GFP_NOWAIT);
 }
 
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
 	struct kasan_alloc_meta *alloc_meta;
-	int i = 0;
 
 	alloc_meta = kasan_get_alloc_meta(cache, object);
 	if (!alloc_meta)
 		return NULL;
 
-#ifdef CONFIG_KASAN_TAGS_IDENTIFY
-	for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
-		if (alloc_meta->free_pointer_tag[i] == tag)
-			break;
-	}
-	if (i == KASAN_NR_FREE_STACKS)
-		i = alloc_meta->free_track_idx;
-#endif
-
-	return &alloc_meta->free_track[i];
+	return &alloc_meta->free_track;
 }
-- 
2.25.1

