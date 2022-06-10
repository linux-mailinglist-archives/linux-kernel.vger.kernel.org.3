Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4310754701E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350836AbiFJXhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350750AbiFJXgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAB2289F31
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z67-20020a254c46000000b0065cd3d2e67eso561353yba.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A4Eml+JKEIubNZOvrdz+yW1eaCBFok/SqX3y3Lo8JPk=;
        b=ICnq54isHnlcIXFq7R78Uk5/hJB4/xoFIMMyBix4W40Cd+eaY+XubVRTX5Qnd+//M2
         10P1viq3F4l0BApMHj1I57uIRnRp/80T4vWiY7Ki5VHqLIdJmC+uOaWeKrEdUL3fFqru
         X6GQUSgh16HYu/aVwI2Iq3K0EzACqQkhd5oZMfP6JyWR6MlQghU2E0L82WWromfvj+u5
         TGg2DXCRUMYaDpZkybad2dXJ5Ds4ha2NS+i4i51gDX+KZyWLRpPW51CreW6SPbbICj4m
         N8S4UDmnpdF+ds47BFpSbJ/CHXK0BVfpN58iumzf3zlkuN4oWj5mzCJzikoZmfoakou6
         kzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A4Eml+JKEIubNZOvrdz+yW1eaCBFok/SqX3y3Lo8JPk=;
        b=2kixoqk4lekqTo8CbqhuvY7WrkMqMRWdTBSpQu5m/yY88Kc5K5yZx3dFmqLhcG/ZHc
         wUBx29DngaJ8xzH3qV2Ae5ZCK9KMt1DIa7Hn13q189ACmjRakszMLhOW3wBPYewmDQsi
         S6E5/vXXNXJzZOYx90iYAnl3e6qfVJ1xlp6I7pGBDYb5q0bGDyTeMLkCZrkVqvEzSRjo
         I/NOOecos2xEKmBxJarkXQSGg2whGUpmMaVc1Jw32oXFhvEV+vfquVkYvucrIZn86LzH
         lBbam1fUQBXm7vkl+s505EY2joTHTRlGxb0bDZOJiz19Nmdcw0etEhbQOXfT9jMAmWCI
         ymWA==
X-Gm-Message-State: AOAM531k//TdWuhn7fWAKi1ddU3040puj0NlRhw4ZhWNFLKUHSrtgQUF
        1aMG7wEG1vXP46IPp1Y1xupabKZT+3vSmjsFhs0/rDT2aswY7Wx77fqiKdZUIR6idy1HZ/PrAs9
        7RH90PVWbpTiZvFvwvOpArZkB54vPCVs/32f1XfdygQwbFO+2Gb+AksQ6GRB0jGjuHPFFiEp+Q5
        X1YX6ptH3aqQ==
X-Google-Smtp-Source: ABdhPJx3rWv57FeBwQEWM6oFIvs7P3CtHXeBLaqrJnarF3QKs+mKVjy+7OOtU2lt3kt6rHiYFVGINgTtgCkYMqfiuis=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a0d:e857:0:b0:30c:34d9:26a with SMTP
 id r84-20020a0de857000000b0030c34d9026amr50927937ywe.452.1654904144744; Fri,
 10 Jun 2022 16:35:44 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:05 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7472; h=from:subject;
 bh=GPeI2jXo672qyhEESIXuD7+8ae5gl84hUV7hYDqvorE=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9UuWrx1MXXVBdMFywRXAOfO2YvBygj7JJFtUOi8
 G8KDBMaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLgAKCRBMtfaEi7xW7k+OC/
 9dpLWjuTj9zfrMrWNrJVFHNL6uWBl3L9HYK5U6Lgv5m6Z03h7wWS6sa2LXLCrTpd9p3l5joJNewr7+
 M2Y+lktQ3G4z+87/qQ4hGMsD46K35UovrQ5TFLuEVnyPleSKBZaad/OOkoJHFPAKpvMIcSug8ANQre
 0DGcYYc7359wxVNSmk1Y06SGDXwPAjaGG37UjiY5Di5Y2zsuj/gJVX93hTNhLgi1PiNNWamYBG5B+F
 xfbJUgY5AP69lrC0TimyHVZYAnX2MivmJh2GPb1Dt70CGsE16F3ih3R/hr3fI563LdWQB4G3xzTj59
 x5IW06T0dLN2GrgYXOaJqhQRR1PyIL04Q1a9bOuDLa32EJHd9xlqqxplAPQ/5qeKLUGukEnNaQST8q
 RHl4mrMt34cBzt+sfh/PWedaGhxICDWuq5hIVsCw7xYFcxyhFXzO1idT4z9CzU8n6M1MUeacly7+71
 dk9ig+TYsTvQosaXAhFq715HYHfT63xcw7fJDbo16Y1wA=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 12/20] treewide: Drop function_nocfi
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With -fsanitize=kcfi, we no longer need function_nocfi() as
the compiler won't change function references to point to a
jump table. Remove all implementations and uses of the macro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/ftrace.h           |  2 +-
 arch/arm64/include/asm/mmu_context.h      |  2 +-
 arch/arm64/kernel/acpi_parking_protocol.c |  2 +-
 arch/arm64/kernel/cpufeature.c            |  2 +-
 arch/arm64/kernel/ftrace.c                |  2 +-
 arch/arm64/kernel/machine_kexec.c         |  2 +-
 arch/arm64/kernel/psci.c                  |  2 +-
 arch/arm64/kernel/smp_spin_table.c        |  2 +-
 drivers/firmware/psci/psci.c              |  4 ++--
 drivers/misc/lkdtm/usercopy.c             |  2 +-
 include/linux/compiler.h                  | 10 ----------
 11 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index dbc45a4157fa..329dbbd4d50b 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -26,7 +26,7 @@
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #else
-#define MCOUNT_ADDR		((unsigned long)function_nocfi(_mcount))
+#define MCOUNT_ADDR		((unsigned long)_mcount)
 #endif
 
 /* The BL at the callsite's adjusted rec->ip */
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index ca0140d0b8cf..8fa4cfbdda90 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -164,7 +164,7 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
 		ttbr1 |= TTBR_CNP_BIT;
 	}
 
