Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BB357725F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiGPXTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiGPXSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B101A23174
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:18:05 -0700 (PDT)
Message-ID: <20220716230954.592165541@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5S6jiCi7pbggp/7rldxDyrEBlWY5m7T5K4YVZOSbqFw=;
        b=yrr0kPjQ+TXB6ttnMnbR7NNnxuozNMzJ9iH73qPOOls2sKXZn7uXp5p9ypUQJHK3DoIxer
        PGyloZYYll0pgGJfu6iEJqegftHAD9RLKZcc6jBy3FWOBMsMV79qclMfs+HVip4EEgtb8s
        lq2/Xu/rixXXRR5P8fxFHCCG/rOLdZ8FmRnWy+OFG8ltddsFidXe878eQeFcyslR1vs0uB
        j1UPaMBGc8KAK3fjL2ldWJLyCnxAblCqlJp4pWMHMpPsOy2XTu6ThPmgsQa6MNmg+17tcp
        hv+rc+BaVZ/QWoHGLRhzcsfbV9z1xbIFwW6MOJt6GPx4KbtkTjwrVHoSH+t/fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5S6jiCi7pbggp/7rldxDyrEBlWY5m7T5K4YVZOSbqFw=;
        b=RWX0luHjkHNuVZX4E++IoRMgZj4/e6aYd9O7QHOlkPaCSNpaXaqKhlH+wwDBQVTFPschsu
        fwmGHJKe9LHSizDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 32/38] static_call: Add call depth tracking support
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:18:01 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

When indirect calls are switched to direct calls then it has to be ensured
that the call target is not the function, but the call thunk when call
depth tracking is enabled. But static calls are available before call
thunks have been set up.

Ensure a second run through the static call patching code after call thunks
have been created. When call thunks are not enabled this has no side
effects.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/alternative.h |    5 +++++
 arch/x86/kernel/callthunks.c       |   37 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/static_call.c      |    1 +
 include/linux/static_call.h        |    2 ++
 kernel/static_call_inline.c        |   23 ++++++++++++++++++-----
 5 files changed, 63 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -93,12 +93,17 @@ extern void callthunks_patch_builtin_cal
 extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
 					  struct module *mod);
 extern void callthunks_module_free(struct module *mod);
+extern void *callthunks_translate_call_dest(void *dest);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
 callthunks_patch_module_calls(struct callthunk_sites *sites,
 			      struct module *mod) {}
 static __always_inline void callthunks_module_free(struct module *mod) { }
+static __always_inline void *callthunks_translate_call_dest(void *dest)
+{
+	return dest;
+}
 #endif
 
 #ifdef CONFIG_SMP
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -7,6 +7,7 @@
 #include <linux/memory.h>
 #include <linux/moduleloader.h>
 #include <linux/set_memory.h>
+#include <linux/static_call.h>
 #include <linux/vmalloc.h>
 
 #include <asm/alternative.h>
@@ -492,6 +493,7 @@ static __init noinline void callthunks_i
 	if (WARN_ON_ONCE(ret))
 		return;
 
+	static_call_force_reinit();
 	thunks_initialized = true;
 }
 
@@ -511,6 +513,41 @@ void __init callthunks_patch_builtin_cal
 	mutex_unlock(&text_mutex);
 }
 
+static bool is_module_init_dest(void *dest)
+{
+	bool ret = false;
+
+#ifdef CONFIG_MODULES
+	struct module *mod;
+
+	preempt_disable();
+	mod = __module_address((unsigned long)dest);
+	if (mod && within_module_init((unsigned long)dest, mod))
+		ret = true;
+	preempt_enable();
+#endif
+	return ret;
+}
+
+void *callthunks_translate_call_dest(void *dest)
+{
+	void *thunk;
+
+	lockdep_assert_held(&text_mutex);
+
+	if (!thunks_initialized || skip_addr(dest))
+		return dest;
+
+	thunk = btree_lookup64(&call_thunks, (unsigned long)dest);
+
+	if (thunk)
+		return thunk;
+
+	WARN_ON_ONCE(!is_kernel_inittext((unsigned long)dest) &&
+		     !is_module_init_dest(dest));
+	return dest;
+}
+
 #ifdef CONFIG_MODULES
 void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
 					    struct module *mod)
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -34,6 +34,7 @@ static void __ref __static_call_transfor
 
 	switch (type) {
 	case CALL:
+		func = callthunks_translate_call_dest(func);
 		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
 		if (func == &__static_call_return0) {
 			emulate = code;
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -162,6 +162,8 @@ extern void arch_static_call_transform(v
 
 extern int __init static_call_init(void);
 
+extern void static_call_force_reinit(void);
+
 struct static_call_mod {
 	struct static_call_mod *next;
 	struct module *mod; /* for vmlinux, mod == NULL */
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -15,7 +15,18 @@ extern struct static_call_site __start_s
 extern struct static_call_tramp_key __start_static_call_tramp_key[],
 				    __stop_static_call_tramp_key[];
 
-static bool static_call_initialized;
+static int static_call_initialized;
+
+/*
+ * Must be called before early_initcall() to be effective.
+ */
+void static_call_force_reinit(void)
+{
+	if (WARN_ON_ONCE(!static_call_initialized))
+		return;
+
+	static_call_initialized++;
+}
 
 /* mutex to protect key modules/sites */
 static DEFINE_MUTEX(static_call_mutex);
@@ -475,7 +486,8 @@ int __init static_call_init(void)
 {
 	int ret;
 
-	if (static_call_initialized)
+	/* See static_call_force_reinit(). */
+	if (static_call_initialized == 1)
 		return 0;
 
 	cpus_read_lock();
@@ -490,11 +502,12 @@ int __init static_call_init(void)
 		BUG();
 	}
 
-	static_call_initialized = true;
-
 #ifdef CONFIG_MODULES
-	register_module_notifier(&static_call_module_nb);
+	if (!static_call_initialized)
+		register_module_notifier(&static_call_module_nb);
 #endif
+
+	static_call_initialized = 1;
 	return 0;
 }
 early_initcall(static_call_init);

