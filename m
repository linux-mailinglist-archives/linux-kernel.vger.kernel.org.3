Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E992B5AE74D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiIFMKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiIFMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:10:38 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04478785B8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:10:37 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id m12-20020a056e021c2c00b002ed9189c241so9285980ilh.15
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 05:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=s9sgjAT2DoCoQySsoB0+MNF8f2YY88ZBUJcW3Jrtwx0=;
        b=YmIanJi+wRra31bgya55CWVkZWsyH5XgBkQWdyMcOzhuItoaAQ9vYJQmSnFvlR5si4
         ZfexSC64NDqJKRUyutUo3WcH0TL8mmW39HcfJZlNjecfZ+2JAUi1PA+B8n/RYSV88LlL
         RnXgzXLno/VmNvyJXhjW9528KeCs3f9C0mVldjRFcqmT4+3roqZzxg2ShlmCsdvkB52Z
         MYpdBdcecP80oy8gBwEAw30I0Qp4J1XXt5Z8Ueb0yzwboZ4Z55PhfN3oh4J24YO7HrIc
         NBLNz+0ZbbGXgvOg95Re0za0a6Jzr6X40pGZN0/3knU/gy5kQzF7NuYgllR1sKjcK1jK
         td+A==
X-Gm-Message-State: ACgBeo08aRm44MhsU+e9jTRNv9jfEPaa888ZzJB7P67TS7SFqMeClOw3
        +/Ew3s3JnprL0ztGZL3+EY7BDqEAGe+T1lNxh4ijJGVrOlpb
X-Google-Smtp-Source: AA6agR4MMJtjkCKxW0W2aosx5MEQmWhFbjQaIYPdv/4T1quWOlCg8EPS/5z9fFGVPkU697s7aM6kct//kfF6ZZBpklP/qU7fPgEZ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1784:b0:688:1e28:1159 with SMTP id
 y4-20020a056602178400b006881e281159mr24780762iox.130.1662466237279; Tue, 06
 Sep 2022 05:10:37 -0700 (PDT)
Date:   Tue, 06 Sep 2022 05:10:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086363205e80115b3@google.com>
Subject: [syzbot] WARNING in __static_key_slow_dec_cpuslocked (2)
From:   syzbot <syzbot+9d7e953bf083b9cdd1cf@syzkaller.appspotmail.com>
To:     ardb@kernel.org, jbaron@akamai.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    85413d1e802e Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10b4accd080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57b9bfeca947ab90
dashboard link: https://syzkaller.appspot.com/bug?extid=9d7e953bf083b9cdd1cf
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a60a93080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d4fee5080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d7e953bf083b9cdd1cf@syzkaller.appspotmail.com

------------[ cut here ]------------
jump label: negative count!
WARNING: CPU: 0 PID: 3047 at kernel/jump_label.c:235 static_key_slow_try_dec kernel/jump_label.c:235 [inline]
WARNING: CPU: 0 PID: 3047 at kernel/jump_label.c:235 __static_key_slow_dec_cpuslocked+0x100/0x138 kernel/jump_label.c:243
Modules linked in:
CPU: 0 PID: 3047 Comm: syz-executor163 Not tainted 6.0.0-rc3-syzkaller-16800-g85413d1e802e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : static_key_slow_try_dec kernel/jump_label.c:235 [inline]
pc : __static_key_slow_dec_cpuslocked+0x100/0x138 kernel/jump_label.c:243
lr : static_key_slow_try_dec kernel/jump_label.c:235 [inline]
lr : __static_key_slow_dec_cpuslocked+0x100/0x138 kernel/jump_label.c:243
sp : ffff80001280b5b0
x29: ffff80001280b5b0 x28: ffff0000c44f4a28 x27: ffff80000c558398
x26: ffff0000c44f4a00 x25: 0000000073b034da x24: ffff0000c44f4a28
x23: dead000000000122 x22: ffff0000c44f4a28 x21: 00000000ffffffff
x20: 00000000ffffffff x19: ffff80000f1ac0a8 x18: 00000000000000c0
x17: ffff80000dd7a698 x16: ffff80000dbb8658 x15: ffff0000c4ff9a80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c4ff9a80
x11: ff808000081c39d0 x10: 0000000000000000 x9 : ea048c7203ed0000
x8 : ea048c7203ed0000 x7 : ffff800008197c80 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 000000000000001b
Call trace:
 static_key_slow_try_dec kernel/jump_label.c:235 [inline]
 __static_key_slow_dec_cpuslocked+0x100/0x138 kernel/jump_label.c:243
 __static_key_slow_dec kernel/jump_label.c:255 [inline]
 static_key_slow_dec+0x40/0x78 kernel/jump_label.c:270
 nf_tables_chain_destroy+0x1b4/0x210 net/netfilter/nf_tables_api.c:1880
 nf_tables_addchain net/netfilter/nf_tables_api.c:2329 [inline]
 nf_tables_newchain+0xe8c/0xe90 net/netfilter/nf_tables_api.c:2593
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:517 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:638 [inline]
 nfnetlink_rcv+0x734/0xd54 net/netfilter/nfnetlink.c:656
 netlink_unicast_kernel+0xfc/0x1bc net/netlink/af_netlink.c:1319
 netlink_unicast+0x164/0x238 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x484/0x574 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg net/socket.c:734 [inline]
 ____sys_sendmsg+0x308/0x450 net/socket.c:2482
 ___sys_sendmsg net/socket.c:2536 [inline]
 __sys_sendmsg+0x1ac/0x228 net/socket.c:2565
 __do_sys_sendmsg net/socket.c:2574 [inline]
 __se_sys_sendmsg net/socket.c:2572 [inline]
 __arm64_sys_sendmsg+0x2c/0x3c net/socket.c:2572
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 534
hardirqs last  enabled at (533): [<ffff8000081c1c3c>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
hardirqs last disabled at (534): [<ffff80000c000f0c>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (518): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (493): [<ffff800008104658>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (493): [<ffff800008104658>] invoke_softirq+0x70/0xbc kernel/softirq.c:452
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
