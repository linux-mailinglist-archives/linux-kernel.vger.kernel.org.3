Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0863451428F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354679AbiD2Gpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiD2Gph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:45:37 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A24BB097
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:42:18 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id x16-20020a6bfe10000000b006409f03e39eso6049561ioh.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=l3uvIzx8owff86p9JQl2Fu7AJprV7tqHPmZVvDWo23Y=;
        b=QGXwWWaAAMtOR28Fl/btibjvXGNuCQnUF9WEEJ4Ea9H8apRHpzqvxiJC/xos02hqXY
         2LTlp1aJ9R5cLSZixULkZrQGLsfLkKCH3uBIiTz/x1eicAVx2IpQlKIZDg1TtvbzbSNo
         jLCD2iFcJUUYFNUPzkWgjGdCMA7psSVMUbGLqD8XyZ+qqux4XLieqvK21HSchO1S2XqY
         boR0HS7ygyDAC1P5KJ19m8X9nUz2YJ/8O7n6ixjEn1yDy4AaNX9qxsQfKsj80ykx9f3e
         +d3OQoSUWgDFM4whbHa5TUJ/FV0WvDst5/BuMTchQ2s45zFeGAvhjA/CQDBS3OXIpUHd
         5iLw==
X-Gm-Message-State: AOAM533gctiKIsEGTmvp1dt+yqBRfy98c1WPrf55cvns/ZIWl3bB+7sm
        PAQBsHxEzRZL87/mniYFSeuRkZ5KGOob09qwx16PQbuaHldY
X-Google-Smtp-Source: ABdhPJx4eNeHQmphQOEWZdtB8HqQTm1RUTsECKQxO5MwZe1wK0DtEboWIgLl45zB6dkp4eQiCGbw1L54lhqfnhXYHV/3KQR/ULPe
MIME-Version: 1.0
X-Received: by 2002:a05:6638:cd3:b0:32a:eec5:bbca with SMTP id
 e19-20020a0566380cd300b0032aeec5bbcamr10551459jak.99.1651214538309; Thu, 28
 Apr 2022 23:42:18 -0700 (PDT)
Date:   Thu, 28 Apr 2022 23:42:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001044205ddc55870@google.com>
Subject: [syzbot] possible deadlock in do_page_fault
From:   syzbot <syzbot+f8181becdab66ab4b181@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0966d385830d riscv: Fix auipc+jalr relocation range checks
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1128ae72f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6295d67591064921
dashboard link: https://syzkaller.appspot.com/bug?extid=f8181becdab66ab4b181
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8181becdab66ab4b181@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.17.0-rc1-syzkaller-00002-g0966d385830d #0 Not tainted
--------------------------------------------
dhcpcd-run-hook/3780 is trying to acquire lock:
ffffaf8010608d18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
ffffaf8010608d18 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault+0x24e/0xa3c arch/riscv/mm/fault.c:285

but task is already holding lock:
ffffaf8010608d18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
ffffaf8010608d18 (&mm->mmap_lock){++++}-{3:3}, at: setup_arg_pages+0x1aa/0x4b8 fs/exec.c:793

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&mm->mmap_lock);
  lock(&mm->mmap_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by dhcpcd-run-hook/3780:
 #0: ffffaf8010608d18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #0: ffffaf8010608d18 (&mm->mmap_lock){++++}-{3:3}, at: setup_arg_pages+0x1aa/0x4b8 fs/exec.c:793

stack backtrace:
CPU: 1 PID: 3780 Comm: dhcpcd-run-hook Not tainted 5.17.0-rc1-syzkaller-00002-g0966d385830d #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8000a228>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:113
[<ffffffff831668cc>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:119
[<ffffffff831756ba>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff831756ba>] dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:106
[<ffffffff83175742>] dump_stack+0x1c/0x24 lib/dump_stack.c:113
[<ffffffff8011404e>] print_deadlock_bug kernel/locking/lockdep.c:2956 [inline]
[<ffffffff8011404e>] check_deadlock kernel/locking/lockdep.c:2999 [inline]
[<ffffffff8011404e>] validate_chain kernel/locking/lockdep.c:3788 [inline]
[<ffffffff8011404e>] __lock_acquire+0x1dcc/0x333e kernel/locking/lockdep.c:5027
[<ffffffff80116582>] lock_acquire.part.0+0x1d0/0x424 kernel/locking/lockdep.c:5639
[<ffffffff8011682a>] lock_acquire+0x54/0x6a kernel/locking/lockdep.c:5612
[<ffffffff831ab656>] down_read+0x3c/0x54 kernel/locking/rwsem.c:1461
[<ffffffff800117d4>] mmap_read_lock include/linux/mmap_lock.h:117 [inline]
[<ffffffff800117d4>] do_page_fault+0x24e/0xa3c arch/riscv/mm/fault.c:285
[<ffffffff80005724>] ret_from_exception+0x0/0x10
[<ffffffff80c0069a>] __stack_depot_save+0x40/0x4b2 lib/stackdepot.c:360


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
