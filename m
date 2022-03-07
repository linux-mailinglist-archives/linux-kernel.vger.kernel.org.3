Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21AF4CF361
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiCGIRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiCGIRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:17:03 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ECA60A89
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:16:09 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id v10-20020a92c80a000000b002c281af4ddfso9719075iln.21
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QyeY3ho1nVJ3VNsQDxkGq2q4Jc1XdwqEX14IaF1Zsh0=;
        b=jSwLm4tM9QmkOQWCeDa1Q0QccyyN7veOXvMoJixZUY6nneun588b4FD9AM1NpaOIJW
         ULRtCApfReBVcGGEBKQsbswO+ampE6WtPmd87wUJuYMAit0GIbl6mvYKP7ME5epTJ3yq
         lIKyaonKYybB8RmfRsxbD/Q+VrL+6uorfhcFkjKD0x6/K+5wdgqS8aJcj2ifyT9Kg9RO
         WmJdG+3/lR33IgPGQHmn6vDt3Yj8eJnjKrHT+z14qFdHHlb/u7g2dpWXsiW0+n1uLRDJ
         D9CPGtAhKI/HhoznE54PBSEuDu9eSXfl4ll8HI4Pm4a0Qb97S2QnxtIZxwpQktqwA6mF
         Aw/w==
X-Gm-Message-State: AOAM533xOWPSaoOZ0OHNwAX1mXWu2H4LYXzxtx5nKHMZKIORpgtA+wyc
        3QSI3RsHwb5FajFXwpcGvdUhn9DqCQzQr4SlTeNlRs/e/baZ
X-Google-Smtp-Source: ABdhPJzm0tuvxYt0cComBW5PON5WOYXsRlz05SOvisSPsMm4Ly63k8OtL9jDGxqJBENJokWD5KP9Yuvy6sSBjpSD10x663pCgkX8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:2b9:dcbb:e810 with SMTP id
 m2-20020a056e021c2200b002b9dcbbe810mr9926166ilh.262.1646640968567; Mon, 07
 Mar 2022 00:16:08 -0800 (PST)
Date:   Mon, 07 Mar 2022 00:16:08 -0800
In-Reply-To: <20220307080520.3199-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000110a705d99c7a91@google.com>
Subject: Re: [syzbot] possible deadlock in snd_timer_interrupt (2)
From:   syzbot <syzbot+1ee0910eca9c94f71f25@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in snd_timer_interrupt

========================================================
WARNING: possible irq lock inversion dependency detected
5.17.0-rc6-syzkaller-00184-g38f80f42147f-dirty #0 Not tainted
--------------------------------------------------------
syz-executor295/5049 just changed the state of lock:
ffff888021a6f948 (&timer->lock){..-.}-{2:2}, at: snd_timer_interrupt.part.0+0x33/0xe80 sound/core/timer.c:856
but this lock took another, SOFTIRQ-READ-unsafe lock in the past:
 (tasklist_lock){.+.+}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
Chain exists of:
  &timer->lock --> &new->fa_lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&timer->lock);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(&timer->lock);

 *** DEADLOCK ***

2 locks held by syz-executor295/5049:
 #0: ffff88801bbbc028 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:71 [inline]
 #0: ffff88801bbbc028 (&mm->mmap_lock#2){++++}-{3:3}, at: exit_mmap+0x10d/0x6a0 mm/mmap.c:3160
 #1: ffffc90000dc0d70 ((&priv->tlist)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:35 [inline]
 #1: ffffc90000dc0d70 ((&priv->tlist)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1411

