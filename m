Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763EB575B55
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiGOGLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiGOGLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8340466AE0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t10-20020a5b07ca000000b0066ec1bb6e2cso3281099ybq.14
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FYBq07VQ4DkWTq1d4ACftXBrb374xXzNK5S2gkLiMO4=;
        b=NLk/3Rkt1n9uJrc345lFPf00C8qzQsyt6y0eZMNx0g5v0lsiCyWYkQx9+2s0nx+FLY
         l7j3QQaH3ghXRvmcdL6PGLW5W9miUzv1T/9vOdwyAYy89tQ4GzXz6p2V30airVL0TRTT
         gaLDbMYbtao1xmyAPM316twHkn78kx1XbDcVfax/2vyIxWw1W37UN08gJVNKESNU8Oys
         3jH/VfxUi0as5R1vO3yh8Bbomq/4kTKHP8BA1NtAj2jLFtJU78Ld+givYs9UGzykLejf
         HyugqtinuF2BlKD1nkuiKiJvYxXkzhFLGM9aX0dGi4OaK2KgU1YGI4OpXw2Mssc0AWMc
         PTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FYBq07VQ4DkWTq1d4ACftXBrb374xXzNK5S2gkLiMO4=;
        b=k7hBEY1z0ZwBpM77Ps2+t4mfuscAoldPUzA63xCDKCxjJRQUFowtSvnXGFEeXyBlL2
         /Fijd92oTTyerTcOLEToHR/ERE6oARVpawwa7D01vEMEpYmZ/JGHp/DQtlQIH3jbck2Q
         tnfeh4LG9DXxpldp8hvcoApKEvRInNBXSjyb/SjGXlDggrgCOsJ2t/UejmavRhZ8vvtm
         oX0YEQ00hu2jySQwiq8Lbk78NSV4T8lbjIDZOolbounLBPVyXUgIlum8qQChM5rWKOGm
         Fmokf8yafyWImzuqGY7a5UalkrTbc4mgE2VtV4QvS7abQ0oEX8cywrycrr2t9LVDCKAp
         P3Rg==
X-Gm-Message-State: AJIora+5BbqK0LQa6H2peXbMOgBJzBrxVt3JFw6BfhYft8+Ktpj1gCjO
        isqYe4JVvLtJUBPvaAgjozcam/GfLDxfUNjFYQ==
X-Google-Smtp-Source: AGRyM1tJ1+XhW8SOFOo1j4XRkY2qov8EmHa+wSlCqK9/nwu8v8plCWadpgoj0f878y6UXleMAR/B6ETRxL9pzXJZ8w==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:2d57:0:b0:66e:497f:51e6 with SMTP
 id s23-20020a252d57000000b0066e497f51e6mr12368453ybe.251.1657865472764; Thu,
 14 Jul 2022 23:11:12 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:14 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 05/18] arm64: stacktrace: Factor out common unwind()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com
Cc:     will@kernel.org, qperret@google.com, tabba@google.com,
        kaleshsingh@google.com, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, andreyknvl@gmail.com,
        russell.king@oracle.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move unwind() to stacktrace/common.h, and as a result
the kernel unwind_next() to asm/stacktrace.h. This allow
reusing unwind() in the implementation of the nVHE HYP
stack unwinder, later in the series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace.h        | 51 ++++++++++++++++
 arch/arm64/include/asm/stacktrace/common.h | 19 ++++++
 arch/arm64/kernel/stacktrace.c             | 67 ----------------------
 3 files changed, 70 insertions(+), 67 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index a4f8b84fb459..4fa07f0f913d 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -11,6 +11,7 @@
 #include <linux/llist.h>
 
 #include <asm/memory.h>
+#include <asm/pointer_auth.h>
 #include <asm/ptrace.h>
 #include <asm/sdei.h>
 
@@ -78,4 +79,54 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 
 	return false;
 }
