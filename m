Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8D580E09
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiGZHjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiGZHim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1752B253
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o135-20020a25738d000000b0066f58989d75so10548672ybc.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=oKsO05P5VhcOhgxPaMS6HDnukgyf9AnFQ5c8xI8uER0=;
        b=RWdGAWr1wiMKMYmt1Q0zaOtg01Gpkj8XyrBSlfbuJSLqsyPs2tLYDKHtBSOwf48Shy
         DkYgX60VLBIuDQouUNeq5KQTYkgOdpKW44mgBBJ+LicBqyV0Z1NWi5StUYyqdAVS1ll5
         F568b6yHoHL1tWf/TUQCFWcSuioO8OfEun/UrNi2xeOZf9PZVBW192GSWJrSrCJ3W9PY
         /Po1ewQ0PS3T1o4JmjsyyYeOfzZfsWEVS/4QdzhlNKOPA29XaZqAVU0WP0ixV2f7Isti
         P0KEbN70EUnCLoPljXREc1wrcu5VQV3ElufIlRi4JXKUyOzY/0wnxsVuLcaVlVjQ/ff3
         iPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=oKsO05P5VhcOhgxPaMS6HDnukgyf9AnFQ5c8xI8uER0=;
        b=Ps6oiZQ7AMbeary6tUWhfDUXH8YSkf4+QKMcVxnQqER0OkypDeqEHfQzGEi87NiCBy
         he+6UBiXCHsYTnfmjV7/b1/fYc6Z1tmWsZqeYIkuJmPdJ15mjFVXqx2zvptLRJWIZ4rw
         KV2utNT3Z5sLJQker96vHWjHgn8uggbK4l9O7X4QVuhfsMXsOi0cM+GNt11mRjqxEsge
         QfBjMRZ0qCQJ8bQxMNzeZjq3HyAXMSDCzpYeE65zrNIlA5yYu0/aBM1hV3MbDWMJ3KyA
         9pp9CpHK+o4ksKMscjpXpl1j+DXtO/kFh+ok4e9P0nIzzwZndNFjebZr9ENdLMB44uNd
         WBsQ==
X-Gm-Message-State: AJIora9wmrcVBWpQhb+NEZdy0oh1MvSfpSD/mzuNqCUovDKrC841cWaQ
        F92sEDU1yU1zlPR3x3xF1uRtlzoyTBLPSQABkg==
X-Google-Smtp-Source: AGRyM1tkUVtSxVSYagZ3IM0myL/MmHggfXa+9W+OWUGgjocjbTQ1+SnKGqSf50Z5nLH4MLcVuHH3XYxWyaCFV7DDXg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:10c1:b0:66f:1f9f:9c00 with
 SMTP id w1-20020a05690210c100b0066f1f9f9c00mr11818088ybu.583.1658821087741;
 Tue, 26 Jul 2022 00:38:07 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:38 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 05/17] arm64: stacktrace: Factor out common unwind()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com,
        oliver.upton@linux.dev
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Add Mark Brown=E2=80=99s Reviewed-by tag
  - Add Fuad's Tested-by tag

Changes in v5:
  - Add Reviewed-by tag from Fuad

 arch/arm64/include/asm/stacktrace.h        | 51 ++++++++++++++++
 arch/arm64/include/asm/stacktrace/common.h | 19 ++++++
 arch/arm64/kernel/stacktrace.c             | 67 ----------------------
 3 files changed, 70 insertions(+), 67 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/s=
tacktrace.h
index 43f4b4a6d383..ea828579a98b 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -11,6 +11,7 @@
 #include <linux/llist.h>
=20
 #include <asm/memory.h>
+#include <asm/pointer_auth.h>
 #include <asm/ptrace.h>
 #include <asm/sdei.h>
=20
@@ -80,4 +81,54 @@ static inline bool on_accessible_stack(const struct task=
_struct *tsk,
 	return false;
 }
