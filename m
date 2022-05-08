Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A18451EEE9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiEHQUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiEHQUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:20:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77087BC0A
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AC01B80DBF
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 16:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2514C385AC;
        Sun,  8 May 2022 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652026602;
        bh=aSM+qwsoybBfG7hu+B5KpBzvce1SYI7kPkbgAdNlN7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wp0TGBxIHnaLHDpUy5porx22k0sHC+tq4kGeDQZDt0zliePYfQGhXAr9y58Wt2f6D
         1g6ToqH1B2Lck1CtURjw6B8XR08DGyAT22UdbU9NMb1Dh5tRoU4Sx64wjpPeJV9N/q
         OA+4hUM9DVB7D9TmpcjtmZJx92JFEHWHvTs9lYlN0mu5oGGkYtckfc+yDaesLfCV8y
         csR1+KlsdBZAm0vsEGMYBPFtF0K3hABUwFIw+yuaUNe0DLrAsDo7lu4wODBF/ZQlXi
         E9hGVIpyVGzb59SKNzWhk43ymCQcrgcDaael0Ya3+vKm23ph83QoJLpnFV6eBVyo/R
         v8GDvMN8x9VLQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v2 3/4] riscv: replace has_fpu() with system_supports_fpu()
Date:   Mon,  9 May 2022 00:07:48 +0800
Message-Id: <20220508160749.984-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220508160749.984-1-jszhang@kernel.org>
References: <20220508160749.984-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to use the unified cpus_have_{final|const}_cap() instead of
putting static key related here and there.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/cpufeature.h | 5 +++++
 arch/riscv/include/asm/switch_to.h  | 9 ++-------
 arch/riscv/kernel/cpufeature.c      | 8 ++------
 arch/riscv/kernel/process.c         | 2 +-
 arch/riscv/kernel/signal.c          | 4 ++--
 5 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index d80ddd2f3b49..634a653c7fa2 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -91,4 +91,9 @@ static inline void cpus_set_cap(unsigned int num)
 	}
 }
 
+static inline bool system_supports_fpu(void)
+{
+	return IS_ENABLED(CONFIG_FPU) && !cpus_have_final_cap(RISCV_HAS_NO_FPU);
+}
+
 #endif
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0a3f4f95c555..362cb18d12d5 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -8,6 +8,7 @@
 
 #include <linux/jump_label.h>
 #include <linux/sched/task_stack.h>
+#include <asm/cpufeature.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
@@ -56,13 +57,7 @@ static inline void __switch_to_aux(struct task_struct *prev,
 	fstate_restore(next, task_pt_regs(next));
 }
 
-extern struct static_key_false cpu_hwcap_fpu;
-static __always_inline bool has_fpu(void)
-{
-	return static_branch_likely(&cpu_hwcap_fpu);
-}
 #else
-static __always_inline bool has_fpu(void) { return false; }
 #define fstate_save(task, regs) do { } while (0)
 #define fstate_restore(task, regs) do { } while (0)
 #define __switch_to_aux(__prev, __next) do { } while (0)
@@ -75,7 +70,7 @@ extern struct task_struct *__switch_to(struct task_struct *,
 do {							\
 	struct task_struct *__prev = (prev);		\
 	struct task_struct *__next = (next);		\
-	if (has_fpu())					\
+	if (system_supports_fpu())					\
 		__switch_to_aux(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index e6c72cad0c1c..1edf3c3f8f62 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -22,10 +22,6 @@ unsigned long elf_hwcap __read_mostly;
 /* Host ISA bitmap */
 static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 
-#ifdef CONFIG_FPU
-__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
-#endif
-
 DECLARE_BITMAP(cpu_hwcaps, RISCV_NCAPS);
 EXPORT_SYMBOL(cpu_hwcaps);
 
@@ -254,8 +250,8 @@ void __init riscv_fill_hwcap(void)
 	pr_info("riscv: ELF capabilities %s\n", print_str);
 
 #ifdef CONFIG_FPU
-	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
-		static_branch_enable(&cpu_hwcap_fpu);
+	if (!(elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D)))
+		cpus_set_cap(RISCV_HAS_NO_FPU);
 #endif
 	enable_cpu_capabilities();
 	static_branch_enable(&riscv_const_caps_ready);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 504b496787aa..c9cd0b42299e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -88,7 +88,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	unsigned long sp)
 {
 	regs->status = SR_PIE;
-	if (has_fpu()) {
+	if (system_supports_fpu()) {
 		regs->status |= SR_FS_INITIAL;
 		/*
 		 * Restore the initial value to the FP register
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 9f4e59f80551..96aa593a989e 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -90,7 +90,7 @@ static long restore_sigcontext(struct pt_regs *regs,
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
 	/* Restore the floating-point state. */
-	if (has_fpu())
+	if (system_supports_fpu())
 		err |= restore_fp_state(regs, &sc->sc_fpregs);
 	return err;
 }
@@ -143,7 +143,7 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
 	/* Save the floating-point state. */
-	if (has_fpu())
+	if (system_supports_fpu())
 		err |= save_fp_state(regs, &sc->sc_fpregs);
 	return err;
 }
-- 
2.34.1

