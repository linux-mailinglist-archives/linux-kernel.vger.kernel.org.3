Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC0653DB03
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350936AbiFEJa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiFEJaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:30:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4DBEE1F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 02:30:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654421450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mOUHzcQAeGWkfGt6jDnjujJovCF8yQ4Zwhio9b5ZyqY=;
        b=owLhroAFbvYl/KC6d/Ksl5P0zHUVrwTX/DRAmg+Bz6sB62/tznxBJU1xvhl5RArUtbXXWq
        bL62VgemcM6I2AW/xcAgt/WoQinItuVhL1sqxoDen6AexXrQVf0HMER69ICvU6LRKphKaB
        bs4aHvPdFBWzove9SXK3rDKx+O25oZWvtb2igjyygsj8VCNmcF+pX3/lzFjurYh+0K4XCy
        rqYwSU131zSOYa7F2pYrcRhPEGsCnK31DxxophvOyT6jAXnGwpTkJ9+WwcSlcN9lcIi3rU
        VdgS/BQzM4r0Ugv5/Qo4cbR9B5BMXeLrmy0MBW9fO3bKcmlTHO1zYLxHpyXjSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654421450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mOUHzcQAeGWkfGt6jDnjujJovCF8yQ4Zwhio9b5ZyqY=;
        b=WrYWe/47tFBANyarHSfYkmQoj8L5W2mybK2PFuWKjOP1pB2WNKfSi7u73ZpaOsnDiM8s6E
        MLt3LNAxIDRtzuBw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] objtool/urgent for v5.19-rc1
Message-ID: <165442136963.152751.14259048792272164569.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  5 Jun 2022 11:30:50 +0200 (CEST)
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

please pull the latest objtool/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2=
022-06-05

up to:  2028a255f4df: x86/extable: Annotate ex_handler_msr_mce() as a dead end


A set of objtool fixes:

  - Handle __ubsan_handle_builtin_unreachable() correctly and treat it as
    noreturn.

  - Allow architectures to select uaccess validation

  - Use the non-instrumented bit test for test_cpu_has() to prevent escape
    from non-instrumentable regions.

  - Use arch_ prefixed atomics for JUMP_LABEL=3Dn builds to prevent escape
    from non-instrumentable regions.

  - Mark a few tiny inline as __always_inline to prevent GCC from bringing
    them out of line and instrumenting them.

  - Mark the empty stub context_tracking_enabled() as always inline as GCC
    brings them out of line and instruments the empty shell.

  - Annotate ex_handler_msr_mce() as dead end

Thanks,

	tglx

------------------>
Borislav Petkov (1):
      x86/extable: Annotate ex_handler_msr_mce() as a dead end

Josh Poimboeuf (1):
      objtool: Add CONFIG_HAVE_UACCESS_VALIDATION

Peter Zijlstra (5):
      objtool: Mark __ubsan_handle_builtin_unreachable() as noreturn
      x86/cpu: Elide KCSAN for cpu_has() and friends
      jump_label,noinstr: Avoid instrumentation for JUMP_LABEL=3Dn builds
      x86: Always inline on_thread_stack() and current_top_of_stack()
      context_tracking: Always inline empty stubs


 arch/Kconfig                           | 4 ++++
 arch/x86/Kconfig                       | 1 +
 arch/x86/include/asm/cpufeature.h      | 2 +-
 arch/x86/include/asm/extable.h         | 8 ++++++--
 arch/x86/include/asm/processor.h       | 4 ++--
 include/linux/context_tracking_state.h | 8 ++++----
 include/linux/jump_label.h             | 4 ++--
 scripts/Makefile.build                 | 2 +-
 scripts/link-vmlinux.sh                | 4 +++-
 tools/objtool/check.c                  | 4 +++-
 10 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 904ed51736d4..cb2954027d10 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1050,6 +1050,10 @@ config HAVE_NOINSTR_HACK
 config HAVE_NOINSTR_VALIDATION
 	bool
=20
+config HAVE_UACCESS_VALIDATION
+	bool
+	select OBJTOOL
+
 config HAVE_STACK_VALIDATION
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cf531fbcd229..5f41f3c3df9a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -258,6 +258,7 @@ config X86
 	select HAVE_PREEMPT_DYNAMIC_CALL
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeat=
ure.h
index 66d3e3b1d24d..ea34cc31b047 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -54,7 +54,7 @@ extern const char * const x86_power_flags[32];
 extern const char * const x86_bug_flags[NBUGINTS*32];
