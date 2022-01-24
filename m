Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9337F4987AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244909AbiAXSEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:04:07 -0500
Received: from out2.migadu.com ([188.165.223.204]:13103 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235769AbiAXSEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:04:05 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643047444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yIiooJ7Br0briWEQqZ6uPYrewTQt0yFaU3FLKd4NjuQ=;
        b=eV2kpwR8xJFcM9Sl9WgGTW1GyXnj5qihypWFh4otrwjMzPW6EgMyoLvbRozNqNB3B591up
        y6lIiFHxnDXiOOaMJmL1wPHK4IrO3UXm0c5KMD2FNNNVtYlOxCIaZDtllz6bDRB1eeO8nD
        l/OGODSVkzQZX5g+F1Cv9ilY4I4R5eo=
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
Subject: [PATCH v6 13/39] kasan, page_alloc: move kernel_init_free_pages in post_alloc_hook
Date:   Mon, 24 Jan 2022 19:02:21 +0100
Message-Id: <a7a76456501eb37ddf9fca6529cee9555e59cdb1.1643047180.git.andreyknvl@google.com>
In-Reply-To: <cover.1643047180.git.andreyknvl@google.com>
References: <cover.1643047180.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Pull the kernel_init_free_pages() call in post_alloc_hook() out of the
big if clause for better code readability. This also allows for more
simplifications in the following patch.

This patch does no functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
 mm/page_alloc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c51d637cdab3..2784bd478942 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2435,14 +2435,18 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
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
 	if (kasan_hw_tags_enabled() && (gfp_flags & __GFP_SKIP_KASAN_POISON))
 		SetPageSkipKASanPoison(page);
-- 
2.25.1

