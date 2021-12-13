Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447A04736C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243203AbhLMVwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbhLMVwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:52:12 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BE3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:52:11 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639432330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/H8xEvLFjZpRKDTHcIRqvJZF1FN7N83kytVLUev48w=;
        b=RU4B+gZHDI9itDnuYpC93S28E3z8WcdMO41jsEOZpHLbSu3BCce89t5cQGIPf66hKE3By4
        6MqlPIKu2ZXjSiATCbbiHui1+0+YiCHmTqyWQf17JNdXLn3JItiX5754T7LomyZY/+l7Ob
        iOtfifAKwhwnlPviuvJL+Lk0lB7vUu0=
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
Subject: [PATCH mm v3 03/38] kasan, page_alloc: merge kasan_free_pages into free_pages_prepare
Date:   Mon, 13 Dec 2021 22:51:22 +0100
Message-Id: <fbd6374a0687dde28d04062807bd0764f0291dfc.1639432170.git.andreyknvl@google.com>
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

Currently, the code responsible for initializing and poisoning memory
in free_pages_prepare() is scattered across two locations:
kasan_free_pages() for HW_TAGS KASAN and free_pages_prepare() itself.
This is confusing.

This and a few following patches combine the code from these two
locations. Along the way, these patches also simplify the performed
checks to make them easier to follow.

Replaces the only caller of kasan_free_pages() with its implementation.

As kasan_has_integrated_init() is only true when CONFIG_KASAN_HW_TAGS
is enabled, moving the code does no functional changes.

This patch is not useful by itself but makes the simplifications in
the following patches easier to follow.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

---

Changes v2->v3:
- Update patch description.
---
 include/linux/kasan.h |  8 --------
 mm/kasan/common.c     |  2 +-
 mm/kasan/hw_tags.c    | 11 -----------
 mm/page_alloc.c       |  6 ++++--
 4 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 4a45562d8893..a8bfe9f157c9 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -96,7 +96,6 @@ static inline bool kasan_hw_tags_enabled(void)
 }
 
 void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags);
-void kasan_free_pages(struct page *page, unsigned int order);
 
 #else /* CONFIG_KASAN_HW_TAGS */
 
@@ -117,13 +116,6 @@ static __always_inline void kasan_alloc_pages(struct page *page,
 	BUILD_BUG();
 }
 
-static __always_inline void kasan_free_pages(struct page *page,
-					     unsigned int order)
-{
-	/* Only available for integrated init. */
-	BUILD_BUG();
-}
-
 #endif /* CONFIG_KASAN_HW_TAGS */
 
 static inline bool kasan_has_integrated_init(void)
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 92196562687b..a0082fad48b1 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -387,7 +387,7 @@ static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
 	}
 
 	/*
-	 * The object will be poisoned by kasan_free_pages() or
+	 * The object will be poisoned by kasan_poison_pages() or
 	 * kasan_slab_free_mempool().
 	 */
 
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 7355cb534e4f..0b8225add2e4 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -213,17 +213,6 @@ void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags)
 	}
 }
 
-void kasan_free_pages(struct page *page, unsigned int order)
-{
-	/*
-	 * This condition should match the one in free_pages_prepare() in
-	 * page_alloc.c.
-	 */
-	bool init = want_init_on_free();
-
-	kasan_poison_pages(page, order, init);
-}
-
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
 void kasan_enable_tagging_sync(void)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7c2b29483b53..740fb01a27ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1367,15 +1367,17 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	/*
 	 * As memory initialization might be integrated into KASAN,
-	 * kasan_free_pages and kernel_init_free_pages must be
+	 * KASAN poisoning and memory initialization code must be
 	 * kept together to avoid discrepancies in behavior.
 	 *
 	 * With hardware tag-based KASAN, memory tags must be set before the
 	 * page becomes unavailable via debug_pagealloc or arch_free_page.
 	 */
 	if (kasan_has_integrated_init()) {
+		bool init = want_init_on_free();
+
 		if (!skip_kasan_poison)
-			kasan_free_pages(page, order);
+			kasan_poison_pages(page, order, init);
 	} else {
 		bool init = want_init_on_free();
 
-- 
2.25.1

