Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF05458F859
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiHKH3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbiHKH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:29:38 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD53923EF
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:29:35 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id h8-20020a6bfb08000000b00684f0587d0cso5306774iog.14
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=20C+yI2KibiJAbl2MuIQKwzDOwtmCdecHBfSm85T2W8=;
        b=1nTucrMppn7NL+8UVmZAow4ZFelF7VBDcQG+wNSuzBRFyhVchGuDDy1ffxrUhrxtIs
         jvieS6GPuOGvEdUkTYag7ejnOJyJKo2bkC2RokPNdBLh+sZakjA+yRKY+nRHPl/vvrBo
         nQADuge+5NAu9P8duYwXh4HQlzmvhnGiF52E9lXiBoasFzhOU+WG4k3YbJJ1jhb5H0g+
         ZkYZ48kCtX7I5Q/V2PXzbfyIDM12nuOMwAeD9GBqL2SiQ0ed0r591yLLrY3T3K9qpgXq
         xec52wsaVYR1qVd6vZBXFaIEo6c9gBqks3KZigp1mrxULqZRn1qDMHRVKzv2wMwMUnsz
         2XsA==
X-Gm-Message-State: ACgBeo2ujPgnMe3oX+khk+FiM8lc16ewVFgS77AQ5t7CzfgcM01M0sqt
        XJzSWvrT1xy2kIGdieTxDVOUurMMGJQdD/n58fDckHJCIwGV
X-Google-Smtp-Source: AA6agR6PB+VfsQk23BSrvL+l4uzYgFT52Ju6nZvXVRPY642t4ptNIm3tHcIvm+2oDFR74PKDVDHnTzD/qiOql0sysRf5ikjhh0GG
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1654:b0:684:8736:dd00 with SMTP id
 y20-20020a056602165400b006848736dd00mr8777997iow.214.1660202974662; Thu, 11
 Aug 2022 00:29:34 -0700 (PDT)
Date:   Thu, 11 Aug 2022 00:29:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f595005e5f2204f@google.com>
Subject: [syzbot] linux-next boot error: BUG: unable to handle kernel paging
 request in proc_register
From:   syzbot <syzbot+fa81ecc0eb36dcfb86bb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

HEAD commit:    40d43a7507e1 Add linux-next specific files for 20220811
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14516c0d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5ae8cfa8d7075d1
dashboard link: https://syzkaller.appspot.com/bug?extid=fa81ecc0eb36dcfb86bb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa81ecc0eb36dcfb86bb@syzkaller.appspotmail.com

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
BUG: unable to handle page fault for address: ffffdc0000000004
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-next-20220811-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:proc_match fs/proc/generic.c:48 [inline]
RIP: 0010:pde_subdir_insert fs/proc/generic.c:101 [inline]
RIP: 0010:proc_register+0x255/0x700 fs/proc/generic.c:375
Code: 07 38 d0 7f 08 84 c0 0f 85 ab 03 00 00 48 8b 04 24 48 8d 7b 23 48 89 fa 83 e2 07 44 0f b6 a8 e3 00 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 30 45 89 ef 38 d0 7f 08 84 c0 0f 85 70 03 00 00 44 0f
RSP: 0000:ffffc900000675d0 EFLAGS: 00010a02
RAX: 1fffe00000000004 RBX: ffff000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff81fae17c RDI: ffff000000000023
RBP: ffff888147325708 R08: 0000000000000004 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000002 R14: dffffc0000000000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000004 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 _proc_mkdir fs/proc/generic.c:498 [inline]
 proc_mkdir_data fs/proc/generic.c:507 [inline]
 proc_mkdir+0x10b/0x170 fs/proc/generic.c:521
 register_irq_proc+0x156/0x390 kernel/irq/proc.c:360
 __setup_irq+0x10fd/0x1c90 kernel/irq/manage.c:1818
 request_threaded_irq+0x2b2/0x3e0 kernel/irq/manage.c:2198
 request_irq include/linux/interrupt.h:168 [inline]
 vp_find_vqs_msix+0x961/0xea0 drivers/virtio/virtio_pci_common.c:345
 vp_find_vqs+0x5a/0x540 drivers/virtio/virtio_pci_common.c:407
 virtio_find_vqs_ctx_size include/linux/virtio_config.h:252 [inline]
 virtnet_find_vqs+0x6cd/0xf00 drivers/net/virtio_net.c:3512
 init_vqs drivers/net/virtio_net.c:3600 [inline]
 virtnet_probe+0x11c0/0x2f30 drivers/net/virtio_net.c:3898
 virtio_dev_probe+0x577/0x870 drivers/virtio/virtio.c:305
 call_driver_probe drivers/base/dd.c:530 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:609
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:748
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:778
 __driver_attach+0x223/0x550 drivers/base/dd.c:1150
 bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
 bus_add_driver+0x4c9/0x640 drivers/base/bus.c:618
 driver_register+0x220/0x3a0 drivers/base/driver.c:240
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
CR2: ffffdc0000000004
---[ end trace 0000000000000000 ]---
RIP: 0010:proc_match fs/proc/generic.c:48 [inline]
RIP: 0010:pde_subdir_insert fs/proc/generic.c:101 [inline]
RIP: 0010:proc_register+0x255/0x700 fs/proc/generic.c:375
Code: 07 38 d0 7f 08 84 c0 0f 85 ab 03 00 00 48 8b 04 24 48 8d 7b 23 48 89 fa 83 e2 07 44 0f b6 a8 e3 00 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 30 45 89 ef 38 d0 7f 08 84 c0 0f 85 70 03 00 00 44 0f
RSP: 0000:ffffc900000675d0 EFLAGS: 00010a02
RAX: 1fffe00000000004 RBX: ffff000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff81fae17c RDI: ffff000000000023
RBP: ffff888147325708 R08: 0000000000000004 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000002 R14: dffffc0000000000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000004 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	38 d0                	cmp    %dl,%al
   2:	7f 08                	jg     0xc
   4:	84 c0                	test   %al,%al
   6:	0f 85 ab 03 00 00    	jne    0x3b7
   c:	48 8b 04 24          	mov    (%rsp),%rax
  10:	48 8d 7b 23          	lea    0x23(%rbx),%rdi
  14:	48 89 fa             	mov    %rdi,%rdx
  17:	83 e2 07             	and    $0x7,%edx
  1a:	44 0f b6 a8 e3 00 00 	movzbl 0xe3(%rax),%r13d
  21:	00
  22:	48 89 f8             	mov    %rdi,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2e:	45 89 ef             	mov    %r13d,%r15d
  31:	38 d0                	cmp    %dl,%al
  33:	7f 08                	jg     0x3d
  35:	84 c0                	test   %al,%al
  37:	0f 85 70 03 00 00    	jne    0x3ad
  3d:	44                   	rex.R
  3e:	0f                   	.byte 0xf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
