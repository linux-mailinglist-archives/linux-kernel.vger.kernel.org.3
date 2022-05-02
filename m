Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9501517737
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387051AbiEBTQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387044AbiEBTQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:16:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0D8E1E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:13:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f8d487f575so70470297b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=/bI0RHeA8Y22AxlgXD6e7A4C/dpyc69T8IyS6sPGv90=;
        b=Sin22pZTsc6T28/VmcgGpYyXlwVEiagPVH8gGRdS/r6ZVMcYq/l2DNUbd/UH3/QkMs
         p/+gTtCY/niBNLAhJoOefVSsFKMM/c88SL89BSA63IuZ3cfwvFI08P1OuK2RdvCjzLBr
         qUF5qcGV6Jm4e/6av+f1gHU3a/JMtMVlOJq7Pwez5ECfb3fFshKATFmMwKNSeqhaIqih
         GGyUCCT+tOf9J+gG8j+J9OY5cZ6Ar1kGTxdP/i+tJ8C9N14Pz00FT+93lrTfUmI2IwA1
         bcCqJVJLvVrn/IbXgTc9dXoasshF+XmU0MAULG1/ZyGr4YYiQrdw3idt7UIQ/kHY2hGo
         MhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=/bI0RHeA8Y22AxlgXD6e7A4C/dpyc69T8IyS6sPGv90=;
        b=jcsploGkOvfn213du2GUPFhfjh7nvG8cve0foGXm+RJhP/1jQuywldmr9jDtgeN9Fd
         qad/m0+7mH3+fl2DZcpy+UlSvNBBqVqfULZiGIyKaX/AZLfa9UZwxADgNRifn/tQpRu3
         jSHQ8hz9ge2JDDE5Bpkf+c4syuxtllwKuhp69LiOZnNAyJR3E5cNf7T8vElK4H92RCP8
         MHIGAQ2awaOr0P6I0t/UVnYRA7FRsRks/JLaGGlyQkRMevoLSn01rYXXkmDr/QRmiqkj
         hR383b5YA3Ggpq/Sn9KUFEkWkhmSkz9avkGItdCch8GDymp61aAtqWejutac2sb+ZazX
         WoOg==
X-Gm-Message-State: AOAM530L86Pax9EOgJBBjP02bv50Cf1/V3T/TshqdeSOzSw1lEbWB6XJ
        jhZYvJqcwCKdDz+hB8ujhcTDYsMjo8W9xSJBYw==
X-Google-Smtp-Source: ABdhPJwG8Jc3ZMgFFAnwpm1gcq8vn2y4rF+jHDc6argwAd5erYSjH3fDQtoG+c1wfL+lxMconIh1ekRrY/pl2Qm63w==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:55c:7548:7073:c14f])
 (user=kaleshsingh job=sendgmr) by 2002:a25:e792:0:b0:645:7ddb:b5eb with SMTP
 id e140-20020a25e792000000b006457ddbb5ebmr11745947ybh.482.1651518800615; Mon,
 02 May 2022 12:13:20 -0700 (PDT)
Date:   Mon,  2 May 2022 12:12:02 -0700
In-Reply-To: <20220502191222.4192768-1-kaleshsingh@google.com>
Message-Id: <20220502191222.4192768-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220502191222.4192768-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 2/5] KVM: arm64: Compile stacktrace.nvhe.o
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, broonie@kernel.org, will@kernel.org,
        maz@kernel.org, qperret@google.com, tabba@google.com,
        surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
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

Recompile stack unwinding code for use with the nVHE hypervisor. This is
a preparatory patch that will allow reusing most of the kernel unwinding
logic in the nVHE hypervisor.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Split out refactoring of common unwinding logic into a separate patch,
    per Mark Brown

 arch/arm64/include/asm/stacktrace.h | 18 +++++++++-----
 arch/arm64/kernel/stacktrace.c      | 37 ++++++++++++++++-------------
 arch/arm64/kvm/hyp/nvhe/Makefile    |  3 ++-
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index aec9315bf156..f5af9a94c5a6 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -16,12 +16,14 @@
 #include <asm/sdei.h>
 
 enum stack_type {
-	STACK_TYPE_UNKNOWN,
+#ifndef __KVM_NVHE_HYPERVISOR__
 	STACK_TYPE_TASK,
 	STACK_TYPE_IRQ,
 	STACK_TYPE_OVERFLOW,
 	STACK_TYPE_SDEI_NORMAL,
 	STACK_TYPE_SDEI_CRITICAL,
+#endif /* !__KVM_NVHE_HYPERVISOR__ */
+	STACK_TYPE_UNKNOWN,
 	__NR_STACK_TYPES
 };
 
