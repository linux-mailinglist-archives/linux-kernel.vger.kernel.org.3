Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CB64CDD71
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 20:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiCDTzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 14:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiCDTyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 14:54:53 -0500
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D41204FC2;
        Fri,  4 Mar 2022 11:50:16 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id f37so15914324lfv.8;
        Fri, 04 Mar 2022 11:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TEtjA80li3GwoTXdCbbmIi4gGeHzm++a4iSp6bbz+E=;
        b=FESTVEuNGelu7Lws+Gyo7sgSeqqjh6ymS8+wMHlIqqHv84QCj6oDx7HlwReD/Z7E62
         4XXwN20831ENBPalhKhoF6UYQu6ORzT9qs9eS455qG7+lLLIiDWkeVL6TwSQx6vUus3G
         LMPFMN8rWICp2n7SkutoQXzO1OIVHEXQijQPasKqQlGl54B3ZZTqdEGSfdtT/l98IC3T
         sH5uaoqXQrzC6olZVuavKLPnXPlxnOtTFDHloO6EXB9oGMnZnnVIOja+/iRa5MhcHRKP
         rDUE6DX0oojMnXKHgFfhd/IBnOL1ZflzQa7FRozbAWF2MnbfUCrAHyPr3SctR/pE+Awb
         yrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TEtjA80li3GwoTXdCbbmIi4gGeHzm++a4iSp6bbz+E=;
        b=qsPFsNL8Y4OcnwFZ2ugJohd7Q6pPDg3kiNruJoZ7jJHuY6ITvLydg7z7iHr75uYMYG
         TnoqnO8OMgi4mvgNlfkEmWnpO7iaoc9b8rTElImUxmx8K3lmRyCua61pwDhGncsSUyYR
         XlWEHbEAEb/nNBCR/QN0O8LO41lvHPKOaY9onKo2TSMsImRYN3DnQiRfNAiX6pkUUiGH
         xxp/WOuRY8W9yd2Fi9yiG3zICiA+WXi8OYTdkWhVz3rFyAfk/nLj9GnGeaMNOU5W5hNP
         JSjT35RrXvhtG60238ebxU4xDmu1y2EGty2PqFkf8PvmN+sXQ3rhfUIYefLv9rE5M4ZF
         vuAQ==
X-Gm-Message-State: AOAM533cMjcjgvEWgXBvGOws332dfo3MNSF40/YKmHyptYIzLZduZ6zF
        3HsB8QWtHDZdOjDXlW2V+IaLvytx8tn+05MmhHpJPn/RmVQ=
X-Google-Smtp-Source: ABdhPJyqwN6yEeOCao1XEyjZhkWhjKismWA4n5RQiTHqAptBU9tQbqSH3n9W6clihQBCGqsaWND9XKHFkgV/odrWsOU=
X-Received: by 2002:a17:907:1c0c:b0:6da:7d3c:ba07 with SMTP id
 nc12-20020a1709071c0c00b006da7d3cba07mr286475ejc.486.1646422724829; Fri, 04
 Mar 2022 11:38:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYs+Qc3rAONJBmyQXFnYmrzFBJ8GMpwWXBMpj3Nx6wQ0Hg@mail.gmail.com>
In-Reply-To: <CA+G9fYs+Qc3rAONJBmyQXFnYmrzFBJ8GMpwWXBMpj3Nx6wQ0Hg@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sat, 5 Mar 2022 03:38:33 +0800
Message-ID: <CAABZP2xHynkBmsk8mcvPujSL65fsj=hpM9acuMvmDOUYbWk0KQ@mail.gmail.com>
Subject: Re: [next] WARNING: suspicious RCU usage : include/linux/cgroup.h:494
 suspicious rcu_dereference_check() usage
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        zhouchengming@bytedance.com
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I can reproduce these warnings on my X86 VM.
Following the my backtrace:

