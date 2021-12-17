Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF3C4788FA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhLQKc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbhLQKcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:32:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0342C06173F;
        Fri, 17 Dec 2021 02:32:22 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639737141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcsZgKvhQhbNuvqvVY2U//4ZClIou7+A9xVPA3yEvPI=;
        b=YTSubYE4uaDslTZwh55oUxp91bNIi1A0izag9UjO/QDim3HdzEFKe0XWdlPC0WXRqxwtcn
        2iMtNkfE0/D024wVCooxTTZoC3+RMzcJo1ikNv6/Ay2odghbPW1lZgBiXlpLNwcjBDVOGF
        3F2E/81JyhI06V8/jQfFAmzSWxsqwqsIqFcAYg4AeynCHHTyPa+RL2lg2ppggx7tpqL7lc
        /I3J5+zTqP+HHP2ENfUplWzPUAVt64IjRdVJn3Eu1q52vkScQsrnDJZDqQfqfN4baxdIzw
        9YYJONxTZU/RYC2S2fbt44DdYb6xT4tpSapPy4HjTSJEk5o8S4oMuQxF+QLg8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639737141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcsZgKvhQhbNuvqvVY2U//4ZClIou7+A9xVPA3yEvPI=;
        b=0x19I31Ladf9yTS7zRuEOixy4Bd7SHtOhxu+gb95ULF+dfKkDKuL/98mPFsh2HxL/Ksun+
        qUjLXYFyETuahuDw==
To:     fcarli@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        stable-rt@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] eventfd: Make signal recursion protection a task bit
Date:   Fri, 17 Dec 2021 11:32:09 +0100
Message-Id: <20211217103209.1122679-3-bigeasy@linutronix.de>
In-Reply-To: <20211217103209.1122679-1-bigeasy@linutronix.de>
References: <CAJuRqcAc19KZYik7T_dYFoqt_wX4QPHKBsh9A8BJwYE7uxs_1A@mail.gmail.com>
 <20211217103209.1122679-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Upstream commit b542e383d8c005f06a131e2b40d5889b812f19c6

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
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/aio.c                |  2 +-
 fs/eventfd.c            | 12 +++++-------
 include/linux/eventfd.h | 11 +++++------
 include/linux/sched.h   |  4 ++++
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 76ce0cc3ee4ec..51b08ab01dffc 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wai=
t, unsigned mode, int sync,
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res =3D mangle_poll(mask);
 		req->done =3D true;
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
+		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
 			iocb =3D NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
diff --git a/fs/eventfd.c b/fs/eventfd.c
index df466ef81dddf..9035ca60bfcf3 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -25,8 +25,6 @@
 #include <linux/idr.h>
 #include <linux/uio.h>
=20
-DEFINE_PER_CPU(int, eventfd_wake_count);
-
 static DEFINE_IDA(eventfd_ida);
=20
 struct eventfd_ctx {
@@ -67,21 +65,21 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
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
=20
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	this_cpu_inc(eventfd_wake_count);
+	current->in_eventfd_signal =3D 1;
 	if (ULLONG_MAX - ctx->count < n)
 		n =3D ULLONG_MAX - ctx->count;
 	ctx->count +=3D n;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	this_cpu_dec(eventfd_wake_count);
+	current->in_eventfd_signal =3D 0;
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
=20
 	return n;
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index dc4fd8a6644dd..836b4c021a0a4 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/percpu-defs.h>
 #include <linux/percpu.h>
+#include <linux/sched.h>
=20
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
@@ -42,11 +43,9 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entr=
y_t *wait,
 				  __u64 *cnt);
=20
-DECLARE_PER_CPU(int, eventfd_wake_count);
-
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_allowed(void)
 {
-	return this_cpu_read(eventfd_wake_count);
+	return !current->in_eventfd_signal;
 }
=20
 #else /* CONFIG_EVENTFD */
@@ -77,9 +76,9 @@ static inline int eventfd_ctx_remove_wait_queue(struct ev=
entfd_ctx *ctx,
 	return -ENOSYS;
 }
=20
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_allowed(void)
 {
-	return false;
+	return true;
 }
=20
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 409a24036952c..29e6ff1af1df9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -852,6 +852,10 @@ struct task_struct {
 	/* Stalled due to lack of memory */
 	unsigned			in_memstall:1;
 #endif
+#ifdef CONFIG_EVENTFD
+	/* Recursion prevention for eventfd_signal() */
+	unsigned			in_eventfd_signal:1;
+#endif
=20
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
=20
--=20
2.34.1

