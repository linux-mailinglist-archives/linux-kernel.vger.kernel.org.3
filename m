Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0AB550678
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 20:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiFRSZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 14:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiFRSZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 14:25:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F55C140CA
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 11:25:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so5629280pjm.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gP30dJy5y4a08n4oSYK7bdWs5c4wdE4/R1IyzPu4w90=;
        b=je9JhQfoBkF8Ef7LB9vvxuJenyXl9oWAJPBHq901iT+NKdeOT6JVHHFTwGIwLW76hL
         uJFHj0IIpoyo6hF//Oelb8k7lLF+XE/K81KCebbLDcP3fatWyxlGcpQ2TA+08SiwFY/X
         i9x1Q0D/BAcXZgip6FLJUnHyCcJwccoRnbtF+tKEKZWtQgtqJ25E09uaJPKajM4yRnyW
         gQazhBhA//o3na0PJgIhFUE7gsF5PaoHL7g2AcU/LRe9Sg2b9unoDz8q9usRodpIeUWG
         J0V4L1y5W9jk4BdGLS372f3b6ZKFWrv4NRgQUOllEe3RrgoaqG50w34vvnWd+2hfllP1
         LfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gP30dJy5y4a08n4oSYK7bdWs5c4wdE4/R1IyzPu4w90=;
        b=hAkXF4t0y8a6BQtqMYO6Pzo7LJPEn+Jg0XsWY73W4p955HxiNqS+Ck1xV8XQ3Irsft
         T7rR6anh7m3kRMQONF5kJOea2bBROZ7xPBE8VMn76UfJU4if0HrWQ9TspBEo4OyhjWUB
         MLeMzl3OOhNJt29YDkKkM3zaAucMXtDgXO0PEmIapiCP+eZhkxz79U3jeee22LgNMHVt
         xY8kghBBRTqtDLMxrNcg7hw6zWvdhAyY53hpGWeRK65CurXxxxKeuo55mk0SQTjj2H5F
         dU97kRhYFxCNxYHbkuPm2MBAVvByqHNfqZjtryPlFC5649NbuB4wALkDN4R9FAKhp4Qs
         nv7w==
X-Gm-Message-State: AJIora9VIXPQYC6JMxA6hF2BD4LnxikzJ0MES+bDLojHNf1Ahkr0oqxC
        wmChqxToQ0PGyX0pu+QxtE41VVCcQh0KOg==
X-Google-Smtp-Source: AGRyM1tUERoF+IMvGxlO1OhCIwKhAOBmVPAErK/70LrLKaeDz1L33TEmysMbySsIVp/JKeTsIsSqHg==
X-Received: by 2002:a17:90a:b703:b0:1dd:1e2f:97d7 with SMTP id l3-20020a17090ab70300b001dd1e2f97d7mr28302620pjr.62.1655576731124;
        Sat, 18 Jun 2022 11:25:31 -0700 (PDT)
Received: from localhost.localdomain ([113.173.111.117])
        by smtp.googlemail.com with ESMTPSA id s10-20020a639e0a000000b0040aeb7e9358sm5810865pgd.90.2022.06.18.11.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 11:25:30 -0700 (PDT)
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bui Quang Minh <minhquangbui99@gmail.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] rseq: x86: Fix rseq_cs get cleared when returning from signal handler
Date:   Sun, 19 Jun 2022 01:25:13 +0700
Message-Id: <20220618182515.95831-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rseq.rseq_cs is not expected to be cleared when we are still in critical
section. When using rseq with RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL, if the
signal is delivered, we don't restart to the abort ip but go to signal
handler then return and continue the critical section execution. While in
signal handler, if a preemption, migration or another signal is delivered,
we will fall into rseq_ip_fixup again. At that moment, the IP is in signal
handler not in critical section so the rseq.rseq_cs is cleared. Later, when
we return back to critical section from signal handlers, we get the
rseq.rseq_cs incorrectly cleared.

Another scenario is when a preemption or migration happens, then a signal
is delivered. When preparing to return to user mode, in
exit_to_user_mode_loop, we first handle the signal and set return IP to
signal handler. After that, rseq_handle_notify_resume is called to handle
the preemption/migration, sees the IP is the address of signal handler not
in critical section and clear rseq.rseq_cs.

To handle this case, a RSEQ_CS_FLAG_IN_SIGNAL_HANDLER is added. This flag
is set in rseq.flags (it is easier to read and update rseq.flags than
rseq.rseq_cs.flags) by the kernel when rseq does not restart on signal.
When this flag is set, we don't clear rseq.rseq_cs when the IP is outside
of critical section. The flag is unset in sigreturn path when the last
signal handler returns back to the critical section.

Reviewed-by: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 arch/x86/kernel/signal.c  |  7 ++++
 include/linux/sched.h     |  5 +++
 include/uapi/linux/rseq.h |  8 +++-
 kernel/rseq.c             | 80 ++++++++++++++++++++++++++++++++++++---
 4 files changed, 94 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 9c7265b524c7..7aadf69d6849 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -646,6 +646,10 @@ SYSCALL_DEFINE0(sigreturn)
 	 */
 	if (!restore_sigcontext(regs, &frame->sc, 0))
 		goto badframe;
+
+	if (rseq_sigreturn(regs))
+		goto badframe;
+
 	return regs->ax;
 
 badframe:
@@ -678,6 +682,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
+	if (rseq_sigreturn(regs))
+		goto badframe;
+
 	return regs->ax;
 
 badframe:
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c46f3a63b758..656b03232d0a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2340,6 +2340,8 @@ static inline void rseq_execve(struct task_struct *t)
 	t->rseq_event_mask = 0;
 }
 
