Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B4D47B5AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhLTWCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:02:34 -0500
Received: from out1.migadu.com ([91.121.223.63]:42554 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232290AbhLTWCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:02:23 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640037742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YFZt1HrIZYuYxTaQojTxU5EnY7ilBJpM8FVgR+Q355s=;
        b=lY1RxKt7gOLGSmTHnPz32PoVri598laX7yZWzTICAmdwmwSF3eTnU/Orzc4PGtR2H5oNdf
        mcNDFxEuf+Ib2xfrnSIO/ZROFAo0gzYLb+pb45dk5qqGceJOai52r/1V1tFk1kSnBZj6/A
        Qfp4p6VPI3wF3HW+wX00y8uDkFqjgAw=
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
Subject: [PATCH mm v4 29/39] kasan, page_alloc: allow skipping memory init for HW_TAGS
Date:   Mon, 20 Dec 2021 23:02:01 +0100
Message-Id: <dea9eb126793544650ff433612016016070ceb52.1640036051.git.andreyknvl@google.com>
In-Reply-To: <cover.1640036051.git.andreyknvl@google.com>
References: <cover.1640036051.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add a new GFP flag __GFP_SKIP_ZERO that allows to skip memory
initialization. The flag is only effective with HW_TAGS KASAN.

This flag will be used by vmalloc code for page_alloc allocations
backing vmalloc() mappings in a following patch. The reason to skip
memory initialization for these pages in page_alloc is because vmalloc
code will be initializing them instead.

With the current implementation, when __GFP_SKIP_ZERO is provided,
__GFP_ZEROTAGS is ignored. This doesn't matter, as these two flags are
never provided at the same time. However, if this is changed in the
future, this particular implementation detail can be changed as well.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v3->v4:
- Only define __GFP_SKIP_ZERO when CONFIG_KASAN_HW_TAGS is enabled.
- Add __GFP_SKIP_ZERO to include/trace/events/mmflags.h.
- Use proper kasan_hw_tags_enabled() check instead of
  IS_ENABLED(CONFIG_KASAN_HW_TAGS). Also add explicit checks for
  software modes.

Changes v2->v3:
- Update patch description.

Changes v1->v2:
- Add this patch.
---
 include/linux/gfp.h            | 16 ++++++++++++----
 include/trace/events/mmflags.h |  1 +
 mm/page_alloc.c                | 18 +++++++++++++++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 600f0749c3f2..c7ebc93296ed 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -55,14 +55,16 @@ struct vm_area_struct;
 #define ___GFP_ACCOUNT		0x400000u
 #define ___GFP_ZEROTAGS		0x800000u
 #ifdef CONFIG_KASAN_HW_TAGS
-#define ___GFP_SKIP_KASAN_UNPOISON	0x1000000u
-#define ___GFP_SKIP_KASAN_POISON	0x2000000u
+#define ___GFP_SKIP_ZERO		0x1000000u
+#define ___GFP_SKIP_KASAN_UNPOISON	0x2000000u
+#define ___GFP_SKIP_KASAN_POISON	0x4000000u
 #else
+#define ___GFP_SKIP_ZERO		0
 #define ___GFP_SKIP_KASAN_UNPOISON	0
 #define ___GFP_SKIP_KASAN_POISON	0
 #endif
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x4000000u
+#define ___GFP_NOLOCKDEP	0x8000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -235,7 +237,11 @@ struct vm_area_struct;
  * %__GFP_ZERO returns a zeroed page on success.
  *
  * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
- * is being zeroed (either via __GFP_ZERO or via init_on_alloc).
+ * is being zeroed (either via __GFP_ZERO or via init_on_alloc, provided that
+ * __GFP_SKIP_ZERO is not set).
+ *
+ * %__GFP_SKIP_ZERO makes page_alloc skip zeroing memory.
+ * Only effective when HW_TAGS KASAN is enabled.
  *
  * %__GFP_SKIP_KASAN_UNPOISON makes KASAN skip unpoisoning on page allocation.
  * Only effective in HW_TAGS mode.
@@ -247,6 +253,7 @@ struct vm_area_struct;
 #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
 #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
 #define __GFP_ZEROTAGS	((__force gfp_t)___GFP_ZEROTAGS)
+#define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
 #define __GFP_SKIP_KASAN_UNPOISON ((__force gfp_t)___GFP_SKIP_KASAN_UNPOISON)
 #define __GFP_SKIP_KASAN_POISON   ((__force gfp_t)___GFP_SKIP_KASAN_POISON)
 
@@ -255,6 +262,7 @@ struct vm_area_struct;
 
 /* Room for N __GFP_FOO bits */
 #define __GFP_BITS_SHIFT (24 +					\
+			  IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
 			  IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
 			  IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
 			  IS_ENABLED(CONFIG_LOCKDEP))
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 1329d9c4df56..f18eeb5fdde2 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -52,6 +52,7 @@
 
 #ifdef CONFIG_KASAN_HW_TAGS
 #define __def_gfpflag_names_kasan					      \
+	, {(unsigned long)__GFP_SKIP_ZERO, "__GFP_SKIP_ZERO"}		      \
 	, {(unsigned long)__GFP_SKIP_KASAN_POISON, "__GFP_SKIP_KASAN_POISON"} \
 	, {(unsigned long)__GFP_SKIP_KASAN_UNPOISON,			      \
 						"__GFP_SKIP_KASAN_UNPOISON"}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2076b5cc7e2c..5e22068d4acb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2414,10 +2414,26 @@ static inline bool should_skip_kasan_unpoison(gfp_t flags, bool init_tags)
 	return init_tags || (flags & __GFP_SKIP_KASAN_UNPOISON);
 }
 
+static inline bool should_skip_init(gfp_t flags)
+{
+	/* Don't skip if a software KASAN mode is enabled. */
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
+	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+		return false;
+
+	/* Don't skip, if hardware tag-based KASAN is not enabled. */
+	if (!kasan_hw_tags_enabled())
+		return false;
+
+	/* For hardware tag-based KASAN, skip if requested. */
+	return (flags & __GFP_SKIP_ZERO);
+}
+
 inline void post_alloc_hook(struct page *page, unsigned int order,
 				gfp_t gfp_flags)
 {
-	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags);
+	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
+			!should_skip_init(gfp_flags);
 	bool init_tags = init && (gfp_flags & __GFP_ZEROTAGS);
 
 	set_page_private(page, 0);
-- 
2.25.1