(gdb) bt
#0  lockdep_rcu_suspicious (file=file@entry=0xffffffff825ea8ff
"include/linux/cgroup.h", line=line@entry=494,
    s=s@entry=0xffffffff825c5c50 "suspicious rcu_dereference_check()
usage") at ./arch/x86/include/asm/current.h:15
#1  0xffffffff81183103 in task_css (subsys_id=2,
task=0xffff888100804080) at ./include/linux/cgroup.h:494
#2  task_ca (tsk=0xffff888100804080) at kernel/sched/cpuacct.c:40
#3  cpuacct_charge (tsk=tsk@entry=0xffff888100804080,
cputime=cputime@entry=3344803) at kernel/sched/cpuacct.c:342
#4  0xffffffff81162655 in cgroup_account_cputime (delta_exec=3344803,
task=0xffff888100804080) at ./include/linux/cgroup.h:792
#5  update_curr (cfs_rq=cfs_rq@entry=0xffff88813b63f500) at
kernel/sched/fair.c:907
#6  0xffffffff81164797 in dequeue_entity (flags=10,
se=0xffff888100804100, cfs_rq=0xffff88813b63f500) at
kernel/sched/fair.c:5771
#7  dequeue_task_fair (rq=0xffff88813b63f440, p=0xffff888100804080,
flags=10) at kernel/sched/fair.c:5771
#8  0xffffffff8115412a in dequeue_task (flags=10,
p=0xffff888100804080, rq=0xffff88813b63f440) at
kernel/sched/core.c:2019
#9  __do_set_cpus_allowed (p=0xffff888100804080,
new_mask=0xffffffff831b4d40 <housekeeping+512>, flags=0) at
kernel/sched/core.c:2508
#10 0xffffffff811564ca in __set_cpus_allowed_ptr_locked
(p=p@entry=0xffff888100804080,
new_mask=new_mask@entry=0xffffffff831b4d40 <housekeeping+512>,
    flags=flags@entry=0, rq=0xffff88813b63f440,
rf=rf@entry=0xffffc9000012bee8) at kernel/sched/core.c:2841
#11 0xffffffff81156573 in __set_cpus_allowed_ptr
(p=p@entry=0xffff888100804080, new_mask=0xffffffff831b4d40
<housekeeping+512>, flags=flags@entry=0)
    at kernel/sched/core.c:2874
#12 0xffffffff8115664c in set_cpus_allowed_ptr
(p=p@entry=0xffff888100804080, new_mask=<optimized out>) at
kernel/sched/core.c:2879
#13 0xffffffff81144676 in kthreadd (unused=<optimized out>) at
kernel/kthread.c:724
#14 0xffffffff810019df in ret_from_fork () at arch/x86/entry/entry_64.S:295
#15 0x0000000000000000 in ?? ()

Do the warnings have something to do with commit
dc6e0818bc9a0336d9accf3ea35d146d72aa7a18 (sched/cpuacct: Optimize away
RCU read lock) ?

Many thanks
Zhouyi