@@ -31,11 +33,6 @@ struct stack_info {
 	enum stack_type type;
 };
 
-extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
-			   const char *loglvl);
-
-DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
-
 static inline bool on_stack(unsigned long sp, unsigned long size,
 			    unsigned long low, unsigned long high,
 			    enum stack_type type, struct stack_info *info)
@@ -54,6 +51,12 @@ static inline bool on_stack(unsigned long sp, unsigned long size,
 	return true;
 }
 
+#ifndef __KVM_NVHE_HYPERVISOR__
+extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+			   const char *loglvl);
+
+DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
+
 static inline bool on_irq_stack(unsigned long sp, unsigned long size,
 				struct stack_info *info)
 {
@@ -88,6 +91,7 @@ static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 			struct stack_info *info) { return false; }
 #endif
+#endif /* !__KVM_NVHE_HYPERVISOR__ */
 
 
 /*
@@ -101,6 +105,7 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 	if (info)
 		info->type = STACK_TYPE_UNKNOWN;
 
+#ifndef __KVM_NVHE_HYPERVISOR__
 	if (on_task_stack(tsk, sp, size, info))
 		return true;
 	if (tsk != current || preemptible())
@@ -111,6 +116,7 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 		return true;
 	if (on_sdei_stack(sp, size, info))
 		return true;
+#endif /* !__KVM_NVHE_HYPERVISOR__ */
 
 	return false;
 }
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index ee60c279511c..a84e38d41d38 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -129,6 +129,26 @@ static int notrace __unwind_next(struct task_struct *tsk,
 }
 NOKPROBE_SYMBOL(__unwind_next);
 
+static int notrace unwind_next(struct task_struct *tsk,
+			       struct unwind_state *state);
+
+static void notrace unwind(struct task_struct *tsk,
+			   struct unwind_state *state,
+			   stack_trace_consume_fn consume_entry, void *cookie)
+{
+	while (1) {
+		int ret;
+
+		if (!consume_entry(cookie, state->pc))
+			break;
+		ret = unwind_next(tsk, state);
+		if (ret < 0)
+			break;
+	}
+}
+NOKPROBE_SYMBOL(unwind);
+
+#ifndef __KVM_NVHE_HYPERVISOR__
 static int notrace unwind_next(struct task_struct *tsk,
 			       struct unwind_state *state)
 {
@@ -171,22 +191,6 @@ static int notrace unwind_next(struct task_struct *tsk,
 }
 NOKPROBE_SYMBOL(unwind_next);
 
-static void notrace unwind(struct task_struct *tsk,
-			   struct unwind_state *state,
-			   stack_trace_consume_fn consume_entry, void *cookie)
-{
-	while (1) {
-		int ret;
-
-		if (!consume_entry(cookie, state->pc))
-			break;
-		ret = unwind_next(tsk, state);
-		if (ret < 0)
-			break;
-	}
-}
-NOKPROBE_SYMBOL(unwind);
-
 static bool dump_backtrace_entry(void *arg, unsigned long where)
 {
 	char *loglvl = arg;
@@ -238,3 +242,4 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 
 	unwind(task, &state, consume_entry, cookie);
 }
+#endif /* !__KVM_NVHE_HYPERVISOR__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index f9fe4dc21b1f..c0ff0d6fc403 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -14,7 +14,8 @@ lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o page_alloc.o \
-	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o
+	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o \
+	 ../../../kernel/stacktrace.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 obj-$(CONFIG_DEBUG_LIST) += list_debug.o
-- 
2.36.0.464.gb9c8b46e94-goog

