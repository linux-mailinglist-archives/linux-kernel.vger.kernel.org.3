Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BED549839A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbiAXPd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:33:26 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:48868 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiAXPdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:33:20 -0500
Received: by mail-io1-f70.google.com with SMTP id o189-20020a6bbec6000000b00604e5f63337so12366964iof.15
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vNUGB9fHuyeQ3QNzajLu2T/fAlRFA+ORh6/YMMlt1Cs=;
        b=1o1Y8bZVzjZDvapQwBfiQDk0R6lkpA7EhpTOO3n2X54tAjMHcNjOaZkzLykQPLTIYd
         VJOOntlxD10ys+UFM9Io/GzkRIg/vP4I2qYi/RJu3LBBcgcaEPMSzonZqnxpjdUJ3tLa
         frt6p7NwfqI2DO5jprUFVikp0dAs9Y3DqbRoPyOFq6nfMyZWipdSbj09rJX2LOUXNpBZ
         R3jq6spKQwqnaWLLYXdCDpUHZYXVRN7DfKioa0t90LWnDREVAxUNHF0CM/8Rbo1ROUsm
         KthdceRoPxnNZJI0lQAkUyv/2zWtuw/cbH9oXZXqxJs8tQ6WjslyKX99qp9InQDRtZ06
         7Ltw==
X-Gm-Message-State: AOAM532e9Hyofj5iRPI3sehfVcM7Z8OMsGmz0NUYK9HJiuCtx9XQ3hAn
        cj8zeCTU4PJTSWFxFwLgSG/Wr4yI3j8Yd1mJLDVhLsH8dLOc
X-Google-Smtp-Source: ABdhPJz15PojYI5IyDzrqqAYbi2VDv0pH8JlJDCOVy67QbsuDt1Z8lGCK5KELio4jdgtKg3f2LGfQdaN3jC0np76hSdRqjFiLgIW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cd:: with SMTP id 13mr8904557ilq.108.1643038400083;
 Mon, 24 Jan 2022 07:33:20 -0800 (PST)
Date:   Mon, 24 Jan 2022 07:33:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000307c7d05d655b0da@google.com>
Subject: [syzbot] BUG: corrupted list in usb_hcd_link_urb_to_ep (2)
From:   syzbot <syzbot+48a2d3f5d7c977bc22d7@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jun.li@nxp.com, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        peter.chen@nxp.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126d2170700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36924ae974256627
dashboard link: https://syzkaller.appspot.com/bug?extid=48a2d3f5d7c977bc22d7
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1312815bb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13804918700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48a2d3f5d7c977bc22d7@syzkaller.appspotmail.com

