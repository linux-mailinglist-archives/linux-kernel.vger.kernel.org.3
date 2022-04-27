Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE665121F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiD0TDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiD0TDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:03:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95791B0D2D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:49:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so24490007b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=sH7KcOi4dXvStzx7CoNtlhTdwpi2Lae2JmM1YdLUdWE=;
        b=s9/HxvVMTsEgNz9+Lpu4CzAWwPaS8lKm6a14jcjfp9W5ZNjguoXROmEzBjK10UxFy9
         tLEgGfH+WEKIS2zMNNyasptxhMVOoByB2BwCLxZXYIcnpyaSqMGJc4z2t4MVPCY4w9JL
         ZCKxdO7JZDeysjHv5IZmfjpMDcF5T4q09OxiwAHWwqtWyNANAY2LhSL/xuZCMBG/R0rF
         P6+3VRPc6JTUKrdTqz6Fagjbtr4+B+8XIbTIx4b/IWL52UZADMw4qnBRMJZwnZuSRQ0T
         iJgsxqBWuys5Dq5QelGIak2Kksgt0qMdgtaUGmLfBG979WMjpi55K1Nwa3phalPPNiSM
         GqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=sH7KcOi4dXvStzx7CoNtlhTdwpi2Lae2JmM1YdLUdWE=;
        b=Sfr+CQKnhwvMOCE0iYuxsBzmaZEpTrelwAxOL96LSg1rOmQgZ5WoEU+5wZzIiPeQ91
         sQSWTreSWHOJ192NbvWfwI9Yse/Yg35/V2awOfyO6VG7IfC69mcJgoWQNxa8n2rj3Izd
         mVj4lXxaV1mMsR7COobR3uwTgglFQYEwcQGAq7MEOee/sJJrW7mo3Wh2RWKzVilMzto4
         1Bi3/ydsDLXldgbU+6ghDoKvs3YQbNwaEIQ6MCmQduP9OxHtbVgFZiD9QDj9X38Tq6D8
         ECpdVf55U5PduuC2N1SXXEUm3zTrMVJl1UBO3ZI2TW/fch6UM2rQtbvSBoZV/6zA5Wbs
         yXCw==
X-Gm-Message-State: AOAM530vDjmt+WmV0bphPRvhOHsjUYGXM8vu/DJQk/Yqg2sU9BgO8q82
        qKBMeGAfZz1zIa/wVyTl7/phLZkwEjM6gi+XUg==
X-Google-Smtp-Source: ABdhPJz/i5n/h2ljJRmeANt+JijtHbBq8jAiICNxa0BDMlFN2U3BSZscHogO0CRADOxNer7VUjlhyrYX3FQL4ZZXmA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:16ec:6da0:8cc5:5f24])
 (user=kaleshsingh job=sendgmr) by 2002:a25:3006:0:b0:646:ddbc:dba6 with SMTP
 id w6-20020a253006000000b00646ddbcdba6mr21665015ybw.113.1651085396777; Wed,
 27 Apr 2022 11:49:56 -0700 (PDT)
Date:   Wed, 27 Apr 2022 11:46:59 -0700
In-Reply-To: <20220427184716.1949239-1-kaleshsingh@google.com>
Message-Id: <20220427184716.1949239-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220427184716.1949239-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 4/4] KVM: arm64: Unwind and dump nVHE hypervisor stacktrace
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, will@kernel.org, maz@kernel.org,
        qperret@google.com, tabba@google.com, surenb@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Keir Fraser <keirf@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hyp_panic(), the hypervisor dumps the addresses for its stacktrace
entries to a page shared with the host. The host then symbolizes and
prints the hyp stacktrace before panicking itself.

Example stacktrace:

