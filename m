Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3698545F60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347778AbiFJIiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347837AbiFJIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:37:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D44553B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:34:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a29so13211177lfk.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RH+whgh3got3+dl8b8OmdI7TW6qFg2n8ZN32SqB4uPY=;
        b=GewrsIZjwKPcpT/Ox7LPW0I4Ypps4biWLKcO7bgADaQ6VSgwIDQALJ1ahPV+q5bAaU
         SmtawYoq41l4jB9PdAvJt22eNC/HpTM9lybymqfyB4UOQ7S9/pong4yiCC29Me8aP2CM
         +5aJNnZoBn7EfMidt1ODeDADVLWv0E1c29zF+wwUXAoLOnwlTnq94HS/eYAs49mUaM1t
         r3bA72KvB1K338HKdWuotwqwRReIsjw1m39iYXClfu94gb2XjPi9xY8QP5eWE4qeld3d
         xe8RLYvR3ksy5ZJ24iAla+kEgOXnTZF4dQgU4nkhFeepuCaUOi7gwrK0+BUID+bJBysI
         3u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RH+whgh3got3+dl8b8OmdI7TW6qFg2n8ZN32SqB4uPY=;
        b=6WTQ60u0HFuY7SF/21FybUXxUPB0Rt6NCUBJbWJyNYJIPAhUSI6OK2c0Uu5ESkxbEa
         QM6sVcE/aFZBOICmwTnsbsOheCJcdDNSZvuA8/D72/M2HeRbs1Dhmza0VOwnzohaWtnP
         jw50xO4OjRuFj1J5er87GneUXr3+ZAmEDy5tvCAy/yHj0kobitjsaV81i5sl9nLdMMXf
         hdJrB9qP06PZi44r5kxiRh5ZoviCm0HQh7Xtit8IzN7pL2ldSjBgyFt9n2Ery5iOVoFl
         h+WpAIjXYCkbGdg/Px6zGjZoPnccfPdQB7kDPEPjT5vqwCp79usdIteVISeA5tvtl9e7
         3+Pw==
X-Gm-Message-State: AOAM533258+hhllmxkTbJ23RXtsoskspIPIwu1PvX6I89YtaY5zi6n5G
        OEmejEmUjHEQ0TkGDhigmXGnB9otFGnJOzKVwh+OEw==
X-Google-Smtp-Source: ABdhPJzs5vYQ1YpqOdhfnoLQSTV1ahTNQcM379Ijqu3ypkFuPhjVfJPSFeUj+sPMUAhV5oQu1LkfICnxM+uKZezULsk=
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr27124674lfb.376.1654850087974; Fri, 10
 Jun 2022 01:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000037e86c05e09bee11@google.com>
In-Reply-To: <00000000000037e86c05e09bee11@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 10 Jun 2022 10:34:36 +0200
Message-ID: <CACT4Y+ZMn3yZOMXSiktCUL_oCKwLvNGG3EXcsn8GHWWLHmKUyQ@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in hwrng_register (2)
To:     syzbot <syzbot+23fb83d1d9fb5e6c54b3@syzkaller.appspotmail.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        mpm@selenic.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jun 2022 at 11:33, syzbot
<syzbot+23fb83d1d9fb5e6c54b3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    032dcf09e2bf Merge tag 'gpio-fixes-for-v5.19-rc1' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=126c9583f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=99f457384a4fea79
> dashboard link: https://syzkaller.appspot.com/bug?extid=23fb83d1d9fb5e6c54b3
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+23fb83d1d9fb5e6c54b3@syzkaller.appspotmail.com

#syz dup: upstream boot error: INFO: task hung in hwrng_register


