Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6E54A081
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349819AbiFMU4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351910AbiFMUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:02 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1983725C6D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:18:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+1jiBrKGTOAkQ9I8eaP4PIHMCNWMSHqgu/PvHey6xE=;
        b=F5EnSyRzoYiX0f3p7v1JZyYXYCdly4dsV81EJcSjrE5AgBjsvqGzsSPNsrhg9xnJINY22B
        JTqZ7R3jNHwJvMGgFjl3QeawSgC3InukMau/z4kNEB+Yd8GVk9awFkEbF9PJy7T04jE2a2
        yUW14maYFKV3Zq0LX4bXhSJ6v+M/U7E=
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
Subject: [PATCH 20/32] kasan: move kasan_get_alloc/free_track definitions
Date:   Mon, 13 Jun 2022 22:14:11 +0200
Message-Id: <8c647863a2ea158fd2ddc0c79e5e937bb03d86f0.1655150842.git.andreyknvl@google.com>
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

Move the definitions of kasan_get_alloc/free_track() to report_*.c, as
they belong with other the reporting code.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/generic.c        | 21 ---------------------
 mm/kasan/report_generic.c | 21 +++++++++++++++++++++
 mm/kasan/report_tags.c    | 12 ++++++++++++
 mm/kasan/tags.c           | 12 ------------
 4 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index aff39af3c532..d8b5590f9484 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -512,24 +512,3 @@ void kasan_save_free_info(struct kmem_cache *cache, void *object)
 	/* The object was freed and has free track set. */
 	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREETRACK;
 }
-
-struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
-						void *object)
-{
-	struct kasan_alloc_meta *alloc_meta;
-
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (!alloc_meta)
-		return NULL;
-
-	return &alloc_meta->alloc_track;
-}
-
-struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-						void *object, u8 tag)
-{
-	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREETRACK)
-		return NULL;
-	/* Free meta must be present with KASAN_SLAB_FREETRACK. */
-	return &kasan_get_free_meta(cache, object)->free_track;
-}
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 348dc207d462..74d21786ef09 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -127,6 +127,27 @@ const char *kasan_get_bug_type(struct kasan_report_info *info)
 	return get_wild_bug_type(info);
 }
 
+struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
+						void *object)
+{
+	struct kasan_alloc_meta *alloc_meta;
+
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (!alloc_meta)
+		return NULL;
+
+	return &alloc_meta->alloc_track;
+}
+
+struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
+						void *object, u8 tag)
+{
+	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREETRACK)
+		return NULL;
+	/* Free meta must be present with KASAN_SLAB_FREETRACK. */
+	return &kasan_get_free_meta(cache, object)->free_track;
+}
+
 void kasan_metadata_fetch_row(char *buffer, void *row)
 {
 	memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 35cf3cae4aa4..79b6497d8a81 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -21,3 +21,15 @@ const char *kasan_get_bug_type(struct kasan_report_info *info)
 
 	return "invalid-access";
 }
+
+struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
+						void *object)
+{
+	return NULL;
+}
+
+struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
+						void *object, u8 tag)
+{
+	return NULL;
+}
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index fd11d10a4ffc..39a0481e5228 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -24,15 +24,3 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 void kasan_save_free_info(struct kmem_cache *cache, void *object)
 {
 }
-
-struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
-						void *object)
-{
-	return NULL;
-}
-
-struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-						void *object, u8 tag)
-{
-	return NULL;
-}
-- 
2.25.1

