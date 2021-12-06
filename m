Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD96146AAA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350954AbhLFVro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:47:44 -0500
Received: from out2.migadu.com ([188.165.223.204]:63793 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350916AbhLFVrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:47:43 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638827053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gob2lt41MqESGzJ3aS1cO67hIxM237cUiv6TAp2u4fg=;
        b=fuNxtXvqdyLDZCHw8EYl/QZ9yB8Q4AI0Kt5FffmAuW1+81Vj0jDxwm5fnYFdYCoT07n7ON
        I3T1j1F+9/05GbBX80spdrQS/gD4lF42utJaAAe33bRU6dH1jZJgfdnVMe6mT/11FKvwwK
        uKZNObSdyGR8puOSzvYLSUI25qqEP2o=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 04/34] kasan, page_alloc: simplify kasan_poison_pages call site
Date:   Mon,  6 Dec 2021 22:43:41 +0100
Message-Id: <73d7d82c2b5cf44cb429fbc7cc16479fb8776bbe.1638825394.git.andreyknvl@google.com>
In-Reply-To: <cover.1638825394.git.andreyknvl@google.com>
References: <cover.1638825394.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Simplify the code around calling kasan_poison_pages() in
free_pages_prepare().

This patch does no functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Don't reorder kasan_poison_pages() and free_pages_prepare().
---
 mm/page_alloc.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3f3ea41f8c64..15f76bc1fa3e 100644
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
+	if (init && !kasan_has_integrated_init())
+		kernel_init_free_pages(page, 1 << order);
+	if (!skip_kasan_poison)
+		kasan_poison_pages(page, order, init);
 
 	/*
 	 * arch_free_page() can make the page's contents inaccessible.  s390
-- 
2.25.1

