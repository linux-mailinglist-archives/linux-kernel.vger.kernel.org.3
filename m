Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF2156165C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiF3JcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiF3JcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:32:22 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89B342ED7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:32:20 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id a6-20020a92a306000000b002da987fc9f2so5864993ili.17
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Aqv+uR4xJVCILY0FJU8Eeg6DETdWn8J1zwf9rn3G8z0=;
        b=M35mTzowM1FbgbaXPtoQLKCAY2bggJ4kEtMZfwSNO121RaiFLz3UII0glxE+yUnxbu
         nYp21WLgtAmHCa5kX/zG2GpT4oI33CzbceSXbcEucaFd8HlhH3w9HQ8Ryq97W9BXcEkn
         mbIdCP6ox52+CjnRw2/IBi7RqA3sEJWs6NsV3ML0aHFy9I2dZErFtZkA8CQuP/Mu+7ZF
         KdRH1xm7vbJ9qWpPCZGJj6qQmhae1Z7mnYWpUWAGs16VQmGp2Iu3hMyO47YCb98lo9HV
         WavBX5nA26x9FZOlxHyED3MYtNPwDQXwEi2VGNiOHy679pYTQ6zbQzJ9nlKm+Hb7yxk+
         Br7w==
X-Gm-Message-State: AJIora/ZPwAiv5AOjDR9vg0Js1iuWIBKyBjJvDgJFG/1QLKaWi2/k19s
        RugGpDUtmWT7aeDjVkqg6jlPvWbOsxkRkkKcQU9bMIw0fJ4u
X-Google-Smtp-Source: AGRyM1tQnCRMVWqdnKP691JsDC+C/VhOGWuSIMBmaC32Fz51TGwXC4HTF9SRQpsDPD2ZrP/W2dfjDjkdO+9p+kxH/SsN10TMbvdu
MIME-Version: 1.0
X-Received: by 2002:a02:85e3:0:b0:339:cf24:68f6 with SMTP id
 d90-20020a0285e3000000b00339cf2468f6mr4806247jai.161.1656581540305; Thu, 30
 Jun 2022 02:32:20 -0700 (PDT)
Date:   Thu, 30 Jun 2022 02:32:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040624a05e2a6f2db@google.com>
Subject: [syzbot] linux-next boot error: general protection fault in add_mtd_device
From:   syzbot <syzbot+fe013f55a2814a9e8cfd@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-next@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6cc11d2a1759 Add linux-next specific files for 20220630
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1640f850080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54f75b620e3845dd
dashboard link: https://syzkaller.appspot.com/bug?extid=fe013f55a2814a9e8cfd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe013f55a2814a9e8cfd@syzkaller.appspotmail.com

Block layer SCSI generic (bsg) driver version 0.4 loaded (major 240)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
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
VMCI host device registered (name=vmci, major=10, minor=119)
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
general protection fault, probably for non-canonical address 0xdffffc00000000ac: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000560-0x0000000000000567]
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc4-next-20220630-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/18/2022
RIP: 0010:dev_of_node include/linux/device.h:862 [inline]
RIP: 0010:mtd_check_of_node drivers/mtd/mtdcore.c:563 [inline]
RIP: 0010:add_mtd_device+0xbc8/0x1520 drivers/mtd/mtdcore.c:721
Code: 48 81 fd 60 fe ff ff 0f 84 90 fd ff ff e8 b0 10 97 fc 48 8d bd 60 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 da 08 00 00 48 8b ad 60 05 00 00 48 85 ed 0f 84
RSP: 0000:ffffc90000067c98 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88801ebf2000 RCX: 0000000000000000
RDX: 00000000000000ac RSI: ffffffff84e3a650 RDI: 0000000000000560
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000000
R10: ffffffff89c00000 R11: 0000000000000001 R12: ffff88801ebf2004
R13: ffff88801ebf2028 R14: 0000000000000000 R15: 0000000005a00000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000ba8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mtd_device_parse_register+0x50c/0x850 drivers/mtd/mtdcore.c:1032
 mtdram_init_device+0x291/0x350 drivers/mtd/devices/mtdram.c:146
 init_mtdram+0xe5/0x177 drivers/mtd/devices/mtdram.c:171
 do_one_initcall+0xfe/0x650 init/main.c:1300
 do_initcall_level init/main.c:1375 [inline]
 do_initcalls init/main.c:1391 [inline]
 do_basic_setup init/main.c:1410 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1617
 kernel_init+0x1a/0x1d0 init/main.c:1506
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dev_of_node include/linux/device.h:862 [inline]
RIP: 0010:mtd_check_of_node drivers/mtd/mtdcore.c:563 [inline]
RIP: 0010:add_mtd_device+0xbc8/0x1520 drivers/mtd/mtdcore.c:721
Code: 48 81 fd 60 fe ff ff 0f 84 90 fd ff ff e8 b0 10 97 fc 48 8d bd 60 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 da 08 00 00 48 8b ad 60 05 00 00 48 85 ed 0f 84
RSP: 0000:ffffc90000067c98 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88801ebf2000 RCX: 0000000000000000
RDX: 00000000000000ac RSI: ffffffff84e3a650 RDI: 0000000000000560
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000000
R10: ffffffff89c00000 R11: 0000000000000001 R12: ffff88801ebf2004
R13: ffff88801ebf2028 R14: 0000000000000000 R15: 0000000005a00000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000ba8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 81 fd 60 fe ff ff 	cmp    $0xfffffffffffffe60,%rbp
   7:	0f 84 90 fd ff ff    	je     0xfffffd9d
   d:	e8 b0 10 97 fc       	callq  0xfc9710c2
  12:	48 8d bd 60 05 00 00 	lea    0x560(%rbp),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 da 08 00 00    	jne    0x90e
  34:	48 8b ad 60 05 00 00 	mov    0x560(%rbp),%rbp
  3b:	48 85 ed             	test   %rbp,%rbp
  3e:	0f                   	.byte 0xf
  3f:	84                   	.byte 0x84


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
