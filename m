Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6F15A9F45
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiIASnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIASnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:43:33 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A76B558F3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:43:31 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id z9-20020a056e02088900b002e35dba878cso13649422ils.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 11:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=tSm8RJxZnQES9hrhXTPiqnJb2qljBW6PGF4rDckYcBU=;
        b=KW7fDfak49USHHrUu4I6jsucFeIHli07s21oYdsgD9K3p0j7ijvXEQTwNA9lt1amfJ
         WieymR8ATqahckJo3XXg7/ydGHVBztRuQ1rKl0iQXrRyI5vDixntFsUAX/GiyoyCbMSA
         Jh/O09y3AQP7C8ZyHDTvX++lIrnCnstVqBsVsxquJO3hsrzaaGCEsQVeq0uyiJF8iuzK
         mAEPto8f+dEToDCvJlgFIIyvc21pjPMcgWFsXX9xoARf0wVD61iefu0QkhE+YbFzk3nr
         +7jsmJmoU5gWlOq2V6Rq5MBexYdEJvlCUMmvaIUwueG7zm6nNl+M1rb6TbDwz4JUlQuf
         FA9A==
X-Gm-Message-State: ACgBeo3JQNQ16sstA58YO7u7vEj7VGkOZJPJd6+Fwp7oQeI1bsO7wcV2
        sesvMlFT8Csu2kNg5ChXI8vFJ2fm1rEmhl3kh+U6AiQFzLvN
X-Google-Smtp-Source: AA6agR6ql9AjVH9LUPRZ2P8yA8RUqQd1MM1pz0LeQkxKH9hEtNfnFWcqV2+JI9Nodvy0fRGhQbv0Qt5qi/CHOPcXa90sPkYqb7VE
MIME-Version: 1.0
X-Received: by 2002:a6b:580e:0:b0:689:af21:6f3f with SMTP id
 m14-20020a6b580e000000b00689af216f3fmr16490897iob.116.1662057810886; Thu, 01
 Sep 2022 11:43:30 -0700 (PDT)
Date:   Thu, 01 Sep 2022 11:43:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a06a005e7a1fd95@google.com>
Subject: [syzbot] WARNING in floppy_shutdown
From:   syzbot <syzbot+046fef2eab0d7c657ca0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    10d4879f9ef0 Merge tag 'thermal-6.0-rc3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ba5d33080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=312be25752c7fe30
dashboard link: https://syzkaller.appspot.com/bug?extid=046fef2eab0d7c657ca0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+046fef2eab0d7c657ca0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 3723 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 2 PID: 3723 at drivers/block/floppy.c:999 process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 2 PID: 3723 at drivers/block/floppy.c:999 floppy_shutdown.cold+0x7b/0xaa drivers/block/floppy.c:1892
Modules linked in:
CPU: 2 PID: 3723 Comm: kworker/u16:3 Not tainted 6.0.0-rc2-syzkaller-00283-g10d4879f9ef0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: floppy floppy_shutdown
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:floppy_shutdown.cold+0x7b/0xaa drivers/block/floppy.c:1892
Code: 05 7e 95 f9 07 20 66 63 8a e8 99 37 77 f8 48 8b 1d 72 43 60 03 31 ff 83 e3 01 89 de e8 16 8b 2b f8 84 db 74 07 e8 8d 8e 2b f8 <0f> 0b e8 86 8e 2b f8 48 8b 35 0f 94 f9 07 bf 08 00 00 00 48 c7 c2
RSP: 0018:ffffc90003147d00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888014c16080 RSI: ffffffff894fab83 RDI: 0000000000000001
RBP: 0000000000000282 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffffc90003147da8 R14: ffff888014efd100 R15: ffff888011875800
FS:  0000000000000000(0000) GS:ffff88802c800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563743531680 CR3: 000000001a5d6000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
