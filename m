Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579A6464066
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344324AbhK3VoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:44:21 -0500
Received: from out0.migadu.com ([94.23.1.103]:57231 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240582AbhK3VoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:44:03 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
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
Subject: [PATCH 04/31] kasan, page_alloc: simplify kasan_poison_pages call site
Date:   Tue, 30 Nov 2021 22:39:10 +0100
Message-Id: <b28f30ed5d662439fd2354b7a05e4d58a2889e5f.1638308023.git.andreyknvl@google.com>
In-Reply-To: <cover.1638308023.git.andreyknvl@google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Simplify the code around calling kasan_poison_pages() in
free_pages_prepare().

Reording kasan_poison_pages() and kernel_init_free_pages() is OK,
since kernel_init_free_pages() can handle poisoned memory.

This patch does no functional changes besides reordering the calls.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/page_alloc.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3f3ea41f8c64..0673db27dd12 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1289,6 +1289,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 {
 	int bad = 0;
 	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
+	bool init = want_init_on_free();
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -1359,19 +1360,10 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	 * With hardware tag-based KASAN, memory tags must be set before the
 	 * page becomes unavailable via debug_pagealloc or arch_free_page.
 	 */
-	if (kasan_has_integrated_init()) {
-		bool init = want_init_on_free();
-
-		if (!skip_kasan_poison)
-			kasan_poison_pages(page, order, init);
-	} else {
-		bool init = want_init_on_free();
-
-		if (init)
-			kernel_init_free_pages(page, 1 << order);
-		if (!skip_kasan_poison)
-			kasan_poison_pages(page, order, init);
-	}
+	if (!skip_kasan_poison)
+		kasan_poison_pages(page, order, init);
+	if (init && !kasan_has_integrated_init())
+		kernel_init_free_pages(page, 1 << order);
 
 	/*
 	 * arch_free_page() can make the page's contents inaccessible.  s390
-- 
2.25.1

