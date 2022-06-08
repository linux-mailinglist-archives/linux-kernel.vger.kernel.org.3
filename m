Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37D0542343
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiFHERK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiFHEPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:15:23 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AAF2DCB3B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:37:14 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id a3-20020a924443000000b002d1bc79da14so14842622ilm.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 18:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3quTe/YTAzxvtOHPr2g/PAusNIQN6U0Vr23qqvBiMCI=;
        b=liKd3BY6GATGcrTBvevWm36VBP/fjm6CYA6uu5ch5GssjJKTWEJbxcZzuT60y0j3NI
         nXi7ILo2vZHpnXJ/4l/Jr8Wiux9U+0qPA/17hUowPdkQx/KMeOh4PWMidVzX/p0kk5Cr
         uPN0Id5ynjlHunNvEY4VYdMBnUnFGdU/K7STnYF4p2bR9gvLn1RFFVhATGgmX0P/9C+P
         CFqbz44wDRXc+0XKuJyaMPpdWVNEg1xglXdvX8dem0jCyAm/LptjQq6gEhQg6s3ztkBp
         oqHMmDapALMEojgy9FKST81SrrwgrBMwG1cwy8xj8JboxvAhxWMar8XM8oIvF2wSePcZ
         PLRg==
X-Gm-Message-State: AOAM530z4zl41yLAFE6mLIysqVcdbhYpg2c76gYhF0MXebO3TLbW25qn
        Cyzg5fxEw26kBnoSj/kYIYA6saMUdZPmzqmI8aGFXeLSF+eL
X-Google-Smtp-Source: ABdhPJylwN71VFNI+/254pFUWH9lXJFGnlqwYbm0AjbRFXc1hlu2dUXD4cm0Anb0f6HA36sgyJ+3zrgrn+BX8FdtRyGy9jRkcFnw
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:2d3:a4e6:3fc6 with SMTP id
 g8-20020a056e02198800b002d3a4e63fc6mr17698073ilf.262.1654652233881; Tue, 07
 Jun 2022 18:37:13 -0700 (PDT)
Date:   Tue, 07 Jun 2022 18:37:13 -0700
In-Reply-To: <CACGkMEseR-vDzgei21jftC8Grm0Not+e1XEefyLgV8C4yfWOHQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a09fc105e0e5bedb@google.com>
Subject: Re: [syzbot] INFO: task hung in add_early_randomness (2)
From:   syzbot <syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com>
To:     herbert@gondor.apana.org.au, jasowang@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, mpm@selenic.com, mst@redhat.com,
        syzkaller-bugs@googlegroups.com, xuanzhuo@linux.alibaba.com,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in add_early_randomness

INFO: task kworker/0:0:6 blocked for more than 143 seconds.
      Not tainted 5.18.0-syzkaller-11503-gbd8bb9aed56b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:24728 pid:    6 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6431
 schedule+0xd2/0x1f0 kernel/sched/core.c:6503
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6562
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
 add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69
 hwrng_register+0x399/0x510 drivers/char/hw_random/core.c:599
 chaoskey_probe+0x7b5/0xc40 drivers/usb/misc/chaoskey.c:205
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:542 [inline]
 really_probe+0x23e/0xb20 drivers/base/dd.c:621
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3402
 usb_set_configuration+0x101e/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:542 [inline]
 really_probe+0x23e/0xb20 drivers/base/dd.c:621
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3402
 usb_new_device.cold+0x641/0x1091 drivers/usb/core/hub.c:2566
 hub_port_connect drivers/usb/core/hub.c:5363 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
 port_event drivers/usb/core/hub.c:5665 [inline]
 hub_event+0x25c6/0x4680 drivers/usb/core/hub.c:5747
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/0:0/6:
 #0: ffff88801756a938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801756a938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801756a938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88801756a938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88801756a938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88801756a938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900002cfda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888147718190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:762 [inline]
 #2: ffff888147718190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4680 drivers/usb/core/hub.c:5693
 #3: ffff88806a2f0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:762 [inline]
 #3: ffff88806a2f0190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:945
 #4: ffff88806a270118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:762 [inline]
 #4: ffff88806a270118 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:945
 #5: ffffffff8c828728 (reading_mutex){+.+.}-{3:3}, at: add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69
