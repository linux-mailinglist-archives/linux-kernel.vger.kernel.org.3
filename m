Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18B47AAD8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhLTOCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:02:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41822 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhLTOCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:02:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 944BDCE10DC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BA7C36AE8;
        Mon, 20 Dec 2021 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640008925;
        bh=NSvi98aEFaQgUV72zWwqKlQJgJXwFw8U9szg61ZExXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G1RtsmKUJjh0joUakRXBzHtZyAWeucATDtxlDKuIF2ncbMfHYs0GLrUPwTRlwmF1g
         u04WictEYGPWvYFDlTy3yGFofkCjQBgChA2g8eVjJ51txr8wakUxqDXLvZnFuvfRtm
         l2thDhPUPjBubfN737t9pqFDtc4DJ7VhhEDTe7i+tALwQgojjOxI2aNlx6BsOmw7H2
         +e5G70wj+AKue1FD1FJt/7H1uPTpKFDwvNZSD/E6n3wny5j/XNPxU9ZMc5F0v29rjC
         HfyEAaiBU2fokJT1GMZMwS6ZLcl/PptAS0nYv9/+tgnP9mbMp/rxDdH8CcE6QES94M
         GcbulzeaBVYxg==
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
Subject: [PATCH 4/5] arm64: Implement IRQ exit preemption static call for dynamic preemption
Date:   Mon, 20 Dec 2021 15:01:41 +0100
Message-Id: <20211220140142.922323-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211220140142.922323-1-frederic@kernel.org>
References: <20211220140142.922323-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 doesn't support generic entry yet, so the architecture's own IRQ
exit preemption path needs to be exposed through the relevant static
call.

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
 arch/arm64/include/asm/preempt.h |  7 +++++++
 arch/arm64/kernel/entry-common.c | 15 ++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index e83f0982b99c..4fbbe644532f 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -3,6 +3,7 @@
 #define __ASM_PREEMPT_H
 
 #include <linux/thread_info.h>
+#include <linux/static_call_types.h>
 
 #define PREEMPT_NEED_RESCHED	BIT(32)
 #define PREEMPT_ENABLED	(PREEMPT_NEED_RESCHED)
@@ -86,4 +87,10 @@ void preempt_schedule_notrace(void);
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
 #endif /* CONFIG_PREEMPTION */
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+void arm64_preempt_schedule_irq(void);
+#define __irqentry_exit_cond_resched_func arm64_preempt_schedule_irq
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, __irqentry_exit_cond_resched_func);
+#endif /* CONFIG_PREEMPT_DYNAMIC */
+
 #endif /* __ASM_PREEMPT_H */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index f7408edf8571..b4fe707885d9 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/thread_info.h>
+#include <linux/static_call.h>
 
 #include <asm/cpufeature.h>
 #include <asm/daifflags.h>
@@ -220,7 +221,7 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-static void __sched arm64_preempt_schedule_irq(void)
+void __sched arm64_preempt_schedule_irq(void)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -244,6 +245,9 @@ static void __sched arm64_preempt_schedule_irq(void)
 	if (system_capabilities_finalized())
 		preempt_schedule_irq();
 }
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_CALL(irqentry_exit_cond_resched, arm64_preempt_schedule_irq);
+#endif
 
 static void do_interrupt_handler(struct pt_regs *regs,
 				 void (*handler)(struct pt_regs *))
@@ -444,8 +448,13 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 	 * preempt_count().
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPTION) &&
-	    READ_ONCE(current_thread_info()->preempt_count) == 0)
-		arm64_preempt_schedule_irq();
+	    READ_ONCE(current_thread_info()->preempt_count) == 0) {
+#ifdef CONFIG_PREEMPT_DYNAMIC
+			static_call(irqentry_exit_cond_resched)();
+#else
+			arm64_preempt_schedule_irq();
+#endif
+	}
 
 	exit_to_kernel_mode(regs);
 }
-- 
2.25.1

