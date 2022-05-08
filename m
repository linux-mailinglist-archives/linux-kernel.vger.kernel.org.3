Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F151ED55
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiEHMLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiEHMLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:11:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC4E60C0
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:07:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652011633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=23uoMWOSbZFEDZ+lD4psiytK5JZ2eAs3VrMpI5yC2+w=;
        b=2HMOGF/BAVuO4X/KNGuft1AWpo7l4a4qL86tNtwYl4s+mzILUgpBqA0j8t/iWY+vbqhw2A
        jdwWCcDlTVpLPSV2IPxcy+SHgVn8cPW/ijo9ExM2WWQFARFN2VrkavslGcPwA4d6VypNzJ
        4r2fmzrDZZD/o93COuBskD35Gq49XxrCuRmaHYDniUNtfMvaWVh6YItIvx+Xemma4nMH0s
        Mj4A3kfLhfZWVXkC9glmnmUF9RhpBlCU75DDAt3EQ3lrphPqsktrQicdaw/uqg6qA5s2dU
        pHfG24MUTCxb3wWm/KGaPf0c6d2zvbw5k47xKxehAXqBSwTMgWXaPuDUB0ggnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652011633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=23uoMWOSbZFEDZ+lD4psiytK5JZ2eAs3VrMpI5yC2+w=;
        b=bro1s94+hr/m++bH11HytUI4sJSWijOEY0wZE9+wNEN2CV2NsatVg/2mfh19HewwEl3FUk
        wBd5Jf5KgLje7DBA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.18-rc6
References: <165201148069.536527.1960632033331546251.tglx@xen13>
Message-ID: <165201159583.536601.1349852832993944140.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  8 May 2022 14:07:12 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-=
05-08

up to:  59f5ede3bc0f: x86/fpu: Prevent FPU state corruption


A fix and an email address update:

 - Prevent FPU state corruption. The condition in irq_fpu_usable() grants
   FPU usage when the FPU is not used in the kernel. That's just wrong as
   it does not take the fpregs_lock()'ed regions into account. If FPU usage
   happens within such a region from interrupt context, then the FPU state
   gets corrupted. That's a long standing bug, which got unearthed by the
   recent changes to the random code.

 - Josh wants to use his kernel.org email address


Thanks,

	tglx

------------------>
Josh Poimboeuf (1):
      MAINTAINERS: Update Josh Poimboeuf's email address

Thomas Gleixner (1):
      x86/fpu: Prevent FPU state corruption


 MAINTAINERS                | 10 +++----
 arch/x86/kernel/fpu/core.c | 67 ++++++++++++++++++--------------------------=
--
 2 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cdb85e8..1e1a2264792d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7499,7 +7499,7 @@ F:	Documentation/hwmon/f71805f.rst
 F:	drivers/hwmon/f71805f.c
=20
 FADDR2LINE
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 S:	Maintained
 F:	scripts/faddr2line
=20
@@ -11348,7 +11348,7 @@ F:	drivers/mmc/host/litex_mmc.c
 N:	litex
=20
 LIVE PATCHING
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Jiri Kosina <jikos@kernel.org>
 M:	Miroslav Benes <mbenes@suse.cz>
 M:	Petr Mladek <pmladek@suse.com>
@@ -14224,7 +14224,7 @@ F:	lib/objagg.c
 F:	lib/test_objagg.c
=20
 OBJTOOL
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 S:	Supported
 F:	tools/objtool/
@@ -18792,7 +18792,7 @@ F:	include/dt-bindings/reset/starfive-jh7100.h
=20
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Jason Baron <jbaron@akamai.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Ard Biesheuvel <ardb@kernel.org>
@@ -21444,7 +21444,7 @@ F:	arch/x86/kernel/apic/x2apic_uv_x.c
 F:	arch/x86/platform/uv/
=20
 X86 STACK UNWINDING
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 S:	Supported
 F:	arch/x86/include/asm/unwind*.h
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index c049561f373a..e28ab0ecc537 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -41,17 +41,7 @@ struct fpu_state_config fpu_user_cfg __ro_after_init;
  */
 struct fpstate init_fpstate __ro_after_init;
=20
-/*
- * Track whether the kernel is using the FPU state
- * currently.
- *
- * This flag is used:
- *
- *   - by IRQ context code to potentially use the FPU
- *     if it's unused.
- *
- *   - to debug kernel_fpu_begin()/end() correctness
- */
+/* Track in-kernel FPU usage */
 static DEFINE_PER_CPU(bool, in_kernel_fpu);
=20
 /*
@@ -59,42 +49,37 @@ static DEFINE_PER_CPU(bool, in_kernel_fpu);
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
=20
-static bool kernel_fpu_disabled(void)
-{
-	return this_cpu_read(in_kernel_fpu);
-}
-
-static bool interrupted_kernel_fpu_idle(void)
-{
-	return !kernel_fpu_disabled();
-}
-
-/*
- * Were we in user mode (or vm86 mode) when we were
- * interrupted?
- *
- * Doing kernel_fpu_begin/end() is ok if we are running
- * in an interrupt context from user mode - we'll just
- * save the FPU state as required.
- */
-static bool interrupted_user_mode(void)
-{
-	struct pt_regs *regs =3D get_irq_regs();
-	return regs && user_mode(regs);
-}
-
 /*
  * Can we use the FPU in kernel mode with the
  * whole "kernel_fpu_begin/end()" sequence?
- *
- * It's always ok in process context (ie "not interrupt")
- * but it is sometimes ok even from an irq.
  */
 bool irq_fpu_usable(void)
 {
-	return !in_interrupt() ||
-		interrupted_user_mode() ||
-		interrupted_kernel_fpu_idle();
+	if (WARN_ON_ONCE(in_nmi()))
+		return false;
+
+	/* In kernel FPU usage already active? */
+	if (this_cpu_read(in_kernel_fpu))
+		return false;
+
+	/*
+	 * When not in NMI or hard interrupt context, FPU can be used in:
+	 *
+	 * - Task context except from within fpregs_lock()'ed critical
+	 *   regions.
+	 *
+	 * - Soft interrupt processing context which cannot happen
+	 *   while in a fpregs_lock()'ed critical region.
+	 */
+	if (!in_hardirq())
+		return true;
+
+	/*
+	 * In hard interrupt context it's safe when soft interrupts
+	 * are enabled, which means the interrupt did not hit in
+	 * a fpregs_lock()'ed critical region.
+	 */
+	return !softirq_count();
 }
 EXPORT_SYMBOL(irq_fpu_usable);
=20