the shortest dependencies between 2nd lock and 1st lock:
   -> (tasklist_lock){.+.+}-{2:2} {
      HARDIRQ-ON-R at:
                          lock_acquire kernel/locking/lockdep.c:5639 [inline]
                          lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                          __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                          _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                          do_wait+0x284/0xce0 kernel/exit.c:1518
                          kernel_wait+0x9c/0x150 kernel/exit.c:1708
                          call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                          call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                          process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
                          worker_thread+0x657/0x1110 kernel/workqueue.c:2454
                          kthread+0x2e9/0x3a0 kernel/kthread.c:377
                          ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
      SOFTIRQ-ON-R at:
                          lock_acquire kernel/locking/lockdep.c:5639 [inline]
                          lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                          __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                          _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                          do_wait+0x284/0xce0 kernel/exit.c:1518
                          kernel_wait+0x9c/0x150 kernel/exit.c:1708
                          call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                          call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                          process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
                          worker_thread+0x657/0x1110 kernel/workqueue.c:2454
                          kthread+0x2e9/0x3a0 kernel/kthread.c:377
                          ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
      INITIAL USE at:
                         lock_acquire kernel/locking/lockdep.c:5639 [inline]
                         lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                         __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                         _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:326
                         copy_process+0x486a/0x7250 kernel/fork.c:2295
                         kernel_clone+0xe7/0xab0 kernel/fork.c:2565
                         kernel_thread+0xb5/0xf0 kernel/fork.c:2617
                         rest_init+0x23/0x3e0 init/main.c:690
                         start_kernel+0x47a/0x49b init/main.c:1138
                         secondary_startup_64_no_verify+0xc3/0xcb
      INITIAL READ USE at:
                              lock_acquire kernel/locking/lockdep.c:5639 [inline]
                              lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                              __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                              _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                              do_wait+0x284/0xce0 kernel/exit.c:1518
                              kernel_wait+0x9c/0x150 kernel/exit.c:1708
                              call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                              call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                              process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
                              worker_thread+0x657/0x1110 kernel/workqueue.c:2454
                              kthread+0x2e9/0x3a0 kernel/kthread.c:377
                              ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
    }
    ... key      at: [<ffffffff8b80a098>] tasklist_lock+0x18/0x40
    ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
   send_sigio+0xab/0x380 fs/fcntl.c:810
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1393
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
   snd_timer_stop1+0x496/0x860 sound/core/timer.c:657
   snd_timer_stop sound/core/timer.c:710 [inline]
   snd_timer_close_locked+0x20f/0xbb0 sound/core/timer.c:408
   snd_timer_close+0x87/0xf0 sound/core/timer.c:463
   __snd_timer_user_ioctl.isra.0+0x10e2/0x2490 sound/core/timer.c:1769
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2135
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

  -> (&f->f_owner.lock){....}-{2:2} {
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5639 [inline]
                       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                       __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                       _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:326
                       f_modown+0x2a/0x390 fs/fcntl.c:91
                       __f_setown fs/fcntl.c:110 [inline]
                       f_setown+0xd7/0x230 fs/fcntl.c:138
                       do_fcntl+0x749/0x1210 fs/fcntl.c:393
                       __do_sys_fcntl fs/fcntl.c:472 [inline]
                       __se_sys_fcntl fs/fcntl.c:457 [inline]
                       __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:457
                       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                       entry_SYSCALL_64_after_hwframe+0x44/0xae
     INITIAL READ USE at:
                            lock_acquire kernel/locking/lockdep.c:5639 [inline]
                            lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                            __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                            _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
                            send_sigio+0x24/0x380 fs/fcntl.c:796
                            kill_fasync_rcu fs/fcntl.c:1021 [inline]
                            kill_fasync fs/fcntl.c:1035 [inline]
                            kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
                            snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1393
                            snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
                            snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
                            snd_timer_start sound/core/timer.c:696 [inline]
                            snd_timer_start sound/core/timer.c:689 [inline]
                            snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1991
                            __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2114
                            snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2135
                            vfs_ioctl fs/ioctl.c:51 [inline]
                            __do_sys_ioctl fs/ioctl.c:874 [inline]
                            __se_sys_ioctl fs/ioctl.c:860 [inline]
                            __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
                            do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                            do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                            entry_SYSCALL_64_after_hwframe+0x44/0xae
   }
   ... key      at: [<ffffffff90585a40>] __key.5+0x0/0x40
   ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   send_sigio+0x24/0x380 fs/fcntl.c:796
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1393
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
   snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_start sound/core/timer.c:689 [inline]
   snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1991
   __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2114
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2135
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

 -> (&new->fa_lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5639 [inline]
                     lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                     _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:326
                     fasync_remove_entry+0xb6/0x1f0 fs/fcntl.c:891
                     fasync_helper+0x9e/0xb0 fs/fcntl.c:994
                     __fput+0x846/0x9f0 fs/file_table.c:314
                     task_work_run+0xdd/0x1a0 kernel/task_work.c:164
                     exit_task_work include/linux/task_work.h:32 [inline]
                     do_exit+0xb29/0x2a30 kernel/exit.c:806
                     do_group_exit+0xd2/0x2f0 kernel/exit.c:935
                     __do_sys_exit_group kernel/exit.c:946 [inline]
                     __se_sys_exit_group kernel/exit.c:944 [inline]
                     __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
                     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                     do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                     entry_SYSCALL_64_after_hwframe+0x44/0xae
    INITIAL READ USE at:
                          lock_acquire kernel/locking/lockdep.c:5639 [inline]
                          lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                          __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                          _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
                          kill_fasync_rcu fs/fcntl.c:1014 [inline]
                          kill_fasync fs/fcntl.c:1035 [inline]
                          kill_fasync+0x136/0x470 fs/fcntl.c:1028
                          snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1393
                          snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
                          snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
                          snd_timer_start sound/core/timer.c:696 [inline]
                          snd_timer_start sound/core/timer.c:689 [inline]
                          snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1991
                          __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2114
                          snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2135
                          vfs_ioctl fs/ioctl.c:51 [inline]
                          __do_sys_ioctl fs/ioctl.c:874 [inline]
                          __se_sys_ioctl fs/ioctl.c:860 [inline]
                          __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                          do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                          entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff90586820>] __key.0+0x0/0x40
  ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1014 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x136/0x470 fs/fcntl.c:1028
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1393
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
   snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_start sound/core/timer.c:689 [inline]
   snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1991
   __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2114
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2135
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

