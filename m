Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0951E57F435
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 10:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiGXIx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 04:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiGXIxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 04:53:25 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD8315714
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 01:53:24 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id w5-20020a056e021c8500b002dcb397284dso5357596ill.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 01:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AO7PREUYv+nfrjbwbYMkqRJTeiRWWTiw5vqtaXtpbtA=;
        b=H/Eq04V3Eha/fOsfyiVDk+n+bCL7UYeoPMkCgScJ+LtkCkaBLhHt1wdborr2Ci+qAD
         xkGX6/CXzgKTpkcUVlXzEhL7iCMMgMMehwf4eDW6gtzcma4F+debQULZh8y9zs+rTarX
         HauwmWvrmrELw11nkwzyJ1d0TUsZAtcJZ/+Ev93MOecT4Ll1fPrBia4NC4U++K5P5RBM
         CiknDnz5Yb4lu9MnBbnqyLg/kwQALSPxzCXvt7bKn2o5gCZ+aPI/uiHxVwxM8Fgm7O0s
         rsKkedyU7DwZxaIrJmPpELWOq91KedJUA43NEWASwzthCf2sJ3s2Qc6OJb7oNs820y+A
         xN0A==
X-Gm-Message-State: AJIora8+lBByCZ180Wc0jXjDnjs18cH/05jyhumWziJ9flMyZCve1hq0
        C0DeFy5ecjexejn+VtqAKBjeXuvWpQ/q4Z22+y/B5CLsj2qW
X-Google-Smtp-Source: AGRyM1uM1oPUyMj0Ln7ZwkRBA5KZ8XSY348AfwZbC08Od2dJe9jvODpfUw0TGZgv/H0Vx+A0viHThixcq+QpxylufVrMHzKf8tnI
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1587:b0:67c:b28:6e90 with SMTP id
 e7-20020a056602158700b0067c0b286e90mr2648662iow.16.1658652803347; Sun, 24 Jul
 2022 01:53:23 -0700 (PDT)
Date:   Sun, 24 Jul 2022 01:53:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000263bc305e489338a@google.com>
Subject: [syzbot] kernel BUG in ntfs_lookup_inode_by_name
From:   syzbot <syzbot+d532380eef771ac0034b@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
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

syzbot found the following issue on:

HEAD commit:    ca85855bdcae Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=157a16dc080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a01cb298f103d7e3
dashboard link: https://syzkaller.appspot.com/bug?extid=d532380eef771ac0034b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148f69c2080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1534cc4a080000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14032ec2080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16032ec2080000
console output: https://syzkaller.appspot.com/x/log.txt?x=12032ec2080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d532380eef771ac0034b@syzkaller.appspotmail.com

ntfs: (device loop0): map_mft_record_page(): Mft record 0xa is corrupt.  Run chkdsk.
ntfs: (device loop0): map_mft_record(): Failed with error code 5.
ntfs: (device loop0): ntfs_read_locked_inode(): Failed with error code -5.  Marking corrupt inode 0xa as bad.  Run chkdsk.
ntfs: (device loop0): load_and_init_upcase(): Failed to load $UpCase from the volume. Using default.
ntfs: volume version 3.1.
ntfs: (device loop0): map_mft_record_page(): Mft record 0x2 is corrupt.  Run chkdsk.
------------[ cut here ]------------
kernel BUG at fs/ntfs/dir.c:86!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3611 Comm: syz-executor707 Not tainted 5.19.0-rc7-syzkaller-00005-gca85855bdcae #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:ntfs_lookup_inode_by_name+0xe4b/0x2ef0 fs/ntfs/dir.c:86
Code: df 48 c1 ea 03 80 3c 02 00 0f 85 ec 1d 00 00 48 8b 44 24 50 49 8d 5c 24 07 48 c7 00 00 00 00 00 e9 1e fa ff ff e8 f5 af d9 fe <0f> 0b e8 ee af d9 fe 0f 0b e8 e7 af d9 fe 48 8b 74 24 70 4c 89 e1
RSP: 0018:ffffc9000347fa30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000008000 RCX: 0000000000000000
RDX: ffff888020e05880 RSI: ffffffff82a0bc6b RDI: 0000000000000003
RBP: ffff88807bfb8000 R08: 0000000000000003 R09: 0000000000004000
R10: 0000000000008000 R11: 000000000008a07a R12: ffff88807ce82050
R13: ffff88807bfb8000 R14: ffff88807bfb8230 R15: ffff88807ce82000
FS:  00005555555a3300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560fe0051808 CR3: 0000000072caa000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 load_and_init_quota fs/ntfs/super.c:1367 [inline]
 load_system_files fs/ntfs/super.c:2103 [inline]
 ntfs_fill_super+0x59f5/0x9080 fs/ntfs/super.c:2891
 mount_bdev+0x34d/0x410 fs/super.c:1367
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6deea26afa
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdf3ff3938 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffdf3ff3990 RCX: 00007f6deea26afa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffdf3ff3950
RBP: 00007ffdf3ff3950 R08: 00007ffdf3ff3990 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020001208
R13: 0000000000000003 R14: 0000000000000004 R15: 00000000000000ab
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ntfs_lookup_inode_by_name+0xe4b/0x2ef0 fs/ntfs/dir.c:86
Code: df 48 c1 ea 03 80 3c 02 00 0f 85 ec 1d 00 00 48 8b 44 24 50 49 8d 5c 24 07 48 c7 00 00 00 00 00 e9 1e fa ff ff e8 f5 af d9 fe <0f> 0b e8 ee af d9 fe 0f 0b e8 e7 af d9 fe 48 8b 74 24 70 4c 89 e1
RSP: 0018:ffffc9000347fa30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000008000 RCX: 0000000000000000
RDX: ffff888020e05880 RSI: ffffffff82a0bc6b RDI: 0000000000000003
RBP: ffff88807bfb8000 R08: 0000000000000003 R09: 0000000000004000
R10: 0000000000008000 R11: 000000000008a07a R12: ffff88807ce82050
R13: ffff88807bfb8000 R14: ffff88807bfb8230 R15: ffff88807ce82000
FS:  00005555555a3300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560fe0051808 CR3: 0000000072caa000 CR4: 0000000000350ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
