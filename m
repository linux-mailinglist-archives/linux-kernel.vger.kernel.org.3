Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76718575B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiGOGKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOGKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:10:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5825E47B86
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:10:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31c972f5f84so33606877b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HwPTm6cmxu9zJXjSHjPz49JaMF8MztZgzIWe/cJ+deE=;
        b=Z3zQjpPDiRsDOnp5dDl1GRJwMvY87HgUwdl0j3CSd+VpRKjoClSRyeMLjaJep5115R
         DBeCAIIkFz6OCl7XTKhwsUTqotNv8xGpbXkoldYm0q//4woWStURAOVbCoj+7WJsjXL9
         /zCQ0od5ZsSU7isO7m3a380zlVBKQ98kJkp1EEubvlQogyBvSds1KHxUuyihgbI4DZFQ
         7jg+p0Re5JrfdxV3tD1DwB4Dv/sOdelLp5ZxaZHAqrcn5E2G5jbwzfBbd60SM+e2HKuw
         MGOWY6pFUCK2GEIWFI1PcqPGK72EinGGpI7hh0LvcIJ4Fn+Gjx4dYM3Jw1HuIlK0JR8r
         afTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HwPTm6cmxu9zJXjSHjPz49JaMF8MztZgzIWe/cJ+deE=;
        b=BHYpitZh8BHef0Cqhcss+r5K7uwsA2Ndn0xgXNUTlGtaVPpOaAtMmdJdu++9qFsFGz
         KogAZPz0hs2qvfVW8BA7iFFLd5seXIcvlBZP7veaZpYYcO1WoBKjhuJD3uwOS9MoR9UR
         I+QizChj7JTAF3AUs+YVnDjy0ndgPJe1jnXWxhNa3tswJwNMHkTJ4+xk8ZJnGOW2FyQx
         Bh+cWRdpprKcc3NJ1t9FFLfdEpUWUP6RSmTdfcDcwVRu76fjTgUCFKzSkpasBf2ZceSL
         gAVvUF1QIWfODtJiR3V3lYogkTfTS9Kxl9citFSKNxulWY0YfhLkrH1z+hp/lXKIAliM
         ySsw==
X-Gm-Message-State: AJIora9s4zL7ZiSvBfzb5QHwnYOB9n37G5pNeBbdKkk2wU7I7BuEjVtY
        SuA82kztQvNjBW8c8ugHbGdAnt36ifGTxfqZIQ==
X-Google-Smtp-Source: AGRyM1uQsnm9sZo0q5d9K7/udtHT67wBvEUrThfObqq+hDgims8clShXazzHT77SMjEPhS9aYSgaY5BdxHGEM8HEWw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a81:b80c:0:b0:31c:8cfc:cbc0 with SMTP
 id v12-20020a81b80c000000b0031c8cfccbc0mr14308532ywe.157.1657865435586; Thu,
 14 Jul 2022 23:10:35 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:10 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 01/18] arm64: stacktrace: Add shared header for common
 stack unwinding code
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reuse the arm64 stack unwinding logic for the nVHE
hypervisor stack, move the common code to a shared header
(arch/arm64/include/asm/stacktrace/common.h).

The nVHE hypervisor cannot safely link against kernel code, so we
make use of the shared header to avoid duplicated logic later in
this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace.h        |  35 +------
 arch/arm64/include/asm/stacktrace/common.h | 105 +++++++++++++++++++++
 arch/arm64/kernel/stacktrace.c             |  57 -----------
 3 files changed, 106 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm64/include/asm/stacktrace/common.h

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index aec9315bf156..79f455b37c84 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -8,52 +8,19 @@
 #include <linux/percpu.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
-#include <linux/types.h>
 #include <linux/llist.h>
 
 #include <asm/memory.h>
 #include <asm/ptrace.h>
 #include <asm/sdei.h>
 
-enum stack_type {
-	STACK_TYPE_UNKNOWN,
-	STACK_TYPE_TASK,
-	STACK_TYPE_IRQ,
-	STACK_TYPE_OVERFLOW,
-	STACK_TYPE_SDEI_NORMAL,
-	STACK_TYPE_SDEI_CRITICAL,
-	__NR_STACK_TYPES
-};
-
-struct stack_info {
-	unsigned long low;
-	unsigned long high;
-	enum stack_type type;
-};
+#include <asm/stacktrace/common.h>
 
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 			   const char *loglvl);
 
 DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
 
