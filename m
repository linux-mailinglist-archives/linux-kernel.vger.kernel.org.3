Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53CF4640CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhK3V4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:56:04 -0500
Received: from out2.migadu.com ([188.165.223.204]:39674 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbhK3V4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:56:02 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638309162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pa5aYso7nciPjt1f2qi7koMfMaeRn4xXqoVuFKoOwqk=;
        b=ovqDCQ5WFqbvqFlujRhdgfHyRhj0li6Uh8zEZoLw0YRF7N7vlLb+Z/TKzFHDNlp+uBlNoZ
        z59SHNsgGW6De2oF4SHQrCFN3Q6BhwK/eqT/rkJdFzrZmTqkBnUXAZcOtUMRI9f3smLrQN
        Erhhq8U2zOb7zWVxbl6fZyh+JKgaNbs=
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
Subject: [PATCH 10/31] kasan, page_alloc: combine tag_clear_highpage calls in post_alloc_hook
Date:   Tue, 30 Nov 2021 22:52:40 +0100
Message-Id: <48a7a39ddb6fbee4bab6750121d7349eb0364be7.1638308023.git.andreyknvl@google.com>
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

The patch moves tag_clear_highpage() loops out of the
kasan_has_integrated_init() clause as a code simplification.

This patch does no functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/page_alloc.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2a85aeb45ec1..e3e9fefbce43 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2405,30 +2405,30 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
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

