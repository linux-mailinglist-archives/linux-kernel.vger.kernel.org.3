Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDEB59598D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiHPLLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiHPLKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:10:53 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843AE43305
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:38:22 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id t7-20020a6b6407000000b00684ed320f97so5635468iog.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=P+olfJtRQHOHGMMPDrWt6CvAtWdhD9URE1GY5oKp4Ns=;
        b=5oNdWqc4MAK7pCXIrc1n5W9uhAPiTJdppvpOKUtlI29BKxkC1k7w8Tcbhs2ozCRw4/
         Fk6tT+5D9B90RLdSpAwcPZ74dBH1XXddWMe460UE6C7ISZ8lAoNtuDa06sIL+oitNMyk
         PPQG375nTiBJE5cVQ52HJuq5vAXRmUDsMw9Irsw9DOM0lIbGzU6Lv1umbu9Va0HF1hSI
         hGbdERqJJiWOhQne/HncBgocKjZgND2gCxanhEmsDDzYdDOHUPsBSrHGbnnMyndYwTN4
         EHyTqUMnDLkZcnNfIPkHJBN+gQjRxetT3KG0bWboJiDhTZJkyEEs9kpo0MfvfSbBczk1
         hWiQ==
X-Gm-Message-State: ACgBeo1OqY5l55Rw7PcFMfSIXUws9Kbuivk2ihkaymVk/ExpuBOHWH2m
        jV3H2DOov8+7py74auJEWaMQKsrOo4+dEghqO9Cf6tKT0R1c
X-Google-Smtp-Source: AA6agR5/sORJHrbE/EmX677b0DBh4Hd/rlfaMYN1cT0K8nlQFUG4r1zuphZGTgBiNrhuyOq5bCeQmYpkomwcJyAHNz518nGMQZsY
MIME-Version: 1.0
X-Received: by 2002:a02:ad0d:0:b0:343:517b:eb41 with SMTP id
 s13-20020a02ad0d000000b00343517beb41mr8954373jan.152.1660639101857; Tue, 16
 Aug 2022 01:38:21 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:38:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c434ae05e657ab87@google.com>
Subject: [syzbot] upstream boot error: general protection fault in really_probe
From:   syzbot <syzbot+d964b0e6c56631bb9c3d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, rafael@kernel.org,
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

HEAD commit:    aea23e7c464b Merge tag 'pull-work.misc' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13dc4b05080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f83c035536d7b2e3
dashboard link: https://syzkaller.appspot.com/bug?extid=d964b0e6c56631bb9c3d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d964b0e6c56631bb9c3d@syzkaller.appspotmail.com

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
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-syzkaller-14276-gaea23e7c464b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:kmem_cache_alloc_trace+0x172/0x310 mm/slub.c:3282
Code: 84 d9 00 00 00 48 83 78 10 00 0f 84 ce 00 00 00 49 8b 2e 40 f6 c5 0f 0f 85 9f 01 00 00 40 84 ff 0f 84 98 01 00 00 41 8b 46 28 <49> 8b 5c 05 00 48 8d 4a 08 4c 89 e8 65 48 0f c7 4d 00 0f 94 c0 a8
RSP: 0000:ffffc90000067918 EFLAGS: 00010202
RAX: 0000000000000800 RBX: 0000000000000dc0 RCX: 0000000000000000
RDX: 0000000000002ed0 RSI: 0000000000000dc0 RDI: ffff888012042101
RBP: 000000000003d960 R08: dffffc0000000000 R09: fffffbfff1c4ade6
R10: fffffbfff1c4ade6 R11: 1ffffffff1c4ade5 R12: 0000000000000a20
R13: ffff000000000000 R14: ffff888012042140 R15: 0000000000000dc0
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000ca8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 kobject_uevent_env+0x33a/0x8e0 lib/kobject_uevent.c:524
 really_probe+0x794/0x9f0 drivers/base/dd.c:657
 __driver_probe_device+0x1f4/0x3f0 drivers/base/dd.c:748
 driver_probe_device+0x50/0x240 drivers/base/dd.c:778
 __driver_attach+0x35f/0x590 drivers/base/dd.c:1150
 bus_for_each_dev+0x188/0x1f0 drivers/base/bus.c:301
 bus_add_driver+0x32f/0x600 drivers/base/bus.c:618
 driver_register+0x2e9/0x3e0 drivers/base/driver.c:240
 virtio_net_driver_init+0x8e/0xcb drivers/net/virtio_net.c:4108
 do_one_initcall+0xbd/0x2b0 init/main.c:1296
 do_initcall_level+0x168/0x218 init/main.c:1369
 do_initcalls+0x4b/0x8c init/main.c:1385
 kernel_init_freeable+0x43a/0x5c3 init/main.c:1611
 kernel_init+0x19/0x2b0 init/main.c:1500
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:kmem_cache_alloc_trace+0x172/0x310 mm/slub.c:3282
Code: 84 d9 00 00 00 48 83 78 10 00 0f 84 ce 00 00 00 49 8b 2e 40 f6 c5 0f 0f 85 9f 01 00 00 40 84 ff 0f 84 98 01 00 00 41 8b 46 28 <49> 8b 5c 05 00 48 8d 4a 08 4c 89 e8 65 48 0f c7 4d 00 0f 94 c0 a8
RSP: 0000:ffffc90000067918 EFLAGS: 00010202
RAX: 0000000000000800 RBX: 0000000000000dc0 RCX: 0000000000000000
RDX: 0000000000002ed0 RSI: 0000000000000dc0 RDI: ffff888012042101
RBP: 000000000003d960 R08: dffffc0000000000 R09: fffffbfff1c4ade6
R10: fffffbfff1c4ade6 R11: 1ffffffff1c4ade5 R12: 0000000000000a20
R13: ffff000000000000 R14: ffff888012042140 R15: 0000000000000dc0
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000ca8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	84 d9                	test   %bl,%cl
   2:	00 00                	add    %al,(%rax)
   4:	00 48 83             	add    %cl,-0x7d(%rax)
   7:	78 10                	js     0x19
   9:	00 0f                	add    %cl,(%rdi)
   b:	84 ce                	test   %cl,%dh
   d:	00 00                	add    %al,(%rax)
   f:	00 49 8b             	add    %cl,-0x75(%rcx)
  12:	2e 40 f6 c5 0f       	cs test $0xf,%bpl
  17:	0f 85 9f 01 00 00    	jne    0x1bc
  1d:	40 84 ff             	test   %dil,%dil
  20:	0f 84 98 01 00 00    	je     0x1be
  26:	41 8b 46 28          	mov    0x28(%r14),%eax
* 2a:	49 8b 5c 05 00       	mov    0x0(%r13,%rax,1),%rbx <-- trapping instruction
  2f:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  33:	4c 89 e8             	mov    %r13,%rax
  36:	65 48 0f c7 4d 00    	cmpxchg16b %gs:0x0(%rbp)
  3c:	0f 94 c0             	sete   %al
  3f:	a8                   	.byte 0xa8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
