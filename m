Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E858C49E637
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbiA0PiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiA0PiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:38:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92DAC061714;
        Thu, 27 Jan 2022 07:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FK2KOKKIeogSgT4OajiGqHETtj6QhVcNQ4Tqky6O32g=; b=dak2QOjj7iMRzavy/9HxfQOW1X
        h8VZRBSWK9lbMPyh0RS5+0ZQ8Tb8js+h06kEziLv7sMlA0LCWmvbh/Rz37Y4LVrLiSmdboltDHV5A
        QacAwnAxG6I66GqSwIg3XAyxG+GUvXJ8oY9pNeoLdkPCrFZ6bn0+B2WSwuthnIHF5+ZBSooLqw3vh
        QYf8kAFpm9pZe96Dm93tc8NlzVMiPZ8beP/cEKR681OSvLHpbbw2ARTDZtgkQkK4evwR7FnldCzS1
        GIgBsuOwG04L/3OUtMayoZIv/EnQ9zOiyBz49pb2+6rbsus1LSBqEporGKDRSJ9wLOjalNd9eX2z+
        UolFqbOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD6qO-005N6G-BL; Thu, 27 Jan 2022 15:37:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB6BE986245; Thu, 27 Jan 2022 16:37:49 +0100 (CET)
Date:   Thu, 27 Jan 2022 16:37:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Subject: Re: [RFC PATCH v2 4/5] sched: UMCG: add a blocked worker list
Message-ID: <20220127153749.GP20638@worktop.programming.kicks-ass.net>
References: <20220113233940.3608440-1-posk@google.com>
 <20220113233940.3608440-5-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113233940.3608440-5-posk@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 03:39:39PM -0800, Peter Oskolkov wrote:

> This change introduces the following benefits:
> - block detection how behaves similarly to wake detection;
>   without this patch worker wakeups added wakees to the list
>   and woke the server, while worker blocks only woke the server
>   without adding blocked workers to a list, forcing servers
>   to explicitly check worker's state;

> - if the blocked worker woke sufficiently quickly, the server
>   woken on the block event would observe its worker now as
>   RUNNABLE, so the block event had to be inferred rather than
>   explicitly signalled by the worker being added to the blocked
>   worker list;

This I think is missing the point, there is no race if the server checks
curr->state == RUNNING.

> - it is now possible for a single server to control several
>   RUNNING workers, which makes writing userspace schedulers
>   simpler for smaller processes that do not need to scale beyond
>   one "server";

How about something like so on top?

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1298,6 +1298,7 @@ struct task_struct {
 
 #ifdef CONFIG_UMCG
 	/* setup by sys_umcg_ctrl() */
+	u32			umcg_flags;
 	clockid_t		umcg_clock;
 	struct umcg_task __user	*umcg_task;
 
--- a/include/uapi/linux/umcg.h
+++ b/include/uapi/linux/umcg.h
@@ -119,6 +119,8 @@ struct umcg_task {
 	 *
 	 * Readable/writable by both the kernel and the userspace: the
 	 * kernel adds items to the list, userspace removes them.
+	 *
+	 * Only used with UMCG_CTL_MULTI.
 	 */
 	__u64	blocked_workers_ptr;		/* r/w */
 
@@ -147,11 +149,13 @@ enum umcg_wait_flag {
  * @UMCG_CTL_REGISTER:   register the current task as a UMCG task
  * @UMCG_CTL_UNREGISTER: unregister the current task as a UMCG task
  * @UMCG_CTL_WORKER:     register the current task as a UMCG worker
+ * @UMCG_CTL_MULTI:	 allow 1:n worker relations, enables blocked_workers_ptr
  */
 enum umcg_ctl_flag {
 	UMCG_CTL_REGISTER	= 0x00001,
 	UMCG_CTL_UNREGISTER	= 0x00002,
 	UMCG_CTL_WORKER		= 0x10000,
+	UMCG_CTL_MULTI		= 0x20000,
 };
 
 #endif /* _UAPI_LINUX_UMCG_H */
--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -335,7 +335,7 @@ static inline int umcg_enqueue_runnable(
 }
 
 /*
- * Enqueue @tsk on it's server's blocked list
+ * Enqueue @tsk on it's server's blocked list OR ensure @tsk == server::next_tid
  *
  * Must be called in umcg_pin_pages() context, relies on tsk->umcg_server.
  *
@@ -346,10 +346,34 @@ static inline int umcg_enqueue_runnable(
  * Returns:
  *   0: success
  *   -EFAULT
+ *   -ESRCH	server::next_tid is not a valid UMCG task
+ *   -EINVAL	server::next_tid doesn't match @tsk
  */
 static inline int umcg_enqueue_blocked(struct task_struct *tsk)
 {
-	return umcg_enqueue(tsk, true /* blocked */);
+	struct task_struct *next;
+	u32 next_tid;
+	int ret;
+
+	if (tsk->umcg_server->umcg_flags & UMCG_CTL_MULTI)
+		return umcg_enqueue(tsk, true /* blocked */);
+
+	/*
+	 * When !MULTI, ensure this worker is the current worker,
+	 * ensuring the 1:1 relation.
+	 */
+	if (get_user(next_tid, &tsk->umcg_server_task->next_tid))
+		return -EFAULT;
+
+	next = umcg_get_task(next_tid);
+	if (!next)
+		return -ESRCH;
+
+	ret = (next == tsk) ? 0 : -EINVAL;
+
+	put_task_struct(next);
+
+	return ret;
 }
 
 /* pre-schedule() */
@@ -911,6 +934,8 @@ static int umcg_register(struct umcg_tas
 		return -EINVAL;
 	}
 
+	current->umcg_flags = flags;
+
 	if (current->umcg_task || !self)
 		return -EINVAL;
 
@@ -1061,7 +1086,7 @@ SYSCALL_DEFINE3(umcg_ctl, u32, flags, st
 
 	flags &= ~UMCG_CTL_CMD;
 
-	if (flags & ~(UMCG_CTL_WORKER))
+	if (flags & ~(UMCG_CTL_WORKER|UMCG_CTL_MULTI))
 		return -EINVAL;
 
 	switch (cmd) {
