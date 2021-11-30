Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42E6464117
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbhK3WNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:13:21 -0500
Received: from out1.migadu.com ([91.121.223.63]:58349 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344608AbhK3WLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:11:31 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638310090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/6qJwit6ITW8lPGUAdTPjRxCn0EQ40SKku7cvq8gPsA=;
        b=Z4Yuz3BRckT0pZZtivLkslb47vrrWnkskR/i1AYmyXGZ6nnU6ad48vgnRdp4m8E/f+7DE4
        n+d0qMciv/EuNLT+EhFYzdNjD6DuBFLdl0jdnhHG21fKR2Qdhlfm19buPMrJZXcdD3vdUI
        vDWH8ymk4nMxlLZUsj4ZdoJikhsjO2g=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 26/31] kasan, page_alloc: allow skipping unpoisoning for HW_TAGS
Date:   Tue, 30 Nov 2021 23:08:08 +0100
Message-Id: <e60cbad6f4f8ee08137671c008c83ab26255e9bf.1638308023.git.andreyknvl@google.com>
In-Reply-To: <cover.1638308023.git.andreyknvl@google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

This patch add a new GFP flag __GFP_SKIP_KASAN_UNPOISON that allows
skipping KASAN poisoning for page_alloc allocations. The flag is only
effective with HW_TAGS KASAN.

This flag will be used by vmalloc code for page_alloc allocations
backing vmalloc() mappings in the following patch. The reason to skip
KASAN poisoning for these pages in page_alloc is because vmalloc code
will be poisoning them instead.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/gfp.h | 13 +++++++++----
 mm/page_alloc.c     | 24 +++++++++++++++++-------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index dddd7597689f..a4c8ff3fbed1 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -54,9 +54,10 @@ struct vm_area_struct;
 #define ___GFP_THISNODE		0x200000u
 #define ___GFP_ACCOUNT		0x400000u
 #define ___GFP_ZEROTAGS		0x800000u
-#define ___GFP_SKIP_KASAN_POISON	0x1000000u
+#define ___GFP_SKIP_KASAN_UNPOISON	0x1000000u
+#define ___GFP_SKIP_KASAN_POISON	0x2000000u
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x2000000u
+#define ___GFP_NOLOCKDEP	0x4000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -235,6 +236,9 @@ struct vm_area_struct;
  * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
  * is being zeroed (either via __GFP_ZERO or via init_on_alloc).
  *
+ * %__GFP_SKIP_KASAN_UNPOISON skips KASAN unpoisoning on page allocation.
+ * Currently only has an effect in HW tags mode.
+ *
  * %__GFP_SKIP_KASAN_POISON returns a page which does not need to be poisoned
  * on deallocation. Typically used for userspace pages. Currently only has an
  * effect in HW tags mode.
@@ -243,13 +247,14 @@ struct vm_area_struct;
 #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
 #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
 #define __GFP_ZEROTAGS	((__force gfp_t)___GFP_ZEROTAGS)
-#define __GFP_SKIP_KASAN_POISON	((__force gfp_t)___GFP_SKIP_KASAN_POISON)
+#define __GFP_SKIP_KASAN_UNPOISON ((__force gfp_t)___GFP_SKIP_KASAN_UNPOISON)
+#define __GFP_SKIP_KASAN_POISON   ((__force gfp_t)___GFP_SKIP_KASAN_POISON)
 
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4eb341351124..3afebc037fcd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2381,6 +2381,21 @@ static bool check_new_pages(struct page *page, unsigned int order)
 	return false;
 }
 
+static inline bool should_skip_kasan_unpoison(gfp_t flags, bool init_tags)
+{
+	/* Don't skip if a software KASAN mode is enabled. */
+	if (!IS_ENABLED(CONFIG_KASAN_HW_TAGS))
+		return false;
+
+	/*
+	 * For hardware tag-based KASAN, skip if either:
+	 *
+	 * 1. Memory tags have already been cleared via tag_clear_highpage().
+	 * 2. Skipping has been requested via __GFP_SKIP_KASAN_UNPOISON.
+	 */
+	return init_tags || (flags & __GFP_SKIP_KASAN_UNPOISON);
+}
+
 inline void post_alloc_hook(struct page *page, unsigned int order,
 				gfp_t gfp_flags)
 {
@@ -2420,13 +2435,8 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		/* Note that memory is already initialized by the loop above. */
 		init = false;
 	}
-	/*
-	 * If either a software KASAN mode is enabled, or,
-	 * in the case of hardware tag-based KASAN,
-	 * if memory tags have not been cleared via tag_clear_highpage().
-	 */
-	if (!IS_ENABLED(CONFIG_KASAN_HW_TAGS) || !init_tags) {
-		/* Mark shadow memory or set memory tags. */
+	if (!should_skip_kasan_unpoison(gfp_flags, init_tags)) {
+		/* Unpoison shadow memory or set memory tags. */
 		kasan_unpoison_pages(page, order, init);
 
 		/* Note that memory is already initialized by KASAN. */
-- 
2.25.1

