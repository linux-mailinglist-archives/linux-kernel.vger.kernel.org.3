Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9EE57FE67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbiGYLdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiGYLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:33:12 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E2818B2B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:33:10 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id o7-20020a056e02102700b002dd09fe012aso7281525ilj.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=G6+KPVwCbz9f7uAce+He90zkK2rdMl+aAICfsh+bT7E=;
        b=N01m+zqbirueuKHTVgiTxYsT38ly01GLa2UpzWI2A8WpyNw/1SmjKQoHqtSC59AztT
         rC8WS/X3g/tPon9fps16mqGkAKMgoiX2SkQKvgOH2uk5dQ+a78AyJqhQVvnf4P5pDX80
         8eU90+cZeuh5W7fMMyGqFD+0nXRkbZGMrC0Nn65DK8fH3o85PJST/3B3TtXBjCgBPxzg
         ZKPWHOmLnNUED8dSq3FmTgahDpiaTev31/LrYWb51xVGjb2/XolNfeWuw9I1hjT1eI/N
         uGVz9Dr4R7V2Np52vgYdUgrrF77oPlEtZyLzWt3S2Ec23Vio88Tl+frGMhHZ5g6JFC8S
         SU9g==
X-Gm-Message-State: AJIora/mJDIwODGxIaNZJvAl43JINCsqZJQfNYkRRgy6bVvL0r7KP6pO
        OpOjK82lJno+YDkrbG5yB2JtrIWBMoPmFoKLW2+aCI+pzY5p
X-Google-Smtp-Source: AGRyM1vLbt9q20gUCZDH0ESuE395CNUjbT3pi/pjQnR0sTS2k5izt/dwk5j5Al37pWhVHTKai9QsLvR9H9Nf9sTGZ7elPGiF+LAR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188c:b0:2dc:a00:3222 with SMTP id
 o12-20020a056e02188c00b002dc0a003222mr4348000ilu.43.1658748790194; Mon, 25
 Jul 2022 04:33:10 -0700 (PDT)
Date:   Mon, 25 Jul 2022 04:33:10 -0700
In-Reply-To: <20220725112124.2733-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006949b705e49f8cc8@google.com>
Subject: Re: [syzbot] WARNING in p9_client_destroy
From:   syzbot <syzbot+5e28cdb7ebd0f2389ca4@syzkaller.appspotmail.com>
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
INFO: trying to register non-static key in p9_req_free

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 4084 Comm: syz-executor.0 Not tainted 5.19.0-rc4-next-20220628-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:979 [inline]
 register_lock_class+0xf30/0x1130 kernel/locking/lockdep.c:1292
 __lock_acquire+0x10a/0x5660 kernel/locking/lockdep.c:4932
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 complete+0x19/0x1f0 kernel/sched/completion.c:32
 p9_req_free+0x16d/0x1d0 net/9p/client.c:385
 kref_put include/linux/kref.h:65 [inline]
 p9_req_put net/9p/client.c:390 [inline]
 p9_tag_remove+0xe2/0x120 net/9p/client.c:372
 p9_client_version net/9p/client.c:999 [inline]
 p9_client_create+0xc5f/0x1100 net/9p/client.c:1062
 v9fs_session_init+0x1e2/0x1810 fs/9p/v9fs.c:408
 v9fs_mount+0x73/0xa80 fs/9p/vfs_super.c:126
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1501
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fc4c8e89209
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc4c9fd0168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc4c8f9bf60 RCX: 00007fc4c8e89209
RDX: 0000000020000140 RSI: 0000000020000200 RDI: 0000000000000000
RBP: 00007fc4c8ee3161 R08: 0000000020000580 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdb94b6f3f R14: 00007fc4c9fd0300 R15: 0000000000022000
 </TASK>
