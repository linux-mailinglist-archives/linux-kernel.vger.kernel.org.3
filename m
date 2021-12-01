Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC708465154
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350605AbhLAPWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:22:40 -0500
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:58147 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243911AbhLAPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:22:30 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id C9CCC1C4789
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 15:19:04 +0000 (GMT)
Received: (qmail 10196 invoked from network); 1 Dec 2021 15:19:04 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 1 Dec 2021 15:19:04 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] sched/fair: Use weight of SD_NUMA domain in find_busiest_group
Date:   Wed,  1 Dec 2021 15:18:43 +0000
Message-Id: <20211201151844.20488-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201151844.20488-1-mgorman@techsingularity.net>
References: <20211201151844.20488-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_busiest_group uses the child domain's group weight instead of
the sched_domain's weight that has SD_NUMA set when calculating the
allowed imbalance between NUMA nodes. This is wrong and inconsistent
with find_idlest_group.

This patch uses the SD_NUMA weight in both.

Fixes: c4e8f691d926 ("sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCS")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6d9435..0a969affca76 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9397,7 +9397,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-				busiest->sum_nr_running, busiest->group_weight);
+				busiest->sum_nr_running, env->sd->span_weight);
 		}
 
 		return;
-- 
2.31.1

