Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBB34683E4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbhLDJ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:58:45 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:36524 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbhLDJ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:58:43 -0500
Received: by mail-io1-f72.google.com with SMTP id w16-20020a5d8a10000000b005e241c13c7bso4469950iod.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 01:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=u3AsoxQU/tK950hpFqbByeUWB2sygjl3RJ7kN22TcwA=;
        b=ZE0Ru8NPJSg0nBeekmQUJ6x7WRBHBy0lTC44E4hzUBdhw2jpaUvhqDrUbmcFAbwsXI
         keOJsW98UbVD42ONq/cylo1lAGrl7PIZcNtZCQAhhfrFog5q+o1ru900gqnAsLkUWkS3
         cH7kDmo9pdBM51Fs5Es9LcL3QW+OWjqlWFovijzPWj1+RgJBCmGvPPS5Dbd9ki559dLB
         fWO3VEKHcXPe4/1lnc7czF91YNic5uQPnd+FlazliKjHVWSvqXIGJ7F5lSnY8ic/I6hw
         72QUNaQFC1X9f2pn0MgxdZAddirHb+DxYl9MFKc5wwAit/HWUPYddsbWFDKiJkDsO/iq
         tSSw==
X-Gm-Message-State: AOAM532IqWHw1m+FhcCvjn2g4RQCXm6dpL86vmqnPzJPPBkd+AUfM8Cb
        4DoNyC1oNaghRI/CWe48aryl2bNPCnXwoj5uWSeixEjUVP0j
X-Google-Smtp-Source: ABdhPJw1obiBok/ARF2Pcafr1QlBTnCw+v2GFk1FSdlOe1581hI6USfe8e1YUTTgfJMIt0Q/vDZdgnIJNqpEHPs8j1trWt+9MLn1
MIME-Version: 1.0
X-Received: by 2002:a92:c562:: with SMTP id b2mr23168568ilj.108.1638611717923;
 Sat, 04 Dec 2021 01:55:17 -0800 (PST)
Date:   Sat, 04 Dec 2021 01:55:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f297e05d24f05f6@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in folio_mark_dirty
From:   syzbot <syzbot+7cd473c2cac13fd2dd72@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    58e1100fdc59 MAINTAINERS: co-maintain random.c
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1362881eb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9ea28d2c3c2c389
dashboard link: https://syzkaller.appspot.com/bug?extid=7cd473c2cac13fd2dd72
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7cd473c2cac13fd2dd72@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 70764067 P4D 70764067 PUD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6541 Comm: syz-executor.3 Not tainted 5.16.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc900027ff7f8 EFLAGS: 00010246
RAX: 1ffffffff14fef03 RBX: ffffffff8a7f7818 RCX: ffff88801b40d700
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffea0002790ec0
RBP: dffffc0000000000 R08: ffffffff81b0fa16 R09: fffff940004f21d9
R10: fffff940004f21d9 R11: 0000000000000000 R12: ffff88806c11c7b0
R13: 0000000000000000 R14: 1ffffd40004f21d9 R15: ffffea0002790ec0
FS:  0000555557165400(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000030d85000 CR4: 00000000003526e0
Call Trace:
 <TASK>
 folio_mark_dirty+0x136/0x270 mm/page-writeback.c:2639
 f2fs_update_meta_page+0x4b/0x380 fs/f2fs/segment.c:2485
 do_checkpoint fs/f2fs/checkpoint.c:1513 [inline]
 f2fs_write_checkpoint+0x31ad/0x5430 fs/f2fs/checkpoint.c:1674
 f2fs_issue_checkpoint+0x361/0x4e0
 sync_filesystem+0x19c/0x1f0 fs/sync.c:63
 generic_shutdown_super+0x6b/0x300 fs/super.c:448
 kill_block_super+0x79/0xd0 fs/super.c:1397
 kill_f2fs_super+0x2f9/0x3c0 fs/f2fs/super.c:4478
 deactivate_locked_super+0xa7/0xf0 fs/super.c:335
 cleanup_mnt+0x462/0x510 fs/namespace.c:1137
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x209/0x220 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300
 do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6cfdd59f57
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffcbddcad8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f6cfdd59f57
RDX: 00007fffcbddcbac RSI: 000000000000000a RDI: 00007fffcbddcba0
RBP: 00007fffcbddcba0 R08: 00000000ffffffff R09: 00007fffcbddc970
R10: 0000555557166903 R11: 0000000000000246 R12: 00007f6cfddb2105
R13: 00007fffcbdddc60 R14: 0000555557166810 R15: 00007fffcbdddca0
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 08eda5a5e35b48a0 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc900027ff7f8 EFLAGS: 00010246
RAX: 1ffffffff14fef03 RBX: ffffffff8a7f7818 RCX: ffff88801b40d700
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffea0002790ec0
RBP: dffffc0000000000 R08: ffffffff81b0fa16 R09: fffff940004f21d9
R10: fffff940004f21d9 R11: 0000000000000000 R12: ffff88806c11c7b0
R13: 0000000000000000 R14: 1ffffd40004f21d9 R15: ffffea0002790ec0
FS:  0000555557165400(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000030d85000 CR4: 00000000003526e0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
