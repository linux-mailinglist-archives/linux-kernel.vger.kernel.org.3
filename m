Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDDA4D98AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347080AbiCOK0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347061AbiCOK0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:26:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8976D45509
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:24:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 46B011F391;
        Tue, 15 Mar 2022 10:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647339892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oM8P4U/YzWHvHTnC2VlxJDlrb2nKnNFscDRcX24QZ1M=;
        b=ab6m1HZJAk1qWZyBqp+EL6uUhL6g46Zz4Yd9J+MjGIEBR+9MkH+lasBgiQ7uyyUkPFG7wT
        r3B4sh5I8Mt4OzKs/Tftf6qI+3g6F+5Rc/+KEIU87EpL2qs5U+0DvAztbGFc9AHKhuBPai
        YJoI7M6FpwinUj/q9N/TXQ7dJkS1JkE=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id 87CA8A3B88;
        Tue, 15 Mar 2022 10:24:51 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2] kthread: Make it clear that kthread_create_on_node() might be terminated by any fatal signal
Date:   Tue, 15 Mar 2022 11:24:44 +0100
Message-Id: <20220315102444.2380-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments in kernel/kthread.c create a feeling that only SIGKILL
is able to terminate the creation of kernel kthreads by
kthread_create()/_on_node()/_on_cpu() APIs.

In reality, wait_for_completion_killable() might be killed by any
fatal signal that does not have a custom handler:

	(!siginmask(signr, SIG_KERNEL_IGNORE_MASK|SIG_KERNEL_STOP_MASK) && \
	 (t)->sighand->action[(signr)-1].sa.sa_handler == SIG_DFL)

static inline void signal_wake_up(struct task_struct *t, bool resume)
{
	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
}

static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
{
[...]
	/*
	 * Found a killable thread.  If the signal will be fatal,
	 * then start taking the whole group down immediately.
	 */
	if (sig_fatal(p, sig) ...) {
		if (!sig_kernel_coredump(sig)) {
		[...]
			do {
				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
				sigaddset(&t->pending.signal, SIGKILL);
				signal_wake_up(t, 1);
			} while_each_thread(p, t);
			return;
		}
	}
}

Update the comments in kernel/kthread.c to make this more obvious.

The motivation for this change was debugging why a module initialization
failed. The module was being loaded from initrd. It "magically" failed
when systemd was switching to the real root. The clean up operations
sent SIGTERM to various pending processed that were started from initrd.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
Changes against v1:

+ Fix the commit message to make it clear that the signal is sent
  to the public API caller and not the helper kthread [Eric]

+ Added Reviewed-by from Eric.

 kernel/kthread.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 38c6dd822da8..6f994c354adb 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -341,7 +341,7 @@ static int kthread(void *_create)
 
 	self = to_kthread(current);
 
-	/* If user was SIGKILLed, I release the structure. */
+	/* Release the structure when caller killed by a fatal signal. */
 	done = xchg(&create->done, NULL);
 	if (!done) {
 		kfree(create);
@@ -399,7 +399,7 @@ static void create_kthread(struct kthread_create_info *create)
 	/* We want our own signal handler (we take no signals by default). */
 	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
 	if (pid < 0) {
-		/* If user was SIGKILLed, I release the structure. */
+		/* Release the structure when caller killed by a fatal signal. */
 		struct completion *done = xchg(&create->done, NULL);
 
 		if (!done) {
@@ -441,9 +441,9 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	 */
 	if (unlikely(wait_for_completion_killable(&done))) {
 		/*
-		 * If I was SIGKILLed before kthreadd (or new kernel thread)
-		 * calls complete(), leave the cleanup of this structure to
-		 * that thread.
+		 * If I was killed by a fatal signal before kthreadd (or new
+		 * kernel thread) calls complete(), leave the cleanup of this
+		 * structure to that thread.
 		 */
 		if (xchg(&create->done, NULL))
 			return ERR_PTR(-EINTR);
@@ -877,7 +877,7 @@ __kthread_create_worker(int cpu, unsigned int flags,
  *
  * Returns a pointer to the allocated worker on success, ERR_PTR(-ENOMEM)
  * when the needed structures could not get allocated, and ERR_PTR(-EINTR)
- * when the worker was SIGKILLed.
+ * when the caller was killed by a fatal signal.
  */
 struct kthread_worker *
 kthread_create_worker(unsigned int flags, const char namefmt[], ...)
@@ -926,7 +926,7 @@ EXPORT_SYMBOL(kthread_create_worker);
  * Return:
  * The pointer to the allocated worker on success, ERR_PTR(-ENOMEM)
  * when the needed structures could not get allocated, and ERR_PTR(-EINTR)
- * when the worker was SIGKILLed.
+ * when the caller was killed by a fatal signal.
  */
 struct kthread_worker *
 kthread_create_worker_on_cpu(int cpu, unsigned int flags,
-- 
2.26.2

