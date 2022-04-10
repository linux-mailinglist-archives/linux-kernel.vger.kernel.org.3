Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06084FAC2D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 07:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiDJFsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 01:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiDJFsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 01:48:30 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107866541F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 22:46:19 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id k20-20020a5e9314000000b00649d55ffa67so7845557iom.20
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 22:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QCvd5P6eT+fYZT498G/wD6AWG+51ZJ3UUxPZiS2SbjM=;
        b=sm2eqz0uw/1aYb/ec7wQlzxr3l8cK46eJYDt8Jiq64TqDaURzZGcBz/7IZh7hJtsey
         e5GT5kbE+I0nqzPsJaRIPq4X8FOyMmwWu1aSIBEnEblfzpjoTJjEMA7Ihz13F4j+/uv8
         4NX3xsZ6llyQjYmTcaF3fUey2stBXRutMIivXMpd1HlOsKkr0hCuvJ0DbsGAPLQuvUzQ
         //DXuurKo6GKzGJ5x9KxxYYjaO8HUWH9QLco9ikV1b+6sd2Qhqo3tjwWFx7x0QBTpp/w
         UCtDbm6LQr+DZpZ8VU/WFXBv6utI7+uIFztMXM4Wr4pRi7HSd03U91Y8Bt0tDrwU9f4+
         WN5g==
X-Gm-Message-State: AOAM533XknaksTqtisf4ugjxsG9hbiP5nG3G2kV1siHaQx5QmpDmgVVT
        mvyTwyYeDBtx2thGTEppVnnG/U4wiIM4wxAeS23chk1Y2b+s
X-Google-Smtp-Source: ABdhPJyLZQJIf6fuBzDXHnTwVVSe+svNP5nQv4V4XExHY/PeZBO39VVvC8WCaGAInveyjMK89dVvKyyun8tN0js0aampqvzfiPdF
MIME-Version: 1.0
X-Received: by 2002:a05:6638:498c:b0:324:2550:7038 with SMTP id
 cv12-20020a056638498c00b0032425507038mr7013671jab.284.1649569578089; Sat, 09
 Apr 2022 22:46:18 -0700 (PDT)
Date:   Sat, 09 Apr 2022 22:46:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc053a05dc46585f@google.com>
Subject: [syzbot] memory leak in __vsock_create
From:   syzbot <syzbot+b03f55bf128f9a38f064@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
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

HEAD commit:    ce4c854ee868 Merge tag 'for-5.18-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1099787f700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=983cf973af0d1b0f
dashboard link: https://syzkaller.appspot.com/bug?extid=b03f55bf128f9a38f064
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bf17f7700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12810bbf700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b03f55bf128f9a38f064@syzkaller.appspotmail.com

Warning: Permanently added '10.128.1.36' (ECDSA) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810ea56a40 (size 1232):
  comm "syz-executor756", pid 3604, jiffies 4294947681 (age 12.350s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace:
    [<ffffffff837c830e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1930
    [<ffffffff837cbe22>] sk_alloc+0x32/0x2e0 net/core/sock.c:1989
    [<ffffffff842ccf68>] __vsock_create.constprop.0+0x38/0x320 net/vmw_vsock/af_vsock.c:734
    [<ffffffff842ce8f1>] vsock_create+0xc1/0x2d0 net/vmw_vsock/af_vsock.c:2203
    [<ffffffff837c0cbb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c3acf>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c3acf>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c3bba>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c3bba>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c3bba>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff84512815>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84512815>] do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810fb89080 (size 96):
  comm "syz-executor756", pid 3604, jiffies 4294947681 (age 12.350s)
  hex dump (first 32 bytes):
    40 6a a5 0e 81 88 ff ff 00 00 00 00 00 00 00 00  @j..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff842d3767>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff842d3767>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff842d3767>] virtio_transport_do_socket_init+0x27/0xe0 net/vmw_vsock/virtio_transport_common.c:593
    [<ffffffff842cbaf0>] vsock_assign_transport+0x200/0x320 net/vmw_vsock/af_vsock.c:502
    [<ffffffff842cf8a8>] vsock_connect+0x128/0x5d0 net/vmw_vsock/af_vsock.c:1345
    [<ffffffff837c4722>] __sys_connect_file+0x92/0xa0 net/socket.c:1900
    [<ffffffff81667a4a>] io_connect+0x8a/0x370 fs/io_uring.c:5711
    [<ffffffff8166ea49>] io_issue_sqe+0xb29/0x2cb0 fs/io_uring.c:7294
    [<ffffffff81671c09>] __io_queue_sqe fs/io_uring.c:7605 [inline]
    [<ffffffff81671c09>] io_queue_sqe fs/io_uring.c:7647 [inline]
    [<ffffffff81671c09>] io_submit_sqe fs/io_uring.c:7855 [inline]
    [<ffffffff81671c09>] io_submit_sqes+0xa99/0x2ed0 fs/io_uring.c:7961
    [<ffffffff81674581>] __do_sys_io_uring_enter+0x541/0xa20 fs/io_uring.c:11011
    [<ffffffff84512815>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84512815>] do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
