Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635CB46AAB3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352469AbhLFVsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352459AbhLFVsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:48:14 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0505C061354
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:44:44 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638827083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i2FffCVJttNjYU5fhxzifZEfN2PNcPmkAgEoBkLN39I=;
        b=ki8a4uqZiwX/o6uF82TlRSlizCDnifW77Fpu8VTqd908FDeI+i1+dbsBcCFIYSxQYQKSLq
        e1kCTsdesyz70eaaUS9SEwh9RnUJRBS29bdYj1y+wucVhuxQmVl5m0s6844MrKgsJ4pZQO
        Np3RYHeNsMKNqpoYYjN5JcmZPFdV9Co=
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
Subject: [PATCH v2 09/34] kasan, page_alloc: refactor init checks in post_alloc_hook
Date:   Mon,  6 Dec 2021 22:43:46 +0100
Message-Id: <7445f15afeaeffd92956d7093ba6aab62781f637.1638825394.git.andreyknvl@google.com>
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

This patch separates code for zeroing memory from the code clearing tags
in post_alloc_hook().

This patch is not useful by itself but makes the simplifications in
the following patches easier to follow.

This patch does no functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/page_alloc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f70bfa63a374..507004a54f2f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2405,19 +2405,21 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
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

