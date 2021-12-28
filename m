Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389A348088D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhL1Ktw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:49:52 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:64805 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbhL1Ktv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:49:51 -0500
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BSAnLuI067355;
        Tue, 28 Dec 2021 19:49:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Tue, 28 Dec 2021 19:49:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BSAnKWk067351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 28 Dec 2021 19:49:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <77f05c15-81b6-bddd-9650-80d5f23fe330@i-love.sakura.ne.jp>
Date:   Tue, 28 Dec 2021 19:49:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [lockdep] UAF read in print_name().
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I found using linux-next-20211210 that reading /proc/lockdep after lockdep splat
triggers UAF read access. I think this is a side effect of zapping dependency
information when loop driver's WQ is destroyed. You might want to xchg() the pointer
with a dummy struct containing a static string.

difference before lockdep splat and after lockdep splat
----------------------------------------
8635c8636
< ffff88811561cd28 OPS:      26 FD:  122 BD:    1 +.+.: (wq_completion)loop0
---
> ffff88811561cd28 OPS:      31 FD:  439 BD:    1 +.+.:  M>^MM-^AM-^HM-^?M-^?
----------------------------------------

----------------------------------------
[  139.865683] loop0: detected capacity change from 0 to 2048
[  141.979545] 
[  141.980166] ======================================================
[  141.982320] WARNING: possible circular locking dependency detected
[  141.984478] 5.16.0-rc4-next-20211210 #14 Not tainted
[  141.986223] ------------------------------------------------------
[  141.988382] 1/2244 is trying to acquire lock:
[  141.989919] ffff88811561cd38 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x9c/0x900
[  141.993346] 
[  141.993346] but task is already holding lock:
[  141.995458] ffff88810c4fcd18 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x80/0x2e0
[  141.998261] 
[  141.998261] which lock already depends on the new lock.
[  141.998261] 
[  142.001093] 
[  142.001093] the existing dependency chain (in reverse order) is:
[  142.003668] 
[  142.003668] -> #6 (&disk->open_mutex){+.+.}-{3:3}:
[  142.005854]        lock_acquire+0xe9/0x230
[  142.007459]        __mutex_lock_common+0xf1/0x13a0
[  142.010547]        mutex_lock_nested+0x17/0x20
[  142.014435]        blkdev_get_by_dev+0x106/0x490
[  142.016031]        swsusp_check+0x35/0x140
[  142.017462]        software_resume+0x5f/0x210
[  142.018966]        resume_store+0x7b/0xa0
[  142.020362]        kernfs_fop_write_iter+0x1c6/0x270
[  142.022103]        vfs_write+0x51e/0x5c0
[  142.023512]        ksys_write+0x90/0x110
[  142.025872]        do_syscall_64+0x3d/0x90
[  142.027847]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  142.029795] 
[  142.029795] -> #5 (system_transition_mutex/1){+.+.}-{3:3}:
[  142.034777]        lock_acquire+0xe9/0x230
[  142.036226]        __mutex_lock_common+0xf1/0x13a0
[  142.037941]        mutex_lock_nested+0x17/0x20
[  142.039537]        software_resume+0x4d/0x210
[  142.043256]        resume_store+0x7b/0xa0
[  142.044775]        kernfs_fop_write_iter+0x1c6/0x270
[  142.046585]        vfs_write+0x51e/0x5c0
[  142.047960]        ksys_write+0x90/0x110
[  142.049303]        do_syscall_64+0x3d/0x90
[  142.050795]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  142.052751] 
[  142.052751] -> #4 (&of->mutex){+.+.}-{3:3}:
[  142.054793]        lock_acquire+0xe9/0x230
[  142.056249]        __mutex_lock_common+0xf1/0x13a0
[  142.060032]        mutex_lock_nested+0x17/0x20
[  142.061981]        kernfs_seq_start+0x2f/0x190
[  142.063655]        seq_read_iter+0x1dc/0x6d0
[  142.065175]        vfs_read+0x50b/0x5a0
[  142.066548]        ksys_read+0x90/0x110
[  142.067903]        do_syscall_64+0x3d/0x90
[  142.069365]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  142.071298] 
[  142.071298] -> #3 (&p->lock){+.+.}-{3:3}:
[  142.073213]        lock_acquire+0xe9/0x230
[  142.076345]        __mutex_lock_common+0xf1/0x13a0
[  142.078745]        mutex_lock_nested+0x17/0x20
[  142.080331]        seq_read_iter+0x57/0x6d0
[  142.081823]        generic_file_splice_read+0x1fb/0x2b0
[  142.083664]        splice_direct_to_actor+0x223/0x4e0
[  142.085446]        do_splice_direct+0x112/0x180
[  142.087044]        do_sendfile+0x295/0x610
[  142.088501]        __se_sys_sendfile64+0xb0/0xe0
[  142.090127]        do_syscall_64+0x3d/0x90
[  142.092769]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  142.095191] 
[  142.095191] -> #2 (sb_writers#7){.+.+}-{0:0}:
[  142.098093]        lock_acquire+0xe9/0x230
[  142.099580]        loop_process_work+0xafb/0xf10 [loop]
[  142.101454]        process_one_work+0x40a/0x630
[  142.103053]        worker_thread+0x4d7/0x9b0
[  142.104563]        kthread+0x27c/0x2a0
[  142.105890]        ret_from_fork+0x1f/0x30
[  142.108496] 
[  142.108496] -> #1 ((work_completion)(&worker->work)){+.+.}-{0:0}:
[  142.111860]        lock_acquire+0xe9/0x230
[  142.113339]        process_one_work+0x3ec/0x630
[  142.114931]        worker_thread+0x4d7/0x9b0
[  142.116436]        kthread+0x27c/0x2a0
[  142.117763]        ret_from_fork+0x1f/0x30
[  142.119208] 
[  142.119208] -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
[  142.121472]        validate_chain+0x236c/0x3ab0
[  142.123062]        __lock_acquire+0xcd4/0x1050
[  142.125387]        lock_acquire+0xe9/0x230
[  142.127359]        flush_workqueue+0xb8/0x900
[  142.129307]        drain_workqueue+0xa4/0x1c0
[  142.130853]        destroy_workqueue+0x4e/0x620
[  142.132738]        __loop_clr_fd+0x101/0x4d0 [loop]
[  142.134462]        blkdev_put+0x285/0x2e0
[  142.135891]        blkdev_close+0x33/0x40
[  142.137306]        __fput+0x1f7/0x3d0
[  142.138603]        task_work_run+0xba/0xf0
[  142.140174]        do_exit+0x3a9/0xf70
[  142.142904]        do_group_exit+0x113/0x140
[  142.144607]        __x64_sys_exit_group+0x22/0x30
[  142.146275]        do_syscall_64+0x3d/0x90
[  142.148069]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  142.150228] 
[  142.150228] other info that might help us debug this:
[  142.150228] 
[  142.152962] Chain exists of:
[  142.152962]   (wq_completion)loop0 --> system_transition_mutex/1 --> &disk->open_mutex
[  142.152962] 
[  142.158480]  Possible unsafe locking scenario:
[  142.158480] 
[  142.160867]        CPU0                    CPU1
[  142.162411]        ----                    ----
[  142.164334]   lock(&disk->open_mutex);
[  142.166267]                                lock(system_transition_mutex/1);
[  142.168773]                                lock(&disk->open_mutex);
[  142.171107]   lock((wq_completion)loop0);
[  142.172487] 
[  142.172487]  *** DEADLOCK ***
[  142.172487] 
[  142.175779] 1 lock held by 1/2244:
[  142.177542]  #0: ffff88810c4fcd18 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x80/0x2e0
[  142.180507] 
[  142.180507] stack backtrace:
[  142.181995] CPU: 3 PID: 2244 Comm: 1 Kdump: loaded Not tainted 5.16.0-rc4-next-20211210 #14
[  142.184959] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[  142.189123] Call Trace:
[  142.190001]  <TASK>
[  142.191930]  dump_stack_lvl+0x8e/0xe1
[  142.193508]  check_noncircular+0x1c7/0x1e0
[  142.195260]  validate_chain+0x236c/0x3ab0
[  142.196780]  ? validate_chain+0x6f4/0x3ab0
[  142.198595]  ? validate_chain+0x6f4/0x3ab0
[  142.202374]  ? rcu_read_lock_sched_held+0x41/0xa0
[  142.204010]  ? trace_sched_overutilized_tp+0x5b/0x140
[  142.205738]  ? load_balance+0x2d6e/0x2e30
[  142.207226]  ? check_chain_key+0x1ec/0x280
[  142.210401]  ? __lock_acquire+0xd2d/0x1050
[  142.212082]  ? mark_lock+0xbb/0x290
[  142.213305]  ? check_chain_key+0x1ec/0x280
[  142.214755]  __lock_acquire+0xcd4/0x1050
[  142.216112]  lock_acquire+0xe9/0x230
[  142.217440]  ? flush_workqueue+0x9c/0x900
[  142.218821]  flush_workqueue+0xb8/0x900
[  142.220140]  ? flush_workqueue+0x9c/0x900
[  142.221552]  ? lock_release+0x382/0x400
[  142.222873]  ? check_chain_key+0x1ec/0x280
[  142.225481]  drain_workqueue+0xa4/0x1c0
[  142.227654]  destroy_workqueue+0x4e/0x620
[  142.229373]  ? init_wait_entry+0x60/0x60
[  142.230837]  __loop_clr_fd+0x101/0x4d0 [loop]
[  142.232346]  blkdev_put+0x285/0x2e0
[  142.233583]  blkdev_close+0x33/0x40
[  142.234785]  __fput+0x1f7/0x3d0
[  142.235878]  task_work_run+0xba/0xf0
[  142.237178]  do_exit+0x3a9/0xf70
[  142.238426]  do_group_exit+0x113/0x140
[  142.239734]  __x64_sys_exit_group+0x22/0x30
[  142.242344]  do_syscall_64+0x3d/0x90
[  142.244105]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  142.245966] RIP: 0033:0x7f9d354d8ed1
[  142.247386] Code: Unable to access opcode bytes at RIP 0x7f9d354d8ea7.
[  142.249814] RSP: 002b:00007fff9eb900f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[  142.252344] RAX: ffffffffffffffda RBX: 00007f9d356056d0 RCX: 00007f9d354d8ed1
[  142.254840] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[  142.257348] RBP: 0000000000000000 R08: ffffffffffffff80 R09: 0000000000000001
[  142.260850] R10: 0000000000000008 R11: 0000000000000246 R12: 00007f9d356056d0
[  142.263281] R13: 0000000000000000 R14: 00007f9d35605ba8 R15: 00007f9d35605bc0
[  142.266062]  </TASK>
[  149.667400] ==================================================================
[  149.670632] BUG: KASAN: use-after-free in string+0xf6/0x170
[  149.673737] Read of size 1 at addr ffff88810d3e4ec0 by task cat/2260
[  149.675980] 
[  149.676550] CPU: 2 PID: 2260 Comm: cat Kdump: loaded Not tainted 5.16.0-rc4-next-20211210 #14
[  149.679459] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[  149.684006] Call Trace:
[  149.685272]  <TASK>
[  149.686179]  dump_stack_lvl+0x8e/0xe1
[  149.687674]  print_address_description+0x64/0x3f0
[  149.689297]  ? string+0xf6/0x170
[  149.690411]  kasan_report+0x165/0x1b0
[  149.691590]  ? string+0xf6/0x170
[  149.692668]  string+0xf6/0x170
[  149.693698]  vsnprintf+0x64d/0xa50
[  149.694913]  seq_printf+0xa6/0x100
[  149.696016]  ? print_name+0x35/0xf0
[  149.697630]  ? number+0x66a/0x790
[  149.700065]  print_name+0x52/0xf0
[  149.701685]  ? put_dec_trunc8+0x10b/0x130
[  149.703314]  ? number+0x524/0x790
[  149.704404]  ? format_decode+0x1c5/0x770
[  149.706283]  ? vsnprintf+0x3da/0xa50
[  149.708356]  ? memcpy+0x3c/0x60
[  149.709542]  ? vsnprintf+0xa14/0xa50
[  149.710849]  ? seq_printf+0xd9/0x100
[  149.712097]  ? seq_printf+0xd9/0x100
[  149.713331]  ? seq_puts+0x77/0x90
[  149.714425]  ? get_usage_chars+0xf1/0x100
[  149.716683]  l_show+0x177/0x260
[  149.718721]  seq_read_iter+0x528/0x6d0
[  149.720199]  proc_reg_read_iter+0x91/0x100
[  149.721601]  vfs_read+0x50b/0x5a0
[  149.722778]  ksys_read+0x90/0x110
[  149.723921]  do_syscall_64+0x3d/0x90
[  149.725148]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  149.726906] RIP: 0033:0x7f801b050912
[  149.728242] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 5a b9 0c 00 e8 05 19 02 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[  149.735647] RSP: 002b:00007fff47ee48b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  149.739170] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f801b050912
[  149.741618] RDX: 0000000000020000 RSI: 00007f801a9a5000 RDI: 0000000000000003
[  149.744059] RBP: 00007f801a9a5000 R08: 00007f801a9a4010 R09: 0000000000000000
[  149.747455] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000000
[  149.752184] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
[  149.754659]  </TASK>
[  149.755489] 
[  149.756055] Allocated by task 0:
[  149.757452] (stack is not available)
[  149.758972] 
[  149.759544] Freed by task 0:
[  149.760592]  kasan_set_track+0x3d/0x60
[  149.761901]  kasan_set_free_info+0x1f/0x40
[  149.763319]  ____kasan_slab_free+0xc2/0xf0
[  149.764747]  slab_free_freelist_hook+0xe1/0x160
[  149.767887]  kfree+0xc6/0x210
[  149.769262]  rcu_free_wq+0x28/0x80
[  149.770487]  rcu_do_batch+0x2df/0x760
[  149.772139]  rcu_core+0x3ad/0x5a0
[  149.773423]  __do_softirq+0x24c/0x42c
[  149.774773] 
[  149.775324] The buggy address belongs to the object at ffff88810d3e4ec0
[  149.775324]  which belongs to the cache kmalloc-32 of size 32
[  149.779880] The buggy address is located 0 bytes inside of
[  149.779880]  32-byte region [ffff88810d3e4ec0, ffff88810d3e4ee0)
[  149.784615] The buggy address belongs to the page:
[  149.786376] page:ffffea000434f900 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10d3e4
[  149.789609] head:ffffea000434f900 order:1 compound_mapcount:0
[  149.791580] flags: 0x2ffe00000010200(slab|head|node=0|zone=2|lastcpupid=0x7ff)
[  149.793995] raw: 02ffe00000010200 ffffea00042cb388 ffff8881000409a8 ffff88810004ca40
[  149.796480] raw: 0000000000000000 0000000000130013 00000001ffffffff 0000000000000000
[  149.801275] page dumped because: kasan: bad access detected
[  149.803300] 
[  149.803820] Memory state around the buggy address:
[  149.805724]  ffff88810d3e4d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  149.808443]  ffff88810d3e4e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  149.810798] >ffff88810d3e4e80: fc fc fc fc fc fc fc fc fa fb fb fb fc fc fc fc
[  149.813187]                                            ^
[  149.814992]  ffff88810d3e4f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  149.817889]  ffff88810d3e4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  149.820566] ==================================================================
----------------------------------------
