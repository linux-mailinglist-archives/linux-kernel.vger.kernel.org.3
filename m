Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC654B18C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbiBJWqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:46:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241709AbiBJWqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:46:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7049726F3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:46:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x1-20020a25a001000000b0061c64ee0196so15115361ybh.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=vCIc/T3BypFPMAfivt4Ue/YpaTqTQiwu1sslRwpeTec=;
        b=seqJLYA4w2epHJQlXFABX3D3UYUQLwDvDqlyQDaAaeWonXzVw6MUkHTsJIGtf1Cskw
         hepDtnf243UVN0de4xbKTvLzx6+EFj6S3n6IRujfhuaYqjLZUsIxOQDJFaiHLhwHpcif
         azVEJyiu+Imi36TS4A81UL9UDOkVsoc0kyvsRcSLnLEi8OD4pfPAdfyeSn/c8dzfFTh8
         7D62rZPd45GwLcsuMH2KDaNp1C7YkxXtHCKU7OxB1rSZEAw8tiYeNPiKdAhNp55Kki6L
         BdhzopTvP6lPB8mZyd+OizIcJ0uhFSKZBpkvy3pa7eLgNvE/kt/lk25iKtQcmYtsAqDt
         9Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=vCIc/T3BypFPMAfivt4Ue/YpaTqTQiwu1sslRwpeTec=;
        b=yyAwA/QKGublha7pcEU8d+fgAUJQVLwGBS28KShs3MFacF+kEih0IajtBTydMBvh7z
         rwhbGFOJ10JBx2WwFRtwq7gBZWrdG39QiTWx1ktE4o4K+qPMMCXYGrWxTLTcoLC4UgVZ
         qFRM81+6DQVeg/65SoWPtO3YHOriXMbaT1jZxj1Smfe7MOa4vfiIC77mThc3CfL5sczf
         yhDhu31yMRqCqSmd8LTzFpi+960hunEqw2B+hldIBbHuskcqTjb1iCi08Iq6AXwkrXtq
         Vb97/w5s+kBdO8EX9B1/uOI/9NBUNBSAtxxyWBrOuxt4hT1RS5EM0yXrsJ5jA0RCl561
         x9jg==
X-Gm-Message-State: AOAM530FoUNUr2xTxC/Nq7cfvlJjyEOtbdko+gQYTQ/D2t8n+k2vwQ66
        BGerNxrm4zUTfg42c10TeCW3jy/h0dhL0KDWAw==
X-Google-Smtp-Source: ABdhPJyErmlDgws4R3zr2NRs/2SNeRzB0+zSuqXZ4aWQ8ngObpdjK8Lp8zJzG3DZwOPBxAq3t5kSy2t3OH5MHOSyFg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:8f02:232:ad86:2ab2])
 (user=kaleshsingh job=sendgmr) by 2002:a25:b94f:: with SMTP id
 s15mr9159159ybm.362.1644533197659; Thu, 10 Feb 2022 14:46:37 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:41:47 -0800
In-Reply-To: <20220210224220.4076151-1-kaleshsingh@google.com>
Message-Id: <20220210224220.4076151-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220210224220.4076151-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 6/7] KVM: arm64: Unwind and dump nVHE HYP stacktrace
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
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

Unwind the stack in EL1, when CONFIG_NVHE_EL2_DEBUG is enabled. This is
possible because CONFIG_NVHE_EL2_DEBUG disables the host stage 2 protection
which allows host to access the hypervisor stack pages in EL1.

Unwinding and dumping hyp call traces is gated on CONFIG_NVHE_EL2_DEBUG
to avoid the potential leaking of information to the host.

A simple stack overflow test produces the following output:

