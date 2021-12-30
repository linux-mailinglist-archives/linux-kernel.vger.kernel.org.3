Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F5148202F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 21:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhL3UIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 15:08:18 -0500
Received: from netrider.rowland.org ([192.131.102.5]:45259 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236161AbhL3UIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 15:08:17 -0500
Received: (qmail 1117556 invoked by uid 1000); 30 Dec 2021 15:08:16 -0500
Date:   Thu, 30 Dec 2021 15:08:16 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, andreyknvl@google.com,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, jun.li@nxp.com, keescook@chromium.org,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.szyprowski@samsung.com,
        noring@nocrew.org, pastor.winkley@holytabernacleint.org,
        peter.chen@nxp.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in
 usb_hcd_poll_rh_status (2)
Message-ID: <Yc4RsFnaFfbCUeRy@rowland.harvard.edu>
References: <000000000000bbbbcf05aec86741@google.com>
 <00000000000026712705d45ef8a7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000026712705d45ef8a7@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 07:47:18AM -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    eec4df26e24e Merge tag 's390-5.16-6' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1696bbfbb00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ebd4b29568807bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6a2b06f131ab9849f
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b14c1bb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ab99edb00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in usb_hcd_poll_rh_status+0x243/0x530 drivers/usb/core/hcd.c:774
> Write of size 2 at addr ffff88801dd0d780 by task syz-executor046/3607
> 
> CPU: 1 PID: 3607 Comm: syz-executor046 Not tainted 5.16.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
>  print_address_description+0x65/0x380 mm/kasan/report.c:247
>  __kasan_report mm/kasan/report.c:433 [inline]
>  kasan_report+0x19a/0x1f0 mm/kasan/report.c:450
>  kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:189
>  memcpy+0x3c/0x60 mm/kasan/shadow.c:66
>  usb_hcd_poll_rh_status+0x243/0x530 drivers/usb/core/hcd.c:774
>  call_timer_fn+0xf6/0x210 kernel/time/timer.c:1421
>  expire_timers kernel/time/timer.c:1466 [inline]
>  __run_timers+0x71a/0x910 kernel/time/timer.c:1734
>  run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1747
>  __do_softirq+0x392/0x7a3 kernel/softirq.c:558
>  __irq_exit_rcu+0xec/0x170 kernel/softirq.c:637
>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
>  sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1097
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x12/0x20
> RIP: 0010:console_unlock+0xc88/0xe90 kernel/printk/printk.c:2716
> Code: 00 e9 71 fa ff ff e8 a7 70 1a 00 e8 62 4b a0 08 48 83 7c 24 38 00 74 dd 66 2e 0f 1f 84 00 00 00 00 00 e8 8b 70 1a 00 fb 31 ff <44> 89 f6 e8 90 74 1a 00 31 db 45 85 f6 0f 95 c0 89 c1 0a 4c 24 0f
> RSP: 0018:ffffc90001a8f0e0 EFLAGS: 00000246
> RAX: ffffffff816a0d85 RBX: 0000000000000000 RCX: ffff888018638000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90001a8f2f0 R08: ffffffff816a0d3c R09: fffffbfff1bfd566
> R10: fffffbfff1bfd566 R11: 0000000000000000 R12: ffffffff8d3ec5e8
> R13: ffffffff8d3ec5b0 R14: 0000000000000001 R15: ffffc90001a8f160
>  vprintk_emit+0xba/0x140 kernel/printk/printk.c:2245
>  dev_vprintk_emit+0x2e4/0x35d drivers/base/core.c:4594
>  dev_printk_emit+0xd9/0x118 drivers/base/core.c:4605
>  _dev_warn+0x11e/0x165 drivers/base/core.c:4661
>  checkintf drivers/usb/core/devio.c:826 [inline]
>  do_proc_bulk+0x81c/0x15d0 drivers/usb/core/devio.c:1268
>  proc_bulk drivers/usb/core/devio.c:1351 [inline]
>  usbdev_do_ioctl drivers/usb/core/devio.c:2625 [inline]
>  usbdev_ioctl+0x36b7/0x6d00 drivers/usb/core/devio.c:2791
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fc8c54137a9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe10cef0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fc8c54570b0 RCX: 00007fc8c54137a9
> RDX: 0000000020000240 RSI: 00000000c0185502 RDI: 0000000000000006
> RBP: 00007ffe10cef0f0 R08: 00007ffe10ceeb40 R09: 0000000000000000
> R10: 000000000000ffff R11: 0000000000000246 R12: 00007fc8c53d2780
> R13: 0000000000000000 R14: 00007ffe10cef0f0 R15: 00007ffe10cef0e0
>  </TASK>
> 
> Allocated by task 3616:
>  kasan_save_stack mm/kasan/common.c:38 [inline]
>  kasan_set_track mm/kasan/common.c:46 [inline]
>  set_alloc_info mm/kasan/common.c:434 [inline]
>  ____kasan_kmalloc+0xdc/0x110 mm/kasan/common.c:513
>  kasan_kmalloc include/linux/kasan.h:269 [inline]
>  __kmalloc+0x253/0x380 mm/slub.c:4423
>  kmalloc include/linux/slab.h:595 [inline]
>  do_proc_bulk+0x858/0x15d0 drivers/usb/core/devio.c:1292
>  proc_bulk drivers/usb/core/devio.c:1351 [inline]
>  usbdev_do_ioctl drivers/usb/core/devio.c:2625 [inline]
>  usbdev_ioctl+0x36b7/0x6d00 drivers/usb/core/devio.c:2791
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae

Diagnostic patch.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ eec4df26e24e

Index: usb-devel/drivers/usb/core/devio.c
===================================================================
--- usb-devel.orig/drivers/usb/core/devio.c
+++ usb-devel/drivers/usb/core/devio.c
@@ -109,7 +109,7 @@ struct async {
 	u8 bulk_status;
 };
 
-static bool usbfs_snoop;
+static bool usbfs_snoop = true;
 module_param(usbfs_snoop, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(usbfs_snoop, "true to log all usbfs traffic");
 
