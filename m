Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02D54C5945
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 05:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiB0Ea5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 23:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiB0Eay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 23:30:54 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E7BB1A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 20:30:18 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id 3-20020a056e020ca300b002c2cf74037cso1394646ilg.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 20:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lk3dhbwsiHYwHiorQEsdLRoXBJt7OFCEFXr5KpqWvyc=;
        b=ZRLhUyuhQMcCH5LNHjcZDz0t9+OWQ2hUiSqfIokOLkCPHw+l8vqb8vhhyXkeHNuO8P
         EOEXVYztWF7gwa4ZzEpuZnwxa1X+Y8y3eNRx1VlXTuxZqKl0fyR2+iZjSFu1jX3fh2RP
         LeFNBy1Eil/ZSuubiKJvGxQmK0sKxSJKH/YAVpHLUcmOZ9Kr4LsiIRbfp0msOzs+JaaL
         569SuRUj/oC+fswUAimhRvxljJYjovO2AOZz7bo6dpee/XUoqAgB2wvq+1kVLqT56GCU
         1feFH33vzFRklpUQW+6t2WBxEBDPdaZJE3r6yYyyBZnHBWnh0sjRBpWCHmQCHAETsMrR
         +Jmw==
X-Gm-Message-State: AOAM5324NLeRdCjY5DKMdinM6/IbCkqVNJ4mo6Z2/X6CZsy0QhpTIIcZ
        sUouEJj9hrulCbgJakcGikfYs5IKoF6MOdBAMh+1eBBClQsx
X-Google-Smtp-Source: ABdhPJygECl0FCp1bhqjy8Dces9USwSeH8UY91zWWut+X5D8P/x6n0O4cSX9mtL8Iwhmkq6yZl2Up/ldYbLH8j2Hs9hOV+8mKd4k
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3391:b0:314:bf3e:2bff with SMTP id
 h17-20020a056638339100b00314bf3e2bffmr12614675jav.71.1645936217615; Sat, 26
 Feb 2022 20:30:17 -0800 (PST)
Date:   Sat, 26 Feb 2022 20:30:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092f01b05d8f863a5@google.com>
Subject: [syzbot] possible deadlock in __queue_work (2)
From:   syzbot <syzbot+4a404694c39d03bb78da@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        macro@orcam.me.uk, syzkaller-bugs@googlegroups.com,
        wander@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_FMBLA_NEWDOM,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    196d330d7fb1 Add linux-next specific files for 20220222
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=129defc6700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45b71d0aea81d553
dashboard link: https://syzkaller.appspot.com/bug?extid=4a404694c39d03bb78da
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a404694c39d03bb78da@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.17.0-rc5-next-20220222-syzkaller #0 Not tainted
------------------------------------------------------
kworker/u4:2/45 is trying to acquire lock:
ffff8880b9c395d8 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x366/0x1140 kernel/workqueue.c:1474

