Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1BC491F56
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 07:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbiARGTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 01:19:13 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59518 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241699AbiARGTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 01:19:12 -0500
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20I6J9Ki056025;
        Tue, 18 Jan 2022 15:19:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Tue, 18 Jan 2022 15:19:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20I6J9nt055997
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Jan 2022 15:19:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dd6c1f86-9a4b-bc1d-8d9e-835e64a00638@I-love.SAKURA.ne.jp>
Date:   Tue, 18 Jan 2022 15:19:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: regression: LTP isofs testcase failure - bisection fingers "loop:
 make autoclear operation asynchronous"
Content-Language: en-US
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>
References: <4eb771d2b48ee94ba2e3aa8706bce8117d398e80.camel@gmx.de>
 <c53285e4-cbd4-5fd0-cbc9-93e2e3d3d88d@I-love.SAKURA.ne.jp>
 <0a1c1464e40e4c60687bc715c0b78c9124e456f8.camel@gmx.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0a1c1464e40e4c60687bc715c0b78c9124e456f8.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/18 12:21, Mike Galbraith wrote:
> On Tue, 2022-01-18 at 06:57 +0900, Tetsuo Handa wrote:
>> On 2022/01/18 0:34, Mike Galbraith wrote:
>>> Greetings,
>>>
>>> LTP's isofs testcase began failing this cycle, and bisected as below,
>>> which a revert then confirmed.  Full testcase output attached.
>>>
>>
>> Thanks for reporting.
>> Discussion is continued at https://lkml.kernel.org/r/cdaf1346-2885-f0da-8878-12264bd48348@I-love.SAKURA.ne.jp .
> 
> FWIW, simply immediately flushing that shiny new rundown_work turned
> LTP's thumb back to upward pointing.

Unfortunately, that reintroduces the circular locking dependency problem
which my patch tried to solve.

