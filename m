Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BDC4683E7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbhLDJ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:59:44 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:41680 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbhLDJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:59:43 -0500
Received: by mail-il1-f198.google.com with SMTP id r1-20020a92cd81000000b002a3ae5f6ad9so3675604ilb.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 01:56:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ucx0G2cXqTlPReDamGD5z+eWbTOBEHQgvE2ckvGV7sU=;
        b=CDdmFX5+9eIDiTbmbxvns5gxJumrmUGGkWZT75k+mrHM7G7VykkHSR8YtF+d71xK/5
         0kqyviPSbtJz1cpyunVVL0b+O/gYK9FVQIVq3BkBBncMFHka9EGGlNqGhEsLhEcywgz4
         XbBlxvgFf2gUN2YBdNHehC33IlnAdJHvfeoTdBms1bvdhkPq5LvfMkkB+RXy+P43k/fE
         cm5QiVjGkFqMGA8arI+9w6WKAOqTbtMbjNjoGYk98LcsCcfo6XBVYUc8VvLXRaAwlc+q
         1QhkSh+auvhX3Tk2jleufODWZLkuwM/rxP1dSkIjIu1mcVEtrz5cOmOe3LNofQao9/fn
         3Y+A==
X-Gm-Message-State: AOAM532+EWz27N/dbL3Rvw5eP6aFhp0mnYQsimB44eI+3QgPHf3BgkLu
        WIhqZ3kTxBgpyQrIgddPFGVjpVEvtY3KF0JsFnTKqYHtIuBY
X-Google-Smtp-Source: ABdhPJy5dc4i3xwdiohl6ZkjAPRtqFDZUcAnJI8F6PUVd8QE2wFvM/0lYC5WgGMFVB9bAHYw7GQXQmFWzRwR3Etsq+URM/FI8zi6
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29c5:: with SMTP id z5mr22971364ioq.34.1638611777918;
 Sat, 04 Dec 2021 01:56:17 -0800 (PST)
Date:   Sat, 04 Dec 2021 01:56:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f298c005d24f08a3@google.com>
Subject: [syzbot] general protection fault in kernfs_find_ns
From:   syzbot <syzbot+606682dc540a22b8dbef@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    923dcc5eb0c1 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1699b75eb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5999a5ee199b97
dashboard link: https://syzkaller.appspot.com/bug?extid=606682dc540a22b8dbef
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+606682dc540a22b8dbef@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc00000297c7: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x000000000014be38-0x000000000014be3f]
CPU: 1 PID: 1025 Comm: kworker/u4:4 Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:strlen+0x27/0x60 lib/string.c:487
Code: 0f 1f 00 41 57 41 56 53 49 89 fe 49 bf 00 00 00 00 00 fc ff df 48 89 f8 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 c3 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 0b 48 8d 43 01 80 3b 00 75 e7 eb 13 89 d9
RSP: 0018:ffffc900045c7960 EFLAGS: 00010202
RAX: 00000000000297c7 RBX: 000000000014be38 RCX: ffff88801ca3ba01
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000014be38
RBP: 0000000000000001 R08: ffffffff82081018 R09: fffffbfff198b682
R10: fffffbfff198b682 R11: 0000000000000000 R12: ffff8880b4e63828
R13: 0000000000000000 R14: 000000000014be38 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f79b499a90 CR3: 00000000447a1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernfs_name_hash fs/kernfs/dir.c:302 [inline]
 kernfs_find_ns+0xe7/0x4d0 fs/kernfs/dir.c:799
 kernfs_remove_by_name_ns+0x32/0x90 fs/kernfs/dir.c:1542
 kernfs_remove_by_name include/linux/kernfs.h:570 [inline]
 remove_files fs/sysfs/group.c:28 [inline]
 sysfs_remove_group+0xf7/0x280 fs/sysfs/group.c:288
 sysfs_remove_groups+0x5b/0xb0 fs/sysfs/group.c:312
 destroy_port drivers/infiniband/core/sysfs.c:1284 [inline]
 ib_free_port_attrs+0x339/0x3c0 drivers/infiniband/core/sysfs.c:1409
 remove_one_compat_dev drivers/infiniband/core/device.c:1001 [inline]
 rdma_dev_exit_net+0x20d/0x370 drivers/infiniband/core/device.c:1139
 ops_exit_list net/core/net_namespace.c:168 [inline]
 cleanup_net+0x758/0xc50 net/core/net_namespace.c:593
 process_one_work+0x853/0x1140 kernel/workqueue.c:2298
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
---[ end trace 0b26f5c4a2c69aa9 ]---
RIP: 0010:strlen+0x27/0x60 lib/string.c:487
Code: 0f 1f 00 41 57 41 56 53 49 89 fe 49 bf 00 00 00 00 00 fc ff df 48 89 f8 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 c3 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 0b 48 8d 43 01 80 3b 00 75 e7 eb 13 89 d9
RSP: 0018:ffffc900045c7960 EFLAGS: 00010202
RAX: 00000000000297c7 RBX: 000000000014be38 RCX: ffff88801ca3ba01
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000014be38
RBP: 0000000000000001 R08: ffffffff82081018 R09: fffffbfff198b682
R10: fffffbfff198b682 R11: 0000000000000000 R12: ffff8880b4e63828
R13: 0000000000000000 R14: 000000000014be38 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2c72a000 CR3: 000000009369d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	0f 1f 00             	nopl   (%rax)
   3:	41 57                	push   %r15
   5:	41 56                	push   %r14
   7:	53                   	push   %rbx
   8:	49 89 fe             	mov    %rdi,%r14
   b:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  12:	fc ff df
  15:	48 89 f8             	mov    %rdi,%rax
  18:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  1f:	00 00 00
  22:	90                   	nop
  23:	48 89 c3             	mov    %rax,%rbx
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	75 0b                	jne    0x3e
  33:	48 8d 43 01          	lea    0x1(%rbx),%rax
  37:	80 3b 00             	cmpb   $0x0,(%rbx)
  3a:	75 e7                	jne    0x23
  3c:	eb 13                	jmp    0x51
  3e:	89 d9                	mov    %ebx,%ecx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
