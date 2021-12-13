Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EFA4736DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbhLMVxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:53:35 -0500
Received: from out0.migadu.com ([94.23.1.103]:19059 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234715AbhLMVxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:53:34 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639432411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0xyJR8h0NzK4f0d23y72W+ijwLL48MO0qPoTx5MTdw=;
        b=s8HCaE0IPffQ/paWYTaqDRdMItrQEHpcf8g/XkSpejUkJdWroGRFfYID4GBwIqqwNtGV+e
        jod2WDG+hWsWAW3d11enpKYrIyDe/b3CkgLDo4glrrP3lzATK9D5aOUiaz4LP4yVCFhwCf
        L//YYtC1GvomrtHNRV/RytDwx2lhwtc=
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
Subject: [PATCH mm v3 11/38] kasan, page_alloc: combine tag_clear_highpage calls in post_alloc_hook
Date:   Mon, 13 Dec 2021 22:53:01 +0100
Message-Id: <585c27bfa692331cd75de7c9dc713a318d3db466.1639432170.git.andreyknvl@google.com>
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

Move tag_clear_highpage() loops out of the kasan_has_integrated_init()
clause as a code simplification.

This patch does no functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

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

