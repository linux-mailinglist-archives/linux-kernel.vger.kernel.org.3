Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D7C5A2446
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343736AbiHZJ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343772AbiHZJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:26:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF39D7CD3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:26:13 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDZ8v4nl9zYcsH;
        Fri, 26 Aug 2022 17:21:51 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 17:26:10 +0800
Received: from ubuntu1804.huawei.com (10.67.174.149) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 17:26:10 +0800
From:   Ye Weihua <yeweihua4@huawei.com>
To:     <ebiederm@xmission.com>, <keescook@chromium.org>,
        <oleg@redhat.com>, <tglx@linutronix.de>, <chang.seok.bae@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <yeweihua4@huawei.com>
Subject: [PATCH] signal: fix deadlock caused by calling printk() under sighand->siglock
Date:   Fri, 26 Aug 2022 17:22:58 +0800
Message-ID: <20220826092258.147322-1-yeweihua4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.149]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__dend_signal_locked() invokes __sigqueue_alloc() which may invoke a
normal printk() to print failure message. This can cause a deadlock in
the scenario reported by syz-bot below (test in 5.10):

	CPU0				CPU1
	----				----
	lock(&sighand->siglock);
					lock(&tty->read_wait);
					lock(&sighand->siglock);
	lock(console_owner);

This patch specities __GFP_NOWARN to __sigqueue_alloc(), so that printk
will not be called, and this deadlock problem can be avoided.

Syzbot reported the following lockdep error:

======================================================
WARNING: possible circular locking dependency detected
5.10.0-04424-ga472e3c833d3 #1 Not tainted
------------------------------------------------------
syz-executor.2/31970 is trying to acquire lock:
ffffa00014066a60 (console_owner){-.-.}-{0:0}, at: console_trylock_spinning+0xf0/0x2e0 kernel/printk/printk.c:1854

but task is already holding lock:
ffff0000ddb38a98 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x60/0x260 kernel/signal.c:1322

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #4 (&sighand->siglock){-.-.}-{2:2}:
       validate_chain+0x6dc/0xb0c kernel/locking/lockdep.c:3728
       __lock_acquire+0x498/0x940 kernel/locking/lockdep.c:4954
       lock_acquire+0x228/0x580 kernel/locking/lockdep.c:5564
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xc0/0x15c kernel/locking/spinlock.c:159
       __lock_task_sighand+0xf0/0x370 kernel/signal.c:1396
       lock_task_sighand include/linux/sched/signal.h:699 [inline]
       task_work_add+0x1f8/0x2a0 kernel/task_work.c:58
       io_req_task_work_add+0x98/0x10c fs/io_uring.c:2115
       __io_async_wake+0x338/0x780 fs/io_uring.c:4984
       io_poll_wake+0x40/0x50 fs/io_uring.c:5461
       __wake_up_common+0xcc/0x2a0 kernel/sched/wait.c:93
       __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:123
       __wake_up+0x1c/0x24 kernel/sched/wait.c:142
       pty_set_termios+0x1ac/0x2d0 drivers/tty/pty.c:286
       tty_set_termios+0x310/0x46c drivers/tty/tty_ioctl.c:334
       set_termios.part.0+0x2dc/0xa50 drivers/tty/tty_ioctl.c:414
       set_termios drivers/tty/tty_ioctl.c:368 [inline]
       tty_mode_ioctl+0x4f4/0xbec drivers/tty/tty_ioctl.c:736
       n_tty_ioctl_helper+0x74/0x260 drivers/tty/tty_ioctl.c:883
       n_tty_ioctl+0x80/0x3d0 drivers/tty/n_tty.c:2516
       tty_ioctl+0x508/0x1100 drivers/tty/tty_io.c:2751
       vfs_ioctl fs/ioctl.c:48 [inline]
       __do_sys_ioctl fs/ioctl.c:753 [inline]
       __se_sys_ioctl fs/ioctl.c:739 [inline]
       __arm64_sys_ioctl+0x12c/0x18c fs/ioctl.c:739
       __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
       el0_svc_common.constprop.0+0xf8/0x420 arch/arm64/kernel/syscall.c:155
       do_el0_svc+0x50/0x120 arch/arm64/kernel/syscall.c:217
       el0_svc+0x20/0x30 arch/arm64/kernel/entry-common.c:353
       el0_sync_handler+0xe4/0x1e0 arch/arm64/kernel/entry-common.c:369
       el0_sync+0x148/0x180 arch/arm64/kernel/entry.S:683

