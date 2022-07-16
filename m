Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77A2577266
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiGPXRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiGPXRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C9A1AF22
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:15 -0700 (PDT)
Message-ID: <20220716230952.787452088@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4fi47O/0pVrlNGLHp44UcxjED6kI5STBjAcxzwbWyJc=;
        b=we7GlwNbtnKX6t1UjXXCfOgk/d/tK0f/WoIQ5JnMbR3PvYnECLlzc4RV+x1XxwH8+ilB9l
        VInJpKLOLGx4/BEEDAfVlGmzJ/l1WZY6AMVytFrbWQXgcsIsem+J3Ie7QRfWVxcxiZh0AT
        NRvWB8zFwv9V3cvhTnb5SKxJgsCv7iJNPjocjcaxaCJHb/4ScmpC+rrhdIsaer/KlnD//Q
        yUE04pTIYOlF87oG1eTI9+f9wmltFIwJLII6M86NQLUJVDGsnZfCocTVDAeJn5PhVK3Jib
        2ccaES0yrqIx3zSYYYKk4vnh74SFvgXEYgW8ZlTDtEJSUHqtvrld0wScgcITPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4fi47O/0pVrlNGLHp44UcxjED6kI5STBjAcxzwbWyJc=;
        b=qdCa5TIaaXeJkUFTt802dhkWoRMEiCfJKRWByzRlmwPoch0DFgbD6xpJzyZixxHfQbHdIw
        05z/jsknHGNa3QDg==
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
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 02/38] x86/cpu: Use native_wrmsrl() in load_percpu_segment()
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:12 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_percpu_segment() is using wrmsr() which is paravirtualized. That's an
issue because the code sequence is:

        __loadsegment_simple(gs, 0);
	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));

So anything which uses a per CPU variable between setting GS to 0 and
writing GSBASE is going to end up in a NULL pointer dereference. That's
can be triggered with instrumentation and is guaranteed to be triggered
with callthunks for call depth tracking.

Use native_wrmsrl() instead. XEN_PV will trap and emulate, but that's not a
hot path.

Also make it static and mark it noinstr so neither kprobes, sanitizers or
whatever can touch it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    1 -
 arch/x86/kernel/cpu/common.c     |   12 ++++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -673,7 +673,6 @@ extern struct desc_ptr		early_gdt_descr;
 extern void switch_to_new_gdt(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
-extern void load_percpu_segment(int);
 extern void cpu_init(void);
 extern void cpu_init_secondary(void);
 extern void cpu_init_exception_handling(void);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -701,13 +701,21 @@ static const char *table_lookup_model(st
 __u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
 __u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
 
-void load_percpu_segment(int cpu)
+static noinstr void load_percpu_segment(int cpu)
 {
 #ifdef CONFIG_X86_32
 	loadsegment(fs, __KERNEL_PERCPU);
 #else
 	__loadsegment_simple(gs, 0);
-	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
+	/*
+	 * Because of the __loadsegment_simple(gs, 0) above, any GS-prefixed
+	 * instruction will explode right about here. As such, we must not have
+	 * any CALL-thunks using per-cpu data.
+	 *
+	 * Therefore, use native_wrmsrl() and have XenPV take the fault and
+	 * emulate.
+	 */
+	native_wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
 #endif
 }
 

