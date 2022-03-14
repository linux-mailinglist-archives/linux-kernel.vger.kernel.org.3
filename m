Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EBC4D8DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244930AbiCNUHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiCNUHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:07:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F86403ED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:06:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d07ae11462so141909737b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=mXdQx6y1X7XoYA3xZnPfmktj3a5xOv4cTUjZQXQ7QEY=;
        b=s7J80w9hld1XIBJ/UTgaMW2q9VzHN0dtHZZoUV5BQg3xdDL41swhyeznJf61mvD3SF
         ZrK0xsEVoJgUGtVkhfji8EEUdZ/oNvwrR8pyxz3elqKDPzdcuL80AX32ddZypz/aDNNB
         5R5Qn8T4cQHXWE0CNYq/qXlfBGgOP0a94ijkLqw8yEOZaJCczfmtg3RWs8pyH9L8x2iY
         St27wJNyS2L6XjJ3RplTUSKUpndN7NJcXRv9tMlcVpX9+QeNdFvb/gSXei8TGBmbBfp8
         DQWufgNgBlkUaevjzl3oaKRCCw55yO8oQ4D+RrXwTztu0d19K1hwQymb1eRE2VQiOPYd
         lHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=mXdQx6y1X7XoYA3xZnPfmktj3a5xOv4cTUjZQXQ7QEY=;
        b=cX7F+uKs1/Zu/MZACyU4E5n4+5IY5A/nZAfDKeK9uzCZdkjQmF5Ac9E8YrFiS9I2Sr
         1YIxbnyiAg2hK6e5IMhje3ynOiJQ0aR0sYmv/1fM+RdqLWICKL3IdlzhTADOMY6L3gjS
         LkFu0X7YaY+HUbF2GbBUzd8Bkh/IE4BLyDvRle2VH86/6DuK84+yKisNPZulw2rIaoiz
         YFYVdt4YOsN3G6xXUUg0wU5aVqlrk7W6WHsytEVqgPK3XnxqcDNVVDhZ0u/rWv9Pd3JM
         8PZXtE6XsF28GeqAetepCZoog6P+RrECaiBXCqoPj0YAab/0kZ29R/oezuk0TIMdCsA+
         Qsrw==
X-Gm-Message-State: AOAM530wP0SsjKjbfFqqfiFBsYLjxqp44tJ5YbYGcSVepE57ZpJTPGXX
        kbB+pqYGfJ2eDpI5tdV3uVvNCLAjGqhEzENi7Q==
X-Google-Smtp-Source: ABdhPJyaQtecJX0eaDnEgcsZnTJi0QMftBFt1Ol5UUnDoGK1zS1zHPVIt42N4yE42gDDvltZoIa1oYpDV5lslmYG9w==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:500a:9ac2:e73e:69e3])
 (user=kaleshsingh job=sendgmr) by 2002:a81:6606:0:b0:2e5:7ede:abad with SMTP
 id a6-20020a816606000000b002e57edeabadmr1871170ywc.405.1647288388280; Mon, 14
 Mar 2022 13:06:28 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:01:16 -0700
In-Reply-To: <20220314200148.2695206-1-kaleshsingh@google.com>
Message-Id: <20220314200148.2695206-8-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v6 7/8] KVM: arm64: Unwind and dump nVHE HYP stacktrace
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unwind the stack in EL1, when CONFIG_NVHE_EL2_DEBUG is enabled.
This is possible because CONFIG_NVHE_EL2_DEBUG disables the host
stage-2 protection on hyp_panic(), allowing the host to access
the hypervisor stack pages in EL1.

A simple stack overflow test produces the following output:

