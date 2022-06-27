Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1A55D9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbiF0HUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiF0HUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:20:23 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3535B5FE5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:20:22 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o17-20020a056e02115100b002d95d6881e4so5203414ill.19
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lAooD3J6mP7ldvQuXnQPEeD/OSwyoUVnXORpNT6oGQ4=;
        b=PILW1EvX523xt2pmFmNVx0zd8dpEr1D4njxe1w7LMicD0xLUV2xZalt+Jp5QxaOu4e
         cWbWhLaXzmtmE+5RWXLtpra8zqPMXe3xrO+TZdebK4WXiiOucoExAUdOP3sLrjHslQeh
         I9tXkjJFeTGRLU8CNWlLZ8WGRLhDSItrvfA0Yi/gBNX288PS9qPLvtX4X/uMM6t1aSrJ
         qn2iyJTgGBdnWVOl0RmuLPWyirxptMF2PN3Vlf/GTFt0M6r9d1rc955qLSaJAQMi4k2s
         99powUskYVwvHxm3+va9j6A5ZnAqI8gTuEyauvR0oCjbcxmeHQXcCwaaazIllRw5spZ3
         KDbQ==
X-Gm-Message-State: AJIora/fMlDefD/5UyDytRf+9n0cfLEtOQTCdsx8h6qrcCJmCh8HW+5G
        9HOnn7exP5tTENZKWhD6K56mDwqOZ5O4Dq6PQ+/WvWkhFEA2
X-Google-Smtp-Source: AGRyM1tvlyeAJjO6dUejWsKJFORmYey/AmBLekUTorRPnHIUUVtnsxpSr1l04EqASdEbnTsnlf4QYjHQN7L/R0eHTeA0tawJebbV
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2411:b0:339:e6f8:4240 with SMTP id
 z17-20020a056638241100b00339e6f84240mr7052091jat.306.1656314421611; Mon, 27
 Jun 2022 00:20:21 -0700 (PDT)
Date:   Mon, 27 Jun 2022 00:20:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc935c05e268c067@google.com>
Subject: [syzbot] WARNING in binder_alloc_vma_close
From:   syzbot <syzbot+da54fa8d793ca89c741f@syzkaller.appspotmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        hridya@google.com, joel@joelfernandes.org, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    08897940f458 Add linux-next specific files for 20220623
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=160dc3b0080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb185a52c6ad0a8e
dashboard link: https://syzkaller.appspot.com/bug?extid=da54fa8d793ca89c741f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ef6974080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b9f0d4080000

The issue was bisected to:

commit 472a68df605b149ca58e931b4936e3136f5ecca0
Author: Liam R. Howlett <Liam.Howlett@oracle.com>
Date:   Tue Jun 21 01:09:09 2022 +0000

    android: binder: stop saving a pointer to the VMA

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123596c4080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=113596c4080000
console output: https://syzkaller.appspot.com/x/log.txt?x=163596c4080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da54fa8d793ca89c741f@syzkaller.appspotmail.com
Fixes: 472a68df605b ("android: binder: stop saving a pointer to the VMA")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3611 at include/linux/mmap_lock.h:161 mmap_assert_write_locked include/linux/mmap_lock.h:161 [inline]
WARNING: CPU: 0 PID: 3611 at include/linux/mmap_lock.h:161 binder_alloc_set_vma drivers/android/binder_alloc.c:323 [inline]
WARNING: CPU: 0 PID: 3611 at include/linux/mmap_lock.h:161 binder_alloc_vma_close+0x123/0x170 drivers/android/binder_alloc.c:970
Modules linked in:
CPU: 0 PID: 3611 Comm: syz-executor763 Not tainted 5.19.0-rc3-next-20220623-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mmap_assert_write_locked include/linux/mmap_lock.h:161 [inline]
RIP: 0010:binder_alloc_set_vma drivers/android/binder_alloc.c:323 [inline]
RIP: 0010:binder_alloc_vma_close+0x123/0x170 drivers/android/binder_alloc.c:970
Code: 5b fa 48 8d bd 58 01 00 00 31 f6 e8 d7 44 5d 02 31 ff 41 89 c4 89 c6 e8 7b f8 5b fa 45 85 e4 0f 85 5b ff ff ff e8 1d fc 5b fa <0f> 0b e9 4f ff ff ff e8 11 fc 5b fa 48 89 ef e8 99 cd 91 fa 0f 0b
RSP: 0018:ffffc90002dffbe0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888078e119e0 RCX: 0000000000000000
RDX: ffff8880219d0000 RSI: ffffffff871ec183 RDI: 0000000000000005
RBP: ffff88807744c880 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88807744c880 R15: 0000000000000000
FS:  0000555556a5c300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6863e39130 CR3: 00000000217f4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 remove_vma+0x81/0x130 mm/mmap.c:187
 remove_mt mm/mmap.c:2232 [inline]
 do_mas_align_munmap+0x9e6/0xef0 mm/mmap.c:2507
 do_mas_munmap+0x202/0x2c0 mm/mmap.c:2562
 __vm_munmap+0x159/0x290 mm/mmap.c:2833
 __do_sys_munmap mm/mmap.c:2858 [inline]
 __se_sys_munmap mm/mmap.c:2855 [inline]
 __x64_sys_munmap+0x55/0x80 mm/mmap.c:2855
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f6863dc8099
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdc69a2808 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f6863dc8099
RDX: 00007f6863dc8099 RSI: 0000000000004000 RDI: 0000000020ffa000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00007ffdc69a2850
R13: 00007ffdc69a2840 R14: 00007ffdc69a2830 R15: 0000000000000000
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
