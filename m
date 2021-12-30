Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88112481FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbhL3TQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbhL3TQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:16:22 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33789C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:16:22 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640891780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypDUrRwpvHxVi9/0pzLPCyjGz64l2U6vLcrEu5OiSo8=;
        b=eyGshO82xqanygFacqinfLeba2KPxh5XF9s2IEZVg/E3Dz8eJlQbOCBnwbeDwdpVKWRgJd
        pWEq/aQHvlzMroKqD2eAHkM/91eD9y/mpzsMXLKMnajhZ7D7D/fYXeNiCraR13PAkBwvFU
        RBMUnn90+kwM9qJseNQH/rpS6fQGIao=
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
Subject: [PATCH mm v5 34/39] kasan: clean up feature flags for HW_TAGS mode
Date:   Thu, 30 Dec 2021 20:14:59 +0100
Message-Id: <9fefb5cb7639153e50446746fdd3427635bdcda7.1640891329.git.andreyknvl@google.com>
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

- Untie kasan_init_hw_tags() code from the default values of
  kasan_arg_mode and kasan_arg_stacktrace.

- Move static_branch_enable(&kasan_flag_enabled) to the end of
  kasan_init_hw_tags_cpu().

- Remove excessive comments in kasan_arg_mode switch.

- Add new comments.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v4->v5:
- Add this patch.
---
 mm/kasan/hw_tags.c | 38 +++++++++++++++++++++-----------------
 mm/kasan/kasan.h   |  2 +-
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 6509809dd5d8..6a3146d1ccc5 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -42,16 +42,22 @@ static enum kasan_arg kasan_arg __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_stacktrace kasan_arg_stacktrace __initdata;
 
-/* Whether KASAN is enabled at all. */
+/*
+ * Whether KASAN is enabled at all.
+ * The value remains false until KASAN is initialized by kasan_init_hw_tags().
+ */
 DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
 EXPORT_SYMBOL(kasan_flag_enabled);
 
-/* Whether the selected mode is synchronous/asynchronous/asymmetric.*/
+/*
+ * Whether the selected mode is synchronous, asynchronous, or asymmetric.
+ * Defaults to KASAN_MODE_SYNC.
+ */
 enum kasan_mode kasan_mode __ro_after_init;
 EXPORT_SYMBOL_GPL(kasan_mode);
 
 /* Whether to collect alloc/free stack traces. */
-DEFINE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
+DEFINE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
 
 /* kasan=off/on */
 static int __init early_kasan_flag(char *arg)
@@ -127,7 +133,11 @@ void kasan_init_hw_tags_cpu(void)
 	 * as this function is only called for MTE-capable hardware.
 	 */
 
-	/* If KASAN is disabled via command line, don't initialize it. */
+	/*
+	 * If KASAN is disabled via command line, don't initialize it.
+	 * When this function is called, kasan_flag_enabled is not yet
+	 * set by kasan_init_hw_tags(). Thus, check kasan_arg instead.
+	 */
 	if (kasan_arg == KASAN_ARG_OFF)
 		return;
 
@@ -154,42 +164,36 @@ void __init kasan_init_hw_tags(void)
 	if (kasan_arg == KASAN_ARG_OFF)
 		return;
 
-	/* Enable KASAN. */
-	static_branch_enable(&kasan_flag_enabled);
-
 	switch (kasan_arg_mode) {
 	case KASAN_ARG_MODE_DEFAULT:
-		/*
-		 * Default to sync mode.
-		 */
-		fallthrough;
+		/* Default is specified by kasan_mode definition. */
+		break;
 	case KASAN_ARG_MODE_SYNC:
-		/* Sync mode enabled. */
 		kasan_mode = KASAN_MODE_SYNC;
 		break;
 	case KASAN_ARG_MODE_ASYNC:
-		/* Async mode enabled. */
 		kasan_mode = KASAN_MODE_ASYNC;
 		break;
 	case KASAN_ARG_MODE_ASYMM:
-		/* Asymm mode enabled. */
 		kasan_mode = KASAN_MODE_ASYMM;
 		break;
 	}
 
 	switch (kasan_arg_stacktrace) {
 	case KASAN_ARG_STACKTRACE_DEFAULT:
-		/* Default to enabling stack trace collection. */
-		static_branch_enable(&kasan_flag_stacktrace);
+		/* Default is specified by kasan_flag_stacktrace definition. */
 		break;
 	case KASAN_ARG_STACKTRACE_OFF:
-		/* Do nothing, kasan_flag_stacktrace keeps its default value. */
+		static_branch_disable(&kasan_flag_stacktrace);
 		break;
 	case KASAN_ARG_STACKTRACE_ON:
 		static_branch_enable(&kasan_flag_stacktrace);
 		break;
 	}
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, stacktrace=%s)\n",
 		kasan_mode_info(),
 		kasan_stack_collection_enabled() ? "on" : "off");
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 020f3e57a03f..efda13a9ce6a 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -12,7 +12,7 @@
 #include <linux/static_key.h>
 #include "../slab.h"
 
-DECLARE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
+DECLARE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
 
 enum kasan_mode {
 	KASAN_MODE_SYNC,
-- 
2.25.1

