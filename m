Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D49554042C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345271AbiFGQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345265AbiFGQ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:56:28 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800391021DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:56:25 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e189-20020a6369c6000000b003fd31d5990fso5545660pgc.20
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ik67eq7ZFLPpGR0zNaRH/kqbteisvZSFHAun96EESgY=;
        b=c5MnAxiYEqPUKzHWj6VaKDHLpVGmdQSneovsbZDaIlVlrUT0cWvKa+9KuwbIMXJkX2
         nq1k6E8l8eEqVBh+PyGQX9aHE/jBgk8dsv85NbeBbW3lrnYlhkCSdt2/c+HYe2GXH982
         UJSNvT3tPQ/Ec/J58jiDra/FhbZgxUwcqR9HKv3WBvsUtKISRf2Fc+3EgZ5Adritd4Ob
         3BEBfW/Ky4rJ2Ct1yG69tsW4yEuwJYgysrD/gGd/gHBqOjs3fc6ud2uwuV/S36ASvt6l
         7vBEVwvj20nxRnZGSjY/Z0Z0kk5RxYqg2AqqfHtUNCjzErEPrMt2bw/TJV6MYV9j8eRH
         3M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ik67eq7ZFLPpGR0zNaRH/kqbteisvZSFHAun96EESgY=;
        b=7TaeFWNs7lnCuJGcXK0kPFcAGXXenX4BvJqYXYmPsZRcNJPYfKcDed1xZeJzvnKX3m
         lJ6Jmtcw/HTKUsm8d4xWVBWIRRSOzf8r9lHeDm3of3FCIlYAirj1ZljFGVk7qDD8tR3b
         h164x26hxeDStZymor2r0orfTtjRglxsU/n+A7Cd/I1htCCU8ct0dxN7LrkvSL0e9vCf
         N6oSO17MzRhCvZRGY/709mYXmA919pq3rOJZlma9Bahq/YbsDTd/Quuo4dntTaaSh9IC
         0EYX3or21IuGGHWYuYYx2FSw/wJub50+p8T3aTGqPNp6YzjzAuut/VDKW+2u+9+KXzHh
         j5wg==
X-Gm-Message-State: AOAM531G6sxr10HO38vjl4EDHiUvpjg/vYszXcQ4sdQL+c8fo88SzyRo
        7w4wr1s+HPdsSseYHGMll/a7psIgDUrBD9YKFg==
X-Google-Smtp-Source: ABdhPJyQoKHawMwo4HxqpkAQ9clAAvMd8TryB/FlktgNoP0ffixbJjrIY+9zZn++XlD8hy1B7BR/4fhUDYjPOaZJwA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:7091:8518:ec1e:93dc])
 (user=kaleshsingh job=sendgmr) by 2002:a17:902:b683:b0:163:4ef2:3c40 with
 SMTP id c3-20020a170902b68300b001634ef23c40mr29010356pls.123.1654620984901;
 Tue, 07 Jun 2022 09:56:24 -0700 (PDT)
Date:   Tue,  7 Jun 2022 09:50:47 -0700
In-Reply-To: <20220607165105.639716-1-kaleshsingh@google.com>
Message-Id: <20220607165105.639716-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220607165105.639716-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 5/5] KVM: arm64: Unwind and dump nVHE hypervisor stacktrace
From:   Kalesh Singh <kaleshsingh@google.com>
To:     mark.rutland@arm.com, broonie@kernel.org, maz@kernel.org
Cc:     will@kernel.org, qperret@google.com, tabba@google.com,
        surenb@google.com, tjmercier@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Jones <drjones@redhat.com>,
        Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
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
Reviewed-by: Mark Brown <broonie@kernel.org>
---

Changes in v2:
  - Add Mark's Reviewed-by tag

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
index f66c0142b335..96c5dc5529a1 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -17,6 +17,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/debug-monitors.h>
+#include <asm/stacktrace.h>
 #include <asm/traps.h>
 
 #include <kvm/arm_hypercalls.h>
@@ -353,6 +354,9 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 				(void *)panic_addr);
 	}
 
+	/* Dump the hypervisor stacktrace */
+	hyp_dump_backtrace(hyp_offset);
+
 	/*
 	 * Hyp has panicked and we're going to handle that by panicking the
 	 * kernel. The kernel offset will be revealed in the panic so we're
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6db801db8f27..add157f8e3f3 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -25,6 +25,7 @@
 #include <asm/fpsimd.h>
 #include <asm/debug-monitors.h>
 #include <asm/processor.h>
+#include <asm/stacktrace.h>
 
 #include <nvhe/fixed_config.h>
 #include <nvhe/mem_protect.h>
@@ -375,6 +376,9 @@ asmlinkage void __noreturn hyp_panic(void)
 		__sysreg_restore_state_nvhe(host_ctxt);
 	}
 
+	/* Save the hypervisor stacktrace */
+	hyp_save_backtrace();
+
 	__hyp_do_panic(host_ctxt, spsr, elr, par);
 	unreachable();
 }
-- 
2.36.1.255.ge46751e96f-goog

