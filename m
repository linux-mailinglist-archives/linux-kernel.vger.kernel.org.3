Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7B8532349
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiEXGfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiEXGfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:35:20 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EFA75230
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:35:19 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id a5-20020a056602208500b0066572ae07f8so1478824ioa.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DGNgBhDVvfVzkkpumuUcvhk3jujMVq/Vlb0VD5wROTY=;
        b=eXQITfmG8jBNYFrA0hWF6g9f2IfRLFgMjZJGTuRzpsUbijxNjHf/njKEPzNrcVDc3g
         s98oWg0XSvp9K1S/yu52Pg+JJeV/iJFz6fpoU1f+6dXc5Z2wMwMSWiaJTQ7oc7XpLEM5
         gbBueSXfHaY0WxHakyItQfW0VM4gAs5SG7nvzJLtHnly8GuWjdcK0NhevRkyU48W5xbL
         OGfhv8FVxE8Dn3vm5Uwsys14zV+Kefba27NojoHV9AuEglR47RD5pN0A7n9Ts8BVnNlY
         XI3lZGwUCYBKoW9jNbrW+rpfTBUKnjC0lmCdqzOcfPKUvZS9cVOzF3WE3GlKSZsBem9I
         vk5Q==
X-Gm-Message-State: AOAM530Mp4srj3EI+egjP4HagcnWWR/8yyZBHBaPtiIBuKf4SK4mx0cI
        7hvbguxyPJigbvPkX4K2NHrte7fTVr5Juh8t66RkAos9lmqG
X-Google-Smtp-Source: ABdhPJz9jKc5B0fN3K2if16xt2dQ2Wv0MuuN8mkQ52nXImUEjSA8a10iEFBmgnFvP+SExuoujifo860YZVSLf2vJ9ElAc72uA4NZ
MIME-Version: 1.0
X-Received: by 2002:a92:c54a:0:b0:2d1:c33a:c72e with SMTP id
 a10-20020a92c54a000000b002d1c33ac72emr1028140ilj.323.1653374119077; Mon, 23
 May 2022 23:35:19 -0700 (PDT)
Date:   Mon, 23 May 2022 23:35:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c6f9e05dfbc294e@google.com>
Subject: [syzbot] kernel BUG in __fscache_relinquish_cookie
From:   syzbot <syzbot+544cd0e72903f79d599d@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com,
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

HEAD commit:    b015dcd62b86 Merge tag 'for-5.18/parisc-4' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a4dccef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=edaa7ad763884c40
dashboard link: https://syzkaller.appspot.com/bug?extid=544cd0e72903f79d599d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+544cd0e72903f79d599d@syzkaller.appspotmail.com

FS-Cache: 1 == 0 is false
------------[ cut here ]------------
kernel BUG at fs/fscache/cookie.c:957!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 2 PID: 3705 Comm: syz-executor.3 Not tainted 5.18.0-rc7-syzkaller-00119-gb015dcd62b86 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:__fscache_relinquish_cookie.cold+0xee/0x107 fs/fscache/cookie.c:957
Code: c1 ea 03 0f b6 14 02 4c 89 e8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 14 48 63 75 04 31 d2 48 c7 c7 40 cc df 89 e8 57 99 fc ff <0f> 0b 4c 89 ef e8 24 12 97 f8 eb e2 48 89 ef e8 1a 12 97 f8 e9 72
RSP: 0000:ffffc90002f17b90 EFLAGS: 00010282
RAX: 0000000000000019 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888042fde1c0 RSI: ffffffff815f4a18 RDI: fffff520005e2f64
RBP: ffff888069794040 R08: 0000000000000019 R09: 0000000000000001
R10: ffffffff815ef3ee R11: 0000000000000000 R12: ffff888069794130
R13: ffff888069794044 R14: ffff88807894aab0 R15: ffff88801d84aa00
FS:  000055555661b400(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000451437 CR3: 00000000654f7000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fscache_relinquish_cookie include/linux/fscache.h:306 [inline]
 v9fs_evict_inode+0x1b1/0x2b0 fs/9p/vfs_inode.c:399
 evict+0x2ed/0x6b0 fs/inode.c:664
 dispose_list+0x117/0x1e0 fs/inode.c:697
 evict_inodes+0x350/0x450 fs/inode.c:747
 generic_shutdown_super+0xab/0x400 fs/super.c:451
 kill_anon_super+0x36/0x60 fs/super.c:1056
 v9fs_kill_super+0x39/0x90 fs/9p/vfs_super.c:223
 deactivate_locked_super+0x94/0x160 fs/super.c:332
 deactivate_super+0xad/0xd0 fs/super.c:363
 cleanup_mnt+0x3a2/0x540 fs/namespace.c:1186
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff00688a557
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff46e14f08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007ff00688a557
RDX: 00007fff46e14fd9 RSI: 000000000000000a RDI: 00007fff46e14fd0
RBP: 00007fff46e14fd0 R08: 00000000ffffffff R09: 00007fff46e14da0
R10: 000055555661c903 R11: 0000000000000246 R12: 00007ff0068e21f8
R13: 00007fff46e16090 R14: 000055555661c810 R15: 00007fff46e160d0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__fscache_relinquish_cookie.cold+0xee/0x107 fs/fscache/cookie.c:957
Code: c1 ea 03 0f b6 14 02 4c 89 e8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 14 48 63 75 04 31 d2 48 c7 c7 40 cc df 89 e8 57 99 fc ff <0f> 0b 4c 89 ef e8 24 12 97 f8 eb e2 48 89 ef e8 1a 12 97 f8 e9 72
RSP: 0000:ffffc90002f17b90 EFLAGS: 00010282
RAX: 0000000000000019 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888042fde1c0 RSI: ffffffff815f4a18 RDI: fffff520005e2f64
RBP: ffff888069794040 R08: 0000000000000019 R09: 0000000000000001
R10: ffffffff815ef3ee R11: 0000000000000000 R12: ffff888069794130
R13: ffff888069794044 R14: ffff88807894aab0 R15: ffff88801d84aa00
FS:  000055555661b400(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff131d09b8 CR3: 00000000654f7000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
