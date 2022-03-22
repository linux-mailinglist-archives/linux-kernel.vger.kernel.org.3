Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B662F4E3EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiCVMuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiCVMtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:49:53 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA456464
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:48:21 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id g2-20020a056e02130200b002c837b25e60so2169669ilr.20
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WZuJsNtOgUuUItIem3kdpk66hAcMwq+RcKjKTBfuo0o=;
        b=v7K8e4gnsywYOr8a1PjFHGihmzEt+FegbF+VbUK9rvxb0ysezgV8TBYq0ZeWoVLV0e
         D7/Yf+E6vYMLbMjw3u1m4onU46DZab+OTOfhS3ozsAreWbLmdrntL+GUBwSJc9eSCc1x
         qxi+BpcNEEXsZIfA3xYmqWRMSaZJw53Wp/gdCJ8xNQhxHpwfcCDyfxHXMayWcG2Xf/ZK
         bHLBmqGIonIMKQ8oELrbA7wrVS4qdVHA9z70Q5Q1PzspxZdPT0wvybVe9pw9JfKND80w
         eZzgYJipo6r/+mKcH3hmmW6QrWXffqy4GNNM5ZKGmt2wedPnJLcIfA0pz4qH0qtfBFIQ
         drpw==
X-Gm-Message-State: AOAM5324IuXjJsZzlX8SvTqhYYf5ahfvKBp5eU1BXZJXJU7fKXUnOldZ
        un0sGgsb158RoCwLe8jS6tYjGj3qzXq6pGDuh31vzqCWGa5k
X-Google-Smtp-Source: ABdhPJyGS+2VYKEwbvq02g1k8kyiwrTONaR9rngaRO8J/OIyisT/6m3DpKgzQJBwi9zUtJzuoo/dLA/4dtbdr5/mSXEPEU1oj04B
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b09:b0:2c8:3fa3:d7a1 with SMTP id
 i9-20020a056e021b0900b002c83fa3d7a1mr1826881ilv.173.1647953301097; Tue, 22
 Mar 2022 05:48:21 -0700 (PDT)
Date:   Tue, 22 Mar 2022 05:48:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e547305dace07d4@google.com>
Subject: [syzbot] KASAN: use-after-free Read in diFree
From:   syzbot <syzbot+1964c915c8c3913b3d7a@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    91265a6da44d Add linux-next specific files for 20220303
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=156de84d700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
dashboard link: https://syzkaller.appspot.com/bug?extid=1964c915c8c3913b3d7a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1792d44d700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f47491700000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10467e9d700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12467e9d700000
console output: https://syzkaller.appspot.com/x/log.txt?x=14467e9d700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1964c915c8c3913b3d7a@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 180
jfs_mount: dbMount failed w/rc = -5
Mount JFS Failure: -5
jfs_mount failed w/return code = -5
loop0: detected capacity change from 0 to 180
jfs_mount: diMount failed w/rc = -5
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 3828 Comm: syz-executor115 Not tainted 5.17.0-rc6-next-20220303-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:diFree+0x17f/0x2660 fs/jfs/jfs_imap.c:871
Code: 00 48 8b 44 24 18 48 8b 68 80 4c 89 e8 48 c1 e8 0c 48 89 04 24 48 b8 00 00 00 00 00 fc ff df 4c 8d 65 04 4c 89 e2 48 c1 ea 03 <0f> b6 14 02 4c 89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 26
RSP: 0018:ffffc90003aff8e0 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: ffff88801ce21400 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82ce6625 RDI: ffff8880718883b0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff82cc0f85 R11: 0000000000000000 R12: 0000000000000004
R13: 0000000000000001 R14: ffffffff8a07aa60 R15: ffff8880718a2930
FS:  00005555569f3300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1e855c0720 CR3: 0000000072fcb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_evict_inode+0x392/0x470 fs/jfs/inode.c:155
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1744 [inline]
 iput.part.0+0x562/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 diFreeSpecial+0x73/0x100 fs/jfs/jfs_imap.c:548
 jfs_mount+0x1c1/0x7b0 fs/jfs/jfs_mount.c:207
 jfs_fill_super+0x5a4/0xc70 fs/jfs/super.c:560
 mount_bdev+0x34d/0x410 fs/super.c:1367
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3025 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3355
 do_mount fs/namespace.c:3368 [inline]
 __do_sys_mount fs/namespace.c:3576 [inline]
 __se_sys_mount fs/namespace.c:3553 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3553
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1e855ecdba
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe2176c5d8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe2176c640 RCX: 00007f1e855ecdba
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe2176c600
RBP: 00007ffe2176c600 R08: 00007ffe2176c640 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000020000260
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000004
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:diFree+0x17f/0x2660 fs/jfs/jfs_imap.c:871
Code: 00 48 8b 44 24 18 48 8b 68 80 4c 89 e8 48 c1 e8 0c 48 89 04 24 48 b8 00 00 00 00 00 fc ff df 4c 8d 65 04 4c 89 e2 48 c1 ea 03 <0f> b6 14 02 4c 89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 26
RSP: 0018:ffffc90003aff8e0 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: ffff88801ce21400 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82ce6625 RDI: ffff8880718883b0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff82cc0f85 R11: 0000000000000000 R12: 0000000000000004
R13: 0000000000000001 R14: ffffffff8a07aa60 R15: ffff8880718a2930
FS:  00005555569f3300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1e855c0720 CR3: 0000000072fcb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 48 8b             	add    %cl,-0x75(%rax)
   3:	44 24 18             	rex.R and $0x18,%al
   6:	48 8b 68 80          	mov    -0x80(%rax),%rbp
   a:	4c 89 e8             	mov    %r13,%rax
   d:	48 c1 e8 0c          	shr    $0xc,%rax
  11:	48 89 04 24          	mov    %rax,(%rsp)
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	4c 8d 65 04          	lea    0x4(%rbp),%r12
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	4c 89 e0             	mov    %r12,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85 26                	test   %esp,(%rsi)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
