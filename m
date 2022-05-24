Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB6532101
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiEXCdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiEXCde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:33:34 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5351644EC
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:33:32 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id g11-20020a056e021e0b00b002d1b5e8389bso2275307ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vS6L5CZCfKuHlo887Ie4nS6MPjUiFWIkQQaygVU2CR0=;
        b=zpqoJuQeRPaybZEtf6OphM8wkA9qDEAVIzWdd/5LO1T/xa+R3k/mDfdSogrpIz5H7/
         annLzSd5q6d0PXF3sFzG/h/ypCPgqpdOEr4Qurw/m7XgCwGavZssG7xzXONf1ypcb0/u
         VXOEoo8+cmGv9jh0G9lZNMGUmnnS7OhHCt2n8Sio5ZinNOgK6blUuqNmhB6cBc+gGCVG
         hRet3HVnJQl8fD6aO5Eb/8JcNctFslNNawYwy4mY7f7Qk07yPkkrl35YHwExsLzaAmLl
         o6GttVTU6w49lOkEDs6ew6KZuD+ltoaFgiB4+/1embTwGFwywdlAX3F3Rf+4Xr0hp+ns
         Lgkw==
X-Gm-Message-State: AOAM5322c9wb7x/Ck7FX4fmHLVIWvUSzCv7lf5pPhEXGW+ButRloub/N
        wUF45kp6R2JV44Ro+qLwgf3pFC465mXvo7jjqvJ1Kzd2CVWW
X-Google-Smtp-Source: ABdhPJwRrOR8nOJzr7p0//h8TjcjW3s42hfBNljSSxITCqRErg/dJwiXLu99t1ee2rPoYEe0TWcS2FizJh/OAu2scMqA+8vpJlMq
MIME-Version: 1.0
X-Received: by 2002:a6b:3b54:0:b0:665:197:f1b0 with SMTP id
 i81-20020a6b3b54000000b006650197f1b0mr2935908ioa.206.1653359612085; Mon, 23
 May 2022 19:33:32 -0700 (PDT)
Date:   Mon, 23 May 2022 19:33:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d4f6a05dfb8c85a@google.com>
Subject: [syzbot] WARNING in trace_hardirqs_on (2)
From:   syzbot <syzbot+0ccb59952c73777126bb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    b015dcd62b86 Merge tag 'for-5.18/parisc-4' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14562d45f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=edaa7ad763884c40
dashboard link: https://syzkaller.appspot.com/bug?extid=0ccb59952c73777126bb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ccb59952c73777126bb@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!irqs_disabled())
WARNING: CPU: 1 PID: 29602 at kernel/locking/lockdep.c:4275 lockdep_hardirqs_on_prepare kernel/locking/lockdep.c:4275 [inline]
WARNING: CPU: 1 PID: 29602 at kernel/locking/lockdep.c:4275 lockdep_hardirqs_on_prepare+0x354/0x400 kernel/locking/lockdep.c:4246
Modules linked in:
CPU: 1 PID: 29602 Comm: syz-executor.1 Not tainted 5.18.0-rc7-syzkaller-00119-gb015dcd62b86 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:lockdep_hardirqs_on_prepare kernel/locking/lockdep.c:4275 [inline]
RIP: 0010:lockdep_hardirqs_on_prepare+0x354/0x400 kernel/locking/lockdep.c:4246
Code: 08 84 d2 0f 85 a9 00 00 00 8b 3d bf a5 5c 0c 85 ff 0f 85 50 fe ff ff 48 c7 c6 00 43 cc 89 48 c7 c7 40 43 cc 89 e8 7c c2 cb 07 <0f> 0b e9 36 fe ff ff e8 10 99 97 02 85 c0 0f 84 29 fe ff ff 48 c7
RSP: 0018:ffffc90004c47a88 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff905c0940 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815f4a18 RDI: fffff52000988f43
RBP: ffffffff8970231f R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815ef3ee R11: 0000000000000000 R12: ffff888026900540
R13: ffff888026900338 R14: ffffffff8a017f40 R15: ffff888025ad4a00
FS:  00007f0c85100700(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0c85101000 CR3: 000000005ed20000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 trace_hardirqs_on+0x5b/0x1c0 kernel/trace/trace_preemptirq.c:49
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
 _raw_spin_unlock_irq+0x1f/0x40 kernel/locking/spinlock.c:202
 spin_unlock_irq include/linux/spinlock.h:399 [inline]
 clear_inode+0x6b/0x190 fs/inode.c:620
 ntfs_evict_inode+0x5c/0xa0 fs/ntfs3/inode.c:1757
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1744 [inline]
 iput.part.0+0x562/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 ntfs_fill_super+0x2e08/0x37b0 fs/ntfs3/super.c:1178
 get_tree_bdev+0x440/0x760 fs/super.c:1292
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0c8408a61a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0c850fff88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f0c8408a61a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f0c850fffe0
RBP: 00007f0c85100020 R08: 00007f0c85100020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f0c850fffe0 R15: 000000002007aa80
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
