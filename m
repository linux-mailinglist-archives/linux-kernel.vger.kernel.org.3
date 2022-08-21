Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001D959B283
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 09:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiHUHE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 03:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiHUHE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 03:04:26 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA77DF28
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 00:04:25 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id t7-20020a6b6407000000b00684ed320f97so4309427iog.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 00:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=3hgFHCwj+5jXbTMyqbsuac4UCbcOea2qM5naHaX8xys=;
        b=QkI+GGEE1yytRgm8Qh3vHK5TlAJa0687E2lsy56NGA/nk6v8n2AphUscCVP70cTHNA
         2/4r+HpfOkSSRV7UbJAvbgqfmH5FNVx07Fzy08+z+tFIRlnpZ8duPnGZ+8Pgo5fu/lWZ
         Dp5QpVG603WyqfoyJIS7SD58RiNolYEuoe5hMEu8o9iI60S3/sGs0Xs+6OzGNsb2YWlm
         t3FAp9cMBYF70TTcINJuNrgVQiiUEEMSN3D8arRUmz5FnBpg4Pr/g/rCF8xiF59E4H5N
         WPf/i3Fn4HfU+zaxv/Fl4HC8FTgqSJIZd825jUktX998eyiltQBSdKGo+s2ElZdTIoeW
         yaqA==
X-Gm-Message-State: ACgBeo13oB0BVKawO9RfwKPu5mtSLjQQZZ9fZY4mLaz0LnGsqtSD2QEG
        8Ha3BBnFngNTAC3ppSY6ANDwVt5GIBJxvjGcdPb2thRK83ek
X-Google-Smtp-Source: AA6agR5DVgmF3oXhWNCIrlV0ltSGeF5Juyh1mROXCtdaURjcJMvarD91JlswDoi8qIS35pffXJgOW9Vzu4BWQhPeHM/FPKFC3SiE
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1593:b0:689:b4e7:7e21 with SMTP id
 e19-20020a056602159300b00689b4e77e21mr1844189iow.151.1661065464871; Sun, 21
 Aug 2022 00:04:24 -0700 (PDT)
Date:   Sun, 21 Aug 2022 00:04:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb7fc005e6baf0f3@google.com>
Subject: [syzbot] general protection fault in sanity_check_pinned_pages
From:   syzbot <syzbot+c14f12d4b695168145b0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    95d10484d66e Add linux-next specific files for 20220817
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=175b81d3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f5fa747986be53a
dashboard link: https://syzkaller.appspot.com/bug?extid=c14f12d4b695168145b0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e24b5080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f105f3080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c14f12d4b695168145b0@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 3608 Comm: syz-executor314 Not tainted 6.0.0-rc1-next-20220817-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:_compound_head include/linux/page-flags.h:253 [inline]
RIP: 0010:sanity_check_pinned_pages+0x25e/0xec0 mm/gup.c:52
Code: a2 06 00 00 e8 f3 8a c9 ff 4c 89 f0 48 c1 e8 03 80 3c 18 00 0f 85 8e 0a 00 00 4d 8b 26 49 8d 44 24 08 48 89 04 24 48 c1 e8 03 <80> 3c 18 00 0f 85 8b 0a 00 00 49 8b 6c 24 08 31 ff 49 89 ef 41 83
RSP: 0018:ffffc900039df6d0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffff88802763bb00 RSI: ffffffff81b28a5d RDI: 0000000000000007
RBP: 000000000000034e R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffffc900039df7c8 R15: 0000000000000000
FS:  00007fc2d0fe9700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001600 CR3: 0000000076052000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 unpin_user_pages_dirty_lock mm/gup.c:311 [inline]
 unpin_user_pages_dirty_lock+0x4a/0x4c0 mm/gup.c:299
 rds_rdma_free_op+0x28d/0x3c0 net/rds/rdma.c:501
 rds_cmsg_rdma_args+0x32c/0x1540 net/rds/rdma.c:797
 rds_cmsg_send net/rds/send.c:1005 [inline]
 rds_sendmsg+0x1c5c/0x3040 net/rds/send.c:1316
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc2d1036e39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc2d0fe9308 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc2d10bf408 RCX: 00007fc2d1036e39
RDX: 0000000000000000 RSI: 0000000020001600 RDI: 0000000000000004
RBP: 00007fc2d10bf400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc2d10bf40c
R13: 00007fc2d108d004 R14: 632e79726f6d656d R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:253 [inline]
RIP: 0010:sanity_check_pinned_pages+0x25e/0xec0 mm/gup.c:52
Code: a2 06 00 00 e8 f3 8a c9 ff 4c 89 f0 48 c1 e8 03 80 3c 18 00 0f 85 8e 0a 00 00 4d 8b 26 49 8d 44 24 08 48 89 04 24 48 c1 e8 03 <80> 3c 18 00 0f 85 8b 0a 00 00 49 8b 6c 24 08 31 ff 49 89 ef 41 83
RSP: 0018:ffffc900039df6d0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffff88802763bb00 RSI: ffffffff81b28a5d RDI: 0000000000000007
RBP: 000000000000034e R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffffc900039df7c8 R15: 0000000000000000
FS:  00007fc2d0fe9700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002034d000 CR3: 0000000076052000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	a2 06 00 00 e8 f3 8a 	movabs %al,0xffc98af3e8000006
   7:	c9 ff
   9:	4c 89 f0             	mov    %r14,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  14:	0f 85 8e 0a 00 00    	jne    0xaa8
  1a:	4d 8b 26             	mov    (%r14),%r12
  1d:	49 8d 44 24 08       	lea    0x8(%r12),%rax
  22:	48 89 04 24          	mov    %rax,(%rsp)
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
  2e:	0f 85 8b 0a 00 00    	jne    0xabf
  34:	49 8b 6c 24 08       	mov    0x8(%r12),%rbp
  39:	31 ff                	xor    %edi,%edi
  3b:	49 89 ef             	mov    %rbp,%r15
  3e:	41                   	rex.B
  3f:	83                   	.byte 0x83


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
