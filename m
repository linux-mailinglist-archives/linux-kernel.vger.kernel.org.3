Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5FF5AB4C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiIBPMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiIBPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:12:07 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E19153D37
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:42:37 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id g12-20020a5d8c8c000000b006894fb842e3so1409236ion.21
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 07:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=p76NpCuZlBgkotzqMUuU1yZA+Pg91gwSgFVN9EseNWk=;
        b=3vKShjXmrgrlDZRbJOMWMrPMAL7TWzd4HSF3sd3BZ9RQ4B41dzKvx7Ce3i4AnNqRU4
         LKv2FQuP9UX91wr1vvzrLMEmMKC/1Xk0BIhL4CHq8OwbS42iGyVrlx0aF8vmFDmxXKOB
         4pQmV6THs1+EssdOX2/iHAl+9lfknPk9WfUfp0ZEa/mhS5pjctgu6BkK6JPQbqjznIUS
         Z0ILp/mf4p9oLraBMgoMWrLkhGHPk0/pXM91FP+SdbrUvRQ4i0tYG0bPvU82P7unXg0r
         PUbE22zQZ5ivfczWb3MM+VTJFl3XBp2BdgObYw+AzzB9oyazn3mri4qyPUdnQUHwSEWV
         2mzw==
X-Gm-Message-State: ACgBeo20gLYvJpmYI4Qe4mool5IPToj+EChJRqx4gEjiEr9jAMsLx4vk
        vdB2CO++fORrmjYU/z5X0a6E/Gaw+8mLVNt4wvb6tH95J4t/
X-Google-Smtp-Source: AA6agR7+URXwX52wiSNSaNGN33li00YiPSIlQjAep8xScZcKsl0jkwHfrYm8UuStJufngUwgwbgIxdI7cQubr7fEepvYTccBnTMW
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150f:b0:343:3db6:433c with SMTP id
 b15-20020a056638150f00b003433db6433cmr21016205jat.34.1662129756070; Fri, 02
 Sep 2022 07:42:36 -0700 (PDT)
Date:   Fri, 02 Sep 2022 07:42:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae694805e7b2bda3@google.com>
Subject: [syzbot] general protection fault in binder_alloc_new_buf_locked
From:   syzbot <syzbot+ff47834028a51cf6f857@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arve@android.com, brauner@kernel.org,
        cmllamas@google.com, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, maco@android.com,
        omosnace@redhat.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
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

HEAD commit:    b90cb1053190 Linux 6.0-rc3
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1719e383080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c5c41fc03fda66f
dashboard link: https://syzkaller.appspot.com/bug?extid=ff47834028a51cf6f857
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11794975080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1445c063080000

The issue was bisected to:

commit 44e602b4e52f70f04620bbbf4fe46ecb40170bde
Author: Liam Howlett <liam.howlett@oracle.com>
Date:   Wed Aug 10 16:02:25 2022 +0000

    binder_alloc: add missing mmap_lock calls when using the VMA

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d0d575080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15d0d575080000
console output: https://syzkaller.appspot.com/x/log.txt?x=11d0d575080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff47834028a51cf6f857@syzkaller.appspotmail.com
Fixes: 44e602b4e52f ("binder_alloc: add missing mmap_lock calls when using the VMA")

binder: 3610:3610 ioctl c0306201 20001480 returned -14
general protection fault, probably for non-canonical address 0xdffffc0000000025: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000128-0x000000000000012f]
CPU: 0 PID: 3610 Comm: syz-executor216 Not tainted 6.0.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__lock_acquire+0x6b/0x1f60 kernel/locking/lockdep.c:4923
Code: ff df 8a 04 10 84 c0 0f 85 62 16 00 00 83 3d bf 50 bc 0c 00 0f 84 13 15 00 00 83 3d 7e 93 55 0b 00 74 2c 4c 89 e8 48 c1 e8 03 <80> 3c 10 00 74 12 4c 89 ef e8 b7 f3 73 00 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003a2efa8 EFLAGS: 00010002
RAX: 0000000000000025 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000128
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1c4ae0e R11: 1ffffffff1c4ae0d R12: 0000000000000001
R13: 0000000000000128 R14: 0000000000000000 R15: 0000000000000001
FS:  000055555635f300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000001db40000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5666
 down_read+0x39/0x50 kernel/locking/rwsem.c:1499
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 binder_alloc_new_buf_locked+0x9d/0x15f0 drivers/android/binder_alloc.c:405
 binder_alloc_new_buf+0x42/0x60 drivers/android/binder_alloc.c:593
 binder_transaction+0x284b/0x72e0 drivers/android/binder.c:3187
 binder_ioctl_write_read+0xd9a/0x8e50 drivers/android/binder.c:5024
 binder_ioctl+0x385/0x18c0 drivers/android/binder.c:5311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f292e46f339
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda7bf8418 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f292e46f339
RDX: 0000000020000040 RSI: 00000000c0306201 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007f292e4dce40 R09: 00007f292e4dce40
R10: 00007f292e4dce40 R11: 0000000000000246 R12: 00007ffda7bf8450
R13: 00007ffda7bf8440 R14: 00007ffda7bf8430 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x6b/0x1f60 kernel/locking/lockdep.c:4923
Code: ff df 8a 04 10 84 c0 0f 85 62 16 00 00 83 3d bf 50 bc 0c 00 0f 84 13 15 00 00 83 3d 7e 93 55 0b 00 74 2c 4c 89 e8 48 c1 e8 03 <80> 3c 10 00 74 12 4c 89 ef e8 b7 f3 73 00 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003a2efa8 EFLAGS: 00010002
RAX: 0000000000000025 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000128
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1c4ae0e R11: 1ffffffff1c4ae0d R12: 0000000000000001
R13: 0000000000000128 R14: 0000000000000000 R15: 0000000000000001
FS:  000055555635f300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000001db40000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	df 8a 04 10 84 c0    	fisttps -0x3f7beffc(%rdx)
   6:	0f 85 62 16 00 00    	jne    0x166e
   c:	83 3d bf 50 bc 0c 00 	cmpl   $0x0,0xcbc50bf(%rip)        # 0xcbc50d2
  13:	0f 84 13 15 00 00    	je     0x152c
  19:	83 3d 7e 93 55 0b 00 	cmpl   $0x0,0xb55937e(%rip)        # 0xb55939e
  20:	74 2c                	je     0x4e
  22:	4c 89 e8             	mov    %r13,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1) <-- trapping instruction
  2d:	74 12                	je     0x41
  2f:	4c 89 ef             	mov    %r13,%rdi
  32:	e8 b7 f3 73 00       	callq  0x73f3ee
  37:	48                   	rex.W
  38:	ba 00 00 00 00       	mov    $0x0,%edx
  3d:	00 fc                	add    %bh,%ah


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