BUG: unable to handle page fault for address: fffffffffffffff8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD ba8f067 P4D ba8f067 PUD ba91067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 4084 Comm: syz-executor.0 Not tainted 5.19.0-rc4-next-20220628-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:swake_up_locked kernel/sched/swait.c:29 [inline]
RIP: 0010:swake_up_locked kernel/sched/swait.c:21 [inline]
RIP: 0010:complete+0x98/0x1f0 kernel/sched/completion.c:36
Code: e0 0f 84 f7 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5b 48 48 8d 7b f8 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 03 01 00 00 <48> 8b 7b f8 4c 8d 63 08 e8 8b 74 f8 ff 48 89 df e8 e3 79 a3 02 84
RSP: 0018:ffffc900030af978 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff815f0600
RDX: 1fffffffffffffff RSI: 0000000000000004 RDI: fffffffffffffff8
RBP: 0000000000000293 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000615f1d R11: 3e4b5341542f3c20 R12: ffff88806ef26cb8
R13: ffff88806ef26c78 R14: ffff8880205a6000 R15: ffff88806ef26c48
FS:  00007fc4c9fd0700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff8 CR3: 0000000078de1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 p9_req_free+0x16d/0x1d0 net/9p/client.c:385
 kref_put include/linux/kref.h:65 [inline]
 p9_req_put net/9p/client.c:390 [inline]
 p9_tag_remove+0xe2/0x120 net/9p/client.c:372
 p9_client_version net/9p/client.c:999 [inline]
 p9_client_create+0xc5f/0x1100 net/9p/client.c:1062
 v9fs_session_init+0x1e2/0x1810 fs/9p/v9fs.c:408
 v9fs_mount+0x73/0xa80 fs/9p/vfs_super.c:126
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1501
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fc4c8e89209
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc4c9fd0168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc4c8f9bf60 RCX: 00007fc4c8e89209
RDX: 0000000020000140 RSI: 0000000020000200 RDI: 0000000000000000
RBP: 00007fc4c8ee3161 R08: 0000000020000580 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdb94b6f3f R14: 00007fc4c9fd0300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: fffffffffffffff8
---[ end trace 0000000000000000 ]---
RIP: 0010:swake_up_locked kernel/sched/swait.c:29 [inline]
RIP: 0010:swake_up_locked kernel/sched/swait.c:21 [inline]
RIP: 0010:complete+0x98/0x1f0 kernel/sched/completion.c:36
Code: e0 0f 84 f7 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5b 48 48 8d 7b f8 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 03 01 00 00 <48> 8b 7b f8 4c 8d 63 08 e8 8b 74 f8 ff 48 89 df e8 e3 79 a3 02 84
RSP: 0018:ffffc900030af978 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff815f0600
RDX: 1fffffffffffffff RSI: 0000000000000004 RDI: fffffffffffffff8
RBP: 0000000000000293 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000615f1d R11: 3e4b5341542f3c20 R12: ffff88806ef26cb8
R13: ffff88806ef26c78 R14: ffff8880205a6000 R15: ffff88806ef26c48
FS:  00007fc4c9fd0700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff8 CR3: 0000000078de1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	0f 84 f7 00 00 00    	je     0xfd
   6:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   d:	fc ff df
  10:	48 8b 5b 48          	mov    0x48(%rbx),%rbx
  14:	48 8d 7b f8          	lea    -0x8(%rbx),%rdi
  18:	48 89 fa             	mov    %rdi,%rdx
  1b:	48 c1 ea 03          	shr    $0x3,%rdx
  1f:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  23:	0f 85 03 01 00 00    	jne    0x12c
* 29:	48 8b 7b f8          	mov    -0x8(%rbx),%rdi <-- trapping instruction
  2d:	4c 8d 63 08          	lea    0x8(%rbx),%r12
  31:	e8 8b 74 f8 ff       	callq  0xfff874c1
  36:	48 89 df             	mov    %rbx,%rdi
  39:	e8 e3 79 a3 02       	callq  0x2a37a21
  3e:	84                   	.byte 0x84


Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=121acc4a080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=5e28cdb7ebd0f2389ca4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109ffe72080000

