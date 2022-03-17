Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F377D4DC036
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiCQHeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiCQHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:34:44 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D41699EDD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:33:26 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id w28-20020a05660205dc00b00645d3cdb0f7so2700094iox.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TXD53onF7jSioPaLEzYkXjzZs5nYo1PBwcqv+vMPmy8=;
        b=WVlzBv9xnRLaPWoO/eIARYsg8/yR6JufvqtG3/MGlTIJy69BrmRYcrmWddJQ4ON3yl
         QyS0hcsNl6GbdfXlcNNMhr63FplmARe147mubf5z6o8UxLlZtvMxNPtBrrQdNsXGd+1V
         L1dAl7Lqe0x8BTq1skM8a4q1LwgfZsW2a/ggRw/rwTvj9mINTQTEFG2o4epOa2UP0fdE
         +oQxhuzqdOoeNyjF9ZWj8E3dM3VrDFxg7oCitdgIcMbEJWdL3oxWraq8Hpr6h3hb7pmA
         G+GUzR96WcL4DG2r27VIbqoAB6DwGwOOfFXNZczgmzgPQX8v52nk1/bqslb1JlIooOMT
         o3RQ==
X-Gm-Message-State: AOAM530bv6MjRyvlFAqwdhla4v5NtCsEIuotLvhu8JL5ifHZCREtsmeJ
        aQGL/ctjpNvdSP8gX4f1shLEfIRT4F/SXI2xue02N7dl1nZn
X-Google-Smtp-Source: ABdhPJwkMsObrWiRRCcevnjxPP3cfk10pnUm5dioTbyRul+6q+oOx8iVwSNT7x/WskYwDn+9bOeOKnX3v5iNHKNV6xjOLgsLAcF+
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1583:b0:648:c289:2dab with SMTP id
 e3-20020a056602158300b00648c2892dabmr1602791iow.60.1647502405971; Thu, 17 Mar
 2022 00:33:25 -0700 (PDT)
Date:   Thu, 17 Mar 2022 00:33:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000acb4b105da650b31@google.com>
Subject: [syzbot] WARNING in floppy_revalidate
From:   syzbot <syzbot+c5732f0517748c2c8051@syzkaller.appspotmail.com>
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

HEAD commit:    aad611a868d1 Merge tag 'perf-tools-fixes-for-v5.17-2022-03..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160538d5700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aba0ab2928a512c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c5732f0517748c2c8051
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144e717e700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10909745700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c5732f0517748c2c8051@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3729 at drivers/block/floppy.c:1000 schedule_bh drivers/block/floppy.c:1000 [inline]
WARNING: CPU: 1 PID: 3729 at drivers/block/floppy.c:1000 process_fd_request drivers/block/floppy.c:2851 [inline]
WARNING: CPU: 1 PID: 3729 at drivers/block/floppy.c:1000 floppy_revalidate.isra.0+0x841/0xae0 drivers/block/floppy.c:4195
Modules linked in:
CPU: 1 PID: 3729 Comm: syz-executor117 Not tainted 5.17.0-rc7-syzkaller-00235-gaad611a868d1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:1000 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2851 [inline]
RIP: 0010:floppy_revalidate.isra.0+0x841/0xae0 drivers/block/floppy.c:4195
Code: 0f 0b e9 30 f9 ff ff 48 89 de 48 c7 c7 80 7b 6a 8c e8 63 d7 84 ff e9 84 f8 ff ff e8 b9 48 42 fd e9 11 fb ff ff e8 cf 62 fb fc <0f> 0b e9 16 fc ff ff e8 c3 62 fb fc 48 83 fb 07 0f 87 3b 02 00 00
RSP: 0018:ffffc900026ef8b0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888025c14200 RSI: ffffffff847c92c1 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8c6ae647
R10: ffffffff847c8ed5 R11: 0000000000000000 R12: ffffffff90804b10
R13: ffff888011a38800 R14: 0000000000000050 R15: 0000000000000001
FS:  000055555708b300(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002e48 CR3: 000000001c6d3000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_open+0xac5/0xd70 drivers/block/floppy.c:4041
 blkdev_get_whole+0x99/0x2d0 block/bdev.c:666
 blkdev_get_by_dev.part.0+0x5c6/0xc70 block/bdev.c:813
 blkdev_get_by_dev+0x6b/0x80 block/bdev.c:847
 blkdev_open+0x154/0x2e0 block/fops.c:503
 do_dentry_open+0x4b9/0x1250 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6b20681597
Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
RSP: 002b:00007ffd9192d9d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f6b20681597
RDX: 0000000000000000 RSI: 00007ffd9192da50 RDI: 00000000ffffff9c
RBP: 00007ffd9192da50 R08: 000000000000ffff R09: 00007ffd9192d8e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
