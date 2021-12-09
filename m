Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E41746F385
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhLITBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:01:00 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:41518 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhLITA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:00:59 -0500
Received: by mail-il1-f198.google.com with SMTP id r1-20020a92cd81000000b002a3ae5f6ad9so8125755ilb.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 10:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/jThWv1+SPBGbAQPgT8sXYErXG2da2eSKsxQaEVinZw=;
        b=uRtrGL6qjqxSQBFGj1mjBU1Zmn8xMnvOxNNUbMdh7pqRaTXeaPDGZ/dICl2o8Umi/+
         1vZw6Swh603UJBWusmu++tcdktmyxrLW50SAj2pRGD7v2l1+Q9eijBKwODDGBNUxHYrn
         fV7dB67ebGQaTiYpt+/QCkvq2wbwnP6f74+9UIYf1dhHELHleXEi4FXcarsdf94ykKbD
         xi3pneLaWqzfzZt/qEzD/fczHtij3LDzLW01QO8RFhPSZ3bWim4tM9bi83/TxUblQGxs
         x824dTHgbyLKEGr3FXP/Zew+M7s4+AyevzoIS5+RAUwM+npclG6y1BMgqZBonImZK7Rh
         PC/w==
X-Gm-Message-State: AOAM532QL96vSjIofUND56XkATdWU0NDGVKt0hh1VCgV0a/dDE9ZQPbW
        aOUkIS2Rle/FmsrLNAMwm5XFGtyxkJ7xxDOp8uT3djHZJLn4
X-Google-Smtp-Source: ABdhPJz82AA/+SMk0aKZyWv6ABiSNqDw7paWLHJE6pw01mtk/Hvb3p7U0DB2vG49SJH4XwOflwBoFMRX3Lj/AOASDzGt5B8EIJ0q
MIME-Version: 1.0
X-Received: by 2002:a6b:7711:: with SMTP id n17mr15974209iom.21.1639076245171;
 Thu, 09 Dec 2021 10:57:25 -0800 (PST)
Date:   Thu, 09 Dec 2021 10:57:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a735005d2bb2dff@google.com>
Subject: [syzbot] KMSAN: uninit-value in fib_get_nhs
From:   syzbot <syzbot+d4b9a2851cc3ce998741@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, glider@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8b936c96768e kmsan: core: remove the accidentally committe..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1724ebc5b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e00a8959fdd3f3e8
dashboard link: https://syzkaller.appspot.com/bug?extid=d4b9a2851cc3ce998741
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1225f875b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139513c5b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4b9a2851cc3ce998741@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in fib_get_nhs+0xac4/0x1f80 net/ipv4/fib_semantics.c:708
 fib_get_nhs+0xac4/0x1f80 net/ipv4/fib_semantics.c:708
 fib_create_info+0x2411/0x4870 net/ipv4/fib_semantics.c:1453
 fib_table_insert+0x45c/0x3a10 net/ipv4/fib_trie.c:1224
 inet_rtm_newroute+0x289/0x420 net/ipv4/fib_frontend.c:886
 rtnetlink_rcv_msg+0x145d/0x18c0 net/core/rtnetlink.c:5571
 netlink_rcv_skb+0x447/0x800 net/netlink/af_netlink.c:2491
 rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:5589
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x1095/0x1360 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x16f3/0x1870 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg net/socket.c:724 [inline]
 ____sys_sendmsg+0xe11/0x12c0 net/socket.c:2409
 ___sys_sendmsg net/socket.c:2463 [inline]
 __sys_sendmsg+0x4a5/0x640 net/socket.c:2492
 __do_sys_sendmsg net/socket.c:2501 [inline]
 __se_sys_sendmsg net/socket.c:2499 [inline]
 __x64_sys_sendmsg+0xe2/0x120 net/socket.c:2499
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3251 [inline]
 __kmalloc_node_track_caller+0xe0c/0x1510 mm/slub.c:4974
 kmalloc_reserve net/core/skbuff.c:354 [inline]
 __alloc_skb+0x545/0xf90 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1126 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1191 [inline]
 netlink_sendmsg+0xe93/0x1870 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg net/socket.c:724 [inline]
 ____sys_sendmsg+0xe11/0x12c0 net/socket.c:2409
 ___sys_sendmsg net/socket.c:2463 [inline]
 __sys_sendmsg+0x4a5/0x640 net/socket.c:2492
 __do_sys_sendmsg net/socket.c:2501 [inline]
 __se_sys_sendmsg net/socket.c:2499 [inline]
 __x64_sys_sendmsg+0xe2/0x120 net/socket.c:2499
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

CPU: 0 PID: 6371 Comm: syz-executor193 Not tainted 5.16.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
