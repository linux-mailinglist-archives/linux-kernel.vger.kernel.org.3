Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36A1481F92
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241858AbhL3TNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:13:36 -0500
Received: from out1.migadu.com ([91.121.223.63]:11385 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241839AbhL3TNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:13:18 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640891597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDNFc5UvCUKs8p8aVVL2SzowdanE4VeRdtYVMovopAs=;
        b=VuYGh7eMgdqxpmMer0bWIo/JMOx6QMZJ4hLyIdw6yu71dtJ8mvupqcLiMOLSHXpGnjWlUh
        wIhK0BrCyrQP0H8cyjLYCiGnD1CVWYu6XORZMyxq5/2cmAgIc0aGUCraxPfpYXW2FrrqRv
        JYsIVerjqv+ld2AMz1NI9GSyznRC3h8=
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
Subject: [PATCH mm v5 12/39] kasan, page_alloc: move SetPageSkipKASanPoison in post_alloc_hook
Date:   Thu, 30 Dec 2021 20:12:14 +0100
Message-Id: <7597c0ebcb1c2b46241c44a3307e21a7418f5df6.1640891329.git.andreyknvl@google.com>
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

Pull the SetPageSkipKASanPoison() call in post_alloc_hook() out of the
big if clause for better code readability. This also allows for more
simplifications in the following patches.

Also turn the kasan_has_integrated_init() check into the proper
kasan_hw_tags_enabled() one. These checks evaluate to the same value,
but logically skipping kasan poisoning has nothing to do with
integrated init.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v3->v4:
- Use proper kasan_hw_tags_enabled() check instead of
  IS_ENABLED(CONFIG_KASAN_HW_TAGS).
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2fe02d216c5e..d96a43db90c8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2435,9 +2435,6 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		init = false;
 	}
 	if (kasan_has_integrated_init()) {
-		if (gfp_flags & __GFP_SKIP_KASAN_POISON)
-			SetPageSkipKASanPoison(page);
-
 		if (!init_tags)
 			kasan_unpoison_pages(page, order, init);
 	} else {
@@ -2446,6 +2443,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		if (init)
 			kernel_init_free_pages(page, 1 << order);
 	}
+	/* Propagate __GFP_SKIP_KASAN_POISON to page flags. */
+	if (kasan_hw_tags_enabled() && (gfp_flags & __GFP_SKIP_KASAN_POISON))
+		SetPageSkipKASanPoison(page);
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
-- 
2.25.1

