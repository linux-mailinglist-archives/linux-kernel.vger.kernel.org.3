Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E17058FCC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbiHKMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiHKMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:50:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E5A47BB5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64AA961495
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72078C433D6;
        Thu, 11 Aug 2022 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660222200;
        bh=75eCyKtjIhT/qSC4hpjr7K7Hl8Xt5mApzeksN3tsmXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bC7zMeXWbx+Bjb1MMAs5mD/ZJFZQjVo4NqZqi7BoN07TryJK6Ye5K3Ds+25OKW0y5
         ajO9I0S6PAZLQ3MWcqtVN3nVMa7UzDjgcp71q0+1WdHABNo9MRvUUz+PxKHLTbApIt
         09XhXm6SjQ0TKQMZ9HIjsAQdq/x6fFmwXm0Ww4PkFmqr+QlvdIKaGqmlNK0RGgTzbT
         PR+gBXU6R3qQbttCkuhGFgXfzPDt3YGNDJEkX+ZTQIk4ckyRM2kFzjXLKEq8+ka845
         4RPR55XewDX2AyMj0G8l2UDw3CuzEm05Zz8nPVNdpV/SSFkTJaRn+jAU3wlC6ma5FC
         CE/6nKEJs2UJA==
Date:   Thu, 11 Aug 2022 14:49:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Lihua (lihua, ran)" <hucool.lihua@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Reading /proc/stat has a time backward issue
Message-ID: <20220811124958.GB3284884@lothringen>
References: <85d5087b-450c-351f-270d-c61303cf3187@huawei.com>
 <1f1f625a-148d-0398-f840-1f9b4e964189@huawei.com>
 <7b2586c0-c380-c856-7d63-b7bff6f3a640@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b2586c0-c380-c856-7d63-b7bff6f3a640@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 08:23:46PM +0800, Lihua (lihua, ran) wrote:
> ping...
> 
> Your suggestions are valuable, I don't have a good way to fix this.
> 
> thanks all.
> 
> 在 2022/8/4 15:44, Lihua (lihua, ran) 写道:
> > ping...
> > 
> > Any good suggestions?
> > 
> > thanks all.
> > 
> > 在 2022/7/27 12:02, Lihua (lihua, ran) 写道:
> > > Hi all,
> > > 
> > > I found a problem that the statistical time goes backward, the value read first is 319, and the value read again is 318. As follows：
> > > first：
> > > cat /proc/stat |  grep cpu1
> > > cpu1    319    0    496    41665    0    0    0    0    0    0
> > > then：
> > > cat /proc/stat |  grep cpu1
> > > cpu1    318    0    497    41674    0    0    0    0    0    0
> > > 
> > > Time goes back, which is counterintuitive.
> > > 
> > > After debug this, I found that the problem is caused by the implementation of kcpustat_cpu_fetch_vtime. As follows：
> > > 
> > >                                CPU0                                                                          CPU1
> > > First:
> > > show_stat():
> > >      ->kcpustat_cpu_fetch()
> > >          ->kcpustat_cpu_fetch_vtime()
> > >              ->cpustat[CPUTIME_USER] = kcpustat_cpu(cpu) + vtime->utime + delta;              rq->curr is in user mod
> > >               ---> When CPU1 rq->curr running on userspace, need add utime and delta
> > >                                                                                               --->  rq->curr->vtime->utime is less than 1 tick
> > > Then:
> > > show_stat():
> > >      ->kcpustat_cpu_fetch()
> > >          ->kcpustat_cpu_fetch_vtime()
> > >              ->cpustat[CPUTIME_USER] = kcpustat_cpu(cpu);                                     rq->curr is in kernel mod
> > >              ---> When CPU1 rq->curr running on kernel space, just got kcpustat
> > > 
> > > Because the values ​​of utime、 stime and delta are temporarily written to cpustat. Therefore, there are two problems  read from /proc/stat:
> > > 1. There may be a regression phenomenon;
> > > 2. When there are many tasks, the statistics are not accurate enough when utime and stime do not exceed one TICK.
> > > The time goes back is counterintuitive, and I want to discuss whether there is a good solution without compromising performance.

I see...

Does the following help? (only built tested)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 78a233d43757..410e35e178ac 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -802,6 +802,16 @@ void vtime_init_idle(struct task_struct *t, int cpu)
 	local_irq_restore(flags);
 }
 
