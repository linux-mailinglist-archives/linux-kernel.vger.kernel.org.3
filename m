Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF7152DF6F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245182AbiESVln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244465AbiESVlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:41:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0344E40A26
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=66jVoWk+OA85s9ib6uVCg5Wh95Rp51ur8O6i8KwQNnE=; b=DJcr+aw1GwQzMhU+yRZ2IEAMuu
        8XHLx8RqIkp+uFv5OgMru0jrpLgXEnzyXspCZSJYiYbv6jI3TDzn5Sivpr6pQKAGJOu89WV37HdM0
        AtXVnemEUpp8ZyWaxgH4gaczPYahAdzW4Q2Bq6YNMHcTq0PP5hc0BzCQA5xcqjdzN41eVZqpy032Y
        IDlTRYi+E6UryFOD2dtxgue/dc03aN0TSDex/Br6vBhWYiI3yD/lKaPPKqMJPgiLRvm2Pqqp+jCEQ
        zFaHL+bv0Oc3URS/lSQ6fDy+JYXYRWQgJ3dThj0yJVrO2j7ODdITR+8pr7aQygnMgpVNOHKV79Uf5
        52ikL+NA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrntN-0028dl-Cr; Thu, 19 May 2022 21:41:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CB8A3002BE;
        Thu, 19 May 2022 23:41:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 04F812021B5DF; Thu, 19 May 2022 23:41:07 +0200 (CEST)
Message-ID: <20220519213421.687917982@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 19 May 2022 23:27:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org
Subject: [RFC][PATCH 2/9] x86/idle: Replace x86_idle with a static_call
References: <20220519212750.656413111@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typical boot time setup; no need to suffer an indirect call for that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/process.c |   50 +++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -24,6 +24,7 @@
 #include <linux/cpuidle.h>
 #include <linux/acpi.h>
 #include <linux/elf-randomize.h>
+#include <linux/static_call.h>
 #include <trace/events/power.h>
 #include <linux/hw_breakpoint.h>
 #include <asm/cpu.h>
@@ -692,7 +693,23 @@ void __switch_to_xtra(struct task_struct
 unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(boot_option_idle_override);
 
-static void (*x86_idle)(void);
+/*
+ * We use this if we don't have any better idle routine..
+ */
+void __cpuidle default_idle(void)
+{
+	raw_safe_halt();
+}
+#if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
+EXPORT_SYMBOL(default_idle);
+#endif
+
+DEFINE_STATIC_CALL_NULL(x86_idle, default_idle);
+
+static bool x86_idle_set(void)
+{
+	return !!static_call_query(x86_idle);
+}
 
 #ifndef CONFIG_SMP
 static inline void play_dead(void)
@@ -715,28 +732,17 @@ void arch_cpu_idle_dead(void)
 /*
  * Called from the generic idle code.
  */
-void arch_cpu_idle(void)
-{
-	x86_idle();
-}
-
-/*
- * We use this if we don't have any better idle routine..
- */
-void __cpuidle default_idle(void)
+void __cpuidle arch_cpu_idle(void)
 {
-	raw_safe_halt();
+	static_call(x86_idle)();
 }
-#if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
-EXPORT_SYMBOL(default_idle);
-#endif
 
 #ifdef CONFIG_XEN
 bool xen_set_default_idle(void)
 {
-	bool ret = !!x86_idle;
+	bool ret = x86_idle_set();
 
-	x86_idle = default_idle;
+	static_call_update(x86_idle, default_idle);
 
 	return ret;
 }
@@ -859,20 +865,20 @@ void select_idle_routine(const struct cp
 	if (boot_option_idle_override == IDLE_POLL && smp_num_siblings > 1)
 		pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
 #endif
-	if (x86_idle || boot_option_idle_override == IDLE_POLL)
+	if (x86_idle_set() || boot_option_idle_override == IDLE_POLL)
 		return;
 
 	if (boot_cpu_has_bug(X86_BUG_AMD_E400)) {
 		pr_info("using AMD E400 aware idle routine\n");
-		x86_idle = amd_e400_idle;
+		static_call_update(x86_idle, amd_e400_idle);
 	} else if (prefer_mwait_c1_over_halt(c)) {
 		pr_info("using mwait in idle threads\n");
-		x86_idle = mwait_idle;
+		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
-		x86_idle = tdx_safe_halt;
+		static_call_update(x86_idle, tdx_safe_halt);
 	} else
-		x86_idle = default_idle;
+		static_call_update(x86_idle, default_idle);
 }
 
 void amd_e400_c1e_apic_setup(void)
@@ -925,7 +931,7 @@ static int __init idle_setup(char *str)
 		 * To continue to load the CPU idle driver, don't touch
 		 * the boot_option_idle_override.
 		 */
-		x86_idle = default_idle;
+		static_call_update(x86_idle, default_idle);
 		boot_option_idle_override = IDLE_HALT;
 	} else if (!strcmp(str, "nomwait")) {
 		/*


