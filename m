Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FC947AAD7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhLTOCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhLTOCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:02:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D504C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:02:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A73E9CE10CB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EEAC36AEC;
        Mon, 20 Dec 2021 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640008922;
        bh=3bpd/r5RMN0rbSg1WZbf0MkLK4X+tNmTC2LTF6qvz4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sxn5UhiQVFik8dyUBmXJE4PhrQNSAmpR62bF3I09l+ALE2mNXIlLLJGmZRCkFUWe5
         bQlDLSBszdCaE63w11MWNMkOJMg+4CWPOhyaql3ebpgptz5cjvoMedwELidchuPENV
         WQF8APMt4ysXJ6q22E7AM+nX7X4x5XoZdMsb34ZNJXzUls3nxHQYdiix4AYQq6egK4
         k49y+LW4Uc/kjnE1sXg7clUuw7UvAAHVHBmP82ekxKeq+8kopxOiY1r7t/l7Q3AJyU
         7R6kb2drNyM4OZ3l0N5ebwhBBQBCqDyXnhPPepf9cga8ZuR3SPxtyX00vWmZXuI1GG
         y/Ze2uewHMfXw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/5] sched/preempt: Prepare for supporting !CONFIG_GENERIC_ENTRY dynamic preemption
Date:   Mon, 20 Dec 2021 15:01:40 +0100
Message-Id: <20211220140142.922323-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211220140142.922323-1-frederic@kernel.org>
References: <20211220140142.922323-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to force dynamic preemption to depend on the generic
entry code. The latter is convenient but not mandatory. An architecture
that doesn't support it just need to provide a static call on its
kernel IRQ exit preemption path.

Prepare the preempt dynamic code to handle that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Kees Cook <keescook@chromium.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 arch/Kconfig                 | 1 -
 include/linux/entry-common.h | 3 ++-
 kernel/sched/core.c          | 6 ++++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 26b8ed11639d..f3fb543d5da0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1266,7 +1266,6 @@ config HAVE_STATIC_CALL_INLINE
 config HAVE_PREEMPT_DYNAMIC
 	bool
 	depends on HAVE_STATIC_CALL
-	depends on GENERIC_ENTRY
 	help
 	   Select this if the architecture support boot time preempt setting
 	   on top of static calls. It is strongly advised to support inline
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6140ed..81166bbc0f22 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -456,7 +456,8 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  */
 void irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+#define __irqentry_exit_cond_resched_func irqentry_exit_cond_resched
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, __irqentry_exit_cond_resched_func);
 #endif
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe53e510e711..865b0fc0ac04 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6553,7 +6553,9 @@ EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
+#ifdef CONFIG_GENERIC_ENTRY
 #include <linux/entry-common.h>
+#endif
 
 /*
  * SC:cond_resched
@@ -6618,7 +6620,7 @@ void sched_dynamic_update(int mode)
 	static_call_update(might_resched, __cond_resched);
 	static_call_update(preempt_schedule, __preempt_schedule_func);
 	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+	static_call_update(irqentry_exit_cond_resched, __irqentry_exit_cond_resched_func);
 
 	switch (mode) {
 	case preempt_dynamic_none:
@@ -6644,7 +6646,7 @@ void sched_dynamic_update(int mode)
 		static_call_update(might_resched, (void *)&__static_call_return0);
 		static_call_update(preempt_schedule, __preempt_schedule_func);
 		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+		static_call_update(irqentry_exit_cond_resched, __irqentry_exit_cond_resched_func);
 		pr_info("Dynamic Preempt: full\n");
 		break;
 	}
-- 
2.25.1