[  580.376051][  T412] kvm: nVHE hyp panic at: ffffffc0116145c4!
[  580.378034][  T412] kvm [412]: nVHE HYP call trace:
[  580.378591][  T412] kvm [412]:  [<ffffffc011614934>]
[  580.378993][  T412] kvm [412]:  [<ffffffc01160fa48>]
[  580.379386][  T412] kvm [412]:  [<ffffffc0116145dc>]  // Non-terminating recursive call
[  580.379772][  T412] kvm [412]:  [<ffffffc0116145dc>]
[  580.380158][  T412] kvm [412]:  [<ffffffc0116145dc>]
[  580.380544][  T412] kvm [412]:  [<ffffffc0116145dc>]
[  580.380928][  T412] kvm [412]:  [<ffffffc0116145dc>]
. . .

Since nVHE hyp symbols are not included by kallsyms to avoid issues
with aliasing, we fallback to the vmlinux addresses. Symbolizing the
addresses is handled in the next patch in this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v4:
  - Update commit text and struct kvm_nvhe_panic_info kernel-doc comment
    to clarify that CONFIG_NVHE_EL2_DEBUG only disables the host stage-2
    protection on hyp_panic(), per Fuad
  - Update NVHE_EL2_DEBUG Kconfig description to clarify that the
    hypervisor stack trace is printed when hyp_panic() is called, per Fuad

Changes in v3:
  - The nvhe hyp stack unwinder now makes use of the core logic from the
    regular kernel unwinder to avoid duplication, per Mark

Changes in v2:
  - Add cpu_prepare_nvhe_panic_info()
  - Move updating the panic info to hyp_panic(), so that unwinding also
    works for conventional nVHE Hyp-mode.


 arch/arm64/include/asm/kvm_asm.h    |  20 +++
 arch/arm64/include/asm/stacktrace.h |  12 ++
 arch/arm64/kernel/stacktrace.c      | 210 +++++++++++++++++++++++++---
 arch/arm64/kvm/Kconfig              |   5 +-
 arch/arm64/kvm/arm.c                |   2 +-
 arch/arm64/kvm/handle_exit.c        |   3 +
 arch/arm64/kvm/hyp/nvhe/switch.c    |  18 +++
 7 files changed, 244 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 2e277f2ed671..4abcf93c6662 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -176,6 +176,26 @@ struct kvm_nvhe_init_params {
 	unsigned long vtcr;
 };
 
