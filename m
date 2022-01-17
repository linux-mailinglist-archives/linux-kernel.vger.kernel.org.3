Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999A14905B8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbiAQKJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:09:19 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:47058 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiAQKJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:09:18 -0500
Received: by mail-io1-f70.google.com with SMTP id e2-20020a6bb502000000b00601c16cb405so9329479iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 02:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KLbvY9L3ttzibJE45m41SBRonuTsoEeOh0+FJZLCoxM=;
        b=cmp8E2Nkj6SYjrnNw+N/JSwp8cJvd+aFSYqEFMfdmfxTMB09dcRKYBa5uV5fp/eTlH
         L6eEDeNTpHe3jRwhoMlaqyAUJxM+vcGFkCXQJ6Crm2Ecl4/c/Rt1+5vIO3c5cX2jMBDt
         tQoolPAw2eU76+WVaRS9p+mo4Wxk/fB8rHnnRGMJU+6YtTQ6BITNbx3SqEX6/+Cs+J+W
         jiWr8CRyFkyUuGFvU1QRVeIeTuIuf+RnBO1QfEd7Tjx78tiO2mCHLFAKf4hL+JXzJCjg
         wV0H+xpMVfQy4/mRvCbGaZTSMSMnBjd0eNnxTiSjUtpKmvCOflNDepsRpeygAd60ttk0
         rTYA==
X-Gm-Message-State: AOAM533wzrFncSnghuj4snD/pXSXYcq01wxtBRw4X+oi5ecKsj/4g8AN
        Auq298FVWScbXkYn+XSp046Bms7/O61C2votDuE151ANuVI/
X-Google-Smtp-Source: ABdhPJw9FEiSBQcsjIvGibw6cAAcyU1qrTPaF/3tY0qusnwfT+66tD0acJJ0gLa5sk44h9LT8vBnIFTYzPgX+9FhLFWrWhFE5CRM
MIME-Version: 1.0
X-Received: by 2002:a5e:dc42:: with SMTP id s2mr9718201iop.149.1642414157830;
 Mon, 17 Jan 2022 02:09:17 -0800 (PST)
Date:   Mon, 17 Jan 2022 02:09:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000739eb405d5c458dc@google.com>
Subject: [syzbot] kernel BUG in ntfs_read_inode_mount
From:   syzbot <syzbot+3c765c5248797356edaa@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d0a231f01e5b Merge tag 'pci-v5.17-changes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f83837b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=986ed422f1741853
dashboard link: https://syzkaller.appspot.com/bug?extid=3c765c5248797356edaa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c765c5248797356edaa@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ntfs/malloc.h:31!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 13085 Comm: syz-executor.4 Not tainted 5.16.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__ntfs_malloc fs/ntfs/malloc.h:31 [inline]
RIP: 0010:ntfs_malloc_nofs fs/ntfs/malloc.h:52 [inline]
RIP: 0010:ntfs_read_inode_mount+0x1df3/0x2490 fs/ntfs/inode.c:1884
Code: 24 30 48 39 c3 0f 83 e2 01 00 00 e8 87 85 e5 fe 48 89 ef be 42 0c 00 00 e8 ba c9 21 ff 48 89 c5 e9 59 f4 ff ff e8 6d 85 e5 fe <0f> 0b 4c 8b 7c 24 30 e8 61 85 e5 fe 48 c7 c2 c0 b3 df 89 48 c7 c7
RSP: 0018:ffffc90003a37a80 EFLAGS: 00010212
RAX: 0000000000003063 RBX: 0000000000000000 RCX: ffffc9000fc69000
RDX: 0000000000040000 RSI: ffffffff82924583 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff82923991 R11: 0000000000000000 R12: ffff88807d0f4038
R13: ffff88807d0f4040 R14: ffff888071f5f6a0 R15: ffff88801e2ca000
FS:  00007f29a2160700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555c25708 CR3: 00000000793be000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ntfs_fill_super+0xa2f/0x8440 fs/ntfs/super.c:2854
 mount_bdev+0x34d/0x410 fs/super.c:1370
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1500
 do_new_mount fs/namespace.c:2994 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3324
 do_mount fs/namespace.c:3337 [inline]
 __do_sys_mount fs/namespace.c:3545 [inline]
 __se_sys_mount fs/namespace.c:3522 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3522
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f29a37ec51a
Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f29a215ff88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f29a37ec51a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f29a215ffe0
RBP: 00007f29a2160020 R08: 00007f29a2160020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f29a215ffe0 R15: 000000002007dd00
 </TASK>
Modules linked in:
---[ end trace 20309b23609f3571 ]---
RIP: 0010:__ntfs_malloc fs/ntfs/malloc.h:31 [inline]
RIP: 0010:ntfs_malloc_nofs fs/ntfs/malloc.h:52 [inline]
RIP: 0010:ntfs_read_inode_mount+0x1df3/0x2490 fs/ntfs/inode.c:1884
Code: 24 30 48 39 c3 0f 83 e2 01 00 00 e8 87 85 e5 fe 48 89 ef be 42 0c 00 00 e8 ba c9 21 ff 48 89 c5 e9 59 f4 ff ff e8 6d 85 e5 fe <0f> 0b 4c 8b 7c 24 30 e8 61 85 e5 fe 48 c7 c2 c0 b3 df 89 48 c7 c7
RSP: 0018:ffffc90003a37a80 EFLAGS: 00010212
RAX: 0000000000003063 RBX: 0000000000000000 RCX: ffffc9000fc69000
RDX: 0000000000040000 RSI: ffffffff82924583 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff82923991 R11: 0000000000000000 R12: ffff88807d0f4038
R13: ffff88807d0f4040 R14: ffff888071f5f6a0 R15: ffff88801e2ca000
FS:  00007f29a2160700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8b9a64ffc8 CR3: 00000000793be000 CR4: 0000000000350ee0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
