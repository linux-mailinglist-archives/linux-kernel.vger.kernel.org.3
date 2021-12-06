Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02126469FB4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392323AbhLFPvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378937AbhLFPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:36:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9941DC08EAD1;
        Mon,  6 Dec 2021 07:22:47 -0800 (PST)
Date:   Mon, 06 Dec 2021 15:22:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638804166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSt8q/8e/nInyK8sJyI1ka7WCaym2KvVvp3HmPNl+2s=;
        b=CIVp6gZu/J6oNj4nfWDHOqppJIfTbHqMxzNxfmEIKER+HyYpyWFHjUniuFmMEgu8h5eqBM
        +Wip74wqKmtOiHZS3PbwdFP1LX6irvSeyQWnLadjzC/9J6seJBow6wM9dk7XFo6fSBpLh0
        uZ31ABEs+8OOIhF18WWuIU4sf3wKV4l0/eGo0ZnLg4gPjAyB8ZnIZxwMX/dn2YhGbArXwd
        wXfW0qyY4z41gHGk8ip6crSynX0/f1JkEbCCpeNdkpt+2n74mWsmKyErMq6mINhRUo3ZBq
        ntRpAWpyOolhsSYbiHNVEjx8RZYLfEj3esU5ao8Rmxv2gGR9oVT3iO3VzYOF+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638804166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSt8q/8e/nInyK8sJyI1ka7WCaym2KvVvp3HmPNl+2s=;
        b=hvpH7VpWY3tYZ7sbfzk0dMzkAG41YzylqU8gZ5PBUDBTJ+1M2RdpmTf56QdPHnkZVWV7F1
        LQs4TcZ6MTofdJBQ==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix detection of per-CPU kthreads waking a task
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211201143450.479472-1-vincent.donnefort@arm.com>
References: <20211201143450.479472-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <163880416530.11128.2092614972887250600.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8b4e74ccb582797f6f0b0a50372ebd9fd2372a27
Gitweb:        https://git.kernel.org/tip/8b4e74ccb582797f6f0b0a50372ebd9fd2372a27
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Wed, 01 Dec 2021 14:34:50 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:20 +01:00

sched/fair: Fix detection of per-CPU kthreads waking a task

select_idle_sibling() has a special case for tasks woken up by a per-CPU
kthread, where the selected CPU is the previous one. However, the current
condition for this exit path is incomplete. A task can wake up from an
interrupt context (e.g. hrtimer), while a per-CPU kthread is running. A
such scenario would spuriously trigger the special case described above.
Also, a recent change made the idle task like a regular per-CPU kthread,
hence making that situation more likely to happen
(is_per_cpu_kthread(swapper) being true now).

Checking for task context makes sure select_idle_sibling() will not
interpret a wake up from any other context as a wake up by a per-CPU
kthread.

Fixes: 52262ee567ad ("sched/fair: Allow a per-CPU kthread waking a task to stack on the same CPU, to fix XFS performance regression")
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lore.kernel.org/r/20211201143450.479472-1-vincent.donnefort@arm.com
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 884f29d..5cd2798 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6398,6 +6398,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * pattern is IO completions.
 	 */
 	if (is_per_cpu_kthread(current) &&
+	    in_task() &&
 	    prev == smp_processor_id() &&
 	    this_rq()->nr_running <= 1) {
 		return prev;
