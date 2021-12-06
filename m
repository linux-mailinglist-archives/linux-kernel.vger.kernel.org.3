Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF77469E12
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389318AbhLFPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385613AbhLFPZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:25:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0EAC08EB4F;
        Mon,  6 Dec 2021 07:15:44 -0800 (PST)
Date:   Mon, 06 Dec 2021 15:15:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638803742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abbYFFVDyhnzMZHcRcfoK1sNHOkW/nwzoE6qzhJ4dS8=;
        b=Y2dZlRk1dhlWg0ByD9BZIX+ArTbDEZcd1A+qPj4Wm4F3ANWyWyhJJHZ9PIbn6FKHJL0xyW
        aZUOpon91PyPsJQlgu2LijpnbTmxo0q0l5UNaMF0a9ermjpCzS41/R05R0cfB+gc0q4lRU
        q7LO9zLx74K8f3k60N+Ir2ZP42WKcGzp/pye2jws2hteOiU9xqGMpY6ynnUbErvbkojJiC
        Grr4lGQfjP65dCd5MUak0mTUGULaCVqWJQOp4ObmPL62mTwIZ7PTHFf0nKa6A6bfTivVYM
        69l2XG+9RoANEprTUnuPICu5xoXVTwBW2Fb2wjKC4Ct+a2MQTDeg0jIrL7KPOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638803742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abbYFFVDyhnzMZHcRcfoK1sNHOkW/nwzoE6qzhJ4dS8=;
        b=einwmB30Zaa5Y195yGbU0nUgGjX8UbOFjBZXyOO8qWqf0Er0LyprSdOHc0lsu5qwk8oJlE
        KLNhsPzoIeBY6SAg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Mark racy reads of owner->on_cpu
Cc:     Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211203075935.136808-3-wangkefeng.wang@huawei.com>
References: <20211203075935.136808-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Message-ID: <163880374099.11128.7615758886368833285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4cf75fd4a2545ca4deea992f929602c9fdbe8058
Gitweb:        https://git.kernel.org/tip/4cf75fd4a2545ca4deea992f929602c9fdbe8058
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 03 Dec 2021 15:59:35 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:25 +01:00

locking: Mark racy reads of owner->on_cpu

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

With previous refactor, mark the read to owner->on_cpu in owner_on_cpu(),
which immediately precedes the loop executing mutex_spin_on_owner().

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211203075935.136808-3-wangkefeng.wang@huawei.com
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ff609d9..0b9b0e3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2177,7 +2177,7 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 	 * As lock holder preemption issue, we both skip spinning if
 	 * task is not on cpu or its cpu is preempted
 	 */
-	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+	return READ_ONCE(owner->on_cpu) && !vcpu_is_preempted(task_cpu(owner));
 }
 
 /* Returns effective CPU energy utilization, as seen by the scheduler */
