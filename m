Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4521950B238
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445090AbiDVH6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241901AbiDVH6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:58:18 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A98C34647
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:55:24 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id j16-20020a056e02125000b002cc39632ab9so3976727ilq.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/vtUWpnugYZvI17/PxIskjzNw1gYIuijhJ19Q0tFHHE=;
        b=KpfepWGv6mQKgxM6AD8SG0Z2Zt50nYsWiGDljc9I4pp5l/n3jW97+QzjsO9Uqjj6Cc
         vInEQjGz+xVZurvawbZZ9DMBoHNd34i8LamV0yUqCcHW9PxjwErOfjXaBAWTkhJztJgc
         7FTvKS3E39i1Eb/JKCuBKZ6meCqsy/kR1CMPPuXeuuwCYuaX9yvH4Bc/hOS7TDwtpHIu
         fLju3RyVrknKo/uDYSZL6doTDpWMEWzMUlZ2amdjudBPkdHd5Q0ur4CX/2FM31in0K6+
         Dh5IahI0bVsvg1A65KepN7ZowzMUhXbcNwKQqqu3z5tCxrJUbIl3qqZCIktbzRYISk71
         VaYQ==
X-Gm-Message-State: AOAM532GZmiuj2Uqh0kffanOplJCw5y3paFtcSJQ04M/zsIdn3iKi5wZ
        0SUMfkqOysa2rerejv5wSKhEgwfnmqlYlpxqz80Njk6bND/P
X-Google-Smtp-Source: ABdhPJweuOucVY7qIlWIZ0LJXuyQZzQ1OM0E9pWKoqV1SaityRuZjD/S4y68Or9hUabKFNRg/Iq8vpFpikOvh5qXsHWBPHn+N/r5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1647:b0:328:81e9:1975 with SMTP id
 a7-20020a056638164700b0032881e91975mr1518400jat.143.1650614124001; Fri, 22
 Apr 2022 00:55:24 -0700 (PDT)
Date:   Fri, 22 Apr 2022 00:55:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085bef105dd398c3d@google.com>
Subject: [syzbot] WARNING in __floppy_read_block_0
From:   syzbot <syzbot+bac6723617710898abd3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b2d229d4ddb1 Linux 5.18-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b813f0f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd7c9a79dfcfa205
dashboard link: https://syzkaller.appspot.com/bug?extid=bac6723617710898abd3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bac6723617710898abd3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 22697 at drivers/block/floppy.c:1000 schedule_bh drivers/block/floppy.c:1000 [inline]
WARNING: CPU: 2 PID: 22697 at drivers/block/floppy.c:1000 process_fd_request drivers/block/floppy.c:2849 [inline]
WARNING: CPU: 2 PID: 22697 at drivers/block/floppy.c:1000 __floppy_read_block_0.isra.0+0x292/0x330 drivers/block/floppy.c:4141
Modules linked in:
CPU: 2 PID: 22697 Comm: syz-executor.3 Not tainted 5.18.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:1000 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2849 [inline]
RIP: 0010:__floppy_read_block_0.isra.0+0x292/0x330 drivers/block/floppy.c:4141
Code: 84 24 b8 01 00 00 65 48 2b 04 25 28 00 00 00 0f 85 a0 00 00 00 48 81 c4 c0 01 00 00 5b 5d 41 5c 41 5d 41 5e c3 e8 1e 1e f0 fc <0f> 0b e9 5a ff ff ff e8 e2 12 3b fd e9 7c fe ff ff e8 08 1e f0 fc
RSP: 0018:ffffc90021f2f6c0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff920043e5ed8 RCX: 0000000000000000
RDX: ffff888019a48080 RSI: ffffffff84882ff2 RDI: 0000000000000003
RBP: ffffea0001593300 R08: 0000000000000000 R09: ffffffff8c8b3f27
R10: ffffffff84882f4a R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: dffffc0000000000 R15: 0000000000000001
FS:  00007fce8416d700(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5e5a11efc0 CR3: 000000006ad68000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_revalidate.isra.0+0x801/0xae0 drivers/block/floppy.c:4187
 floppy_open+0xac5/0xd70 drivers/block/floppy.c:4039
 blkdev_get_whole+0x99/0x2d0 block/bdev.c:666
 blkdev_get_by_dev.part.0+0x5d2/0xc80 block/bdev.c:816
 blkdev_get_by_dev+0x6b/0x80 block/bdev.c:850
 blkdev_open+0x13c/0x2c0 block/fops.c:498
 do_dentry_open+0x4a1/0x11e0 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1213
 do_sys_open fs/open.c:1229 [inline]
 __do_sys_openat fs/open.c:1245 [inline]
 __se_sys_openat fs/open.c:1240 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1240
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fce8303c004
Code: 84 00 00 00 00 00 44 89 54 24 0c e8 96 f9 ff ff 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 c8 f9 ff ff 8b 44
RSP: 002b:00007fce8416cca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007fce8303c004
RDX: 0000000000000000 RSI: 00007fce8416cd40 RDI: 00000000ffffff9c
RBP: 00007fce8416cd40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffe79dbf38f R14: 00007fce8416d300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