-	replace_phys = (void *)__pa_symbol(function_nocfi(idmap_cpu_replace_ttbr1));
+	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
 
 	cpu_install_idmap();
 	replace_phys(ttbr1);
diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
index bfeeb5319abf..b1990e38aed0 100644
--- a/arch/arm64/kernel/acpi_parking_protocol.c
+++ b/arch/arm64/kernel/acpi_parking_protocol.c
@@ -99,7 +99,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 	 * that read this address need to convert this address to the
 	 * Boot-Loader's endianness before jumping.
 	 */
-	writeq_relaxed(__pa_symbol(function_nocfi(secondary_entry)),
+	writeq_relaxed(__pa_symbol(secondary_entry),
 		       &mailbox->entry_point);
 	writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f6f9694d0448..6cd476f0d19c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1668,7 +1668,7 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 	if (arm64_use_ng_mappings)
 		return;
 
-	remap_fn = (void *)__pa_symbol(function_nocfi(idmap_kpti_install_ng_mappings));
+	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
 
 	cpu_install_idmap();
 	remap_fn(cpu, num_online_cpus(), __pa_symbol(swapper_pg_dir));
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index f447c4a36f69..74c8ab01dd8c 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -56,7 +56,7 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	unsigned long pc;
 	u32 new;
 
-	pc = (unsigned long)function_nocfi(ftrace_call);
+	pc = (unsigned long)ftrace_call;
 	new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
 					  AARCH64_INSN_BRANCH_LINK);
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 19c2d487cb08..ce3d40120f72 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -204,7 +204,7 @@ void machine_kexec(struct kimage *kimage)
 		typeof(cpu_soft_restart) *restart;
 
 		cpu_install_idmap();
-		restart = (void *)__pa_symbol(function_nocfi(cpu_soft_restart));
+		restart = (void *)__pa_symbol(cpu_soft_restart);
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index ab7f4c476104..29a8e444db83 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -38,7 +38,7 @@ static int __init cpu_psci_cpu_prepare(unsigned int cpu)
 
 static int cpu_psci_cpu_boot(unsigned int cpu)
 {
-	phys_addr_t pa_secondary_entry = __pa_symbol(function_nocfi(secondary_entry));
+	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
 	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
 	if (err)
 		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 7e1624ecab3c..49029eace3ad 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -66,7 +66,7 @@ static int smp_spin_table_cpu_init(unsigned int cpu)
 static int smp_spin_table_cpu_prepare(unsigned int cpu)
 {
 	__le64 __iomem *release_addr;
-	phys_addr_t pa_holding_pen = __pa_symbol(function_nocfi(secondary_holding_pen));
+	phys_addr_t pa_holding_pen = __pa_symbol(secondary_holding_pen);
 
 	if (!cpu_release_addr[cpu])
 		return -ENODEV;
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index cfb448eabdaa..aa3133cafced 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -334,7 +334,7 @@ static int __init psci_features(u32 psci_func_id)
 static int psci_suspend_finisher(unsigned long state)
 {
 	u32 power_state = state;
-	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
+	phys_addr_t pa_cpu_resume = __pa_symbol(cpu_resume);
 
 	return psci_ops.cpu_suspend(power_state, pa_cpu_resume);
 }
@@ -359,7 +359,7 @@ int psci_cpu_suspend_enter(u32 state)
 
 static int psci_system_suspend(unsigned long unused)
 {
-	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
+	phys_addr_t pa_cpu_resume = __pa_symbol(cpu_resume);
 
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
 			      pa_cpu_resume, 0, 0);
diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 6215ec995cd3..67db57249a34 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -330,7 +330,7 @@ static void lkdtm_USERCOPY_KERNEL(void)
 
 	pr_info("attempting bad copy_to_user from kernel text: %px\n",
 		vm_mmap);
-	if (copy_to_user((void __user *)user_addr, function_nocfi(vm_mmap),
+	if (copy_to_user((void __user *)user_addr, vm_mmap,
 			 unconst + PAGE_SIZE)) {
 		pr_warn("copy_to_user failed, but lacked Oops\n");
 		goto free_user;
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 63be1c23d676..76f5e41ea725 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -203,16 +203,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__v;								\
 })
 
-/*
- * With CONFIG_CFI_CLANG, the compiler replaces function addresses in
- * instrumented C code with jump table addresses. Architectures that
- * support CFI can define this macro to return the actual function address
- * when needed.
- */
-#ifndef function_nocfi
-#define function_nocfi(x) (x)
-#endif
-
 #endif /* __KERNEL__ */
 
 /*
-- 
2.36.1.476.g0c4daa206d-goog

