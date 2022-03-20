Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9E54E1E1B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 23:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343783AbiCTWFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 18:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbiCTWFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 18:05:45 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303D51263D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 15:04:19 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso9402285ioo.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 15:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=b/1oryzfHvRg4XC4e2sdbDRzFiWW93xl9aNeKRepNvQ=;
        b=XW3DswDgxJ6xRcDiRZMHdB6L4l9I/RFU7XzqnAVonc7GF1UavjEzqhAGYsDsWZDsbG
         9wZZM2Km7lJuA9cp36qtPlJjP61lfymYEYTCgBvkZ7gmURLVFvGJ/7ljDWEE0VAoxfiN
         DJsOb1hq+OapzGknJCl4UPEodktAsb3umbLbmAkYLepsVHQS9GT1JhQQu3wZAdHki/RQ
         eFxqJBCR8yjmYzGXaVfy1ABA8c5+N1lmLHjUj/6K+/ZWVwVBCdAGwogkUzE7meXnYmjs
         oyRnK5EXGYSlGoSjFCdpAvea6ruxQKDSO9kEQrBwDSS3VrZ280ZhcfdLRuUq6cCRDvIP
         +Cxg==
X-Gm-Message-State: AOAM533ynR0yU78Jv1WLuGp1+Z1Grp7ttuLjtJPjdxLczwJgmbCEWXPW
        tkqzEJQLHky+INdnhbvHFldCVDA4ZsvV9G2qd5AfdEPcQZey
X-Google-Smtp-Source: ABdhPJy0lq4ZnocPShXKj14+uR9/7djhKTQmzQ4hTwWHf+hUClThXhKCsxHfDIt9GdqYeMQRVsi4oXFsD04zMKl20qwJO5Q6KuD/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2395:b0:321:2570:590d with SMTP id
 q21-20020a056638239500b003212570590dmr4144884jat.114.1647813858523; Sun, 20
 Mar 2022 15:04:18 -0700 (PDT)
Date:   Sun, 20 Mar 2022 15:04:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1807c05daad8f98@google.com>
Subject: [syzbot] KASAN: null-ptr-deref Read in __free_pages
From:   syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
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

HEAD commit:    56e337f2cf13 Revert "gpio: Revert regression in sysfs-gpio..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e0a8c5700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
dashboard link: https://syzkaller.appspot.com/bug?extid=d55757faa9b80590767b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134e4e91700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127bd083700000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138601c5700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=104601c5700000
console output: https://syzkaller.appspot.com/x/log.txt?x=178601c5700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc794ecea0 R14: 000000000000000d R15: 00007ff328525490
 </TASK>
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
BUG: KASAN: null-ptr-deref in page_ref_count include/linux/page_ref.h:67 [inline]
BUG: KASAN: null-ptr-deref in put_page_testzero include/linux/mm.h:717 [inline]
BUG: KASAN: null-ptr-deref in __free_pages+0x1f/0x1b0 mm/page_alloc.c:5473
Read of size 4 at addr 0000000000000034 by task syz-executor168/3599

CPU: 1 PID: 3599 Comm: syz-executor168 Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __kasan_report mm/kasan/report.c:446 [inline]
 kasan_report.cold+0x66/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
 page_ref_count include/linux/page_ref.h:67 [inline]
 put_page_testzero include/linux/mm.h:717 [inline]
 __free_pages+0x1f/0x1b0 mm/page_alloc.c:5473
 watch_queue_set_size+0x499/0x630 kernel/watch_queue.c:275
 pipe_ioctl+0xac/0x2b0 fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff3284b2d59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc794ece38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000031 RCX: 00007ff3284b2d59
RDX: 0000000000000029 RSI: 0000000000005760 RDI: 0000000000000003
RBP: 00007ffc794ece40 R08: 0000000000000001 R09: 00007ffc794e0035
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc794ecea0 R14: 000000000000000d R15: 00007ff328525490
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
