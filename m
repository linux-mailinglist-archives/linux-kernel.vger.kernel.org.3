Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E727469FB2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392274AbhLFPvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378991AbhLFPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:36:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21D8C08EAD0;
        Mon,  6 Dec 2021 07:22:46 -0800 (PST)
Date:   Mon, 06 Dec 2021 15:22:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638804165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8NlbiwgmIT50EasVMrVXl8xMy/TaKs7FjoQNO/v6TLw=;
        b=UMqwkMJgBmJSEz/KlwmEzjaStMPgmUADLzwu0iZBNOGBmfQKuj5BX+1KLhMebFBq98NBnU
        fjhFo+agHiyC4g5u+Rb3lEqID8cC+s56NCTseYmlR/pv7KIBi2QClk6SATu18LOZYvYKk4
        kwy0oT+o7HufqZP5GMPFlEAtTH/1ZhxtraYfYR2yw5KftFAPH32P6RqGjVt963QsIZ5SsB
        SEag8+G/octNv8EjIDvUSaPPt0VLbvrEqv5+51H+bmPiZxYZ5FvGhF5wRUqkrq+Jz2ig/v
        Awhk+2xE+iQ5qjg6iLm8QP24yJH6sGI+BxPvdVK7F3jy6nq6vP2XfIprUZEFow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638804165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8NlbiwgmIT50EasVMrVXl8xMy/TaKs7FjoQNO/v6TLw=;
        b=cpSF1MHJ3g/htMd9H5bBMJdcATsTEu+kB2fbYswLtF/KDqHLkUXWiuDTbIjkq282f1Pg8Y
        7luTWQ9wlcbOaBDQ==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix per-CPU kthread and wakee stacking
 for asym CPU capacity
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129173115.4006346-1-vincent.donnefort@arm.com>
References: <20211129173115.4006346-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <163880416451.11128.11779625724017471407.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     014ba44e8184e1acf93e0cbb7089ee847802f8f0
Gitweb:        https://git.kernel.org/tip/014ba44e8184e1acf93e0cbb7089ee847802f8f0
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Mon, 29 Nov 2021 17:31:15 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:21 +01:00

sched/fair: Fix per-CPU kthread and wakee stacking for asym CPU capacity

select_idle_sibling() has a special case for tasks woken up by a per-CPU
kthread where the selected CPU is the previous one. For asymmetric CPU
capacity systems, the assumption was that the wakee couldn't have a
bigger utilization during task placement than it used to have during the
last activation. That was not considering uclamp.min which can completely
change between two task activations and as a consequence mandates the
fitness criterion asym_fits_capacity(), even for the exit path described
above.

Fixes: b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lkml.kernel.org/r/20211129173115.4006346-1-vincent.donnefort@arm.com
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5cd2798..0672218 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6400,7 +6400,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (is_per_cpu_kthread(current) &&
 	    in_task() &&
 	    prev == smp_processor_id() &&
-	    this_rq()->nr_running <= 1) {
+	    this_rq()->nr_running <= 1 &&
+	    asym_fits_capacity(task_util, prev)) {
 		return prev;
 	}
 
