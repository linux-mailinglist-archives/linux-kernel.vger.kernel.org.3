Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A3E4640F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbhK3WKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:10:16 -0500
Received: from out2.migadu.com ([188.165.223.204]:43973 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344455AbhK3WKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:10:07 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638310006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbhL8TrmzwL9tq/+XeKdOp7BHc1RVFQ8fUYh+mFdIuI=;
        b=NQfqmix4ZSvUyW5rZHTJ56mI4W2mnrwCftlsGoFReG6bD3ea/xOXZssNSXldCiXJfEJU6C
        dJuZjXM6plIPMy9XcyQdI0pUABcvAMdFmRM4EaSp/haCJo0tOLmgxd6oXSkaiqTqzBaGLN
        FkhRF0bg8uD8m5D8wOeC1ThwI7eXcxc=
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
Subject: [PATCH 15/31] kasan: define KASAN_VMALLOC_INVALID for SW_TAGS
Date:   Tue, 30 Nov 2021 23:06:44 +0100
Message-Id: <0cfa94ae26c59bba4329dd384b5a8a5bd6adb891.1638308023.git.andreyknvl@google.com>
In-Reply-To: <cover.1638308023.git.andreyknvl@google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

In preparation for adding vmalloc support to SW_TAGS KASAN,
provide a KASAN_VMALLOC_INVALID definition for it.

HW_TAGS KASAN won't be using this value, as it falls back onto
page_alloc for poisoning freed vmalloc() memory.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index a50450160638..0827d74d0d87 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -71,18 +71,19 @@ static inline bool kasan_sync_fault_possible(void)
 #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
 #define KASAN_KMALLOC_REDZONE   0xFC  /* redzone inside slub object */
 #define KASAN_KMALLOC_FREE      0xFB  /* object was freed (kmem_cache_free/kfree) */
+#define KASAN_VMALLOC_INVALID   0xF8  /* unallocated space in vmapped page */
 #else
 #define KASAN_FREE_PAGE         KASAN_TAG_INVALID
 #define KASAN_PAGE_REDZONE      KASAN_TAG_INVALID
 #define KASAN_KMALLOC_REDZONE   KASAN_TAG_INVALID
 #define KASAN_KMALLOC_FREE      KASAN_TAG_INVALID
+#define KASAN_VMALLOC_INVALID   KASAN_TAG_INVALID /* only for SW_TAGS */
 #endif
 
 #ifdef CONFIG_KASAN_GENERIC
 
 #define KASAN_KMALLOC_FREETRACK 0xFA  /* object was freed and has free track set */
 #define KASAN_GLOBAL_REDZONE    0xF9  /* redzone for global variable */
-#define KASAN_VMALLOC_INVALID   0xF8  /* unallocated space in vmapped page */
 
 /*
  * Stack redzone shadow values
-- 
2.25.1