+int rseq_sigreturn(struct pt_regs *regs);
+
 #else
 
 static inline void rseq_set_notify_resume(struct task_struct *t)
@@ -2365,6 +2367,9 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 static inline void rseq_execve(struct task_struct *t)
 {
 }
+static inline int rseq_sigreturn(struct pt_regs *regs)
+{
+}
 
 #endif
 
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 77ee207623a9..f946af8e21e6 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -26,6 +26,7 @@ enum rseq_cs_flags_bit {
 	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
 	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
+	RSEQ_CS_FLAG_IN_SIGNAL_HANDLER_BIT	= 3,
 };
 
 enum rseq_cs_flags {
@@ -35,6 +36,8 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE	=
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+	RSEQ_CS_FLAG_IN_SIGNAL_HANDLER		=
+		(1U << RSEQ_CS_FLAG_IN_SIGNAL_HANDLER_BIT),
 };
 
 /*
@@ -115,7 +118,7 @@ struct rseq {
 	 * Restartable sequences flags field.
 	 *
 	 * This field should only be updated by the thread which
-	 * registered this data structure. Read by the kernel.
+	 * registered this data structure. Read and set by the kernel.
 	 * Mainly used for single-stepping through rseq critical sections
 	 * with debuggers.
 	 *
@@ -128,6 +131,9 @@ struct rseq {
 	 * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
 	 *     Inhibit instruction sequence block restart on migration for
 	 *     this thread.
+	 * - RSEQ_CS_FLAG_IN_SIGNAL_HANDLER
+	 *     Mark that this thread is in critical section but currently in
+	 *     signal handlers, so don't clear the rseq_cs field.
 	 */
 	__u32 flags;
 } __attribute__((aligned(4 * sizeof(__u64))));
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 97ac20b4f738..a4aca612724b 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -172,14 +172,16 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 
 static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 {
-	u32 flags, event_mask;
+	u32 old_flags, flags, event_mask;
 	int ret;
 
 	/* Get thread flags. */
-	ret = get_user(flags, &t->rseq->flags);
+	ret = get_user(old_flags, &t->rseq->flags);
 	if (ret)
 		return ret;
 
+	flags = old_flags;
+
 	/* Take critical section flags into account. */
 	flags |= cs_flags;
 
@@ -203,6 +205,21 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	t->rseq_event_mask = 0;
 	preempt_enable();
 
+	/*
+	 * If we don't restart on signal event, set the
+	 * RSEQ_CS_FLAG_IN_SIGNAL_HANDLER flag so that later rseq_ip_fixup
+	 * doesn't clear rseq_cs pointer as the IP is outside of critical
+	 * section.
+	 */
+	if ((flags & RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL) &&
+	    (event_mask & RSEQ_EVENT_SIGNAL) &&
+	    !(old_flags & RSEQ_CS_FLAG_IN_SIGNAL_HANDLER)) {
+		old_flags |= RSEQ_CS_FLAG_IN_SIGNAL_HANDLER;
+		ret = put_user(old_flags, &t->rseq->flags);
+		if (ret)
+			return ret;
+	}
+
 	return !!(event_mask & ~flags);
 }
 
@@ -248,10 +265,23 @@ static int rseq_ip_fixup(struct pt_regs *regs)
 	/*
 	 * Handle potentially not being within a critical section.
 	 * If not nested over a rseq critical section, restart is useless.
-	 * Clear the rseq_cs pointer and return.
+	 * In case the RSEQ_CS_FLAG_IN_SIGNAL_HANDLER is set, we are in
+	 * signal handlers and later return to critical section so don't
+	 * clear rseq_cs pointer.
+	 * Otherwise, clear the rseq_cs pointer and return.
 	 */
-	if (!in_rseq_cs(ip, &rseq_cs))
-		return clear_rseq_cs(t);
+	if (!in_rseq_cs(ip, &rseq_cs)) {
+		u32 flags;
+
+		ret = get_user(flags, &t->rseq->flags);
+		if (ret)
+			return ret;
+		if (flags & RSEQ_CS_FLAG_IN_SIGNAL_HANDLER)
+			return 0;
+		else
+			return clear_rseq_cs(t);
+	}
+
 	ret = rseq_need_restart(t, rseq_cs.flags);
 	if (ret <= 0)
 		return ret;
@@ -322,6 +352,46 @@ void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+#ifdef CONFIG_RSEQ
+
+int rseq_sigreturn(struct pt_regs *regs)
+{
+	int ret;
+	struct rseq_cs rseq_cs;
+	struct task_struct *t = current;
+
+	if (t->rseq) {
+		u32 flags;
+
+		ret = get_user(flags, &t->rseq->flags);
+		if (ret)
+			return ret;
+
+		if (flags & RSEQ_CS_FLAG_IN_SIGNAL_HANDLER) {
+			ret = rseq_get_rseq_cs(t, &rseq_cs);
+			if (ret)
+				return ret;
+
+			/*
+			 * If the returned IP is in critical section, it
+			 * means we handle all the possible nested signal,
+			 * so unset the RSEQ_CS_FLAG_IN_SIGNAL_HANDLER.
+			 */
+			if (in_rseq_cs(regs->ip, &rseq_cs)) {
+				flags &= ~RSEQ_CS_FLAG_IN_SIGNAL_HANDLER;
+
+				ret = put_user(flags, &t->rseq->flags);
+				if (ret)
+					return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+#endif
+
 /*
  * sys_rseq - setup restartable sequences for caller thread.
  */
-- 
2.25.1

