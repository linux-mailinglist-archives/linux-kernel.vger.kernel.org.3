Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6609647B581
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhLTV7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhLTV7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:59:23 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2128C061747
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:59:19 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640037558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxvElAXzOKVErefTs0SDL10+kOEEoku9HnbkEr9+Z/k=;
        b=YZcT55/9mcQpsaOkxweOJo1NEC98lfIA4KCqfVVlpLJIkeGLOy/F1FFkQRLU/6x2dPIlwB
        Nlvj4NLfWF3T5lITYMLg3XChvunbc92vcZkVZA7OLJWR655/yUY70g8oY2i9cAUBLX6VaE
        prMrvMwxwXlMZhAdosEwMcUVmupqnAo=
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
Subject: [PATCH mm v4 09/39] kasan, page_alloc: refactor init checks in post_alloc_hook
Date:   Mon, 20 Dec 2021 22:58:24 +0100
Message-Id: <ebc657034b70b03c7cbee1337c4d8cef8518cce4.1640036051.git.andreyknvl@google.com>
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

Separate code for zeroing memory from the code clearing tags in
post_alloc_hook().

This patch is not useful by itself but makes the simplifications in
the following patches easier to follow.

This patch does no functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

---

Changes v2->v3:
- Update patch description.
---
 mm/page_alloc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 73280222e0e8..9ecdf2124ac1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2419,19 +2419,21 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		kasan_alloc_pages(page, order, gfp_flags);
 	} else {
 		bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags);
+		bool init_tags = init && (gfp_flags & __GFP_ZEROTAGS);
 
 		kasan_unpoison_pages(page, order, init);
 
-		if (init) {
-			if (gfp_flags & __GFP_ZEROTAGS) {
-				int i;
+		if (init_tags) {
+			int i;
 
-				for (i = 0; i < 1 << order; i++)
-					tag_clear_highpage(page + i);
-			} else {
-				kernel_init_free_pages(page, 1 << order);
-			}
+			for (i = 0; i < 1 << order; i++)
+				tag_clear_highpage(page + i);
+
+			init = false;
 		}
+
+		if (init)
+			kernel_init_free_pages(page, 1 << order);
 	}
 
 	set_page_owner(page, order, gfp_flags);
-- 
2.25.1

