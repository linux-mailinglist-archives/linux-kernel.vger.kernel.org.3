Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E95E4ECAEB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349434AbiC3RoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343849AbiC3RoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:44:14 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5DCF47D9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:42:29 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id f10-20020a056e020c6a00b002c9ef5c9df4so882731ilj.22
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=v89tVw8ySyr98HqbPOA8KhBHppRaKTd45nWoytVaQ0U=;
        b=mzm5T1PYPlZc1tz5c49rXxPE0mcEypVoVfZC5zPzvqX8Aq/Se7wAfjRAwryMMIQvzZ
         mSInzwmTWQ+X/h0SIgBIAZkZSGk6Iz2OpyTq4sSbsoWJrReOF5cLePsP63jdUJy4OADc
         mqnd6SVArDsP8qRmBFuScx9fWBbZghsPFCL++CGU7SbD+e5cCVe7RFDCBTjozUqGfW2l
         BdH5adU8UAZBp/ls7wzOzCsIXrBb1HEl+G3Tru6UvgkiwRXwex/QMTJ8LQavq9rRd5Gz
         anL40aGvmEOhZit/U0V4Iy/hc84W++L4mrduLvBx6KARmGE8DWpE30s3xxPZmO/8s5YN
         G1ZA==
X-Gm-Message-State: AOAM530yvrytkfaqDCqtGkPsJCrr0ctcKQfwzRrOEak8xdGeXWoVnWxn
        CoX/QavNPKtEwNa2iGnL8L50wFTx2WLWsYHGdx13JgJDECH6
X-Google-Smtp-Source: ABdhPJyiz50nZ2RWpGYPBTvfpWsTpAwBWqsfVFFK+b/4bOJNNcHpmERV4SikYJ2bYt+Yp6SYDg/ejepWPdxLAKCPQ7gkC/gl80c6
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1453:b0:319:c928:5ccd with SMTP id
 l19-20020a056638145300b00319c9285ccdmr543819jad.136.1648662148565; Wed, 30
 Mar 2022 10:42:28 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:42:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b850b905db73117a@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in
 f2fs_update_meta_page (2)
From:   syzbot <syzbot+9e29d4a176b24eaa4fc1@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
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

HEAD commit:    ae085d7f9365 mm: kfence: fix missing objcg housekeeping fo..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a11a77700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91f0a0c422e301dd
dashboard link: https://syzkaller.appspot.com/bug?extid=9e29d4a176b24eaa4fc1
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e29d4a176b24eaa4fc1@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 1ef8e067 P4D 1ef8e067 PUD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3615 Comm: syz-executor.0 Tainted: G        W         5.17.0-syzkaller-11407-gae085d7f9365 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000400f818 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffea0000c768c0 RCX: ffff88801a581d00
RDX: 0000000000000000 RSI: ffffea0000c768c0 RDI: ffff88802c0203b8
RBP: ffffc9000400faf0 R08: ffffffff81b497cb R09: fffff9400018ed19
R10: fffff9400018ed19 R11: 0000000000000000 R12: ffff88807bb85b10
R13: 0000000000000001 R14: ffff888040fea000 R15: ffff888058d74000
FS:  000055555607f400(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000479d6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 f2fs_update_meta_page+0x45/0x60 fs/f2fs/segment.c:2484
 do_checkpoint fs/f2fs/checkpoint.c:1527 [inline]
 f2fs_write_checkpoint+0x3136/0x5b80 fs/f2fs/checkpoint.c:1689
 f2fs_issue_checkpoint+0x361/0x4e0
 sync_filesystem+0x1bc/0x220 fs/sync.c:66
 generic_shutdown_super+0x6b/0x300 fs/super.c:445
 kill_block_super+0x79/0xd0 fs/super.c:1394
 kill_f2fs_super+0x2f9/0x3c0 fs/f2fs/super.c:4546
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x462/0x510 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:190 [inline]
 exit_to_user_mode_prepare+0x1dd/0x200 kernel/entry/common.c:222
 __syscall_exit_to_user_mode_work kernel/entry/common.c:304 [inline]
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:315
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f48a848a4b7
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd9c82d6e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f48a848a4b7
RDX: 00007ffd9c82d7bc RSI: 000000000000000a RDI: 00007ffd9c82d7b0
RBP: 00007ffd9c82d7b0 R08: 00000000ffffffff R09: 00007ffd9c82d580
R10: 00005555560808b3 R11: 0000000000000246 R12: 00007f48a84e21ea
R13: 00007ffd9c82e870 R14: 0000555556080810 R15: 00007ffd9c82e8b0
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000400f818 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffea0000c768c0 RCX: ffff88801a581d00
RDX: 0000000000000000 RSI: ffffea0000c768c0 RDI: ffff88802c0203b8
RBP: ffffc9000400faf0 R08: ffffffff81b497cb R09: fffff9400018ed19
R10: fffff9400018ed19 R11: 0000000000000000 R12: ffff88807bb85b10
R13: 0000000000000001 R14: ffff888040fea000 R15: ffff888058d74000
FS:  000055555607f400(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000479d6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
