Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BCE564C0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 05:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiGDDdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 23:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGDDdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 23:33:10 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31092DFC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 20:33:08 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id b11-20020a92340b000000b002d3dbbc7b15so3579450ila.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 20:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cIUaVLh+l2wzterIVeA9kJJ1nNH6IHcfYZ0J2ZD0+fY=;
        b=FSuKiwdQ2Hwjzn3b66rBFsHhy7YvGXZD/LYLXZW5C4AtZvBYkp/vOjg/58AC5PWNi9
         4SQNGVHGP+jBNkYUpVfCc+KoEZY1QK2VP99QdU/iqfXmGwO5GetlT9k6E0ST/mRR1XPf
         9OVKjA2PZclzUXZ88CCOUidAB5v5k/4zrSRj8JJuQdim7hlkXBZilk1LvtAg/B5PQO7g
         Y6Uflgp/aa2/6o0m6rijTQFxduk5D1vo1jE4cJ+yvBtTI1hduFOUhZhZy4dzjaIEou3b
         Fe8dZl/Fb6UdEzHxAb4AaDs7BcXxWCWbnWjduSROcW7TKAmvgtEPPPlmlKfz7mt9hwfT
         g1Wg==
X-Gm-Message-State: AJIora9F/1p679e3MsmpTsHH5aaiLn1CVOEZ5R7M5Q9h9TkSglooG+uF
        G0m1KaiBuzbyt06IcgBavWijAjBJb5eU4KErKC0o8p6d23ZI
X-Google-Smtp-Source: AGRyM1sHhSp6SPjbVuMVkvzer5zsaIXRFlhDBOCNJCrVxOwwUiBk8M1A1HBuLyAJwHj7POh6G/6JlbREMgZvdvcPznG8G5Y3T9a1
MIME-Version: 1.0
X-Received: by 2002:a92:ca06:0:b0:2da:d16d:f41 with SMTP id
 j6-20020a92ca06000000b002dad16d0f41mr13621692ils.107.1656905587910; Sun, 03
 Jul 2022 20:33:07 -0700 (PDT)
Date:   Sun, 03 Jul 2022 20:33:07 -0700
In-Reply-To: <20220704031413.1709-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe6f6705e2f26465@google.com>
Subject: Re: [syzbot] INFO: task hung in __input_unregister_device (4)
From:   syzbot <syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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
INFO: task hung in joydev_cleanup

INFO: task kworker/0:0:6 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:24472 pid:    6 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa00/0x4b50 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
 joydev_mark_dead drivers/input/joydev.c:731 [inline]
 joydev_cleanup+0x21/0x190 drivers/input/joydev.c:740
 joydev_disconnect+0x45/0xb0 drivers/input/joydev.c:1022
 __input_unregister_device+0x1f1/0x460 drivers/input/input.c:2238
 input_unregister_device+0xb4/0xf0 drivers/input/input.c:2428
 iforce_usb_disconnect+0x5e/0xf0 drivers/input/joystick/iforce/iforce-usb.c:261
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:545 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:537
 __device_release_driver drivers/base/dd.c:1222 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1248
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3604
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x278/0x6ec drivers/usb/core/hub.c:2228
 hub_port_connect drivers/usb/core/hub.c:5207 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
 port_event drivers/usb/core/hub.c:5663 [inline]
 hub_event+0x1e83/0x4690 drivers/usb/core/hub.c:5745
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0x854/0x1080 kernel/workqueue.c:2438
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

Showing all locks held in the system:
7 locks held by kworker/0:0/6:
 #0: ffff8881459c3938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881459c3938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8881459c3938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8881459c3938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8881459c3938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8881459c3938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900000b7da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888147879190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff888147879190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4690 drivers/usb/core/hub.c:5691
 #3: ffff8880173a9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff8880173a9190 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x6ec drivers/usb/core/hub.c:2219
 #4: ffff8880173ae118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff8880173ae118 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1054 [inline]
 #4: ffff8880173ae118 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa0/0x700 drivers/base/dd.c:1245
 #5: ffffffff8ceafca8 (input_mutex){+.+.}-{3:3}, at: __input_unregister_device+0x158/0x460 drivers/input/input.c:2235
 #6: ffff88807bab4158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_mark_dead drivers/input/joydev.c:731 [inline]
 #6: ffff88807bab4158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_cleanup+0x21/0x190 drivers/input/joydev.c:740
