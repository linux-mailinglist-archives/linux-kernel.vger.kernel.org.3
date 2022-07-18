Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A955788D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiGRRwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiGRRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:52:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC072D1F5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:52:11 -0700 (PDT)
Message-ID: <20220718173923.891284477@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658166730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=DV9RISA2Yv9qpZ7RXhfs8KoIUDaQkO6UidbNBFBKI9E=;
        b=ZpfHOdqI16tdUfnRa2uOuJY/hmF9Uq/HBDYSIPE2o+A84ExAAF9yVx1+a8d28DFuafbyZP
        QLR83/d/MxKBwBdbZgT3rVUopF5TZuaTHOJn94ZTPaDyVgTpNEH5jhqA/egLF9CXCUiHUo
        gn9MEoog8jxfSYuJxog9/L+yn5Z+B46jsvY07kqps/zLvve3XlUuR59uL11FDkOaTit03W
        lSWBoXofwEeIA36pT+HArY4MOGcRlwHapQ0lu0Q9tES1uK7wgeayY78jdWKzeAvQnqBgFR
        OE9K7RoKeV52SikTxqZ4W9p1tkymj8lZf1jIEAQGGgSMYJjyERLWP/YLSfmKMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658166730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=DV9RISA2Yv9qpZ7RXhfs8KoIUDaQkO6UidbNBFBKI9E=;
        b=CJQhoRogbuVlr8JBV7GlEDffoyfEHS5JeiJnbVyARuL+WtH6HeLC/Zyn2WjHNsmpNfBxWR
        DzqPvXACoLaFf3Dw==
2Message-ID: <20220718173814.731702240@linutronix.de>
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
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch 1/3] x86/cpu: Remove segment load from switch_to_new_gdt()
References: <20220716230952.787452088@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 18 Jul 2022 19:52:09 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32bit FS and on 64bit GS segments are already set up correctly, but
load_percpu_segment() still sets [FG]S after switching from the early GDT
to the direct GDT.

For 32bit the segment load has no side effects, but on 64bit it causes
GSBASE to become 0, which means that any per CPU access before GSBASE is
set to the new value is going to fault. That's the reason why the whole
file containing this code has stackprotector removed.

But that's a pointless exercise for both 32 and 64 bit as the relevant
segment selector is already correct. Loading the new GDT does not change
that.

Remove the segment loads and inline load_percpu_segment() into the only
caller. Add comments while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    1 
 arch/x86/kernel/cpu/common.c     |   42 ++++++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 17 deletions(-)

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
@@ -701,16 +701,6 @@ static const char *table_lookup_model(st
 __u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
 __u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
 
-void load_percpu_segment(int cpu)
-{
-#ifdef CONFIG_X86_32
-	loadsegment(fs, __KERNEL_PERCPU);
-#else
-	__loadsegment_simple(gs, 0);
-	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
-#endif
-}
-
 #ifdef CONFIG_X86_32
 /* The 32-bit entry code needs to find cpu_entry_area. */
 DEFINE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
@@ -738,16 +728,36 @@ void load_fixmap_gdt(int cpu)
 }
 EXPORT_SYMBOL_GPL(load_fixmap_gdt);
 
-/*
- * Current gdt points %fs at the "master" per-cpu area: after this,
- * it's on the real one.
+/**
+ * switch_to_new_gdt - Switch form early GDT to the direct one
+ * @cpu:	The CPU number for which this is invoked
+ *
+ * Invoked during early boot to switch from early GDT and early per CPU
+ * (%fs on 32bit, GS_BASE on 64bit) to the direct GDT and the runtime per
+ * CPU area.
  */
 void switch_to_new_gdt(int cpu)
 {
-	/* Load the original GDT */
 	load_direct_gdt(cpu);
-	/* Reload the per-cpu base */
-	load_percpu_segment(cpu);
+
+	/*
+	 * No need to load the %gs (%fs for 32bit) segment. It is already
+	 * correct, %gs is 0 on 64bit and %fs is __KERNEL_PERCPU on 32 bit.
+	 *
+	 * Writing %gs on 64bit would zero GSBASE which would make any per
+	 * CPU operation up to the point of the wrmsrl() fault.
+	 *
+	 * 64bit requires to point GSBASE to the new offset. Until the
+	 * wrmsrl() happens the early mapping is still valid. That means
+	 * the GSBASE update will lose any prior per CPU data which was
+	 * not copied over in setup_per_cpu_areas().
+	 *
+	 * For secondary CPUs this is not a problem because they start
+	 * already with the direct GDT and the real GSBASE. This invocation
+	 * is pointless and will be removed in a subsequent step.
+	 */
+	if (IS_ENABLED(CONFIG_X86_64))
+		wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
 }
 
 static const struct cpu_dev *cpu_devs[X86_VENDOR_NUM] = {};