[  159.316295] 
[  159.316759] ======================================================
[  159.318129] WARNING: possible circular locking dependency detected
[  159.319446] 5.16.0+ #48 Not tainted
[  159.320270] ------------------------------------------------------
[  159.321660] kworker/0:1/11 is trying to acquire lock:
[  159.322859] ffff888074368538 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x9c/0x890
[  159.324744] 
[  159.324744] but task is already holding lock:
[  159.326028] ffff888100847dd8 ((work_completion)(&lo->rundown_work)){+.+.}-{0:0}, at: process_one_work+0x3b5/0x600
[  159.328411] 
[  159.328411] which lock already depends on the new lock.
[  159.328411] 
[  159.330227] 
[  159.330227] the existing dependency chain (in reverse order) is:
[  159.331831] 
[  159.331831] -> #7 ((work_completion)(&lo->rundown_work)){+.+.}-{0:0}:
[  159.335509]        lock_acquire+0xe9/0x230
[  159.336497]        __flush_work+0x5f/0xd0
[  159.337425]        blkdev_put+0x285/0x2e0
[  159.338356]        blkdev_close+0x33/0x40
[  159.339253]        __fput+0x1f7/0x3d0
[  159.340230]        task_work_run+0xba/0xf0
[  159.341149]        exit_to_user_mode_loop+0x144/0x160
[  159.342295]        exit_to_user_mode_prepare+0xbd/0x130
[  159.343423]        syscall_exit_to_user_mode+0x26/0x60
[  159.344655]        do_syscall_64+0x49/0x90
[  159.345596]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  159.346814] 
[  159.346814] -> #6 (&disk->open_mutex){+.+.}-{3:3}:
[  159.348188]        lock_acquire+0xe9/0x230
[  159.349115]        __mutex_lock_common+0xf1/0x1340
[  159.350285]        mutex_lock_nested+0x17/0x20
[  159.351345]        blkdev_get_by_dev+0x106/0x490
[  159.352506]        swsusp_check+0x35/0x1a0
[  159.353493]        software_resume+0x5f/0x210
[  159.354620]        resume_store+0x7b/0xa0
[  159.355690]        kernfs_fop_write_iter+0x1c6/0x270
[  159.356851]        vfs_write+0x51e/0x5c0
[  159.357835]        ksys_write+0x90/0x110
[  159.358757]        do_syscall_64+0x3d/0x90
[  159.359644]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  159.360853] 
[  159.360853] -> #5 (system_transition_mutex/1){+.+.}-{3:3}:
[  159.362489]        lock_acquire+0xe9/0x230
[  159.363437]        __mutex_lock_common+0xf1/0x1340
[  159.364661]        mutex_lock_nested+0x17/0x20
[  159.365725]        software_resume+0x4d/0x210
[  159.366787]        resume_store+0x7b/0xa0
[  159.367806]        kernfs_fop_write_iter+0x1c6/0x270
[  159.368874]        vfs_write+0x51e/0x5c0
[  159.369782]        ksys_write+0x90/0x110
[  159.370698]        do_syscall_64+0x3d/0x90
[  159.371644]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  159.372832] 
[  159.372832] -> #4 (&of->mutex){+.+.}-{3:3}:
[  159.374122]        lock_acquire+0xe9/0x230
[  159.375048]        __mutex_lock_common+0xf1/0x1340
[  159.376088]        mutex_lock_nested+0x17/0x20
[  159.377073]        kernfs_seq_start+0x2f/0x190
[  159.378202]        seq_read_iter+0x1dc/0x6d0
[  159.379351]        vfs_read+0x50b/0x5a0
[  159.380231]        ksys_read+0x90/0x110
[  159.381047]        do_syscall_64+0x3d/0x90
[  159.382012]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  159.383206] 
[  159.383206] -> #3 (&p->lock){+.+.}-{3:3}:
[  159.384400]        lock_acquire+0xe9/0x230
[  159.385386]        __mutex_lock_common+0xf1/0x1340
[  159.386479]        mutex_lock_nested+0x17/0x20
[  159.387487]        seq_read_iter+0x57/0x6d0
[  159.388439]        generic_file_splice_read+0x1fb/0x2b0
[  159.389538]        splice_direct_to_actor+0x223/0x4e0
[  159.390610]        do_splice_direct+0x112/0x180
[  159.391587]        do_sendfile+0x295/0x610
[  159.392489]        __se_sys_sendfile64+0xb0/0xe0
[  159.393475]        do_syscall_64+0x3d/0x90
[  159.394533]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  159.397834] 
[  159.397834] -> #2 (sb_writers#7){.+.+}-{0:0}:
[  159.399840]        lock_acquire+0xe9/0x230
[  159.401096]        loop_process_work+0xaca/0xec0 [loop]
[  159.402497]        process_one_work+0x3ee/0x600
[  159.403685]        worker_thread+0x4d7/0x960
[  159.404746]        kthread+0x178/0x1a0
[  159.405772]        ret_from_fork+0x1f/0x30
[  159.406858] 
[  159.406858] -> #1 ((work_completion)(&worker->work)){+.+.}-{0:0}:
[  159.408601]        lock_acquire+0xe9/0x230
[  159.409506]        process_one_work+0x3d3/0x600
[  159.410461]        worker_thread+0x4d7/0x960
[  159.411531]        kthread+0x178/0x1a0
[  159.412387]        ret_from_fork+0x1f/0x30
[  159.413315] 
[  159.413315] -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
[  159.414960]        validate_chain+0x2364/0x3aa0
[  159.415942]        __lock_acquire+0xcd4/0x1050
[  159.417021]        lock_acquire+0xe9/0x230
[  159.418016]        flush_workqueue+0xb8/0x890
[  159.419126]        drain_workqueue+0xa4/0x1c0
[  159.420105]        destroy_workqueue+0x4e/0x600
[  159.421103]        __loop_clr_fd+0xed/0x440 [loop]
[  159.422203]        loop_rundown_workfn+0x3f/0xc0 [loop]
[  159.423357]        process_one_work+0x3ee/0x600
[  159.424357]        worker_thread+0x4d7/0x960
[  159.425299]        kthread+0x178/0x1a0
[  159.426140]        ret_from_fork+0x1f/0x30
[  159.427100] 
[  159.427100] other info that might help us debug this:
[  159.427100] 
[  159.429256] Chain exists of:
[  159.429256]   (wq_completion)loop0 --> &disk->open_mutex --> (work_completion)(&lo->rundown_work)
[  159.429256] 
[  159.432130]  Possible unsafe locking scenario:
[  159.432130] 
[  159.433368]        CPU0                    CPU1
[  159.434337]        ----                    ----
[  159.435375]   lock((work_completion)(&lo->rundown_work));
[  159.436552]                                lock(&disk->open_mutex);
[  159.437859]                                lock((work_completion)(&lo->rundown_work));
[  159.439558]   lock((wq_completion)loop0);
[  159.440451] 
[  159.440451]  *** DEADLOCK ***
[  159.440451] 
[  159.441684] 2 locks held by kworker/0:1/11:
[  159.442719]  #0: ffff888100082138 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work+0x383/0x600
[  159.444841]  #1: ffff888100847dd8 ((work_completion)(&lo->rundown_work)){+.+.}-{0:0}, at: process_one_work+0x3b5/0x600
[  159.447171] 
[  159.447171] stack backtrace:
[  159.448108] CPU: 0 PID: 11 Comm: kworker/0:1 Kdump: loaded Not tainted 5.16.0+ #48
[  159.449757] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[  159.451960] Workqueue: events_long loop_rundown_workfn [loop]
[  159.453169] Call Trace:
[  159.453784]  <TASK>
[  159.454353]  dump_stack_lvl+0x8e/0xe1
[  159.455197]  check_noncircular+0x1c7/0x1e0
[  159.456081]  ? preempt_count_sub+0xf/0xc0
[  159.457081]  validate_chain+0x2364/0x3aa0
[  159.457950]  ? validate_chain+0x6f4/0x3aa0
[  159.458868]  ? mark_lock+0xbb/0x290
[  159.459662]  __lock_acquire+0xcd4/0x1050
[  159.460545]  lock_acquire+0xe9/0x230
[  159.461356]  ? flush_workqueue+0x9c/0x890
[  159.462411]  flush_workqueue+0xb8/0x890
[  159.463269]  ? flush_workqueue+0x9c/0x890
[  159.464157]  ? lock_release+0x382/0x400
[  159.464969]  ? check_chain_key+0x1ec/0x280
[  159.465947]  drain_workqueue+0xa4/0x1c0
[  159.466845]  destroy_workqueue+0x4e/0x600
[  159.467855]  ? init_wait_entry+0x60/0x60
[  159.468858]  __loop_clr_fd+0xed/0x440 [loop]
[  159.469850]  loop_rundown_workfn+0x3f/0xc0 [loop]
[  159.470930]  process_one_work+0x3ee/0x600
[  159.471850]  worker_thread+0x4d7/0x960
[  159.472667]  ? _raw_spin_unlock_irqrestore+0x3f/0xb0
[  159.473786]  ? rcu_lock_release+0x20/0x20
[  159.476282]  kthread+0x178/0x1a0
[  159.477562]  ? kthread_blkcg+0x50/0x50
[  159.478691]  ret_from_fork+0x1f/0x30
[  159.479949]  </TASK>

