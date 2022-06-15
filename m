Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7871154CB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245550AbiFOO1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiFOO1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:27:16 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D73145AF9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:27:15 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id 3-20020a056e0220c300b002d3d7ebdfdeso8480406ilq.16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Yo4PTJFoGtM62d5JgMwOMkLWOxxz//twxnpdMmSykWI=;
        b=MuXybgEhHrJoIy865xa/A0FfLKxxLKeIKvmkymhft1bWIMRC/id70v+Mf1IVyJz51S
         mO3/x0zqNpKl+yIcF4dk+DV75Bjw+0SAXwAErMG27d+j/cgWnupnORaPQcCBKiGTks+T
         OCxYdpUxcPCnHF5wq+8Xstm14YynqQ3HYHXfcRAiSrkl1b+dZe72Mr9plHIhBBFm+4G4
         u9udUliAeoaIeyuDSUX7TuZjtB2CL9mp6uktCI/vX1oLYPZ4B/gnFJxTYJRWxjwvDoEW
         zOL2qqAyX5s2vP/sZofPb9B0IlYfHlHpESl9FFmn5oP329P9bnXcf73PCmzd2EURr8nZ
         e+gA==
X-Gm-Message-State: AJIora8WeFdEnihyN/rdEh9UT4zVocj7Y9eLsJBxbzLJJEJqp2dcJJ0I
        M11ny+6B1pJWCvx7o3jyKtryrVV3rTUH5/Rh2ooigJgIb44J
X-Google-Smtp-Source: AGRyM1voVSEhmDDGfTNmd9pcR+JIEkwuOkLcTDJNmvWp3XmBb93qo6bPSTD8gPRwunTg8hoA7V8MeDOQHK0ucLQycv8X6BkEsasX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:2d3:d69a:6d88 with SMTP id
 l8-20020a056e021aa800b002d3d69a6d88mr40598ilv.243.1655303234877; Wed, 15 Jun
 2022 07:27:14 -0700 (PDT)
Date:   Wed, 15 Jun 2022 07:27:14 -0700
In-Reply-To: <20220615140453.2269-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f7edf05e17d5146@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in route4_destroy
From:   syzbot <syzbot+2e3efb5eb71cb5075ba7@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: ODEBUG bug in route4_destroy

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 4134 at lib/debugobjects.c:502 debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Modules linked in:
CPU: 0 PID: 4134 Comm: syz-executor.0 Not tainted 5.19.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd e0 c5 27 8a 4c 89 ee 48 c7 c7 c0 b9 27 8a e8 f6 1b 30 05 <0f> 0b 83 05 35 22 c5 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc900031befb0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff888025440000 RSI: ffffffff815fcd08 RDI: fffff52000637de8
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffffffff89cde060
R13: ffffffff8a27c080 R14: 0000000000000000 R15: ffffffff89cde060
FS:  00007f1daf655700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1daf634718 CR3: 0000000024a07000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_activate+0x2da/0x3e0 lib/debugobjects.c:674
 debug_rcu_head_queue kernel/rcu/rcu.h:178 [inline]
 call_rcu+0x2c/0x790 kernel/rcu/tree.c:3111
 queue_rcu_work+0x82/0xa0 kernel/workqueue.c:1774
 route4_queue_work net/sched/cls_route.c:279 [inline]
 route4_destroy+0x4e7/0x9d0 net/sched/cls_route.c:306
 tcf_proto_destroy+0x6a/0x2d0 net/sched/cls_api.c:314
 tcf_proto_put+0x8c/0xc0 net/sched/cls_api.c:326
 tcf_chain_flush+0x21a/0x360 net/sched/cls_api.c:632
 tcf_block_flush_all_chains net/sched/cls_api.c:1034 [inline]
 __tcf_block_put+0x15a/0x510 net/sched/cls_api.c:1196
 tcf_block_put_ext net/sched/cls_api.c:1396 [inline]
 tcf_block_put+0xb3/0x100 net/sched/cls_api.c:1411
 drr_destroy_qdisc+0x44/0x1d0 net/sched/sch_drr.c:455
 qdisc_destroy+0xc4/0x4e0 net/sched/sch_generic.c:1067
 qdisc_put+0xcd/0xe0 net/sched/sch_generic.c:1086
 notify_and_destroy net/sched/sch_api.c:1012 [inline]
 qdisc_graft+0xeb1/0x1270 net/sched/sch_api.c:1084
 tc_modify_qdisc+0xbb7/0x1a00 net/sched/sch_api.c:1671
 rtnetlink_rcv_msg+0x43a/0xc90 net/core/rtnetlink.c:6089
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2492
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2546
 __sys_sendmsg net/socket.c:2575 [inline]
 __do_sys_sendmsg net/socket.c:2584 [inline]
 __se_sys_sendmsg net/socket.c:2582 [inline]
 __x64_sys_sendmsg+0x132/0x220 net/socket.c:2582
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1daf655188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665f9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffc31782fcf R14: 00007f1daf655300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         018ab4fa netfs: fix up netfs_inode_init() docbook comm..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=107ff687f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f21890d74080ef72
dashboard link: https://syzkaller.appspot.com/bug?extid=2e3efb5eb71cb5075ba7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1703e12ff00000

