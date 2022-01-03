Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7033E4833C5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiACOxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:53:20 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:51866 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiACOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:53:18 -0500
Received: by mail-il1-f199.google.com with SMTP id y2-20020a056e020f4200b002b4313fb71aso18037343ilj.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 06:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2AwCv+MdZp2xWRQME5H6ywuEm/16fd12BouvmRXI+Lc=;
        b=tGqElWZY3u/hd8WE1tTvviiBkc9yyBZAaKsm9NoMmuBDGGmIKFmVFgOotS0nxSSUFA
         g4oSeB2CMdN4s4vcIt0lXvlYK63Lpp+byx1sUP8nOsYHNchcAP/VJxzElkTMKZ4mv/SN
         c2+ukyfGklRxEKe8ZrzUSl3T9sL06BeY3OH4xE53nwc3cYmRJneZzZoRUrqTygE7og4q
         N8oqUoFQXaIJFW3aDA7VjqA6houClJ/fsOoyHU5AioWnSbPfqt1+BnodTwibtl82f5wd
         0XaxXO97UoxAQtRmCCu/QZpOUwzudFcHZBtnKCBSij0BzklQc22cFqIqrHGS6LqGzbhm
         qK9A==
X-Gm-Message-State: AOAM531X87voTDUzyg/zpO/3QENMzJHTpeQ9w9bVHlzadM5yfnO+6/Si
        ISEYuSKi/CSyKMpYwmE7t2QThrmeW07lyHlFEOO3UpAkC22c
X-Google-Smtp-Source: ABdhPJxTYGesJ9UfPxhmrm2/9HJWTU3K9lKnrNxa15l4IGdS6Bau6ea8gFeAM9uXXq0HCkjfvJEHQRnbGWRW6xw/FunzzF4ShxS5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:11c2:: with SMTP id g2mr21859251jas.36.1641221598279;
 Mon, 03 Jan 2022 06:53:18 -0800 (PST)
Date:   Mon, 03 Jan 2022 06:53:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d008905d4aeae84@google.com>
Subject: [syzbot] WARNING: ODEBUG bug in really_probe
From:   syzbot <syzbot+464c4df17b2bbb9ff4dd@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ea586a076e8a Add linux-next specific files for 20211224
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1523dec3b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9c4e3dde2c568fb
dashboard link: https://syzkaller.appspot.com/bug?extid=464c4df17b2bbb9ff4dd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+464c4df17b2bbb9ff4dd@syzkaller.appspotmail.com

magicmouse 0003:05AC:0265.0002: hidraw0: USB HID v0.00 Device [HID 05ac:0265] on usb-dummy_hcd.0-1/input0
magicmouse 0003:05AC:0265.0002: magicmouse input not registered
magicmouse: probe of 0003:05AC:0265.0002 failed with error -12
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint: magicmouse_battery_timer_tick+0x0/0x360 include/linux/device.h:693
WARNING: CPU: 1 PID: 20 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Modules linked in:
CPU: 1 PID: 20 Comm: kworker/1:0 Not tainted 5.16.0-rc6-next-20211224-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 80 c1 05 8a 4c 89 ee 48 c7 c7 80 b5 05 8a e8 1e 28 25 05 <0f> 0b 83 05 35 9d a6 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc90000da6b10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815f4208 RDI: fffff520001b4d54
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815edf6e R11: 0000000000000000 R12: ffffffff89adf420
R13: ffffffff8a05bbc0 R14: ffffffff81666980 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4272a02090 CR3: 000000000b88e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:992 [inline]
 debug_check_no_obj_freed+0x301/0x420 lib/debugobjects.c:1023
 slab_free_hook mm/slub.c:1703 [inline]
 slab_free_freelist_hook+0xeb/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kfree+0xce/0x380 mm/slub.c:4562
 release_nodes drivers/base/devres.c:501 [inline]
 devres_release_all+0x18e/0x240 drivers/base/devres.c:530
 really_probe+0x553/0xcc0 drivers/base/dd.c:665
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3389
 hid_add_device+0x344/0x9d0 drivers/hid/hid-core.c:2530
 usbhid_probe+0xbf4/0x1070 drivers/hid/usbhid/hid-core.c:1424
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3389
 usb_set_configuration+0x101e/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3389
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2566
 hub_port_connect drivers/usb/core/hub.c:5358 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5502 [inline]
 port_event drivers/usb/core/hub.c:5660 [inline]
 hub_event+0x2585/0x44d0 drivers/usb/core/hub.c:5742
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
