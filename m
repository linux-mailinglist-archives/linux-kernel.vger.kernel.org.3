Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9670459346D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiHOSB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiHOSBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:01:42 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CC929CB3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:01:32 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n13-20020a056e02140d00b002dfa5464967so5472850ilo.19
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=wI6rpH0iM/1G/LX9v0hvrEVpnosX3FZrM6chnxP086I=;
        b=ZVj0doUrSQoG59w/1aHDo+eQO4BvGFfG7+WURyZ6LGLqIHeqW9jYj5UdktlqVQ3p7a
         Aq16eMebiGUwURCjoxNVLmQnFuhb+iXXrU7e1PUic9shXUS6bZXSuihzQHrgg4lH3hm5
         /k7GYJhblnMGxlXno18L6nHpNHkv9SOtYfxVTf3dcGSx1kc667pB6Lqwb2/2MukPp+U2
         MRMg4zwsbzkZzW0/cOEi5ZxnDPbu+8D9RBmAg/oSaB0MsoNRqRBOMrQVLRPXZ6szD4fj
         vO5ksV40uwrFGHmSP4ywwrTV81YBaG8lTB4ovomFqisioxdA8PstbLytbKVoKxBexflZ
         qrNw==
X-Gm-Message-State: ACgBeo08OJtcLYV6lH2s7dwNX1X6pzqkVRb/1gxx/wuiis8Z7jFtvTXa
        6vOz/y/QWZvQrm/a555wKhpq6VtHQROLnd3XzAg4mdoYubq3
X-Google-Smtp-Source: AA6agR6vFiqcBsYDIr2nznJ+SX3kiISr8BFjE5fNrZZd0mwP6Kr+jsx5HVvSQ6VcfNN9RcOBEEqBXjeju0a6HwJLziD4YfStMwMM
MIME-Version: 1.0
X-Received: by 2002:a02:cc97:0:b0:343:6284:a982 with SMTP id
 s23-20020a02cc97000000b003436284a982mr6903386jap.287.1660586490671; Mon, 15
 Aug 2022 11:01:30 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:01:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5391905e64b6b95@google.com>
Subject: [syzbot] usb-testing boot error: general protection fault in __tty_alloc_driver
From:   syzbot <syzbot+2c35c4d66094ddfe198e@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
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

HEAD commit:    568035b01cfb Linux 6.0-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15271a0d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=2c35c4d66094ddfe198e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c35c4d66094ddfe198e@syzkaller.appspotmail.com

scsi 0:0:1:0: Direct-Access     Google   PersistentDisk   1    PQ: 0 ANSI: 6
sd 0:0:1:0: Attached scsi generic sg0 type 0
Rounding down aligned max_sectors from 4294967295 to 4294967288
db_root: cannot open: /etc/target
CAN device driver interface
usbcore: registered new interface driver usb_8dev
usbcore: registered new interface driver ems_usb
usbcore: registered new interface driver gs_usb
usbcore: registered new interface driver kvaser_usb
usbcore: registered new interface driver mcba_usb
usbcore: registered new interface driver peak_usb
e100: Intel(R) PRO/100 Network Driver
e100: Copyright(c) 1999-2006 Intel Corporation
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
sky2: driver version 1.30
usbcore: registered new interface driver ath9k_htc
usbcore: registered new interface driver carl9170
usbcore: registered new interface driver ath6kl_usb
usbcore: registered new interface driver ar5523
usbcore: registered new interface driver ath10k_usb
Atmel at76x USB Wireless LAN Driver 0.17 loading
usbcore: registered new interface driver at76c50x-usb
usbcore: registered new interface driver brcmfmac
usbcore: registered new interface driver orinoco_usb
usbcore: registered new interface driver p54usb
usbcore: registered new interface driver usb8xxx
usbcore: registered new interface driver lbtf_usb
usbcore: registered new interface driver mwifiex_usb
usbcore: registered new interface driver mt7601u
usbcore: registered new interface driver rt2500usb
usbcore: registered new interface driver rt73usb
usbcore: registered new interface driver rt2800usb
usbcore: registered new interface driver rtl8187
usbcore: registered new interface driver rtl8192cu
usbcore: registered new interface driver rtl8xxxu
usbcore: registered new interface driver RSI-USB WLAN
usbcore: registered new interface driver zd1211rw
usbcore: registered new interface driver zd1201
usbcore: registered new interface driver rndis_wlan
usbcore: registered new interface driver atusb
usbcore: registered new interface driver catc
usbcore: registered new interface driver kaweth
pegasus: Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new interface driver pegasus
usbcore: registered new interface driver rtl8150
usbcore: registered new interface driver r8152
hso: drivers/net/usb/hso.c: Option Wireless
general protection fault, probably for non-canonical address 0xffff080000000400: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8600000002000-0xfff8600000002007]
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:__kmalloc+0x10e/0x320 mm/slub.c:4420
Code: 8b 51 08 48 8b 01 48 83 79 10 00 48 89 44 24 08 0f 84 dc 01 00 00 48 85 c0 0f 84 d3 01 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 df 01 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc9000001fd58 EFLAGS: 00010246
RAX: ffff080000000000 RBX: 0000000000000100 RCX: 0000000000000400
RDX: 0000000000001899 RSI: 0000000000000dc0 RDI: 000000000003b420
RBP: ffff888100042000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000dc0
R13: 0000000000000800 R14: 0000000000000dc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kmalloc_array include/linux/slab.h:640 [inline]
 kcalloc include/linux/slab.h:671 [inline]
 __tty_alloc_driver drivers/tty/tty_io.c:3358 [inline]
 __tty_alloc_driver+0x1ea/0x510 drivers/tty/tty_io.c:3317
 hso_init+0x98/0x44e drivers/net/usb/hso.c:3247
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
RIP: 0010:__kmalloc+0x10e/0x320 mm/slub.c:4420
Code: 8b 51 08 48 8b 01 48 83 79 10 00 48 89 44 24 08 0f 84 dc 01 00 00 48 85 c0 0f 84 d3 01 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 df 01 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc9000001fd58 EFLAGS: 00010246
RAX: ffff080000000000 RBX: 0000000000000100 RCX: 0000000000000400
RDX: 0000000000001899 RSI: 0000000000000dc0 RDI: 000000000003b420
RBP: ffff888100042000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000dc0
R13: 0000000000000800 R14: 0000000000000dc0 R15: 0000000000000000
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
  10:	0f 84 dc 01 00 00    	je     0x1f2
  16:	48 85 c0             	test   %rax,%rax
  19:	0f 84 d3 01 00 00    	je     0x1f2
  1f:	48 8b 7d 00          	mov    0x0(%rbp),%rdi
  23:	8b 4d 28             	mov    0x28(%rbp),%ecx
  26:	40 f6 c7 0f          	test   $0xf,%dil
* 2a:	48 8b 1c 08          	mov    (%rax,%rcx,1),%rbx <-- trapping instruction
  2e:	0f 85 df 01 00 00    	jne    0x213
  34:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  38:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3d:	0f 94 c0             	sete   %al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
