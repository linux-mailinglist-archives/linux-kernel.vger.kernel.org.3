Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F19859574D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiHPJ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiHPJ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:57:19 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955A7DB7E4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:41:35 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id c7-20020a056e020bc700b002e59be6ce85so4105478ilu.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=uDdqdg2D5oQb5bC2cgZXwzGB0b6PimvWB/eIeWIucQ8=;
        b=OkjS3O5ZRaQkl23jO2CDQ+/uDYoVmmOZfXTPnzWnWbGn1VadhStzIPHmvP5uZr4CG+
         zlIb5IPVyDhM94Pf8zLIj+f8+JyBIvmXdLzi/yONYDV0usHStXU5KYOW00La48uCkC0F
         CJ2St+t+cFP1nsS9fuME0NIpMRqfH9QTC0xDTsCkso1kRSkzT45yq7Vucw/QsMmSkd8U
         dqj/hXQjFdX/oZapimwXOiEcDvgvuRQGPwPDm4vOBtJZZrjG4ajHgXMAPsold+AAfEhf
         RHUok3KCGi3P+bWdcrAhJXQomoAlgI2QPPYmBw4GDrbTgnDg+YAu+Jf4jvQiD9j5NKIv
         0LfQ==
X-Gm-Message-State: ACgBeo0RiK0tNdBaAYatwbWmeooDgyhUulTcDP+fTpv3kres8lUwu16c
        wxJoquOFvgR50NW5hf/6iRNMxYp/f846Dl+gjPWRQh/UOz9Y
X-Google-Smtp-Source: AA6agR5Hjz2xwv/dtmvPhpLiGCsPp2aHTUFCJv4E/zItJc9o+fq3jTi87/5LeY5X73yA8wURTG51x2rJZzL6GNds3OFLNd+frMkA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3588:b0:346:b8ba:1260 with SMTP id
 v8-20020a056638358800b00346b8ba1260mr116712jal.85.1660639294979; Tue, 16 Aug
 2022 01:41:34 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:41:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004701b205e657b773@google.com>
Subject: [syzbot] upstream boot error: general protection fault in device_create
From:   syzbot <syzbot+83174867af1448d2e62b@syzkaller.appspotmail.com>
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

HEAD commit:    6c833c0581f1 Merge tag 'devicetree-fixes-for-6.0-1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138a2f05080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f83c035536d7b2e3
dashboard link: https://syzkaller.appspot.com/bug?extid=83174867af1448d2e62b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83174867af1448d2e62b@syzkaller.appspotmail.com

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
vcan: Virtual CAN interface driver
vxcan: Virtual CAN Tunnel driver
slcan: serial line CAN interface driver
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
mkiss: AX.25 Multikiss, Hans Albas PE1AYX
AX.25: 6pack driver, Revision: 0.3.0
AX.25: bpqether driver version 004
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
PPP MPPE Compression module registered
NET: Registered PF_PPPOX protocol family
PPTP driver version 0.8.5
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit encapsulation enabled).
CSLIP: code copyright 1989 Regents of the University of California.
SLIP linefill/keepalive option.
hdlc: HDLC support module revision 1.22
LAPB Ethernet driver version 0.02
usbcore: registered new interface driver ath9k_htc
usbcore: registered new interface driver carl9170
usbcore: registered new interface driver ath6kl_usb
usbcore: registered new interface driver ar5523
usbcore: registered new interface driver ath10k_usb
usbcore: registered new interface driver rndis_wlan
mac80211_hwsim: initializing netlink
general protection fault, probably for non-canonical address 0xffff000100000400: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8200800002000-0xfff8200800002007]
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-syzkaller-14135-g6c833c0581f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:kmem_cache_alloc_trace+0x172/0x310 mm/slub.c:3282
Code: 84 d9 00 00 00 48 83 78 10 00 0f 84 ce 00 00 00 49 8b 2e 40 f6 c5 0f 0f 85 9f 01 00 00 40 84 ff 0f 84 98 01 00 00 41 8b 46 28 <49> 8b 5c 05 00 48 8d 4a 08 4c 89 e8 65 48 0f c7 4d 00 0f 94 c0 a8
RSP: 0000:ffffc900000678c0 EFLAGS: 00010202
RAX: 0000000000000400 RBX: 0000000000000dc0 RCX: 0000000000000000
RDX: 0000000000001ff8 RSI: 0000000000000dc0 RDI: ffff888012042001
RBP: 000000000003d910 R08: dffffc0000000000 R09: fffffbfff1c4ad5e
R10: fffffbfff1c4ad5e R11: 1ffffffff1c4ad5d R12: 0000000000000468
R13: ffff000100000000 R14: ffff888012042000 R15: 0000000000000dc0
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000ca8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 device_create_groups_vargs drivers/base/core.c:4176 [inline]
 device_create+0x11d/0x2e0 drivers/base/core.c:4236
 mac80211_hwsim_new_radio+0x34f/0x3de0 drivers/net/wireless/mac80211_hwsim.c:3821
 init_mac80211_hwsim+0x7b8/0xa08 drivers/net/wireless/mac80211_hwsim.c:5379
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
RSP: 0000:ffffc900000678c0 EFLAGS: 00010202
RAX: 0000000000000400 RBX: 0000000000000dc0 RCX: 0000000000000000
RDX: 0000000000001ff8 RSI: 0000000000000dc0 RDI: ffff888012042001
RBP: 000000000003d910 R08: dffffc0000000000 R09: fffffbfff1c4ad5e
R10: fffffbfff1c4ad5e R11: 1ffffffff1c4ad5d R12: 0000000000000468
R13: ffff000100000000 R14: ffff888012042000 R15: 0000000000000dc0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000ca8e000 CR4: 00000000003506e0
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
