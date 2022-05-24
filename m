Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CF55332E8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbiEXVTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbiEXVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:19:29 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F7156F93
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:19:28 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id s198-20020a6b2ccf000000b0065e4872af2dso9411806ios.21
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wg+dhb4Sbt4LYM+C0ecpnWu6QVgFH/3cQ/wS9ie879w=;
        b=hm0FT4DIusk/8SX3cRK6C2bV9By9+UsorDh46xknLGlItmxVekwEvn1agbWEqkDdLV
         Es/iKTvmFJKA92LeqHP0jzeUnw2BXG0V4KqR4MyHB7hZkENsG0LIs6mvR4NI4zPhjm3o
         lFHWDeVcr7Y13TW1zS//t+0wNB2TmYQqZd+/Xq7pEvZiJUvKNHN67PxO0ydLEeriS/1S
         gjVXBLNt4teKin6MVXnNMtCwKw/+G8A3LWu3wOu4kO1ASerU+H5lHFbsgbY9ep3NJ/N7
         UKqOfA6Fn2YeoxuBqZxNyX9aHvVRbzqezqhrBPUJNB+pyZvxGfhWb9AWIKyqimOkCNHy
         jjOA==
X-Gm-Message-State: AOAM533hKFJqt600rOrJxcf2dBZf+3qmV1+5hRQl2CjBxIK3EmDz1J9s
        9JbBiAGXVR7Z/6FJm0/VuTNHcxz9FxIOfSwCMoPeaIe2us5a
X-Google-Smtp-Source: ABdhPJzO/J9UZT0CA4+FQ5CUbrwD+1WF2GLwg7LCkZPrxk61gqrW/MRloM29RYON3uBNiIVWny3XfQgI77wtUOGz3KiF6SxyJZcw
MIME-Version: 1.0
X-Received: by 2002:a05:6638:329b:b0:32e:d7c1:c30 with SMTP id
 f27-20020a056638329b00b0032ed7c10c30mr4706630jav.19.1653427167973; Tue, 24
 May 2022 14:19:27 -0700 (PDT)
Date:   Tue, 24 May 2022 14:19:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000259ba05dfc883a0@google.com>
Subject: [syzbot] memory leak in tty_init_dev (2)
From:   syzbot <syzbot+5e1694f5b0869a691915@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
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

HEAD commit:    3d7285a335ed Merge tag 'v5.18-p2' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1590d0e6f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50f4d49cdcacc43c
dashboard link: https://syzkaller.appspot.com/bug?extid=5e1694f5b0869a691915
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17647111f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ad531df00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e1694f5b0869a691915@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810da76400 (size 1024):
  comm "syz-executor299", pid 3683, jiffies 4294957001 (age 29.640s)
  hex dump (first 32 bytes):
    01 54 00 00 01 00 00 00 00 00 00 00 00 00 00 00  .T..............
    40 95 0d 04 81 88 ff ff 00 fc c4 84 ff ff ff ff  @...............
  backtrace:
    [<ffffffff825ee96c>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff825ee96c>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff825ee96c>] alloc_tty_struct+0x3c/0x2f0 drivers/tty/tty_io.c:3091
    [<ffffffff825eec40>] tty_init_dev.part.0+0x20/0x2f0 drivers/tty/tty_io.c:1412
    [<ffffffff825eef50>] tty_init_dev+0x40/0x60 drivers/tty/tty_io.c:1409
    [<ffffffff825fd949>] ptmx_open drivers/tty/pty.c:834 [inline]
    [<ffffffff825fd949>] ptmx_open+0xd9/0x210 drivers/tty/pty.c:800
    [<ffffffff815c628d>] chrdev_open+0x10d/0x340 fs/char_dev.c:414
    [<ffffffff815b4c46>] do_dentry_open+0x1e6/0x650 fs/open.c:824
    [<ffffffff815db101>] do_open fs/namei.c:3476 [inline]
    [<ffffffff815db101>] path_openat+0x18a1/0x1e70 fs/namei.c:3609
    [<ffffffff815dddd1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3636
    [<ffffffff815b841d>] do_sys_openat2+0xed/0x260 fs/open.c:1213
    [<ffffffff815b8e6f>] do_sys_open fs/open.c:1229 [inline]
    [<ffffffff815b8e6f>] __do_sys_openat fs/open.c:1245 [inline]
    [<ffffffff815b8e6f>] __se_sys_openat fs/open.c:1240 [inline]
    [<ffffffff815b8e6f>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1240
    [<ffffffff84565f05>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84565f05>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888109c1ce00 (size 512):
  comm "syz-executor299", pid 3683, jiffies 4294957001 (age 29.640s)
  hex dump (first 32 bytes):
    50 ce c1 09 81 88 ff ff e0 ff ff ff 0f 00 00 00  P...............
    10 ce c1 09 81 88 ff ff 10 ce c1 09 81 88 ff ff  ................
  backtrace:
    [<ffffffff825fdb42>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff825fdb42>] pty_common_install+0x72/0x3d0 drivers/tty/pty.c:382
    [<ffffffff825eec7b>] tty_driver_install_tty drivers/tty/tty_io.c:1307 [inline]
    [<ffffffff825eec7b>] tty_init_dev.part.0+0x5b/0x2f0 drivers/tty/tty_io.c:1419
    [<ffffffff825eef50>] tty_init_dev+0x40/0x60 drivers/tty/tty_io.c:1409
    [<ffffffff825fd949>] ptmx_open drivers/tty/pty.c:834 [inline]
    [<ffffffff825fd949>] ptmx_open+0xd9/0x210 drivers/tty/pty.c:800
    [<ffffffff815c628d>] chrdev_open+0x10d/0x340 fs/char_dev.c:414
    [<ffffffff815b4c46>] do_dentry_open+0x1e6/0x650 fs/open.c:824
    [<ffffffff815db101>] do_open fs/namei.c:3476 [inline]
    [<ffffffff815db101>] path_openat+0x18a1/0x1e70 fs/namei.c:3609
    [<ffffffff815dddd1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3636
    [<ffffffff815b841d>] do_sys_openat2+0xed/0x260 fs/open.c:1213
    [<ffffffff815b8e6f>] do_sys_open fs/open.c:1229 [inline]
    [<ffffffff815b8e6f>] __do_sys_openat fs/open.c:1245 [inline]
    [<ffffffff815b8e6f>] __se_sys_openat fs/open.c:1240 [inline]
    [<ffffffff815b8e6f>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1240
    [<ffffffff84565f05>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84565f05>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
