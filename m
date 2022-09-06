Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C325AE5EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiIFKus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiIFKuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:50:24 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D1B7CA9D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:48:42 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so6373003ioz.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 03:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=SSNttRLoA6vKZf2pkuzHvScLFL9l/hldXTAeM9JeHkY=;
        b=ftF9bATpf1ep6/btMrpzvKazhN7HRdfG56VfBqHafZDYZhGMlqzlNWi9qV305Wa594
         Z0XfhEmakhCSXbvILoPDieHPxglGFJO2EpMLPUD6pxpaF/oIzS14xA8J4i0ZrAEH1PCN
         LF30uGbuKacZKNJ2TvFi0qYl960UJ4HN/2YBGksc6AYwg4uOb6hBXh2nW6olLpxy2p1c
         1c4+4rlmDyn6oX6Eqn8sFy7LanZGy12sKW9hafU0YOo15M739UmvQwRK5SgHnStUdyzX
         O21gaCXu7Zx0X/bSZr30Fw8Sxu+EywOrwp6IOwrzNkj6hs7nnEVhdOwTzXRYvc1nvcBl
         s8OA==
X-Gm-Message-State: ACgBeo3JS20XQXY8t5PauluVo0G0GN3VVMRA2MYiMquk0VSYuMMvPiVh
        /5G7QLRYXwaV5dxLcBpgpnEv44uihsn93VZ+ff2WiLldk+a2
X-Google-Smtp-Source: AA6agR4fdiNtiJ/6DhjawMfWRp0gbvfaGtBihNPDsvlNkkv6g5+HTy97AieU11klHFBCF7F1UyDlO4kXWQSWkGZRtERNu2A2FSjs
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2411:b0:346:86a0:d325 with SMTP id
 z17-20020a056638241100b0034686a0d325mr29065407jat.28.1662461307063; Tue, 06
 Sep 2022 03:48:27 -0700 (PDT)
Date:   Tue, 06 Sep 2022 03:48:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9172705e7ffef2e@google.com>
Subject: [syzbot] WARNING in static_key_slow_try_dec (3)
From:   syzbot <syzbot+b5d82a651b71cd8a75ab@syzkaller.appspotmail.com>
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

HEAD commit:    42cf58c272ee Merge tag 'tty-6.0-rc4' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10239be7080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=892a57667b7af6cf
dashboard link: https://syzkaller.appspot.com/bug?extid=b5d82a651b71cd8a75ab
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15065393080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b22817080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0cddb4889822/disk-42cf58c2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/86b24f0bd2f9/vmlinux-42cf58c2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5d82a651b71cd8a75ab@syzkaller.appspotmail.com

------------[ cut here ]------------
jump label: negative count!
WARNING: CPU: 1 PID: 3629 at kernel/jump_label.c:235 static_key_slow_try_dec+0xca/0xe0 kernel/jump_label.c:235
Modules linked in:
CPU: 1 PID: 3629 Comm: syz-executor307 Not tainted 6.0.0-rc3-syzkaller-00328-g42cf58c272ee #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:static_key_slow_try_dec+0xca/0xe0 kernel/jump_label.c:235
Code: 5d c3 e8 79 16 d9 ff 45 31 ed 5b 44 89 e8 5d 41 5c 41 5d c3 44 89 e5 eb 8e e8 62 16 d9 ff 48 c7 c7 60 b8 f6 89 e8 c3 68 97 07 <0f> 0b eb c5 48 89 df e8 1a 76 25 00 e9 6a ff ff ff 0f 1f 44 00 00
RSP: 0018:ffffc900038af078 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff915443a0 RCX: 0000000000000000
RDX: ffff88801dee5880 RSI: ffffffff8161f408 RDI: fffff52000715e01
RBP: 00000000ffffffff R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 00000000ffffffff
R13: ffff888012709601 R14: 0000000000000001 R15: ffff888012709628
FS:  0000555555620300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe1aacdaf8 CR3: 000000001ce9e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __static_key_slow_dec_cpuslocked kernel/jump_label.c:243 [inline]
 __static_key_slow_dec kernel/jump_label.c:255 [inline]
 static_key_slow_dec+0x5c/0xc0 kernel/jump_label.c:270
 nf_tables_chain_destroy+0x250/0x640 net/netfilter/nf_tables_api.c:1880
 nf_tables_addchain.constprop.0+0xc56/0x16e0 net/netfilter/nf_tables_api.c:2329
 nf_tables_newchain+0x16d1/0x1ef0 net/netfilter/nf_tables_api.c:2593
 nfnetlink_rcv_batch+0x1721/0x2600 net/netfilter/nfnetlink.c:517
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:638 [inline]
 nfnetlink_rcv+0x3af/0x420 net/netfilter/nfnetlink.c:656
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f136a7cf0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe1aacdb18 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f136a7cf0c9
RDX: 0000000000000000 RSI: 000000002000c2c0 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe1aacdb30
R13: 00000000000f4240 R14: 000000000000b1ac R15: 00007ffe1aacdb24
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
