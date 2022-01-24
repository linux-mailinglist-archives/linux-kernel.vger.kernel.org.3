Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519204987E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244955AbiAXSIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiAXSId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:08:33 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F83C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:08:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643047710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5t1XFftR4v8UgokG+BYIbGPBYNE5uJ7BSehShZZUsBk=;
        b=BUKLmrXv7GyMxTzB5DSJGz230NytWU0UNERBrcxYJORdlg7Lny/TzdFNdFSZT7dUVFrW1j
        KxKVzq60GzKrTN0k3PGe39oDprNgi6iRPwKx6INF1CUQU/3plIojYrYqfFXRoMVRN0Ej5p
        kdNl8rcBL3mzBf6hBdy4azNDGUiRu1o=
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
Subject: [PATCH v6 35/39] kasan: add kasan.vmalloc command line flag
Date:   Mon, 24 Jan 2022 19:05:09 +0100
Message-Id: <904f6d4dfa94870cc5fc2660809e093fd0d27c3b.1643047180.git.andreyknvl@google.com>
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

Allow disabling vmalloc() tagging for HW_TAGS KASAN via a kasan.vmalloc
command line switch.

This is a fail-safe switch intended for production systems that enable
HW_TAGS KASAN. In case vmalloc() tagging ends up having an issue not
detected during testing but that manifests in production, kasan.vmalloc
allows to turn vmalloc() tagging off while leaving page_alloc/slab
tagging on.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v4->v5:
- Use true as kasan_flag_vmalloc static key default.

Changes v1->v2:
- Mark kasan_arg_stacktrace as __initdata instead of __ro_after_init.
- Combine KASAN_ARG_VMALLOC_DEFAULT and KASAN_ARG_VMALLOC_ON switch
  cases.
---
 mm/kasan/hw_tags.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 mm/kasan/kasan.h   |  6 ++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 6a3146d1ccc5..fad1887e54c0 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -32,6 +32,12 @@ enum kasan_arg_mode {
 	KASAN_ARG_MODE_ASYMM,
 };
 
+enum kasan_arg_vmalloc {
+	KASAN_ARG_VMALLOC_DEFAULT,
+	KASAN_ARG_VMALLOC_OFF,
+	KASAN_ARG_VMALLOC_ON,
+};
+
 enum kasan_arg_stacktrace {
 	KASAN_ARG_STACKTRACE_DEFAULT,
 	KASAN_ARG_STACKTRACE_OFF,
@@ -40,6 +46,7 @@ enum kasan_arg_stacktrace {
 
 static enum kasan_arg kasan_arg __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
+static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
 static enum kasan_arg_stacktrace kasan_arg_stacktrace __initdata;
 
 /*
@@ -56,6 +63,9 @@ EXPORT_SYMBOL(kasan_flag_enabled);
 enum kasan_mode kasan_mode __ro_after_init;
 EXPORT_SYMBOL_GPL(kasan_mode);
 
+/* Whether to enable vmalloc tagging. */
+DEFINE_STATIC_KEY_TRUE(kasan_flag_vmalloc);
+
 /* Whether to collect alloc/free stack traces. */
 DEFINE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
 
@@ -95,6 +105,23 @@ static int __init early_kasan_mode(char *arg)
 }
 early_param("kasan.mode", early_kasan_mode);
 
+/* kasan.vmalloc=off/on */
+static int __init early_kasan_flag_vmalloc(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "off"))
+		kasan_arg_vmalloc = KASAN_ARG_VMALLOC_OFF;
+	else if (!strcmp(arg, "on"))
+		kasan_arg_vmalloc = KASAN_ARG_VMALLOC_ON;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan.vmalloc", early_kasan_flag_vmalloc);
+
 /* kasan.stacktrace=off/on */
 static int __init early_kasan_flag_stacktrace(char *arg)
 {
@@ -179,6 +206,18 @@ void __init kasan_init_hw_tags(void)
 		break;
 	}
 
+	switch (kasan_arg_vmalloc) {
+	case KASAN_ARG_VMALLOC_DEFAULT:
+		/* Default is specified by kasan_flag_vmalloc definition. */
+		break;
+	case KASAN_ARG_VMALLOC_OFF:
+		static_branch_disable(&kasan_flag_vmalloc);
+		break;
+	case KASAN_ARG_VMALLOC_ON:
+		static_branch_enable(&kasan_flag_vmalloc);
+		break;
+	}
+
 	switch (kasan_arg_stacktrace) {
 	case KASAN_ARG_STACKTRACE_DEFAULT:
 		/* Default is specified by kasan_flag_stacktrace definition. */
@@ -194,8 +233,9 @@ void __init kasan_init_hw_tags(void)
 	/* KASAN is now initialized, enable it. */
 	static_branch_enable(&kasan_flag_enabled);
 
-	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, stacktrace=%s)\n",
+	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s)\n",
 		kasan_mode_info(),
+		kasan_vmalloc_enabled() ? "on" : "off",
 		kasan_stack_collection_enabled() ? "on" : "off");
 }
 
@@ -228,6 +268,9 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	u8 tag;
 	unsigned long redzone_start, redzone_size;
 
+	if (!kasan_vmalloc_enabled())
+		return (void *)start;
+
 	if (!is_vmalloc_or_module_addr(start))
 		return (void *)start;
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index efda13a9ce6a..4d67408e8407 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -12,6 +12,7 @@
 #include <linux/static_key.h>
 #include "../slab.h"
 
+DECLARE_STATIC_KEY_TRUE(kasan_flag_vmalloc);
 DECLARE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
 
 enum kasan_mode {
@@ -22,6 +23,11 @@ enum kasan_mode {
 
 extern enum kasan_mode kasan_mode __ro_after_init;
 
+static inline bool kasan_vmalloc_enabled(void)
+{
+	return static_branch_likely(&kasan_flag_vmalloc);
+}
+
 static inline bool kasan_stack_collection_enabled(void)
 {
 	return static_branch_unlikely(&kasan_flag_stacktrace);
-- 
2.25.1

