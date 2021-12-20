Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A2347B57D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhLTV7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:59:15 -0500
Received: from out2.migadu.com ([188.165.223.204]:39315 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231902AbhLTV7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:59:12 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640037551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lLRehdStIsdn/AnAQZ01/ErmphlQVweFQPGIsWoJgns=;
        b=F97bEeeJRBQ6SBfM8fEN6e04Gk+8U56Ay0CPWDT/0FoSQ5WywdPJss3TaT8Qi8CzXsFbNp
        4OvNMq+tEPxSvviK5eKG3AI2hTLTyOmv7wJNc7KjpDJzx/ZAWkGToWmZ9cHZC9i8JnLV9g
        UszEur2mlNqkGExuUYRpQSUsv7aXxJ4=
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
Subject: [PATCH mm v4 06/39] kasan: drop skip_kasan_poison variable in free_pages_prepare
Date:   Mon, 20 Dec 2021 22:58:21 +0100
Message-Id: <91c2d00aabbfda5dea828301d3a508a2abdbf686.1640036051.git.andreyknvl@google.com>
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

skip_kasan_poison is only used in a single place.
Call should_skip_kasan_poison() directly for simplicity.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Suggested-by: Marco Elver <elver@google.com>

---

Changes v1->v2:
- Add this patch.
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 114d6b010331..73280222e0e8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1300,7 +1300,6 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			unsigned int order, bool check_free, fpi_t fpi_flags)
 {
 	int bad = 0;
-	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
 	bool init = want_init_on_free();
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
@@ -1374,7 +1373,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	 * With hardware tag-based KASAN, memory tags must be set before the
 	 * page becomes unavailable via debug_pagealloc or arch_free_page.
 	 */
-	if (!skip_kasan_poison) {
+	if (!should_skip_kasan_poison(page, fpi_flags)) {
 		kasan_poison_pages(page, order, init);
 
 		/* Memory is already initialized if KASAN did it internally. */
-- 
2.25.1

