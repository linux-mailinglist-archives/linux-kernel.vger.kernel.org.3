Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8860B582632
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiG0MOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiG0MOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:14:15 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0555948C91
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:14:11 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i8-20020a056e020d8800b002d931252904so11065528ilj.23
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gj/P/30fw4zjHLH7ZgeJF47IBW/9lA9dOUxITMmthjo=;
        b=1v9eWeZrQKAu7g+eWQe82vo9JRGx+aCs5LEuG7PdJN7ZyiVJ+V8TYZXlZM6kTBl1EZ
         hg8yzMUh7lSosWiF1W5rCjFErAGMg+tqb7cDhMr0sR9wSN2JT3AV6UTGdiroG7UCvMnN
         yyRxGN5ppqHqSbAnbVSs9orAXhbOEupUVrU+MNnD+T6xlxgnc0ysc4m/lz6bIRaPTFmh
         LiDV65VP8hMeYkehQ0Hk12aWDbkxU0OceA+2Ec5aADtWpcvUt3/hXL4iZN+ZblxaPHDF
         tJO7+ATfj9LTYaXH0wxGu50IWTYoOcCg3lr6aHFOuduVqkIfZI9yzqYYUaolp4Hk5E7+
         /xMg==
X-Gm-Message-State: AJIora/E2AvAODFhemZt+Lopd/JlPJwIi18V3oqZyxdBSiMR9CxdTfON
        U4Xn/6FWsY5X1pCSvxIVxZUr7oaC2Dzi8xK9Ivb1H6gNha4Y
X-Google-Smtp-Source: AGRyM1s2LMMBrGm5WrYdmOQynTAAEmpdQH7YbRzzo4cGZirpHR88IxnGx5rtYblJ91FpxtD13B+b0VK/7vFDnTkF2G0PrWFzo8W1
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c05:b0:2dc:26e3:a758 with SMTP id
 l5-20020a056e021c0500b002dc26e3a758mr8827518ilh.133.1658924050394; Wed, 27
 Jul 2022 05:14:10 -0700 (PDT)
Date:   Wed, 27 Jul 2022 05:14:10 -0700
In-Reply-To: <20220727120100.2928-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbb5e305e4c85a51@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in net_tx_action
From:   syzbot <syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __do_softirq

hrtimer: interrupt took 5497694 ns
------------[ cut here ]------------
softirq hog NET_TX
WARNING: CPU: 0 PID: 5925 at kernel/softirq.c:564 __do_softirq+0x3c2/0xb44 kernel/softirq.c:564
Modules linked in:
CPU: 0 PID: 5925 Comm: syz-executor.0 Not tainted 5.13.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:__do_softirq+0x3c2/0xb44 kernel/softirq.c:564
Code: 00 00 fc ff df 48 89 f8 48 c1 e8 03 80 3c 08 00 0f 85 25 07 00 00 4a 8b 34 ed e0 5b 6a 89 48 c7 c7 80 56 6a 89 e8 e9 7b 95 ff <0f> 0b e9 12 fe ff ff 65 8b 15 98 91 c1 76 83 fa 07 0f 87 94 04 00
RSP: 0018:ffffc90000007f78 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff8b40a0d0 RCX: 0000000000000000
RDX: ffff888018ea9c40 RSI: ffffffff815ce2a5 RDI: fffff52000000fe1
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815c810e R11: 0000000000000000 R12: 0000000000000101
R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000081
FS:  00007fe124111700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000051e370 CR3: 0000000011c93000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 do_softirq.part.0+0xd9/0x130 kernel/softirq.c:460
 </IRQ>
 do_softirq kernel/softirq.c:452 [inline]
 __local_bh_enable_ip+0x102/0x120 kernel/softirq.c:384
 spin_unlock_bh include/linux/spinlock.h:399 [inline]
 taprio_change+0x272d/0x4030 net/sched/sch_taprio.c:1641
 taprio_init+0x52e/0x670 net/sched/sch_taprio.c:1759
 qdisc_create+0x475/0x1310 net/sched/sch_api.c:1247
 tc_modify_qdisc+0x4c8/0x1a50 net/sched/sch_api.c:1663
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5566
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:674
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2337
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2391
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2420
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe124111188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007fff8efb607f R14: 00007fe124111300 R15: 0000000000022000


Tested on:

commit:         d6765985 Revert "be2net: disable bh with spin_lock in ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11b32102080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d43f3e8616689bf
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c6b35a080000