[  122.051187] kvm [380]: Invalid host exception to nVHE hyp!
[  122.052467] kvm [380]: nVHE HYP call trace:
[  122.052814] kvm [380]: [<ffff800008f5b550>] __kvm_nvhe___pkvm_vcpu_init_traps+0x1f0/0x1f0
[  122.053865] kvm [380]: [<ffff800008f560f0>] __kvm_nvhe_hyp_panic+0x130/0x1c0
[  122.054367] kvm [380]: [<ffff800008f56190>] __kvm_nvhe___kvm_vcpu_run+0x10/0x10
[  122.054878] kvm [380]: [<ffff800008f57a40>] __kvm_nvhe_handle___kvm_vcpu_run+0x30/0x50
[  122.055412] kvm [380]: [<ffff800008f57d2c>] __kvm_nvhe_handle_trap+0xbc/0x160
[  122.055911] kvm [380]: [<ffff800008f56864>] __kvm_nvhe___host_exit+0x64/0x64
[  122.056417] kvm [380]: ---- end of nVHE HYP call trace ----

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace.h | 42 ++++++++++++++--
 arch/arm64/kernel/stacktrace.c      | 75 +++++++++++++++++++++++++++++
 arch/arm64/kvm/handle_exit.c        |  4 ++
 arch/arm64/kvm/hyp/nvhe/switch.c    |  4 ++
 4 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index f5af9a94c5a6..3063912107b0 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -5,6 +5,7 @@
 #ifndef __ASM_STACKTRACE_H
 #define __ASM_STACKTRACE_H
 
+#include <linux/kvm_host.h>
 #include <linux/percpu.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
@@ -19,10 +20,12 @@ enum stack_type {
 #ifndef __KVM_NVHE_HYPERVISOR__
 	STACK_TYPE_TASK,
 	STACK_TYPE_IRQ,
-	STACK_TYPE_OVERFLOW,
 	STACK_TYPE_SDEI_NORMAL,
 	STACK_TYPE_SDEI_CRITICAL,
+#else /* __KVM_NVHE_HYPERVISOR__ */
+	STACK_TYPE_HYP,
 #endif /* !__KVM_NVHE_HYPERVISOR__ */
+	STACK_TYPE_OVERFLOW,
 	STACK_TYPE_UNKNOWN,
 	__NR_STACK_TYPES
 };
@@ -55,6 +58,9 @@ static inline bool on_stack(unsigned long sp, unsigned long size,
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 			   const char *loglvl);
 
+extern void hyp_dump_backtrace(unsigned long hyp_offset);
+
+DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stacktrace_page);
 DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
 
 static inline bool on_irq_stack(unsigned long sp, unsigned long size,
@@ -91,8 +97,32 @@ static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 			struct stack_info *info) { return false; }
 #endif
-#endif /* !__KVM_NVHE_HYPERVISOR__ */
+#else /* __KVM_NVHE_HYPERVISOR__ */
+
+extern void hyp_save_backtrace(void);
+
+DECLARE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], overflow_stack);
+DECLARE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
+
+static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
+				 struct stack_info *info)
+{
+	unsigned long low = (unsigned long)this_cpu_ptr(overflow_stack);
+	unsigned long high = low + PAGE_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_OVERFLOW, info);
+}
+
+static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
+				 struct stack_info *info)
+{
+	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
+	unsigned long high = params->stack_hyp_va;
+	unsigned long low = high - PAGE_SIZE;
 
+	return on_stack(sp, size, low, high, STACK_TYPE_HYP, info);
+}
+#endif /* !__KVM_NVHE_HYPERVISOR__ */
 
 /*
  * We can only safely access per-cpu stacks from current in a non-preemptible
@@ -105,6 +135,9 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 	if (info)
 		info->type = STACK_TYPE_UNKNOWN;
 
+	if (on_overflow_stack(sp, size, info))
+		return true;
+
 #ifndef __KVM_NVHE_HYPERVISOR__
 	if (on_task_stack(tsk, sp, size, info))
 		return true;
@@ -112,10 +145,11 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 		return false;
 	if (on_irq_stack(sp, size, info))
 		return true;
-	if (on_overflow_stack(sp, size, info))
-		return true;
 	if (on_sdei_stack(sp, size, info))
 		return true;
+#else /* __KVM_NVHE_HYPERVISOR__ */
+	if (on_hyp_stack(sp, size, info))
+		return true;
 #endif /* !__KVM_NVHE_HYPERVISOR__ */
 
 	return false;
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index f346b4c66f1c..c81dea9760ac 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -104,6 +104,7 @@ static int notrace __unwind_next(struct task_struct *tsk,
 	 *
 	 * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
 	 * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
+	 * HYP -> OVERFLOW
 	 *
 	 * ... but the nesting itself is strict. Once we transition from one
 	 * stack to another, it's never valid to unwind back to that first
@@ -242,7 +243,81 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 
 	unwind(task, &state, consume_entry, cookie);
 }