-> #3 (&tty->read_wait){....}-{2:2}:
       validate_chain+0x6dc/0xb0c kernel/locking/lockdep.c:3728
       __lock_acquire+0x498/0x940 kernel/locking/lockdep.c:4954
       lock_acquire+0x228/0x580 kernel/locking/lockdep.c:5564
       __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
       _raw_spin_lock+0xa0/0x120 kernel/locking/spinlock.c:151
       spin_lock include/linux/spinlock.h:354 [inline]
       io_poll_double_wake+0x158/0x30c fs/io_uring.c:5093
       __wake_up_common+0xcc/0x2a0 kernel/sched/wait.c:93
       __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:123
       __wake_up+0x1c/0x24 kernel/sched/wait.c:142
       pty_close+0x1bc/0x330 drivers/tty/pty.c:68
       tty_release+0x1e0/0x88c drivers/tty/tty_io.c:1761
       __fput+0x1dc/0x500 fs/file_table.c:281
       ____fput+0x24/0x30 fs/file_table.c:314
       task_work_run+0xf4/0x1ec kernel/task_work.c:151
       tracehook_notify_resume include/linux/tracehook.h:188 [inline]
       do_notify_resume+0x378/0x410 arch/arm64/kernel/signal.c:718
       work_pending+0xc/0x198

-> #2 (&tty->write_wait){....}-{2:2}:
       validate_chain+0x6dc/0xb0c kernel/locking/lockdep.c:3728
       __lock_acquire+0x498/0x940 kernel/locking/lockdep.c:4954
       lock_acquire+0x228/0x580 kernel/locking/lockdep.c:5564
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xc0/0x15c kernel/locking/spinlock.c:159
       __wake_up_common_lock+0xb0/0x130 kernel/sched/wait.c:122
       __wake_up+0x1c/0x24 kernel/sched/wait.c:142
       tty_wakeup+0x54/0xbc drivers/tty/tty_io.c:539
       tty_port_default_wakeup+0x38/0x50 drivers/tty/tty_port.c:50
       tty_port_tty_wakeup+0x3c/0x50 drivers/tty/tty_port.c:388
       uart_write_wakeup+0x38/0x60 drivers/tty/serial/serial_core.c:106
       pl011_tx_chars+0x530/0x5c0 drivers/tty/serial/amba-pl011.c:1418
       pl011_start_tx_pio drivers/tty/serial/amba-pl011.c:1303 [inline]
       pl011_start_tx+0x1b4/0x430 drivers/tty/serial/amba-pl011.c:1315
       __uart_start.isra.0+0xb4/0xcc drivers/tty/serial/serial_core.c:127
       uart_write+0x21c/0x460 drivers/tty/serial/serial_core.c:613
       process_output_block+0x120/0x3ac drivers/tty/n_tty.c:590
       n_tty_write+0x2c8/0x650 drivers/tty/n_tty.c:2383
       do_tty_write drivers/tty/tty_io.c:1028 [inline]
       file_tty_write.constprop.0+0x2d0/0x520 drivers/tty/tty_io.c:1118
       tty_write drivers/tty/tty_io.c:1125 [inline]
       redirected_tty_write+0xe4/0x104 drivers/tty/tty_io.c:1147
       call_write_iter include/linux/fs.h:1960 [inline]
       new_sync_write+0x264/0x37c fs/read_write.c:515
       vfs_write+0x694/0x9d0 fs/read_write.c:602
       ksys_write+0xfc/0x200 fs/read_write.c:655
       __do_sys_write fs/read_write.c:667 [inline]
       __se_sys_write fs/read_write.c:664 [inline]
       __arm64_sys_write+0x50/0x60 fs/read_write.c:664
       __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
       el0_svc_common.constprop.0+0xf8/0x420 arch/arm64/kernel/syscall.c:155
       do_el0_svc+0x50/0x120 arch/arm64/kernel/syscall.c:217
       el0_svc+0x20/0x30 arch/arm64/kernel/entry-common.c:353
       el0_sync_handler+0xe4/0x1e0 arch/arm64/kernel/entry-common.c:369
       el0_sync+0x148/0x180 arch/arm64/kernel/entry.S:683

