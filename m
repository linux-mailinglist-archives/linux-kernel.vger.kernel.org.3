Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1F3561247
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiF3GJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiF3GJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:09:23 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ED81A80C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:09:22 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id z18-20020a056e02089200b002dab7cef3d2so3204728ils.16
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6Bwik4YJ/z6hqLdAFagjgHvT1Tdn44mBnKUBC2kVmms=;
        b=KlHsJCh8TzTvD6XY6BIAk2Mf1dMxBDhIVzlIpX8ZGvsl15PcIz9NSmsHuAm7uuK7ao
         FwFSlgQDTdgxkI2ryMTtUHuHolw45vLXUCCaVMKVeqoXpHoWL7OrvzABR/nyhbkvnN6R
         UgUaELyHBh7pcsmgDyFlu3mSslW66zt7i2EHH8OYtEM9ZIzzoeW0jc3LvseWvN4Glmcm
         lIq1A9ll0nUwTV816HHZeBkz4arqTgKlaibY3XiG7rBiX1o80NoADwKrf5Ac4ksp1Dhp
         nHa3K0W/xbeq1UDho+Vph/+mGNBJ28gjiv7nvMvke09aJ0W5p4nRULt4l526N8xBidCv
         RJmQ==
X-Gm-Message-State: AJIora9isVLOR6Qeg7HAj0I2me0WHOwIhjS9B8lQ55EYbbaxIkg9vZ++
        6mtafFjk2Nvl0Pc38DHkMdMqNd+QjFkr5FITbSryawC0iBh8
X-Google-Smtp-Source: AGRyM1ulGAJKtSd49kmLTC8kxHT3qrI+vGY2hkINERqf7fF9JIbPDBWf7Em9Qmgj0En65QFRvsQOswaW6ilHq0C6StaSeogejom6
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3298:b0:675:7d23:6643 with SMTP id
 d24-20020a056602329800b006757d236643mr3588156ioz.143.1656569362086; Wed, 29
 Jun 2022 23:09:22 -0700 (PDT)
Date:   Wed, 29 Jun 2022 23:09:22 -0700
In-Reply-To: <0000000000002cd2b1058ee760fe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f821205e2a41c4e@google.com>
Subject: Re: [syzbot] memory leak in pty_common_install
From:   syzbot <syzbot+bdebcbf44250d75bdd82@syzkaller.appspotmail.com>
To:     anant.thazhemadam@gmail.com, gregkh@linuxfoundation.org,
        hdanton@sina.com, jirislaby@kernel.org, jslaby@suse.com,
        jslaby@suse.cz, linux-kernel@vger.kernel.org, phind.uet@gmail.com,
        syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    d9b2ba67917c Merge tag 'platform-drivers-x86-v5.19-3' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1795f0f0080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b6c1840347c4c391
dashboard link: https://syzkaller.appspot.com/bug?extid=bdebcbf44250d75bdd82
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d01f90080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126f34f0080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bdebcbf44250d75bdd82@syzkaller.appspotmail.com

Warning: Permanently added '10.128.1.122' (ECDSA) to the list of known hosts.
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810222e600 (size 512):
  comm "syz-executor149", pid 3615, jiffies 4294954919 (age 12.620s)
  hex dump (first 32 bytes):
    50 e6 22 02 81 88 ff ff e0 ff ff ff 0f 00 00 00  P.".............
    10 e6 22 02 81 88 ff ff 10 e6 22 02 81 88 ff ff  ..".......".....
  backtrace:
    [<ffffffff8262ce09>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff8262ce09>] pty_common_install+0x59/0x3d0 drivers/tty/pty.c:381
    [<ffffffff8261decb>] tty_driver_install_tty drivers/tty/tty_io.c:1307 [inline]
    [<ffffffff8261decb>] tty_init_dev.part.0+0x5b/0x2f0 drivers/tty/tty_io.c:1419
    [<ffffffff8261e1a0>] tty_init_dev+0x40/0x60 drivers/tty/tty_io.c:1409
    [<ffffffff8262cc29>] ptmx_open drivers/tty/pty.c:834 [inline]
    [<ffffffff8262cc29>] ptmx_open+0xd9/0x210 drivers/tty/pty.c:800
    [<ffffffff815dd68d>] chrdev_open+0x10d/0x340 fs/char_dev.c:414
    [<ffffffff815cbf96>] do_dentry_open+0x1e6/0x660 fs/open.c:848
    [<ffffffff815f26c1>] do_open fs/namei.c:3520 [inline]
    [<ffffffff815f26c1>] path_openat+0x18a1/0x1e70 fs/namei.c:3653
    [<ffffffff815f5391>] do_filp_open+0xc1/0x1b0 fs/namei.c:3680
    [<ffffffff815cf88d>] do_sys_openat2+0xed/0x260 fs/open.c:1278
    [<ffffffff815d02df>] do_sys_open fs/open.c:1294 [inline]
    [<ffffffff815d02df>] __do_sys_openat fs/open.c:1310 [inline]
    [<ffffffff815d02df>] __se_sys_openat fs/open.c:1305 [inline]
    [<ffffffff815d02df>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1305
    [<ffffffff845ac915>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845ac915>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

BUG: memory leak
unreferenced object 0xffff88810213d400 (size 1024):
  comm "syz-executor149", pid 3615, jiffies 4294954919 (age 12.620s)
  hex dump (first 32 bytes):
    01 54 00 00 01 00 00 00 00 00 00 00 00 00 00 00  .T..............
    40 be ca 41 81 88 ff ff 60 65 c5 84 ff ff ff ff  @..A....`e......
  backtrace:
    [<ffffffff8261dbbc>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff8261dbbc>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff8261dbbc>] alloc_tty_struct+0x3c/0x2f0 drivers/tty/tty_io.c:3091
    [<ffffffff8262ce72>] pty_common_install+0xc2/0x3d0 drivers/tty/pty.c:389
    [<ffffffff8261decb>] tty_driver_install_tty drivers/tty/tty_io.c:1307 [inline]
    [<ffffffff8261decb>] tty_init_dev.part.0+0x5b/0x2f0 drivers/tty/tty_io.c:1419
    [<ffffffff8261e1a0>] tty_init_dev+0x40/0x60 drivers/tty/tty_io.c:1409
    [<ffffffff8262cc29>] ptmx_open drivers/tty/pty.c:834 [inline]
    [<ffffffff8262cc29>] ptmx_open+0xd9/0x210 drivers/tty/pty.c:800
    [<ffffffff815dd68d>] chrdev_open+0x10d/0x340 fs/char_dev.c:414
    [<ffffffff815cbf96>] do_dentry_open+0x1e6/0x660 fs/open.c:848
    [<ffffffff815f26c1>] do_open fs/namei.c:3520 [inline]
    [<ffffffff815f26c1>] path_openat+0x18a1/0x1e70 fs/namei.c:3653
    [<ffffffff815f5391>] do_filp_open+0xc1/0x1b0 fs/namei.c:3680
    [<ffffffff815cf88d>] do_sys_openat2+0xed/0x260 fs/open.c:1278
    [<ffffffff815d02df>] do_sys_open fs/open.c:1294 [inline]
    [<ffffffff815d02df>] __do_sys_openat fs/open.c:1310 [inline]
    [<ffffffff815d02df>] __se_sys_openat fs/open.c:1305 [inline]
    [<ffffffff815d02df>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1305
    [<ffffffff845ac915>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845ac915>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0


