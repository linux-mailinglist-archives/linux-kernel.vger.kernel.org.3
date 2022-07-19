Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6E2578F18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiGSAPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiGSAPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:15:47 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057A8DF6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:15:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nn1wRmXGNlycId97pMK2GGK/DQj9IfbkBYQ3B2Fk9HA=;
        b=AgpB1/AhUXouCU+9FWLxvR4qtROoWxjrIHFdJKXGRu5em1LE96vrsCj2F2+4JgIo1ZW/sg
        XSkCQ9Sc9PllQYVWN70e9jiZkYNC6V010cVyrwjLbYZa3GySFFCPbvKl1VBTMze09zUfse
        7dOPakya88V93QnjdezPKJQdUYZwwkY=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v2 31/33] kasan: support kasan.stacktrace for SW_TAGS
Date:   Tue, 19 Jul 2022 02:10:11 +0200
Message-Id: <8db2d46b0e2c54aa7eaade18e39f68c0d9d09945.1658189199.git.andreyknvl@google.com>
In-Reply-To: <cover.1658189199.git.andreyknvl@google.com>
References: <cover.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add support for the kasan.stacktrace command-line argument for Software
Tag-Based KASAN.

The following patch adds a command-line argument for selecting the stack
ring size, and, as the stack ring is supported by both the Software and
the Hardware Tag-Based KASAN modes, it is natural that both of them have
support for kasan.stacktrace too.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- This is a new patch.
---
 Documentation/dev-tools/kasan.rst | 15 ++++++-----
 mm/kasan/hw_tags.c                | 39 +---------------------------
 mm/kasan/kasan.h                  | 36 +++++++++++++++++---------
 mm/kasan/sw_tags.c                |  5 +++-
 mm/kasan/tags.c                   | 43 +++++++++++++++++++++++++++++++
 5 files changed, 81 insertions(+), 57 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 1772fd457fed..7bd38c181018 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -111,9 +111,15 @@ parameter can be used to control panic and reporting behaviour:
   report or also panic the kernel (default: ``report``). The panic happens even
   if ``kasan_multi_shot`` is enabled.
 
-Hardware Tag-Based KASAN mode (see the section about various modes below) is
-intended for use in production as a security mitigation. Therefore, it supports
-additional boot parameters that allow disabling KASAN or controlling features:
+Software and Hardware Tag-Based KASAN modes (see the section about various
+modes below) support disabling stack trace collection:
+
+- ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
+  traces collection (default: ``on``).
+
+Hardware Tag-Based KASAN mode is intended for use in production as a security
+mitigation. Therefore, it supports additional boot parameters that allow
+disabling KASAN altogether or controlling its features:
 
 - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
 
@@ -132,9 +138,6 @@ additional boot parameters that allow disabling KASAN or controlling features:
 - ``kasan.vmalloc=off`` or ``=on`` disables or enables tagging of vmalloc
   allocations (default: ``on``).
 
-- ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
-  traces collection (default: ``on``).
-
 Error reports
 ~~~~~~~~~~~~~
 
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 9ad8eff71b28..b22c4f461cb0 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -38,16 +38,9 @@ enum kasan_arg_vmalloc {
 	KASAN_ARG_VMALLOC_ON,
 };
 
-enum kasan_arg_stacktrace {
-	KASAN_ARG_STACKTRACE_DEFAULT,
-	KASAN_ARG_STACKTRACE_OFF,
-	KASAN_ARG_STACKTRACE_ON,
-};
-
 static enum kasan_arg kasan_arg __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
-static enum kasan_arg_stacktrace kasan_arg_stacktrace __initdata;
 
 /*
  * Whether KASAN is enabled at all.
@@ -66,9 +59,6 @@ EXPORT_SYMBOL_GPL(kasan_mode);
 /* Whether to enable vmalloc tagging. */
 DEFINE_STATIC_KEY_TRUE(kasan_flag_vmalloc);
 
-/* Whether to collect alloc/free stack traces. */
-DEFINE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
-
 /* kasan=off/on */
 static int __init early_kasan_flag(char *arg)
 {
@@ -122,23 +112,6 @@ static int __init early_kasan_flag_vmalloc(char *arg)
 }
 early_param("kasan.vmalloc", early_kasan_flag_vmalloc);
 
