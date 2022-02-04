Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526B34A988A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358466AbiBDLmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:42:23 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:47101 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbiBDLmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:42:22 -0500
Received: by mail-io1-f72.google.com with SMTP id d70-20020a6bcd49000000b0060d10445eddso3905696iog.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 03:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=36KTVj0AZYWxMeoeQVX5mEy243jn+ZN8gcRYu2GfdSk=;
        b=jJOKSAgoGdH5NaF2DRAeJAClGbxakxeweKHzUDABCFN6EmPsU/gwbdnfbhbHDcFbkH
         VMwsVaKcRNDNHXytK+kQydeFWS9Zqplz3tdU6G64Kp0ElwnafONIIA9opQtBS02MGvca
         BzgRN6dQkuxbl9IjccLmS9BnqKqx+e/6TLK3XXPNIB6PPTh1iApkBcIePedQHPN4K/96
         zl49j/1vadxFho8i2MbM1V/w25iNXcytmN2dkZlYtTvoESSp80cYk2pXQhO8nXanyAkD
         I4XdFZeV2PFyVYekYOX8cXyWlVQj+6+nlmextRqOCCw5aIkJHH6lkt2aFDv77b0+c9QS
         4Lbw==
X-Gm-Message-State: AOAM532XSPSJjoVYdiEO6oNVVgvfCJ4pFtyTKyFIKC0ec5a7PKmeTm1a
        6fhQLq11G3vhYZMZrIiKRFDmihlcMPLseTJ7jV2pq3zFRV5j
X-Google-Smtp-Source: ABdhPJxso1fIuTaoh6MHPbumvivKZSIWPLh1ND/ivAiyDqXxgQU0X3mfzxoTVUdAEpM51gsp5ZTqYix0bzBcP6rEVkj2+42bdZ9K
MIME-Version: 1.0
X-Received: by 2002:a92:c6c8:: with SMTP id v8mr1205884ilm.14.1643974941905;
 Fri, 04 Feb 2022 03:42:21 -0800 (PST)
Date:   Fri, 04 Feb 2022 03:42:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e988105d72fbe3f@google.com>
Subject: [syzbot] general protection fault in i2c_setup_smbus_alert
From:   syzbot <syzbot+0591ccf54ee05344e4eb@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, djrscally@gmail.com,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, sakari.ailus@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    887a333c44eb Add linux-next specific files for 20220131
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=141d71e0700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a7db1ff785d5c0
dashboard link: https://syzkaller.appspot.com/bug?extid=0591ccf54ee05344e4eb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0591ccf54ee05344e4eb@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000008a: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000450-0x0000000000000457]
CPU: 0 PID: 3685 Comm: kworker/0:6 Not tainted 5.17.0-rc2-next-20220131-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:dev_fwnode drivers/base/property.c:22 [inline]
RIP: 0010:device_property_match_string+0x2c/0xa0 drivers/base/property.c:224
Code: 49 89 d5 41 54 49 89 f4 55 53 48 89 fb e8 2c 0e f7 fc 48 8d bb 50 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 5a 48 8b ab 50 04 00 00 48 85 ed 74 22 e8 fd 0d f7
RSP: 0018:ffffc90004096fd8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc900134aa000
RDX: 000000000000008a RSI: ffffffff84819374 RDI: 0000000000000450
RBP: ffff88801a685038 R08: 0000000000000000 R09: ffff88801a6851a3
R10: ffffffff85ed1a99 R11: 0000000000000000 R12: ffffffff8a660120
R13: ffffffff8a6600e0 R14: ffff88801a685660 R15: ffff88801a685664
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1ac663a9ee CR3: 000000007a1ff000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 i2c_setup_smbus_alert+0x9c/0x1a0 drivers/i2c/i2c-core-smbus.c:710
 i2c_register_adapter+0x32f/0x1150 drivers/i2c/i2c-core-base.c:1482
 i2c_add_adapter+0x11a/0x1c0 drivers/i2c/i2c-core-base.c:1587
 osif_probe+0x2ae/0x500 drivers/i2c/busses/i2c-robotfuzz-osif.c:164
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3405
 usb_set_configuration+0x101e/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3405
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2566
 hub_port_connect drivers/usb/core/hub.c:5362 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5506 [inline]
 port_event drivers/usb/core/hub.c:5664 [inline]
 hub_event+0x25c6/0x4680 drivers/usb/core/hub.c:5746
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dev_fwnode drivers/base/property.c:22 [inline]
RIP: 0010:device_property_match_string+0x2c/0xa0 drivers/base/property.c:224
Code: 49 89 d5 41 54 49 89 f4 55 53 48 89 fb e8 2c 0e f7 fc 48 8d bb 50 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 5a 48 8b ab 50 04 00 00 48 85 ed 74 22 e8 fd 0d f7
RSP: 0018:ffffc90004096fd8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc900134aa000
RDX: 000000000000008a RSI: ffffffff84819374 RDI: 0000000000000450
RBP: ffff88801a685038 R08: 0000000000000000 R09: ffff88801a6851a3
R10: ffffffff85ed1a99 R11: 0000000000000000 R12: ffffffff8a660120
R13: ffffffff8a6600e0 R14: ffff88801a685660 R15: ffff88801a685664
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fda5e249090 CR3: 00000000348b9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	49 89 d5             	mov    %rdx,%r13
   3:	41 54                	push   %r12
   5:	49 89 f4             	mov    %rsi,%r12
   8:	55                   	push   %rbp
   9:	53                   	push   %rbx
   a:	48 89 fb             	mov    %rdi,%rbx
   d:	e8 2c 0e f7 fc       	callq  0xfcf70e3e
  12:	48 8d bb 50 04 00 00 	lea    0x450(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 5a                	jne    0x8a
  30:	48 8b ab 50 04 00 00 	mov    0x450(%rbx),%rbp
  37:	48 85 ed             	test   %rbp,%rbp
  3a:	74 22                	je     0x5e
  3c:	e8                   	.byte 0xe8
  3d:	fd                   	std
  3e:	0d                   	.byte 0xd
  3f:	f7                   	.byte 0xf7


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
