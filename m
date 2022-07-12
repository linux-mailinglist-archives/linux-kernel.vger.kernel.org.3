Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2957C571A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiGLM5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGLM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:57:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C450A5E73;
        Tue, 12 Jul 2022 05:57:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B5AB1596;
        Tue, 12 Jul 2022 05:57:07 -0700 (PDT)
Received: from wubuntu (unknown [10.57.86.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F6ED3F70D;
        Tue, 12 Jul 2022 05:57:04 -0700 (PDT)
Date:   Tue, 12 Jul 2022 13:57:02 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <20220712125702.yg4eqbaakvj56k6m@wubuntu>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsyO9GM9mCydaybo@slm.duckdns.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/22 10:58, Tejun Heo wrote:
> (cc'ing Waiman)
> 
> On Mon, Jul 11, 2022 at 06:46:29PM +0100, Qais Yousef wrote:
> > Have you tried running with PROVE_LOCKDEP enabled? It'll help print a useful
> > output about the DEADLOCK. But your explanation was good and clear to me.
> 
> I don't think lockdep would be able to track CPU1 -> CPU2 dependency here
> unfortunately.

I see. It seems I got it wrong and CPU1 and CPU2 below run from the same
context, IIU Xuewen's response correctly this time that is.

> 
> > AFAIU:
> > 
> > 
> > CPU0                                     CPU1                                   CPU2
> > 
> > // attach task to a different
> > // cpuset cgroup via sysfs
> > __acquire(cgroup_threadgroup_rwsem)
> > 
> >                                          // pring up CPU2 online
> >                                          __acquire(cpu_hotplug_lock)
> >                                          // wait for CPU2 to come online
> >                                                                                 // bringup cpu online
> >                                                                                 // call cpufreq_online() which tries to create sugov kthread
> > __acquire(cpu_hotplug_lock)                                                     copy_process()
> >                                                                                    cgroup_can_fork()
> >                                                                                       cgroup_css_set_fork()
> >                                                                                       __acquire(cgroup_threadgroup_rwsem)
> > // blocks forever                        // blocks forever                            // blocks forever
> > 
> > 
> > Is this a correct summary of the problem?
> > 
> > The locks are held in reverse order and we end up with a DEADLOCK.
> > 
> > I believe the same happens on offline it's just the path to hold the
> > cgroup_threadgroup_rwsem on CPU2 is different.
> > 
> > This will be a tricky one. Your proposed patch might fix it for this case, but
> > if there's anything else that creates a kthread when a cpu goes online/offline
> > then we'll hit the same problem again.
> > 
> > I haven't reviewed your patch to be honest, but I think worth seeing first if
> > there's something that can be done at the 'right level' first.
> > 
> > Needs head scratching from my side at least. This is the not the first type of
> > locking issue between hotplug and cpuset :-/
> 
> Well, the only thing I can think of is always grabbing cpus_read_lock()
> before grabbing threadgroup_rwsem. Waiman, what do you think?

Is there a lot of subsystems beside cpuset that needs the cpus_read_lock()?
A quick grep tells me it's the only one.

Can't we instead use cpus_read_trylock() in cpuset_can_attach() so that we
either hold the lock successfully then before we go ahead and call
cpuset_attach(), or bail out and cancel the whole attach operation which should
unlock the threadgroup_rwsem() lock?

Sounds simple in theory, but as always the devil is in the details which
I don't have all inside my head. AFAICS cgroup_migration_execute() will call
ss->can_attach() for each subsystem. And it's the only caller of can_attach().

Not sure if it'd be safe to do cpus_read_unlock() at the end of cpuset_attach()
or we need to introduce an additional callback to 'cpuset_attach_finish()'
where we'd release the lock.

ie something like the below untested-and-for-demo-purposes-only patch:


diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 71a418858a5e..86c7c6aa0f12 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2226,6 +2226,12 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
        struct task_struct *task;
        int ret;

+       ret = cpus_read_trylock();
+       if (!ret) {
+               ret = -EBUSY;
+               goto out_unlock;
+       }
+
        /* used later by cpuset_attach() */
        cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
        cs = css_cs(css);
@@ -2289,7 +2295,8 @@ static void cpuset_attach(struct cgroup_taskset *tset)
        cgroup_taskset_first(tset, &css);
        cs = css_cs(css);

-       cpus_read_lock();
+       // Requires cpus_read_lock() to be held already
+       // releases cpus_read_lock() when done
        percpu_down_write(&cpuset_rwsem);

        guarantee_online_mems(cs, &cpuset_attach_nodemask_to);


Cheers

--
Qais Yousef
