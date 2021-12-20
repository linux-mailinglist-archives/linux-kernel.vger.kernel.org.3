Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B842247AAD9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhLTOCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:02:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49342 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhLTOCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:02:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D4D161159
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A1AC36AE7;
        Mon, 20 Dec 2021 14:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640008929;
        bh=DzgsKLisfRdks6kxMkj4DhUsGM6fml38rGCF4UCP2Es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPua5JySb6IPtIiNH3GvYJpZoWzZja14yrwNUT0R/A+nVWkjUNtRut4hTDsUSKF4n
         KjZaTNpoTIkzz/KVqUHRYLv+P+f/jhZre3UyqpaqTkrJAPgNFw6LeBB/A4IQNq4xto
         NMbhzH/au4awHeIDtOE/cwf41EZsGFMn4t+movJ3Co7+lpaWw+6s9BYVPECaqDKwk5
         TkA3whMKBCxAtA7EFHik4AVQaWobN4hdLIjo27QtYmAJ90W/fQt2Vw+PdDeISRXtHI
         CiN4Vu/izpVcsFffQd4QmMOESD8D+fhBH4aEnTBns9g2YunrK2rtfEaQCcp94uOPCG
         O+BuuIHxZcyVg==
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
Subject: [PATCH 5/5] arm64: Implement HAVE_PREEMPT_DYNAMIC
Date:   Mon, 20 Dec 2021 15:01:42 +0100
Message-Id: <20211220140142.922323-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211220140142.922323-1-frederic@kernel.org>
References: <20211220140142.922323-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the static calls for the common preemption points and report
arm64 ability to support dynamic preemption.

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
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/preempt.h | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6f2d3e31fb54..f7d55ae0b4a2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -191,6 +191,7 @@ config ARM64
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PREEMPT_DYNAMIC
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	# https://github.com/ClangBuiltLinux/linux/issues/1354
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 4fbbe644532f..69d1cc491d3b 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -82,15 +82,29 @@ static inline bool should_resched(int preempt_offset)
 
 #ifdef CONFIG_PREEMPTION
 void preempt_schedule(void);
-#define __preempt_schedule() preempt_schedule()
 void preempt_schedule_notrace(void);
-#define __preempt_schedule_notrace() preempt_schedule_notrace()
-#endif /* CONFIG_PREEMPTION */
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
+
+#define __preempt_schedule_func preempt_schedule
+DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
+#define __preempt_schedule() static_call(preempt_schedule)()
+
+#define __preempt_schedule_notrace_func preempt_schedule_notrace
+DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+#define __preempt_schedule_notrace() static_call(preempt_schedule_notrace)()
+
 void arm64_preempt_schedule_irq(void);
 #define __irqentry_exit_cond_resched_func arm64_preempt_schedule_irq
 DECLARE_STATIC_CALL(irqentry_exit_cond_resched, __irqentry_exit_cond_resched_func);
+
+#else /* !CONFIG_PREEMPT_DYNAMIC */
+
+#define __preempt_schedule() preempt_schedule()
+#define __preempt_schedule_notrace() preempt_schedule_notrace()
+
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
+#endif /* CONFIG_PREEMPTION */
+
 #endif /* __ASM_PREEMPT_H */
-- 
2.25.1