> INFO: task kworker/1:13:6950 blocked for more than 143 seconds.
>       Not tainted 5.18.0-syzkaller-13760-g032dcf09e2bf #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:13    state:D stack:20992 pid: 6950 ppid:     2 flags:0x00004000
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5116 [inline]
>  __schedule+0x957/0xec0 kernel/sched/core.c:6428
>  schedule+0xeb/0x1b0 kernel/sched/core.c:6500
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6559
>  __mutex_lock_common+0xecf/0x26c0 kernel/locking/mutex.c:679
>  __mutex_lock kernel/locking/mutex.c:747 [inline]
>  mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
>  add_early_randomness drivers/char/hw_random/core.c:69 [inline]
>  hwrng_register+0x3bf/0x680 drivers/char/hw_random/core.c:599
>  chaoskey_probe+0x7f0/0xb10 drivers/usb/misc/chaoskey.c:205
>  usb_probe_interface+0x66e/0xb60 drivers/usb/core/driver.c:396
>  call_driver_probe+0x96/0x250
>  really_probe+0x220/0x940 drivers/base/dd.c:634
>  __driver_probe_device+0x1f4/0x3f0 drivers/base/dd.c:764
>  driver_probe_device+0x50/0x240 drivers/base/dd.c:794
>  __device_attach_driver+0x273/0x3d0 drivers/base/dd.c:917
>  bus_for_each_drv+0x18a/0x210 drivers/base/bus.c:427
>  __device_attach+0x372/0x5a0 drivers/base/dd.c:989
>  bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:487
>  device_add+0xb20/0xf90 drivers/base/core.c:3417
>  usb_set_configuration+0x1a5f/0x20e0 drivers/usb/core/message.c:2170
>  usb_generic_driver_probe+0x83/0x140 drivers/usb/core/generic.c:238
>  usb_probe_device+0x131/0x260 drivers/usb/core/driver.c:293
>  call_driver_probe+0x96/0x250
>  really_probe+0x220/0x940 drivers/base/dd.c:634
>  __driver_probe_device+0x1f4/0x3f0 drivers/base/dd.c:764
>  driver_probe_device+0x50/0x240 drivers/base/dd.c:794
>  __device_attach_driver+0x273/0x3d0 drivers/base/dd.c:917
>  bus_for_each_drv+0x18a/0x210 drivers/base/bus.c:427
>  __device_attach+0x372/0x5a0 drivers/base/dd.c:989
>  bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:487
>  device_add+0xb20/0xf90 drivers/base/core.c:3417
>  usb_new_device+0xbfc/0x18a0 drivers/usb/core/hub.c:2566
>  hub_port_connect+0x106b/0x2930 drivers/usb/core/hub.c:5363
>  hub_port_connect_change+0x619/0xbe0 drivers/usb/core/hub.c:5507
>  port_event+0xeb7/0x1390 drivers/usb/core/hub.c:5663
>  hub_event+0x5be/0xd70 drivers/usb/core/hub.c:5745
>  process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
>  worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
>  kthread+0x266/0x300 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30
>  </TASK>
>
> Showing all locks held in the system:
> 1 lock held by khungtaskd/28:
>  #0: ffffffff8cb1eee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
> 5 locks held by kworker/1:2/145:
>  #0: ffff8881450c4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
>  #1: ffffc900022efd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
>  #2: ffff888147908190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
>  #2: ffff888147908190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1bf/0xd70 drivers/usb/core/hub.c:5691
>  #3: ffff8881479104f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3095 [inline]
>  #3: ffff8881479104f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect+0x4fc/0x2930 drivers/usb/core/hub.c:5259
>  #4: ffff888020563c68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect+0x524/0x2930 drivers/usb/core/hub.c:5260
> 1 lock held by hwrng/755:
>  #0: ffffffff8d24ccc8 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0xec/0x470 drivers/char/hw_random/core.c:503
> 2 locks held by getty/3288:
>  #0: ffff88814a989098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
>  #1: ffffc90002cd62e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6e8/0x1e50 drivers/tty/n_tty.c:2124
> 1 lock held by syz-executor.1/3640:
>  #0: ffffffff8cb23fe0 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:290 [inline]
>  #0: ffffffff8cb23fe0 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x266/0x720 kernel/rcu/tree_exp.h:927
> 4 locks held by kworker/u4:13/4639:
>  #0: ffff888011dba938 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
>  #1: ffffc90007727d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
>  #2: ffffffff8dbb2610 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xf0/0xc50 net/core/net_namespace.c:556
>  #3: ffffffff8dbbe768 (rtnl_mutex){+.+.}-{3:3}, at: tc_action_net_exit include/net/act_api.h:170 [inline]
>  #3: ffffffff8dbbe768 (rtnl_mutex){+.+.}-{3:3}, at: gate_exit_net+0x2c/0x100 net/sched/act_gate.c:674
> 5 locks held by kworker/u4:18/5118:
> 2 locks held by kworker/0:14/6022:
>  #0: ffff888011c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
>  #1: ffffc90002e0fd00 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
> 6 locks held by kworker/1:13/6950:
>  #0: ffff8881450c4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
>  #1: ffffc90006fcfd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
>  #2: ffff888021270190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
>  #2: ffff888021270190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1bf/0xd70 drivers/usb/core/hub.c:5691
>  #3: ffff88801d7cb190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
>  #3: ffff88801d7cb190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8a/0x5a0 drivers/base/dd.c:964
>  #4: ffff88801d7cd118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
>  #4: ffff88801d7cd118 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8a/0x5a0 drivers/base/dd.c:964
>  #5: ffffffff8d24ccc8 (reading_mutex){+.+.}-{3:3}, at: add_early_randomness drivers/char/hw_random/core.c:69 [inline]
>  #5: ffffffff8d24ccc8 (reading_mutex){+.+.}-{3:3}, at: hwrng_register+0x3bf/0x680 drivers/char/hw_random/core.c:599
> 3 locks held by kworker/0:22/10696:
>  #0: ffff888011c64d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
>  #1: ffffc90005ab7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
>  #2: ffffffff8dbbe768 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xa/0x50 net/core/link_watch.c:263
> 3 locks held by kworker/0:23/10697:
>  #0: ffff888011c64d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
>  #1: ffffc90005acfd00 (fqdir_free_work){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
>  #2: ffffffff8cb23ea8 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x620 kernel/rcu/tree.c:4105
> 3 locks held by udevd/10954:
>  #0: ffff88807a763c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:197 [inline]
>  #0: ffff88807a763c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x19b/0x570 fs/kernfs/file.c:236
>  #1: ffff8880262fea00 (kn->active#86){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:198 [inline]
>  #1: ffff8880262fea00 (kn->active#86){++++}-{0:0}, at: kernfs_fop_read_iter+0x1b3/0x570 fs/kernfs/file.c:236
>  #2: ffff88801d7cb190 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:840 [inline]
>  #2: ffff88801d7cb190 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x30/0x390 drivers/usb/core/sysfs.c:873
> 2 locks held by syz-executor.2/14161:
>  #0: ffffffff8dbbe768 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:74 [inline]
>  #0: ffffffff8dbbe768 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x772/0xea0 net/core/rtnetlink.c:6086
>  #1: ffffffff8cb23fe0 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:322 [inline]
>  #1: ffffffff8cb23fe0 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x329/0x720 kernel/rcu/tree_exp.h:927
> 2 locks held by syz-executor.3/14154:
>  #0: ffff888023ad6ca8 (&nft_net->commit_mutex){+.+.}-{3:3}, at: nf_tables_valid_genid+0x27/0xa0 net/netfilter/nf_tables_api.c:9182
>  #1: ffffffff8cb23ea8 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x620 kernel/rcu/tree.c:4105
> 1 lock held by syz-executor.5/14163:
>  #0: ffffffff8dbbe768 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:74 [inline]
>  #0: ffffffff8dbbe768 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x772/0xea0 net/core/rtnetlink.c:6086
> 1 lock held by syz-executor.0/14165:
>  #0: ffffffff8dbbe768 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:74 [inline]
>  #0: ffffffff8dbbe768 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x772/0xea0 net/core/rtnetlink.c:6086
>
> =============================================
>
> NMI backtrace for cpu 1
> CPU: 1 PID: 28 Comm: khungtaskd Not tainted 5.18.0-syzkaller-13760-g032dcf09e2bf #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
>  nmi_cpu_backtrace+0x473/0x4a0 lib/nmi_backtrace.c:111
>  nmi_trigger_cpumask_backtrace+0x168/0x280 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
>  watchdog+0xd18/0xd60 kernel/hung_task.c:378
>  kthread+0x266/0x300 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 14154 Comm: syz-executor.3 Not tainted 5.18.0-syzkaller-13760-g032dcf09e2bf #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
> RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
> RIP: 0010:kasan_check_range+0x84/0x2e0 mm/kasan/generic.c:189
> Code: da 4d 89 d6 4d 29 ce 49 83 fe 10 7f 30 4d 85 f6 0f 84 8e 01 00 00 4c 89 cb 4c 29 d3 66 2e 0f 1f 84 00 00 00 00 00 41 80 39 00 <0f> 85 e7 01 00 00 49 ff c1 48 ff c3 75 ee e9 67 01 00 00 44 89 cd
> RSP: 0018:ffffc900044470e0 EFLAGS: 00000046
> RAX: 1ffff1100415f801 RBX: ffffffffffffffff RCX: ffffffff8167ca2a
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8fd46fc0
> RBP: 000000000001ffff R08: dffffc0000000000 R09: fffffbfff1fa8df8
> R10: fffffbfff1fa8df9 R11: 1ffffffff1fa8df8 R12: 0000000000000000
> R13: ffff888020afc5d0 R14: 0000000000000001 R15: ffff888020afbb00
> FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555555a83888 CR3: 000000000c88e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
>  hlock_class kernel/locking/lockdep.c:227 [inline]
>  check_wait_context kernel/locking/lockdep.c:4727 [inline]
>  __lock_acquire+0x49a/0x1f80 kernel/locking/lockdep.c:5003
>  lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5665
>  rcu_lock_acquire+0x20/0x30 include/linux/rcupdate.h:269
>  rcu_read_lock include/linux/rcupdate.h:695 [inline]
>  folio_memcg_lock+0x8c/0x5f0 mm/memcontrol.c:2042
>  page_remove_rmap+0x2f/0x4c0 mm/rmap.c:1429
>  zap_pte_range+0x9d0/0x1e10 mm/memory.c:1446
>  zap_pmd_range+0x587/0x690 mm/memory.c:1567
>  zap_pud_range mm/memory.c:1596 [inline]
>  zap_p4d_range mm/memory.c:1617 [inline]
>  unmap_page_range+0x310/0x600 mm/memory.c:1638
>  unmap_vmas+0x227/0x3b0 mm/memory.c:1723
>  exit_mmap+0x1c5/0x530 mm/mmap.c:3162
>  __mmput+0x111/0x3a0 kernel/fork.c:1187
>  exit_mm+0x211/0x2f0 kernel/exit.c:510
>  do_exit+0x4ca/0x1ed0 kernel/exit.c:782
>  do_group_exit+0x23b/0x2f0 kernel/exit.c:925
>  get_signal+0x172f/0x1780 kernel/signal.c:2857
>  arch_do_signal_or_restart+0x8d/0x750 arch/x86/kernel/signal.c:869
>  exit_to_user_mode_loop+0x74/0x160 kernel/entry/common.c:166
>  exit_to_user_mode_prepare+0xad/0x110 kernel/entry/common.c:201
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
>  syscall_exit_to_user_mode+0x2e/0x60 kernel/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f82e5c89109
> Code: Unable to access opcode bytes at RIP 0x7f82e5c890df.
> RSP: 002b:00007f82e6dec168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: 00000000000000b0 RBX: 00007f82e5d9bf60 RCX: 00007f82e5c89109
> RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
> RBP: 00007f82e5ce308d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffde4662fcf R14: 00007f82e6dec300 R15: 0000000000022000
>  </TASK>
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>    0:   4d 89 d6                mov    %r10,%r14
>    3:   4d 29 ce                sub    %r9,%r14
>    6:   49 83 fe 10             cmp    $0x10,%r14
>    a:   7f 30                   jg     0x3c
>    c:   4d 85 f6                test   %r14,%r14
>    f:   0f 84 8e 01 00 00       je     0x1a3
>   15:   4c 89 cb                mov    %r9,%rbx
>   18:   4c 29 d3                sub    %r10,%rbx
>   1b:   66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
>   22:   00 00 00
>   25:   41 80 39 00             cmpb   $0x0,(%r9)
> * 29:   0f 85 e7 01 00 00       jne    0x216 <-- trapping instruction
>   2f:   49 ff c1                inc    %r9
>   32:   48 ff c3                inc    %rbx
>   35:   75 ee                   jne    0x25
>   37:   e9 67 01 00 00          jmpq   0x1a3
>   3c:   44 89 cd                mov    %r9d,%ebp
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000037e86c05e09bee11%40google.com.
