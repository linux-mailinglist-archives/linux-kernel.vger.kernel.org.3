Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5563357509F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbiGNOSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbiGNOSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:18:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D859A112A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:18:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0F7A41FB51;
        Thu, 14 Jul 2022 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657808318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRYpzb6LIWbbWphMBkUMzVqsIrAi3ylOIRjAlXln8lU=;
        b=i7FCf848n8urHD64muK7nmATRmwmxFYqZvNuJ2cEQEJW1+s+hFo8AbQOIGG6pBfw5MI79L
        xoR22BMiiQN9YODyaNwRzBW3BC5wZqHTqD/dltJ9vprcD7cg6932M0XC0JNrM9QrJSBm9v
        PNRrMNyfTZqEQooSg0G5AS7UIfo+v/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657808318;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRYpzb6LIWbbWphMBkUMzVqsIrAi3ylOIRjAlXln8lU=;
        b=THlZ+LI+q2S6YGQTxJ3m6+Uv3cjbwiz0XSgIRiu1Jn/bmmpAsFSD6CJXgVWs7cGGfNhYQg
        g4ZyT2KvEmOx2IBA==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 50B622C141;
        Thu, 14 Jul 2022 14:18:37 +0000 (UTC)
Date:   Thu, 14 Jul 2022 15:18:34 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Libo Chen <libo.chen@oracle.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Message-ID: <20220714141834.GC3493@suse.de>
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <2c0c61a1c4c54d06905279a9a724a9390d9ee5c3.camel@linux.intel.com>
 <0917f479-b6aa-19de-3d6a-6fd422df4d21@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <0917f479-b6aa-19de-3d6a-6fd422df4d21@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:17:33PM -0700, Libo Chen wrote:
> 
> 
> On 7/13/22 09:40, Tim Chen wrote:
> > On Mon, 2022-07-11 at 15:47 -0700, Libo Chen wrote:
> > > Barry Song first pointed out that replacing sync wakeup with regular wakeup
> > > seems to reduce overeager wakeup pulling and shows noticeable performance
> > > improvement.[1]
> > > 
> > > This patch argues that allowing sync for wakeups from interrupt context
> > > is a bug and fixing it can improve performance even when irq/softirq is
> > > evenly spread out.
> > > 
> > > For wakeups from ISR, the waking CPU is just the CPU of ISR and the so-called
> > > waker can be any random task that happens to be running on that CPU when the
> > > interrupt comes in. This is completely different from other wakups where the
> > > task running on the waking CPU is the actual waker. For example, two tasks
> > > communicate through a pipe or mutiple tasks access the same critical section,
> > > etc. This difference is important because with sync we assume the waker will
> > > get off the runqueue and go to sleep immedately after the wakeup. The
> > > assumption is built into wake_affine() where it discounts the waker's presence
> > > from the runqueue when sync is true. The random waker from interrupts bears no
> > > relation to the wakee and don't usually go to sleep immediately afterwards
> > > unless wakeup granularity is reached. Plus the scheduler no longer enforces the
> > > preepmtion of waker for sync wakeup as it used to before
> > > patch f2e74eeac03ffb7 ("sched: Remove WAKEUP_SYNC feature"). Enforcing sync
> > > wakeup preemption for wakeups from interrupt contexts doesn't seem to be
> > > appropriate too but at least sync wakeup will do what it's supposed to do.
> > Will there be scenarios where you do want the task being woken up be pulled
> > to the CPU where the interrupt happened, as the data that needs to be accessed is
> > on local CPU/NUMA that interrupt happened?  For example, interrupt associated with network
> > packets received.  Sync still seems desirable, at least if there is no task currently
> > running on the CPU where interrupt happened.  So maybe we should have some consideration
> > of the load on the CPU/NUMA before deciding whether we should do sync wake for such
> > interrupt.
> > 
> There are only two places where sync wakeup matters: wake_affine_idle() and
> wake_affine_weight().
> In wake_affine_idle(), it considers pulling if there is one runnable on the
> waking CPU because
> of the belief that this runnable will voluntarily get off the runqueue. In
> wake_affine_weight(),
> it basically takes off the waker's load again assuming the waker goes to
> sleep after the wakeup.
> My argument is that this assumption doesn't really hold for wakeups from the
> interrupt contexts
> when the waking CPU is non-idle. Wakeups from task context? sure, it seems
> to be a reasonable
> assumption. For your idle case, I totally agree but I don't think having
> sync or not will actually
> have any impacts here giving what the code does. Real impact comes fromMel's
> patch 7332dec055f2457c3
> which makes it less likely to pull tasks when the waking CPU is idle. I
> believe we should consider
> reverting 7332dec055f2 because a significant RDS latency regression has been
> spotted recently on our
> system due to this patch.
> 

The intent of 7332dec055f2 was to prevent harmful cross-node accesses.
It still allowed cache-local migrations on the assumption that the incoming
data was critical enough to justify losing any other cache-hot data. You
state explicitly that "the interrupt CPU isn't as performance critical as
cache from its previous CPU" so that assumption was incorrect, at least
in your case. I don't have a counter example where the interrupt data *is*
more important than any other cache-hot data so the check can go.

I think a revert would not achieve what you want as a plain revert would
still allow an interrupt to pull a task from an arbitrary location as sync
is not checked. A follow-up to your patch or an updated version should not
check available_idle_cpu at all in wake_affine_idle as it's only idle the
wake is from interrupt context and vcpu_is_preempted is not necessarily
justification for pulling a task due to an interrupt.

Something like this but needs testing with your target loads, particularly
the RDS (Relational Database Service?) latency regression;

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b7b275672c89..e55a3a67a442 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5975,8 +5975,8 @@ static int wake_wide(struct task_struct *p)
  * soonest. For the purpose of speed we only consider the waking and previous
  * CPU.
  *
- * wake_affine_idle() - only considers 'now', it check if the waking CPU is
- *			cache-affine and is (or	will be) idle.
+ * wake_affine_idle() - only considers 'now', it checks if the waker task is a
+ *			sync wakeup from a CPU that should be idle soon.
  *
  * wake_affine_weight() - considers the weight to reflect the average
  *			  scheduling latency of the CPUs. This seems to work
@@ -5985,21 +5985,6 @@ static int wake_wide(struct task_struct *p)
 static int
 wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 {
-	/*
-	 * If this_cpu is idle, it implies the wakeup is from interrupt
-	 * context. Only allow the move if cache is shared. Otherwise an
-	 * interrupt intensive workload could force all tasks onto one
-	 * node depending on the IO topology or IRQ affinity settings.
-	 *
-	 * If the prev_cpu is idle and cache affine then avoid a migration.
-	 * There is no guarantee that the cache hot data from an interrupt
-	 * is more important than cache hot data on the prev_cpu and from
-	 * a cpufreq perspective, it's better to have higher utilisation
-	 * on one CPU.
-	 */
-	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
-		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
-
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
 		return this_cpu;
 
