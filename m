Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372D34E5554
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245269AbiCWPfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245195AbiCWPej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:34:39 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A2AD8B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:33:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648049584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MP8VVStpf2u5pFq9LJYVTfW5maMxRrDNwrS4C/iOhFE=;
        b=CHABMq/eZMH3CKmnepGiem7lAUyvtGITme8Qll4LQCROHN+V6C06OVGLwZuteRZ+PbizzX
        B/d0tsbkAj03Q2KNrb7PC4vE3rYeOl8qckRDCHswffvIEUY+QTm6icfg6nxgM6fpgtv52V
        PXKw6cD+WU2EotoizAcwfEiGoH3Y8cA=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 3/4] arm64: implement stack_trace_save_shadow
Date:   Wed, 23 Mar 2022 16:32:54 +0100
Message-Id: <0bb72ea8fa88ef9ae3508c23d993952a0ae6f0f9.1648049113.git.andreyknvl@google.com>
In-Reply-To: <cover.1648049113.git.andreyknvl@google.com>
References: <cover.1648049113.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Implement the stack_trace_save_shadow() interface that collects stack
traces based on the Shadow Call Stack (SCS) for arm64.

The implementation walks through available SCS pointers (the per-task one
and the per-interrupt-type ones) and copies the frames.

Note that the frame of the interrupted function is not included into
the stack trace, as it is not yet saved on the SCS when an interrupt
happens.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Kconfig             |  1 +
 arch/arm64/kernel/stacktrace.c | 83 ++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a659e238f196..d89cecf6c923 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -201,6 +201,7 @@ config ARM64
 	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_RUST
+	select HAVE_SHADOW_STACKTRACE
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index e4103e085681..89daa710d91b 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -12,9 +12,11 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
+#include <linux/scs.h>
 
 #include <asm/irq.h>
 #include <asm/pointer_auth.h>
+#include <asm/scs.h>
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
@@ -210,3 +212,84 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 
 	walk_stackframe(task, &frame, consume_entry, cookie);
 }
+
+static const struct {
+	unsigned long ** __percpu saved;
+	unsigned long ** __percpu base;
+} scs_parts[] = {
+#ifdef CONFIG_ARM_SDE_INTERFACE
+	{
+		.saved = &sdei_shadow_call_stack_critical_saved_ptr,
+		.base = &sdei_shadow_call_stack_critical_ptr,
+	},
+	{
+		.saved = &sdei_shadow_call_stack_normal_saved_ptr,
+		.base = &sdei_shadow_call_stack_normal_ptr,
+	},
+#endif /* CONFIG_ARM_SDE_INTERFACE */
+	{
+		.saved = &irq_shadow_call_stack_saved_ptr,
+		.base = &irq_shadow_call_stack_ptr,
+	},
+};
+
+static inline bool walk_shadow_stack_part(
+				unsigned long *scs_top, unsigned long *scs_base,
+				unsigned long *store, unsigned int size,
+				unsigned int *skipnr, unsigned int *len)
+{
+	unsigned long *frame;
+
+	for (frame = scs_top; frame >= scs_base; frame--) {
+		if (*skipnr > 0) {
+			(*skipnr)--;
+			continue;
+		}
+		/*
+		 * Do not leak PTR_AUTH tags in stack traces.
+		 * Use READ_ONCE_NOCHECK as SCS is poisoned with Generic KASAN.
+		 */
+		store[(*len)++] =
+			ptrauth_strip_insn_pac(READ_ONCE_NOCHECK(*frame));
+		if (*len >= size)
+			return true;
+	}
+
+	return false;
+}
+
+noinline notrace int arch_stack_walk_shadow(unsigned long *store,
+					    unsigned int size,
+					    unsigned int skipnr)
+{
+	unsigned long *scs_top, *scs_base, *scs_next;
+	unsigned int len = 0, part;
+
+	preempt_disable();
+
+	/* Get the SCS pointer. */
+	asm volatile("mov %0, x18" : "=&r" (scs_top));
+
+	/* The top SCS slot is empty. */
+	scs_top -= 1;
+
+	/* Handle SDEI and hardirq frames. */
+	for (part = 0; part < ARRAY_SIZE(scs_parts); part++) {
+		scs_next = *this_cpu_ptr(scs_parts[part].saved);
+		if (scs_next) {
+			scs_base = *this_cpu_ptr(scs_parts[part].base);
+			if (walk_shadow_stack_part(scs_top, scs_base, store,
+						   size, &skipnr, &len))
+				goto out;
+			scs_top = scs_next;
+		}
+	}
+
+	/* Handle task and softirq frames. */
+	scs_base = task_scs(current);
+	walk_shadow_stack_part(scs_top, scs_base, store, size, &skipnr, &len);
+
+out:
+	preempt_enable();
+	return len;
+}
-- 
2.25.1

