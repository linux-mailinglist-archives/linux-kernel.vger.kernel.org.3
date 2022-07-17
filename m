Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5D3577885
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 23:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiGQVy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 17:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiGQVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 17:54:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656CB63C5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 14:54:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658094857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRzPJGFbY+ihEhq17hmTH+dK8kmlJtap/eTytjWRCs0=;
        b=z+z7LGsUDkLV++luahZ4DC4XH9e1TUis2cVmFWadaWkg45d246ZQMzQdsfpNhM4w9DZpo1
        GczqdROqeFDQFVPzykDyen1zN3FNKWqeGEP4nNOdT6qyGSlGhARUIE3MozgYyjDWKkSn/+
        SOAN1rSbw7RULwisRAUR1D65h6pS8EOOMQSoRoYi1riE7qGjYoAgC3X5T1HnWWL5xN+xx4
        lCR2UdpBw6R/Xt655pX8Sdb7FTkL4INVMdstLr2R03zMUImGvqPoZwocLccklQDDDDGbRO
        62mSQD1hPwyL/rL0xhdZ/MQbEDwSfaTSvVVidcxdLYI8tug3ZipZkoI5Z1Z+pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658094857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRzPJGFbY+ihEhq17hmTH+dK8kmlJtap/eTytjWRCs0=;
        b=JPPZsryaaXeA4jTfNogGPo2zUBWFxTEe5Jn6oUXVA3Pdb5bo2CjVSjiQvnZmxoGYRyi2Te
        JOtOSIFBUlJuc1Cw==
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 02/38] x86/cpu: Use native_wrmsrl() in
 load_percpu_segment()
In-Reply-To: <87r12jwl9l.ffs@tglx>
References: <20220716230344.239749011@linutronix.de>
 <20220716230952.787452088@linutronix.de>
 <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com> <87zgh7wo91.ffs@tglx>
 <87tu7fwlhr.ffs@tglx> <87r12jwl9l.ffs@tglx>
Date:   Sun, 17 Jul 2022 23:54:16 +0200
Message-ID: <87o7xnwgl3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17 2022 at 22:13, Thomas Gleixner wrote:
> On Sun, Jul 17 2022 at 22:08, Thomas Gleixner wrote:
>> On Sun, Jul 17 2022 at 21:08, Thomas Gleixner wrote:
>> loadsegment_simple() was a red herring. The gs segment is already zero.
>>
>> So what explodes here is the early boot when switching from early per
>> CPU to the real per CPU area.
>>
>> start_kernel()
>>         .....
>>         setup_per_cpu_areas();
>>         smp_prepare_boot_cpu()
>
> Bah. switch_to_new_gdt() is already invoked from setup_per_cpu_areas()
> and then again in smp_prepare_boot_cpu() and once more in cpu_init(),
>
> What a mess.

So the below builds and boots at least on 64bit. I'll stare at it some
more tomorrow. I have no idea whether native_load_gdt() works with
XEN_PV. It should, but what do I know.

Thanks,

        tglx
---
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -205,7 +205,7 @@ static inline void native_set_ldt(const
 	}
 }
 
-static inline void native_load_gdt(const struct desc_ptr *dtr)
+static __always_inline void native_load_gdt(const struct desc_ptr *dtr)
 {
 	asm volatile("lgdt %0"::"m" (*dtr));
 }
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -670,10 +670,9 @@ extern int sysenter_setup(void);
 /* Defined in head.S */
 extern struct desc_ptr		early_gdt_descr;
 
-extern void switch_to_new_gdt(int);
+extern void switch_to_real_gdt(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
-extern void load_percpu_segment(int);
 extern void cpu_init(void);
 extern void cpu_init_secondary(void);
 extern void cpu_init_exception_handling(void);
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -7,20 +7,24 @@
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_common.o = -pg
 CFLAGS_REMOVE_perf_event.o = -pg
+CFLAGS_REMOVE_switch_gdt.o = -pg
 endif
 
 # If these files are instrumented, boot hangs during the first second.
 KCOV_INSTRUMENT_common.o := n
 KCOV_INSTRUMENT_perf_event.o := n
+KCOV_INSTRUMENT_switch_gdt.o := n
 
 # As above, instrumenting secondary CPU boot code causes boot hangs.
 KCSAN_SANITIZE_common.o := n
+KCSAN_SANITIZE_switch_gdt.o := n
 
-# Make sure load_percpu_segment has no stackprotector
-CFLAGS_common.o		:= -fno-stack-protector
+# Make sure that switching the GDT and the per CPU segment
+# does not have stack protector enabled.
+CFLAGS_switch_gdt.o	:= -fno-stack-protector
 
 obj-y			:= cacheinfo.o scattered.o topology.o
-obj-y			+= common.o
+obj-y			+= common.o switch_gdt.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
 obj-y			+= bugs.o
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
@@ -738,18 +728,6 @@ void load_fixmap_gdt(int cpu)
 }
 EXPORT_SYMBOL_GPL(load_fixmap_gdt);
 