-> (&timer->lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5639 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                    snd_timer_interrupt.part.0+0x33/0xe80 sound/core/timer.c:856
                    snd_timer_interrupt sound/core/timer.c:1161 [inline]
                    snd_timer_s_function+0x14b/0x200 sound/core/timer.c:1161
                    call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
                    expire_timers kernel/time/timer.c:1466 [inline]
                    __run_timers.part.0+0x67c/0xa30 kernel/time/timer.c:1734
                    __run_timers kernel/time/timer.c:1715 [inline]
                    run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
                    __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
                    invoke_softirq kernel/softirq.c:432 [inline]
                    __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
                    irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
                    sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
                    asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
                    native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
                    arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
                    arch_local_irq_save arch/x86/include/asm/irqflags.h:106 [inline]
                    lock_is_held_type+0x51/0x140 kernel/locking/lockdep.c:5678
                    lock_is_held include/linux/lockdep.h:283 [inline]
                    __might_resched+0x3a/0x2c0 kernel/sched/core.c:9547
                    down_write+0x6c/0x150 kernel/locking/rwsem.c:1513
                    i_mmap_lock_write include/linux/fs.h:492 [inline]
                    unlink_file_vma+0x7d/0x110 mm/mmap.c:170
                    free_pgtables+0x1b3/0x2f0 mm/memory.c:428
                    exit_mmap+0x210/0x6a0 mm/mmap.c:3179
                    __mmput+0x122/0x4b0 kernel/fork.c:1114
                    mmput+0x56/0x60 kernel/fork.c:1135
                    exit_mm kernel/exit.c:507 [inline]
                    do_exit+0xa3c/0x2a30 kernel/exit.c:793
                    do_group_exit+0xd2/0x2f0 kernel/exit.c:935
                    __do_sys_exit_group kernel/exit.c:946 [inline]
                    __se_sys_exit_group kernel/exit.c:944 [inline]
                    __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
                    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                    do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                    entry_SYSCALL_64_after_hwframe+0x44/0xae
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5639 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                   snd_timer_notify sound/core/timer.c:1093 [inline]
                   snd_timer_notify+0x10c/0x3d0 sound/core/timer.c:1080
                   snd_pcm_timer_notify sound/core/pcm_native.c:608 [inline]
                   snd_pcm_post_stop+0x195/0x1f0 sound/core/pcm_native.c:1466
                   snd_pcm_action_single sound/core/pcm_native.c:1242 [inline]
                   snd_pcm_action+0x143/0x170 sound/core/pcm_native.c:1323
                   snd_pcm_stop sound/core/pcm_native.c:1489 [inline]
                   snd_pcm_drop+0x1ab/0x320 sound/core/pcm_native.c:2168
                   snd_pcm_kernel_ioctl+0x2af/0x310 sound/core/pcm_native.c:3395
                   snd_pcm_oss_sync+0x230/0x800 sound/core/oss/pcm_oss.c:1734
                   snd_pcm_oss_release+0x276/0x300 sound/core/oss/pcm_oss.c:2584
                   __fput+0x286/0x9f0 fs/file_table.c:317
                   task_work_run+0xdd/0x1a0 kernel/task_work.c:164
                   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
                   exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
                   exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
                   __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
                   syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
                   do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff908843c0>] __key.12+0x0/0x40
 ... acquired at:
   mark_lock kernel/locking/lockdep.c:4569 [inline]
   mark_usage kernel/locking/lockdep.c:4500 [inline]
   __lock_acquire+0x11e3/0x56c0 kernel/locking/lockdep.c:4981
   lock_acquire kernel/locking/lockdep.c:5639 [inline]
   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
   snd_timer_interrupt.part.0+0x33/0xe80 sound/core/timer.c:856
   snd_timer_interrupt sound/core/timer.c:1161 [inline]
   snd_timer_s_function+0x14b/0x200 sound/core/timer.c:1161
   call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
   expire_timers kernel/time/timer.c:1466 [inline]
   __run_timers.part.0+0x67c/0xa30 kernel/time/timer.c:1734
   __run_timers kernel/time/timer.c:1715 [inline]
   run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
   __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
   invoke_softirq kernel/softirq.c:432 [inline]
   __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
   irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
   sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
   asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
   native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
   arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
   arch_local_irq_save arch/x86/include/asm/irqflags.h:106 [inline]
   lock_is_held_type+0x51/0x140 kernel/locking/lockdep.c:5678
   lock_is_held include/linux/lockdep.h:283 [inline]
   __might_resched+0x3a/0x2c0 kernel/sched/core.c:9547
   down_write+0x6c/0x150 kernel/locking/rwsem.c:1513
   i_mmap_lock_write include/linux/fs.h:492 [inline]
   unlink_file_vma+0x7d/0x110 mm/mmap.c:170
   free_pgtables+0x1b3/0x2f0 mm/memory.c:428
   exit_mmap+0x210/0x6a0 mm/mmap.c:3179
   __mmput+0x122/0x4b0 kernel/fork.c:1114
   mmput+0x56/0x60 kernel/fork.c:1135
   exit_mm kernel/exit.c:507 [inline]
   do_exit+0xa3c/0x2a30 kernel/exit.c:793
   do_group_exit+0xd2/0x2f0 kernel/exit.c:935
   __do_sys_exit_group kernel/exit.c:946 [inline]
   __se_sys_exit_group kernel/exit.c:944 [inline]
   __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