On Fri, Mar 4, 2022 at 10:43 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> While booting x86_64 with linux next-20220304 kernel the following kernel
> warning reported [1].
>
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 6d284ba80c0c485bcaa7bdf67f232d572640edc4
>   git_describe: next-20220304
>   kernel-config: https://builds.tuxbuild.com/25uuYdm2vTO275aZ3IewZY5sKbU/config
>
>
> warning log:
> ---------
> [    1.482171] MDS: Mitigation: Clear CPU buffers
> [    1.485680] Freeing SMP alternatives memory: 52K
> [    1.487341]
> [    1.488169] =============================
> [    1.488169] WARNING: suspicious RCU usage
> [    1.488169] 5.17.0-rc6-next-20220304 #1 Not tainted
> [    1.488169] -----------------------------
> [    1.488169] include/linux/cgroup.h:494 suspicious
> rcu_dereference_check() usage!
> [    1.488169]
> [    1.488169] other info that might help us debug this:
> [    1.488169]
> [    1.488169]
> [    1.488169] rcu_scheduler_active = 1, debug_locks = 1
> [    1.488169] 2 locks held by kthreadd/2:
> [    1.488169]  #0: ffff9ba440352330 (&p->pi_lock){....}-{2:2}, at:
> task_rq_lock+0x2e/0x130
> [    1.488169]  #1: ffff9ba7a7a2d058 (&rq->__lock){-...}-{2:2}, at:
> task_rq_lock+0x5d/0x130
> [    1.488169]
> [    1.488169] stack backtrace:
> [    1.488169] CPU: 0 PID: 2 Comm: kthreadd Not tainted
> 5.17.0-rc6-next-20220304 #1
> [    1.488169] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.5 11/26/2020
> [    1.488169] Call Trace:
> [    1.488169]  <TASK>
> [    1.488169]  dump_stack_lvl+0x49/0x5e
> [    1.488169]  dump_stack+0x10/0x12
> [    1.488169]  lockdep_rcu_suspicious+0xed/0xf8
> [    1.488169]  cpuacct_charge+0x10c/0x120
> [    1.488169]  update_curr+0x165/0x340
> [    1.488169]  dequeue_entity+0x23/0x430
> [    1.488169]  dequeue_task_fair+0xba/0x3b0
> [    1.488169]  __do_set_cpus_allowed+0xca/0x2c0
> [    1.488169]  __set_cpus_allowed_ptr_locked+0x128/0x1b0
> [    1.488169]  set_cpus_allowed_ptr+0x43/0x70
> [    1.488169]  kthreadd+0x49/0x230
> [    1.488169]  ? kthread_is_per_cpu+0x30/0x30
> [    1.488169]  ret_from_fork+0x22/0x30
> [    1.488169]  </TASK>
> [    1.488169]
> [    1.488169] =============================
> [    1.488169] WARNING: suspicious RCU usage
> [    1.488169] 5.17.0-rc6-next-20220304 #1 Not tainted
> [    1.488169] -----------------------------
> [    1.488169] include/linux/cgroup.h:481 suspicious
> rcu_dereference_check() usage!
> [    1.488169]
> [    1.488169] other info that might help us debug this:
> [    1.488169]
> [    1.488169]
> [    1.488169] rcu_scheduler_active = 1, debug_locks = 1
> [    1.488169] 2 locks held by kthreadd/2:
> [    1.488169]  #0: ffff9ba440352330 (&p->pi_lock){....}-{2:2}, at:
> task_rq_lock+0x2e/0x130
> [    1.488169]  #1: ffff9ba7a7a2d058 (&rq->__lock){-...}-{2:2}, at:
> task_rq_lock+0x5d/0x130
> [    1.488169]
> [    1.488169] stack backtrace:
> [    1.488169] CPU: 0 PID: 2 Comm: kthreadd Not tainted
> 5.17.0-rc6-next-20220304 #1
> [    1.488169] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.5 11/26/2020
> [    1.488169] Call Trace:
> [    1.488169]  <TASK>
> [    1.488169]  dump_stack_lvl+0x49/0x5e
> [    1.488169]  dump_stack+0x10/0x12
> [    1.488169]  lockdep_rcu_suspicious+0xed/0xf8
> [    1.488169]  update_curr+0x2b7/0x340
> [    1.488169]  dequeue_entity+0x23/0x430
> [    1.488169]  dequeue_task_fair+0xba/0x3b0
> [    1.488169]  __do_set_cpus_allowed+0xca/0x2c0
> [    1.488169]  __set_cpus_allowed_ptr_locked+0x128/0x1b0
> [    1.488169]  set_cpus_allowed_ptr+0x43/0x70
> [    1.488169]  kthreadd+0x49/0x230
> [    1.488169]  ? kthread_is_per_cpu+0x30/0x30
> [    1.488169]  ret_from_fork+0x22/0x30
> [    1.488169]  </TASK>
> [    1.488169]
> [    1.488169] =============================
> [    1.488169] WARNING: suspicious RCU usage
> [    1.488169] 5.17.0-rc6-next-20220304 #1 Not tainted
> [    1.488169] -----------------------------
> [    1.488169] include/linux/cgroup.h:481 suspicious
> rcu_dereference_check() usage!
> [    1.488169]
> [    1.488169] other info that might help us debug this:
> [    1.488169]
> [    1.488169]
> [    1.488169] rcu_scheduler_active = 1, debug_locks = 1
> [    1.488169] no locks held by kthreadd/2.
> [    1.488169]
> [    1.488169] stack backtrace:
> [    1.488169] CPU: 0 PID: 2 Comm: kthreadd Not tainted
> 5.17.0-rc6-next-20220304 #1
> [    1.488169] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.5 11/26/2020
> [    1.488169] Call Trace:
> [    1.488169]  <IRQ>
> [    1.488169]  dump_stack_lvl+0x49/0x5e
> [    1.488169]  dump_stack+0x10/0x12
> [    1.488169]  lockdep_rcu_suspicious+0xed/0xf8
> [    1.488169]  account_system_index_time+0x127/0x130
> [    1.488169]  account_system_time+0x50/0x60
> [    1.488169]  account_process_tick+0x59/0x80
> [    1.488169]  update_process_times+0x58/0xe0
> [    1.488169]  tick_periodic+0x37/0xf0
> [    1.488169]  tick_handle_periodic+0x24/0x70
> [    1.488169]  timer_interrupt+0x18/0x20
> [    1.488169]  __handle_irq_event_percpu+0x95/0x2f0
> [    1.488169]  handle_irq_event+0x39/0x80
> [    1.488169]  handle_edge_irq+0xa4/0x240
> [    1.488169]  __common_interrupt+0x8d/0x170
> [    1.488169]  common_interrupt+0xbd/0xe0
> [    1.488169]  </IRQ>
> [    1.488169]  <TASK>
> [    1.488169]  asm_common_interrupt+0x1e/0x40
> [    1.488169] RIP: 0010:_raw_spin_unlock_irqrestore+0x37/0x60
> [    1.488169] Code: fc 48 83 c7 18 53 48 89 f3 48 8b 75 08 e8 21 83
> ed fe 4c 89 e7 e8 19 b0 ed fe 80 e7 02 74 06 e8 6f 77 fa fe fb bf 01
> 00 00 00 <e8> 24 6b e9 fe 65 8b 05 bd e1 28 66 85 c0 74 05 5b 41 5c 5d
> c3 0f
> [    1.488169] RSP: 0000:ffffb75b0002fd50 EFLAGS: 00000202
> [    1.488169] RAX: 0000000000000007 RBX: 0000000000000246 RCX: 0000000000000000
> [    1.488169] RDX: 0000000000000000 RSI: ffffffff9a800a7c RDI: 0000000000000001
> [    1.488169] RBP: ffffb75b0002fd60 R08: 0000000000000001 R09: 0000000000000001
> [    1.488169] R10: 0000000000000002 R11: 0000000000000001 R12: ffff9ba440352318
> [    1.488169] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9ba7a7a2d040
> [    1.488169]  affine_move_task+0x2d4/0x5d0
> [    1.488169]  ? __this_cpu_preempt_check+0x13/0x20
> [    1.488169]  ? lock_is_held_type+0xdd/0x130
> [    1.488169]  ? enqueue_entity+0x1b8/0x520
> [    1.488169]  __set_cpus_allowed_ptr_locked+0x15c/0x1b0
> [    1.488169]  set_cpus_allowed_ptr+0x43/0x70
> [    1.488169]  kthreadd+0x49/0x230
> [    1.488169]  ? kthread_is_per_cpu+0x30/0x30
> [    1.488169]  ret_from_fork+0x22/0x30
> [    1.488169]  </TASK>
> [    1.489211] smpboot: Estimated ratio of average max frequency by
> base frequency (times 1024): 1126
> [    1.490189] smpboot: CPU0: Intel(R) Xeon(R) CPU E3-1220 v6 @
> 3.00GHz (family: 0x6, model: 0x9e, stepping: 0x9)
> [    1.491635] cblist_init_generic: Setting adjustable number of
> callback queues.
> [    1.492171] cblist_init_generic: Setting shift to 2 and lim to 1.
> [    1.493226] cblist_init_generic: Setting shift to 2 and lim to 1.
> [    1.494226] cblist_init_generic: Setting shift to 2 and lim to 1.
> [    1.495219] Running RCU-tasks wait API self tests
> [    1.598317] Performance Events: PEBS fmt3+, Skylake events, 32-deep
> LBR, full-width counters, Intel PMU driver.
> [    1.599176] ... version:                4
> [    1.600171] ... bit width:              48
> [    1.601171] ... generic registers:      8
> [    1.602171] ... value mask:             0000ffffffffffff
> [    1.603171] ... max period:             00007fffffffffff
> [    1.604176] ... fixed-purpose events:   3
> [    1.605171] ... event mask:             00000007000000ff
> [    1.606188] Callback from call_rcu_tasks_trace() invoked.
> [    1.607450] rcu: Hierarchical SRCU implementation.
> [    1.608310]
> [    1.609169] =============================
> [    1.609169] WARNING: suspicious RCU usage
> [    1.609169] 5.17.0-rc6-next-20220304 #1 Not tainted
> [    1.609169] -----------------------------
> [    1.609169] include/linux/cgroup.h:481 suspicious
> rcu_dereference_check() usage!
> [    1.609169]
> [    1.609169] other info that might help us debug this:
> [    1.609169]
> [    1.609169]
> [    1.609169] rcu_scheduler_active = 1, debug_locks = 1
> [    1.609169] 1 lock held by migration/0/17:
> [    1.609169]  #0: ffff9ba7a7a2d058 (&rq->__lock){-.-.}-{2:2}, at:
> __schedule+0x12d/0xcb0
> [    1.609169]
> [    1.609169] stack backtrace:
> [    1.609169] CPU: 0 PID: 17 Comm: migration/0 Not tainted
> 5.17.0-rc6-next-20220304 #1
> [    1.609169] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.5 11/26/2020
> [    1.609169] Stopper: 0x0 <- 0x0
> [    1.609169] Call Trace:
> [    1.609169]  <TASK>
> [    1.609169]  dump_stack_lvl+0x49/0x5e
> [    1.609169]  dump_stack+0x10/0x12
> [    1.609169]  lockdep_rcu_suspicious+0xed/0xf8
> [    1.609169]  put_prev_task_stop+0x1dc/0x240
> [    1.609169]  __schedule+0x751/0xcb0
> [    1.609169]  ? trace_preempt_off+0x29/0xc0
> [    1.609169]  ? smpboot_thread_fn+0x33/0x290
> [    1.609169]  schedule+0x58/0xc0
> [    1.609169]  smpboot_thread_fn+0xec/0x290
> [    1.609169]  ? sort_range+0x30/0x30
> [    1.609169]  kthread+0x107/0x130
> [    1.609169]  ? kthread_complete_and_exit+0x20/0x20
> [    1.609169]  ret_from_fork+0x22/0x30
> [    1.609169]  </TASK>
> [    1.610276] smp: Bringing up secondary CPUs ...
> [    1.611596] x86: Booting SMP configuration:
> [    1.612179] .... node  #0, CPUs:      #1 #2 #3
> [    1.614396] smp: Brought up 1 node, 4 CPUs
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>
> [1] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220304/testrun/8235955/suite/linux-log-parser/test/check-kernel-warning-4655400/log