-/* kasan.stacktrace=off/on */
-static int __init early_kasan_flag_stacktrace(char *arg)
-{
-	if (!arg)
-		return -EINVAL;
-
-	if (!strcmp(arg, "off"))
-		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_OFF;
-	else if (!strcmp(arg, "on"))
-		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_ON;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
-
 static inline const char *kasan_mode_info(void)
 {
 	if (kasan_mode == KASAN_MODE_ASYNC)
@@ -213,17 +186,7 @@ void __init kasan_init_hw_tags(void)
 		break;
 	}
 
-	switch (kasan_arg_stacktrace) {
-	case KASAN_ARG_STACKTRACE_DEFAULT:
-		/* Default is specified by kasan_flag_stacktrace definition. */
-		break;
-	case KASAN_ARG_STACKTRACE_OFF:
-		static_branch_disable(&kasan_flag_stacktrace);
-		break;
-	case KASAN_ARG_STACKTRACE_ON:
-		static_branch_enable(&kasan_flag_stacktrace);
-		break;
-	}
+	kasan_init_tags();
 
 	/* KASAN is now initialized, enable it. */
 	static_branch_enable(&kasan_flag_enabled);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index cfff81139d67..447baf1a7a2e 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -8,13 +8,31 @@
 #include <linux/kfence.h>
 #include <linux/stackdepot.h>
 
-#ifdef CONFIG_KASAN_HW_TAGS
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
 
 #include <linux/static_key.h>
+
+DECLARE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
+
+static inline bool kasan_stack_collection_enabled(void)
+{
+	return static_branch_unlikely(&kasan_flag_stacktrace);
+}
+
+#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
+
+static inline bool kasan_stack_collection_enabled(void)
+{
+	return true;
+}
+
+#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
+
+#ifdef CONFIG_KASAN_HW_TAGS
+
 #include "../slab.h"
 
 DECLARE_STATIC_KEY_TRUE(kasan_flag_vmalloc);
-DECLARE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
 
 enum kasan_mode {
 	KASAN_MODE_SYNC,
@@ -29,11 +47,6 @@ static inline bool kasan_vmalloc_enabled(void)
 	return static_branch_likely(&kasan_flag_vmalloc);
 }
 
-static inline bool kasan_stack_collection_enabled(void)
-{
-	return static_branch_unlikely(&kasan_flag_stacktrace);
-}
-
 static inline bool kasan_async_fault_possible(void)
 {
 	return kasan_mode == KASAN_MODE_ASYNC || kasan_mode == KASAN_MODE_ASYMM;
@@ -46,11 +59,6 @@ static inline bool kasan_sync_fault_possible(void)
 
 #else /* CONFIG_KASAN_HW_TAGS */
 
-static inline bool kasan_stack_collection_enabled(void)
-{
-	return true;
-}
-
 static inline bool kasan_async_fault_possible(void)
 {
 	return false;
@@ -410,6 +418,10 @@ static inline void kasan_enable_tagging(void) { }
 
 #endif /* CONFIG_KASAN_HW_TAGS */
 
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+void __init kasan_init_tags(void);
+#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
+
 #if defined(CONFIG_KASAN_HW_TAGS) && IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
 void kasan_force_async_fault(void);
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 77f13f391b57..a3afaf2ad1b1 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -42,7 +42,10 @@ void __init kasan_init_sw_tags(void)
 	for_each_possible_cpu(cpu)
 		per_cpu(prng_state, cpu) = (u32)get_cycles();
 
-	pr_info("KernelAddressSanitizer initialized (sw-tags)\n");
+	kasan_init_tags();
+
+	pr_info("KernelAddressSanitizer initialized (sw-tags, stacktrace=%s)\n",
+		kasan_stack_collection_enabled() ? "on" : "off");
 }
 
 /*
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 07828021c1f5..0eb6cf6717db 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -19,11 +19,54 @@
 #include "kasan.h"
 #include "../slab.h"
 
+enum kasan_arg_stacktrace {
+	KASAN_ARG_STACKTRACE_DEFAULT,
+	KASAN_ARG_STACKTRACE_OFF,
+	KASAN_ARG_STACKTRACE_ON,
+};
+
+static enum kasan_arg_stacktrace kasan_arg_stacktrace __initdata;
+
+/* Whether to collect alloc/free stack traces. */
+DEFINE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
+
 /* Non-zero, as initial pointer values are 0. */
 #define STACK_RING_BUSY_PTR ((void *)1)
 
 struct kasan_stack_ring stack_ring;
 
+/* kasan.stacktrace=off/on */
+static int __init early_kasan_flag_stacktrace(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "off"))
+		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_OFF;
+	else if (!strcmp(arg, "on"))
+		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_ON;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
+
+void __init kasan_init_tags(void)
+{
+	switch (kasan_arg_stacktrace) {
+	case KASAN_ARG_STACKTRACE_DEFAULT:
+		/* Default is specified by kasan_flag_stacktrace definition. */
+		break;
+	case KASAN_ARG_STACKTRACE_OFF:
+		static_branch_disable(&kasan_flag_stacktrace);
+		break;
+	case KASAN_ARG_STACKTRACE_ON:
+		static_branch_enable(&kasan_flag_stacktrace);
+		break;
+	}
+}
+
 static void save_stack_info(struct kmem_cache *cache, void *object,
 			gfp_t gfp_flags, bool is_free)
 {
-- 
2.25.1

