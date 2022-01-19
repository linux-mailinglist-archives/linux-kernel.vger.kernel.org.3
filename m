Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9816493602
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346862AbiASIG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:06:28 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:37454 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343971AbiASIG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:06:26 -0500
Received: by mail-io1-f69.google.com with SMTP id a10-20020a6b6d0a000000b0060a6d881105so971096iod.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DNq767sr2vzH/mc1BMvkTTk2NAnMTQrmyg2+/t2GQ5g=;
        b=SI4LA4SqEI6AZBvPNMprQgDNSetJp2oqBPvXbSLo5Kby/juG9CV2Gi6r4h8NGalp/d
         /oDWOQVHtUcrVD3JiRuhAAtrB31HA5bZPglVLcTcLtapjHWjw3Pm+rv/kE6/qGPFtoA4
         3zunwuc+UUd6GF87itFf+oXLRAs+YwhY7zbciKW7aW3pnDxvHv19C8iqdiAtEzSFk2VS
         lytAcw1DO+YaeIu7Y38W6m+JPlRU/qc5H0oJ8h763Hyrb/+z79/HJ5D7Lx1k6PfuxIKN
         VXArV2FEUx+O3umlPJ4QbaBRERGqm6L/Y0J9fiz2anAllHyNQZe74W2CTGu64WX6BKmk
         Sxrg==
X-Gm-Message-State: AOAM530pZ/BRbdW0JTiAeqAeDbX/WK0dbdnhxlkyvB5EF+hFE8q2ZEmX
        A6CS9NOYntCwMkKVK4Y89ZQ1zi4tSYHuCRG46Jgg+azeWdt/
X-Google-Smtp-Source: ABdhPJyfZigFvDwpNaXo0/u8QRJ0t40ZgMCwC0RXrVBm4c0RHaBOx2Yxq+wS1Sc6dP5gqLXb/pQI/TZc64iETd8A3dirMJOngEiT
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3824:: with SMTP id i36mr9576040jav.258.1642579585393;
 Wed, 19 Jan 2022 00:06:25 -0800 (PST)
Date:   Wed, 19 Jan 2022 00:06:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3eab705d5eadc8b@google.com>
Subject: [syzbot] general protection fault in dvb_create_media_graph
From:   syzbot <syzbot+0d6a22bbfd17e8c94788@syzkaller.appspotmail.com>
To:     caihuoqing@baidu.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com,
        yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    455e73a07f6e Merge tag 'clk-for-linus' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=129fa2dfb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=465c0933df32e292
dashboard link: https://syzkaller.appspot.com/bug?extid=0d6a22bbfd17e8c94788
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d6a22bbfd17e8c94788@syzkaller.appspotmail.com

usb 5-1: media controller created
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
gp8psk_fe: Frontend attached
usb 5-1: DVB: registering adapter 0 frontend 0 (Genpix DVB-S)...
dvbdev: dvb_create_media_entity: media entity 'Genpix DVB-S' registered.
general protection fault, probably for non-canonical address 0xe37ffbf11022d58a: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0x1bffff888116ac50-0x1bffff888116ac57]
CPU: 1 PID: 4412 Comm: kworker/1:2 Not tainted 5.16.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:dvb_create_media_graph+0x115/0xbc0 drivers/media/dvb-core/dvbdev.c:628
Code: 3c 20 00 0f 85 d7 09 00 00 48 8b 43 10 48 8d 58 f0 49 39 c6 0f 84 87 00 00 00 e8 36 0f 2d fd 48 8d 7b 2c 48 89 f8 48 c1 e8 03 <42> 0f b6 14 20 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85
RSP: 0018:ffffc90005696f70 EFLAGS: 00010203
RAX: 037ffff11022d58a RBX: 1bffff888116ac28 RCX: ffffc9000a361000
RDX: 0000000000040000 RSI: ffffffff84167e6a RDI: 1bffff888116ac54
RBP: 0000000000000000 R08: ffffffff86a4b8e0 R09: ffffffff84167ea1
R10: 0000000000000004 R11: 0000000080ffff88 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff888116ac3908 R15: 0000000080ffff88
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0d80901110 CR3: 000000010c0c2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dvb_usb_adapter_frontend_init+0x3b7/0x5b0 drivers/media/usb/dvb-usb/dvb-usb-dvb.c:327
 dvb_usb_adapter_init drivers/media/usb/dvb-usb/dvb-usb-init.c:90 [inline]
 dvb_usb_init drivers/media/usb/dvb-usb/dvb-usb-init.c:184 [inline]
 dvb_usb_device_init.cold+0xcdd/0x1483 drivers/media/usb/dvb-usb/dvb-usb-init.c:308
 gp8psk_usb_probe+0x46/0x70 drivers/media/usb/dvb-usb/gp8psk.c:304
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3409
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
 device_add+0xc17/0x1ee0 drivers/base/core.c:3409
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2566
 hub_port_connect drivers/usb/core/hub.c:5358 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5502 [inline]
 port_event drivers/usb/core/hub.c:5660 [inline]
 hub_event+0x2585/0x44d0 drivers/usb/core/hub.c:5742
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 process_scheduled_works kernel/workqueue.c:2370 [inline]
 worker_thread+0x833/0x1110 kernel/workqueue.c:2456
 kthread+0x40b/0x500 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Modules linked in:
---[ end trace 89cde2584ae9d86b ]---
RIP: 0010:dvb_create_media_graph+0x115/0xbc0 drivers/media/dvb-core/dvbdev.c:628
Code: 3c 20 00 0f 85 d7 09 00 00 48 8b 43 10 48 8d 58 f0 49 39 c6 0f 84 87 00 00 00 e8 36 0f 2d fd 48 8d 7b 2c 48 89 f8 48 c1 e8 03 <42> 0f b6 14 20 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85
RSP: 0018:ffffc90005696f70 EFLAGS: 00010203
RAX: 037ffff11022d58a RBX: 1bffff888116ac28 RCX: ffffc9000a361000
RDX: 0000000000040000 RSI: ffffffff84167e6a RDI: 1bffff888116ac54
RBP: 0000000000000000 R08: ffffffff86a4b8e0 R09: ffffffff84167ea1
R10: 0000000000000004 R11: 0000000080ffff88 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff888116ac3908 R15: 0000000080ffff88
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0d80901110 CR3: 000000010c0c2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	3c 20                	cmp    $0x20,%al
   2:	00 0f                	add    %cl,(%rdi)
   4:	85 d7                	test   %edx,%edi
   6:	09 00                	or     %eax,(%rax)
   8:	00 48 8b             	add    %cl,-0x75(%rax)
   b:	43 10 48 8d          	rex.XB adc %cl,-0x73(%r8)
   f:	58                   	pop    %rax
  10:	f0 49 39 c6          	lock cmp %rax,%r14
  14:	0f 84 87 00 00 00    	je     0xa1
  1a:	e8 36 0f 2d fd       	callq  0xfd2d0f55
  1f:	48 8d 7b 2c          	lea    0x2c(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 14 20       	movzbl (%rax,%r12,1),%edx <-- trapping instruction
  2f:	48 89 f8             	mov    %rdi,%rax
  32:	83 e0 07             	and    $0x7,%eax
  35:	83 c0 03             	add    $0x3,%eax
  38:	38 d0                	cmp    %dl,%al
  3a:	7c 08                	jl     0x44
  3c:	84 d2                	test   %dl,%dl
  3e:	0f                   	.byte 0xf
  3f:	85                   	.byte 0x85


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
