Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13D447B59B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhLTWAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:00:55 -0500
Received: from out1.migadu.com ([91.121.223.63]:41519 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231902AbhLTWAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:00:25 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640037623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ei8kdZ5sQSvooSj5JSSxP/TjdwvJrbBJ/NUBpnrkl04=;
        b=ipyTmvbVpthnhEccrPEkWulhwNYuW15hYJXvkiFi9HfBqeO73B6Pq+6xOgvIcSgGbMp1r3
        jTiValnoAuZmqupiWH+Cl/8pG+123GZ47otU76YInVcS+836YxSPRKwSd2IK9ZhsacUWGq
        1RYlPbzYX6JBZ3CZaWLzR9t882dreRc=
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
Subject: [PATCH mm v4 20/39] kasan: add wrappers for vmalloc hooks
Date:   Mon, 20 Dec 2021 22:59:35 +0100
Message-Id: <f69174e2f6196fb502afa5785612e3a30e6a71c7.1640036051.git.andreyknvl@google.com>
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

Add wrappers around functions that [un]poison memory for vmalloc
allocations. These functions will be used by HW_TAGS KASAN and
therefore need to be disabled when kasan=off command line argument
is provided.

This patch does no functional changes for software KASAN modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
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

