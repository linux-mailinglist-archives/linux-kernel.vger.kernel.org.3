Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5514823CE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 12:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhLaLsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 06:48:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhLaLsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 06:48:10 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 869CD1EC018B;
        Fri, 31 Dec 2021 12:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640951285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hDF7WztMUDG5oZW7Uldm0ui+Z4oRs5NXMN0dhtH5eys=;
        b=rxOSfpXYlmSpTOm5wTMLf+wARpGMEhg7f/Yg9A3DhfxI1cV3Yd16h2B9gfhJZ86q4Axmzy
        AjQd/vL9Y21FWgkp8+g5qQ5/SKjje8eeoe8Aig9lsd5qJg31p0zGcTwwxvqdNp+C5k4Nwm
        vx+aY1+GmPukQ1fQ7sKKVJi5/7MJv4s=
Date:   Fri, 31 Dec 2021 12:48:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:ras/core] BUILD SUCCESS
 de768416b203ac84e02a757b782a32efb388476f
Message-ID: <Yc7t934f+f/mO8lj@zn.tnic>
References: <61cba815.Her0ebRPVzS617KT%lkp@intel.com>
 <YcwrofZrHadGAMlD@zn.tnic>
 <5925b071-0b4b-b8da-5cf2-5c66ec2ac08f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5925b071-0b4b-b8da-5cf2-5c66ec2ac08f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 08:46:52AM +0800, Chen, Rong A wrote:
> Hi Borislav,
> 
> Below is the report:
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
> head:   de768416b203ac84e02a757b782a32efb388476f
> commit: b4813539d37fa31fed62cdfab7bd2dd8929c5b2e [15/23] x86/mce: Mark
> mce_end() noinstr
> config: x86_64-buildonly-randconfig-r006-20211228 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=b4813539d37fa31fed62cdfab7bd2dd8929c5b2e
>         git remote add tip
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip ras/core
>         git checkout b4813539d37fa31fed62cdfab7bd2dd8929c5b2e
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> vmlinux.o: warning: objtool: do_machine_check()+0x59a: call to test_bit()
> leaves .noinstr.text section

Thanks!

Hmm, so staring at this, it looks kinda weird. Lemme add Peter.

So with your .config I see

vmlinux.o: warning: objtool: mce_start()+0x6a: call to clear_bit() leaves .noinstr.text section

This one generates a call to clear_bit() even though that function is
inline. And yeah, I know, it doesn't always inline it and looking at the
asm, it does generate a clear_bit function down in that same compilation
unit:

	.size	set_bit, .-set_bit
	.type	clear_bit, @function
clear_bit:
	pushq	%rbp	#
	movq	%rsp, %rbp	#,
	pushq	%r12	#
	movq	%rdi, %r12	# tmp84, nr
	pushq	%rbx	#
# ./include/asm-generic/bitops/instrumented-atomic.h:40: {
	movq	%rsi, %rbx	# tmp85, addr
# ./arch/x86/include/asm/bitops.h:79: 		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
	call	__sanitizer_cov_trace_pc	#
#APP
# 79 "./arch/x86/include/asm/bitops.h" 1
	 btrq  %r12,(%rbx)	# nr, MEM[(volatile long int *)addr_2(D)]
# 0 "" 2
# ./include/asm-generic/bitops/instrumented-atomic.h:43: }
#NO_APP
	popq	%rbx	#
	popq	%r12	#
	popq	%rbp	#
	ret	
	.size	clear_bit, .-clear_bit
	.type	test_bit, @function

I guess the compiler decided not to inline the function. The fix for
that is easy, see below.

The next one is:

vmlinux.o: warning: objtool: mce_read_aux()+0x53: call to mca_msr_reg() leaves .noinstr.text section

That one needs instrumentation range widening too, see below.

And the next one is:

vmlinux.o: warning: objtool: do_machine_check()+0xc9: call to mce_no_way_out() leaves .noinstr.text section

mce_no_way_out() is called only once by do_machine_check(), I guess it can be __always_inline.

Which then leads to:

vmlinux.o: warning: objtool: do_machine_check()+0x48e: call to test_bit() leaves .noinstr.text section

and that is again those *_bit() functions which do not get inlined but
actual calls to them get generated:

