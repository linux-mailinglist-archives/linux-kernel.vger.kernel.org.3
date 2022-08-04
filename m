Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68384589D93
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbiHDOgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239805AbiHDOgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:36:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13C224A815
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:36:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 863211480;
        Thu,  4 Aug 2022 07:36:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.10.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D5303F73B;
        Thu,  4 Aug 2022 07:36:34 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 1/9] sched/uclamp: Fix relationship between uclamp and migration margin
Date:   Thu,  4 Aug 2022 15:36:01 +0100
Message-Id: <20220804143609.515789-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804143609.515789-1-qais.yousef@arm.com>
References: <20220804143609.515789-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fits_capacity() verifies that a util is within 20% margin of the
capacity of a CPU, which is an attempt to speed up upmigration.

But when uclamp is used, this 20% margin is problematic because for
example if a task is boosted to 1024, then it will not fit on any CPU
according to fits_capacity() logic.

Or if a task is boosted to capacity_orig_of(medium_cpu). The task will
end up on big instead on the desired medium CPU.

Similar corner cases exist for uclamp and usage of capacity_of().
Slightest irq pressure on biggest CPU for example will make a 1024
boosted task look like it can't fit.

What we really want is for uclamp comparisons to ignore the migration
margin and capacity pressure, yet retain them for when checking the
_actual_ util signal.

For example, task p:

	p->util_avg = 300
	p->uclamp[UCLAMP_MIN] = 1024

Will fit a big CPU. But

	p->util_avg = 900
	p->uclamp[UCLAMP_MIN] = 1024

will not, this should trigger overutilized state because the big CPU is
now *actually* being saturated.

Similar reasoning applies to capping tasks with UCLAMP_MAX. For example:

	p->util_avg = 1024
	p->uclamp[UCLAMP_MAX] = capacity_orig_of(medium_cpu)

Should fit the task on medium cpus without triggering overutilized
state.

Inlined comments expand more on desired behavior in more scenarios.

Introduce new util_fits_cpu() function which encapsulates the new logic.
The new function is not used anywhere yet, but will be used to update
various users of fits_capacity() in later patches.

Fixes: af24bde8df202 ("sched/uclamp: Add uclamp support to energy_compute()")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/fair.c | 123 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 52dc9d6f811e..00c2de800685 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4254,6 +4254,129 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_se_tp(&p->se);
 }
 
+static inline int util_fits_cpu(unsigned long util,
+				unsigned long uclamp_min,
+				unsigned long uclamp_max,
+				int cpu)
+{
+	unsigned long capacity_orig, capacity_orig_thermal;
+	unsigned long capacity = capacity_of(cpu);
+	bool fits, uclamp_max_fits;
+
+	/*
+	 * Check if the real util fits without any uclamp boost/cap applied.
+	 */
+	fits = fits_capacity(util, capacity);
+
+	if (!uclamp_is_used())
+		return fits;
+
+	/*
+	 * We must use capacity_orig_of() for comparing against uclamp_min and
+	 * uclamp_max. We only care about capacity pressure (by using
+	 * capacity_of()) for comparing against the real util.
+	 *
+	 * If a task is boosted to 1024 for example, we don't want a tiny
+	 * pressure to skew the check whether it fits a CPU or not.
+	 *
+	 * Similarly if a task is capped to capacity_orig_of(little_cpu), it
+	 * should fit a little cpu even if there's some pressure.
+	 *
+	 * Only exception is for thermal pressure since it has a direct impact
+	 * on available OPP of the system.
+	 *
+	 * We honour it for uclamp_min only as a drop in performance level
+	 * could result in not getting the requested minimum performance level.
+	 *
+	 * For uclamp_max, we can tolerate a drop in performance level as the
+	 * goal is to cap the task. So it's okay if it's getting less.
+	 *
+	 * In case of capacity inversion, which is not handled yet, we should
+	 * honour the inverted capacity for both uclamp_min and uclamp_max all
+	 * the time.
+	 */
+	capacity_orig = capacity_orig_of(cpu);
+	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
+
+	/*
+	 * We want to force a task to fit a cpu as implied by uclamp_max.
+	 * But we do have some corner cases to cater for..
+	 *
+	 *
+	 *                                 C=z
+	 *   |                             ___
+	 *   |                  C=y       |   |
+	 *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _  uclamp_max
+	 *   |      C=x        |   |      |   |
+	 *   |      ___        |   |      |   |
+	 *   |     |   |       |   |      |   |    (util somewhere in this region)
+	 *   |     |   |       |   |      |   |
+	 *   |     |   |       |   |      |   |
+	 *   +----------------------------------------
+	 *         cpu0        cpu1       cpu2
+	 *
+	 *   In the above example if a task is capped to a specific performance
+	 *   point, y, then when:
+	 *
+	 *   * util = 80% of x then it does not fit on cpu0 and should migrate
+	 *     to cpu1
+	 *   * util = 80% of y then it is forced to fit on cpu1 to honour
+	 *     uclamp_max request.
+	 *
+	 *   which is what we're enforcing here. A task always fits if
+	 *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
+	 *   the normal upmigration rules should withhold still.
+	 *
+	 *   Only exception is when we are on max capacity, then we need to be
+	 *   careful not to block overutilized state. This is so because:
+	 *
+	 *     1. There's no concept of capping at max_capacity! We can't go
+	 *        beyond this performance level anyway.
+	 *     2. The system is being saturated when we're operating near
+	 *        max capacity, it doesn't make sense to block overutilized.
+	 */
+	uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
+	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
+	fits = fits || uclamp_max_fits;
+
+	/*
+	 *
+	 *                                 C=z
+	 *   |                             ___       (region a, capped, util >= uclamp_max)
+	 *   |                  C=y       |   |
+	 *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _ uclamp_max
+	 *   |      C=x        |   |      |   |
+	 *   |      ___        |   |      |   |      (region b, uclamp_min <= util <= uclamp_max)
+	 *   |_ _ _|_ _|_ _ _ _| _ | _ _ _| _ | _ _ _ _ _ uclamp_min
+	 *   |     |   |       |   |      |   |
+	 *   |     |   |       |   |      |   |      (region c, boosted, util < uclamp_min)
+	 *   +----------------------------------------
+	 *         cpu0        cpu1       cpu2
+	 *
+	 * a) If util > uclamp_max, then we're capped, we don't care about
+	 *    actual fitness value here. We only care if uclamp_max fits
+	 *    capacity without taking margin/pressure into account.
+	 *    See comment above.
+	 *
+	 * b) If uclamp_min <= util <= uclamp_max, then the normal
+	 *    fits_capacity() rules apply. Except we need to ensure that we
+	 *    enforce we remain within uclamp_max, see comment above.
+	 *
+	 * c) If util < uclamp_min, then we are boosted. Same as (b) but we
+	 *    need to take into account the boosted value fits the CPU without
+	 *    taking margin/pressure into account.
+	 *
+	 * Cases (a) and (b) are handled in the 'fits' variable already. We
+	 * just need to consider an extra check for case (c) after ensuring we
+	 * handle the case uclamp_min > uclamp_max.
+	 */
+	uclamp_min = min(uclamp_min, uclamp_max);
+	if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
+		fits = fits && (uclamp_min <= capacity_orig_thermal);
+
+	return fits;
+}
+
 static inline int task_fits_capacity(struct task_struct *p,
 				     unsigned long capacity)
 {
-- 
2.25.1

