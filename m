Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DE2466140
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354959AbhLBKQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbhLBKQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:16:44 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07CFC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:13:21 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id r2-20020adfe682000000b00198af042b0dso4875307wrm.23
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 02:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8N5RdsPFCDQOOr5Z+B7VY5Dmo/Ijqkz2fn7CLWsbo/s=;
        b=F3VmtU6AQKt4NMnuBp/weYOHYOaxN3ze5nfUY+yy5JW/8254HRTDEvIt1FD4xlo/Bn
         4/iwSB+yX/eZwJiT1AUHRRBmt1oi11zKx/lM1+PeQbP72+aM5UvM5ZzzqWSO01Xj+1th
         CU9PA7roV7oiT/pZv8YY8L2P7Jf2OxoCi8hTRZExrBNRI5Oc+V2yVF9pCLekQLxRUCK8
         KRdDhJ3iMBCtIAtoWC2uVeJkoH7FKVNygm66KFs+AEXn+3Q14ZdENwzaiAljYjtEkHdg
         qCFzj5eqO+0yYPNlou9kV0Nh4Y3GuhpLXGozBYv1oAKdb/cZ9mWIZbKKCGAg7uk6MQn3
         aqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8N5RdsPFCDQOOr5Z+B7VY5Dmo/Ijqkz2fn7CLWsbo/s=;
        b=PseF+IEKYMSxy4dvzmIpIvXA+ZJUr2ObMSQXMjTNAyYMSC7WxhbwS6QMYXPKACp5xx
         Ad+adOGR5hENofudgh03X0Cfw6iaUlANEWx1waHXeBkeJ9Ldz5rjujP2sSBM15Iu/mWC
         v4wq4rbea7B3UsoitmpjkpFO6R0xIOs4+BQmip/mg+yuRMQ+t3WNYdjXL5tM82lmyQWB
         qNYLic1SXWJVS7nXG+eRuMhUk1d9sKKvDYvZSYiOGYbPb66rRUCil4VPXW17Tij+SrCK
         qpvUeMjyKmCAw0URm1oWlKxb7zV28uGz1Pr+VR7lC367/vIzrnbWGTkOkPF3CUu/7Gep
         2pHQ==
X-Gm-Message-State: AOAM533uu726rScqsiAXfp4Vvh2s7AKzPigGYa3UmeJDsBrsPWh5gg39
        5w1vhaSZ3Da6EGUvIiJ9hcSiBzCHNg==
X-Google-Smtp-Source: ABdhPJzWAXSrgLXPWbu8YK3Y8FIdNsUhvHZebQe9PrO9hqNDDxBD9Ytzzqel3TAvUdiXANuuUyRLAHlHKg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:ddd6:f3c9:b2f0:82f3])
 (user=elver job=sendgmr) by 2002:a5d:4e0b:: with SMTP id p11mr13212204wrt.88.1638440000442;
 Thu, 02 Dec 2021 02:13:20 -0800 (PST)
Date:   Thu,  2 Dec 2021 11:12:38 +0100
Message-Id: <20211202101238.33546-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] locking/mutex: Mark racy reads of owner->on_cpu
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kasan-dev@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more frequent data races reported by KCSAN is the racy read
in mutex_spin_on_owner(), which is usually reported as "race of unknown
origin" without showing the writer. This is due to the racing write
occurring in kernel/sched. Locally enabling KCSAN in kernel/sched shows:

 | write (marked) to 0xffff97f205079934 of 4 bytes by task 316 on cpu 6:
 |  finish_task                kernel/sched/core.c:4632 [inline]
 |  finish_task_switch         kernel/sched/core.c:4848
 |  context_switch             kernel/sched/core.c:4975 [inline]
 |  __schedule                 kernel/sched/core.c:6253
 |  schedule                   kernel/sched/core.c:6326
 |  schedule_preempt_disabled  kernel/sched/core.c:6385
 |  __mutex_lock_common        kernel/locking/mutex.c:680
 |  __mutex_lock               kernel/locking/mutex.c:740 [inline]
 |  __mutex_lock_slowpath      kernel/locking/mutex.c:1028
 |  mutex_lock                 kernel/locking/mutex.c:283
 |  tty_open_by_driver         drivers/tty/tty_io.c:2062 [inline]
 |  ...
 |
 | read to 0xffff97f205079934 of 4 bytes by task 322 on cpu 3:
 |  mutex_spin_on_owner        kernel/locking/mutex.c:370
 |  mutex_optimistic_spin      kernel/locking/mutex.c:480
 |  __mutex_lock_common        kernel/locking/mutex.c:610
 |  __mutex_lock               kernel/locking/mutex.c:740 [inline]
 |  __mutex_lock_slowpath      kernel/locking/mutex.c:1028
 |  mutex_lock                 kernel/locking/mutex.c:283
 |  tty_open_by_driver         drivers/tty/tty_io.c:2062 [inline]
 |  ...
 |
 | value changed: 0x00000001 -> 0x00000000

This race is clearly intentional, and the potential for miscompilation
is slim due to surrounding barrier() and cpu_relax(), and the value
being used as a boolean.

Nevertheless, marking this reader would more clearly denote intent and
make it obvious that concurrency is expected. Use READ_ONCE() to avoid
having to reason about compiler optimizations now and in future.

Similarly, mark the read to owner->on_cpu in mutex_can_spin_on_owner(),
which immediately precedes the loop executing mutex_spin_on_owner().

Signed-off-by: Marco Elver <elver@google.com>
---

I decided to send this out now due to the discussion at [1], because it
is one of the first things that people notice when enabling KCSAN.

[1] https://lkml.kernel.org/r/811af0bc-0c99-37f6-a39a-095418b10661@huawei.com

It had been reported before, but never with the 2nd stack trace -- so at
the very least this patch can now serve as a reference.

Thanks,
-- Marco

---
 kernel/locking/mutex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index db1913611192..50c03a3fa61e 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -367,7 +367,7 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 		/*
 		 * Use vcpu_is_preempted to detect lock holder preemption issue.
 		 */
-		if (!owner->on_cpu || need_resched() ||
+		if (!READ_ONCE(owner->on_cpu) || need_resched() ||
 				vcpu_is_preempted(task_cpu(owner))) {
 			ret = false;
 			break;
@@ -410,7 +410,7 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
 	 */
 
 	if (owner)
-		retval = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+		retval = READ_ONCE(owner->on_cpu) && !vcpu_is_preempted(task_cpu(owner));
 
 	/*
 	 * If lock->owner is not set, the mutex has been released. Return true
-- 
2.34.0.rc2.393.gf8c9666880-goog

