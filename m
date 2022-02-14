Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4D84B5D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiBNVij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:38:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiBNVif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:38:35 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99A616BF92
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:38:25 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g1so11681521pfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pq1P/Cof9Gylq8mnpWk5wPnnRWgsYpfEIvhmaGs+3NY=;
        b=DINj1/D7bfZFoFjwAf6oVtjFjutpduNRfGk/HKmLRpSf7kbN9JJqlEHzyY4GOW1XPW
         TXbW9VqexLE2ujIVFuLYMUfewQI1jy57hDDfZvCo+cpkrWZrJ2gYU29fxE79FidigWXi
         oIb99gdChpqqKxEu51S5x/Oma0a+Nm1DuEaK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pq1P/Cof9Gylq8mnpWk5wPnnRWgsYpfEIvhmaGs+3NY=;
        b=t8jhcSMNBCo+bV9/OgYDBeM2hi2dfwZfef7E8fYAyUq/t5MOM4Qk0EU0yFI3UmW/TW
         IX290U6cD4SUXZ8ter4qbvtnEC1uDo91/E8YGWQ5haew4YgAApJr+P66UABBC1WCBO1t
         qNkbq5sEWE+gjuz32CH1+Nyw0VtOxZgC6qqwbPgW24fo2gTaLrJrbEJoeUUvJlVwE2dx
         xaTeKtKiQ/YaLo4fgQWEJNBcLxFS8T0VQVwve8uz4ApTvY4rP29ewzwd4PpFpqL2kikK
         GaeISQ4viI1ddQzGAfAZ+j1CHA6as8STxbFBTn1q5nswLSv8mtEnaET3zYWxa9hU1kjs
         57cw==
X-Gm-Message-State: AOAM53211pDwIJVn+7kOgu0Ev0GQs1MwtJlTMUV3mISurGaJAcBEo+D+
        QZtUpCsSlQsvab4sTRxgdZ57EQ==
X-Google-Smtp-Source: ABdhPJxWmXP56koW3U1FMm+dAJ1j4j9ft8EMdK8tWGHi2ttWGwZHiiB1gbntfPki+7e2/eUkPIcOJg==
X-Received: by 2002:a63:8542:: with SMTP id u63mr855351pgd.210.1644874705505;
        Mon, 14 Feb 2022 13:38:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d9sm3584185pfl.45.2022.02.14.13.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:38:25 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        =?UTF-8?q?Robert=20=C5=9Awi=C4=99cki?= <robert@swiecki.net>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] exit: Introduce __WCHILDSIGINFO for waitid
Date:   Mon, 14 Feb 2022 13:38:22 -0800
Message-Id: <20220214213823.3297816-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214213823.3297816-1-keescook@chromium.org>
References: <20220214213823.3297816-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4663; h=from:subject; bh=/iJq5z6soSI5EIzLawUNPbFJHdzf+7GBNkasBhsfuI8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiCsvOPn66wWh67KRCowZrZcr9oGEb+oXU/I37c49O b7mRKGKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgrLzgAKCRCJcvTf3G3AJvwZEA CCDu8ycavm6b5yfKOmBlinx+TwMRLLtqomBKUg35Y9ObSw94obSXBpBQr3OOKJNbC19AqK1TZoy7rl UZDhsI015GETY6rxtiIuWAQxlxVi0OkF6bly2OHCPteAc1GWy9nlUr78bSKzk8/8RJFMUaW9+xGJfU f96jKh8VQ4JDwySWUaIf+eQUPlZBwhUeIh2nkJt7yDGHYx4T8y/CFYsDZhHVc+WDye51YmPiXovQLc z1g9pI1qLFffENeemuHX78msBvpT03Iuep9E3mjPqbhIK528e3RL/XTXsWitncCT/OBDoVlHgdrygv QWyVuHeSHNZDtybcDL8A6nJNl2HeUQYWyVCItx7uE99GgPgfqVKwHrS5R6p2ekarN/AJ9OfKU09LKG u4XHh7DKXMQ0RAAWP9/XCMmszqqXyHVGzfiFA97EltxTqAIuA01h33I4gdubaXv3IuiIm8kmXS86mb lGr+8u0JuDVAPXjTXZ0Q4adPM+wIuearmaa3bcpCZxrYiJ0tkZtiiIZK9hi8e5cPIN76rKB3dMYcIB eO0WXhLsA8oTBI1wyySpT9Q9XzkcrElOxZ0tNBM+2Thvhpb2vQzyRo2D/1Zxfov/9vR1ZAafsTaln6 3bWrsJvTeY9m9f7xGIuKNfR0zN5EVzpe/Z5c4ZkSGvQlubG1Rkspg2VVQemg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When __WCHILDSIGINFO is specified, copy the child's siginfo into the
waitid infop instead of constructing the parent's SIGCHLD perspective.

