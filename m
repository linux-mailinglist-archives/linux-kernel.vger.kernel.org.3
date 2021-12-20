Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1114C47A8E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhLTLnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:43:45 -0500
Received: from foss.arm.com ([217.140.110.172]:52906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232023AbhLTLnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:43:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E45701396;
        Mon, 20 Dec 2021 03:43:42 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.37.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81FFF3F718;
        Mon, 20 Dec 2021 03:43:41 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 2/3] sched/fair: Fix newidle_balance() for overutilized systems
Date:   Mon, 20 Dec 2021 12:43:22 +0100
Message-Id: <20211220114323.22811-3-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211220114323.22811-1-vincent.donnefort@arm.com>
References: <20211220114323.22811-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Energy-Aware Scheduling systems, load balancing is disabled in favor of
energy based placement, until one of the CPU is identified as being
overutilized. Once the overutilization is resolved, two paths can lead to
marking the system as non overutilized again:

  * load_balance() triggered from newidle_balance().
  * load_balance() triggered from the scheduler tick.

However, small caveat for each of those paths. newidle_balance() needs
rd->overload set to run load_balance(), while the load_balance() triggered
by the scheduler tick needs to run from the first idle CPU of the root
domain (see should_we_balance()).

Overutilized can be triggered without setting overload (this can happen
for a CPU which had a misfit task but didn't had its util_avg updated
yet). Then, only the scheduler tick could help to reset overutilized...
but if most of the CPUs are idle, it is very unlikely load_balance() would
run on the only CPU which can reset the flag. This means the root domain
can spuriously maintain overutilized for a long period of time.

We then need newidle_balance() to proceed with balancing if the system is
overutilized.

Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2f6fa14e5e7..51f6f55abb37 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10849,7 +10849,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
-	if (!READ_ONCE(this_rq->rd->overload) ||
+	if ((!READ_ONCE(this_rq->rd->overload) &&
+	    !READ_ONCE(this_rq->rd->overutilized)) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
 		if (sd)
-- 
2.25.1

