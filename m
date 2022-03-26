Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603FA4E8371
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 19:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiCZSpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 14:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiCZSpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 14:45:06 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689C7CC517
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:43:29 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id f11-20020a056602070b00b00645d08010fcso7182163iox.15
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3hGRuxIv8jYfcaWGhnr9kvsCvj0FJXA0ErhdaI1jX6g=;
        b=QbEuQswsV6x+7KnbpFLaaexIRIwFELIsSobU91mPdS39snx6tJRv2ZQUAPs7qsfWfv
         wH0fttsl6yZWJiK0GvoNEJCqbXUEYaPYSzaR5rX7Bq9kNO4w1TL/brwmHg/gFKXS9kv6
         kd3NXlGikGZUcUH9R/VvzAJP5OTMAvWKtKWbJRA1MOwXY2yXRpY69y/EvKJKFuwkMEY0
         B5bdMfzO0Kbk41Lo2BIyk6ucx4ZOPX3sSt3Ssm4UoeF949aITVurAee/a1XXbdFCeLG3
         dElN6tssh5lGwArD5L6E+NIK8MVWcFLdiY+qqP5ax9ElcQBRDm8BIJdhPdZJCuZyXLnB
         3Tzg==
X-Gm-Message-State: AOAM531dYjYBr5KgsUB9dt38iitJDMJ0KZcKBcSEJEXjKupzSm/EIgiS
        dZttpUd0z/ZQr057xpo0/x3aH/JqOoSCFBa9VsH8dvVp3V++
X-Google-Smtp-Source: ABdhPJzsFUivzgdwRnFyfZbtHJZvpKIcwRfzkjasjQWTCDuuYgJOlXvnvwWDVH4EhbIOCfXS91NsyOGEYPlcTlYWroxU5BZjPBmQ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1591:b0:60f:6acc:6979 with SMTP id
 e17-20020a056602159100b0060f6acc6979mr2473309iow.173.1648320208748; Sat, 26
 Mar 2022 11:43:28 -0700 (PDT)
Date:   Sat, 26 Mar 2022 11:43:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084c28705db2374a7@google.com>
Subject: [syzbot] memory leak in watch_queue_set_size
From:   syzbot <syzbot+25ea042ae28f3888727a@syzkaller.appspotmail.com>
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

HEAD commit:    34e047aa16c0 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ac6f83700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c80259f3b3fdf91
dashboard link: https://syzkaller.appspot.com/bug?extid=25ea042ae28f3888727a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dc9c95700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dd7871700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25ea042ae28f3888727a@syzkaller.appspotmail.com

Warning: Permanently added '10.128.10.51' (ECDSA) to the list of known hosts.
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810d9bc140 (size 32):
  comm "syz-executor335", pid 3603, jiffies 4294946994 (age 12.840s)
  hex dump (first 32 bytes):
    40 a7 40 04 00 ea ff ff 00 00 00 00 00 00 00 00  @.@.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81459bff>] kmalloc_array include/linux/slab.h:621 [inline]
    [<ffffffff81459bff>] kcalloc include/linux/slab.h:652 [inline]
    [<ffffffff81459bff>] watch_queue_set_size+0x12f/0x2e0 kernel/watch_queue.c:251
    [<ffffffff8159fcf2>] pipe_ioctl+0x82/0x140 fs/pipe.c:632
    [<ffffffff815b601c>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff815b601c>] __do_sys_ioctl fs/ioctl.c:874 [inline]
    [<ffffffff815b601c>] __se_sys_ioctl fs/ioctl.c:860 [inline]
    [<ffffffff815b601c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:860
    [<ffffffff84493a05>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84493a05>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810d9b2440 (size 32):
  comm "syz-executor335", pid 3606, jiffies 4294947528 (age 7.500s)
  hex dump (first 32 bytes):
    40 4d 36 04 00 ea ff ff 00 00 00 00 00 00 00 00  @M6.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81459bff>] kmalloc_array include/linux/slab.h:621 [inline]
    [<ffffffff81459bff>] kcalloc include/linux/slab.h:652 [inline]
    [<ffffffff81459bff>] watch_queue_set_size+0x12f/0x2e0 kernel/watch_queue.c:251
    [<ffffffff8159fcf2>] pipe_ioctl+0x82/0x140 fs/pipe.c:632
    [<ffffffff815b601c>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff815b601c>] __do_sys_ioctl fs/ioctl.c:874 [inline]
    [<ffffffff815b601c>] __se_sys_ioctl fs/ioctl.c:860 [inline]
    [<ffffffff815b601c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:860
    [<ffffffff84493a05>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84493a05>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
