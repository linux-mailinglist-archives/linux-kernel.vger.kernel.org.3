Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900EF584D83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiG2IkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiG2IkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:40:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAF4A84EC9;
        Fri, 29 Jul 2022 01:39:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B35921063;
        Fri, 29 Jul 2022 01:39:54 -0700 (PDT)
Received: from wubuntu (unknown [10.57.9.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E41E3F73B;
        Fri, 29 Jul 2022 01:39:51 -0700 (PDT)
Date:   Fri, 29 Jul 2022 09:39:49 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Lukasz Luba <Lukasz.Luba@arm.com>, pengcheng.lai@unisoc.com
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <20220729083949.6uaojl3vqyvwpkuk@wubuntu>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org>
 <c1426573-92a7-9f0d-a6b8-aa612248b9a9@redhat.com>
 <Ys41ZF5TmSnLLNRB@slm.duckdns.org>
 <CAB8ipk-8cbur-m733py-cw4bXCt7gkd8gAOXtKO+-fV1B2EeZw@mail.gmail.com>
 <YuGbYCfAG81mZBnN@slm.duckdns.org>
 <CAB8ipk_gCLtvEahsp2DvPJf4NxRsM8WCYmmH=yTd7zQE+81_Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8ipk_gCLtvEahsp2DvPJf4NxRsM8WCYmmH=yTd7zQE+81_Yg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/22 15:33, Xuewen Yan wrote:
> Hi Tejun
> 
> On Thu, Jul 28, 2022 at 4:09 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> >
> > Can youp please see whether the following patch fixes the problem?
> >
> 
> I have tested the patch, sadly, although the original deadlock call
> stack is gone, there seems to be a new problem.
> I did a preliminary analysis, but no further in-depth analysis. I
> haven't found the root cause yet, but I think I should let you know
> the test results first.
> Once I find the root cause, I'll report back immediately.
> The thread-A is waiting for the cpu_hotplug_lock's writer, but the
> writer is waiting for the readers:

I *think* it's because we haven't removed cpus_read_lock() from
cpuset_attach(). So we end up holding the lock twice in the same path. Since we
hold it unconditionally now, we should remove cpuset dependency on
cpus_read_lock() I believe.


Cheers

--
Qais Yousef

> 
> PID: 1106   TASK: ffffff8097e90000  CPU: 7   COMMAND: "OomAdjuster"
>  #0 [ffffffc011a23850] __switch_to at ffffffc0081229b4
>  #1 [ffffffc011a238b0] __schedule at ffffffc009c824f8
>  #2 [ffffffc011a23910] schedule at ffffffc009c82b50
>  #3 [ffffffc011a23970] percpu_rwsem_wait at ffffffc00828fbf4
>  #4 [ffffffc011a239b0] __percpu_down_read at ffffffc0082901a8
>  #5 [ffffffc011a239e0] cpus_read_lock at ffffffc0081dadc8
>  #6 [ffffffc011a23a20] cpuset_attach at ffffffc008366f10
>  #7 [ffffffc011a23a90] cgroup_migrate_execute at ffffffc00834f808
>  #8 [ffffffc011a23b60] cgroup_attach_task at ffffffc0083539f0
>  #9 [ffffffc011a23bd0] __cgroup1_procs_write at ffffffc00835f6e8
> #10 [ffffffc011a23c30] cgroup1_tasks_write at ffffffc00835f054
> #11 [ffffffc011a23c60] cgroup_file_write at ffffffc008348b2c
> #12 [ffffffc011a23c90] kernfs_fop_write_iter at ffffffc008754514
> #13 [ffffffc011a23d50] vfs_write at ffffffc008607ac8
> #14 [ffffffc011a23db0] ksys_write at ffffffc008607714
> #15 [ffffffc011a23df0] __arm64_sys_write at ffffffc00860767c
> #16 [ffffffc011a23e10] invoke_syscall at ffffffc00813dcac
> #17 [ffffffc011a23e30] el0_svc_common at ffffffc00813dbc4
> #18 [ffffffc011a23e70] do_el0_svc at ffffffc00813daa8
> #19 [ffffffc011a23e80] el0_svc at ffffffc0098828d8
> #20 [ffffffc011a23ea0] el0t_64_sync_handler at ffffffc00988284c
> #21 [ffffffc011a23fe0] el0t_64_sync at ffffffc008091e44
> 
> cpu_hotplug_lock = $3 = {
>   rss = {
>     gp_state = 2,
>     gp_count = 1,
>     gp_wait = {
>       lock = {
>         {
>           rlock = {
>             raw_lock = {
>               {
>                 val = {
>                   counter = 0
>                 },
>                 {
>                   locked = 0 '\000',
>                   pending = 0 '\000'
>                 },
>                 {
>                   locked_pending = 0,
>                   tail = 0
>                 }
>               }
>             }
>           }
>         }
>       },
>       head = {
>         next = 0xffffffc00b0eb6a0 <cpu_hotplug_lock+16>,
>         prev = 0xffffffc00b0eb6a0 <cpu_hotplug_lock+16>
>       }
>     },
>     cb_head = {
>       next = 0x0,
>       func = 0x0
>     }
>   },
>   read_count = 0xffffffc00b0a0808 <__percpu_rwsem_rc_cpu_hotplug_lock>,
>   writer = {
>     task = 0xffffff80f303ca00
>   },
>   {
>     waiters = {
>       lock = {
>         {
>           rlock = {
>             raw_lock = {
>               {
>                 val = {
>                   counter = 0
>                 },
>                 {
>                   locked = 0 '\000',
>                   pending = 0 '\000'
>                 },
>                 {
>                   locked_pending = 0,
>                   tail = 0
>                 }
>               }
>             }
>           }
>         }
>       },
>       head = {
>         next = 0xffffffc011a23958,
>         prev = 0xffffffc01430bcb8
>       }
>     },
>     destroy_list_entry = {
>       next = 0x0,
>       prev = 0xffffffc011a23958
>     }
>   },
>   block = {
>     counter = 1
>   }
> }
> 
> PID: 15760  TASK: ffffff80f303ca00  CPU: 5   COMMAND: "test.sh"
>  #0 [ffffffc0129639a0] __switch_to at ffffffc0081229b4
>  #1 [ffffffc012963a00] __schedule at ffffffc009c824f8
>  #2 [ffffffc012963a60] schedule at ffffffc009c82b50
>  #3 [ffffffc012963a90] percpu_down_write at ffffffc00828f9d8
>  #4 [ffffffc012963ae0] _cpu_down at ffffffc009884550
>  #5 [ffffffc012963b40] cpu_device_down at ffffffc0081df814
>  #6 [ffffffc012963b60] cpu_subsys_offline at ffffffc008d8dd8c
>  #7 [ffffffc012963b90] device_offline at ffffffc008d77124
>  #8 [ffffffc012963bd0] online_store at ffffffc008d76d44
>  #9 [ffffffc012963c30] dev_attr_store at ffffffc008d7ba30
> #10 [ffffffc012963c60] sysfs_kf_write at ffffffc0087578d0
> #11 [ffffffc012963c90] kernfs_fop_write_iter at ffffffc008754514
> #12 [ffffffc012963d50] vfs_write at ffffffc008607ac8
> #13 [ffffffc012963db0] ksys_write at ffffffc008607714
> #14 [ffffffc012963df0] __arm64_sys_write at ffffffc00860767c
> #15 [ffffffc012963e10] invoke_syscall at ffffffc00813dcac
> #16 [ffffffc012963e30] el0_svc_common at ffffffc00813dbf4
> #17 [ffffffc012963e70] do_el0_svc at ffffffc00813daa8
> #18 [ffffffc012963e80] el0_svc at ffffffc0098828d8
> #19 [ffffffc012963ea0] el0t_64_sync_handler at ffffffc00988284c
> #20 [ffffffc012963fe0] el0t_64_sync at ffffffc008091e44
> 
> Thanks!
> BR
> -- 
> xuewen.yan
> 
> > Thanks.
> >
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 13c8e91d78620..7caefc8af9127 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -2345,6 +2345,38 @@ int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
> >  }
> >  EXPORT_SYMBOL_GPL(task_cgroup_path);
> >
> > +/**
> > + * lock_threadgroup - Stabilize threadgroups
> > + *
> > + * cgroup migration operations need the threadgroups stabilized against forks
> > + * and exits, which can be achieved by write-locking cgroup_threadgroup_rwsem.
> > + *
> > + * Note that write-locking threadgdroup_rwsem is nested inside CPU hotplug
> > + * disable. This is because cpuset needs CPU hotplug disabled during ->attach()
> > + * and bringing up a CPU may involve creating new tasks which can require
> > + * read-locking threadgroup_rwsem. If we call cpuset's ->attach() with
> > + * threadgroup_rwsem write-locked with hotplug enabled, we can deadlock by
> > + * cpuset waiting for an on-going CPU hotplug operation which in turn is waiting
> > + * for the threadgroup_rwsem to be released to create new tasks. See the
> > + * following for more details:
> > + *
> > + * http://lkml.kernel.org/r/20220711174629.uehfmqegcwn2lqzu@wubuntu
> > + */
> > +static void lock_threadgroup(void)
> > +{
> > +       cpus_read_lock();
> > +       percpu_down_write(&cgroup_threadgroup_rwsem);
> > +}
> > +
> > +/**
> > + * lock_threadgroup - Undo lock_threadgroup
> > + */
> > +static void unlock_threadgroup(void)
> > +{
> > +       percpu_up_write(&cgroup_threadgroup_rwsem);
> > +       cpus_read_unlock();
> > +}
> > +
> >  /**
> >   * cgroup_migrate_add_task - add a migration target task to a migration context
> >   * @task: target task
> > @@ -2822,7 +2854,6 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
> >
> >  struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
> >                                              bool *locked)
> > -       __acquires(&cgroup_threadgroup_rwsem)
> >  {
> >         struct task_struct *tsk;
> >         pid_t pid;
> > @@ -2840,7 +2871,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
> >          */
> >         lockdep_assert_held(&cgroup_mutex);
> >         if (pid || threadgroup) {
> > -               percpu_down_write(&cgroup_threadgroup_rwsem);
> > +               lock_threadgroup();
> >                 *locked = true;
> >         } else {
> >                 *locked = false;
> > @@ -2876,7 +2907,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
> >
> >  out_unlock_threadgroup:
> >         if (*locked) {
> > -               percpu_up_write(&cgroup_threadgroup_rwsem);
> > +               unlock_threadgroup();
> >                 *locked = false;
> >         }
> >  out_unlock_rcu:
> > @@ -2885,7 +2916,6 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
> >  }
> >
> >  void cgroup_procs_write_finish(struct task_struct *task, bool locked)
> > -       __releases(&cgroup_threadgroup_rwsem)
> >  {
> >         struct cgroup_subsys *ss;
> >         int ssid;
> > @@ -2894,7 +2924,8 @@ void cgroup_procs_write_finish(struct task_struct *task, bool locked)
> >         put_task_struct(task);
> >
> >         if (locked)
> > -               percpu_up_write(&cgroup_threadgroup_rwsem);
> > +               unlock_threadgroup();
> > +
> >         for_each_subsys(ss, ssid)
> >                 if (ss->post_attach)
> >                         ss->post_attach();
> > @@ -2953,7 +2984,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
> >
> >         lockdep_assert_held(&cgroup_mutex);
> >
> > -       percpu_down_write(&cgroup_threadgroup_rwsem);
> > +       lock_threadgroup();
> >
> >         /* look up all csses currently attached to @cgrp's subtree */
> >         spin_lock_irq(&css_set_lock);
> > @@ -2984,7 +3015,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
> >         ret = cgroup_migrate_execute(&mgctx);
> >  out_finish:
> >         cgroup_migrate_finish(&mgctx);
> > -       percpu_up_write(&cgroup_threadgroup_rwsem);
> > +       unlock_threadgroup();
> >         return ret;
> >  }
> >
