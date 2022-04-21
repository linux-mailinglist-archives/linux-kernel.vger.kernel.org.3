Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72019509530
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 04:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383850AbiDUC7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 22:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDUC7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:59:06 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6172E0A5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:56:17 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id q9-20020a056e02106900b002cbc8d479eeso1954327ilj.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MkhVPdo0Mafc1iZLuMEcUcshLRvLciC49yj/wqexpsw=;
        b=m2YlK3FAQBiLnN7kYfBHbFIMKfQzSXy92YXa1Nr9UuZ+G1M6MMoqtT2aop6+nZlFj2
         0+dU1FGvxuKybcJ9hzQ3vCPFk2ttA/8H/pps51teAOlBrakgPyrGidSQq9hf+TnIRqwE
         7aQAO3gYQiricnhz8RY97Q5JRpn5leHpJzGM6x/c78p6R2fHa6EdClvNmDj2ENVkXgOe
         pI/Y1/5GPyFZlizsiXbRIxtoFi5L0bYHU8fh8sufZBhEeXWTaaKwBnFW9LKdNExvrigC
         eiABkswyCi+RFBqqF0yIvtbFO06B6k8l255xWVw1WIQpergnFdqbh6UwKcv6olufG6lu
         ubtA==
X-Gm-Message-State: AOAM531sSgPzeZHVySKIlobo1ZJtwgHzug8YtNoqec/4X6NuLerkxTci
        aqS39i7s3e93mufVuKPgrluszu9Fn0QZ4DoMuLpza0kZHH2v
X-Google-Smtp-Source: ABdhPJzLXjOG5+JBy4hQ9FFFLFo07YwLAC5oxlQOrJcqZyPYVdTvN/+lknwbigBXxcU0NzRaXq3fXMf2B/IBN9wG9h1B91TweJno
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1527:b0:2cc:5bcf:d695 with SMTP id
 i7-20020a056e02152700b002cc5bcfd695mr2621577ilu.191.1650509777072; Wed, 20
 Apr 2022 19:56:17 -0700 (PDT)
Date:   Wed, 20 Apr 2022 19:56:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5f72c05dd2140d7@google.com>
Subject: [syzbot] memory leak in prepare_creds (3)
From:   syzbot <syzbot+b43f20e5dc7bddc29028@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    90ea17a9e27b Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b8ceb7700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8f1a3425e05af27
dashboard link: https://syzkaller.appspot.com/bug?extid=b43f20e5dc7bddc29028
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1385dd70f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d56140f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b43f20e5dc7bddc29028@syzkaller.appspotmail.com

Warning: Permanently added '10.128.1.125' (ECDSA) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888104810300 (size 176):
  comm "syz-executor344", pid 3589, jiffies 4294945176 (age 12.300s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8127c3c7>] prepare_creds+0x27/0x470 kernel/cred.c:260
    [<ffffffff8127d1f0>] copy_creds+0x40/0x2c0 kernel/cred.c:365
    [<ffffffff812377fe>] copy_process+0x5ce/0x23d0 kernel/fork.c:2094
    [<ffffffff81239833>] kernel_clone+0xf3/0x660 kernel/fork.c:2639
    [<ffffffff81239e16>] __do_sys_clone+0x76/0xa0 kernel/fork.c:2756
    [<ffffffff8451da15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8451da15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810cc24a40 (size 1232):
  comm "syz-executor344", pid 3598, jiffies 4294945177 (age 12.290s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace:
    [<ffffffff837d1bee>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1930
    [<ffffffff837d5862>] sk_alloc+0x32/0x2e0 net/core/sock.c:1989
    [<ffffffff842d78f8>] __vsock_create.constprop.0+0x38/0x320 net/vmw_vsock/af_vsock.c:734
    [<ffffffff842d9281>] vsock_create+0xc1/0x2d0 net/vmw_vsock/af_vsock.c:2203
    [<ffffffff837ca49b>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837cd41f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837cd41f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837cd50a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837cd50a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837cd50a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff8451da15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8451da15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810ea7e8e0 (size 32):
  comm "syz-executor344", pid 3598, jiffies 4294945177 (age 12.290s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82205353>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff82205353>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff82205353>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821caf11>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837d1c45>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1939
    [<ffffffff837d5862>] sk_alloc+0x32/0x2e0 net/core/sock.c:1989
    [<ffffffff842d78f8>] __vsock_create.constprop.0+0x38/0x320 net/vmw_vsock/af_vsock.c:734
    [<ffffffff842d9281>] vsock_create+0xc1/0x2d0 net/vmw_vsock/af_vsock.c:2203
    [<ffffffff837ca49b>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837cd41f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837cd41f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837cd50a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837cd50a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837cd50a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff8451da15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8451da15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810d6b4100 (size 96):
  comm "syz-executor344", pid 3598, jiffies 4294945177 (age 12.290s)
  hex dump (first 32 bytes):
    40 4a c2 0c 81 88 ff ff 00 00 00 00 00 00 00 00  @J..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff842de0c7>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff842de0c7>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff842de0c7>] virtio_transport_do_socket_init+0x27/0xe0 net/vmw_vsock/virtio_transport_common.c:593
    [<ffffffff842d6480>] vsock_assign_transport+0x200/0x320 net/vmw_vsock/af_vsock.c:502
    [<ffffffff842da238>] vsock_connect+0x128/0x5d0 net/vmw_vsock/af_vsock.c:1345
    [<ffffffff837ce072>] __sys_connect_file+0x92/0xa0 net/socket.c:1900
    [<ffffffff8166bbda>] io_connect+0x8a/0x370 fs/io_uring.c:5679
    [<ffffffff8167326d>] io_issue_sqe+0x119d/0x3210 fs/io_uring.c:7171
    [<ffffffff81675dd3>] __io_queue_sqe fs/io_uring.c:7499 [inline]
    [<ffffffff81675dd3>] io_queue_sqe fs/io_uring.c:7541 [inline]
    [<ffffffff81675dd3>] io_submit_sqe fs/io_uring.c:7746 [inline]
    [<ffffffff81675dd3>] io_submit_sqes+0x553/0x3020 fs/io_uring.c:7852
    [<ffffffff81678faa>] __do_sys_io_uring_enter+0x70a/0x1110 fs/io_uring.c:10797
    [<ffffffff8451da15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8451da15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