1 lock held by khungtaskd/29:
 #0: ffffffff8bd840e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
2 locks held by kworker/u4:5/58:
 #0: ffff8880b9a39f98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544
 #1: ffff8880b9a277c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x176/0x4e0 kernel/sched/psi.c:880
1 lock held by hwrng/756:
 #0: ffffffff8c828728 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0x141/0x370 drivers/char/hw_random/core.c:503
2 locks held by getty/3281:
 #0: ffff888022b5a098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90001c382e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcea/0x1230 drivers/tty/n_tty.c:2075

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 5.18.0-syzkaller-11503-gbd8bb9aed56b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xc22/0xf90 kernel/hung_task.c:378
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 1389 Comm: kworker/u4:7 Not tainted 5.18.0-syzkaller-11503-gbd8bb9aed56b-dirty #0
CPU: 1 PID: 1389 Comm: kworker/u4:7 Not tainted 5.18.0-syzkaller-11503-gbd8bb9aed56b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: phy5 ieee80211_iface_work
RIP: 0010:unwind_next_frame+0x8c5/0x1cc0 arch/x86/kernel/unwind_orc.c:466
Code: ff 80 3d a8 c0 70 0c 00 0f 85 ee fa ff ff e9 22 54 fb 07 48 b8 00 00 00 00 00 fc ff df 48 8b 54 24 08 48 c1 ea 03 80 3c 02 00 <0f> 85 73 10 00 00 4c 89 c0 4d 8b 75 38 48 ba 00 00 00 00 00 fc ff
RSP: 0018:ffffc900059e7528 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8e3c9c1f
RDX: 1ffff92000b3ceba RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffc900059e75e0 R08: ffffffff8e3c9c1a R09: ffffc900059e75cc
R10: fffff52000b3cebe R11: 000000000008a07a R12: ffffc900059e75cd
R13: ffffc900059e7598 R14: ffffffff81689fbb R15: ffffffff8e3c9c1e
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f00c3e11110 CR3: 000000000ba8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa6/0xd0 mm/kasan/common.c:524
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 kmem_cache_alloc_trace+0x1ea/0x4a0 mm/slab.c:3569
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 ieee802_11_parse_elems_crc+0xd5/0x1060 net/mac80211/util.c:1502
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2257 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1605 [inline]
 ieee80211_ibss_rx_queued_mgmt+0xda5/0x33f0 net/mac80211/ibss.c:1639
 ieee80211_iface_process_skb net/mac80211/iface.c:1527 [inline]
 ieee80211_iface_work+0xa78/0xd10 net/mac80211/iface.c:1581
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
----------------
Code disassembly (best guess):
   0:	ff 80 3d a8 c0 70    	incl   0x70c0a83d(%rax)
   6:	0c 00                	or     $0x0,%al
   8:	0f 85 ee fa ff ff    	jne    0xfffffafc
   e:	e9 22 54 fb 07       	jmpq   0x7fb5435
  13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1a:	fc ff df
  1d:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  22:	48 c1 ea 03          	shr    $0x3,%rdx
  26:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
* 2a:	0f 85 73 10 00 00    	jne    0x10a3 <-- trapping instruction
  30:	4c 89 c0             	mov    %r8,%rax
  33:	4d 8b 75 38          	mov    0x38(%r13),%r14
  37:	48                   	rex.W
  38:	ba 00 00 00 00       	mov    $0x0,%edx
  3d:	00 fc                	add    %bh,%ah
  3f:	ff                   	.byte 0xff


Tested on:

commit:         bd8bb9ae vdpa: ifcvf: set pci driver data in probe
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=162120bff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d4cbb773055caee
dashboard link: https://syzkaller.appspot.com/bug?extid=5b59d6d459306a556f54
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141d9e6ff00000