input: CM109 USB driver as /devices/platform/dummy_hcd.4/usb5/5-1/5-1:0.0/input/input1176
list_add double add: new=ffff888013fffd18, prev=ffff888013fffd18, next=ffff8880244c9070.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:31!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 140 Comm: kworker/0:2 Not tainted 5.17.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:__list_add_valid+0x8a/0xc0 lib/list_debug.c:29
Code: 74 11 4d 39 f7 74 0c b0 01 5b 41 5c 41 5d 41 5e 41 5f c3 48 c7 c7 80 5a d6 8a 4c 89 fe 4c 89 e2 4c 89 f1 31 c0 e8 3e 3c 53 fd <0f> 0b 48 c7 c7 40 59 d6 8a 4c 89 e6 4c 89 f1 31 c0 e8 28 3c 53 fd
RSP: 0018:ffffc9000282e680 EFLAGS: 00010046
RAX: 0000000000000058 RBX: ffff8880244c9078 RCX: 1c7d44314f50cc00
RDX: 0000000000000000 RSI: 0000000080000002 RDI: 0000000000000000
RBP: ffff8880244c9078 R08: ffffffff816affd2 R09: ffffed1017344f24
R10: ffffed1017344f24 R11: 0000000000000000 R12: ffff888013fffd18
R13: dffffc0000000000 R14: ffff8880244c9070 R15: ffff888013fffd18
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff0109a9f8 CR3: 000000001fd14000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 usb_hcd_link_urb_to_ep+0x1ae/0x300 drivers/usb/core/hcd.c:1181
 dummy_urb_enqueue+0x2a9/0x750 drivers/usb/gadget/udc/dummy_hcd.c:1284
 usb_hcd_submit_urb+0x2be/0x5f0 drivers/usb/core/hcd.c:1555
 cm109_input_open+0x1eb/0x460 drivers/input/misc/cm109.c:572
 input_open_device+0x184/0x2d0 drivers/input/input.c:629
 kbd_connect+0xe5/0x120 drivers/tty/vt/keyboard.c:1593
 input_attach_handler drivers/input/input.c:1035 [inline]
 input_register_device+0xd95/0x1140 drivers/input/input.c:2335
 cm109_usb_probe+0x11bf/0x16c0 drivers/input/misc/cm109.c:806
 usb_probe_interface+0x633/0xb40 drivers/usb/core/driver.c:396
 call_driver_probe+0x96/0x250
 really_probe+0x222/0x9f0 drivers/base/dd.c:596
 __driver_probe_device+0x1f8/0x3e0 drivers/base/dd.c:752
 driver_probe_device+0x50/0x240 drivers/base/dd.c:782
 __device_attach_driver+0x1e1/0x3b0 drivers/base/dd.c:899
 bus_for_each_drv+0x18a/0x210 drivers/base/bus.c:427
 __device_attach+0x310/0x560 drivers/base/dd.c:970
 bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:487
 device_add+0x11c8/0x16d0 drivers/base/core.c:3405
 usb_set_configuration+0x1a86/0x2100 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0x83/0x140 drivers/usb/core/generic.c:238
 usb_probe_device+0x13a/0x260 drivers/usb/core/driver.c:293
 call_driver_probe+0x96/0x250
 really_probe+0x222/0x9f0 drivers/base/dd.c:596
 __driver_probe_device+0x1f8/0x3e0 drivers/base/dd.c:752
 driver_probe_device+0x50/0x240 drivers/base/dd.c:782
 __device_attach_driver+0x1e1/0x3b0 drivers/base/dd.c:899
 bus_for_each_drv+0x18a/0x210 drivers/base/bus.c:427
 __device_attach+0x310/0x560 drivers/base/dd.c:970
 bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:487
 device_add+0x11c8/0x16d0 drivers/base/core.c:3405
 usb_new_device+0x108a/0x1940 drivers/usb/core/hub.c:2566
 hub_port_connect+0x100b/0x2910 drivers/usb/core/hub.c:5358
 hub_port_connect_change+0x5f9/0xc20 drivers/usb/core/hub.c:5502
 port_event+0xca0/0x13e0 drivers/usb/core/hub.c:5660
 hub_event+0x4ed/0xe40 drivers/usb/core/hub.c:5742
 process_one_work+0x850/0x1130 kernel/workqueue.c:2307
 worker_thread+0xab1/0x1300 kernel/workqueue.c:2454
 kthread+0x2a3/0x2d0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid+0x8a/0xc0 lib/list_debug.c:29
Code: 74 11 4d 39 f7 74 0c b0 01 5b 41 5c 41 5d 41 5e 41 5f c3 48 c7 c7 80 5a d6 8a 4c 89 fe 4c 89 e2 4c 89 f1 31 c0 e8 3e 3c 53 fd <0f> 0b 48 c7 c7 40 59 d6 8a 4c 89 e6 4c 89 f1 31 c0 e8 28 3c 53 fd
RSP: 0018:ffffc9000282e680 EFLAGS: 00010046
RAX: 0000000000000058 RBX: ffff8880244c9078 RCX: 1c7d44314f50cc00
RDX: 0000000000000000 RSI: 0000000080000002 RDI: 0000000000000000
RBP: ffff8880244c9078 R08: ffffffff816affd2 R09: ffffed1017344f24
R10: ffffed1017344f24 R11: 0000000000000000 R12: ffff888013fffd18
R13: dffffc0000000000 R14: ffff8880244c9070 R15: ffff888013fffd18
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff0109a9f8 CR3: 000000001fd14000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