but task is already holding lock:
ffffffff9061a530 (&port_lock_key){-.-.}-{2:2}, at: serial8250_handle_irq.part.0+0x21/0x3d0 drivers/tty/serial/8250/8250_port.c:1916

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&port_lock_key){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       serial8250_console_write+0x91a/0xb70 drivers/tty/serial/8250/8250_port.c:3359
       call_console_drivers kernel/printk/printk.c:1953 [inline]
       console_unlock+0x9bc/0xdd0 kernel/printk/printk.c:2775
       vprintk_emit+0x1b4/0x5f0 kernel/printk/printk.c:2273
       vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
       _printk+0xba/0xed kernel/printk/printk.c:2294
       register_console kernel/printk/printk.c:3132 [inline]
       register_console+0x410/0x7c0 kernel/printk/printk.c:3013
       univ8250_console_init+0x3a/0x46 drivers/tty/serial/8250/8250_core.c:679
       console_init+0x3c1/0x58d kernel/printk/printk.c:3232
       start_kernel+0x30b/0x4a0 init/main.c:1068
       secondary_startup_64_no_verify+0xc3/0xcb

-> #1 (console_owner){....}-{0:0}:
       console_lock_spinning_enable kernel/printk/printk.c:1795 [inline]
       console_unlock+0x3b1/0xdd0 kernel/printk/printk.c:2772
       vprintk_emit+0x1b4/0x5f0 kernel/printk/printk.c:2273
       vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
       _printk+0xba/0xed kernel/printk/printk.c:2294
       warn_flush_attempt kernel/workqueue.c:2613 [inline]
       check_flush_dependency.cold+0x18/0x4e kernel/workqueue.c:2635
       start_flush_work kernel/workqueue.c:3049 [inline]
       __flush_work+0x25a/0xb10 kernel/workqueue.c:3091
       flush_all_cpus_locked+0x148/0x1b0 mm/slub.c:2728
       flush_all mm/slub.c:2737 [inline]
       __kmem_cache_shrink+0x11/0x20 mm/slub.c:4640
       acpi_os_purge_cache+0x11/0x20 drivers/acpi/osl.c:1666
       acpi_purge_cached_objects+0x37/0xd0 drivers/acpi/acpica/utxface.c:237
       acpi_initialize_objects+0x2b/0x95 drivers/acpi/acpica/utxfinit.c:250
       acpi_bus_init drivers/acpi/bus.c:1237 [inline]
       acpi_init+0x1d2/0x976 drivers/acpi/bus.c:1325
       do_one_initcall+0x103/0x650 init/main.c:1302
       do_initcall_level init/main.c:1375 [inline]
       do_initcalls init/main.c:1391 [inline]
       do_basic_setup init/main.c:1410 [inline]
       kernel_init_freeable+0x6b1/0x73a init/main.c:1615
       kernel_init+0x1a/0x1d0 init/main.c:1504
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 (&pool->lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3096 [inline]
       check_prevs_add kernel/locking/lockdep.c:3219 [inline]
       validate_chain kernel/locking/lockdep.c:3834 [inline]
       __lock_acquire+0x2ac6/0x56c0 kernel/locking/lockdep.c:5060
       lock_acquire kernel/locking/lockdep.c:5672 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5637
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x366/0x1140 kernel/workqueue.c:1474
       queue_work_on+0xee/0x110 kernel/workqueue.c:1545
       uart_handle_dcd_change+0x1e1/0x2b0 drivers/tty/serial/serial_core.c:3090
       serial8250_modem_status+0x277/0x2c0 drivers/tty/serial/8250/8250_port.c:1880
       serial8250_handle_irq.part.0+0xa1/0x3d0 drivers/tty/serial/8250/8250_port.c:1937
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1913 [inline]
       serial8250_default_handle_irq+0xb2/0x220 drivers/tty/serial/8250/8250_port.c:1957
       serial8250_interrupt+0xfd/0x200 drivers/tty/serial/8250/8250_core.c:126
       __handle_irq_event_percpu+0x22b/0x880 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0xa7/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:817
       generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
       handle_irq arch/x86/kernel/irq.c:231 [inline]
       __common_interrupt+0x9d/0x210 arch/x86/kernel/irq.c:250
       common_interrupt+0xa4/0xc0 arch/x86/kernel/irq.c:240
       asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:629
       lock_acquire+0x1ef/0x510 kernel/locking/lockdep.c:5640
       rcu_lock_acquire include/linux/rcupdate.h:268 [inline]
       rcu_read_lock include/linux/rcupdate.h:694 [inline]
       batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
       batadv_nc_worker+0x12d/0xfa0 net/batman-adv/network-coding.c:719
       process_one_work+0x996/0x1610 kernel/workqueue.c:2289
       worker_thread+0x665/0x1080 kernel/workqueue.c:2436
       kthread+0x2e9/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

other info that might help us debug this:

Chain exists of:
  &pool->lock --> console_owner --> &port_lock_key

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&port_lock_key);
                               lock(console_owner);
                               lock(&port_lock_key);
  lock(&pool->lock);

 *** DEADLOCK ***

6 locks held by kworker/u4:2/45:
 #0: ffff88814adb0138 ((wq_completion)bat_events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88814adb0138 ((wq_completion)bat_events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88814adb0138 ((wq_completion)bat_events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88814adb0138 ((wq_completion)bat_events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88814adb0138 ((wq_completion)bat_events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88814adb0138 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90000b67da8 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffffffff8bb866a0 (rcu_read_lock){....}-{1:2}, at: batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:406 [inline]
 #2: ffffffff8bb866a0 (rcu_read_lock){....}-{1:2}, at: batadv_nc_worker+0xf3/0xfa0 net/batman-adv/network-coding.c:719
 #3: ffff88801ca9ec30 (&i->lock){-.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
 #3: ffff88801ca9ec30 (&i->lock){-.-.}-{2:2}, at: serial8250_interrupt+0x3a/0x200 drivers/tty/serial/8250/8250_core.c:116
 #4: ffffffff9061a530 (&port_lock_key){-.-.}-{2:2}, at: serial8250_handle_irq.part.0+0x21/0x3d0 drivers/tty/serial/8250/8250_port.c:1916
 #5: ffffffff8bb866a0 (rcu_read_lock){....}-{1:2}, at: __queue_work+0xd0/0x1140 kernel/workqueue.c:1437

stack backtrace:
CPU: 0 PID: 45 Comm: kworker/u4:2 Not tainted 5.17.0-rc5-next-20220222-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2176
 check_prev_add kernel/locking/lockdep.c:3096 [inline]
 check_prevs_add kernel/locking/lockdep.c:3219 [inline]
 validate_chain kernel/locking/lockdep.c:3834 [inline]
 __lock_acquire+0x2ac6/0x56c0 kernel/locking/lockdep.c:5060
 lock_acquire kernel/locking/lockdep.c:5672 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5637
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x366/0x1140 kernel/workqueue.c:1474
 queue_work_on+0xee/0x110 kernel/workqueue.c:1545
 uart_handle_dcd_change+0x1e1/0x2b0 drivers/tty/serial/serial_core.c:3090
 serial8250_modem_status+0x277/0x2c0 drivers/tty/serial/8250/8250_port.c:1880
 serial8250_handle_irq.part.0+0xa1/0x3d0 drivers/tty/serial/8250/8250_port.c:1937
 serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1913 [inline]
 serial8250_default_handle_irq+0xb2/0x220 drivers/tty/serial/8250/8250_port.c:1957
 serial8250_interrupt+0xfd/0x200 drivers/tty/serial/8250/8250_core.c:126
 __handle_irq_event_percpu+0x22b/0x880 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xa7/0x1e0 kernel/irq/handle.c:210
 handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:817
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq arch/x86/kernel/irq.c:231 [inline]
 __common_interrupt+0x9d/0x210 arch/x86/kernel/irq.c:250
 common_interrupt+0xa4/0xc0 arch/x86/kernel/irq.c:240
 </IRQ>
 <TASK>
 asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:629
RIP: 0010:lock_acquire+0x1ef/0x510 kernel/locking/lockdep.c:5640
Code: a6 a4 7e 83 f8 01 0f 85 b4 02 00 00 9c 58 f6 c4 02 0f 85 9f 02 00 00 48 83 7c 24 08 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc90000b67b98 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff9200016cf75 RCX: dd462be53ff4bbdf
RDX: 1ffff110021fb4eb RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8fdfe987
R10: fffffbfff1fbfd30 R11: 0000000000000001 R12: 0000000000000002
R13: 0000000000000000 R14: ffffffff8bb866a0 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:268 [inline]
 rcu_read_lock include/linux/rcupdate.h:694 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0x12d/0xfa0 net/batman-adv/network-coding.c:719
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
----------------
Code disassembly (best guess):
   0:	a6                   	cmpsb  %es:(%rdi),%ds:(%rsi)
   1:	a4                   	movsb  %ds:(%rsi),%es:(%rdi)
   2:	7e 83                	jle    0xffffff87
   4:	f8                   	clc
   5:	01 0f                	add    %ecx,(%rdi)
   7:	85 b4 02 00 00 9c 58 	test   %esi,0x589c0000(%rdx,%rax,1)
   e:	f6 c4 02             	test   $0x2,%ah
  11:	0f 85 9f 02 00 00    	jne    0x2b6
  17:	48 83 7c 24 08 00    	cmpq   $0x0,0x8(%rsp)
  1d:	74 01                	je     0x20
  1f:	fb                   	sti
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	48 01 c3             	add    %rax,%rbx <-- trapping instruction
  2d:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  34:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  3b:	00
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	84                   	.byte 0x84
  3f:	24                   	.byte 0x24


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
