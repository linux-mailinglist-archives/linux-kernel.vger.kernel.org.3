Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821B455DA10
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbiF0O5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiF0O5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:57:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB3E17A82
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:57:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CE7DB81851
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E50C3411D;
        Mon, 27 Jun 2022 14:57:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KZbTn82t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656341844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvBOHidW14C5SbscgVMeXZF4furaNMFe21DCdOydfxY=;
        b=KZbTn82tKYOESC1i/vIwkmATYPLjpYQBqMjmT2+CkpuC9EZMWL2kED5VvDsCZbcMeZaxmj
        D9jAYcny+gYEKgr8AdOdtbu1p/5RRQBuFhP9GpkNVScLCpSpb7FWUFmKoycIGtJXZNSvJF
        d+vlKDZGZbkkNYHF+aZdEluITXW3DKQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f8c882a2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 27 Jun 2022 14:57:23 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] signal: break out of wait loops on kthread_stop()
Date:   Mon, 27 Jun 2022 16:57:16 +0200
Message-Id: <20220627145716.641185-1-Jason@zx2c4.com>
In-Reply-To: <YrnEvjcG8tmF3dRV@zx2c4.com>
References: <YrnEvjcG8tmF3dRV@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was recently surprised to learn that msleep_interruptible(),
wait_for_completion_interruptible_timeout(), and related functions
simply hung when I called kthread_stop() on kthreads using them. The
solution to fixing the case with msleep_interruptible() was more simply
to move to schedule_timeout_interruptible(). Why?

The reason is that msleep_interruptible(), and many functions just like
it, has a loop like this:

        while (timeout && !signal_pending(current))
                timeout = schedule_timeout_interruptible(timeout);

The call to kthread_stop() woke up the thread, so schedule_timeout_
interruptible() returned early, but because signal_pending() returned
true, it went back into another timeout, which was never woken up.

This wait loop pattern is common to various pieces of code, and I
suspect that subtle misuse in a kthread that caused a deadlock in the
code I looked at last week is also found elsewhere.

So this commit causes signal_pending() to return true when
kthread_stop() is called. This is already what's done for
TIF_NOTIFY_SIGNAL, for these same purposes of breaking out of wait
loops, so a similar KTHREAD_SHOULD_STOP check isn't too much different.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/kthread.h      | 1 +
 include/linux/sched/signal.h | 9 +++++++++
 kernel/kthread.c             | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 30e5bec81d2b..7061dde23237 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -87,6 +87,7 @@ void kthread_bind(struct task_struct *k, unsigned int cpu);
 void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
 int kthread_stop(struct task_struct *k);
 bool kthread_should_stop(void);
+bool __kthread_should_stop(struct task_struct *k);
 bool kthread_should_park(void);
 bool __kthread_should_park(struct task_struct *k);
 bool kthread_freezable_should_stop(bool *was_frozen);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index cafbe03eed01..08700c65b806 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -11,6 +11,7 @@
 #include <linux/refcount.h>
 #include <linux/posix-timers.h>
 #include <linux/mm_types.h>
+#include <linux/kthread.h>
 #include <asm/ptrace.h>
 
 /*
@@ -397,6 +398,14 @@ static inline int signal_pending(struct task_struct *p)
 	 */
 	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
 		return 1;
+
+	/*
+	 * Likewise, KTHREAD_SHOULD_STOP isn't really a signal, but it also
+	 * requires the same behavior, lest wait loops go forever.
+	 */
+	if (unlikely(__kthread_should_stop(p)))
+		return 1;
+
 	return task_sigpending(p);
 }
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3c677918d8f2..80f6ba323060 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -145,6 +145,14 @@ void free_kthread_struct(struct task_struct *k)
 	kfree(kthread);
 }
 
+bool __kthread_should_stop(struct task_struct *k)
+{
+	struct kthread *kthread = __to_kthread(k);
+
+	return kthread && test_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
+}
+EXPORT_SYMBOL_GPL(__kthread_should_stop);
+
 /**
  * kthread_should_stop - should this kthread return now?
  *
-- 
2.35.1