[  580.376051][  T412] kvm: nVHE hyp panic at: ffffffc0116145c4!
[  580.378034][  T412] kvm [412]: nVHE HYP call trace (vmlinux
addresses):
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
 arch/arm64/include/asm/kvm_asm.h |  17 ++
 arch/arm64/kvm/Makefile          |   1 +
 arch/arm64/kvm/arm.c             |   2 +-
 arch/arm64/kvm/handle_exit.c     |   3 +
 arch/arm64/kvm/hyp/nvhe/setup.c  |  25 +++
 arch/arm64/kvm/hyp/nvhe/switch.c |  17 ++
 arch/arm64/kvm/stacktrace.c      | 290 +++++++++++++++++++++++++++++++
 arch/arm64/kvm/stacktrace.h      |  17 ++
 8 files changed, 371 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/stacktrace.c
 create mode 100644 arch/arm64/kvm/stacktrace.h

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index d5b0386ef765..f2b4c2ae5905 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -175,6 +175,23 @@ struct kvm_nvhe_init_params {
 	unsigned long vtcr;
 };
 
+#ifdef CONFIG_NVHE_EL2_DEBUG
+/*
+ * Used by the host in EL1 to dump the nVHE hypervisor backtrace on
+ * hyp_panic. This is possible because CONFIG_NVHE_EL2_DEBUG disables
+ * the host stage 2 protection. See: __hyp_do_panic()
+ *
+ * @hyp_stack_base:		hyp VA of the hyp_stack base.
+ * @hyp_overflow_stack_base:	hyp VA of the hyp_overflow_stack base.
+ * @start_fp:			hyp FP where the hyp backtrace should begin.
+ */
+struct kvm_nvhe_panic_info {
+	unsigned long hyp_stack_base;
+	unsigned long hyp_overflow_stack_base;
+	unsigned long start_fp;
+};
+#endif
+
 /* Translate a kernel address @ptr into its equivalent linear mapping */
 #define kvm_ksym_ref(ptr)						\
 	({								\
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 91861fd8b897..262b5c58cc62 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -23,6 +23,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o
+kvm-$(CONFIG_NVHE_EL2_DEBUG)  += stacktrace.o
 
 always-y := hyp_constants.h hyp-constants.s
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index ecc5958e27fe..f779436919ad 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -49,7 +49,7 @@ DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
-static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index e3140abd2e2e..b038c32a3236 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -23,6 +23,7 @@
 
 #define CREATE_TRACE_POINTS
 #include "trace_handle_exit.h"
+#include "stacktrace.h"
 
 typedef int (*exit_handle_fn)(struct kvm_vcpu *);
 
@@ -326,6 +327,8 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 		kvm_err("nVHE hyp panic at: %016llx!\n", elr_virt + hyp_offset);
 	}
 
+	hyp_dump_backtrace(hyp_offset);
+
 	/*
 	 * Hyp has panicked and we're going to handle that by panicking the
 	 * kernel. The kernel offset will be revealed in the panic so we're
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 39937fa6a1b2..3d7720d25acb 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -23,6 +23,29 @@ unsigned long hyp_nr_cpus;
 #ifdef CONFIG_NVHE_EL2_DEBUG
 DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack)
 	__aligned(16);
+
+DEFINE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
+
+static void init_nvhe_panic_info(void)
+{
+	struct kvm_nvhe_panic_info *panic_info;
+	struct kvm_nvhe_init_params *params;
+	int cpu;
+
+	for (cpu = 0; cpu < hyp_nr_cpus; cpu++) {
+		panic_info = per_cpu_ptr(&kvm_panic_info, cpu);
+		params = per_cpu_ptr(&kvm_init_params, cpu);
+
+		panic_info->hyp_stack_base = (unsigned long)(params->stack_hyp_va - PAGE_SIZE);
+		panic_info->hyp_overflow_stack_base
+			= (unsigned long)per_cpu_ptr(hyp_overflow_stack, cpu);
+		panic_info->start_fp = 0;
+	}
+}
+#else
+static inline void init_nvhe_panic_info(void)
+{
+}
 #endif
 
 #define hyp_percpu_size ((unsigned long)__per_cpu_end - \
@@ -140,6 +163,8 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 		 * allocated 'private' VA range.
 		 */
 		per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va = (unsigned long) end;
+
+		init_nvhe_panic_info();
 	}
 
 	/*
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 5a2e1ab79913..8f8cd0c02e1a 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -34,6 +34,21 @@ DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
 DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
 DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 
+#ifdef CONFIG_NVHE_EL2_DEBUG
+DECLARE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
+
+static void update_nvhe_panic_info_fp(void)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr(&kvm_panic_info);
+
+	panic_info->start_fp = (unsigned long)__builtin_frame_address(0);
+}
+#else
+static inline void update_nvhe_panic_info_fp(void)
+{
+}
+#endif
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
@@ -355,6 +370,8 @@ void __noreturn hyp_panic(void)
 	struct kvm_cpu_context *host_ctxt;
 	struct kvm_vcpu *vcpu;
 
+	update_nvhe_panic_info_fp();
+
 	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	vcpu = host_ctxt->__hyp_running_vcpu;
 
diff --git a/arch/arm64/kvm/stacktrace.c b/arch/arm64/kvm/stacktrace.c
new file mode 100644
index 000000000000..3990a616ab66
--- /dev/null
+++ b/arch/arm64/kvm/stacktrace.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Stack unwinder for EL2 nVHE hypervisor.
+ *
+ * Code mostly copied from the arm64 kernel stack unwinder
+ * and adapted to the nVHE hypervisor.
+ *
+ * See: arch/arm64/kernel/stacktrace.c
+ *
+ * CONFIG_NVHE_EL2_DEBUG disables the host stage-2 protection
+ * allowing us to access the hypervisor stack pages and
+ * consequently unwind its stack from the host in EL1.
+ *
+ * See: __hyp_do_panic()
+ */
+
+#include <asm/kvm_asm.h>
+#include <asm/kvm_hyp.h>
+#include <linux/kvm_host.h>
+#include "stacktrace.h"
+
+DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DECLARE_KVM_NVHE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack);
+DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
+
+enum hyp_stack_type {
+	HYP_STACK_TYPE_UNKNOWN,
+	HYP_STACK_TYPE_HYP,
+	HYP_STACK_TYPE_OVERFLOW,
+	__NR_HYP_STACK_TYPES
+};
+
+struct hyp_stack_info {
+	unsigned long low;
+	unsigned long high;
+	enum hyp_stack_type type;
+};
+
+/*
+ * A snapshot of a frame record or fp/lr register values, along with some
+ * accounting information necessary for robust unwinding.
+ *
+ * @fp:          The fp value in the frame record (or the real fp)
+ * @pc:          The pc value calculated from lr in the frame record.
+ *
+ * @stacks_done: Stacks which have been entirely unwound, for which it is no
+ *               longer valid to unwind to.
+ *
+ * @prev_fp:     The fp that pointed to this frame record, or a synthetic value
+ *               of 0. This is used to ensure that within a stack, each
+ *               subsequent frame record is at an increasing address.
+ * @prev_type:   The type of stack this frame record was on, or a synthetic
+ *               value of HYP_STACK_TYPE_UNKNOWN. This is used to detect a
+ *               transition from one stack to another.
+ */
+struct hyp_stackframe {
+	unsigned long fp;
+	unsigned long pc;
+	DECLARE_BITMAP(stacks_done, __NR_HYP_STACK_TYPES);
+	unsigned long prev_fp;
+	enum hyp_stack_type prev_type;
+};
+
+static inline bool __on_hyp_stack(unsigned long hyp_sp, unsigned long size,
+				unsigned long low, unsigned long high,
+				enum hyp_stack_type type,
+				struct hyp_stack_info *info)
+{
+	if (!low)
+		return false;
+
+	if (hyp_sp < low || hyp_sp + size < hyp_sp || hyp_sp + size > high)
+		return false;
+
+	if (info) {
+		info->low = low;
+		info->high = high;
+		info->type = type;
+	}
+	return true;
+}
+
+static inline bool on_hyp_overflow_stack(unsigned long hyp_sp, unsigned long size,
+				 struct hyp_stack_info *info)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long low = (unsigned long)panic_info->hyp_overflow_stack_base;
+	unsigned long high = low + PAGE_SIZE;
+
+	return __on_hyp_stack(hyp_sp, size, low, high, HYP_STACK_TYPE_OVERFLOW, info);
+}
+
+static inline bool on_hyp_stack(unsigned long hyp_sp, unsigned long size,
+				 struct hyp_stack_info *info)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long low = (unsigned long)panic_info->hyp_stack_base;
+	unsigned long high = low + PAGE_SIZE;
+
+	return __on_hyp_stack(hyp_sp, size, low, high, HYP_STACK_TYPE_HYP, info);
+}
+
+static inline bool on_hyp_accessible_stack(unsigned long hyp_sp, unsigned long size,
+				       struct hyp_stack_info *info)
+{
+	if (info)
+		info->type = HYP_STACK_TYPE_UNKNOWN;
+
+	if (on_hyp_stack(hyp_sp, size, info))
+		return true;
+	if (on_hyp_overflow_stack(hyp_sp, size, info))
+		return true;
+
+	return false;
+}
+
+static unsigned long __hyp_stack_kern_va(unsigned long hyp_va)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long hyp_base, kern_base, hyp_offset;
+
+	hyp_base = (unsigned long)panic_info->hyp_stack_base;
+	hyp_offset = hyp_va - hyp_base;
+
+	kern_base = (unsigned long)*this_cpu_ptr(&kvm_arm_hyp_stack_page);
+
+	return kern_base + hyp_offset;
+}
+
+static unsigned long __hyp_overflow_stack_kern_va(unsigned long hyp_va)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long hyp_base, kern_base, hyp_offset;
+
+	hyp_base = (unsigned long)panic_info->hyp_overflow_stack_base;
+	hyp_offset = hyp_va - hyp_base;
+
+	kern_base = (unsigned long)this_cpu_ptr_nvhe_sym(hyp_overflow_stack);
+
+	return kern_base + hyp_offset;
+}
+
+/*
+ * Convert hypervisor stack VA to a kernel VA.
+ *
+ * The hypervisor stack is mapped in the flexible 'private' VA range, to allow
+ * for guard pages below the stack. Consequently, the fixed offset address
+ * translation macros won't work here.
+ *
+ * The kernel VA is calculated as an offset from the kernel VA of the hypervisor
+ * stack base. See: __hyp_stack_kern_va(),  __hyp_overflow_stack_kern_va()
+ */
+static unsigned long hyp_stack_kern_va(unsigned long hyp_va,
+					enum hyp_stack_type stack_type)
+{
+	switch (stack_type) {
+	case HYP_STACK_TYPE_HYP:
+		return __hyp_stack_kern_va(hyp_va);
+	case HYP_STACK_TYPE_OVERFLOW:
+		return __hyp_overflow_stack_kern_va(hyp_va);
+	default:
+		return 0UL;
+	}
+}
+
+/*
+ * Unwind from one frame record (A) to the next frame record (B).
+ *
+ * We terminate early if the location of B indicates a malformed chain of frame
+ * records (e.g. a cycle), determined based on the location and fp value of A
+ * and the location (but not the fp value) of B.
+ */
+static int notrace hyp_unwind_frame(struct hyp_stackframe *frame)
+{
+	unsigned long fp = frame->fp, fp_kern_va;
+	struct hyp_stack_info info;
+
+	if (fp & 0x7)
+		return -EINVAL;
+
+	if (!on_hyp_accessible_stack(fp, 16, &info))
+		return -EINVAL;
+
+	if (test_bit(info.type, frame->stacks_done))
+		return -EINVAL;
+
+	/*
+	 * As stacks grow downward, any valid record on the same stack must be
+	 * at a strictly higher address than the prior record.
+	 *
+	 * Stacks can nest in the following order:
+	 *
+	 * HYP -> OVERFLOW
+	 *
+	 * ... but the nesting itself is strict. Once we transition from one
+	 * stack to another, it's never valid to unwind back to that first
+	 * stack.
+	 */
+	if (info.type == frame->prev_type) {
+		if (fp <= frame->prev_fp)
+			return -EINVAL;
+	} else {
+		set_bit(frame->prev_type, frame->stacks_done);
+	}
+
+	/* Translate the hyp stack address to a kernel address */
+	fp_kern_va = hyp_stack_kern_va(fp, info.type);
+	if (!fp_kern_va)
+		return -EINVAL;
+
+	/*
+	 * Record this frame record's values and location. The prev_fp and
+	 * prev_type are only meaningful to the next hyp_unwind_frame()
+	 * invocation.
+	 */
+	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp_kern_va));
+	/* PC = LR - 4; All aarch64 instructions are 32-bits in size */
+	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp_kern_va + 8)) - 4;
+	frame->prev_fp = fp;
+	frame->prev_type = info.type;
+
+	return 0;
+}
+
+/*
+ * AArch64 PCS assigns the frame pointer to x29.
+ *
+ * A simple function prologue looks like this:
+ *	sub	sp, sp, #0x10
+ *	stp	x29, x30, [sp]
+ *	mov	x29, sp
+ *
+ * A simple function epilogue looks like this:
+ *	mov	sp, x29
+ *	ldp	x29, x30, [sp]
+ *	add	sp, sp, #0x10
+ */
+static void hyp_start_backtrace(struct hyp_stackframe *frame, unsigned long fp)
+{
+	frame->fp = fp;
+
+	/*
+	 * Prime the first unwind.
+	 *
+	 * In hyp_unwind_frame() we'll check that the FP points to a valid
+	 * stack, which can't be HYP_STACK_TYPE_UNKNOWN, and the first unwind
+	 * will be treated as a transition to whichever stack that happens to
+	 * be. The prev_fp value won't be used, but we set it to 0 such that
+	 * it is definitely not an accessible stack address. The first frame
+	 * (hyp_panic()) is skipped, so we also set PC to 0.
+	 */
+	bitmap_zero(frame->stacks_done, __NR_HYP_STACK_TYPES);
+	frame->pc = frame->prev_fp = 0;
+	frame->prev_type = HYP_STACK_TYPE_UNKNOWN;
+}
+
+static void hyp_dump_backtrace_entry(unsigned long hyp_pc, unsigned long hyp_offset)
+{
+	unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
+
+	hyp_pc &= va_mask;
+	hyp_pc += hyp_offset;
+
+	kvm_err(" [<%016llx>]\n", hyp_pc);
+}
+
+void hyp_dump_backtrace(unsigned long hyp_offset)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	struct hyp_stackframe frame;
+	int frame_nr = 0;
+	int skip = 1;		/* Skip the first frame: hyp_panic() */
+
+	kvm_err("nVHE HYP call trace (vmlinux addresses):\n");
+
+	hyp_start_backtrace(&frame, (unsigned long)panic_info->start_fp);
+
+	do {
+		if (skip) {
+			skip--;
+			continue;
+		}
+
+		hyp_dump_backtrace_entry(frame.pc, hyp_offset);
+
+		frame_nr++;
+	} while (!hyp_unwind_frame(&frame));
+
+	kvm_err("---- end of nVHE HYP call trace ----\n");
+}
diff --git a/arch/arm64/kvm/stacktrace.h b/arch/arm64/kvm/stacktrace.h
new file mode 100644
index 000000000000..40c397394b9b
--- /dev/null
+++ b/arch/arm64/kvm/stacktrace.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Stack unwinder for EL2 nVHE hypervisor.
+ */
+
+#ifndef __KVM_HYP_STACKTRACE_H
+#define __KVM_HYP_STACKTRACE_H
+
+#ifdef CONFIG_NVHE_EL2_DEBUG
+void hyp_dump_backtrace(unsigned long hyp_offset);
+#else
+static inline void hyp_dump_backtrace(unsigned long hyp_offset)
+{
+}
+#endif /* CONFIG_NVHE_EL2_DEBUG */
+
+#endif /* __KVM_HYP_STACKTRACE_H */
-- 
2.35.1.265.g69c8d7142f-goog