+
+/*
+ * Unwind from one frame record (A) to the next frame record (B).
+ *
+ * We terminate early if the location of B indicates a malformed chain of frame
+ * records (e.g. a cycle), determined based on the location and fp value of A
+ * and the location (but not the fp value) of B.
+ */
+static inline int notrace unwind_next(struct unwind_state *state)
+{
+	struct task_struct *tsk = state->task;
+	unsigned long fp = state->fp;
+	struct stack_info info;
+	int err;
+
+	/* Final frame; nothing to unwind */
+	if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
+		return -ENOENT;
+
+	err = unwind_next_common(state, &info, NULL);
+	if (err)
+		return err;
+
+	state->pc = ptrauth_strip_insn_pac(state->pc);
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	if (tsk->ret_stack &&
+		(state->pc == (unsigned long)return_to_handler)) {
+		unsigned long orig_pc;
+		/*
+		 * This is a case where function graph tracer has
+		 * modified a return address (LR) in a stack frame
+		 * to hook a function return.
+		 * So replace it to an original value.
+		 */
+		orig_pc = ftrace_graph_ret_addr(tsk, NULL, state->pc,
+						(void *)state->fp);
+		if (WARN_ON_ONCE(state->pc == orig_pc))
+			return -EINVAL;
+		state->pc = orig_pc;
+	}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+#ifdef CONFIG_KRETPROBES
+	if (is_kretprobe_trampoline(state->pc))
+		state->pc = kretprobe_find_ret_addr(tsk, (void *)state->fp, &state->kr_cur);
+#endif
+
+	return 0;
+}
+NOKPROBE_SYMBOL(unwind_next);
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
index 5f5d74a286f3..f86efe71479d 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -9,6 +9,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/kprobes.h>
 #include <linux/types.h>
 
 enum stack_type {
@@ -69,6 +70,8 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 				       unsigned long sp, unsigned long size,
 				       struct stack_info *info);
 
+static inline int unwind_next(struct unwind_state *state);
+
 static inline bool on_stack(unsigned long sp, unsigned long size,
 			    unsigned long low, unsigned long high,
 			    enum stack_type type, struct stack_info *info)
@@ -192,4 +195,20 @@ static inline int unwind_next_common(struct unwind_state *state,
 
 	return 0;
 }
+
+static inline void notrace unwind(struct unwind_state *state,
+				  stack_trace_consume_fn consume_entry,
+				  void *cookie)
+{
+	while (1) {
+		int ret;
+
+		if (!consume_entry(cookie, state->pc))
+			break;
+		ret = unwind_next(state);
+		if (ret < 0)
+			break;
+	}
+}
+NOKPROBE_SYMBOL(unwind);
 #endif	/* __ASM_STACKTRACE_COMMON_H */
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index eef3cf6bf2d7..9fa60ee48499 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -7,14 +7,12 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/ftrace.h>
-#include <linux/kprobes.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
 
 #include <asm/irq.h>
-#include <asm/pointer_auth.h>
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
@@ -69,71 +67,6 @@ static inline void unwind_init_from_task(struct unwind_state *state,
 	state->pc = thread_saved_pc(task);
 }
 
-/*
- * Unwind from one frame record (A) to the next frame record (B).
- *
- * We terminate early if the location of B indicates a malformed chain of frame
- * records (e.g. a cycle), determined based on the location and fp value of A
- * and the location (but not the fp value) of B.
- */
-static int notrace unwind_next(struct unwind_state *state)
-{
-	struct task_struct *tsk = state->task;
-	unsigned long fp = state->fp;
-	struct stack_info info;
-	int err;
-
-	/* Final frame; nothing to unwind */
-	if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
-		return -ENOENT;
-
-	err = unwind_next_common(state, &info, NULL);
-	if (err)
-		return err;
-
-	state->pc = ptrauth_strip_insn_pac(state->pc);
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	if (tsk->ret_stack &&
-		(state->pc == (unsigned long)return_to_handler)) {
-		unsigned long orig_pc;
-		/*
-		 * This is a case where function graph tracer has
-		 * modified a return address (LR) in a stack frame
-		 * to hook a function return.
-		 * So replace it to an original value.
-		 */
-		orig_pc = ftrace_graph_ret_addr(tsk, NULL, state->pc,
-						(void *)state->fp);
-		if (WARN_ON_ONCE(state->pc == orig_pc))
-			return -EINVAL;
-		state->pc = orig_pc;
-	}
-#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-#ifdef CONFIG_KRETPROBES
-	if (is_kretprobe_trampoline(state->pc))
-		state->pc = kretprobe_find_ret_addr(tsk, (void *)state->fp, &state->kr_cur);
-#endif
-
-	return 0;
-}
-NOKPROBE_SYMBOL(unwind_next);
-
-static void notrace unwind(struct unwind_state *state,
-			   stack_trace_consume_fn consume_entry, void *cookie)
-{
-	while (1) {
-		int ret;
-
-		if (!consume_entry(cookie, state->pc))
-			break;
-		ret = unwind_next(state);
-		if (ret < 0)
-			break;
-	}
-}
-NOKPROBE_SYMBOL(unwind);
-
 static bool dump_backtrace_entry(void *arg, unsigned long where)
 {
 	char *loglvl = arg;
-- 
2.37.0.170.g444d1eabd0-goog

