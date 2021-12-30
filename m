Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88CB481F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbhL3TMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:12:50 -0500
Received: from out0.migadu.com ([94.23.1.103]:57566 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240361AbhL3TMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:12:49 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640891568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UPKTOfGemEkoQbDp819rZg49kcfBuqLexV6afOkLkJE=;
        b=F2kuBLZ2zi7WWrx0OgUEti6HE8AdsbERH0bYEjQdwaV3lHwS8/aWxqsECkUZUBzHrJIf12
        8avmYHBAETPsv1+WVbqI3sOldeECHHgTmEDKxfs0xyicCZ2WlcFKXGtr7ZEMymTfZWdZBQ
        G7uHIiYhDLHPjnBa4Q9wZt8LyHByKk4=
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
Subject: [PATCH mm v5 02/39] kasan, page_alloc: move tag_clear_highpage out of kernel_init_free_pages
Date:   Thu, 30 Dec 2021 20:12:04 +0100
Message-Id: <3d8f0ec4b71fd639db321781e0862584978162b6.1640891329.git.andreyknvl@google.com>
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

Currently, kernel_init_free_pages() serves two purposes: it either only
zeroes memory or zeroes both memory and memory tags via a different
code path. As this function has only two callers, each using only one
code path, this behaviour is confusing.

Pull the code that zeroes both memory and tags out of
kernel_init_free_pages().

As a result of this change, the code in free_pages_prepare() starts to
look complicated, but this is improved in the few following patches.
Those improvements are not integrated into this patch to make diffs
easier to read.

This patch does no functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

---

Changes v2->v3:
- Update patch description.
---
 mm/page_alloc.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8ecc715a3614..106c427ff8b8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1282,16 +1282,10 @@ static inline bool should_skip_kasan_poison(struct page *page, fpi_t fpi_flags)
 	       PageSkipKASanPoison(page);
 }
 
-static void kernel_init_free_pages(struct page *page, int numpages, bool zero_tags)
+static void kernel_init_free_pages(struct page *page, int numpages)
 {
 	int i;
 
-	if (zero_tags) {
-		for (i = 0; i < numpages; i++)
-			tag_clear_highpage(page + i);
-		return;
-	}
-
 	/* s390's use of memset() could override KASAN redzones. */
 	kasan_disable_current();
 	for (i = 0; i < numpages; i++) {
@@ -1387,7 +1381,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		bool init = want_init_on_free();
 
 		if (init)
-			kernel_init_free_pages(page, 1 << order, false);
+			kernel_init_free_pages(page, 1 << order);
 		if (!skip_kasan_poison)
 			kasan_poison_pages(page, order, init);
 	}
@@ -2430,9 +2424,17 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags);
 
 		kasan_unpoison_pages(page, order, init);
-		if (init)
-			kernel_init_free_pages(page, 1 << order,
-					       gfp_flags & __GFP_ZEROTAGS);
+
+		if (init) {
+			if (gfp_flags & __GFP_ZEROTAGS) {
+				int i;
+
+				for (i = 0; i < 1 << order; i++)
+					tag_clear_highpage(page + i);
+			} else {
+				kernel_init_free_pages(page, 1 << order);
+			}
+		}
 	}
 
 	set_page_owner(page, order, gfp_flags);
-- 
2.25.1

