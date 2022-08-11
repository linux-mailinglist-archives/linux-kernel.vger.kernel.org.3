Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9297F58F864
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbiHKHac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiHKHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:30:25 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BB75FAEE
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:30:24 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i12-20020a056e021d0c00b002df2d676974so11969865ila.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=9QocR199mkPVq/GgHt8+teP0PhBjbHEosob0+fChonA=;
        b=dsEooRGZRJ3nRu3L+ahe8yoEcyxzQfsyP1w14GHO6Iw66OZlnpAyuGX3NkXmomeNMO
         729xGXf0gQt2tU7GFubK6VvspjmEV1rqrzzZfDE7tDYfptu35aAbQyAkBQmdEr9p7r25
         AfhyHKM2Vtzem0jpS0dmZuhEo0ozPnWfkrC5zCs8hAo51K8PvHCS93UgsKG83dbn019C
         u0h9wmOdfEk7np7EgDUKfWyz9i+Y929gY8vZ0MoPWsKFb7zhvcWxxGLud3ygYzV+FVcd
         d9N+OCjjIYn7Mmm9LBFfdE3ms+gx+8hIQjjFsSll7obXoYN8/QRPDgb/UB/Ww+yHXJY8
         AXLw==
X-Gm-Message-State: ACgBeo173t5DseGpln4waxCG4pOb3n1/Ygqbsm8vWsI1RWkLf+D4RlRp
        AhabnQoeUXcY25ZQ96avFjJRJGpcYY5bVoVwcj/dJ6bz0crC
X-Google-Smtp-Source: AA6agR6vvwHX/K7gKjlAzesY1ybwiV5h4uilY0HAuXFgjjKlMID+RA0WJy8CxfGADrbfQ5JPD2QG7weCwTUpnZzlDhrqDmjRmjLv
MIME-Version: 1.0
X-Received: by 2002:a02:2718:0:b0:33f:7a76:baa4 with SMTP id
 g24-20020a022718000000b0033f7a76baa4mr14364801jaa.277.1660203023500; Thu, 11
 Aug 2022 00:30:23 -0700 (PDT)
Date:   Thu, 11 Aug 2022 00:30:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007891b705e5f2239b@google.com>
Subject: [syzbot] linux-next boot error: BUG: unable to handle kernel paging
 request in kobject_get
From:   syzbot <syzbot+47766a292ef15310f377@syzkaller.appspotmail.com>
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

HEAD commit:    40d43a7507e1 Add linux-next specific files for 20220811
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1469a753080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5ae8cfa8d7075d1
dashboard link: https://syzkaller.appspot.com/bug?extid=47766a292ef15310f377
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47766a292ef15310f377@syzkaller.appspotmail.com

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
BUG: unable to handle page fault for address: ffffdd1020000007
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11828067 P4D 11828067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-next-20220811-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:kobject_get+0x30/0x150 lib/kobject.c:623
Code: 53 e8 14 0b 5b fd 4d 85 e4 0f 84 a2 00 00 00 e8 06 0b 5b fd 49 8d 7c 24 3c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 e7 00 00 00
RSP: 0000:ffffc900000677e0 EFLAGS: 00010a03
RAX: dffffc0000000000 RBX: ffff88801f753800 RCX: 0000000000000000
RDX: 1fffe11020000007 RSI: ffffffff8420fafa RDI: ffff08810000003c
RBP: ffff888147a408a8 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff088100000000
R13: ffff888147a408f8 R14: 1ffff9200000cf09 R15: ffff088100000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdd1020000007 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 get_device drivers/base/core.c:3612 [inline]
 device_add+0x297/0x1e90 drivers/base/core.c:3437
 wiphy_register+0x1ee8/0x2a40 net/wireless/core.c:928
 ieee80211_register_hw+0x22a3/0x3eb0 net/mac80211/main.c:1379
 mac80211_hwsim_new_radio+0x255f/0x4dd0 drivers/net/wireless/mac80211_hwsim.c:4129
 init_mac80211_hwsim+0x5aa/0x73b drivers/net/wireless/mac80211_hwsim.c:5379
 do_one_initcall+0xfe/0x650 init/main.c:1299
 do_initcall_level init/main.c:1374 [inline]
 do_initcalls init/main.c:1390 [inline]
 do_basic_setup init/main.c:1409 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1616
 kernel_init+0x1a/0x1d0 init/main.c:1505
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffdd1020000007
---[ end trace 0000000000000000 ]---
RIP: 0010:kobject_get+0x30/0x150 lib/kobject.c:623
Code: 53 e8 14 0b 5b fd 4d 85 e4 0f 84 a2 00 00 00 e8 06 0b 5b fd 49 8d 7c 24 3c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 e7 00 00 00
RSP: 0000:ffffc900000677e0 EFLAGS: 00010a03
RAX: dffffc0000000000 RBX: ffff88801f753800 RCX: 0000000000000000
RDX: 1fffe11020000007 RSI: ffffffff8420fafa RDI: ffff08810000003c
RBP: ffff888147a408a8 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff088100000000
R13: ffff888147a408f8 R14: 1ffff9200000cf09 R15: ffff088100000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdd1020000007 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	53                   	push   %rbx
   1:	e8 14 0b 5b fd       	callq  0xfd5b0b1a
   6:	4d 85 e4             	test   %r12,%r12
   9:	0f 84 a2 00 00 00    	je     0xb1
   f:	e8 06 0b 5b fd       	callq  0xfd5b0b1a
  14:	49 8d 7c 24 3c       	lea    0x3c(%r12),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 08                	jg     0x40
  38:	84 c0                	test   %al,%al
  3a:	0f 85 e7 00 00 00    	jne    0x127


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
