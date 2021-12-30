Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C986481FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbhL3TRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:17:18 -0500
Received: from out2.migadu.com ([188.165.223.204]:61392 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236170AbhL3TRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:17:17 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640891836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XC1+Aytkcqzf1ileaTyJqJ/4yyuLy4mtp9hx3Zvq9co=;
        b=HKWSHEkqM7GV9ysATlL/HixOZGAnvndzYxvdYdBOeyoEanodwoWTV7TFV/VG/nVEnp/x3j
        9OtEQ5WbHID2Qc3KrvbLKCLpyB61vt4sMMCn8tMAqFFPj2OuFFpAOjyrALEohpBBQxPgM7
        ugKGSDUgt1+x7di5Rlwm+69INwNYsGo=
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
Subject: [PATCH mm v5 36/39] kasan: allow enabling KASAN_VMALLOC and SW/HW_TAGS
Date:   Thu, 30 Dec 2021 20:17:11 +0100
Message-Id: <f863f9d1e78c1ca3924db0d8a36a19b8e06f57e6.1640891329.git.andreyknvl@google.com>
In-Reply-To: <cover.1640891329.git.andreyknvl@google.com>
References: <cover.1640891329.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Allow enabling CONFIG_KASAN_VMALLOC with SW_TAGS and HW_TAGS KASAN
modes.

Also adjust CONFIG_KASAN_VMALLOC description:

- Mention HW_TAGS support.
- Remove unneeded internal details: they have no place in Kconfig
  description and are already explained in the documentation.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/Kconfig.kasan | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 879757b6dd14..1f3e620188a2 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -178,17 +178,17 @@ config KASAN_TAGS_IDENTIFY
 	  memory consumption.
 
 config KASAN_VMALLOC
-	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
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

