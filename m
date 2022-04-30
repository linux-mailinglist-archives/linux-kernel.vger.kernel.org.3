Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D68515F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 19:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbiD3RQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 13:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbiD3RQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:16:19 -0400
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [221.12.31.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCA84EDEC
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 10:12:55 -0700 (PDT)
Received: from mail.maildlp.com ([172.25.15.154])
        by h3cspam02-ex.h3c.com with ESMTP id 23UHCKSx084346;
        Sun, 1 May 2022 01:12:20 +0800 (GMT-8)
        (envelope-from zushuzhi@h3c.com)
Received: from DAG2EX04-BASE.srv.huawei-3com.com (unknown [10.8.0.67])
        by mail.maildlp.com (Postfix) with ESMTP id 215DA2221BC4;
        Sun,  1 May 2022 01:14:32 +0800 (CST)
Received: from localhost.localdomain (10.99.222.162) by
 DAG2EX04-BASE.srv.huawei-3com.com (10.8.0.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 1 May 2022 01:12:24 +0800
From:   Shuzhi Zu <zushuzhi@h3c.com>
To:     <brauner@kernel.org>, <oleg@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Shuzhi Zu <zushuzhi@h3c.com>
Subject: [PATCH] signal/ptrace: Fix the bug of ptrace attach and signal handling concurrency
Date:   Sun, 1 May 2022 00:55:56 +0800
Message-ID: <20220430165556.29739-1-zushuzhi@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.99.222.162]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX04-BASE.srv.huawei-3com.com (10.8.0.67)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 23UHCKSx084346
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ptrace attach and signal handling are concurrent, it will cause the
state of all threads of the traced process to become stopped and trace
pid is 0.

The thread dequeues the signal from the queue and another thread traces
the thread while the signal has not been handled or when non-real-time
signals less than SIGSTOP and a SIGSTOP signal are in the signal pending
queue at the same time, these two cases will cause all threads of the
process to be stopped. Therefore, when ptrace_attach modifying the task
ptrace value of the thread, it is necessary to lock. Except for synchronous
signals, SIGSTOP signal should be handled before non-real-time signals.

Example: Thread A is the traced thread. Thread B is the tracer.
1.Thread A dequeues the SIGCHLD signal, before it is handled, thread B
executes ptrace attach A, and A's ptrace is assigned PT_PTRACED. Then the
SIGCHLD signal processing will go to the ptrace_signal function。Thread A
becomes traced. Thread B continues to execute ptrace_detach after the
execution of waitpid returns. A thread ptrace value is set to 0 and
it is woken up. Thread A continues to process the SIGSTOP signal, causing
all threads of the process to be stopped.
2. Thread A ptrace is assigned PT_PTRACED by ptrace attach, and both
SIGPIPE and SIGSTOP signals exist in the pending queue of thread A.
Because the value of SIGPIPE is less than SIGSTOP, SIGSPIPE is handled
first, which will result in a timing similar to Example 1。

Example 1：
    A                             B
    get_signal
    dequeue_signal (SIGCHLD）
                                  ptrace_attach ( A->ptrace |= PT_PTRACED)

    ptrace_signal
    ->ptrace_stop(TASK_TRACED)
                                  ptrace_attach ( Send SIGSTOP to A)
                                  ptrace_waitpid( return 0)
                                  ptrace_detach (A->ptrace=0, wakeup A)
    dequeue_signal(SIGSTOP)
    sig_kernel_stop(SIGSTOP)
    do_signal_stop (TASK_STOPPED)

then：
A (other threads of the process received signal)
get_signal-> do_signal_stop(0))->TASK_STOPPED

Example 2：
    A                             B
    send_sig(SIGPIPE, current, 0)
                                  ptrace_attach ( A->ptrace |= PT_PTRACED)
                                  ptrace_attach ( Send SIGSTOP to A)
    get_signal
    dequeue_signal (SIGPIPE)
    ptrace_signal
    ->ptrace_stop(TASK_TRACED)

                                  ptrace_waitpid( return 0)
                                  ptrace_detach (A->ptrace=0, wakeup A)
    dequeue_signal(SIGSTOP)
    sig_kernel_stop(SIGSTOP)
    do_signal_stop (TASK_STOPPED)

then：
A (other threads of the process received signal)
get_signal-> do_signal_stop(0))->TASK_STOPPED

Signed-off-by: Shuzhi Zu <zushuzhi@h3c.com>
---
 kernel/ptrace.c | 2 ++
 kernel/signal.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index ccc4b46..ab1dc8f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -447,7 +447,9 @@ static int ptrace_attach(struct task_struct *task, long request,
 	if (task->ptrace)
 		goto unlock_tasklist;
 
+	spin_lock(&task->sighand->siglock);
 	task->ptrace = flags;
+	spin_unlock(&task->sighand->siglock);
 
 	ptrace_link(task, current);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 30cd1ca..522bc6e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -220,6 +220,8 @@ int next_signal(struct sigpending *pending, sigset_t *mask)
 	if (x) {
 		if (x & SYNCHRONOUS_MASK)
 			x &= SYNCHRONOUS_MASK;
+		else if (x & sigmask(SIGSTOP))
+			x &= sigmask(SIGSTOP);
 		sig = ffz(~x) + 1;
 		return sig;
 	}
-- 
1.8.3.1

