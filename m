Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3984E5552
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245197AbiCWPej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbiCWPef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:34:35 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD30330
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:33:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648049582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mmc3nZQPUIWzZbIw9R7zdg/6fIrR3qfP7vluF20CZjk=;
        b=UTJfa80A9sjfbSyh7XvFmbslezbBssH3pgpUdBaLBgs3IL2A3I6NA415UycL5yEGhbwHb6
        vpUhIr+s+DTQPNB7OYobvxHrvMaOkJFmdVvDpJbnJ21kD5Gc+xjflW3QFSbiifKEwW887J
        jc+p/iTWkpBgyYYx+H4uOeaKNyAMx8U=
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
Subject: [PATCH v2 1/4] stacktrace: add interface based on shadow call stack
Date:   Wed, 23 Mar 2022 16:32:52 +0100
Message-Id: <21e3e20ea58e242e3c82c19abbfe65b579e0e4b8.1648049113.git.andreyknvl@google.com>
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

Add a new interface stack_trace_save_shadow() for collecting stack traces
by copying frames from the Shadow Call Stack.

Collecting stack traces this way is significantly faster: boot time
of a defconfig build with KASAN enabled gets descreased by ~30%.

The few patches following this one add an implementation of
stack_trace_save_shadow() for arm64.

The implementation of the added interface is not meant to use
stack_trace_consume_fn to avoid making a function call for each
collected frame to further improve performance.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/Kconfig               |  6 ++++++
 include/linux/stacktrace.h | 15 +++++++++++++++
 kernel/stacktrace.c        | 21 +++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index e12a4268c01d..207c1679c53a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1041,6 +1041,12 @@ config HAVE_RELIABLE_STACKTRACE
 	  arch_stack_walk_reliable() function which only returns a stack trace
 	  if it can guarantee the trace is reliable.
 
+config HAVE_SHADOW_STACKTRACE
+	bool
+	help
+	  If this is set, the architecture provides the arch_stack_walk_shadow()
+	  function, which collects the stack trace from the shadow call stack.
+
 config HAVE_ARCH_HASH
 	bool
 	default n
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 97455880ac41..b74d1e42e157 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -60,6 +60,9 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
 
 void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			  const struct pt_regs *regs);
+
+int arch_stack_walk_shadow(unsigned long *store, unsigned int size,
+			   unsigned int skipnr);
 #endif /* CONFIG_ARCH_STACKWALK */
 
 #ifdef CONFIG_STACKTRACE
@@ -108,4 +111,16 @@ static inline int stack_trace_save_tsk_reliable(struct task_struct *tsk,
 }
 #endif
 
+#if defined(CONFIG_STACKTRACE) && defined(CONFIG_HAVE_SHADOW_STACKTRACE)
+int stack_trace_save_shadow(unsigned long *store, unsigned int size,
+			    unsigned int skipnr);
+#else
+static inline int stack_trace_save_shadow(unsigned long *store,
+					  unsigned int size,
+					  unsigned int skipnr)
+{
+	return -ENOSYS;
+}
+#endif
+
 #endif /* __LINUX_STACKTRACE_H */
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 9ed5ce989415..fe305861fd55 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -237,6 +237,27 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 }
 #endif
 
+#ifdef CONFIG_HAVE_SHADOW_STACKTRACE
+/**
+ * stack_trace_save_shadow - Save a stack trace based on shadow call stack
+ * @store:	Pointer to the storage array
+ * @size:	Size of the storage array
+ * @skipnr:	Number of entries to skip at the start of the stack trace
+ *
+ * Return: Number of trace entries stored.
+ */
+int stack_trace_save_shadow(unsigned long *store, unsigned int size,
+			    unsigned int skipnr)
+{
+	/*
+	 * Do not use stack_trace_consume_fn to avoid making a function
+	 * call for each collected frame to improve performance.
+	 * Skip + 1 frame to skip stack_trace_save_shadow.
+	 */
+	return arch_stack_walk_shadow(store, size, skipnr + 1);
+}
+#endif
+
 #else /* CONFIG_ARCH_STACKWALK */
 
 /*
-- 
2.25.1