+
+/**
+ * Symbolizes and dumps the hypervisor backtrace from the shared
+ * stacktrace page.
+ */
+noinline notrace void hyp_dump_backtrace(unsigned long hyp_offset)
+{
+	unsigned long *stacktrace_pos =
+		(unsigned long *)*this_cpu_ptr(&kvm_arm_hyp_stacktrace_page);
+	unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
+	unsigned long pc = *stacktrace_pos++;
+
+	kvm_err("nVHE HYP call trace:\n");
+
+	while (pc) {
+		pc &= va_mask;		/* Mask tags */
+		pc += hyp_offset;	/* Convert to kern addr */
+		kvm_err("[<%016lx>] %pB\n", pc, (void *)pc);
+		pc = *stacktrace_pos++;
+	}
+
+	kvm_err("---- end of nVHE HYP call trace ----\n");
+}
 #else /* __KVM_NVHE_HYPERVISOR__ */
 DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], overflow_stack)
 	__aligned(16);
+
+static int notrace unwind_next(struct task_struct *tsk,
+			       struct unwind_state *state)
+{
+	struct stack_info info;
+
+	return __unwind_next(tsk, state, &info);
+}
+
+/**
+ * Saves a hypervisor stacktrace entry (address) to the shared stacktrace page.
+ */
+static bool hyp_save_backtrace_entry(void *arg, unsigned long where)
+{
+	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
+	unsigned long **stacktrace_pos = (unsigned long **)arg;
+	unsigned long stacktrace_start, stacktrace_end;
+
+	stacktrace_start = (unsigned long)params->stacktrace_hyp_va;
+	stacktrace_end = stacktrace_start + PAGE_SIZE - (2 * sizeof(long));
+
+	if ((unsigned long) *stacktrace_pos > stacktrace_end)
+		return false;
+
+	/* Save the entry to the current pos in stacktrace page */
+	**stacktrace_pos = where;
+
+	/* A zero entry delimits the end of the stacktrace. */
+	*(*stacktrace_pos + 1) = 0UL;
+
+	/* Increment the current pos */
+	++*stacktrace_pos;
+
+	return true;
+}
+
+/**
+ * Saves hypervisor stacktrace to the shared stacktrace page.
+ */
+noinline notrace void hyp_save_backtrace(void)
+{
+	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
+	void *stacktrace_start = (void *)params->stacktrace_hyp_va;
+	struct unwind_state state;
+
+	unwind_init(&state, (unsigned long)__builtin_frame_address(0),
+			_THIS_IP_);
+
+	unwind(NULL, &state, hyp_save_backtrace_entry, &stacktrace_start);
+}
+
 #endif /* !__KVM_NVHE_HYPERVISOR__ */
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index a377b871bf58..ee5adc9bdb8c 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -17,6 +17,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/debug-monitors.h>
+#include <asm/stacktrace.h>
 #include <asm/traps.h>
 
 #include <kvm/arm_hypercalls.h>
@@ -323,6 +324,9 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 				(void *)panic_addr);
 	}
 
+	/* Dump the hypervisor stacktrace */
+	hyp_dump_backtrace(hyp_offset);
+
 	/*
 	 * Hyp has panicked and we're going to handle that by panicking the
 	 * kernel. The kernel offset will be revealed in the panic so we're
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 978f1b94fb25..95d810e86c7d 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -25,6 +25,7 @@
 #include <asm/fpsimd.h>
 #include <asm/debug-monitors.h>
 #include <asm/processor.h>
+#include <asm/stacktrace.h>
 
 #include <nvhe/fixed_config.h>
 #include <nvhe/mem_protect.h>
@@ -395,6 +396,9 @@ asmlinkage void __noreturn hyp_panic(void)
 		__sysreg_restore_state_nvhe(host_ctxt);
 	}
 
+	/* Save the hypervisor stacktrace */
+	hyp_save_backtrace();
+
 	__hyp_do_panic(host_ctxt, spsr, elr, par);
 	unreachable();
 }
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

