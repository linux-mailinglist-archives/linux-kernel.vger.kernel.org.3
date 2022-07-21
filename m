Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D169757C3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiGUF5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiGUF5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:57:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627E178592
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u15-20020a25ab0f000000b0066e49f6c461so596449ybi.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WyIKR8TUtopiF0qnPsaUqeT828xnhHfiqTnOAjLvkEU=;
        b=qXePP2zExQWiLI/yOHnWQnY5tmhFAwJFSqJrQsCg0h6G8nmwnF1BSu7Tv7ohah8YB1
         KVX8Lavyw3BBpVWcrOaCdU/iJ6Y7qYazH9qiorZj/xwIMS40SXKumHg4Dn/S475ukR74
         9CnvnxRXJxA8LdmN+KFBJdWnfbbdOibcMyVBYansveYrAPuoySkyyGtU1qNpn7xYDGsV
         6xtr6vD2pMy3ZSHbjF4UdwODcRZhFLACHZXKJ7WTnnp1f40k/V/jqLXL9FQwX+kCIdfW
         0OW/gsveCT9YMYi/It+j39p4HHJbgisCkz0pmK6O+z6E1fJWW2gAUcUB7FR5rRfZWEGL
         8mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WyIKR8TUtopiF0qnPsaUqeT828xnhHfiqTnOAjLvkEU=;
        b=7NlqOa8G2Jwci9k+/JJxaV1aGxlPSnsPcwUe93B6yBsGvP0NEykEF7LHMl0/0Tiwsw
         tCiNaJ7UNTDF2hguprpHvZxsPiZCvWgHHTW78Zyg4RsIrcGyBSyJZeUToy0yVQisCxap
         aowaHA7nOJXYfI/O5WXt/WbLUFEek/S7vOPe8VGS6RLubVYUICnSU8ATbBhtj6xU8+Bg
         5YcwAKnwObMsyHdbg+HLHfD33oYRdQEE8Hjol6H0MTz2rSeHCPIVyHSgpBTkaNZJUi3G
         JaBlxVc8NDD45/AiSomDpLXqJuM19iCgp56UpN94K1t8EpODP6kwtB9Y+YlTa/hUfx29
         Ko5g==
X-Gm-Message-State: AJIora+yrDpWyaToPQQl6s/rCSpzevOcTTppoRhDD6vic+wipjkP9S/X
        qYZW7WQk6Ld2N4Ys1SCd3w7DKyWJSvYIeZCnbw==
X-Google-Smtp-Source: AGRyM1sfIbntgoW8rO3m7spgy+DJgSO1pahUDS3COgVSb+d4GGF47/6T+S4aPood8bswctHa1bPb6Il0e/iafJvdTA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a81:4f41:0:b0:31e:7981:3a64 with SMTP
 id d62-20020a814f41000000b0031e79813a64mr3060018ywb.93.1658383065697; Wed, 20
 Jul 2022 22:57:45 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:16 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 05/17] arm64: stacktrace: Factor out common unwind()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v5:
  - Add Reviewed-by tag from Fuad

 arch/arm64/include/asm/stacktrace.h        | 51 ++++++++++++++++
 arch/arm64/include/asm/stacktrace/common.h | 19 ++++++
 arch/arm64/kernel/stacktrace.c             | 67 ----------------------
 3 files changed, 70 insertions(+), 67 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 43f4b4a6d383..ea828579a98b 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -11,6 +11,7 @@
 #include <linux/llist.h>
 
 #include <asm/memory.h>
+#include <asm/pointer_auth.h>
 #include <asm/ptrace.h>
 #include <asm/sdei.h>
 
@@ -80,4 +81,54 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 	return false;
 }
 
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
+
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
index e89c8c39858d..7807752aaab1 100644
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
@@ -191,4 +194,20 @@ static inline int unwind_next_common(struct unwind_state *state,
 
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