+#ifdef CONFIG_NVHE_EL2_DEBUG
+/**
+ * struct kvm_nvhe_panic_info - nVHE hypervisor panic info.
+ * @hyp_stack_base:             hyp VA of the hyp_stack base.
+ * @hyp_overflow_stack_base:    hyp VA of the hyp_overflow_stack base.
+ * @fp:                         hyp FP where the backtrace begins.
+ * @pc:                         hyp PC where the backtrace begins.
+ *
+ * Used by the host in EL1 to dump the nVHE hypervisor backtrace on
+ * hyp_panic. This is possible because CONFIG_NVHE_EL2_DEBUG disables
+ * the host stage 2 protection on hyp_panic(). See: __hyp_do_panic()
+ */
+struct kvm_nvhe_panic_info {
+	unsigned long hyp_stack_base;
+	unsigned long hyp_overflow_stack_base;
+	unsigned long fp;
+	unsigned long pc;
+};
+#endif /* CONFIG_NVHE_EL2_DEBUG */
+
 /* Translate a kernel address @ptr into its equivalent linear mapping */
 #define kvm_ksym_ref(ptr)						\
 	({								\
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index e77cdef9ca29..18611a51cf14 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -22,6 +22,10 @@ enum stack_type {
 	STACK_TYPE_OVERFLOW,
 	STACK_TYPE_SDEI_NORMAL,
 	STACK_TYPE_SDEI_CRITICAL,
+#ifdef CONFIG_NVHE_EL2_DEBUG
+	STACK_TYPE_KVM_NVHE_HYP,
+	STACK_TYPE_KVM_NVHE_OVERFLOW,
+#endif /* CONFIG_NVHE_EL2_DEBUG */
 	__NR_STACK_TYPES
 };
 
@@ -147,4 +151,12 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 	return false;
 }
 
+#ifdef CONFIG_NVHE_EL2_DEBUG
+void kvm_nvhe_dump_backtrace(unsigned long hyp_offset);
+#else
+static inline void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
+{
+}
+#endif /* CONFIG_NVHE_EL2_DEBUG */
+
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index e4103e085681..6ec85cb69b1f 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -15,6 +15,8 @@
 
 #include <asm/irq.h>
 #include <asm/pointer_auth.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_hyp.h>
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
@@ -64,26 +66,15 @@ NOKPROBE_SYMBOL(start_backtrace);
  * records (e.g. a cycle), determined based on the location and fp value of A
  * and the location (but not the fp value) of B.
  */
-static int notrace unwind_frame(struct task_struct *tsk,
-				struct stackframe *frame)
+static int notrace __unwind_frame(struct stackframe *frame, struct stack_info *info,
+		unsigned long (*translate_fp)(unsigned long, enum stack_type))
 {
 	unsigned long fp = frame->fp;
-	struct stack_info info;
-
-	if (!tsk)
-		tsk = current;
-
-	/* Final frame; nothing to unwind */
-	if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
-		return -ENOENT;
 
 	if (fp & 0x7)
 		return -EINVAL;
 
-	if (!on_accessible_stack(tsk, fp, 16, &info))
-		return -EINVAL;
-
-	if (test_bit(info.type, frame->stacks_done))
+	if (test_bit(info->type, frame->stacks_done))
 		return -EINVAL;
 
 	/*
@@ -94,28 +85,62 @@ static int notrace unwind_frame(struct task_struct *tsk,
 	 *
 	 * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
 	 * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
+	 * KVM_NVHE_HYP -> KVM_NVHE_OVERFLOW
 	 *
 	 * ... but the nesting itself is strict. Once we transition from one
 	 * stack to another, it's never valid to unwind back to that first
 	 * stack.
 	 */
-	if (info.type == frame->prev_type) {
+	if (info->type == frame->prev_type) {
 		if (fp <= frame->prev_fp)
 			return -EINVAL;
 	} else {
 		set_bit(frame->prev_type, frame->stacks_done);
 	}
 
+	/* Record fp as prev_fp before attempting to get the next fp */
+	frame->prev_fp = fp;
+
+	/*
+	 * If fp is not from the current address space perform the
+	 * necessary translation before dereferencing it to get next fp.
+	 */
+	if (translate_fp)
+		fp = translate_fp(fp, info->type);
+	if (!fp)
+		return -EINVAL;
+
 	/*
 	 * Record this frame record's values and location. The prev_fp and
-	 * prev_type are only meaningful to the next unwind_frame() invocation.
+	 * prev_type are only meaningful to the next __unwind_frame() invocation.
 	 */
 	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
 	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
-	frame->prev_fp = fp;
-	frame->prev_type = info.type;
-
 	frame->pc = ptrauth_strip_insn_pac(frame->pc);
+	frame->prev_type = info->type;
+
+	return 0;
+}
+
+static int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
+{
+	unsigned long fp = frame->fp;
+	struct stack_info info;
+	int err;
+
+	if (!tsk)
+		tsk = current;
+
+	/* Final frame; nothing to unwind */
+	if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
+		return -ENOENT;
+
+	if (!on_accessible_stack(tsk, fp, 16, &info))
+		return -EINVAL;
+
+	err = __unwind_frame(frame, &info, NULL);
+	if (err)
+		return err;
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	if (tsk->ret_stack &&
@@ -143,20 +168,27 @@ static int notrace unwind_frame(struct task_struct *tsk,
 }
 NOKPROBE_SYMBOL(unwind_frame);
 
-static void notrace walk_stackframe(struct task_struct *tsk,
-				    struct stackframe *frame,
-				    bool (*fn)(void *, unsigned long), void *data)
+static void notrace __walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
+		bool (*fn)(void *, unsigned long), void *data,
+		int (*unwind_frame_fn)(struct task_struct *tsk, struct stackframe *frame))
 {
 	while (1) {
 		int ret;
 
 		if (!fn(data, frame->pc))
 			break;
-		ret = unwind_frame(tsk, frame);
+		ret = unwind_frame_fn(tsk, frame);
 		if (ret < 0)
 			break;
 	}
 }
+
+static void notrace walk_stackframe(struct task_struct *tsk,
+				    struct stackframe *frame,
+				    bool (*fn)(void *, unsigned long), void *data)
+{
+	__walk_stackframe(tsk, frame, fn, data, unwind_frame);
+}
 NOKPROBE_SYMBOL(walk_stackframe);
 
 static bool dump_backtrace_entry(void *arg, unsigned long where)
@@ -210,3 +242,135 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 
 	walk_stackframe(task, &frame, consume_entry, cookie);
 }
+
+#ifdef CONFIG_NVHE_EL2_DEBUG
+DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DECLARE_KVM_NVHE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack);
+DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
+
+static inline bool kvm_nvhe_on_overflow_stack(unsigned long sp, unsigned long size,
+				 struct stack_info *info)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long low = (unsigned long)panic_info->hyp_overflow_stack_base;
+	unsigned long high = low + PAGE_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_KVM_NVHE_OVERFLOW, info);
+}
+
+static inline bool kvm_nvhe_on_hyp_stack(unsigned long sp, unsigned long size,
+				 struct stack_info *info)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long low = (unsigned long)panic_info->hyp_stack_base;
+	unsigned long high = low + PAGE_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_KVM_NVHE_HYP, info);
+}
+
+static inline bool kvm_nvhe_on_accessible_stack(unsigned long sp, unsigned long size,
+				       struct stack_info *info)
+{
+	if (info)
+		info->type = STACK_TYPE_UNKNOWN;
+
+	if (kvm_nvhe_on_hyp_stack(sp, size, info))
+		return true;
+	if (kvm_nvhe_on_overflow_stack(sp, size, info))
+		return true;
+
+	return false;
+}
+
+static unsigned long kvm_nvhe_hyp_stack_kern_va(unsigned long addr)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long hyp_base, kern_base, hyp_offset;
+
+	hyp_base = (unsigned long)panic_info->hyp_stack_base;
+	hyp_offset = addr - hyp_base;
+
+	kern_base = (unsigned long)*this_cpu_ptr(&kvm_arm_hyp_stack_page);
+
+	return kern_base + hyp_offset;
+}
+
+static unsigned long kvm_nvhe_overflow_stack_kern_va(unsigned long addr)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long hyp_base, kern_base, hyp_offset;
+
+	hyp_base = (unsigned long)panic_info->hyp_overflow_stack_base;
+	hyp_offset = addr - hyp_base;
+
+	kern_base = (unsigned long)this_cpu_ptr_nvhe_sym(hyp_overflow_stack);
+
+	return kern_base + hyp_offset;
+}
+
+/*
+ * Convert KVM nVHE hypervisor stack VA to a kernel VA.
+ *
+ * The nVHE hypervisor stack is mapped in the flexible 'private' VA range, to allow
+ * for guard pages below the stack. Consequently, the fixed offset address
+ * translation macros won't work here.
+ *
+ * The kernel VA is calculated as an offset from the kernel VA of the hypervisor
+ * stack base. See: kvm_nvhe_hyp_stack_kern_va(),  kvm_nvhe_overflow_stack_kern_va()
+ */
+static unsigned long kvm_nvhe_stack_kern_va(unsigned long addr,
+					enum stack_type type)
+{
+	switch (type) {
+	case STACK_TYPE_KVM_NVHE_HYP:
+		return kvm_nvhe_hyp_stack_kern_va(addr);
+	case STACK_TYPE_KVM_NVHE_OVERFLOW:
+		return kvm_nvhe_overflow_stack_kern_va(addr);
+	default:
+		return 0UL;
+	}
+}
+
+static int notrace kvm_nvhe_unwind_frame(struct task_struct *tsk,
+					struct stackframe *frame)
+{
+	struct stack_info info;
+
+	if (!kvm_nvhe_on_accessible_stack(frame->fp, 16, &info))
+		return -EINVAL;
+
+	return  __unwind_frame(frame, &info, kvm_nvhe_stack_kern_va);
+}
+
+static bool kvm_nvhe_dump_backtrace_entry(void *arg, unsigned long where)
+{
+	unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
+	unsigned long hyp_offset = (unsigned long)arg;
+
+	where &= va_mask;	/* Mask tags */
+	where += hyp_offset;	/* Convert to kern addr */
+
+	kvm_err("[<%016lx>] %pB\n", where, (void *)where);
+
+	return true;
+}
+
+static void notrace kvm_nvhe_walk_stackframe(struct task_struct *tsk,
+				    struct stackframe *frame,
+				    bool (*fn)(void *, unsigned long), void *data)
+{
+	__walk_stackframe(tsk, frame, fn, data, kvm_nvhe_unwind_frame);
+}
+
+void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	struct stackframe frame;
+
+	start_backtrace(&frame, panic_info->fp, panic_info->pc);
+	pr_err("nVHE HYP call trace:\n");
+	kvm_nvhe_walk_stackframe(NULL, &frame, kvm_nvhe_dump_backtrace_entry,
+					(void *)hyp_offset);
+	pr_err("---- end of nVHE HYP call trace ----\n");
+}
+#endif /* CONFIG_NVHE_EL2_DEBUG */
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8a5fbbf084df..a7be4ef35fbf 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -51,8 +51,9 @@ config NVHE_EL2_DEBUG
 	depends on KVM
 	help
 	  Say Y here to enable the debug mode for the non-VHE KVM EL2 object.