Cc: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: "Robert Święcki" <robert@swiecki.net>
Cc: Jann Horn <jannh@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-api@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/sched.h     |  1 +
 include/uapi/linux/wait.h |  1 +
 kernel/exit.c             | 23 +++++++++++++++++++----
 kernel/signal.c           |  4 ++++
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f5b2be39a78c..e40789e801ef 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1178,6 +1178,7 @@ struct task_struct {
 #endif
 	/* Ptrace state: */
 	unsigned long			ptrace_message;
+	kernel_siginfo_t		death_siginfo;
 	kernel_siginfo_t		*last_siginfo;
 
 	struct task_io_accounting	ioac;
diff --git a/include/uapi/linux/wait.h b/include/uapi/linux/wait.h
index 85b809fc9f11..7258cd4510ba 100644
--- a/include/uapi/linux/wait.h
+++ b/include/uapi/linux/wait.h
@@ -9,6 +9,7 @@
 #define WCONTINUED	0x00000008
 #define WNOWAIT		0x01000000	/* Don't reap, just poll status.  */
 
+#define __WCHILDSIGINFO	0x10000000	/* Report child's siginfo. */
 #define __WNOTHREAD	0x20000000	/* Don't wait on children of other threads in this group */
 #define __WALL		0x40000000	/* Wait on all children, regardless of type */
 #define __WCLONE	0x80000000	/* Wait only on non-SIGCHLD children */
diff --git a/kernel/exit.c b/kernel/exit.c
index b00a25bb4ab9..de6e024976c6 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -953,6 +953,7 @@ struct waitid_info {
 	uid_t uid;
 	int status;
 	int cause;
+	kernel_siginfo_t siginfo;
 };
 
 struct wait_opts {
@@ -964,7 +965,7 @@ struct wait_opts {
 	int			wo_stat;
 	struct rusage		*wo_rusage;
 
-	wait_queue_entry_t		child_wait;
+	wait_queue_entry_t	child_wait;
 	int			notask_error;
 };
 
@@ -1012,11 +1013,16 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 	int state, status;
 	pid_t pid = task_pid_vnr(p);
 	uid_t uid = from_kuid_munged(current_user_ns(), task_uid(p));
-	struct waitid_info *infop;
+	struct waitid_info *infop = wo->wo_info;
 
 	if (!likely(wo->wo_flags & WEXITED))
 		return 0;
 
+	/* Before WNOWAIT so a copy can be extracted without reaping. */
+	if (unlikely(wo->wo_flags & __WCHILDSIGINFO)) {
+		if (infop && p->last_siginfo)
+			copy_siginfo(&infop->siginfo, p->last_siginfo);
+	}
 	if (unlikely(wo->wo_flags & WNOWAIT)) {
 		status = (p->signal->flags & SIGNAL_GROUP_EXIT)
 			? p->signal->group_exit_code : p->exit_code;
@@ -1121,7 +1127,6 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 		release_task(p);
 
 out_info:
-	infop = wo->wo_info;
 	if (infop) {
 		if ((status & 0x7f) == 0) {
 			infop->cause = CLD_EXITED;
@@ -1564,7 +1569,7 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 	unsigned int f_flags = 0;
 
 	if (options & ~(WNOHANG|WNOWAIT|WEXITED|WSTOPPED|WCONTINUED|
-			__WNOTHREAD|__WCLONE|__WALL))
+			__WNOTHREAD|__WCLONE|__WALL|__WCHILDSIGINFO))
 		return -EINVAL;
 	if (!(options & (WEXITED|WSTOPPED|WCONTINUED)))
 		return -EINVAL;
@@ -1637,6 +1642,10 @@ SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
 	if (!infop)
 		return err;
 
+	/* __WCHILDSIGINFO */
+	if (info.siginfo.si_signo)
+		return copy_siginfo_to_user(infop, &info.siginfo);
+
 	if (!user_write_access_begin(infop, sizeof(*infop)))
 		return -EFAULT;
 
@@ -1780,6 +1789,12 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 	if (!infop)
 		return err;
 
+	/* __WCHILDSIGINFO */
+	if (info.siginfo.si_signo)
+		return copy_siginfo_to_user32(
+				(struct compat_siginfo __user *)infop,
+				&info.siginfo);
+
 	if (!user_write_access_begin(infop, sizeof(*infop)))
 		return -EFAULT;
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 9b04631acde8..41f6ba6b7aa7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2825,6 +2825,10 @@ bool get_signal(struct ksignal *ksig)
 		}
 
 	fatal:
+		/* Allow siginfo to be queried until reaped. */
+		copy_siginfo(&current->death_siginfo, &ksig->info);
+		current->last_siginfo = &current->death_siginfo;
+
 		spin_unlock_irq(&sighand->siglock);
 		if (unlikely(cgroup_task_frozen(current)))
 			cgroup_leave_frozen(true);
-- 
2.30.2

