Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830F74E1F10
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbiCUCfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbiCUCfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:35:46 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F461CB3E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:34:22 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id z10-20020a056602080a00b00645b9fdc630so9714804iow.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QUoEilwGQJjP61Rbh2F5H2HodIumWRf1OPJbJQ3Sj30=;
        b=hKjf01h6yhdDU+92hdccbLOIZO6tznwFMQML8cM5QBKndWI8mPMTqcit81JqbJO3+b
         jJcTGp/1Ubwjw+nF7zdhlVVinTGYeJzzuvSHr/xoyM5TAf5sif8px4AE02uyIEOxFfVz
         qWwgPzu9P8dEQWz7uicmBwJf76aytdWgRsxKjNkurP31BKSad8Yq4B2G0Vef9G7s/ATz
         6yI2toOOU287L0mECEYPRZEqGxMZ+X54KmyOn7VBo5zPZW7B16QwguVFAeL/6xp1ye4V
         18c5zd8nj+QRmPPVVOe4AuWtYpxJy6vopkdMnohvaeBIk9FG6nseuYswXOrhE9nVlDnF
         RUdg==
X-Gm-Message-State: AOAM533hUf0Maa8CqMrG59GQJzHxAgo5jUl87qPHILrkHir3+iWDDGG6
        h95+OpKtnCmDqjFtXDh6mYzGV/irq+EgCIYEYpKQsLtIj9x4
X-Google-Smtp-Source: ABdhPJzAK13m+gUK9RaNc20ucH1OYiQqrDun+TrkHcBIsnzAAFBfFE6CgTLlnkUGXF+BZkdkQ2Bly31xNhTpgQ/hQ3vLEbT9M2Ea
MIME-Version: 1.0
X-Received: by 2002:a02:5b85:0:b0:319:ff85:ff5 with SMTP id
 g127-20020a025b85000000b00319ff850ff5mr10161038jab.250.1647830061515; Sun, 20
 Mar 2022 19:34:21 -0700 (PDT)
Date:   Sun, 20 Mar 2022 19:34:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000778f1005dab1558e@google.com>
Subject: [syzbot] possible deadlock in pipe_write
From:   syzbot <syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    56e337f2cf13 Revert "gpio: Revert regression in sysfs-gpio..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f00f7e700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
dashboard link: https://syzkaller.appspot.com/bug?extid=011e4ea1da6692cf881c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133235c5700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1248ca89700000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f235c5700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11f235c5700000
console output: https://syzkaller.appspot.com/x/log.txt?x=16f235c5700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0 Not tainted
--------------------------------------------
syz-executor190/3593 is trying to acquire lock:
ffff888078020868 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:103 [inline]
ffff888078020868 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x132/0x1c00 fs/pipe.c:431

but task is already holding lock:
ffff888078020468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_lock_nested fs/pipe.c:82 [inline]
ffff888078020468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_lock fs/pipe.c:90 [inline]
ffff888078020468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_wait_readable+0x39b/0x420 fs/pipe.c:1049

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&pipe->mutex/1);
  lock(&pipe->mutex/1);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz-executor190/3593:
 #0: ffff888078020468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_lock_nested fs/pipe.c:82 [inline]
 #0: ffff888078020468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_lock fs/pipe.c:90 [inline]
 #0: ffff888078020468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_wait_readable+0x39b/0x420 fs/pipe.c:1049

stack backtrace:
CPU: 1 PID: 3593 Comm: syz-executor190 Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2956 [inline]
 check_deadlock kernel/locking/lockdep.c:2999 [inline]
 validate_chain kernel/locking/lockdep.c:3788 [inline]
 __lock_acquire.cold+0x213/0x3a9 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 __mutex_lock_common kernel/locking/mutex.c:600 [inline]
 __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:733
 __pipe_lock fs/pipe.c:103 [inline]
 pipe_write+0x132/0x1c00 fs/pipe.c:431
 call_write_iter include/linux/fs.h:2074 [inline]
 do_iter_readv_writev+0x47a/0x750 fs/read_write.c:725
 do_iter_write+0x188/0x710 fs/read_write.c:851
 vfs_iter_write+0x70/0xa0 fs/read_write.c:892
 iter_file_splice_write+0x723/0xc70 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 do_splice+0xb7e/0x1960 fs/splice.c:1079
 __do_splice+0x134/0x250 fs/splice.c:1144
 __do_sys_splice fs/splice.c:1350 [inline]
 __se_sys_splice fs/splice.c:1332 [inline]
 __x64_sys_splice+0x198/0x250 fs/splice.c:1332
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb9ac14bca9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb9ac0fe308 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: fffffff


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
