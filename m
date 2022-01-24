Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE964987BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245024AbiAXSF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244918AbiAXSFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:05:20 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC61EC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:05:19 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643047518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4jFZKwC+1fGM+Zh4UMZz7D7AiRXqN4olJqxCqj+PmMQ=;
        b=UlCrGKBAuA8d1oTsocL7IE0SrflMdbtAS5WghAmbZDW2VPLOwFw8aZW4KMlHfbLQbLVsOv
        IKwBQ6/nlpu7pV6MtgOi3bsz0kb6QK7pBollsSUM1NVShtvrCmfeloCG1ZxGhQ95NOQU3i
        eBA8N4ipq51wSOpDw/CTj5WXUtErR4A=
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
Subject: [PATCH v6 20/39] kasan: add wrappers for vmalloc hooks
Date:   Mon, 24 Jan 2022 19:04:54 +0100
Message-Id: <3b8728eac438c55389fb0f9a8a2145d71dd77487.1643047180.git.andreyknvl@google.com>
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

Add wrappers around functions that [un]poison memory for vmalloc
allocations. These functions will be used by HW_TAGS KASAN and
therefore need to be disabled when kasan=off command line argument
is provided.

This patch does no functional changes for software KASAN modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
 include/linux/kasan.h | 17 +++++++++++++++--
 mm/kasan/shadow.c     |  5 ++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 46a63374c86f..da320069e7cf 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -424,8 +424,21 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end);
 
-void kasan_unpoison_vmalloc(const void *start, unsigned long size);
-void kasan_poison_vmalloc(const void *start, unsigned long size);
+void __kasan_unpoison_vmalloc(const void *start, unsigned long size);
+static __always_inline void kasan_unpoison_vmalloc(const void *start,
+						   unsigned long size)
+{
+	if (kasan_enabled())
+		__kasan_unpoison_vmalloc(start, size);
+}
+
+void __kasan_poison_vmalloc(const void *start, unsigned long size);
+static __always_inline void kasan_poison_vmalloc(const void *start,
+						 unsigned long size)
+{
+	if (kasan_enabled())
+		__kasan_poison_vmalloc(start, size);
+}
 
 #else /* CONFIG_KASAN_VMALLOC */
 
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index bf7ab62fbfb9..39d0b32ebf70 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -475,8 +475,7 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	}
 }
 
-
-void kasan_unpoison_vmalloc(const void *start, unsigned long size)
+void __kasan_unpoison_vmalloc(const void *start, unsigned long size)
 {
 	if (!is_vmalloc_or_module_addr(start))
 		return;
@@ -488,7 +487,7 @@ void kasan_unpoison_vmalloc(const void *start, unsigned long size)
  * Poison the shadow for a vmalloc region. Called as part of the
  * freeing process at the time the region is freed.
  */
-void kasan_poison_vmalloc(const void *start, unsigned long size)
+void __kasan_poison_vmalloc(const void *start, unsigned long size)
 {
 	if (!is_vmalloc_or_module_addr(start))
 		return;
-- 
2.25.1

