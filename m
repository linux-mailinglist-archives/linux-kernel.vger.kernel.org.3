Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1E64F757F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 07:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbiDGFwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 01:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbiDGFwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 01:52:41 -0400
X-Greylist: delayed 1829 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 22:50:32 PDT
Received: from SHSQR01.unisoc.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F081560E9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 22:50:32 -0700 (PDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id 2375K3WR084414
        for <linux-kernel@vger.kernel.org>; Thu, 7 Apr 2022 13:20:03 +0800 (CST)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 2375JfPV083371
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Thu, 7 Apr 2022 13:19:41 +0800 (CST)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from BJ10918PCW.spreadtrum.com (10.0.74.50) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 7 Apr 2022 13:19:40 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>
CC:     <rafael@kernel.org>, <viresh.kumar@linaro.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [PATCH] sched: Take thermal pressure into account when determine rt fits capacity
Date:   Thu, 7 Apr 2022 13:19:32 +0800
Message-ID: <20220407051932.4071-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.50]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 2375JfPV083371
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases when the cpu max capacity might be reduced due to thermal.
Take into the thermal pressure into account when judge whether the rt task
fits the cpu. And when schedutil govnor get cpu util, the thermal pressure
also should be considered.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/cpufreq_schedutil.c | 1 +
 kernel/sched/rt.c                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3dbf351d12d5..285ad51caf0f 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -159,6 +159,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
 
+	max -= arch_scale_thermal_pressure(sg_cpu->cpu);
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu), max,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a32c46889af8..d9982ebd4821 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -466,6 +466,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 	max_cap = uclamp_eff_value(p, UCLAMP_MAX);
 
 	cpu_cap = capacity_orig_of(cpu);
+	cpu_cap -= arch_scale_thermal_pressure(cpu);
 
 	return cpu_cap >= min(min_cap, max_cap);
 }
-- 
2.25.1

