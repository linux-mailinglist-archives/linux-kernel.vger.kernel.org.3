Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE77567CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiGFDvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiGFDvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:51:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E53D201B1;
        Tue,  5 Jul 2022 20:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 874D3B81A9A;
        Wed,  6 Jul 2022 03:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE93C341C6;
        Wed,  6 Jul 2022 03:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657079441;
        bh=WwiHJSeRBZFKvms17mk/wSwuZWColXmfzza+DkWK/JY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Y4/j4UrKcJh/mGFMIzfu+3oynOUiV6EojftD++Awyy9BoR96P2CFZ97KOoBzXKzH2
         DGmbpNFWc+NF4W0bqHnUz2JFzrFYv3Cmi8KYiU8C7MNdG4NC/C/WXkVeEVw+kV9ukC
         izb/ZIR5Z4r20QEsRh0cfHKXYqXO+1+Ih0LefeEDt46KAX+YOjtfA5eRrGNqrG6bWc
         doiM6o0iP4yo0UpPzHkjDp5guBnnmob6t/HW8jPbPWg4EXKf/pqsqMryvqW9AbCgB1
         C80OFCFhDj05Ot4nevYurvtUwXCMZrCORlEQb+l6rJC+hYrZT8lZ5AjFZ48Wnkvobu
         eXCRtXCSHKdFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B0FE85C05ED; Tue,  5 Jul 2022 20:50:40 -0700 (PDT)
Date:   Tue, 5 Jul 2022 20:50:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu: Make tiny RCU support leak callbacks for
 debug-object errors
Message-ID: <20220706035040.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220701024404.2228367-1-qiang1.zhang@intel.com>
 <20220705174109.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880370195C11E8E943069CBDA809@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880370195C11E8E943069CBDA809@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 02:00:51AM +0000, Zhang, Qiang1 wrote:
> On Fri, Jul 01, 2022 at 10:44:04AM +0800, Zqiang wrote:
> > Currently, only tree RCU support leak callbacks setting when do
> > duplicate call_rcu(). this commit add leak callbacks setting when
> > fo duplicate call_rcu() for tiny RCU.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> >This does look plausible, thank you!
> >
> >What testing have you done?
> >
> >One important test for Tiny RCU is that the size of the kernel not
> >grow without a very good reason.  In this case, the added code should
> >be dead code in a production build (CONFIG_DEBUG_OBJECTS_RCU_HEAD=n),
> >but it is good to check.
> >
> >It is of course also good to check that the messages print as expected,
> >which is what rcutorture.object_debug is there to help with.
> 
> In the condition that the CONFIG_DEBUG_OBJECTS_RCU_HEAD=n, the function directly returns zero.
> 
> #else   /* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> static inline int debug_rcu_head_queue(struct rcu_head *head)
> {
>         return 0;
> }

Yes, like I said, the added code -should- be dead code.  But there is
often a gap between "should" and "is", for example, compilers don't
always do what we would like them to.  So please use the "size vmlinux"
command with and without your patch for a kernel built (both times)
with CONFIG_TINY_RCU=y and CONFIG_DEBUG_OBJECTS_RCU_HEAD==n.

The rest of the test results look good, thank you!

							Thanx, Paul

