Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310D54736DD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbhLMVxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:53:42 -0500
Received: from out0.migadu.com ([94.23.1.103]:19132 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235303AbhLMVxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:53:41 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639432420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s3l2s0+hmq5iLRz8+HP6zciVmRfmK7g/3R40/Nt6UW0=;
        b=wBlPvUruWkc1kjP1gg1zDNoG4Eki8kBtbhNaAX1aYazZNE91cyGrEqS3b6kRhEzrGI5HDB
        ZtxmTKjm0r5QDTGhOciWBqkMVoDUOpIdqqOc1vIY3i+BTj2Vx52UI//DM2NIW7aG45g7Bm
        noOTCGSWqoOkr4YNZLEBGMpEOugbQaM=
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
Subject: [PATCH mm v3 13/38] kasan, page_alloc: move kernel_init_free_pages in post_alloc_hook
Date:   Mon, 13 Dec 2021 22:53:03 +0100
Message-Id: <6f430d8dd55a22e141b0000357890d872b8cd487.1639432170.git.andreyknvl@google.com>
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

Pull the kernel_init_free_pages() call in post_alloc_hook() out of the
big if clause for better code readability. This also allows for more
simplifications in the following patch.

This patch does no functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/page_alloc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3dba92accfb7..90a2f353d230 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2434,14 +2434,18 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		init = false;
 	}
 	if (kasan_has_integrated_init()) {
-		if (!init_tags)
+		if (!init_tags) {
 			kasan_unpoison_pages(page, order, init);
+
+			/* Note that memory is already initialized by KASAN. */
+			init = false;
+		}
 	} else {
 		kasan_unpoison_pages(page, order, init);
-
-		if (init)
-			kernel_init_free_pages(page, 1 << order);
 	}
+	/* If memory is still not initialized, do it now. */
+	if (init)
+		kernel_init_free_pages(page, 1 << order);
 	/* Propagate __GFP_SKIP_KASAN_POISON to page flags. */
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&
 	    (gfp_flags & __GFP_SKIP_KASAN_POISON))
-- 
2.25.1

