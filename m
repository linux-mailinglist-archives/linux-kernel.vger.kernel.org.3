Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBDA48352C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiACQw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:52:58 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53226 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiACQwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:52:49 -0500
Received: from x64host.home (unknown [47.187.212.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id CE74C20B7187;
        Mon,  3 Jan 2022 08:52:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE74C20B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641228768;
        bh=3lzVOaR35pHb/fHnIwSFLrwaATuOq5V8yBUdf85S2So=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=p2npznnDJMamREe4Ij37w4jczzWls1u96tyFnLpJMrTubpsjQayaHgc0lh0THTno3
         az7fWl0yNeN1d2bp3AjJWYlX0WifnePtntc5VIyOlwwf69ps/hDx81dNBPQX0cu/Ow
         ElqSITmCNGHAy0ufY3+hSnJnlXGG4TqAASmYHL+Y=
From:   madvenka@linux.microsoft.com
To:     mark.rutland@arm.com, broonie@kernel.org, jpoimboe@redhat.com,
        ardb@kernel.org, nobuta.keiya@fujitsu.com,
        sjitindarsingh@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        jmorris@namei.org, linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        madvenka@linux.microsoft.com
Subject: [PATCH v12 04/10] arm64: Split unwind_init()
Date:   Mon,  3 Jan 2022 10:52:06 -0600
Message-Id: <20220103165212.9303-5-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103165212.9303-1-madvenka@linux.microsoft.com>
References: <0d0eb36f348fb5a6af6eb592c0525f6e94007328>
 <20220103165212.9303-1-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

unwind_init() is currently a single function that initializes all of the
unwind state. Split it into the following functions and call them
appropriately:

	- unwind_init_regs() - initialize from regs passed by caller.

	- unwind_init_current() - initialize for the current task from the
	  caller of arch_stack_walk().

	- unwind_init_from_task() - initialize from the saved state of a
	  task other than the current task. In this case, the other
	  task must not be running.

	- unwind_init_common() - initialize fields that are common across
	  the above 3 cases.

This is done so that specialized initialization can be added to each case
in the future.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 arch/arm64/kernel/stacktrace.c | 50 +++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index a1a7ff93b84f..bd797e3f7789 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -33,11 +33,8 @@
  */
 
 
-static void unwind_init(struct unwind_state *state, unsigned long fp,
-			unsigned long pc)
+static void unwind_init_common(struct unwind_state *state)
 {
-	state->fp = fp;
-	state->pc = pc;
 #ifdef CONFIG_KRETPROBES
 	state->kr_cur = NULL;
 #endif
@@ -56,6 +53,40 @@ static void unwind_init(struct unwind_state *state, unsigned long fp,
 	state->prev_type = STACK_TYPE_UNKNOWN;
 }
 
+/*
+ * TODO: document requirements here.
+ */
+static inline void unwind_init_regs(struct unwind_state *state,
+				    struct pt_regs *regs)
+{
+	state->fp = regs->regs[29];
+	state->pc = regs->pc;
+}
+
+/*
+ * TODO: document requirements here.
+ *
+ * Note: this is always inlined, and we expect our caller to be a noinline
+ * function, such that this starts from our caller's caller.
+ */
+static __always_inline void unwind_init_current(struct unwind_state *state)
+{
+	state->fp = (unsigned long)__builtin_frame_address(1);
+	state->pc = (unsigned long)__builtin_return_address(0);
+}
+
+/*
+ * TODO: document requirements here.
+ *
+ * The caller guarantees that the task is not running.
+ */
+static inline void unwind_init_task(struct unwind_state *state,
+				    struct task_struct *task)
+{
+	state->fp = thread_saved_fp(task);
+	state->pc = thread_saved_pc(task);
+}
+
 /*
  * Unwind from one frame record (A) to the next frame record (B).
  *
@@ -194,15 +225,14 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 {
 	struct unwind_state state;
 
+	unwind_init_common(&state);
+
 	if (regs)
-		unwind_init(&state, regs->regs[29], regs->pc);
+		unwind_init_regs(&state, regs);
 	else if (task == current)
-		unwind_init(&state,
-				(unsigned long)__builtin_frame_address(1),
-				(unsigned long)__builtin_return_address(0));
+		unwind_init_current(&state);
 	else
-		unwind_init(&state, thread_saved_fp(task),
-				thread_saved_pc(task));
+		unwind_init_task(&state, task);
 
 	unwind(task, &state, consume_entry, cookie);
 }
-- 
2.25.1

