Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22636502EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346455AbiDOSc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346927AbiDOScu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:32:50 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AB15715D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:30:21 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso5171901iov.16
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bJnL6XNppgHjVNvFuWRsjo5rWU8q7h1HCutwsx9Ydnk=;
        b=oKDqExlNFJoCPJzIextl1Fphb5RZ+PWBwomd0ZKbpyp9lIv+z70bAA371gnt7PPiLF
         kd8hYet1jVlgr+nqKymCB5Sa+qpGMdy8aNKm8xswenZtb7r6oh3naphLu945/WIG1NKt
         n9IBa/5lLGkznDWYvnL1W3jkS83Vczbo0tDgZl9v0CHmDvgtcvVU4wo0cAOjcxGaiKNt
         5m8yK9uvYX+N7Q7yfsl+Dyo1R4f5UHY99yDwncEBeitqi7SMWxfNrIyiW9MOtQjjaCM/
         bcEH12FijWf+g896UOAKw911wPKR1B/r9h6SuZ6yM8FyxctnZstfLc1qhKXNl7xmuYAm
         Q1/g==
X-Gm-Message-State: AOAM530Ou8b+6irTAf+TNVZ6xhwQLW8Ay+oSM7zLDiIIyelzeJXT/ksU
        vDbMfjEAg63IuH5Eo+6sbPqxSkz3VVaAsMsBmrmec7WH48jP
X-Google-Smtp-Source: ABdhPJzO+q4fCg1W3/W+kR4lAh8sMz8YNEiX9noO0mSDXW8ldFjTYf5hrOyLECQHTfGN+ezRvcZTk1sKFlXxrCTvrNJZDqbhZ1SW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:2cb:d354:180c with SMTP id
 k9-20020a056e021a8900b002cbd354180cmr72135ilv.229.1650047420795; Fri, 15 Apr
 2022 11:30:20 -0700 (PDT)
Date:   Fri, 15 Apr 2022 11:30:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061120905dcb59aab@google.com>
Subject: [syzbot] WARNING in fuse_write_file_get
From:   syzbot <syzbot+6e1efbd8efaaa6860e91@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    a19944809fe9 Merge tag 'hardening-v5.18-rc3' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1531a0c0f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ac56d6828346c4e
dashboard link: https://syzkaller.appspot.com/bug?extid=6e1efbd8efaaa6860e91
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17342888f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146c64ecf00000

The issue was bisected to:

commit 36ea23374d1f7b6a9d96a2b61d38830fdf23e45d
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri Oct 22 15:03:01 2021 +0000

    fuse: write inode in fuse_vma_close() instead of fuse_release()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13a9b9ef700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1069b9ef700000
console output: https://syzkaller.appspot.com/x/log.txt?x=17a9b9ef700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e1efbd8efaaa6860e91@syzkaller.appspotmail.com
Fixes: 36ea23374d1f ("fuse: write inode in fuse_vma_close() instead of fuse_release()")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 45 at fs/fuse/file.c:1842 spin_unlock include/linux/spinlock.h:389 [inline]
WARNING: CPU: 0 PID: 45 at fs/fuse/file.c:1842 __fuse_write_file_get fs/fuse/file.c:1834 [inline]
WARNING: CPU: 0 PID: 45 at fs/fuse/file.c:1842 fuse_write_file_get+0xb7/0xf0 fs/fuse/file.c:1841
Modules linked in:
CPU: 1 PID: 45 Comm: kworker/u4:2 Not tainted 5.18.0-rc2-syzkaller-00050-ga19944809fe9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-0:36)
RIP: 0010:fuse_write_file_get+0xb7/0xf0 fs/fuse/file.c:1842
Code: bf ff ff ff ff e8 d9 dd a4 fe 09 dd 78 36 e8 b0 d9 a4 fe 4c 89 f7 e8 88 c9 34 07 eb 0f e8 a1 d9 a4 fe 4c 89 f7 e8 79 c9 34 07 <0f> 0b 4c 89 e0 5b 41 5c 41 5e 41 5f 5d c3 e8 86 d9 a4 fe be 02 00
RSP: 0018:ffffc90000b66eb0 EFLAGS: 00010286
RAX: 0000000080000000 RBX: ffff888073f304c8 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffffc90000b671f0 R08: dffffc0000000000 R09: ffffed100e7e60bd
R10: ffffed100e7e60bd R11: 1ffff1100e7e60bc R12: 0000000000000000
R13: ffffea0001c33380 R14: ffff888073f305e0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020005000 CR3: 000000001d3f2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fuse_writepages_fill+0x11b/0x1bb0 fs/fuse/file.c:2152
 write_cache_pages+0x7dd/0x1350 mm/page-writeback.c:2243
 fuse_writepages+0x295/0x470 fs/fuse/file.c:2258
 do_writepages+0x3c3/0x690 mm/page-writeback.c:2352
 __writeback_single_inode+0xd1/0x670 fs/fs-writeback.c:1581
 writeback_sb_inodes+0xb4c/0x1870 fs/fs-writeback.c:1854
 __writeback_inodes_wb+0x125/0x420 fs/fs-writeback.c:1923
 wb_writeback+0x450/0x7a0 fs/fs-writeback.c:2028
 wb_check_background_flush fs/fs-writeback.c:2094 [inline]
 wb_do_writeback fs/fs-writeback.c:2182 [inline]
 wb_workfn+0xb5f/0xf10 fs/fs-writeback.c:2209
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
