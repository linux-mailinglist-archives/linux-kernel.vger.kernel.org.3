Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA90E4C0569
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiBVXkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiBVXkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:40:52 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BA73A190
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:40:25 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id k10-20020a5d91ca000000b006414a00b160so3648102ior.18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OooVyoOgW3l6HohSHtsDC5MFtd8nu7N8NE3HmObQJ5o=;
        b=hVPVDOJ5JlQyMuygUXUqdt9+VvWGg15Mz/b5e+Rd45ua8QL1O9VtJ/jxKKm7M/NQFZ
         BsaMG4/cK8BWIY3b1LedPj6EnysTkrGRL9eyZP+LVRdJ8FC5MwSBcDltWdK7nrJ1abOd
         hEMopSBvIC9M8BRd1YpeH1/l5bLj7y2ZGwBzLvtQajVxM+yODCW/mPrWe5XmqlBoqWI/
         9xco3sbRCHGePjIj71oafBxthoZ4u8fCGvtM8YB4WS0TzuBEpO+XvJiVOg9iy/PFmC27
         HP2IP2dMLBfYkg3OVNMpvwuejwjusT+vd+FDngeZtFvzab9x4hRn8oSSFNYjrZK2O49f
         J8RQ==
X-Gm-Message-State: AOAM532XcPNTFLsv4jFQNI/t9WCBoc7qP0OMtpwW0Kk0R/YPM3RpUnCK
        ZgMq2rmGsWYvHON5FVzIMwy0Lfxg3PmCSGYo0FLrcnzzb9PO
X-Google-Smtp-Source: ABdhPJz1Fn+Fc9twJUyPU6QWtzbHGw3fAKOtx1KnBpDPEkMKqEXzMWm6kEI3vtUc/FsqtVLZMEPaHKQ/tQu+tmerahxeUEwSCk1w
MIME-Version: 1.0
X-Received: by 2002:a02:c772:0:b0:314:9319:9076 with SMTP id
 k18-20020a02c772000000b0031493199076mr19486218jao.176.1645573224994; Tue, 22
 Feb 2022 15:40:24 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:40:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000871dfa05d8a3df7c@google.com>
Subject: [syzbot] memory leak in create_io_worker (2)
From:   syzbot <syzbot+7085977fe51df63eb2bf@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7993e65fdd0f Merge tag 'mtd/fixes-for-5.17-rc5' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b8d5bc700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6668288739b7ad26
dashboard link: https://syzkaller.appspot.com/bug?extid=7085977fe51df63eb2bf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eae25a700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a51236700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7085977fe51df63eb2bf@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888112ec56c0 (size 192):
  comm "syz-executor313", pid 30410, jiffies 4294958360 (age 18.100s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816515c6>] kmalloc_node include/linux/slab.h:599 [inline]
    [<ffffffff816515c6>] kzalloc_node include/linux/slab.h:726 [inline]
    [<ffffffff816515c6>] create_io_worker+0x46/0x250 fs/io-wq.c:812
    [<ffffffff81652ab2>] create_worker_cb+0xd2/0xf0 fs/io-wq.c:331
    [<ffffffff81273853>] task_work_run+0x73/0xb0 kernel/task_work.c:164
    [<ffffffff8163dadd>] tracehook_notify_signal include/linux/tracehook.h:213 [inline]
    [<ffffffff8163dadd>] io_run_task_work fs/io_uring.c:2595 [inline]
    [<ffffffff8163dadd>] io_run_task_work fs/io_uring.c:2591 [inline]
    [<ffffffff8163dadd>] io_run_task_work_sig+0x6d/0x110 fs/io_uring.c:7684
    [<ffffffff8164ec75>] io_cqring_wait_schedule fs/io_uring.c:7701 [inline]
    [<ffffffff8164ec75>] io_cqring_wait fs/io_uring.c:7770 [inline]
    [<ffffffff8164ec75>] __do_sys_io_uring_enter+0x715/0xf60 fs/io_uring.c:10178
    [<ffffffff844b4875>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844b4875>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
