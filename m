Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D82481FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbhL3TPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbhL3TPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:15:47 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BF6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:15:47 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640891746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAwQcHTlCiYChpYnlNq+QkugFDzxho9e0I/gAsV+YMU=;
        b=AQgDkQD0wIPFHfk3DwCfbzvuGQd5Tr/0yV8e+3KFE+t7PuAACZ43LPLyOAnrZnyF+l71je
        qZRLSHQifFHmU0iCvBFaSARbvhGoAGJzgthAHBGcsoMk0I0wMH00RozL53SOj9/MgduT/d
        /YXyai/y9Ydgn/e3TI7uXi5KcnS65Zo=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
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
Subject: [PATCH mm v5 28/39] kasan, page_alloc: allow skipping unpoisoning for HW_TAGS
Date:   Thu, 30 Dec 2021 20:14:53 +0100
Message-Id: <d23aabe9b20593cbae6c0e304e267f0f8cfe0bfb.1640891329.git.andreyknvl@google.com>
In-Reply-To: <cover.1640891329.git.andreyknvl@google.com>
References: <cover.1640891329.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
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

Changes v4->v5:
- Cosmetic changes to __def_gfpflag_names_kasan and __GFP_BITS_SHIFT.

Changes v3->v4:
- Only define __GFP_SKIP_KASAN_POISON when CONFIG_KASAN_HW_TAGS is
  enabled.

Changes v2->v3:
- Update patch description.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/gfp.h            | 21 +++++++++++++--------
 include/trace/events/mmflags.h |  5 +++--
 mm/page_alloc.c                | 31 ++++++++++++++++++++++---------
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 9dce456d147a..487126f089e1 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -55,12 +55,14 @@ struct vm_area_struct;
 #define ___GFP_ACCOUNT		0x400000u
 #define ___GFP_ZEROTAGS		0x800000u
 #ifdef CONFIG_KASAN_HW_TAGS
-#define ___GFP_SKIP_KASAN_POISON	0x1000000u
+#define ___GFP_SKIP_KASAN_UNPOISON	0x1000000u
+#define ___GFP_SKIP_KASAN_POISON	0x2000000u
 #else
+#define ___GFP_SKIP_KASAN_UNPOISON	0
 #define ___GFP_SKIP_KASAN_POISON	0
 #endif
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x2000000u
+#define ___GFP_NOLOCKDEP	0x4000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -237,22 +239,25 @@ struct vm_area_struct;
  * intended for optimization: setting memory tags at the same time as zeroing
  * memory has minimal additional performace impact.
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
-#define __GFP_BITS_SHIFT (24 +					\
-			  IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
+#define __GFP_BITS_SHIFT (24 +						\
+			  2 * IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
 			  IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 414bf4367283..5ffc7bdce91f 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -51,8 +51,9 @@
 	{(unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"}	\
 
 #ifdef CONFIG_KASAN_HW_TAGS
-#define __def_gfpflag_names_kasan					      \
-	, {(unsigned long)__GFP_SKIP_KASAN_POISON, "__GFP_SKIP_KASAN_POISON"}
+#define __def_gfpflag_names_kasan ,					       \
+	{(unsigned long)__GFP_SKIP_KASAN_POISON,   "__GFP_SKIP_KASAN_POISON"}, \
+	{(unsigned long)__GFP_SKIP_KASAN_UNPOISON, "__GFP_SKIP_KASAN_UNPOISON"}
 #else
 #define __def_gfpflag_names_kasan
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a07f9e9b0abc..102f0cd8815e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2395,6 +2395,26 @@ static bool check_new_pages(struct page *page, unsigned int order)
 	return false;
 }
 
+static inline bool should_skip_kasan_unpoison(gfp_t flags, bool init_tags)
+{
+	/* Don't skip if a software KASAN mode is enabled. */
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
+	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+		return false;
+
+	/* Skip, if hardware tag-based KASAN is not enabled. */
+	if (!kasan_hw_tags_enabled())
+		return true;
+
+	/*
+	 * With hardware tag-based KASAN enabled, skip if either:
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
@@ -2434,15 +2454,8 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		/* Note that memory is already initialized by the loop above. */
 		init = false;
 	}
-	/*
-	 * If either a software KASAN mode is enabled, or,
-	 * in the case of hardware tag-based KASAN,
-	 * if memory tags have not been cleared via tag_clear_highpage().
-	 */
-	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
-	    IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
-	    kasan_hw_tags_enabled() && !init_tags) {
-		/* Mark shadow memory or set memory tags. */
+	if (!should_skip_kasan_unpoison(gfp_flags, init_tags)) {
+		/* Unpoison shadow memory or set memory tags. */
 		kasan_unpoison_pages(page, order, init);
 
 		/* Note that memory is already initialized by KASAN. */
-- 
2.25.1

