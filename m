Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039A85305C5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351043AbiEVUN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiEVUNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:13:24 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B58369D1
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:13:23 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id x8-20020a056e021ca800b002d1332831deso7497051ill.23
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=V2egRK35LLO/DNzGGJrV12+GHS4O2lGLZM4ZUtaAVsQ=;
        b=T+igF8Zd9g1dX+eMrjqvPi4Zb2hqs0GQmv+Cv6SUHIbKQCI8RQ//NjcH4Z3PFwtWK9
         Mv5l5YgTaOnJ4yFnCw4PNKxEL4dqCh5Rn954g3rBEcwhffCQz1IwW1HO63Ehmm1Wkb+O
         +BRRRx1RGSburunLMiKkETUmGuMlQEkAz0TmXWKCuZ/ZKy8+R684v7cgQSXN2caMJzo0
         qDcgvs/q7Jon2IL53k3VWQiOJwx+4KW23KcsfxZnP5jZhoXM1ShbNerqNMQdRaUM++kF
         BoZrEIWEm+GzqH02cL8y3tY4cEWsrAEPNLaYeGaxdf5QM6yyO7g0TeJQyXca3B8VU44b
         0dDw==
X-Gm-Message-State: AOAM532OknpRjYIeX2pVe1BKtxyGWsG5I2xLsVoMYWpZVDGazoDM8ZqI
        K9wjZ1aUuYBf+8qjSOPkWtklZtYeDj9LXksTVcDoivTl0sTh
X-Google-Smtp-Source: ABdhPJxUopgqdwl6mIbOm2npgUz5vgw7wPKsNCZGjmg74bWW6GKinb/ct7yjfbVFvc/CLi+d3xX0FB8g3nlcdiCIJPzKkUF7b/g1
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3052:b0:317:79e1:8b7f with SMTP id
 u18-20020a056638305200b0031779e18b7fmr9950637jak.239.1653250402098; Sun, 22
 May 2022 13:13:22 -0700 (PDT)
Date:   Sun, 22 May 2022 13:13:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f121b705df9f5a0a@google.com>
Subject: [syzbot] WARNING in folio_account_dirtied
From:   syzbot <syzbot+8d1d62bfb63d6a480be1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    ef1302160bfb Merge tag 'sound-5.18' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17626629f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d84df8e1a4c4d5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=8d1d62bfb63d6a480be1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d1d62bfb63d6a480be1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 19258 at include/linux/backing-dev.h:264 folio_account_dirtied+0x61a/0x720 mm/page-writeback.c:2448
Modules linked in:
CPU: 1 PID: 19258 Comm: syz-executor.3 Not tainted 5.18.0-rc7-syzkaller-00015-gef1302160bfb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:inode_to_wb include/linux/backing-dev.h:261 [inline]
RIP: 0010:folio_account_dirtied+0x61a/0x720 mm/page-writeback.c:2448
Code: ff ff e9 6e fd ff ff e8 c4 6d d2 ff 4c 89 f7 4c 89 e6 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 eb af 29 00 e8 a6 6d d2 ff <0f> 0b 43 80 3c 3c 00 0f 85 36 fd ff ff e9 39 fd ff ff 48 c7 c1 f4
RSP: 0018:ffffc90002e5f840 EFLAGS: 00010093
RAX: ffffffff81b3a75a RBX: 0000000000000000 RCX: ffff8880795c9d80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888140c8ef80 R08: ffffffff81b3a71e R09: fffff940003cd8c9
R10: fffff940003cd8c9 R11: 1ffffd40003cd8c8 R12: 1ffff11028191df0
R13: 0000000000000001 R14: ffffea0001e6c640 R15: dffffc0000000000
FS:  0000555556a2c400(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0157c0000 CR3: 0000000034a53000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000003b DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __folio_mark_dirty+0x125/0x260 mm/page-writeback.c:2499
 __set_page_dirty include/linux/pagemap.h:1008 [inline]
 mark_buffer_dirty+0x263/0x560 fs/buffer.c:1105
 gfs2_unpin+0x116/0xa40 fs/gfs2/lops.c:111
 buf_lo_after_commit+0x172/0x1d0 fs/gfs2/lops.c:747
 lops_after_commit fs/gfs2/lops.h:49 [inline]
 gfs2_log_flush+0x1258/0x2770 fs/gfs2/log.c:1108
 do_sync+0xbe7/0xe60 fs/gfs2/quota.c:967
 gfs2_quota_sync+0x3da/0x8b0 fs/gfs2/quota.c:1310
 gfs2_sync_fs+0x49/0xb0 fs/gfs2/super.c:642
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x300 fs/super.c:445
 kill_block_super+0x79/0xd0 fs/super.c:1394
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x452/0x500 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x134/0x160 kernel/entry/common.c:169
 exit_to_user_mode_prepare+0xad/0x110 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1c2e88a557
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff1b126788 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f1c2e88a557
RDX: 00007fff1b12685a RSI: 000000000000000a RDI: 00007fff1b126850
RBP: 00007fff1b126850 R08: 00000000ffffffff R09: 00007fff1b126620
R10: 0000555556a2d8b3 R11: 0000000000000246 R12: 00007f1c2e8e21f8
R13: 00007fff1b127910 R14: 0000555556a2d810 R15: 00007fff1b127950
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
