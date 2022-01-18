Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51CE49249B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbiARLSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:18:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35094 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239520AbiARLSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:18:13 -0500
Date:   Tue, 18 Jan 2022 11:18:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKexeQ9ADkjB8kDZNztseV3vq2w0Z47HQHdnBdHz9ak=;
        b=b1oxLH4giJhyyoTvBogUiifJAO88jW7N/WTtZviYlH7uU42KSftaIEyvwQMdVejHlZJKe1
        Mi8Bi9byOQUWGg9MHTaG2LliQpC7ONLtFcwZKOZaGJBpyPa+UbaeQYF/QY8O6pdhqH20xb
        TB2NEdGRYbvlKYcTnX3QFQSUNrknZpqA1oCvrRQCAYLddRUnD+9VdG5aKcPln1F0XnAQXc
        ctgEU29f9pCHZIeHPNGwQCU/dfvL97ywsFwVeWpX6QobikNe7JXYW0VsfOgqgqKGtHVnNq
        TNRAQ+77JAW5mooXIhoeVMrX5G5r1ka9s0PrlBWdq83bUuBUUP39jUfiwu3nQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKexeQ9ADkjB8kDZNztseV3vq2w0Z47HQHdnBdHz9ak=;
        b=/Ho2gYHaUKhNTULiD0prpnK5idTtPLZ2zg2xw/3fj/84p5XZK9g6spJECgXVfVqUxu5cnI
        D0zyc957YiV2cEDw==
From:   "tip-bot2 for Cruz Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Accounting forceidle time for all
 tasks except idle task
Cc:     Cruz Zhao <CruzZhao@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Don <joshdon@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1641894961-9241-2-git-send-email-CruzZhao@linux.alibaba.com>
References: <1641894961-9241-2-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <164250469114.16921.12912359382201917091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b171501f258063f5c56dd2c5fdf310802d8d7dc1
Gitweb:        https://git.kernel.org/tip/b171501f258063f5c56dd2c5fdf310802d8d7dc1
Author:        Cruz Zhao <CruzZhao@linux.alibaba.com>
AuthorDate:    Tue, 11 Jan 2022 17:55:59 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:09:59 +01:00

sched/core: Accounting forceidle time for all tasks except idle task

There are two types of forced idle time: forced idle time from cookie'd
task and forced idle time form uncookie'd task. The forced idle time from
uncookie'd task is actually caused by the cookie'd task in runqueue
indirectly, and it's more accurate to measure the capacity loss with the
sum of both.

Assuming cpu x and cpu y are a pair of SMT siblings, consider the
following scenarios:
  1.There's a cookie'd task running on cpu x, and there're 4 uncookie'd
    tasks running on cpu y. For cpu x, there will be 80% forced idle time
    (from uncookie'd task); for cpu y, there will be 20% forced idle time
    (from cookie'd task).
  2.There's a uncookie'd task running on cpu x, and there're 4 cookie'd
    tasks running on cpu y. For cpu x, there will be 80% forced idle time
    (from cookie'd task); for cpu y, there will be 20% forced idle time
    (from uncookie'd task).

The scenario1 can recurrent by stress-ng(scenario2 can recurrent similary):
    (cookie'd)taskset -c x stress-ng -c 1 -l 100
    (uncookie'd)taskset -c y stress-ng -c 4 -l 100

In the above two scenarios, the total capacity loss is 1 cpu, but in
scenario1, the cookie'd forced idle time tells us 20% cpu capacity loss, in
scenario2, the cookie'd forced idle time tells us 80% cpu capacity loss,
which are not accurate. It'll be more accurate to measure with cookie'd
forced idle time and uncookie'd forced idle time.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Don <joshdon@google.com>
Link: https://lore.kernel.org/r/1641894961-9241-2-git-send-email-CruzZhao@linux.alibaba.com
---
 kernel/sched/core.c       | 3 +--
 kernel/sched/core_sched.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83872f9..0d2ab2a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5822,8 +5822,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	}
 
 	if (schedstat_enabled() && rq->core->core_forceidle_count) {
-		if (cookie)
-			rq->core->core_forceidle_start = rq_clock(rq->core);
+		rq->core->core_forceidle_start = rq_clock(rq->core);
 		rq->core->core_forceidle_occupation = occ;
 	}
 
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 1fb4567..c8746a9 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -277,7 +277,7 @@ void __sched_core_account_forceidle(struct rq *rq)
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick ?: rq_i->curr;
 
-		if (!p->core_cookie)
+		if (p == rq_i->idle)
 			continue;
 
 		__schedstat_add(p->stats.core_forceidle_sum, delta);