1 lock held by khungtaskd/28:
 #0: ffffffff8bd86660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
2 locks held by acpid/2960:
 #0: ffff88807bab4158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_close_device drivers/input/joydev.c:220 [inline]
 #0: ffff88807bab4158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_release+0x187/0x290 drivers/input/joydev.c:252
 #1: ffff8880173af2c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_close_device+0x42/0x1f0 drivers/input/input.c:726
2 locks held by getty/3287:
 #0: ffff88802616e098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
2 locks held by udevd/4084:
 #0: ffff8881458fa110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_open_device drivers/input/evdev.c:393 [inline]
 #0: ffff8881458fa110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_open+0x2f3/0x6a0 drivers/input/evdev.c:487
 #1: ffff8880173af2c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_open_device+0x4a/0x320 drivers/input/input.c:656

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:369
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Workqueue: phy5 ieee80211_iface_work
RIP: 0010:next_tid mm/slub.c:2311 [inline]
RIP: 0010:___slab_alloc+0x74b/0xe20 mm/slub.c:2985
Code: 8b 34 24 48 89 43 10 8b 05 5e 20 f5 0b 85 c0 0f 85 80 03 00 00 48 8b 43 10 80 78 2b 00 0f 89 25 04 00 00 8b 45 28 49 8b 04 06 <48> 83 43 08 08 48 89 03 48 8b 5d 00 e8 c4 bf b0 07 89 c5 48 83 c3
RSP: 0018:ffffc90000b27700 EFLAGS: 00000082
RAX: ffff888020bfa000 RBX: ffff8880b9a3db80 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888011841dc0 R08: 0000000000000000 R09: 0000000080100010
R10: ffffffff81c69e72 R11: 0000000000000000 R12: 000000000003dba0
R13: 0000000000000246 R14: ffff888020bfb000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4fd6a83110 CR3: 000000000ba8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 kmem_cache_alloc_trace+0x310/0x3f0 mm/slub.c:3282
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 ieee802_11_parse_elems_crc+0xd5/0x1050 net/mac80211/util.c:1502
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2257 [inline]
 ieee80211_bss_info_update+0x42c/0xb00 net/mac80211/scan.c:212
 ieee80211_rx_bss_info net/mac80211/ibss.c:1119 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1610 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1ab8/0x33f0 net/mac80211/ibss.c:1639
 ieee80211_iface_process_skb net/mac80211/iface.c:1527 [inline]
 ieee80211_iface_work+0xa78/0xd10 net/mac80211/iface.c:1581
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
----------------
Code disassembly (best guess):
   0:	8b 34 24             	mov    (%rsp),%esi
   3:	48 89 43 10          	mov    %rax,0x10(%rbx)
   7:	8b 05 5e 20 f5 0b    	mov    0xbf5205e(%rip),%eax        # 0xbf5206b
   d:	85 c0                	test   %eax,%eax
   f:	0f 85 80 03 00 00    	jne    0x395
  15:	48 8b 43 10          	mov    0x10(%rbx),%rax
  19:	80 78 2b 00          	cmpb   $0x0,0x2b(%rax)
  1d:	0f 89 25 04 00 00    	jns    0x448
  23:	8b 45 28             	mov    0x28(%rbp),%eax
  26:	49 8b 04 06          	mov    (%r14,%rax,1),%rax
* 2a:	48 83 43 08 08       	addq   $0x8,0x8(%rbx) <-- trapping instruction
  2f:	48 89 03             	mov    %rax,(%rbx)
  32:	48 8b 5d 00          	mov    0x0(%rbp),%rbx
  36:	e8 c4 bf b0 07       	callq  0x7b0bfff
  3b:	89 c5                	mov    %eax,%ebp
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	c3                   	retq


Tested on:

commit:         a175eca0 Merge tag 'drm-fixes-2022-07-01' of git://ano..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1626aa58080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=deb6abc36aad4008f407
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b3b658080000

