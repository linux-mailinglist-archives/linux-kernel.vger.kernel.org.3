Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B90557095F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiGKRqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiGKRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:46:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17E872AC69;
        Mon, 11 Jul 2022 10:46:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F288816A3;
        Mon, 11 Jul 2022 10:46:33 -0700 (PDT)
Received: from wubuntu (unknown [10.57.86.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40E7F3F792;
        Mon, 11 Jul 2022 10:46:31 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:46:29 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <20220711174629.uehfmqegcwn2lqzu@wubuntu>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220705123705.764-1-xuewen.yan@unisoc.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuewen

+CC Tejun who might be interested.

On 07/05/22 20:37, Xuewen Yan wrote:
> There is a deadlock between cpu_hotplug_lock sem and cgroup_threadgroup_rwsem.
> And both cpu online and cpu offline scenarios will cause deadlock:
> 
> [1] cpu online:
> 
> 1. first, thread-A get the cgroup_threadgroup_rwsem and waiting foe the cpu_hotplug_lock:
> 
>   [ffffffc00f9c3850] __switch_to at ffffffc0081229d4
>   [ffffffc00f9c38b0] __schedule at ffffffc009c824f8
>   [ffffffc00f9c3910] schedule at ffffffc009c82b50
>   [ffffffc00f9c3970] percpu_rwsem_wait at ffffffc00828fbcc
>   [ffffffc00f9c39b0] __percpu_down_read at ffffffc008290180     <<< try to get cpu_hotplug_lock
>   [ffffffc00f9c39e0] cpus_read_lock at ffffffc0081dade8
>   [ffffffc00f9c3a20] cpuset_attach at ffffffc008366ed4
>   [ffffffc00f9c3a90] cgroup_migrate_execute at ffffffc00834f7d8
>   [ffffffc00f9c3b60] cgroup_attach_task at ffffffc0083539b8
>   [ffffffc00f9c3bd0] __cgroup1_procs_write at ffffffc00835f6ac   <<< get the cgroup_threadgroup_rwsem
>   [ffffffc00f9c3c30] cgroup1_tasks_write at ffffffc00835f018
>   [ffffffc00f9c3c60] cgroup_file_write at ffffffc008348b04
>   [ffffffc00f9c3c90] kernfs_fop_write_iter at ffffffc0087544d8
>   [ffffffc00f9c3d50] vfs_write at ffffffc008607a8c
>   [ffffffc00f9c3db0] ksys_write at ffffffc0086076d8
>   [ffffffc00f9c3df0] __arm64_sys_write at ffffffc008607640
>   [ffffffc00f9c3e10] invoke_syscall at ffffffc00813dccc
>   [ffffffc00f9c3e30] el0_svc_common at ffffffc00813dbe4
>   [ffffffc00f9c3e70] do_el0_svc at ffffffc00813dac8
>   [ffffffc00f9c3e80] el0_svc at ffffffc0098836c8
>   [ffffffc00f9c3ea0] el0t_64_sync_handler at ffffffc00988363c
>   [ffffffc00f9c3fe0] el0t_64_sync at ffffffc008091e44
> 
> 2. Thread-B get the cpu_hotplug_lock and waiting for cpuhp/x:
> 
>   [ffffffc01245b740] __switch_to at ffffffc0081229d4
>   [ffffffc01245b7a0] __schedule at ffffffc009c824f8
>   [ffffffc01245b800] schedule at ffffffc009c82b50
>   [ffffffc01245b880] schedule_timeout at ffffffc009c8a144
>   [ffffffc01245b8e0] wait_for_common at ffffffc009c83dac     <<< waiting for cpuhp/x complete
>   [ffffffc01245b940] cpuhp_kick_ap at ffffffc0081dc8ac       <<< wake up cpuhp/x
>   [ffffffc01245b980] bringup_cpu at ffffffc0081db7f0
>   [ffffffc01245ba00] cpuhp_invoke_callback at ffffffc0081dc000
>   [ffffffc01245ba60] cpuhp_up_callbacks at ffffffc0081dd9b0
>   [ffffffc01245bac0] _cpu_up at ffffffc0081dd844            <<< percpu_down_write(&cpu_hotplug_lock)
>   [ffffffc01245bb40] cpu_up at ffffffc0081dd100
>   [ffffffc01245bb80] cpu_subsys_online at ffffffc008d8ebe4
>   [ffffffc01245bb90] device_online at ffffffc008d77dec
>   [ffffffc01245bbd0] online_store at ffffffc008d77bb8
>   [ffffffc01245bc30] dev_attr_store at ffffffc008d7c8b8
>   [ffffffc01245bc60] sysfs_kf_write at ffffffc008757894
>   [ffffffc01245bc90] kernfs_fop_write_iter at ffffffc0087544d8
>   [ffffffc01245bd50] vfs_write at ffffffc008607a8c
>   [ffffffc01245bdb0] ksys_write at ffffffc0086076d8
>   [ffffffc01245bdf0] __arm64_sys_write at ffffffc008607640
>   [ffffffc01245be10] invoke_syscall at ffffffc00813dccc
>   [ffffffc01245be30] el0_svc_common at ffffffc00813dc14
>   [ffffffc01245be70] do_el0_svc at ffffffc00813dac8
>   [ffffffc01245be80] el0_svc at ffffffc0098836c8
>   [ffffffc01245bea0] el0t_64_sync_handler at ffffffc00988363c
>   [ffffffc01245bfe0] el0t_64_sync at ffffffc008091e44
> 
> 3. cpuhp/x would call cpufreq_online and the schedutil need create kthread, as a result it need wait for kthreadd:
> 
>   [ffffffc00b653860] __switch_to at ffffffc0081229d4
>   [ffffffc00b6538c0] __schedule at ffffffc009c824f8
>   [ffffffc00b653920] schedule at ffffffc009c82b50
>   [ffffffc00b6539a0] schedule_timeout at ffffffc009c8a144
>   [ffffffc00b653a00] wait_for_common at ffffffc009c83dac     <<< wait for kthreadd
>   [ffffffc00b653ad0] __kthread_create_on_node at ffffffc0082296b8
>   [ffffffc00b653b90] kthread_create_on_node at ffffffc008229a58
>   [ffffffc00b653bb0] sugov_init at ffffffc001d01414
>   [ffffffc00b653c00] cpufreq_init_governor at ffffffc009179a48
>   [ffffffc00b653c50] cpufreq_set_policy at ffffffc009179360
>   [ffffffc00b653cb0] cpufreq_online at ffffffc00917c3e4
>   [ffffffc00b653d10] cpuhp_cpufreq_online at ffffffc00917ee3c
>   [ffffffc00b653d70] cpuhp_invoke_callback at ffffffc0081dc000
>   [ffffffc00b653dd0] cpuhp_thread_fun at ffffffc0081df47c
>   [ffffffc00b653e10] smpboot_thread_fn at ffffffc008234718
>   [ffffffc00b653e70] kthread at ffffffc00822ac84
> 
> 4. the kthreadd is trying to get cgroup_threadgroup_rwsem...
> 
>   [ffffffc008073a70] __switch_to at ffffffc0081229d4
>   [ffffffc008073ad0] __schedule at ffffffc009c824f8
>   [ffffffc008073b30] schedule at ffffffc009c82b50
>   [ffffffc008073b90] percpu_rwsem_wait at ffffffc00828fbcc  <<< cgroup_threadgroup_rwsem
>   [ffffffc008073bd0] __percpu_down_read at ffffffc008290180
>   [ffffffc008073c00] cgroup_css_set_fork at ffffffc008357ecc
>   [ffffffc008073c60] cgroup_can_fork at ffffffc008357bb4
>   [ffffffc008073d00] copy_process at ffffffc0081d18c4
>   [ffffffc008073d90] kernel_clone at ffffffc0081d088c
>   [ffffffc008073e50] kthreadd at ffffffc00822a8e4
> 
> Finally, the Thread-A and Thread-B would be blockd forever.
> 
> [2]cpu_offline:
> 
> 1. first, thread-A get the cgroup_threadgroup_rwsem and waiting foe the cpu_hotplug_lock:
> 
>   [ffffffc00f9c3850] __switch_to at ffffffc0081229d4
>   [ffffffc00f9c38b0] __schedule at ffffffc009c824f8
>   [ffffffc00f9c3910] schedule at ffffffc009c82b50
>   [ffffffc00f9c3970] percpu_rwsem_wait at ffffffc00828fbcc
>   [ffffffc00f9c39b0] __percpu_down_read at ffffffc008290180     <<< try to get cpu_hotplug_lock
>   [ffffffc00f9c39e0] cpus_read_lock at ffffffc0081dade8
>   [ffffffc00f9c3a20] cpuset_attach at ffffffc008366ed4
>   [ffffffc00f9c3a90] cgroup_migrate_execute at ffffffc00834f7d8
>   [ffffffc00f9c3b60] cgroup_attach_task at ffffffc0083539b8
>   [ffffffc00f9c3bd0] __cgroup1_procs_write at ffffffc00835f6ac   <<< get the cgroup_threadgroup_rwsem
>   [ffffffc00f9c3c30] cgroup1_tasks_write at ffffffc00835f018
>   [ffffffc00f9c3c60] cgroup_file_write at ffffffc008348b04
>   [ffffffc00f9c3c90] kernfs_fop_write_iter at ffffffc0087544d8
>   [ffffffc00f9c3d50] vfs_write at ffffffc008607a8c
>   [ffffffc00f9c3db0] ksys_write at ffffffc0086076d8
>   [ffffffc00f9c3df0] __arm64_sys_write at ffffffc008607640
>   [ffffffc00f9c3e10] invoke_syscall at ffffffc00813dccc
>   [ffffffc00f9c3e30] el0_svc_common at ffffffc00813dbe4
>   [ffffffc00f9c3e70] do_el0_svc at ffffffc00813dac8
>   [ffffffc00f9c3e80] el0_svc at ffffffc0098836c8
>   [ffffffc00f9c3ea0] el0t_64_sync_handler at ffffffc00988363c
>   [ffffffc00f9c3fe0] el0t_64_sync at ffffffc008091e44
> 
> 2. Thread-B get the cpu_hotplug_lock and waiting for cpuhp/x:
> 
>   [ffffffc01245b740] __switch_to at ffffffc0081229d4
>   [ffffffc01245b7a0] __schedule at ffffffc009c824f8
>   [ffffffc01245b800] schedule at ffffffc009c82b50
>   [ffffffc01245b880] schedule_timeout at ffffffc009c8a144
>   [ffffffc01245b8e0] wait_for_common at ffffffc009c83dac     <<< waiting for cpuhp/x complete
>   [ffffffc01245b940] cpuhp_kick_ap at ffffffc0081dc8ac       <<< wake up cpuhp/x
>   [ffffffc01245b980] bringup_cpu at ffffffc0081db7f0
>   [ffffffc01245ba00] cpuhp_invoke_callback at ffffffc0081dc000
>   [ffffffc01245ba60] cpuhp_up_callbacks at ffffffc0081dd9b0
>   [ffffffc01245bac0] _cpu_up at ffffffc0081dd844            <<< percpu_down_write(&cpu_hotplug_lock)
>   [ffffffc01245bb40] cpu_up at ffffffc0081dd100
>   [ffffffc01245bb80] cpu_subsys_online at ffffffc008d8ebe4
>   [ffffffc01245bb90] device_online at ffffffc008d77dec
>   [ffffffc01245bbd0] online_store at ffffffc008d77bb8
>   [ffffffc01245bc30] dev_attr_store at ffffffc008d7c8b8
>   [ffffffc01245bc60] sysfs_kf_write at ffffffc008757894
>   [ffffffc01245bc90] kernfs_fop_write_iter at ffffffc0087544d8
>   [ffffffc01245bd50] vfs_write at ffffffc008607a8c
>   [ffffffc01245bdb0] ksys_write at ffffffc0086076d8
>   [ffffffc01245bdf0] __arm64_sys_write at ffffffc008607640
>   [ffffffc01245be10] invoke_syscall at ffffffc00813dccc
>   [ffffffc01245be30] el0_svc_common at ffffffc00813dc14
>   [ffffffc01245be70] do_el0_svc at ffffffc00813dac8
>   [ffffffc01245be80] el0_svc at ffffffc0098836c8
>   [ffffffc01245bea0] el0t_64_sync_handler at ffffffc00988363c
>   [ffffffc01245bfe0] el0t_64_sync at ffffffc008091e44
> 
> 3.cpuhp/x would call cpufreq_offline and schedutil need stop_kthread:
> 
>   [ffffffc00b683a60] __switch_to at ffffffc0081229d4
>   [ffffffc00b683ac0] __schedule at ffffffc009c824f8
>   [ffffffc00b683b20] schedule at ffffffc009c82b50
>   [ffffffc00b683ba0] schedule_timeout at ffffffc009c8a144
>   [ffffffc00b683c00] wait_for_common at ffffffc009c83dac <<< waiting for sugov complete
>   [ffffffc00b683c60] kthread_stop at ffffffc008228128   <<< wakeup sugov
>   [ffffffc00b683c90] sugov_exit at ffffffc001d016a8
>   [ffffffc00b683cc0] cpufreq_offline at ffffffc00917b4b8
>   [ffffffc00b683d10] cpuhp_cpufreq_offline at ffffffc00917ee70
>   [ffffffc00b683d70] cpuhp_invoke_callback at ffffffc0081dc000
>   [ffffffc00b683dd0] cpuhp_thread_fun at ffffffc0081df47c
>   [ffffffc00b683e10] smpboot_thread_fn at ffffffc008234718
>   [ffffffc00b683e70] kthread at ffffffc00822ac84
> 
> 4. the sugov thread is waiting cgroup_threadgroup_rwsem:
> 
>   [ffffffc01258bc10] __switch_to at ffffffc0081229d4
>   [ffffffc01258bc70] __schedule at ffffffc009c824f8
>   [ffffffc01258bcd0] schedule at ffffffc009c82b50
>   [ffffffc01258bd30] percpu_rwsem_wait at ffffffc00828fbcc  <<< wait for cgroup_threadgroup_rwsem
>   [ffffffc01258bd70] __percpu_down_read at ffffffc008290180
>   [ffffffc01258bdb0] exit_signals at ffffffc0082074c8
>   [ffffffc01258be10] do_exit at ffffffc0081e5130
>   [ffffffc01258be70] kthread at ffffffc00822ac8c
> 
> Finally, the Thread-A and Thread-B would be blockd forever.
> 
> Combining the above two situations, the reason why Thread-A and Thread-B are blocked is because cpuhp/x is blocked.
> If we can solve the problem that cpuhp is not blocked, Thread-A and Thread-B can run normally.
> So we can let schedutil do not create or destory thread, so that the cpuhp/x would not be blocked.
> 
> So init the sugov thread just once to prevent the above deadlock.
> 
> Signed-off-by: Ke Wang <ke.wang@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---

Have you tried running with PROVE_LOCKDEP enabled? It'll help print a useful
output about the DEADLOCK. But your explanation was good and clear to me.

AFAIU:


CPU0                                     CPU1                                   CPU2

// attach task to a different
// cpuset cgroup via sysfs
__acquire(cgroup_threadgroup_rwsem)

                                         // pring up CPU2 online
                                         __acquire(cpu_hotplug_lock)
                                         // wait for CPU2 to come online
                                                                                // bringup cpu online
                                                                                // call cpufreq_online() which tries to create sugov kthread
__acquire(cpu_hotplug_lock)                                                     copy_process()
                                                                                   cgroup_can_fork()
                                                                                      cgroup_css_set_fork()
                                                                                      __acquire(cgroup_threadgroup_rwsem)
// blocks forever                        // blocks forever                            // blocks forever


Is this a correct summary of the problem?

The locks are held in reverse order and we end up with a DEADLOCK.

I believe the same happens on offline it's just the path to hold the
cgroup_threadgroup_rwsem on CPU2 is different.

This will be a tricky one. Your proposed patch might fix it for this case, but
if there's anything else that creates a kthread when a cpu goes online/offline
then we'll hit the same problem again.

I haven't reviewed your patch to be honest, but I think worth seeing first if
there's something that can be done at the 'right level' first.

Needs head scratching from my side at least. This is the not the first type of
locking issue between hotplug and cpuset :-/


Thanks

--
Qais Yousef
