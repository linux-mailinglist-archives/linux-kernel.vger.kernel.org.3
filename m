Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3AD47B591
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhLTWAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:00:01 -0500
Received: from out1.migadu.com ([91.121.223.63]:41174 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhLTWAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:00:00 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640037599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ck703MMF+hkIiVkCv36NAeyoAOxabatRHXeIzXIavPs=;
        b=Pg8Q16GRQ5f+3xtHC3bSQKhYHkINCuznCSAfiHemZOc1A7FcziWjHQsKG90Q8WUuiTOXhh
        MEmlXEzOyNIGd4Fbsd2f7boXzaW0l0gwrPrqbnI9FzLnn8fd+tpVJQgkG65xmkpsJI9p58
        WEUtY9rc9sGPjghPTyfh7Q6oAxXUyXU=
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
Subject: [PATCH mm v4 11/39] kasan, page_alloc: combine tag_clear_highpage calls in post_alloc_hook
Date:   Mon, 20 Dec 2021 22:59:26 +0100
Message-Id: <c5366f47d79bb98287527109886fdbbddcba4aab.1640036051.git.andreyknvl@google.com>
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

Move tag_clear_highpage() loops out of the kasan_has_integrated_init()
clause as a code simplification.

This patch does no functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

---

Changes v2->v3:
- Update patch description.
---
 mm/page_alloc.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a2e32a8abd7f..2d1e63a01ed8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2418,30 +2418,30 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	 * KASAN unpoisoning and memory initializion code must be
 	 * kept together to avoid discrepancies in behavior.
 	 */
+
+	/*
+	 * If memory tags should be zeroed (which happens only when memory
+	 * should be initialized as well).
+	 */
+	if (init_tags) {
+		int i;
+
+		/* Initialize both memory and tags. */
+		for (i = 0; i != 1 << order; ++i)
+			tag_clear_highpage(page + i);
+
+		/* Note that memory is already initialized by the loop above. */
+		init = false;
+	}
 	if (kasan_has_integrated_init()) {
 		if (gfp_flags & __GFP_SKIP_KASAN_POISON)
 			SetPageSkipKASanPoison(page);
 
-		if (init_tags) {
-			int i;
-
-			for (i = 0; i != 1 << order; ++i)
-				tag_clear_highpage(page + i);
-		} else {
+		if (!init_tags)
 			kasan_unpoison_pages(page, order, init);
-		}
 	} else {
 		kasan_unpoison_pages(page, order, init);
 
-		if (init_tags) {
-			int i;
-
-			for (i = 0; i < 1 << order; i++)
-				tag_clear_highpage(page + i);
-
-			init = false;
-		}
-
 		if (init)
 			kernel_init_free_pages(page, 1 << order);
 	}
-- 
2.25.1