=20
+/*
+ * Unwind from one frame record (A) to the next frame record (B).
+ *
+ * We terminate early if the location of B indicates a malformed chain of =
frame
+ * records (e.g. a cycle), determined based on the location and fp value o=
f A
+ * and the location (but not the fp value) of B.
+ */
+static inline int notrace unwind_next(struct unwind_state *state)
+{
+	struct task_struct *tsk =3D state->task;
+	unsigned long fp =3D state->fp;
+	struct stack_info info;
+	int err;
+
+	/* Final frame; nothing to unwind */
+	if (fp =3D=3D (unsigned long)task_pt_regs(tsk)->stackframe)
+		return -ENOENT;
+
+	err =3D unwind_next_common(state, &info, NULL);
+	if (err)
+		return err;
+
+	state->pc =3D ptrauth_strip_insn_pac(state->pc);
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	if (tsk->ret_stack &&
+		(state->pc =3D=3D (unsigned long)return_to_handler)) {
+		unsigned long orig_pc;
+		/*
+		 * This is a case where function graph tracer has
+		 * modified a return address (LR) in a stack frame
+		 * to hook a function return.
+		 * So replace it to an original value.
+		 */
+		orig_pc =3D ftrace_graph_ret_addr(tsk, NULL, state->pc,
+						(void *)state->fp);
+		if (WARN_ON_ONCE(state->pc =3D=3D orig_pc))
+			return -EINVAL;
+		state->pc =3D orig_pc;
+	}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+#ifdef CONFIG_KRETPROBES
+	if (is_kretprobe_trampoline(state->pc))
+		state->pc =3D kretprobe_find_ret_addr(tsk, (void *)state->fp, &state->kr=
_cur);
+#endif
+
+	return 0;
+}
+NOKPROBE_SYMBOL(unwind_next);
+
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/includ=
e/asm/stacktrace/common.h
index b241edba5c76..4b632141d91c 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -9,6 +9,7 @@
=20
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/kprobes.h>
 #include <linux/types.h>
=20
 enum stack_type {
@@ -69,6 +70,8 @@ static inline bool on_accessible_stack(const struct task_=
struct *tsk,
 				       unsigned long sp, unsigned long size,
 				       struct stack_info *info);
=20
+static inline int unwind_next(struct unwind_state *state);
+
 static inline bool on_stack(unsigned long sp, unsigned long size,
 			    unsigned long low, unsigned long high,
 			    enum stack_type type, struct stack_info *info)
@@ -191,4 +194,20 @@ static inline int unwind_next_common(struct unwind_sta=
te *state,
=20
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
+		ret =3D unwind_next(state);
+		if (ret < 0)
+			break;
+	}
+}
+NOKPROBE_SYMBOL(unwind);
 #endif	/* __ASM_STACKTRACE_COMMON_H */
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.=
c
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
=20
 #include <asm/irq.h>
-#include <asm/pointer_auth.h>
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
=20
@@ -69,71 +67,6 @@ static inline void unwind_init_from_task(struct unwind_s=
tate *state,
 	state->pc =3D thread_saved_pc(task);
 }
=20
-/*
- * Unwind from one frame record (A) to the next frame record (B).
- *
- * We terminate early if the location of B indicates a malformed chain of =
frame
- * records (e.g. a cycle), determined based on the location and fp value o=
f A
- * and the location (but not the fp value) of B.
- */
-static int notrace unwind_next(struct unwind_state *state)
-{
-	struct task_struct *tsk =3D state->task;
-	unsigned long fp =3D state->fp;
-	struct stack_info info;
-	int err;
-
-	/* Final frame; nothing to unwind */
-	if (fp =3D=3D (unsigned long)task_pt_regs(tsk)->stackframe)
-		return -ENOENT;
-
-	err =3D unwind_next_common(state, &info, NULL);
-	if (err)
-		return err;
-
-	state->pc =3D ptrauth_strip_insn_pac(state->pc);
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	if (tsk->ret_stack &&
-		(state->pc =3D=3D (unsigned long)return_to_handler)) {
-		unsigned long orig_pc;
-		/*
-		 * This is a case where function graph tracer has
-		 * modified a return address (LR) in a stack frame
-		 * to hook a function return.
-		 * So replace it to an original value.
-		 */
-		orig_pc =3D ftrace_graph_ret_addr(tsk, NULL, state->pc,
-						(void *)state->fp);
-		if (WARN_ON_ONCE(state->pc =3D=3D orig_pc))
-			return -EINVAL;
-		state->pc =3D orig_pc;
-	}
-#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-#ifdef CONFIG_KRETPROBES
-	if (is_kretprobe_trampoline(state->pc))
-		state->pc =3D kretprobe_find_ret_addr(tsk, (void *)state->fp, &state->kr=
_cur);
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
-		ret =3D unwind_next(state);
-		if (ret < 0)
-			break;
-	}
-}
-NOKPROBE_SYMBOL(unwind);
-
 static bool dump_backtrace_entry(void *arg, unsigned long where)
 {
 	char *loglvl =3D arg;
--=20
2.37.1.359.gd136c6c3e2-goog

