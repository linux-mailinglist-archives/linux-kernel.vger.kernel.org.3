Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03E746502C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350620AbhLAOoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:44:13 -0500
Received: from foss.arm.com ([217.140.110.172]:38460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350543AbhLAOjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:39:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04FF3143B;
        Wed,  1 Dec 2021 06:35:34 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.82.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C598A3F5A1;
        Wed,  1 Dec 2021 06:35:32 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2] sched/fair: Fix detection of per-CPU kthreads waking a task
Date:   Wed,  1 Dec 2021 14:34:50 +0000
Message-Id: <20211201143450.479472-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

---
v1 -> v2:
  * is_idle_thread() -> in_task() to also include spurious detection when
    current != swapper. (Vincent Guittot)
---

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 945d987246c5..56db4ae85995 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6399,6 +6399,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * pattern is IO completions.
 	 */
 	if (is_per_cpu_kthread(current) &&
+	    in_task() &&
 	    prev == smp_processor_id() &&
 	    this_rq()->nr_running <= 1) {
 		return prev;
-- 
2.25.1

