Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F4F49841D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbiAXQCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:02:12 -0500
Received: from netrider.rowland.org ([192.131.102.5]:52071 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S240830AbiAXQCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:02:11 -0500
Received: (qmail 78238 invoked by uid 1000); 24 Jan 2022 11:02:07 -0500
Date:   Mon, 24 Jan 2022 11:02:07 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        syzbot <syzbot+48a2d3f5d7c977bc22d7@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, jun.li@nxp.com, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        peter.chen@nxp.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: corrupted list in usb_hcd_link_urb_to_ep (2)
Message-ID: <Ye7Nf1FSi34rs3GJ@rowland.harvard.edu>
References: <000000000000307c7d05d655b0da@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000307c7d05d655b0da@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 07:33:20AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=126d2170700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=36924ae974256627
> dashboard link: https://syzkaller.appspot.com/bug?extid=48a2d3f5d7c977bc22d7
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1312815bb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13804918700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+48a2d3f5d7c977bc22d7@syzkaller.appspotmail.com
> 
> input: CM109 USB driver as /devices/platform/dummy_hcd.4/usb5/5-1/5-1:0.0/input/input1176
> list_add double add: new=ffff888013fffd18, prev=ffff888013fffd18, next=ffff8880244c9070.
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:31!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 140 Comm: kworker/0:2 Not tainted 5.17.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:__list_add_valid+0x8a/0xc0 lib/list_debug.c:29
> Code: 74 11 4d 39 f7 74 0c b0 01 5b 41 5c 41 5d 41 5e 41 5f c3 48 c7 c7 80 5a d6 8a 4c 89 fe 4c 89 e2 4c 89 f1 31 c0 e8 3e 3c 53 fd <0f> 0b 48 c7 c7 40 59 d6 8a 4c 89 e6 4c 89 f1 31 c0 e8 28 3c 53 fd
> RSP: 0018:ffffc9000282e680 EFLAGS: 00010046
> RAX: 0000000000000058 RBX: ffff8880244c9078 RCX: 1c7d44314f50cc00
> RDX: 0000000000000000 RSI: 0000000080000002 RDI: 0000000000000000
> RBP: ffff8880244c9078 R08: ffffffff816affd2 R09: ffffed1017344f24
> R10: ffffed1017344f24 R11: 0000000000000000 R12: ffff888013fffd18
> R13: dffffc0000000000 R14: ffff8880244c9070 R15: ffff888013fffd18
> FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff0109a9f8 CR3: 000000001fd14000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __list_add include/linux/list.h:69 [inline]
>  list_add_tail include/linux/list.h:102 [inline]
>  usb_hcd_link_urb_to_ep+0x1ae/0x300 drivers/usb/core/hcd.c:1181
>  dummy_urb_enqueue+0x2a9/0x750 drivers/usb/gadget/udc/dummy_hcd.c:1284
>  usb_hcd_submit_urb+0x2be/0x5f0 drivers/usb/core/hcd.c:1555
>  cm109_input_open+0x1eb/0x460 drivers/input/misc/cm109.c:572
>  input_open_device+0x184/0x2d0 drivers/input/input.c:629
>  kbd_connect+0xe5/0x120 drivers/tty/vt/keyboard.c:1593
>  input_attach_handler drivers/input/input.c:1035 [inline]
>  input_register_device+0xd95/0x1140 drivers/input/input.c:2335
>  cm109_usb_probe+0x11bf/0x16c0 drivers/input/misc/cm109.c:806
>  usb_probe_interface+0x633/0xb40 drivers/usb/core/driver.c:396

Dmitry:

It looks like the cm109 driver has a logic bug.   
cm109_urb_irq_callback() doesn't check dev->ctl_urb_pending before 
setting it and trying to submit the control URB.

I don't know anything about how this driver is meant to work, and this 
apparent bug may be unrelated to what syzbot found.  Could you please 
take a look at it?

Alan Stern