-> #1 (&port_lock_key){-.-.}-{2:2}:
       validate_chain+0x6dc/0xb0c kernel/locking/lockdep.c:3728
       __lock_acquire+0x498/0x940 kernel/locking/lockdep.c:4954
       lock_acquire+0x228/0x580 kernel/locking/lockdep.c:5564
       __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
       _raw_spin_lock+0xa0/0x120 kernel/locking/spinlock.c:151
       spin_lock include/linux/spinlock.h:354 [inline]
       pl011_console_write+0x2f0/0x410 drivers/tty/serial/amba-pl011.c:2263
       call_console_drivers.constprop.0+0x1f8/0x3b0 kernel/printk/printk.c:1932
       console_unlock+0x36c/0x9ec kernel/printk/printk.c:2553
       vprintk_emit+0x40c/0x4b0 kernel/printk/printk.c:2075
       vprintk_default+0x48/0x54 kernel/printk/printk.c:2092
       vprintk_func+0x1f0/0x40c kernel/printk/printk_safe.c:404
       printk+0xbc/0xf0 kernel/printk/printk.c:2123
       register_console+0x580/0x790 kernel/printk/printk.c:2905
       uart_configure_port.constprop.0+0x4a0/0x4e0 drivers/tty/serial/serial_core.c:2431
       uart_add_one_port+0x378/0x550 drivers/tty/serial/serial_core.c:2944
       pl011_register_port+0xb4/0x210 drivers/tty/serial/amba-pl011.c:2686
       pl011_probe+0x334/0x3ec drivers/tty/serial/amba-pl011.c:2736
       amba_probe+0x14c/0x2f0 drivers/amba/bus.c:283
       really_probe+0x210/0xa5c drivers/base/dd.c:562
       driver_probe_device+0x1c8/0x280 drivers/base/dd.c:747
       __device_attach_driver+0x18c/0x260 drivers/base/dd.c:853
       bus_for_each_drv+0x120/0x1a0 drivers/base/bus.c:431
       __device_attach+0x16c/0x3b4 drivers/base/dd.c:922
       device_initial_probe+0x28/0x34 drivers/base/dd.c:971
       bus_probe_device+0x124/0x13c drivers/base/bus.c:491
       fw_devlink_resume+0x164/0x270 drivers/base/core.c:1601
       of_platform_default_populate_init+0xf4/0x114 drivers/of/platform.c:543
       do_one_initcall+0x11c/0x770 init/main.c:1217
       do_initcall_level+0x364/0x388 init/main.c:1290
       do_initcalls+0x90/0xc0 init/main.c:1306
       do_basic_setup init/main.c:1326 [inline]
       kernel_init_freeable+0x57c/0x63c init/main.c:1529
       kernel_init+0x1c/0x20c init/main.c:1417
       ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1034

-> #0 (console_owner){-.-.}-{0:0}:
       check_prev_add+0xe0/0x105c kernel/locking/lockdep.c:2988
       check_prevs_add+0x1c8/0x3d4 kernel/locking/lockdep.c:3113
       validate_chain+0x6dc/0xb0c kernel/locking/lockdep.c:3728
       __lock_acquire+0x498/0x940 kernel/locking/lockdep.c:4954
       lock_acquire+0x228/0x580 kernel/locking/lockdep.c:5564
       console_trylock_spinning+0x130/0x2e0 kernel/printk/printk.c:1875
       vprintk_emit+0x268/0x4b0 kernel/printk/printk.c:2074
       vprintk_default+0x48/0x54 kernel/printk/printk.c:2092
       vprintk_func+0x1f0/0x40c kernel/printk/printk_safe.c:404
       printk+0xbc/0xf0 kernel/printk/printk.c:2123
       fail_dump lib/fault-inject.c:45 [inline]
       should_fail+0x2a0/0x370 lib/fault-inject.c:146
       __should_failslab+0x8c/0xe0 mm/failslab.c:33
       should_failslab+0x14/0x2c mm/slab_common.c:1181
       slab_pre_alloc_hook mm/slab.h:495 [inline]
       slab_alloc_node mm/slub.c:2842 [inline]
       slab_alloc mm/slub.c:2931 [inline]
       kmem_cache_alloc+0x8c/0xe64 mm/slub.c:2936
       __sigqueue_alloc+0x224/0x5a4 kernel/signal.c:437
       __send_signal+0x700/0xeac kernel/signal.c:1121
       send_signal+0x348/0x6a0 kernel/signal.c:1247
       force_sig_info_to_task+0x184/0x260 kernel/signal.c:1339
       force_sig_fault_to_task kernel/signal.c:1678 [inline]
       force_sig_fault+0xb0/0xf0 kernel/signal.c:1685
       arm64_force_sig_fault arch/arm64/kernel/traps.c:182 [inline]
       arm64_notify_die arch/arm64/kernel/traps.c:208 [inline]
       arm64_notify_die+0xdc/0x160 arch/arm64/kernel/traps.c:199
       do_sp_pc_abort+0x4c/0x60 arch/arm64/mm/fault.c:794
       el0_pc+0xd8/0x19c arch/arm64/kernel/entry-common.c:309
       el0_sync_handler+0x12c/0x1e0 arch/arm64/kernel/entry-common.c:394
       el0_sync+0x148/0x180 arch/arm64/kernel/entry.S:683

other info that might help us debug this:

Chain exists of:
  console_owner --> &tty->read_wait --> &sighand->siglock

Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
---
 kernel/signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 6f86fda5e432..3a3581739a6d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1120,7 +1120,8 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 	else
 		override_rlimit = 0;
 
-	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit, 0);
+	q = __sigqueue_alloc(sig, t, GFP_ATOMIC | __GFP_NOWARN,
+			override_rlimit, 0);
 
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
-- 
2.17.1

