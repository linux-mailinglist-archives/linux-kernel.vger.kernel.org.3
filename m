Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EBB464128
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344937AbhK3WRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:17:17 -0500
Received: from out1.migadu.com ([91.121.223.63]:58466 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344647AbhK3WLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:11:43 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638310102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAlgAJIkgdSw/H62J4ONvMmg8WxewXYkqfQfZPdbW8s=;
        b=Fjt3KF2AE9L8abL87e/sthlvRPuIz3/0wTs/HSkbbBxV0dkxxuai3S0j8hVXgv7J5xWLwx
        7YkXYpw7rpYHEX130k/jyyGvkGlaRLdP1MaIzvhzsx0T8wNIITbyXlDeWY23FP9Cc/7C14
        cT9MC9WlOTZpg5dB9aK0P05Zie7j/ok=
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
Subject: [PATCH 29/31] kasan, arm64: allow KASAN_VMALLOC with HW_TAGS
Date:   Tue, 30 Nov 2021 23:08:20 +0100
Message-Id: <8afdf7eb0bae77d2e94210d689d524580cf5ed9a.1638308023.git.andreyknvl@google.com>
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

vmalloc tagging support for HW_TAGS KASAN is now complete.

Allow enabling CONFIG_KASAN_VMALLOC.

Also adjust CONFIG_KASAN_VMALLOC description:

- Mention HW_TAGS support.
- Remove unneeded internal details: they have no place in Kconfig
  description and are already explained in the documentation.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Kconfig |  3 +--
 lib/Kconfig.kasan  | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c05d7a06276f..5981e5460c51 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -205,8 +205,7 @@ config ARM64
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
-	select KASAN_VMALLOC if KASAN_GENERIC
-	select KASAN_VMALLOC if KASAN_SW_TAGS
+	select KASAN_VMALLOC
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 3f144a87f8a3..7834c35a7964 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -178,17 +178,17 @@ config KASAN_TAGS_IDENTIFY
 	  memory consumption.
 
 config KASAN_VMALLOC
-	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on (KASAN_GENERIC || KASAN_SW_TAGS) && HAVE_ARCH_KASAN_VMALLOC
+	bool "Check accesses to vmalloc allocations"
+	depends on HAVE_ARCH_KASAN_VMALLOC
 	help
-	  By default, the shadow region for vmalloc space is the read-only
-	  zero page. This means that KASAN cannot detect errors involving
-	  vmalloc space.
-
-	  Enabling this option will hook in to vmap/vmalloc and back those
-	  mappings with real shadow memory allocated on demand. This allows
-	  for KASAN to detect more sorts of errors (and to support vmapped
-	  stacks), but at the cost of higher memory usage.
+	  This mode makes KASAN check accesses to vmalloc allocations for
+	  validity.
+
+	  With software KASAN modes, checking is done for all types of vmalloc
+	  allocations. Enabling this option leads to higher memory usage.
+
+	  With hardware tag-based KASAN, only VM_ALLOC mappings are checked.
+	  There is no additional memory usage.
 
 config KASAN_KUNIT_TEST
 	tristate "KUnit-compatible tests of KASAN bug detection capabilities" if !KUNIT_ALL_TESTS
-- 
2.25.1

