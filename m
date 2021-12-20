Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D3947B592
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhLTWAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhLTWAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:00:06 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1122C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:00:05 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640037603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hS4TohLHRNxTcrS94rr2W3I/olYmo6cospSu32Gn/iI=;
        b=HfTr9ZPx0J5uhTNvfzDfN3G+Jav4FuGsM6+XrUYpbqfJCMkic2FznTsJ9U0WdBUGBrjE7P
        ZINR7iLX5iRhr59bXHoRIoFgFgEsl15Naav2oi4RriIx2lYS14XA36JJJToA8Ji4dEHCaq
        LTskPirBTuohbcgAyuFusBPJfuRwBSU=
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
Subject: [PATCH mm v4 12/39] kasan, page_alloc: move SetPageSkipKASanPoison in post_alloc_hook
Date:   Mon, 20 Dec 2021 22:59:27 +0100
Message-Id: <c85e5280566f113353f0c0f542304208e186dcaa.1640036051.git.andreyknvl@google.com>
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
index 2d1e63a01ed8..076c43f369b4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2434,9 +2434,6 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		init = false;
 	}
 	if (kasan_has_integrated_init()) {
-		if (gfp_flags & __GFP_SKIP_KASAN_POISON)
-			SetPageSkipKASanPoison(page);
-
 		if (!init_tags)
 			kasan_unpoison_pages(page, order, init);
 	} else {
@@ -2445,6 +2442,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
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