=20
 #define test_cpu_cap(c, bit)						\
-	 test_bit(bit, (unsigned long *)((c)->x86_capability))
+	 arch_test_bit(bit, (unsigned long *)((c)->x86_capability))
=20
 /*
  * There are 32 bits/features in each mask word.  The high bits
diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index 155c991ba95e..eeed395c3177 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -42,9 +42,13 @@ extern int ex_get_fixup_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
=20
 #ifdef CONFIG_X86_MCE
-extern void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr);
+extern void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr);
 #else
-static inline void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr) { }
+static inline void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool =
wrmsr)
+{
+	for (;;)
+		cpu_relax();
+}
 #endif
=20
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_X86_64)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index 91d0f93a00c7..356308c73951 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -559,7 +559,7 @@ static __always_inline void native_swapgs(void)
 #endif
 }
=20
-static inline unsigned long current_top_of_stack(void)
+static __always_inline unsigned long current_top_of_stack(void)
 {
 	/*
 	 *  We can't read directly from tss.sp0: sp0 on x86_32 is special in
@@ -569,7 +569,7 @@ static inline unsigned long current_top_of_stack(void)
 	return this_cpu_read_stable(cpu_current_top_of_stack);
 }
=20
-static inline bool on_thread_stack(void)
+static __always_inline bool on_thread_stack(void)
 {
 	return (unsigned long)(current_top_of_stack() -
 			       current_stack_pointer) < THREAD_SIZE;
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_t=
racking_state.h
index 65a60d3313b0..ae1e63e26947 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -46,10 +46,10 @@ static __always_inline bool context_tracking_in_user(void)
 	return __this_cpu_read(context_tracking.state) =3D=3D CONTEXT_USER;
 }
 #else
-static inline bool context_tracking_in_user(void) { return false; }
-static inline bool context_tracking_enabled(void) { return false; }
-static inline bool context_tracking_enabled_cpu(int cpu) { return false; }
-static inline bool context_tracking_enabled_this_cpu(void) { return false; }
+static __always_inline bool context_tracking_in_user(void) { return false; }
+static __always_inline bool context_tracking_enabled(void) { return false; }
+static __always_inline bool context_tracking_enabled_cpu(int cpu) { return f=
alse; }
+static __always_inline bool context_tracking_enabled_this_cpu(void) { return=
 false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
=20
 #endif
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 107751cc047b..bf1eef337a07 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -256,9 +256,9 @@ extern void static_key_disable_cpuslocked(struct static_k=
ey *key);
 #include <linux/atomic.h>
 #include <linux/bug.h>
=20
-static inline int static_key_count(struct static_key *key)
+static __always_inline int static_key_count(struct static_key *key)
 {
-	return atomic_read(&key->enabled);
+	return arch_atomic_read(&key->enabled);
 }
=20
 static __always_inline void jump_label_init(void)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 06400504150b..6a663b27b286 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -218,7 +218,7 @@ objtool_args =3D								\
 	$(if $(CONFIG_SLS), --sls)					\
 	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
 	$(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)		\
-	--uaccess							\
+	$(if $(CONFIG_HAVE_UACCESS_VALIDATION), --uaccess)		\
 	$(if $(linked-object), --link)					\
 	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a7f6196c7e41..fd578c380919 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -134,7 +134,9 @@ objtool_link()
 			objtoolopt=3D"${objtoolopt} --static-call"
 		fi
=20
-		objtoolopt=3D"${objtoolopt} --uaccess"
+		if is_enabled CONFIG_HAVE_UACCESS_VALIDATION; then
+			objtoolopt=3D"${objtoolopt} --uaccess"
+		fi
 	fi
=20
 	if is_enabled CONFIG_NOINSTR_VALIDATION; then
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 190b2f6e360a..864bb9dd3584 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -185,7 +185,9 @@ static bool __dead_end_function(struct objtool_file *file=
, struct symbol *func,
 		"do_group_exit",
 		"stop_this_cpu",
 		"__invalid_creds",
-               "cpu_startup_entry",
+		"cpu_startup_entry",
+		"__ubsan_handle_builtin_unreachable",
+		"ex_handler_msr_mce",
 	};
=20
 	if (!func)

