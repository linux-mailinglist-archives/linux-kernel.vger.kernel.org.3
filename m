Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E2452996B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbiEQGSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiEQGSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:18:45 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1981377F6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:18:43 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652768321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bgJcNcSW/ZMq/16RJL24GCiAZ43k7Fqc2lbAAdZ14Xs=;
        b=jneRRm0m2sLAnjS4N+rQ+VNuOuFSWtEIZcbdT9qYQWRU7gh6o8xuTj/louzAlPl/TsVyK4
        x4web+QTyQPXp3wh7Rh6UpLYkD7/tK5azSRFiicguS5F0sJHHJCst5Y8q/Btk5Kf6MmZM0
        Q3lQd5e/xaNxXT+LjEWh4ktZA96/uwk=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v3] sched/rt: fix the case where sched_rt_period_us is negative
Date:   Tue, 17 May 2022 14:18:12 +0800
Message-Id: <20220517061812.95276-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proc_dointvec() is for integer, but sysctl_sched_rt_period is a
unsigned integer, proc_dointvec() would convert negative number into
positive number. So both proc_dointvec() and sched_rt_global_validate()
aren't return error even if we set a negative number.

Use proc_dointvec_minmax() instead of proc_dointvec() and use extra1
limit the minimum value for sched_rt_period_us/sched_rt_runtime_us.

Make sysctl_sched_rt_period integer to match proc_dointvec_minmax().

v3:
 - Make sysctl_sched_rt_period integer (Valentin Schneider)
v2:
 - Remove sched_rr_timeslice_ms related changes (Valentin Schneider)

Fixes: d0b27fa77854 ("sched: rt-group: synchonised bandwidth period")
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/rt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed9664840..cafc580edbe4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -16,7 +16,7 @@ struct rt_bandwidth def_rt_bandwidth;
  * period over which we measure -rt task CPU usage in us.
  * default: 1s
  */
-unsigned int sysctl_sched_rt_period = 1000000;
+int sysctl_sched_rt_period = 1000000;
 
 /*
  * part of the period that we allow rt tasks to run in us.
@@ -34,9 +34,10 @@ static struct ctl_table sched_rt_sysctls[] = {
 	{
 		.procname       = "sched_rt_period_us",
 		.data           = &sysctl_sched_rt_period,
-		.maxlen         = sizeof(unsigned int),
+		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = sched_rt_handler,
+		.extra1		= SYSCTL_ONE,
 	},
 	{
 		.procname       = "sched_rt_runtime_us",
@@ -44,6 +45,7 @@ static struct ctl_table sched_rt_sysctls[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = sched_rt_handler,
+		.extra1		= SYSCTL_NEG_ONE,
 	},
 	{
 		.procname       = "sched_rr_timeslice_ms",
@@ -2960,9 +2962,6 @@ static int sched_rt_global_constraints(void)
 #ifdef CONFIG_SYSCTL
 static int sched_rt_global_validate(void)
 {
-	if (sysctl_sched_rt_period <= 0)
-		return -EINVAL;
-
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
 		((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
 		 ((u64)sysctl_sched_rt_runtime *
@@ -2993,7 +2992,7 @@ static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (!ret && write) {
 		ret = sched_rt_global_validate();
-- 
2.25.1