-static inline bool on_stack(unsigned long sp, unsigned long size,
-			    unsigned long low, unsigned long high,
-			    enum stack_type type, struct stack_info *info)
-{
-	if (!low)
-		return false;
-
-	if (sp < low || sp + size < sp || sp + size > high)
-		return false;
-
-	if (info) {
-		info->low = low;
-		info->high = high;
-		info->type = type;
-	}
-	return true;
-}
-
 static inline bool on_irq_stack(unsigned long sp, unsigned long size,
 				struct stack_info *info)
 {
diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
new file mode 100644
index 000000000000..64ae4f6b06fe
--- /dev/null
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Common arm64 stack unwinder code.
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ */
+#ifndef __ASM_STACKTRACE_COMMON_H
+#define __ASM_STACKTRACE_COMMON_H
+
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
+
+enum stack_type {
+	STACK_TYPE_UNKNOWN,
+	STACK_TYPE_TASK,
+	STACK_TYPE_IRQ,
+	STACK_TYPE_OVERFLOW,
+	STACK_TYPE_SDEI_NORMAL,
+	STACK_TYPE_SDEI_CRITICAL,
+	__NR_STACK_TYPES
+};
+
+struct stack_info {
+	unsigned long low;
+	unsigned long high;
+	enum stack_type type;
+};
+
+/*
+ * A snapshot of a frame record or fp/lr register values, along with some
+ * accounting information necessary for robust unwinding.
+ *
+ * @fp:          The fp value in the frame record (or the real fp)
+ * @pc:          The lr value in the frame record (or the real lr)
+ *
+ * @stacks_done: Stacks which have been entirely unwound, for which it is no
+ *               longer valid to unwind to.
+ *
+ * @prev_fp:     The fp that pointed to this frame record, or a synthetic value
+ *               of 0. This is used to ensure that within a stack, each
+ *               subsequent frame record is at an increasing address.
+ * @prev_type:   The type of stack this frame record was on, or a synthetic
+ *               value of STACK_TYPE_UNKNOWN. This is used to detect a
+ *               transition from one stack to another.
+ *
+ * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
+ *               associated with the most recently encountered replacement lr
+ *               value.
+ *
+ * @task:        The task being unwound.
+ */
+struct unwind_state {
+	unsigned long fp;
+	unsigned long pc;
+	DECLARE_BITMAP(stacks_done, __NR_STACK_TYPES);
+	unsigned long prev_fp;
+	enum stack_type prev_type;
+#ifdef CONFIG_KRETPROBES
+	struct llist_node *kr_cur;
+#endif
+	struct task_struct *task;
+};
+
+static inline bool on_stack(unsigned long sp, unsigned long size,
+			    unsigned long low, unsigned long high,
+			    enum stack_type type, struct stack_info *info)
+{
+	if (!low)
+		return false;
+
+	if (sp < low || sp + size < sp || sp + size > high)
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
+static inline void unwind_init_common(struct unwind_state *state,
+				      struct task_struct *task)
+{
+	state->task = task;
+#ifdef CONFIG_KRETPROBES
+	state->kr_cur = NULL;
+#endif
+
+	/*
+	 * Prime the first unwind.
+	 *
+	 * In unwind_next() we'll check that the FP points to a valid stack,
+	 * which can't be STACK_TYPE_UNKNOWN, and the first unwind will be
+	 * treated as a transition to whichever stack that happens to be. The
+	 * prev_fp value won't be used, but we set it to 0 such that it is
+	 * definitely not an accessible stack address.
+	 */
+	bitmap_zero(state->stacks_done, __NR_STACK_TYPES);
+	state->prev_fp = 0;
+	state->prev_type = STACK_TYPE_UNKNOWN;
+}
+
+#endif	/* __ASM_STACKTRACE_COMMON_H */
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index fcaa151b81f1..94a5dd2ab8fd 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -18,63 +18,6 @@
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
-/*
- * A snapshot of a frame record or fp/lr register values, along with some
- * accounting information necessary for robust unwinding.
- *
- * @fp:          The fp value in the frame record (or the real fp)
- * @pc:          The lr value in the frame record (or the real lr)
- *
- * @stacks_done: Stacks which have been entirely unwound, for which it is no
- *               longer valid to unwind to.
- *
- * @prev_fp:     The fp that pointed to this frame record, or a synthetic value
- *               of 0. This is used to ensure that within a stack, each
- *               subsequent frame record is at an increasing address.
- * @prev_type:   The type of stack this frame record was on, or a synthetic
- *               value of STACK_TYPE_UNKNOWN. This is used to detect a
- *               transition from one stack to another.
- *
- * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
- *               associated with the most recently encountered replacement lr
- *               value.
- *
- * @task:        The task being unwound.
- */
-struct unwind_state {
-	unsigned long fp;
-	unsigned long pc;
-	DECLARE_BITMAP(stacks_done, __NR_STACK_TYPES);
-	unsigned long prev_fp;
-	enum stack_type prev_type;
-#ifdef CONFIG_KRETPROBES
-	struct llist_node *kr_cur;
-#endif
-	struct task_struct *task;
-};
-
-static void unwind_init_common(struct unwind_state *state,
-			       struct task_struct *task)
-{
-	state->task = task;
-#ifdef CONFIG_KRETPROBES
-	state->kr_cur = NULL;
-#endif
-
-	/*
-	 * Prime the first unwind.
-	 *
-	 * In unwind_next() we'll check that the FP points to a valid stack,
-	 * which can't be STACK_TYPE_UNKNOWN, and the first unwind will be
-	 * treated as a transition to whichever stack that happens to be. The
-	 * prev_fp value won't be used, but we set it to 0 such that it is
-	 * definitely not an accessible stack address.
-	 */
-	bitmap_zero(state->stacks_done, __NR_STACK_TYPES);
-	state->prev_fp = 0;
-	state->prev_type = STACK_TYPE_UNKNOWN;
-}
-
 /*
  * Start an unwind from a pt_regs.
  *
-- 
2.37.0.170.g444d1eabd0-goog