-/*
- * Current gdt points %fs at the "master" per-cpu area: after this,
- * it's on the real one.
- */
-void switch_to_new_gdt(int cpu)
-{
-	/* Load the original GDT */
-	load_direct_gdt(cpu);
-	/* Reload the per-cpu base */
-	load_percpu_segment(cpu);
-}
-
 static const struct cpu_dev *cpu_devs[X86_VENDOR_NUM] = {};
 
 static void get_model_name(struct cpuinfo_x86 *c)
@@ -2228,12 +2206,6 @@ void cpu_init(void)
 	    boot_cpu_has(X86_FEATURE_TSC) || boot_cpu_has(X86_FEATURE_DE))
 		cr4_clear_bits(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
 
-	/*
-	 * Initialize the per-CPU GDT with the boot GDT,
-	 * and set up the GDT descriptor:
-	 */
-	switch_to_new_gdt(cpu);
-
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		loadsegment(fs, 0);
 		memset(cur->thread.tls_array, 0, GDT_ENTRY_TLS_ENTRIES * 8);
--- /dev/null
+++ b/arch/x86/kernel/cpu/switch_gdt.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <asm/processor.h>
+#include <asm/segment.h>
+#include <asm/desc.h>
+
+/*
+ * Invoked during early boot to switch from early GDT and early per CPU
+ * (%fs on 32bit, GS_BASE on 64bit) to the real GDT and the runtime per CPU
+ * area.
+ *
+ * This has to be done atomic because after switching from early GDT to
+ * the real one any per cpu variable access is going to fault because
+ * %fs resp. GS_BASE is not yet pointing to the real per CPU data.
+ *
+ * As a consequence this uses the native variants of load_gdt() and
+ * wrmsrl(). So XEN_PV has to take the fault and emulate.
+ */
+void __init switch_to_real_gdt(int cpu)
+{
+	struct desc_ptr gdt_descr;
+
+	gdt_descr.address = (long)get_cpu_gdt_rw(cpu);
+	gdt_descr.size = GDT_SIZE - 1;
+	native_load_gdt(&gdt_descr);
+
+#ifdef CONFIG_X86_32
+	loadsegment(fs, __KERNEL_PERCPU);
+#else
+	native_wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
+#endif
+}
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -211,7 +211,7 @@ void __init setup_per_cpu_areas(void)
 		 * area.  Reload any changed state for the boot CPU.
 		 */
 		if (!cpu)
-			switch_to_new_gdt(cpu);
+			switch_to_real_gdt(cpu);
 	}
 
 	/* indicate the early static arrays will soon be gone */
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1457,7 +1457,11 @@ void arch_thaw_secondary_cpus_end(void)
 void __init native_smp_prepare_boot_cpu(void)
 {
 	int me = smp_processor_id();
-	switch_to_new_gdt(me);
+
+	/* SMP invokes this from setup_per_cpu_areas() */
+	if (!IS_ENABLED(CONFIG_SMP))
+		switch_to_real_gdt(me);
+
 	/* already set me in cpu_online_mask in boot_cpu_init() */
 	cpumask_set_cpu(me, cpu_callout_mask);
 	cpu_set_state_online(me);
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1164,7 +1164,7 @@ static void __init xen_setup_gdt(int cpu
 	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry_boot;
 	pv_ops.cpu.load_gdt = xen_load_gdt_boot;
 
-	switch_to_new_gdt(cpu);
+	switch_to_real_gdt(cpu);
 
 	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry;
 	pv_ops.cpu.load_gdt = xen_load_gdt;

