Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094364D70B8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 21:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiCLUPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 15:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiCLUPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 15:15:19 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4392C643
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 12:14:13 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647116050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LmoxS08scyGyVZqa/3VyRO6NmjBbbNh8W/Hs8Ybg/AU=;
        b=KWCmw9X7waDLg1FZltp14KfIGyto7rGibooprLEDSWhgrgIdyyrss/jrmCWPML7qrv4h3m
        s0gyjJwZ6jZkTYilfgDgMqU7xbGhTb9UT4MrHm5Fnh6URXKOyMWzhaExVa9NgXSSccY2c9
        CGZrl8lNiUsRHWHw2rTcoSdmyThnBrI=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] kasan, scs: collect stack traces from shadow stack
Date:   Sat, 12 Mar 2022 21:14:06 +0100
Message-Id: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Currently, KASAN always uses the normal stack trace collection routines,
which rely on the unwinder, when saving alloc and free stack traces.

Instead of invoking the unwinder, collect the stack trace by copying
frames from the Shadow Call Stack whenever it is enabled. This reduces
boot time by 30% for all KASAN modes when Shadow Call Stack is enabled.

To avoid potentially leaking PAC pointer tags, strip them when saving
the stack trace.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Things to consider:

We could integrate shadow stack trace collection into kernel/stacktrace.c
as e.g. stack_trace_save_shadow(). However, using stack_trace_consume_fn
leads to invoking a callback on each saved from, which is undesirable.
The plain copy loop is faster.

We could add a command line flag to switch between stack trace collection
modes. I noticed that Shadow Call Stack might be missing certain frames
in stacks originating from a fault that happens in the middle of a
function. I am not sure if this case is important to handle though.

Looking forward to thoughts and comments.

Thanks!

---
 mm/kasan/common.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index d9079ec11f31..65a0723370c7 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -9,6 +9,7 @@
  *        Andrey Konovalov <andreyknvl@gmail.com>
  */
 
+#include <linux/bits.h>
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/kasan.h>
@@ -21,6 +22,7 @@
 #include <linux/printk.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
+#include <linux/scs.h>
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
 #include <linux/string.h>
@@ -30,12 +32,44 @@
 #include "kasan.h"
 #include "../slab.h"
 
+#ifdef CONFIG_SHADOW_CALL_STACK
+
+#ifdef CONFIG_ARM64_PTR_AUTH
+#define PAC_TAG_RESET(x) (x | GENMASK(63, CONFIG_ARM64_VA_BITS))
+#else
+#define PAC_TAG_RESET(x) (x)
+#endif
+
+static unsigned int save_shadow_stack(unsigned long *entries,
+				      unsigned int nr_entries)
+{
+	unsigned long *scs_sp = task_scs_sp(current);
+	unsigned long *scs_base = task_scs(current);
+	unsigned long *frame;
+	unsigned int i = 0;
+
+	for (frame = scs_sp - 1; frame >= scs_base; frame--) {
+		entries[i++] = PAC_TAG_RESET(*frame);
+		if (i >= nr_entries)
+			break;
+	}
+
+	return i;
+}
+#else /* CONFIG_SHADOW_CALL_STACK */
+static inline unsigned int save_shadow_stack(unsigned long *entries,
+					unsigned int nr_entries) { return 0; }
+#endif /* CONFIG_SHADOW_CALL_STACK */
+
 depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
 {
 	unsigned long entries[KASAN_STACK_DEPTH];
 	unsigned int nr_entries;
 
-	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+	if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK))
+		nr_entries = save_shadow_stack(entries, ARRAY_SIZE(entries));
+	else
+		nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
 	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
 }
 
-- 
2.25.1

