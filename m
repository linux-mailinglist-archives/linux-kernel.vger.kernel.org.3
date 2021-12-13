Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DE24736FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbhLMVyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240393AbhLMVyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:54:52 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45EFC061748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:54:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639432490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=049z7ZWTue9UJQyuIOFEPdRayr1xnumxPN0uhYB9vCs=;
        b=YvdW6wS86xmdofVuqHB+O+COTxguO1gaWYg66sC6QTKITmfpIz0/UoW+syfaMIJYp3dYBf
        fV5E8MecM4NTorDpoz2kV/x959cLwgHpdx1Popw06XrNqxIBSnnbpn+fX1KY2jetsxdU0y
        Q74/RVazP8NMMU+RFZPfiXPaqkdd96Q=
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
Subject: [PATCH mm v3 27/38] kasan, page_alloc: allow skipping unpoisoning for HW_TAGS
Date:   Mon, 13 Dec 2021 22:54:23 +0100
Message-Id: <e9696ef1484c7057d1c048dda15819ac19dd4bea.1639432170.git.andreyknvl@google.com>
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

Add a new GFP flag __GFP_SKIP_KASAN_UNPOISON that allows skipping KASAN
poisoning for page_alloc allocations. The flag is only effective with
HW_TAGS KASAN.

This flag will be used by vmalloc code for page_alloc allocations
backing vmalloc() mappings in a following patch. The reason to skip
KASAN poisoning for these pages in page_alloc is because vmalloc code
will be poisoning them instead.

Also reword the comment for __GFP_SKIP_KASAN_POISON.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Update patch description.
---
 include/linux/gfp.h | 18 +++++++++++-------
 mm/page_alloc.c     | 24 +++++++++++++++++-------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 42b845cdc131..6781f84345d1 100644
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
@@ -231,21 +232,24 @@ struct vm_area_struct;
  * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
  * is being zeroed (either via __GFP_ZERO or via init_on_alloc).
  *
- * %__GFP_SKIP_KASAN_POISON returns a page which does not need to be poisoned
- * on deallocation. Typically used for userspace pages. Currently only has an
- * effect in HW tags mode.
+ * %__GFP_SKIP_KASAN_UNPOISON makes KASAN skip unpoisoning on page allocation.
+ * Only effective in HW_TAGS mode.
+ *
+ * %__GFP_SKIP_KASAN_POISON makes KASAN skip poisoning on page deallocation.
+ * Typically, used for userspace pages. Only effective in HW_TAGS mode.
  */
 #define __GFP_NOWARN	((__force gfp_t)___GFP_NOWARN)
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
index 497db24ed169..f1d5b80591c4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2394,6 +2394,21 @@ static bool check_new_pages(struct page *page, unsigned int order)
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
@@ -2433,13 +2448,8 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
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

