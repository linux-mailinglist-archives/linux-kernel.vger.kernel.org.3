Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6E50EE84
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbiDZCLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiDZCLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:11:44 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853DD1F62E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:08:38 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id k2-20020a0566022a4200b00654c0f121a9so12748107iov.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CYKeawol8zncozAhsbHcli7CJbCkNgzXS+o7Jsn+zWs=;
        b=TXmlOXMCdWCSjk2e7DGrN0W0UDYm9RuiyNTVvUtQwrgmp96lL1NEAAXqkIe4olFnE9
         7/OXChC49q4pQM3Y8rZ1tnuvO0LHU9hGCi5QpLKsJcrtk5al03QSBbX8/CeAmoo8E2co
         DyjU9ahgueGMPBvz1dPZjRvNW1jbjWNcoYvrXw4PD67oJY8wq94K1CLaeQ4yz1/+kGkH
         KF0Q1CjPNRN/IXOJ1U7898405AM9YqsmtuE5dCHzFbMQljyclXPNyzqo/DBivYUVDsGh
         7e6q+ms20Hjm6vOLv7Fpe2kJq33exCe1QFNYzxstbLxW/TqxZGZ8sTs4YnaVdulqJCb8
         FXMw==
X-Gm-Message-State: AOAM532qBYyf49iEdZMsT+B3ly2STJoQCGsIiOEFXOo6Vr+J46JjnFqF
        l66QdpckE9HgF1Gl7klEgl+/teLzeBGJ0XNTIDE0H9W/q/jA
X-Google-Smtp-Source: ABdhPJyGzdcA8agiuJK3spkbO/Q29+8B2j8kOsOndrkWwYATEhs821uHeO4R+4fwqiudekKSrJCYDzFfkgXzYvpTqjeijyCtE6jd
MIME-Version: 1.0
X-Received: by 2002:a5d:88c7:0:b0:649:7b59:949c with SMTP id
 i7-20020a5d88c7000000b006497b59949cmr8714173iol.181.1650938917858; Mon, 25
 Apr 2022 19:08:37 -0700 (PDT)
Date:   Mon, 25 Apr 2022 19:08:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000beb14105dd852b6a@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in hsr_node_get_first
From:   syzbot <syzbot+d4de7030f60c07837e60@syzkaller.appspotmail.com>
To:     claudiajkang@gmail.com, davem@davemloft.net,
        ennoerlangen@gmail.com, george.mccollister@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    22da5264abf4 Merge tag '5.18-rc3-ksmbd-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177ed38af00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71bf5c8488a4e33a
dashboard link: https://syzkaller.appspot.com/bug?extid=d4de7030f60c07837e60
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15200242f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13437c44f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4de7030f60c07837e60@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
netlink: 'syz-executor156': attribute type 2 has an invalid length.
netlink: 194488 bytes leftover after parsing attributes in process `syz-executor156'.
=============================
WARNING: suspicious RCU usage
5.18.0-rc3-syzkaller-00235-g22da5264abf4 #0 Not tainted
-----------------------------
net/hsr/hsr_framereg.c:41 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by syz-executor156/3589:
 #0: ffffffff8d5ff210 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40 net/netlink/genetlink.c:802
 #1: ffffffff8d5ff2c8 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
 #1: ffffffff8d5ff2c8 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x3e0/0x580 net/netlink/genetlink.c:790
 #2: ffffffff8bd820e0 (rcu_read_lock){....}-{1:2}, at: hsr_get_node_list+0xcb/0xa80 net/hsr/hsr_netlink.c:425

stack backtrace:
CPU: 1 PID: 3589 Comm: syz-executor156 Not tainted 5.18.0-rc3-syzkaller-00235-g22da5264abf4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 hsr_node_get_first+0xc7/0xe0 net/hsr/hsr_framereg.c:41
 hsr_get_next_node+0x1d0/0x320 net/hsr/hsr_framereg.c:608
 hsr_get_node_list+0x333/0xa80 net/hsr/hsr_netlink.c:461
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:731
 genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
 genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:792
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2503
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x904/0xe00 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:705 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:725
 ____sys_sendmsg+0x6e2/0x800 net/socket.c:2413
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2467
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2496
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb779cfc8d9
Code: 28 c3 e8 4a 15 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe75a56d68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffe75a56d78 RCX: 00007fb779cfc8d9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 0000000000000003 R08: bb1414ac00000000 R09: bb1414ac00000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe75a56d80
R13: 00007ffe75a56d74 R14: 0000000000000003 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
