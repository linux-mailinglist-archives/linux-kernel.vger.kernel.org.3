Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667BE58E95A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiHJJNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiHJJNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:13:25 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E919686C30
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:13:23 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id n13-20020a056e02140d00b002dfa5464967so8810382ilo.19
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=tf4gJN+guGWJfhtEdIsV/zbFIfUPfg1ABC2K/UmNdy0=;
        b=jDpUQ0CSbJvNCG5YKknYs81yEc0+3RuwM89ubh7ohkD9168f1UDvy+1MJ5hZnvohLe
         /7sspsgwXeCzZIozmkzQ7mjC/AG9PDJklTKA9jCt5Bbdq1hHVS7TO5JmVkedzUe6lqtq
         TsZRsTtE/DKmlsPVAWN8/NobKNQ4w9nnaO7HcIn4DYgSlPWVH0h/TlQUoSPJVtW4oHw1
         8j6zuTABtZjOGaAUEmZUV4RzggYUpMAlQc+X/2Do9NmevUo0F/BKAJgyDpMb4Pvz5szr
         dO1QwpQH8vZ5pFMb3SkpgOs0Yy5g/2etkcjiZCW2PuYFwtoZO27o55fcW/cJY+2OmmjL
         l4mQ==
X-Gm-Message-State: ACgBeo0pz6kY+S2CkFcSUuHygBYpbQ4ZZiF4VT1rgUVLy/OliGfP36tZ
        Au6Ld96BxTaJRrcwULxSnUwLj3Q2FOEsKKGyN3a+lqR1vkvd
X-Google-Smtp-Source: AA6agR6ESvFQaWHXHWCztcEP/o7zcj5RbakFDygn/AXmnxD9ycBS5+dJIyydo5MjGviiJrL+MnLNqWGmGtQ7E0AfbS7fhsRJoZ/i
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c43:b0:2e0:cc73:1ba2 with SMTP id
 d3-20020a056e021c4300b002e0cc731ba2mr7373626ilg.252.1660122803292; Wed, 10
 Aug 2022 02:13:23 -0700 (PDT)
Date:   Wed, 10 Aug 2022 02:13:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9512505e5df758d@google.com>
Subject: [syzbot] linux-next boot error: general protection fault in driver_register
From:   syzbot <syzbot+5ea594c104baba5164fe@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, rafael@kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
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

HEAD commit:    bc6c6584ffb2 Add linux-next specific files for 20220810
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=147843e1080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5784be4315a4403b
dashboard link: https://syzkaller.appspot.com/bug?extid=5ea594c104baba5164fe
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ea594c104baba5164fe@syzkaller.appspotmail.com

input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: button: Sleep Button [SLPF]
ACPI: \_SB_.LNKC: Enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKD: Enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKB: Enabled at IRQ 10
virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
N_HDLC line discipline registered with maxframe=4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
ACPI: bus type drm_connector registered
[drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
Console: switching to colour frame buffer device 128x48
platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
usbcore: registered new interface driver udl
brd: module loaded
loop: module loaded
zram: Added device: zram0
null_blk: disk nullb0 created
null_blk: module loaded
Guest personality initialized and is inactive
VMCI host device registered (name=vmci, major=10, minor=120)
Initialized host personality
usbcore: registered new interface driver rtsx_usb
usbcore: registered new interface driver viperboard
usbcore: registered new interface driver dln2
usbcore: registered new interface driver pn533_usb
nfcsim 0.2 initialized
usbcore: registered new interface driver port100
usbcore: registered new interface driver nfcmrvl
Loading iSCSI transport class v2.0-870.
scsi host0: Virtio SCSI HBA
st: Version 20160209, fixed bufsize 32768, s/g segs 256
Rounding down aligned max_sectors from 4294967295 to 4294967288
db_root: cannot open: /etc/target
slram: not enough parameters.
ftl_cs: FTL header not found.
wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
eql: Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller (davem@redhat.com)
MACsec IEEE 802.1AE
tun: Universal TUN/TAP device driver, 1.6
general protection fault, probably for non-canonical address 0xffff000000000800: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8200000004000-0xfff8200000004007]
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-next-20220810-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:kmem_cache_alloc_trace+0x164/0x3e0 mm/slub.c:3282
Code: 8b 51 08 48 8b 01 48 83 79 10 00 48 89 44 24 08 0f 84 bf 01 00 00 48 85 c0 0f 84 b6 01 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 c2 01 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc90000067ce8 EFLAGS: 00010246
RAX: ffff000000000000 RBX: 0000000000000000 RCX: 0000000000000800
RDX: 0000000000002ae8 RSI: 0000000000000dc0 RDI: 000000000003dce0
RBP: ffff888011842140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000dc0 R14: 0000000000000a20 R15: 0000000000000dc0
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 kobject_uevent_env+0x230/0x1640 lib/kobject_uevent.c:524
 driver_register+0x2db/0x3a0 drivers/base/driver.c:248
 virtio_net_driver_init+0x93/0xd2 drivers/net/virtio_net.c:4102
 do_one_initcall+0xfe/0x650 init/main.c:1299
 do_initcall_level init/main.c:1374 [inline]
 do_initcalls init/main.c:1390 [inline]
 do_basic_setup init/main.c:1409 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1616
 kernel_init+0x1a/0x1d0 init/main.c:1505
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:kmem_cache_alloc_trace+0x164/0x3e0 mm/slub.c:3282
Code: 8b 51 08 48 8b 01 48 83 79 10 00 48 89 44 24 08 0f 84 bf 01 00 00 48 85 c0 0f 84 b6 01 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 c2 01 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc90000067ce8 EFLAGS: 00010246
RAX: ffff000000000000 RBX: 0000000000000000 RCX: 0000000000000800
RDX: 0000000000002ae8 RSI: 0000000000000dc0 RDI: 000000000003dce0
RBP: ffff888011842140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000dc0 R14: 0000000000000a20 R15: 0000000000000dc0
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8b 51 08             	mov    0x8(%rcx),%edx
   3:	48 8b 01             	mov    (%rcx),%rax
   6:	48 83 79 10 00       	cmpq   $0x0,0x10(%rcx)
   b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10:	0f 84 bf 01 00 00    	je     0x1d5
  16:	48 85 c0             	test   %rax,%rax
  19:	0f 84 b6 01 00 00    	je     0x1d5
  1f:	48 8b 7d 00          	mov    0x0(%rbp),%rdi
  23:	8b 4d 28             	mov    0x28(%rbp),%ecx
  26:	40 f6 c7 0f          	test   $0xf,%dil
* 2a:	48 8b 1c 08          	mov    (%rax,%rcx,1),%rbx <-- trapping instruction
  2e:	0f 85 c2 01 00 00    	jne    0x1f6
  34:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  38:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3d:	0f 94 c0             	sete   %al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