+u64 static vtime_delta_filtered(u64 val, struct vtime *vtime)
+{
+	u64 delta = val + vtime_delta(vtime);
+
+	if (delta >= TICK_NSEC)
+		return delta;
+	else
+		return 0;
+}
+
 u64 task_gtime(struct task_struct *t)
 {
 	struct vtime *vtime = &t->vtime;
@@ -816,7 +826,7 @@ u64 task_gtime(struct task_struct *t)
 
 		gtime = t->gtime;
 		if (vtime->state == VTIME_GUEST)
-			gtime += vtime->gtime + vtime_delta(vtime);
+			gtime += vtime_delta_filtered(vtime->gtime, vtime);
 
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 
@@ -832,7 +842,6 @@ bool task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 {
 	struct vtime *vtime = &t->vtime;
 	unsigned int seq;
-	u64 delta;
 	int ret;
 
 	if (!vtime_accounting_enabled()) {
@@ -853,16 +862,15 @@ bool task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 			continue;
 
 		ret = true;
-		delta = vtime_delta(vtime);
 
 		/*
 		 * Task runs either in user (including guest) or kernel space,
 		 * add pending nohz time to the right place.
 		 */
 		if (vtime->state == VTIME_SYS)
-			*stime += vtime->stime + delta;
+			*stime += vtime_delta_filtered(vtime->stime, vtime);
 		else
-			*utime += vtime->utime + delta;
+			*utime += vtime_delta_filtered(vtime->utime, vtime);
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 
 	return ret;
@@ -897,9 +905,9 @@ static int vtime_state_fetch(struct vtime *vtime, int cpu)
 static u64 kcpustat_user_vtime(struct vtime *vtime)
 {
 	if (vtime->state == VTIME_USER)
-		return vtime->utime + vtime_delta(vtime);
+		return vtime_delta_filtered(vtime->utime, vtime);
 	else if (vtime->state == VTIME_GUEST)
-		return vtime->gtime + vtime_delta(vtime);
+		return vtime_delta_filtered(vtime->gtime, vtime);
 	return 0;
 }
 
@@ -932,7 +940,7 @@ static int kcpustat_field_vtime(u64 *cpustat,
 		switch (usage) {
 		case CPUTIME_SYSTEM:
 			if (state == VTIME_SYS)
-				*val += vtime->stime + vtime_delta(vtime);
+				*val += vtime_delta_filtered(vtime->stime, vtime);
 			break;
 		case CPUTIME_USER:
 			if (task_nice(tsk) <= 0)
@@ -944,11 +952,11 @@ static int kcpustat_field_vtime(u64 *cpustat,
 			break;
 		case CPUTIME_GUEST:
 			if (state == VTIME_GUEST && task_nice(tsk) <= 0)
-				*val += vtime->gtime + vtime_delta(vtime);
+				*val += vtime_delta_filtered(vtime->gtime, vtime);
 			break;
 		case CPUTIME_GUEST_NICE:
 			if (state == VTIME_GUEST && task_nice(tsk) > 0)
-				*val += vtime->gtime + vtime_delta(vtime);
+				*val += vtime_delta_filtered(vtime->gtime, vtime);
 			break;
 		default:
 			break;
@@ -1001,7 +1009,6 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 
 	do {
 		u64 *cpustat;
-		u64 delta;
 		int state;
 
 		seq = read_seqcount_begin(&vtime->seqcount);
@@ -1017,27 +1024,25 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 		if (state < VTIME_SYS)
 			continue;
 
-		delta = vtime_delta(vtime);
-
 		/*
 		 * Task runs either in user (including guest) or kernel space,
 		 * add pending nohz time to the right place.
 		 */
 		if (state == VTIME_SYS) {
-			cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
+			cpustat[CPUTIME_SYSTEM] += vtime_delta_filtered(vtime->stime, vtime);
 		} else if (state == VTIME_USER) {
 			if (task_nice(tsk) > 0)
-				cpustat[CPUTIME_NICE] += vtime->utime + delta;
+				cpustat[CPUTIME_NICE] += vtime_delta_filtered(vtime->utime, vtime);
 			else
-				cpustat[CPUTIME_USER] += vtime->utime + delta;
+				cpustat[CPUTIME_USER] += vtime_delta_filtered(vtime->utime, vtime);
 		} else {
 			WARN_ON_ONCE(state != VTIME_GUEST);
 			if (task_nice(tsk) > 0) {
-				cpustat[CPUTIME_GUEST_NICE] += vtime->gtime + delta;
-				cpustat[CPUTIME_NICE] += vtime->gtime + delta;
+				cpustat[CPUTIME_GUEST_NICE] += vtime_delta_filtered(vtime->gtime, vtime);
+				cpustat[CPUTIME_NICE] += vtime_delta_filtered(vtime->gtime, vtime);
 			} else {
-				cpustat[CPUTIME_GUEST] += vtime->gtime + delta;
-				cpustat[CPUTIME_USER] += vtime->gtime + delta;
+				cpustat[CPUTIME_GUEST] += vtime_delta_filtered(vtime->gtime, vtime);
+				cpustat[CPUTIME_USER] += vtime_delta_filtered(vtime->gtime, vtime);
 			}
 		}
 	} while (read_seqcount_retry(&vtime->seqcount, seq));

