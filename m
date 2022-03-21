Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33214E31EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353414AbiCUUjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346616AbiCUUjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:39:00 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD01117336B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:37:33 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id g2-20020a056e02130200b002c837b25e60so1159149ilr.20
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SUwtGSAW8MMzqRMHGMLu+LQIXzYxE9UsH0DlufN6LeU=;
        b=nPQWqYXNHnsh8exI/ML0gCh67cO2f2FF6s/sykJj6Vb2FJMiOr8A2Rt10iZY/8JL17
         eXeA4kQJaznbHQbEBoIw/QB69tLzkEI72Ec625Oh8+/nyFT9zHPgXcK6y02yy2nm1CnS
         5Ru4uh/KTdBD5ybHTZWIX4TXd2Li+6FOLoDqkGfxRcBF4yEeGNNlex0ZNtAEIAqlKtGm
         jyb0bSsYmcYoMkg5kKEdglRBzFfz4wl0ADX9cAc+npllSRK0EQ/F/yZREMJ5Yhv8qnaS
         dBZAqkYz92CcoWmY1d3lITok3boZWgD2mtiAFPso0VkfQUwKFO+Kp14/6pGAgS1zr422
         qwAg==
X-Gm-Message-State: AOAM532Tj6p7ifXuKiMlYfDXWvz5GZduxWN2CwS1YeMALnGRYb7c8d8O
        0mCLvMSPKAPl2Mj8pm3L6EAt2w3N6333eBtL0gsaWXOdOsUc
X-Google-Smtp-Source: ABdhPJwKTDzyXORVwoKfIj+AtNMIGVq2e/lKaKXQhn+gh8RogL9w1Z6Eaua0SIjw8/7Q4P/D64l7R6CLqB+u1eZUhMRKngWlKXjs
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148d:b0:2c8:a1a:ab98 with SMTP id
 n13-20020a056e02148d00b002c80a1aab98mr6684829ilk.194.1647895053265; Mon, 21
 Mar 2022 13:37:33 -0700 (PDT)
Date:   Mon, 21 Mar 2022 13:37:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046f08405dac07714@google.com>
Subject: [syzbot] WARNING in blk_release_queue
From:   syzbot <syzbot+bd9d63403ded496c6d3c@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    f9006d9269ea Add linux-next specific files for 20220321
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1768caeb700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1619ffa2b0259a1
dashboard link: https://syzkaller.appspot.com/bug?extid=bd9d63403ded496c6d3c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd9d63403ded496c6d3c@syzkaller.appspotmail.com

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=2 set at [<ffffffff815a3faa>] prepare_to_wait_exclusive+0x7a/0x2b0 kernel/sched/wait.c:286
WARNING: CPU: 1 PID: 5480 at kernel/sched/core.c:9689 __might_sleep+0x105/0x150 kernel/sched/core.c:9689
Modules linked in:
CPU: 1 PID: 5480 Comm: syz-executor.3 Tainted: G        W         5.17.0-next-20220321-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__might_sleep+0x105/0x150 kernel/sched/core.c:9689
Code: 70 02 00 48 8d bb f8 16 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 75 34 48 8b 93 f8 16 00 00 48 c7 c7 60 dc cb 89 e8 67 74 c8 07 <0f> 0b e9 75 ff ff ff e8 4f 37 73 00 e9 26 ff ff ff 89 34 24 e8 52
RSP: 0018:ffffc900001e0d88 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88801c178000 RCX: 0000000000000000
RDX: ffff88801c178000 RSI: ffffffff815fc918 RDI: fffff5200003c1a3
RBP: ffffffff8a2485c0 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff815f72de R11: 0000000000000000 R12: 00000000000002fe
R13: 0000000000000000 R14: ffffffff8a2489c0 R15: 0000000000000000
FS:  00007f37479ec700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000c000 CR3: 000000007c560000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 blk_release_queue+0x1f/0x320 block/blk-sysfs.c:766
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 blkg_free.part.0+0x112/0x1f0 block/blk-cgroup.c:86
 blkg_free block/blk-cgroup.c:78 [inline]
 __blkg_release+0x105/0x160 block/blk-cgroup.c:102
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x7b1/0x1880 kernel/rcu/tree.c:2786
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 do_softirq.part.0+0xde/0x130 kernel/softirq.c:459
 </IRQ>
 <TASK>
 do_softirq kernel/softirq.c:451 [inline]
 __local_bh_enable_ip+0x102/0x120 kernel/softirq.c:383
 spin_unlock_bh include/linux/spinlock.h:399 [inline]
 __lock_sock+0x138/0x260 net/core/sock.c:2769
 lock_sock_nested+0xd6/0xf0 net/core/sock.c:3317
 lock_sock include/net/sock.h:1682 [inline]
 sk_wait_data+0x20a/0x450 net/core/sock.c:2836
 tcp_recvmsg_locked+0xe28/0x1fd0 net/ipv4/tcp.c:2459
 tcp_recvmsg+0x137/0x610 net/ipv4/tcp.c:2574
 inet_recvmsg+0x11b/0x5e0 net/ipv4/af_inet.c:850
 sock_recvmsg_nosec net/socket.c:948 [inline]
 sock_recvmsg net/socket.c:966 [inline]
 sock_recvmsg net/socket.c:962 [inline]
 ____sys_recvmsg+0x2c4/0x600 net/socket.c:2632
 ___sys_recvmsg+0x127/0x200 net/socket.c:2674
 __sys_recvmsg+0xe2/0x1a0 net/socket.c:2704
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3746889049
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f37479ec168 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00007f374699c030 RCX: 00007f3746889049
RDX: 0000000000000100 RSI: 0000000020001500 RDI: 0000000000000003
RBP: 00007f37468e308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd774bdcef R14: 00007f37479ec300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
