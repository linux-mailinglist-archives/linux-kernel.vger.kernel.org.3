Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5022059D127
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbiHWGSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiHWGSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:18:40 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40174BC24
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:18:36 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id p123-20020a6bbf81000000b00674f66cf13aso6925831iof.23
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=w7IBh16YCOLSqhh2JLVcXFQTO2VKalGU5Te6z3qBSMc=;
        b=noGPIPOGO52F0gAGDWT13VvKp/qahJoAB0bHiquNBr5AdBNWB3rYPcpYfXqcK52FBt
         9wVTnEqvhAfWGNUMwmy2NOrL55SivCp3dog52LzCJ3Ip5J83zc9qaKBHcEf2LWdjIBwI
         qweuSQpK/v+Zx///Shl6bjPBvsj49/sbRvZeSveq0EdihGq1Ii32F5bdZgNnm4AT/suL
         bFadvFXTr4Ox8HXQYKEfL9AZ2AgxVz5mZl34+frbOL2l8FHx6/Qch7NEPCo8wWSTnIT8
         4pfqSwoSOFYPXOWLG+0NGcJFsBFMnxPCbomekKE/VOQ25VfUE/Ydq3fad9LruAkhUOdr
         qyfQ==
X-Gm-Message-State: ACgBeo2D2M0W0wGUbxUhqV7+1mz1q1sjt+Lzv8dNrO72DQ4lFI7G6h5a
        0Z4XLQX4tqJL9CZW4flkjhVfvixXdPmzvjIHSoO69P/n3umW
X-Google-Smtp-Source: AA6agR6ZjVfPnVgmZjl23yXcHlr22t2DH/cVcuWLiCkH385YErK52BwMvN4Ge2U5Gj99sViQbuYqE2WhAZKQzNWxEXweKfeCQkaE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f04:b0:2e9:be2a:5fac with SMTP id
 x4-20020a056e020f0400b002e9be2a5facmr4268302ilj.70.1661235515559; Mon, 22 Aug
 2022 23:18:35 -0700 (PDT)
Date:   Mon, 22 Aug 2022 23:18:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb172905e6e28808@google.com>
Subject: [syzbot] memory leak in ntfs_init_fs_context
From:   syzbot <syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

HEAD commit:    1c23f9e627a7 Linux 6.0-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16caa92d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1831d905b683446
dashboard link: https://syzkaller.appspot.com/bug?extid=9d67170b20e8f94351c8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161472f3080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145f3e2d080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com

executing program
executing program
BUG: memory leak
unreferenced object 0xffff8881100918a0 (size 32):
  comm "syz-executor151", pid 3611, jiffies 4294944949 (age 8.110s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 c0 ff c0 ff 00 00 00 00  ................
  backtrace:
    [<ffffffff81b23cb2>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff81b23cb2>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff81b23cb2>] ntfs_init_fs_context+0x22/0x1e0 fs/ntfs3/super.c:1397
    [<ffffffff81650025>] alloc_fs_context+0x225/0x3b0 fs/fs_context.c:290
    [<ffffffff8162beb3>] do_new_mount fs/namespace.c:3025 [inline]
    [<ffffffff8162beb3>] path_mount+0x6f3/0x10d0 fs/namespace.c:3370
    [<ffffffff8162cfde>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162cfde>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162cfde>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162cfde>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845e4855>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845e4855>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
