Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C2E535A22
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343589AbiE0HO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244898AbiE0HOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:14:24 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E691340CB
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:14:18 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so2327309iov.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=j6ajVUzEB2nrik9UDH5ays8VM265tKSlOxXcqrRJfe0=;
        b=mTI7rRp8HkQ1p6EyvZnm5IGSZ6OUhGtJlug1Zd1t1d1Q4ZAxvHKRRsE+74gWRf69nW
         o80LSs6Wj3YHSh3mmyjmwQokHD7V0SSryEz3jNi/bv3IYrzLSs+lhKWMhtXa9Mc6puVE
         Ma++6XOEkigUpRg2t7D/nLJq88Xk85Jf6TW5JDKDnznCCvvxToptMXw/4jNFGihQxWhK
         U1c1AiS5sS1/wbqQcXEEe54nf5UUUFvQsi0vS1svDFudjHDkb0N5/nWqafDexyKY2QR7
         ZiMd9q1nhJ7tmOduqo9xD5PkhSIgr8pOSe3jJQZ+ULFVn7pzCuPoULszeJd7vSX1Y47s
         mX2A==
X-Gm-Message-State: AOAM533aTRcvidm4uQ/RpZZxFEtfOi3MoC+kecUrAAjIG81rvVQpS3dj
        gWUS6veeJEGZyQFsUet2a+7yVfjdPHh7qRdTIxz2SPQtJy7K
X-Google-Smtp-Source: ABdhPJzKvFehj6RJR8jNqMdUmoWzn/hPh5oZfOEw3/QLuOwNm3XZBvKGKJ3t1u/C5tUpratD8M3zD9cZMEuFJz94LM4S7ewLmAUn
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca3:b0:2d1:aad8:9043 with SMTP id
 x3-20020a056e021ca300b002d1aad89043mr12036923ill.200.1653635657568; Fri, 27
 May 2022 00:14:17 -0700 (PDT)
Date:   Fri, 27 May 2022 00:14:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5181405dff90d7f@google.com>
Subject: [syzbot] WARNING in floppy_queue_rq
From:   syzbot <syzbot+334c1c7dfb084b11520e@syzkaller.appspotmail.com>
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

HEAD commit:    babf0bb978e3 Merge tag 'xfs-5.19-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1257af23f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb7a468cb4ea251
dashboard link: https://syzkaller.appspot.com/bug?extid=334c1c7dfb084b11520e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+334c1c7dfb084b11520e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 0 PID: 9 at drivers/block/floppy.c:999 process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 0 PID: 9 at drivers/block/floppy.c:999 floppy_queue_rq+0x32b/0x390 drivers/block/floppy.c:2879
Modules linked in:

CPU: 0 PID: 9 Comm: kworker/0:1H Not tainted 5.18.0-syzkaller-07857-gbabf0bb978e3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: kblockd blk_mq_run_work_fn

RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:floppy_queue_rq+0x32b/0x390 drivers/block/floppy.c:2879
Code: ea 03 80 3c 02 00 75 67 48 8b 56 30 48 c7 c7 80 41 42 8a e8 cd f9 96 04 0f 0b 41 bc 0a 00 00 00 e9 36 ff ff ff e8 a5 b0 e1 fc <0f> 0b e9 ec fe ff ff 48 89 df e8 96 f6 2d fd e9 ee fc ff ff 48 89
RSP: 0018:ffffc900003af928 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888011408000 RSI: ffffffff849817cb RDI: 0000000000000003
RBP: ffffffff8c8e9820 R08: 0000000000000000 R09: ffffffff8c8e8b47
R10: ffffffff849816b5 R11: 00000000ffffff80 R12: ffff888019d7f048
R13: ffff888019d7f000 R14: ffffc900003afb68 R15: ffff888019d7f048
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000030921000 CR3: 0000000057352000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blk_mq_dispatch_rq_list+0x6ea/0x2340 block/blk-mq.c:1908
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:173 [inline]
 blk_mq_do_dispatch_sched+0x96a/0xc20 block/blk-mq-sched.c:187
 __blk_mq_sched_dispatch_requests+0x26d/0x3d0 block/blk-mq-sched.c:313
 blk_mq_sched_dispatch_requests+0x101/0x180 block/blk-mq-sched.c:339
 __blk_mq_run_hw_queue+0xff/0x350 block/blk-mq.c:2025
 blk_mq_run_work_fn+0x55/0x70 block/blk-mq.c:2363
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