stack backtrace:
CPU: 1 PID: 5049 Comm: syz-executor295 Not tainted 5.17.0-rc6-syzkaller-00184-g38f80f42147f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_irq_inversion_bug kernel/locking/lockdep.c:194 [inline]
 check_usage_forwards kernel/locking/lockdep.c:4043 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4175 [inline]
 mark_lock.part.0.cold+0x86/0xd8 kernel/locking/lockdep.c:4605
 mark_lock kernel/locking/lockdep.c:4569 [inline]
 mark_usage kernel/locking/lockdep.c:4500 [inline]
 __lock_acquire+0x11e3/0x56c0 kernel/locking/lockdep.c:4981
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 snd_timer_interrupt.part.0+0x33/0xe80 sound/core/timer.c:856
 snd_timer_interrupt sound/core/timer.c:1161 [inline]
 snd_timer_s_function+0x14b/0x200 sound/core/timer.c:1161
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x67c/0xa30 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_local_irq_save arch/x86/include/asm/irqflags.h:106 [inline]
RIP: 0010:lock_is_held_type+0x51/0x140 kernel/locking/lockdep.c:5678
Code: b6 76 85 c0 0f 85 ca 00 00 00 65 4c 8b 24 25 00 70 02 00 41 8b 94 24 5c 0a 00 00 85 d2 0f 85 b1 00 00 00 48 89 fd 41 89 f6 9c <8f> 04 24 fa 48 c7 c7 e0 60 ac 89 31 db e8 fd 0d 00 00 41 8b 84 24
RSP: 0018:ffffc9000333fb08 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffffffff8bb84520
RBP: ffffffff8bb84520 R08: 0000000000000000 R09: ffffffff8ffc4977
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888022f40000
R13: 00000000ffffffff R14: 00000000ffffffff R15: 0000000000000000
 lock_is_held include/linux/lockdep.h:283 [inline]
 __might_resched+0x3a/0x2c0 kernel/sched/core.c:9547
 down_write+0x6c/0x150 kernel/locking/rwsem.c:1513
 i_mmap_lock_write include/linux/fs.h:492 [inline]
 unlink_file_vma+0x7d/0x110 mm/mmap.c:170
 free_pgtables+0x1b3/0x2f0 mm/memory.c:428
 exit_mmap+0x210/0x6a0 mm/mmap.c:3179
 __mmput+0x122/0x4b0 kernel/fork.c:1114
 mmput+0x56/0x60 kernel/fork.c:1135
 exit_mm kernel/exit.c:507 [inline]
 do_exit+0xa3c/0x2a30 kernel/exit.c:793
 do_group_exit+0xd2/0x2f0 kernel/exit.c:935
 __do_sys_exit_group kernel/exit.c:946 [inline]
 __se_sys_exit_group kernel/exit.c:944 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa5e94ccc89