-	  Failure reports will BUG() in the hypervisor. This is intended for
-	  local EL2 hypervisor development.
+	  Failure reports will BUG() in the hypervisor; and calls to hyp_panic()
+	  will result in printing the hypervisor call stack.
+	  This is intended for local EL2 hypervisor development.
 
 	  If unsure, say N.
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 72be7e695d8d..c7216ce1d55c 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -49,7 +49,7 @@ DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
-static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index e3140abd2e2e..ff69dff33700 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -17,6 +17,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/debug-monitors.h>
+#include <asm/stacktrace.h>
 #include <asm/traps.h>
 
 #include <kvm/arm_hypercalls.h>
@@ -326,6 +327,8 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 		kvm_err("nVHE hyp panic at: %016llx!\n", elr_virt + hyp_offset);
 	}
 
+	kvm_nvhe_dump_backtrace(hyp_offset);
+
 	/*
 	 * Hyp has panicked and we're going to handle that by panicking the
 	 * kernel. The kernel offset will be revealed in the panic so we're
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index efc20273a352..b8ecffc47424 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -37,6 +37,22 @@ DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 #ifdef CONFIG_NVHE_EL2_DEBUG
 DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack)
 	__aligned(16);
+DEFINE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
+
+static inline void cpu_prepare_nvhe_panic_info(void)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr(&kvm_panic_info);
+	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
+
+	panic_info->hyp_stack_base = (unsigned long)(params->stack_hyp_va - PAGE_SIZE);
+	panic_info->hyp_overflow_stack_base = (unsigned long)this_cpu_ptr(hyp_overflow_stack);
+	panic_info->fp = (unsigned long)__builtin_frame_address(0);
+	panic_info->pc = _THIS_IP_;
+}
+ #else
+static inline void cpu_prepare_nvhe_panic_info(void)
+{
+}
 #endif
 
 static void __activate_traps(struct kvm_vcpu *vcpu)
@@ -360,6 +376,8 @@ asmlinkage void __noreturn hyp_panic(void)
 	struct kvm_cpu_context *host_ctxt;
 	struct kvm_vcpu *vcpu;
 
+	cpu_prepare_nvhe_panic_info();
+
 	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	vcpu = host_ctxt->__hyp_running_vcpu;
 
-- 
2.35.1.723.g4982287a31-goog

