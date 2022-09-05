Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9EB5ADB55
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 00:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiIEWSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 18:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIEWSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 18:18:43 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B46E6052B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:18:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662416318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=86vkn1lngiubNGWHffOAiBFa/gjw4IKkbIc5Z1/odHo=;
        b=foLluK7py9GlYQMWiiCW9yrRKmL3EzEmTMBqk1t5O7oE6DaN8lQWgoYZsmt0dGDhUxV7qq
        1+L+v894GtqbQusBlw/tw3O+hE8QnqEmZbXqcCZOeuDmfkYQhC3MnRvTlGJ3dG5E1hNZvg
        7IWj8x6um0xX64Yu+1Z6WKFGiYhpge0=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] kasan: move tests to mm/kasan/
Date:   Tue,  6 Sep 2022 00:18:36 +0200
Message-Id: <676398f0aeecd47d2f8e3369ea0e95563f641a36.1662416260.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Move KASAN tests to mm/kasan/ to keep the test code alongside the
implementation.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 MAINTAINERS                                             | 1 -
 lib/Makefile                                            | 5 -----
 mm/kasan/Makefile                                       | 8 ++++++++
 lib/test_kasan.c => mm/kasan/kasan_test.c               | 2 +-
 lib/test_kasan_module.c => mm/kasan/kasan_test_module.c | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)
 rename lib/test_kasan.c => mm/kasan/kasan_test.c (99%)
 rename lib/test_kasan_module.c => mm/kasan/kasan_test_module.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 589517372408..31b3e4b11e01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10938,7 +10938,6 @@ F:	arch/*/include/asm/*kasan.h
 F:	arch/*/mm/kasan_init*
 F:	include/linux/kasan*.h
 F:	lib/Kconfig.kasan
-F:	lib/test_kasan*.c
 F:	mm/kasan/
 F:	scripts/Makefile.kasan
 
diff --git a/lib/Makefile b/lib/Makefile
index ffabc30a27d4..928d7605c35c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -65,11 +65,6 @@ obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_SIPHASH) += test_siphash.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
-obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
-CFLAGS_test_kasan.o += -fno-builtin
-CFLAGS_test_kasan.o += $(call cc-disable-warning, vla)
-obj-$(CONFIG_KASAN_MODULE_TEST) += test_kasan_module.o
-CFLAGS_test_kasan_module.o += -fno-builtin
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 UBSAN_SANITIZE_test_ubsan.o := y
diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 1f84df9c302e..d4837bff3b60 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -35,7 +35,15 @@ CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_hw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 
+CFLAGS_KASAN_TEST := $(CFLAGS_KASAN) -fno-builtin $(call cc-disable-warning, vla)
+
+CFLAGS_kasan_test.o := $(CFLAGS_KASAN_TEST)
+CFLAGS_kasan_test_module.o := $(CFLAGS_KASAN_TEST)
+
 obj-y := common.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
 obj-$(CONFIG_KASAN_HW_TAGS) += hw_tags.o report_hw_tags.o tags.o report_tags.o
 obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o tags.o report_tags.o
+
+obj-$(CONFIG_KASAN_KUNIT_TEST) += kasan_test.o
+obj-$(CONFIG_KASAN_MODULE_TEST) += kasan_test_module.o
diff --git a/lib/test_kasan.c b/mm/kasan/kasan_test.c
similarity index 99%
rename from lib/test_kasan.c
rename to mm/kasan/kasan_test.c
index 505f77ffad27..f25692def781 100644
--- a/lib/test_kasan.c
+++ b/mm/kasan/kasan_test.c
@@ -25,7 +25,7 @@
 
 #include <kunit/test.h>
 
-#include "../mm/kasan/kasan.h"
+#include "kasan.h"
 
 #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANULE_SIZE)
 
diff --git a/lib/test_kasan_module.c b/mm/kasan/kasan_test_module.c
similarity index 99%
rename from lib/test_kasan_module.c
rename to mm/kasan/kasan_test_module.c
index b112cbc835e9..e4ca82dc2c16 100644
--- a/lib/test_kasan_module.c
+++ b/mm/kasan/kasan_test_module.c
@@ -13,7 +13,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
-#include "../mm/kasan/kasan.h"
+#include "kasan.h"
 
 static noinline void __init copy_user_test(void)
 {
-- 
2.25.1