test_bit:
	pushq	%rbp	#
	movq	%rsp, %rbp	#,
	pushq	%r12	#
	movq	%rdi, %r12	# tmp87, nr
	pushq	%rbx	#
# ./include/asm-generic/bitops/instrumented-non-atomic.h:133: {
	movq	%rsi, %rbx	# tmp88, addr
# ./arch/x86/include/asm/bitops.h:214: 	asm volatile(__ASM_SIZE(bt) " %2,%1"
	call	__sanitizer_cov_trace_pc	#
#APP
# 214 "./arch/x86/include/asm/bitops.h" 1
	 btq  %r12,(%rbx)	# nr, MEM[(long unsigned int *)addr_5(D)]
	/* output condition code c*/

# 0 "" 2
# ./include/asm-generic/bitops/instrumented-non-atomic.h:136: }
#NO_APP
	popq	%rbx	#
# ./arch/x86/include/asm/bitops.h:214: 	asm volatile(__ASM_SIZE(bt) " %2,%1"
	setc	%al	#, oldbit
# ./include/asm-generic/bitops/instrumented-non-atomic.h:136: }
	popq	%r12	#
	popq	%rbp	#
	ret	
	.size	test_bit, .-test_bit

---

if I do:

diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Makefile
index 015856abdbb1..3afa0585bc75 100644
--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
+#
+
+KCOV_INSTRUMENT_core.o         := n
+

then test_bit still remains a call:

---
        .type   test_bit, @function
test_bit:
# ./arch/x86/include/asm/bitops.h:214:  asm volatile(__ASM_SIZE(bt) " %2,%1"
#APP
# 214 "./arch/x86/include/asm/bitops.h" 1
         btq  %rdi,(%rsi)       # tmp87, MEM[(long unsigned int *)addr_5(D)]
        /* output condition code c*/

# 0 "" 2
#NO_APP
        setc    %al     #, oldbit
# ./include/asm-generic/bitops/instrumented-non-atomic.h:136: }
        ret     
        .size   test_bit, .-test_bit
---

and that *should* *get* inlined, for chrissakes! It is *two* insns!

Disabling CONFIG_KCOV doesn't help either - those *_bit() manipulation
functions are still not inlined.

Anyway, here's what I have so far:

---
diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Makefile
index 015856abdbb1..3afa0585bc75 100644
--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
+#
+
+KCOV_INSTRUMENT_core.o		:= n
+
 obj-y				=  core.o severity.o genpool.o
 
 obj-$(CONFIG_X86_ANCIENT_MCE)	+= winchip.o p5.o
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..aca1408d2d93 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -648,7 +648,7 @@ static struct notifier_block mce_default_nb = {
 /*
  * Read ADDR and MISC registers.
  */
-static noinstr void mce_read_aux(struct mce *m, int i)
+static void mce_read_aux(struct mce *m, int i)
 {
 	if (m->status & MCI_STATUS_MISCV)
 		m->misc = mce_rdmsrl(mca_msr_reg(i, MCA_MISC));
@@ -838,8 +838,8 @@ static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
  */
-static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
-			  struct pt_regs *regs)
+static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
+					  struct pt_regs *regs)
 {
 	char *tmp = *msg;
 	int i;
@@ -1021,11 +1021,12 @@ static noinstr int mce_start(int *no_way_out)
 	 * is updated before mce_callin.
 	 */
 	order = atomic_inc_return(&mce_callin);
-	cpumask_clear_cpu(smp_processor_id(), &mce_missing_cpus);
 
 	/* Enable instrumentation around calls to external facilities */
 	instrumentation_begin();
 
+	cpumask_clear_cpu(smp_processor_id(), &mce_missing_cpus);
+
 	/*
 	 * Wait for everyone.
 	 */
@@ -1250,16 +1251,17 @@ __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
 		if (severity == MCE_NO_SEVERITY)
 			continue;
 
+		/*
+		 * Enable instrumentation around the MCE logging which is
+		 * done in #MC context, where instrumentation is disabled.
+		 */
+		instrumentation_begin();
+
 		mce_read_aux(m, i);
 
 		/* assuming valid severity level != 0 */
 		m->severity = severity;
 
-		/*
-		 * Enable instrumentation around the mce_log() call which is
-		 * done in #MC context, where instrumentation is disabled.
-		 */
-		instrumentation_begin();
 		mce_log(m);
 		instrumentation_end();
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
