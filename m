Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0393F4736D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbhLMVwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbhLMVwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:52:43 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB5BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:52:43 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639432361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+nNbb3pTxbMZ8HlsYjmZQU7bd/tE4UK1EaMgljEPUA=;
        b=n4IarGd7GfBcJfK4eocxz90aqKtmBoviEvEsqEt+tX6KvseLcz6XKgoHyZ1sAcV/bXHih9
        g/x9ppTwIxTFw7ndmGoP9xvyRCqjE8dhgwcKL81bBnbXcsxCkHFRzzd+RyQ8yDAU2DtqM/
        R5VyZPhxzS+5OFQGZoa5g4IocjuFFe4=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v3 10/38] kasan, page_alloc: merge kasan_alloc_pages into post_alloc_hook
Date:   Mon, 13 Dec 2021 22:51:29 +0100
Message-Id: <d1543b79ed7771b0719600845a74fa72a29497ac.1639432170.git.andreyknvl@google.com>
In-Reply-To: <cover.1639432170.git.andreyknvl@google.com>
References: <cover.1639432170.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: andrey.konovalov@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Currently, the code responsible for initializing and poisoning memory in
post_alloc_hook() is scattered across two locations: kasan_alloc_pages()
hook for HW_TAGS KASAN and post_alloc_hook() itself. This is confusing.

This and a few following patches combine the code from these two
locations. Along the way, these patches do a step-by-step restructure
the many performed checks to make them easier to follow.

Replace the only caller of kasan_alloc_pages() with its implementation.

As kasan_has_integrated_init() is only true when CONFIG_KASAN_HW_TAGS
is enabled, moving the code does no functional changes.

Also move init and init_tags variables definitions out of
kasan_has_integrated_init() clause in post_alloc_hook(), as they have
the same values regardless of what the if condition evaluates to.

This patch is not useful by itself but makes the simplifications in
the following patches easier to follow.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Update patch description.
---
 include/linux/kasan.h |  9 ---------
 mm/kasan/common.c     |  2 +-
 mm/kasan/hw_tags.c    | 22 ----------------------
 mm/page_alloc.c       | 20 +++++++++++++++-----
 4 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index a8bfe9f157c9..b88ca6b97ba3 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -95,8 +95,6 @@ static inline bool kasan_hw_tags_enabled(void)
 	return kasan_enabled();
 }
 
-void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags);
-
 #else /* CONFIG_KASAN_HW_TAGS */
 
 static inline bool kasan_enabled(void)
@@ -109,13 +107,6 @@ static inline bool kasan_hw_tags_enabled(void)
 	return false;
 }
 
-static __always_inline void kasan_alloc_pages(struct page *page,
-					      unsigned int order, gfp_t flags)
-{
-	/* Only available for integrated init. */
-	BUILD_BUG();
-}
-
 #endif /* CONFIG_KASAN_HW_TAGS */
 
 static inline bool kasan_has_integrated_init(void)
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a0082fad48b1..d9079ec11f31 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -538,7 +538,7 @@ void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
 		return NULL;
 
 	/*
-	 * The object has already been unpoisoned by kasan_alloc_pages() for
+	 * The object has already been unpoisoned by kasan_unpoison_pages() for
 	 * alloc_pages() or by kasan_krealloc() for krealloc().
 	 */
 
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index c643740b8599..76cf2b6229c7 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -192,28 +192,6 @@ void __init kasan_init_hw_tags(void)
 		kasan_stack_collection_enabled() ? "on" : "off");
 }
 
-void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags)
-{
-	/*
-	 * This condition should match the one in post_alloc_hook() in
-	 * page_alloc.c.
-	 */
-	bool init = !want_init_on_free() && want_init_on_alloc(flags);
-	bool init_tags = init && (flags & __GFP_ZEROTAGS);
-
-	if (flags & __GFP_SKIP_KASAN_POISON)
-		SetPageSkipKASanPoison(page);
-
-	if (init_tags) {
-		int i;
-
-		for (i = 0; i != 1 << order; ++i)
-			tag_clear_highpage(page + i);
-	} else {
-		kasan_unpoison_pages(page, order, init);
-	}
-}
-
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
 void kasan_enable_tagging_sync(void)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ecdf2124ac1..a2e32a8abd7f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2397,6 +2397,9 @@ static bool check_new_pages(struct page *page, unsigned int order)
 inline void post_alloc_hook(struct page *page, unsigned int order,
 				gfp_t gfp_flags)
 {
+	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags);
+	bool init_tags = init && (gfp_flags & __GFP_ZEROTAGS);
+
 	set_page_private(page, 0);
 	set_page_refcounted(page);
 
@@ -2412,15 +2415,22 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	/*
 	 * As memory initialization might be integrated into KASAN,
-	 * kasan_alloc_pages and kernel_init_free_pages must be
+	 * KASAN unpoisoning and memory initializion code must be
 	 * kept together to avoid discrepancies in behavior.
 	 */
 	if (kasan_has_integrated_init()) {
-		kasan_alloc_pages(page, order, gfp_flags);
-	} else {
-		bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags);
-		bool init_tags = init && (gfp_flags & __GFP_ZEROTAGS);
+		if (gfp_flags & __GFP_SKIP_KASAN_POISON)
+			SetPageSkipKASanPoison(page);
+
+		if (init_tags) {
+			int i;
 
+			for (i = 0; i != 1 << order; ++i)
+				tag_clear_highpage(page + i);
+		} else {
+			kasan_unpoison_pages(page, order, init);
+		}
+	} else {
 		kasan_unpoison_pages(page, order, init);
 
 		if (init_tags) {
-- 
2.25.1

