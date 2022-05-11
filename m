Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D46952315F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiEKLWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiEKLWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:22:36 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F41210896
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:22:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652268153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4g56gF9BShwS0CUD8MKwxhjOnNnUm+SpxtifTSrg85c=;
        b=n33BoqRNDSpMzngZM4rvseNt6pQbR9C5Yh45F/072yryqVb286ZcXiNVokvXFhOUfgmptb
        6EzB5ZBHFn9HnBlegzLwsDvEZkMgerUq52+UBEXB551+nS8NQ0WCNGBuMsWdhwfKzN0pjM
        LultSDsuJkjMKcEyMjZLYc/zIaDJjWc=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] sched/rt: fix the case where sched_rt_period_us is non-positive
Date:   Wed, 11 May 2022 19:21:40 +0800
Message-Id: <20220511112140.103579-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proc_dointvec() in sched_rt_handler() is for integer, but
sysctl_sched_rt_period is a unsigned integer. sched_rt_handler() would
cover a non-positive number to positive number, so both proc_dointvec()
and sched_rt_global_validate() aren't return error when we set a
non-positive number.

Use proc_dointvec_minmax() instead of proc_dointvec(), and add extra
for sched_rt_period_us/sched_rt_runtime_us/sched_rr_timeslice_ms.

Fixes: 391e43da797a ("sched: Move all scheduler bits into kernel/sched/")
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/rt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b491a0f8c25d..f20389aa6731 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -37,6 +37,7 @@ static struct ctl_table sched_rt_sysctls[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler   = sched_rt_handler,
+		.extra1		= SYSCTL_ONE,
 	},
 	{
 		.procname       = "sched_rt_runtime_us",
@@ -44,6 +45,8 @@ static struct ctl_table sched_rt_sysctls[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = sched_rt_handler,
+		.extra1		= SYSCTL_NEG_ONE,
+		.extra2		= (void *)&sysctl_sched_rt_period,
 	},
 	{
 		.procname       = "sched_rr_timeslice_ms",
@@ -51,6 +54,7 @@ static struct ctl_table sched_rt_sysctls[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = sched_rr_handler,
+		.extra1		= SYSCTL_ONE,
 	},
 	{}
 };
@@ -2959,9 +2963,6 @@ static int sched_rt_global_constraints(void)
 #ifdef CONFIG_SYSCTL
 static int sched_rt_global_validate(void)
 {
-	if (sysctl_sched_rt_period <= 0)
-		return -EINVAL;
-
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
 		((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
 		 ((u64)sysctl_sched_rt_runtime *
@@ -2992,7 +2993,7 @@ static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (!ret && write) {
 		ret = sched_rt_global_validate();
@@ -3027,14 +3028,13 @@ static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 	static DEFINE_MUTEX(mutex);
 
 	mutex_lock(&mutex);
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	/*
 	 * Make sure that internally we keep jiffies.
 	 * Also, writing zero resets the timeslice to default:
 	 */
 	if (!ret && write) {
 		sched_rr_timeslice =
-			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
 			msecs_to_jiffies(sysctl_sched_rr_timeslice);
 	}
 	mutex_unlock(&mutex);
-- 
2.25.1

