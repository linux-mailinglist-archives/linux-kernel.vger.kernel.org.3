Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8133E550E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 03:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbiFTBra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 21:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiFTBr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:47:29 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6382A647A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:47:28 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id u8-20020a056e021a4800b002d3a5419d1bso6620060ilv.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xvZkpgihzeXSfHGfqkZp0yoHFvkneKgI8mBcxwRpQeo=;
        b=evRSBRIeyjgKjb0muerRwqSQEbKIoIDY92shYxZMHBxFQPceYhVHpu2unvDe+FE5Tp
         pb93ZMvoPIbocyxiPHgwrnJJrnQ9yG59cLXP6nsxswXn90Z/WmzNtmkKRL/GD/S+P61K
         m/NGUR1eIDq2livkhwZ/BRjRd4ZhkXI+aL4Ns7VaeFeFPHIkWei6kD1jYuWOYcJB6Li1
         hRBRb4LjVXE6g5ojpb2j8zcpnJxEwKpFjNoE5wq50J6r2DnaOEQ5P3w9BpS/IEmpiiz6
         3zLWGyF0XEILB98fysu0X5LgDXIAu11IJSdCcZ2qL5wlc+TZ8gvRU1ODl+l4YBfCP7lS
         NLPg==
X-Gm-Message-State: AJIora9Ux/ozhCcszHmiG83ngHM+o3GtDFC3Y7PszLxIlBVWQcLIE/aI
        22RC3lKRRm3A3GeHa1p0nnad/VXV+tlXiUa66gGe7rxPNgFG
X-Google-Smtp-Source: AGRyM1shNihDwRuReC2arFM7R59MgvI+tpQsKWTC0nCvQFtPvfelmgv5EH0ISdbjMT5LyKXwolmSuEE3E4dfdWcDMuI/aLFsL/B/
MIME-Version: 1.0
X-Received: by 2002:a92:dc91:0:b0:2d8:ecc3:ffb5 with SMTP id
 c17-20020a92dc91000000b002d8ecc3ffb5mr6877125iln.170.1655689647359; Sun, 19
 Jun 2022 18:47:27 -0700 (PDT)
Date:   Sun, 19 Jun 2022 18:47:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a0dbe05e1d749e0@google.com>
Subject: [syzbot] kernel BUG in binder_alloc_deferred_release
From:   syzbot <syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com>
To:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
        arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        hridya@google.com, joel@joelfernandes.org, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        willy@infradead.org
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

HEAD commit:    6012273897fe Add linux-next specific files for 20220615
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16596feff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4154677977b1776
dashboard link: https://syzkaller.appspot.com/bug?extid=58b51ac2b04e388ab7b0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1024e510080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113e407ff00000

The issue was bisected to:

commit 42086abba43463fbf495cb80173600284b4c4e8c
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Tue Jun 14 19:00:27 2022 +0000

    mm: start tracking VMAs with maple tree

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10ef827ff00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12ef827ff00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14ef827ff00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com
Fixes: 42086abba434 ("mm: start tracking VMAs with maple tree")

------------[ cut here ]------------
kernel BUG at drivers/android/binder_alloc.c:820!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 2934 Comm: kworker/0:3 Not tainted 5.19.0-rc2-next-20220615-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events binder_deferred_func
RIP: 0010:binder_alloc_deferred_release+0x602/0x780 drivers/android/binder_alloc.c:820
Code: c6 80 16 c7 8a 48 c7 c7 80 b6 48 8d e8 57 86 05 fd 31 ff 89 c5 89 c6 e8 fc ba 5b fa 85 ed 74 c6 e9 78 57 55 02 e8 9e be 5b fa <0f> 0b c7 44 24 20 00 00 00 00 e9 27 ff ff ff e8 8a be 5b fa 48 89
RSP: 0018:ffffc9000de07bc8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880519971e0 RCX: 0000000000000000
RDX: ffff888026b0d7c0 RSI: ffffffff871f04b2 RDI: ffff888051997270
RBP: ffff888051997000 R08: 0000000000000000 R09: ffffffff8dbcac17
R10: fffffbfff1b79582 R11: 0000000000000000 R12: ffff888147653c60
R13: ffff8880519972d8 R14: ffff888147653d10 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f99ddec19c1 CR3: 0000000077a01000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 binder_free_proc drivers/android/binder.c:4766 [inline]
 binder_proc_dec_tmpref drivers/android/binder.c:1433 [inline]
 binder_proc_dec_tmpref+0x2aa/0x530 drivers/android/binder.c:1426
 binder_deferred_release drivers/android/binder.c:5761 [inline]
 binder_deferred_func+0xe2a/0x1150 drivers/android/binder.c:5788
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:binder_alloc_deferred_release+0x602/0x780 drivers/android/binder_alloc.c:820
Code: c6 80 16 c7 8a 48 c7 c7 80 b6 48 8d e8 57 86 05 fd 31 ff 89 c5 89 c6 e8 fc ba 5b fa 85 ed 74 c6 e9 78 57 55 02 e8 9e be 5b fa <0f> 0b c7 44 24 20 00 00 00 00 e9 27 ff ff ff e8 8a be 5b fa 48 89
RSP: 0018:ffffc9000de07bc8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880519971e0 RCX: 0000000000000000
RDX: ffff888026b0d7c0 RSI: ffffffff871f04b2 RDI: ffff888051997270
RBP: ffff888051997000 R08: 0000000000000000 R09: ffffffff8dbcac17
R10: fffffbfff1b79582 R11: 0000000000000000 R12: ffff888147653c60
R13: ffff8880519972d8 R14: ffff888147653d10 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f99ddec19c1 CR3: 000000001bb00000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