> My test results are as follows:
> 
> runqemu kvm slirp nographic qemuparams="-m 2048 -smp 1" bootparams="rcutorture.object_debug=1" -d
> 
> log:
> root@qemux86-64:/# zcat /proc/config.gz | grep RCU
> # RCU Subsystem
> CONFIG_TINY_RCU=y
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> 
> [    1.015657] rcutorture: WARN: Duplicate call_rcu() test starting.
> [    1.015659] ------------[ cut here ]------------
> [    1.015659] ODEBUG: activate active (active state 1) object type: rcu_head hint: 0x0
> [    1.015680] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_print_object+0xda/0x100
> [    1.016329] Modules linked in:
> [    1.016329] CPU: 0 PID: 1 Comm: swapper Not tainted 5.19.0-rc3-yoctodev-standard+ #214
> [    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    1.016329] RIP: 0010:debug_print_object+0xda/0x100
> [    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e1 48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <0f> e
> [    1.016329] RSP: 0000:ffff888001337be0 EFLAGS: 00010086
> [    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed1000266f6e
> [    1.016329] RBP: ffff888001337c10 R08: ffffffff90a56ee6 R09: fffffbfff25df5c2
> [    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 0000000000000001
> [    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e8a0 R15: 0000000000000000
> [    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlGS:0000000000000000
> [    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 00000000001506f0
> [    1.016329] Call Trace:
> [    1.016329]  <TASK>
> [    1.016329]  debug_object_activate+0x2b9/0x300
> [    1.016329]  ? debug_object_assert_init+0x220/0x220
> [    1.016329]  ? lockdep_hardirqs_on_prepare+0x13/0x210
> [    1.016329]  ? call_rcu+0xde/0x150
> [    1.016329]  ? trace_hardirqs_on+0x54/0x120
> [    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    1.016329]  call_rcu+0x20/0x150
> [    1.016329]  rcu_torture_init+0x1687/0x1759
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? irq_pm_init_ops+0x19/0x19
> [    1.016329]  ? mutex_unlock+0x12/0x20
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  do_one_initcall+0xc1/0x310
> [    1.016329]  ? initcall_blacklisted+0x140/0x140
> [    1.016329]  ? parameq+0x20/0x90
> [    1.016329]  ? __kmalloc+0x238/0x5d0
> [    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
> [    1.016329]  kernel_init_freeable+0x20a/0x268
> [    1.016329]  ? rest_init+0x160/0x160
> [    1.016329]  kernel_init+0x1e/0x140
> [    1.016329]  ret_from_fork+0x22/0x30
> [    1.016329]  </TASK>
> [    1.016329] irq event stamp: 152
> [    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw_spin_unlock_irqrestore+0x4c/0x60
> [    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw_spin_lock_irqsave+0x71/0x90
> [    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_process+0xc8c/0x31b0
> [    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.016329] ---[ end trace 0000000000000000 ]---
> [    1.016329] ------------[ cut here ]------------
> [    1.016329] ODEBUG: active_state active (active state 1) object type: rcu_head hint: 0x0
> [    1.016329] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_print_object+0xda/0x100
> [    1.016329] Modules linked in:
> [    1.016329] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.19.0-rc3-yoctodev-standard+ #214
> [    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    1.016329] RIP: 0010:debug_print_object+0xda/0x100
> [    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e1 48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <0f> e
> [    1.016329] RSP: 0000:ffff888001337bd0 EFLAGS: 00010082
> [    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed1000266f6c
> [    1.016329] RBP: ffff888001337c00 R08: ffffffff90a56ee6 R09: fffffbfff25df5c2
> [    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 0000000000000001
> [    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e640 R15: 0000000000000000
> [    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlGS:0000000000000000
> [    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 00000000001506f0
> [    1.016329] Call Trace:
> [    1.016329]  <TASK>
> [    1.016329]  debug_object_active_state+0x1d7/0x210
> [    1.016329]  ? debug_object_deactivate+0x210/0x210
> [    1.016329]  ? lockdep_hardirqs_on_prepare+0x13/0x210
> [    1.016329]  ? call_rcu+0xde/0x150
> [    1.016329]  ? trace_hardirqs_on+0x54/0x120
> [    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    1.016329]  call_rcu+0x39/0x150
> [    1.016329]  rcu_torture_init+0x1687/0x1759
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? irq_pm_init_ops+0x19/0x19
> [    1.016329]  ? mutex_unlock+0x12/0x20
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  do_one_initcall+0xc1/0x310
> [    1.016329]  ? initcall_blacklisted+0x140/0x140
> [    1.016329]  ? parameq+0x20/0x90
> [    1.016329]  ? __kmalloc+0x238/0x5d0
> [    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
> [    1.016329]  kernel_init_freeable+0x20a/0x268
> [    1.016329]  ? rest_init+0x160/0x160
> [    1.016329]  kernel_init+0x1e/0x140
> [    1.016329]  ret_from_fork+0x22/0x30
> [    1.016329]  </TASK>
> [    1.016329] irq event stamp: 152
> [    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw_spin_unlock_irqrestore+0x4c/0x60
> [    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw_spin_lock_irqsave+0x71/0x90
> [    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_process+0xc8c/0x31b0
> [    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.016329] ---[ end trace 0000000000000000 ]---
> [    1.016329] call_rcu(): Double-freed CB (____ptrval____)->rcu_torture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
> [    1.016329] ------------[ cut here ]------------
> [    1.016329] ODEBUG: activate active (active state 1) object type: rcu_head hint: 0x0
> [    1.016329] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_print_object+0xda/0x100
> [    1.016329] Modules linked in:
> [    1.016329] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.19.0-rc3-yoctodev-standard+ #214
> [    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    1.016329] RIP: 0010:debug_print_object+0xda/0x100
> [    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e1 48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <0f> e
> [    1.016329] RSP: 0000:ffff888001337be0 EFLAGS: 00010086
> [    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed1000266f6e
> [    1.016329] RBP: ffff888001337c10 R08: ffffffff90a56ee6 R09: fffffbfff25df5c2
> [    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 0000000000000001
> [    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e8a0 R15: 0000000000000000
> [    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlGS:0000000000000000
> [    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 00000000001506f0
> [    1.016329] Call Trace:
> [    1.016329]  <TASK>
> [    1.016329]  debug_object_activate+0x2b9/0x300
> [    1.016329]  ? debug_object_assert_init+0x220/0x220
> [    1.016329]  ? _raw_spin_unlock+0x23/0x30
> [    1.016329]  ? find_vmap_area+0x5c/0x90
> [    1.016329]  ? do_raw_spin_unlock+0x85/0xe0
> [    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    1.016329]  call_rcu+0x20/0x150
> [    1.016329]  rcu_torture_init+0x16aa/0x1759
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? srcu_torture_completed+0x10/0x10
> [    1.016329]  ? irq_pm_init_ops+0x19/0x19
> [    1.016329]  ? mutex_unlock+0x12/0x20
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  do_one_initcall+0xc1/0x310
> [    1.016329]  ? initcall_blacklisted+0x140/0x140
> [    1.016329]  ? parameq+0x20/0x90
> [    1.016329]  ? __kmalloc+0x238/0x5d0
> [    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
> [    1.016329]  kernel_init_freeable+0x20a/0x268
> [    1.016329]  ? rest_init+0x160/0x160
> [    1.016329]  kernel_init+0x1e/0x140
> [    1.016329]  ret_from_fork+0x22/0x30
> [    1.016329]  </TASK>
> [    1.016329] irq event stamp: 152
> [    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw_spin_unlock_irqrestore+0x4c/0x60
> [    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw_spin_lock_irqsave+0x71/0x90
> [    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_process+0xc8c/0x31b0
> [    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.016329] ---[ end trace 0000000000000000 ]---
> [    1.016329] ------------[ cut here ]------------
> [    1.016329] ODEBUG: active_state active (active state 1) object type: rcu_head hint: 0x0
> [    1.016329] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_print_object+0xda/0x100
> [    1.016329] Modules linked in:
> [    1.016329] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.19.0-rc3-yoctodev-standard+ #214
> [    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    1.016329] RIP: 0010:debug_print_object+0xda/0x100
> [    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e1 48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <0f> e
> [    1.016329] RSP: 0000:ffff888001337bd0 EFLAGS: 00010082
> [    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed1000266f6c
> [    1.016329] RBP: ffff888001337c00 R08: ffffffff90a56ee6 R09: fffffbfff25df5c2
> [    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 0000000000000001
> [    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e640 R15: 0000000000000000
> [    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlGS:0000000000000000
> [    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 00000000001506f0
> [    1.016329] Call Trace:
> [    1.016329]  <TASK>
> [    1.016329]  debug_object_active_state+0x1d7/0x210
> [    1.016329]  ? debug_object_deactivate+0x210/0x210
> [    1.016329]  ? _raw_spin_unlock+0x23/0x30
> [    1.016329]  ? find_vmap_area+0x5c/0x90
> [    1.016329]  ? do_raw_spin_unlock+0x85/0xe0
> [    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    1.016329]  call_rcu+0x39/0x150
> [    1.016329]  rcu_torture_init+0x16aa/0x1759
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? srcu_torture_completed+0x10/0x10
> [    1.016329]  ? irq_pm_init_ops+0x19/0x19
> [    1.016329]  ? mutex_unlock+0x12/0x20
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  do_one_initcall+0xc1/0x310
> [    1.016329]  ? initcall_blacklisted+0x140/0x140
> [    1.016329]  ? parameq+0x20/0x90
> [    1.016329]  ? __kmalloc+0x238/0x5d0
> [    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
> [    1.016329]  kernel_init_freeable+0x20a/0x268
> [    1.016329]  ? rest_init+0x160/0x160
> [    1.016329]  kernel_init+0x1e/0x140
> [    1.016329]  ret_from_fork+0x22/0x30
> [    1.016329]  </TASK>
> [    1.016329] irq event stamp: 152
> [    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw_spin_unlock_irqrestore+0x4c/0x60
> [    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw_spin_lock_irqsave+0x71/0x90
> [    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_process+0xc8c/0x31b0
> [    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.016329] ---[ end trace 0000000000000000 ]---
> [    1.016329] call_rcu(): Double-freed CB (____ptrval____)->rcu_torture_leak_cb+0x0/0x10()!!!   slab kmalloc-16 start ffff888003f49240 pointer offset 06
> [    1.101401] rcu-torture: rcu_torture_read_exit: Start of test
> 
> Thanks
> Zqiang
> 
> 
> >
> >							Thanx, Paul
> 
> > ---
> >  v1->v2:
> >  for do duplicate kvfree_call_rcu(), not set leak callbacks. 
> > 
> >  kernel/rcu/tiny.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > index f0561ee16b9c..943d431b908f 100644
> > --- a/kernel/rcu/tiny.c
> > +++ b/kernel/rcu/tiny.c
> > @@ -158,6 +158,10 @@ void synchronize_rcu(void)
> >  }
> >  EXPORT_SYMBOL_GPL(synchronize_rcu);
> >  
> > +static void tiny_rcu_leak_callback(struct rcu_head *rhp)
> > +{
> > +}
> > +
> >  /*
> >   * Post an RCU callback to be invoked after the end of an RCU grace
> >   * period.  But since we have but one CPU, that would be after any
> > @@ -165,9 +169,20 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
> >   */
> >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  {
> > +	static atomic_t doublefrees;
> >  	unsigned long flags;
> >  
> > -	debug_rcu_head_queue(head);
> > +	if (debug_rcu_head_queue(head)) {
> > +		if (atomic_inc_return(&doublefrees) < 4) {
> > +			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
> > +			mem_dump_obj(head);
> > +		}
> > +
> > +		if (!__is_kvfree_rcu_offset((unsigned long)head->func))
> > +			WRITE_ONCE(head->func, tiny_rcu_leak_callback);
> > +		return;
> > +	}
> > +
> >  	head->func = func;
> >  	head->next = NULL;
> >  
> > -- 
> > 2.25.1
> > 