Code: Unable to access opcode bytes at RIP 0x7fa5e94ccc5f.
RSP: 002b:00007ffe3ea446b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa5e9541330 RCX: 00007fa5e94ccc89
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 00007fa5e9541330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
----------------
Code disassembly (best guess):
   0:	b6 76                	mov    $0x76,%dh
   2:	85 c0                	test   %eax,%eax
   4:	0f 85 ca 00 00 00    	jne    0xd4
   a:	65 4c 8b 24 25 00 70 	mov    %gs:0x27000,%r12
  11:	02 00
  13:	41 8b 94 24 5c 0a 00 	mov    0xa5c(%r12),%edx
  1a:	00
  1b:	85 d2                	test   %edx,%edx
  1d:	0f 85 b1 00 00 00    	jne    0xd4
  23:	48 89 fd             	mov    %rdi,%rbp
  26:	41 89 f6             	mov    %esi,%r14d
  29:	9c                   	pushfq
* 2a:	8f 04 24             	popq   (%rsp) <-- trapping instruction
  2d:	fa                   	cli
  2e:	48 c7 c7 e0 60 ac 89 	mov    $0xffffffff89ac60e0,%rdi
  35:	31 db                	xor    %ebx,%ebx
  37:	e8 fd 0d 00 00       	callq  0xe39
  3c:	41                   	rex.B
  3d:	8b                   	.byte 0x8b
  3e:	84                   	.byte 0x84
  3f:	24                   	.byte 0x24


Tested on:

commit:         38f80f42 MAINTAINERS: Remove dead patchwork link
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=17ec0c11700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e9585407e09f75f
dashboard link: https://syzkaller.appspot.com/bug?extid=1ee0910eca9c94f71f25
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15000f85700000

