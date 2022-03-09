Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29714D31C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiCIP3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiCIP2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:28:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F53639D;
        Wed,  9 Mar 2022 07:27:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BE0761484;
        Wed,  9 Mar 2022 15:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232A0C340F4;
        Wed,  9 Mar 2022 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646839672;
        bh=dMyKNU+Scbf5e52FtlBwSub/ypQq2YlPR+76ClMuaOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=qGYYXwoPPFA4rg/tQyuIOHGgfyu3Zh6qkActnqaf4KFRDWw3iIHCsRF6J5b7IzUbn
         Fvu8c3ft9ncamXs4h6BM3zMsoKhnp00AJcmZWUwxFDtA2tql6e0uYwF/cgNpOsK4R4
         XqAVuORthA5ku+O17BCY8r1xGmlqS3USRdnG3/c1oTNh1Ug2H9bileMRqSPpXBEWzg
         ObdP9a+MGwGW2FjUwLTuHf0Gz+5TmiFVF3Af32iLP0AYHY35a2F5aC6NQDLbj3QI5J
         YAvnqXKsq4kCiizQs4LyzrRA7QuC/lhP2ow46gb33Is2CA2ZEnOZWvHJ/K7Ii4+dZ6
         Lvb9yHi6D1kJQ==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH RT 1/3] eventfd: Make signal recursion protection a task bit
Date:   Wed,  9 Mar 2022 09:27:46 -0600
Message-Id: <ac8b2b7899cf6724d0798ee8ca68066713fc351b.1646839649.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1646839649.git.zanussi@kernel.org>
References: <cover.1646839649.git.zanussi@kernel.org>
In-Reply-To: <cover.1646839649.git.zanussi@kernel.org>
References: <cover.1646839649.git.zanussi@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

v5.4.182-rt71-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit b542e383d8c005f06a131e2b40d5889b812f19c6 ]

The recursion protection for eventfd_signal() is based on a per CPU
variable and relies on the !RT semantics of spin_lock_irqsave() for
protecting this per CPU variable. On RT kernels spin_lock_irqsave() neither
disables preemption nor interrupts which allows the spin lock held section
to be preempted. If the preempting task invokes eventfd_signal() as well,
then the recursion warning triggers.

Paolo suggested to protect the per CPU variable with a local lock, but
that's heavyweight and actually not necessary. The goal of this protection
is to prevent the task stack from overflowing, which can be achieved with a
per task recursion protection as well.

Replace the per CPU variable with a per task bit similar to other recursion
protection bits like task_struct::in_page_owner. This works on both !RT and
RT kernels and removes as a side effect the extra per CPU storage.

No functional change for !RT kernels.

Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/87wnp9idso.ffs@tglx

Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	fs/aio.c
	include/linux/sched.h
---
 fs/aio.c                |  2 +-
 fs/eventfd.c            | 12 +++++-------
 include/linux/eventfd.h | 11 +++++------
 include/linux/sched.h   | 12 ++++++++++++
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index fb92c32a6f1e..db21ca695781 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1767,7 +1767,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del_init(&req->wait.entry);
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
+		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 78e41c7c3d05..661ccc45852b 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -24,8 +24,6 @@
 #include <linux/seq_file.h>
 #include <linux/idr.h>
 
-DEFINE_PER_CPU(int, eventfd_wake_count);
-
 static DEFINE_IDA(eventfd_ida);
 
 struct eventfd_ctx {
@@ -66,21 +64,21 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * Deadlock or stack overflow issues can happen if we recurse here
 	 * through waitqueue wakeup handlers. If the caller users potentially
 	 * nested waitqueues with custom wakeup handlers, then it should
-	 * check eventfd_signal_count() before calling this function. If
-	 * it returns true, the eventfd_signal() call should be deferred to a
+	 * check eventfd_signal_allowed() before calling this function. If
+	 * it returns false, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(current->in_eventfd_signal))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	this_cpu_inc(eventfd_wake_count);
+	current->in_eventfd_signal = 1;
 	if (ULLONG_MAX - ctx->count < n)
 		n = ULLONG_MAX - ctx->count;
 	ctx->count += n;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	this_cpu_dec(eventfd_wake_count);
+	current->in_eventfd_signal = 0;
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 
 	return n;
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index dc4fd8a6644d..836b4c021a0a 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/percpu-defs.h>
 #include <linux/percpu.h>
+#include <linux/sched.h>
 
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
@@ -42,11 +43,9 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
 				  __u64 *cnt);
 
-DECLARE_PER_CPU(int, eventfd_wake_count);
-
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_allowed(void)
 {
-	return this_cpu_read(eventfd_wake_count);
+	return !current->in_eventfd_signal;
 }
 
 #else /* CONFIG_EVENTFD */
@@ -77,9 +76,9 @@ static inline int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx,
 	return -ENOSYS;
 }
 
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_allowed(void)
 {
-	return false;
+	return true;
 }
 
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 79e34e98f812..e1dfb01f4623 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -802,6 +802,18 @@ struct task_struct {
 	/* to be used once the psi infrastructure lands upstream. */
 	unsigned			use_memdelay:1;
 #endif
+#ifdef CONFIG_PSI
+	/* Stalled due to lack of memory */
+	unsigned			in_memstall:1;
+#endif
+#ifdef CONFIG_PAGE_OWNER
+	/* Used by page_owner=on to detect recursion in page tracking. */
+	unsigned			in_page_owner:1;
+#endif
+#ifdef CONFIG_EVENTFD
+	/* Recursion prevention for eventfd_signal() */
+	unsigned			in_eventfd_signal:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
-- 
2.17.1

