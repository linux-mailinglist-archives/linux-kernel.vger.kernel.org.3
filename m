Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA18054041E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345233AbiFGQwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345229AbiFGQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:52:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA92A10192A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:52:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-310061f47faso110149097b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rjRsj4m79FaG01hh1JM+gnevDQqcLHdW4HjfiuVC0I0=;
        b=hn7Xx71n2KnaaudPsWoOTWsmIKVH2tEImkA5C6UnP/mD/yBngfMLji74jihCgmGl3i
         Oe+usDOEZhIztDMPc4rcdCiSldhSIax6bzofbCx/aXbOpHA8gJZb4Yt4b3HyzrEDGavY
         tz1an+NE9s3+fZ4I/wqrsGluqW7Gl9q8cb52CZ1wNMrgLvNqRIVFbx7acB7jUIs6dy3a
         z6SeXpB+1tP7RqmG/ZlE2XEI4V6CdBQCR3gjZkV62ZVv42q3eIfxz3DsUvqfdulCdf0n
         aWtbzj2IgfmtGIcAPuyAQ6d5/2iF/92KY92kI9WA2rv9rcUAH23ftma3wW1dEriJCT6t
         aD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rjRsj4m79FaG01hh1JM+gnevDQqcLHdW4HjfiuVC0I0=;
        b=oy+lZM3NZWiWS7zo5Tmvd+sBYn8lVjtplxSfMVSM0FSiKm5i1RFd2NIZuYGQgj2Iy/
         2LsZPmL2/97GGd8AXyAxGjUEUySJprey1y5Kz6teqMU79bO16BtJsbK6mSVQy1qCjXRE
         BAXA+0dUm4KDPHOR+yHUy8RQeQbmeuX8Bx69mI39EynK5X8b7OBK5nU87mP+TpduTmIB
         ugqpudRArFWXZeAWUCIwcMwesce+BQjwLfKIbskVt4esUZDJZ2jXB2VpfmkN1Pq2YSs+
         1h8OjeON1rTvZw4DSR3pMTe1eL2jl1qlHZGrDmJ/GH0NA+3FK9w3FdoQZel4GLimGyLz
         WAJQ==
X-Gm-Message-State: AOAM533hkGn6T7UwAMNpemp/hZej3w8XiZbpWA/iiQl3F83q76BgltK3
        NeHMBhfQd/yFIDyw54havUqQx0xcp2byOnMJ+g==
X-Google-Smtp-Source: ABdhPJy+IB15B8hsKv/SihsClOR+eo9Nq0yxU4MyQoY67kA3uwyRsLph8BS0L40V/9kbjX+bqF3kZKaMqzx2PJ910Q==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:7091:8518:ec1e:93dc])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:1006:b0:660:6f21:a210 with
 SMTP id w6-20020a056902100600b006606f21a210mr22111816ybt.178.1654620722845;
 Tue, 07 Jun 2022 09:52:02 -0700 (PDT)
Date:   Tue,  7 Jun 2022 09:50:44 -0700
In-Reply-To: <20220607165105.639716-1-kaleshsingh@google.com>
Message-Id: <20220607165105.639716-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220607165105.639716-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 2/5] KVM: arm64: Compile stacktrace.nvhe.o
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
        Andrew Jones <drjones@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Keir Fraser <keirf@google.com>,
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

Recompile stack unwinding code for use with the nVHE hypervisor. This is
a preparatory patch that will allow reusing most of the kernel unwinding
logic in the nVHE hypervisor.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---

Changes in v3:
  - Add Mark's Reviewed-by tag

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
2.36.1.255.ge46751e96f-goog

