Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B135A3D35
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 12:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiH1Kob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 06:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiH1Ko2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 06:44:28 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D3013CD1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 03:44:27 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id bh11-20020a056602370b00b00688c8a2b56cso3167919iob.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 03:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=mWpjuw2cEypIEwPl3uUFPCRS5JpzlHOLzs3TgwZBGJ8=;
        b=RJ33uQpZvk/GkmNDE2CRW/jZSelnw6iDDZC/xKyXE7f7qLeJb9AT7UQTSYTKaWh+jS
         6M8ipwVMvQ6uXGIS0Gxcjqy6IOqQlaFd42NGct5T6lSGmVBqt6mw3//Zy7b975/p2R8c
         JrCFgR7ipcwTEP2iMRftCRadWeg2GCQX+VOqg1NxVgqKRzcErPQfJwrefHOaaheU1Ohp
         S8kI6sT1lnhX99VLF7NZ0jNBeW0ETbWBwCYjn5tC0aQdGDXUFFZ0OdRaR6YMB2hcQPia
         q2RQkJ02Ig1Fy/kZ1KarKRpwrYf5M2valPwl7VxKjaA2kzRNrFThmh3cbMlJjmLOHkLZ
         8+cg==
X-Gm-Message-State: ACgBeo2mMFgagdIFve7X3Mj5ObbpwM/yJEqwnwod1pXANjkOD5hiNyxE
        T1U9QmvjC+NZD/0iuULR3DqKXkCFGbKq2hltJR91ltLE/ZqU
X-Google-Smtp-Source: AA6agR6nuK/jedOn6XCE2bkX14AoyBxrnUcfzrL/5xBxG4n5OSiyPFeC5poB3hAAjIY419N82aIif5hhFBf2i5SdioS+22IT0ulS
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:2ea:8154:1da0 with SMTP id
 k11-20020a056e021a8b00b002ea81541da0mr6378225ilv.47.1661683466752; Sun, 28
 Aug 2022 03:44:26 -0700 (PDT)
Date:   Sun, 28 Aug 2022 03:44:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3da4d05e74ad4fc@google.com>
Subject: [syzbot] usb-testing boot error: general protection fault in driver_register
From:   syzbot <syzbot+e7499dac4bd3955773ed@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
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

syzbot found the following issue on:

HEAD commit:    4dce3b375179 usb/hcd: Fix dma_map_sg error check
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10344fd3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=e7499dac4bd3955773ed
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7499dac4bd3955773ed@syzkaller.appspotmail.com

PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x00000000bbffd000-0x00000000bfffd000] (64MB)
RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb6b90ffa2, max_idle_ns: 440795278193 ns
clocksource: Switched to clocksource tsc
Initialise system trusted keyrings
workingset: timestamp_bits=40 max_order=21 bucket_order=0
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
9p: Installing v9fs 9p2000 file system support
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
io scheduler mq-deadline registered
io scheduler kyber registered
usbcore: registered new interface driver udlfb
usbcore: registered new interface driver smscufx
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: button: Sleep Button [SLPF]
ACPI: \_SB_.LNKC: Enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKD: Enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKB: Enabled at IRQ 10
virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
ACPI: bus type drm_connector registered
usbcore: registered new interface driver udl
loop: module loaded
usbcore: registered new interface driver rtsx_usb
usbcore: registered new interface driver viperboard
usbcore: registered new interface driver dln2
usbcore: registered new interface driver pn533_usb
usbcore: registered new interface driver port100
usbcore: registered new interface driver nfcmrvl
scsi host0: Virtio SCSI HBA
scsi 0:0:1:0: Direct-Access     Google   PersistentDisk   1    PQ: 0 ANSI: 6
sd 0:0:1:0: Attached scsi generic sg0 type 0
Rounding down aligned max_sectors from 4294967295 to 4294967288
db_root: cannot open: /etc/target
general protection fault, probably for non-canonical address 0xffff000000000800: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8200000004000-0xfff8200000004007]
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-syzkaller-00028-g4dce3b375179 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:kmem_cache_alloc_trace+0x15e/0x3b0 mm/slub.c:3282
Code: 8b 51 08 48 8b 01 48 83 79 10 00 48 89 44 24 08 0f 84 9d 01 00 00 48 85 c0 0f 84 94 01 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 a0 01 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc9000001fce8 EFLAGS: 00010246
RAX: ffff000000000000 RBX: 0000000000000000 RCX: 0000000000000800
RDX: 0000000000000d39 RSI: 0000000000000dc0 RDI: 000000000003b470
RBP: ffff888100042140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000dc0
R13: 0000000000000a20 R14: 0000000000000dc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 kobject_uevent_env+0x230/0x1640 lib/kobject_uevent.c:524
 driver_register+0x2db/0x3a0 drivers/base/driver.c:248
 virtio_net_driver_init+0x93/0xd2 drivers/net/virtio_net.c:4108
 do_one_initcall+0xfe/0x650 init/main.c:1296
 do_initcall_level init/main.c:1369 [inline]
 do_initcalls init/main.c:1385 [inline]
 do_basic_setup init/main.c:1404 [inline]
 kernel_init_freeable+0x6ac/0x735 init/main.c:1611
 kernel_init+0x1a/0x1d0 init/main.c:1500
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:kmem_cache_alloc_trace+0x15e/0x3b0 mm/slub.c:3282
Code: 8b 51 08 48 8b 01 48 83 79 10 00 48 89 44 24 08 0f 84 9d 01 00 00 48 85 c0 0f 84 94 01 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 a0 01 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc9000001fce8 EFLAGS: 00010246
RAX: ffff000000000000 RBX: 0000000000000000 RCX: 0000000000000800
RDX: 0000000000000d39 RSI: 0000000000000dc0 RDI: 000000000003b470
RBP: ffff888100042140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000dc0
R13: 0000000000000a20 R14: 0000000000000dc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8b 51 08             	mov    0x8(%rcx),%edx
   3:	48 8b 01             	mov    (%rcx),%rax
   6:	48 83 79 10 00       	cmpq   $0x0,0x10(%rcx)
   b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10:	0f 84 9d 01 00 00    	je     0x1b3
  16:	48 85 c0             	test   %rax,%rax
  19:	0f 84 94 01 00 00    	je     0x1b3
  1f:	48 8b 7d 00          	mov    0x0(%rbp),%rdi
  23:	8b 4d 28             	mov    0x28(%rbp),%ecx
  26:	40 f6 c7 0f          	test   $0xf,%dil
* 2a:	48 8b 1c 08          	mov    (%rax,%rcx,1),%rbx <-- trapping instruction
  2e:	0f 85 a0 01 00 00    	jne    0x1d4
  34:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  38:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3d:	0f 94 c0             	sete   %al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
