Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07B9584105
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiG1OX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiG1OXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:23:55 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FA054AF0;
        Thu, 28 Jul 2022 07:23:52 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 204so2344430yba.1;
        Thu, 28 Jul 2022 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFzjKOux5yA4ZXm4H1/hdM4KXRpdOEhWq9zPOWQW71Q=;
        b=AgfmBko2dYmke3IssbMndp1sbxpBsSH1cNf8zYpV2hK15n7D7Ul/JewVVvXVzsPLc5
         QrJfO9lfAY/MxeTLkYqqeOLVqj3572fmmCqrQKGyJpKpHmI6UYsddIt3Leru+nUhcTJJ
         97xWSZMUuxkHiCfL+SQvhHDGZJcUWMLkrLwj5Xc0Dij2dA7OxgK5wAnlhEW1LxPX3bcf
         vbKL3qnee0+lfIlW2/IKG0d68RbqIea54ZtKL188mqNxFa4U2k2PIaG0JeGjnqh8LQOj
         lwXj5P0SzuqQbh3UJ7JlWKQ/uMqYlVFSnJYwnQlbLEA0LT6Xfy7g0cSxNcraKMGVBjhv
         Qcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFzjKOux5yA4ZXm4H1/hdM4KXRpdOEhWq9zPOWQW71Q=;
        b=ecYHx+qSYDcnWSQf0PZK86ZS4pF3+xm3xtHu0xr8DkVIsByxUu5ThqKd5eRLfC1DxB
         gJtQFY1RnCKbOGg7T4AFAfQTWKyzdECi5rYfu6L4j0sJeuWHvGDmb0pUioMn/CNuJTtF
         F745tlZq6xmy0Om08URBih7NwsLqx5kLSTKIHmprkk4NX0qNIyMJJ7xPY11KyMHXRV7o
         sfayqiglyFWVMlq2Q18SbzsT88EGXRMjyAt5MGH7gbIaHjtGFr98AXsaeL/90oisxS/h
         b+sO/AqfYIsNeAXUuw4LboA1SZKFQyW90tZxZaWt8zm00Hu94J8uh+3H4c6Y2QY1RgJb
         cdAw==
X-Gm-Message-State: AJIora8F75D5aUdfjYvh6WPYAAxKnBviev7QFC2biRdclM1BHH47/ib6
        RWWsCOZSsxopXgywyciV8oHJ0qpxlgqFePF2hRA=
X-Google-Smtp-Source: AGRyM1uNh0W9UlvVjpOulxhRZ18v1YaiApsFiUw6hXE9a19kdIaYzS98TEFZzO6o8x3bzIa380ekXDUlYh7iJTuZ5yQ=
X-Received: by 2002:a25:e6cd:0:b0:675:8f5d:60a6 with SMTP id
 d196-20020a25e6cd000000b006758f5d60a6mr1795140ybh.389.1659018231868; Thu, 28
 Jul 2022 07:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5ZSuHONz-TPVdGcW3q_n6Z2DKLM6M8RfG+mORA9CCQRsQ@mail.gmail.com>
In-Reply-To: <CANX2M5ZSuHONz-TPVdGcW3q_n6Z2DKLM6M8RfG+mORA9CCQRsQ@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 28 Jul 2022 16:23:40 +0200
Message-ID: <CAKXUXMxVCCRB2uaAN68LZv6Fwe7zAkUmwCmsqB6pE=z_=cztMg@mail.gmail.com>
Subject: Re: INFO: task hung in __floppy_read_block_0
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 12:01 AM Dipanjan Das
<mail.dipanjan.das@gmail.com> wrote:
>
> Hi,
>
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
>
> ======================================================
> description: INFO: task hung in __floppy_read_block_0
> affected file: drivers/block/floppy.c
> kernel version: 5.19-rc6
> kernel commit: 32346491ddf24599decca06190ebca03ff9de7f8
> git tree: upstream
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=cd73026ceaed1402
> crash reproducer: attached

Dipanjan, are you really sure that you want to report a "INFO: task
hung" bug identified with your syzkaller instance? Especially for a
floppy driver, probably in your case even just an emulated one
(right?). Reading data from floppies was always very slow as far as I
remember those times...

Consider the severity of the issue and judge if you would like to
point out such a 'bug'.

It might happen that:

Due to bad judgement on your side, kernel developers and maintainers
will consider the value/severity of the provided bug reports overall
and then eventually simply ignore all reports that you send.

Dmitry and his team around syzkaller and syzbot can give you more
insights on learning a good judgement of what to report, how and when.
IMHO, this is the trickiest (the most challenging) task when setting
up a syzkaller/syzbot instance and trying to use that to influence
releasing "better kernel versions". By the way, kudos to Dmitry and
his team for working on that challenging task and doing a good job on
that.

I hope this helps,

Lukas

> ======================================================
> Crash log:
> ======================================================
> INFO: task syz-executor.1:9482 blocked for more than 143 seconds.
>       Tainted: G           OE     5.19.0-rc6-g2eae0556bb9d #2
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.1  state:D stack:27528 pid: 9482 ppid:  5005 flags:0x00004004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5146 [inline]
>  __schedule+0xa76/0x5140 kernel/sched/core.c:6458
>  schedule+0xd2/0x1f0 kernel/sched/core.c:6530
>  schedule_timeout+0x5e5/0x890 kernel/time/timer.c:1911
>  do_wait_for_common kernel/sched/completion.c:85 [inline]
>  __wait_for_common kernel/sched/completion.c:106 [inline]
>  wait_for_common kernel/sched/completion.c:117 [inline]
>  wait_for_completion+0x182/0x360 kernel/sched/completion.c:138
>  __floppy_read_block_0+0x1dd/0x290 drivers/block/floppy.c:4162
>  floppy_revalidate+0x74f/0xa90 drivers/block/floppy.c:4206
>  invalidate_drive+0xeb/0x120 drivers/block/floppy.c:3219
>  fd_locked_ioctl+0xac1/0x1720 drivers/block/floppy.c:3467
>  fd_ioctl+0x35/0x50 drivers/block/floppy.c:3574
>  blkdev_ioctl+0x36e/0x800 block/ioctl.c:614
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fa70548d4ed
> RSP: 002b:00007fa706530be8 EFLAGS: 00000246
>  ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fa7055abf60 RCX: 00007fa70548d4ed
> RDX: 0000000000000000 RSI: 0000000000000241 RDI: 0000000000000003
> RBP: 00007fa7054f92e1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff9363b3ef R14: 00007fa7055abf60 R15: 00007fa706530d80
>  </TASK>
> INFO: task syz-executor.1:9490 blocked for more than 143 seconds.
>       Tainted: G           OE     5.19.0-rc6-g2eae0556bb9d #2
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.1  state:D stack:28120 pid: 9490 ppid:  5005 flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5146 [inline]
>  __schedule+0xa76/0x5140 kernel/sched/core.c:6458
>  schedule+0xd2/0x1f0 kernel/sched/core.c:6530
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0xfa9/0x1f50 kernel/locking/mutex.c:747
>  blkdev_get_by_dev block/bdev.c:814 [inline]
>  blkdev_get_by_dev+0x241/0xae0 block/bdev.c:787
>  blkdev_open+0x13c/0x2c0 block/fops.c:481
>  do_dentry_open+0x4a1/0x11f0 fs/open.c:848
>  do_open fs/namei.c:3520 [inline]
>  path_openat+0x1c51/0x2890 fs/namei.c:3653
>  do_filp_open+0x1c1/0x290 fs/namei.c:3680
>  do_sys_openat2+0x61b/0x990 fs/open.c:1278
>  do_sys_open+0xc3/0x140 fs/open.c:1294
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fa70543caf4
> RSP: 002b:00007fa70650f710 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007fa70543caf4
> RDX: 0000000000000003 RSI: 00007fa70650f7b0 RDI: 00000000ffffff9c
> RBP: 00007fa70650f7b0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 00007fff9363b3ef R14: 00007fa7055ac040 R15: 00007fa70650fd80
>  </TASK>
> INFO: task syz-executor.1:9498 blocked for more than 143 seconds.
>       Tainted: G           OE     5.19.0-rc6-g2eae0556bb9d #2
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.1  state:D stack:29272 pid: 9498 ppid:  5005 flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5146 [inline]
>  __schedule+0xa76/0x5140 kernel/sched/core.c:6458
>  schedule+0xd2/0x1f0 kernel/sched/core.c:6530
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0xfa9/0x1f50 kernel/locking/mutex.c:747
>  fd_ioctl+0x25/0x50 drivers/block/floppy.c:3573
>  blkdev_ioctl+0x36e/0x800 block/ioctl.c:614
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fa70548d4ed
> RSP: 002b:00007fa703a8bbe8 EFLAGS: 00000246
>  ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fa7055ac120 RCX: 00007fa70548d4ed
> RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000003
> RBP: 00007fa7054f92e1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff9363b3ef R14: 00007fa7055ac120 R15: 00007fa703a8bd80
>  </TASK>
> INFO: task syz-executor.1:9506 blocked for more than 143 seconds.
>       Tainted: G           OE     5.19.0-rc6-g2eae0556bb9d #2
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.1  state:D
>  stack:29272 pid: 9506 ppid:  5005 flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5146 [inline]
>  __schedule+0xa76/0x5140 kernel/sched/core.c:6458
>  schedule+0xd2/0x1f0 kernel/sched/core.c:6530
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0xfa9/0x1f50 kernel/locking/mutex.c:747
>  fd_ioctl+0x25/0x50 drivers/block/floppy.c:3573
>  blkdev_ioctl+0x36e/0x800 block/ioctl.c:614
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fa70548d4ed
> RSP: 002b:00007fa70386abe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fa7055ac200 RCX: 00007fa70548d4ed
> RDX: 0000000000000000 RSI: 0000000000000247 RDI: 0000000000000003
> RBP: 00007fa7054f92e1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff9363b3ef R14: 00007fa7055ac200 R15: 00007fa70386ad80
>  </TASK>
> INFO: task syz-executor.1:9523 blocked for more than 143 seconds.
>       Tainted: G           OE     5.19.0-rc6-g2eae0556bb9d #2
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.1  state:D
>  stack:28120 pid: 9523 ppid:  5005 flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5146 [inline]
>  __schedule+0xa76/0x5140 kernel/sched/core.c:6458
>  schedule+0xd2/0x1f0 kernel/sched/core.c:6530
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0xfa9/0x1f50 kernel/locking/mutex.c:747
>  blkdev_get_by_dev block/bdev.c:814 [inline]
>  blkdev_get_by_dev+0x241/0xae0 block/bdev.c:787
>  blkdev_open+0x13c/0x2c0 block/fops.c:481
>  do_dentry_open+0x4a1/0x11f0 fs/open.c:848
>  do_open fs/namei.c:3520 [inline]
>  path_openat+0x1c51/0x2890 fs/namei.c:3653
>  do_filp_open+0x1c1/0x290 fs/namei.c:3680
>  do_sys_openat2+0x61b/0x990 fs/open.c:1278
>  do_sys_open+0xc3/0x140 fs/open.c:1294
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fa70543caf4
> RSP: 002b:00007fa703649710 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007fa70543caf4
> RDX: 0000000000000003 RSI: 00007fa7036497b0 RDI: 00000000ffffff9c
> RBP: 00007fa7036497b0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 00007fff9363b3ef R14: 00007fa7055ac2e0 R15: 00007fa703649d80
>  </TASK>
> INFO: task syz-executor.1:9526 blocked for more than 143 seconds.
>       Tainted: G           OE     5.19.0-rc6-g2eae0556bb9d #2
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.1  state:D stack:28120 pid: 9526 ppid:  5005 flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5146 [inline]
>  __schedule+0xa76/0x5140 kernel/sched/core.c:6458
>  schedule+0xd2/0x1f0 kernel/sched/core.c:6530
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0xfa9/0x1f50 kernel/locking/mutex.c:747
>  blkdev_get_by_dev block/bdev.c:814 [inline]
>  blkdev_get_by_dev+0x241/0xae0 block/bdev.c:787
>  blkdev_open+0x13c/0x2c0 block/fops.c:481
>  do_dentry_open+0x4a1/0x11f0 fs/open.c:848
>  do_open fs/namei.c:3520 [inline]
>  path_openat+0x1c51/0x2890 fs/namei.c:3653
>  do_filp_open+0x1c1/0x290 fs/namei.c:3680
>  do_sys_openat2+0x61b/0x990 fs/open.c:1278
>  do_sys_open+0xc3/0x140 fs/open.c:1294
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fa70543caf4
> RSP: 002b:00007fa703428710 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007fa70543caf4
> RDX: 0000000000000003 RSI: 00007fa7034287b0 RDI: 00000000ffffff9c
> RBP: 00007fa7034287b0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 00007fff9363b3ef R14: 00007fa7055ac3c0 R15: 00007fa703428d80
>  </TASK>
> INFO: task syz-executor.1:9537 blocked for more than 143 seconds.
>       Tainted: G           OE     5.19.0-rc6-g2eae0556bb9d #2
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.1  state:D
>  stack:28584 pid: 9537 ppid:  5005 flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5146 [inline]
>  __schedule+0xa76/0x5140 kernel/sched/core.c:6458
>  schedule+0xd2/0x1f0 kernel/sched/core.c:6530
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0xfa9/0x1f50 kernel/locking/mutex.c:747
>  fd_ioctl+0x25/0x50 drivers/block/floppy.c:3573
>  blkdev_ioctl+0x36e/0x800 block/ioctl.c:614
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fa70548d4ed
> RSP: 002b:00007fa703207be8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fa7055ac4a0 RCX: 00007fa70548d4ed
> RDX: 0000000020000200 RSI: 0000000040200242 RDI: 0000000000000003
> RBP: 00007fa7054f92e1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff9363b3ef R14: 00007fa7055ac4a0 R15: 00007fa703207d80
>  </TASK>
> INFO: task syz-executor.6:9486 blocked for more than 143 seconds.
>       Tainted: G           OE     5.19.0-rc6-g2eae0556bb9d #2
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.6  state:D stack:28120 pid: 9486 ppid:  6033 flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5146 [inline]
>  __schedule+0xa76/0x5140 kernel/sched/core.c:6458
>  schedule+0xd2/0x1f0 kernel/sched/core.c:6530
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0xfa9/0x1f50 kernel/locking/mutex.c:747
>  floppy_open+0x7f/0xdb0 drivers/block/floppy.c:3994
>  blkdev_get_whole+0x99/0x260 block/bdev.c:673
>  blkdev_get_by_dev block/bdev.c:823 [inline]
>  blkdev_get_by_dev+0x4a8/0xae0 block/bdev.c:787
>  blkdev_open+0x13c/0x2c0 block/fops.c:481
>  do_dentry_open+0x4a1/0x11f0 fs/open.c:848
>  do_open fs/namei.c:3520 [inline]
>  path_openat+0x1c51/0x2890 fs/namei.c:3653
>  do_filp_open+0x1c1/0x290 fs/namei.c:3680
>  do_sys_openat2+0x61b/0x990 fs/open.c:1278
>  do_sys_open+0xc3/0x140 fs/open.c:1294
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f9e8623caf4
> RSP: 002b:00007f9e8731f710 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007f9e8623caf4
> RDX: 0000000000000003 RSI: 00007f9e8731f7b0 RDI: 00000000ffffff9c
> RBP: 00007f9e8731f7b0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 00007ffe6d243b2f R14: 00007f9e863abf60 R15: 00007f9e8731fd80
>  </TASK>
> INFO: task syz-executor.5:9503 blocked for more than 143 seconds.
>       Tainted: G           OE     5.19.0-rc6-g2eae0556bb9d #2
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.5  state:D stack:28120 pid: 9503 ppid:  6502 flags:0x00004004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5146 [inline]
>  __schedule+0xa76/0x5140 kernel/sched/core.c:6458
>  schedule+0xd2/0x1f0 kernel/sched/core.c:6530
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0xfa9/0x1f50 kernel/locking/mutex.c:747
>  blkdev_get_by_dev block/bdev.c:814 [inline]
>  blkdev_get_by_dev+0x241/0xae0 block/bdev.c:787
>  blkdev_open+0x13c/0x2c0 block/fops.c:481
>  do_dentry_open+0x4a1/0x11f0 fs/open.c:848
>  do_open fs/namei.c:3520 [inline]
>  path_openat+0x1c51/0x2890 fs/namei.c:3653
>  do_filp_open+0x1c1/0x290 fs/namei.c:3680
>  do_sys_openat2+0x61b/0x990 fs/open.c:1278
>  do_sys_open+0xc3/0x140 fs/open.c:1294
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fc9a783caf4
> RSP: 002b:00007fc9a5f27710 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007fc9a783caf4
> RDX: 0000000000000000 RSI: 00007fc9a5f277b0 RDI: 00000000ffffff9c
> RBP: 00007fc9a5f277b0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 00007ffda907f81f R14: 00007fc9a79abf60 R15: 00007fc9a5f27d80
>  </TASK>
>
> Showing all locks held in the system:
> 2 locks held by kworker/u4:1/12:
> 1 lock held by khungtaskd/30:
>  #0: ffffffff8bd83aa0 (rcu_read_lock){....}-{1:2}, at:
> debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
> 1 lock held by in:imklog/6573:
>  #0: ffff88810db62368 (&f->f_pos_lock){+.+.}-{3:3}, at:
> __fdget_pos+0xe3/0x100 fs/file.c:1036
> 5 locks held by kworker/u4:4/8242:
>  #0: ffff888063c39ed8 (&rq->__lock){-.-.}-{2:2}, at:
> raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544
>  #1: ffff888063c277c8 (&per_cpu_ptr(group->pcpu,
> cpu)->seq){-.-.}-{0:0}, at: process_one_work+0x8e4/0x1650
> kernel/workqueue.c:2264
>  #2: ffffffff8bdbc198 (dma_spin_lock){-.-.}-{2:2}, at: claim_dma_lock
> arch/x86/include/asm/dma.h:156 [inline]
>  #2: ffffffff8bdbc198 (dma_spin_lock){-.-.}-{2:2}, at: floppy_ready
> drivers/block/floppy.c:1946 [inline]
>  #2: ffffffff8bdbc198 (dma_spin_lock){-.-.}-{2:2}, at:
> floppy_ready+0xb27/0x19b0 drivers/block/floppy.c:1926
>  #3: ffff888063c28398 (&base->lock){-.-.}-{2:2}
> , at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:999
>  #4:
> ffffffff911ba350
>  (&obj_hash[i].lock
> ){-.-.}-{2:2}, at: console_lock_spinning_disable_and_check
> kernel/printk/printk.c:1830 [inline]
> ){-.-.}-{2:2}, at: console_emit_next_record.constprop.0+0x40a/0x840
> kernel/printk/printk.c:2737
> 1 lock held by syz-executor.1/9482:
>  #0: ffffffff8c8f20e8 (floppy_mutex){+.+.}-{3:3}, at:
> fd_ioctl+0x25/0x50 drivers/block/floppy.c:3573
> 1 lock held by syz-executor.1/9490:
>  #0: ffff8880174eb118 (
> &disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev block/bdev.c:814 [inline]
> &disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x241/0xae0
> block/bdev.c:787
> 1 lock held by syz-executor.1/9498:
>  #0: ffffffff8c8f20e8 (floppy_mutex){+.+.}-{3:3}, at:
> fd_ioctl+0x25/0x50 drivers/block/floppy.c:3573
> 1 lock held by syz-executor.1/9506:
>  #0: ffffffff8c8f20e8 (floppy_mutex){+.+.}-{3:3}, at:
> fd_ioctl+0x25/0x50 drivers/block/floppy.c:3573
> 1 lock held by syz-executor.1/9523:
>  #0:
> ffff8880174eb118
>  (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev
> block/bdev.c:814 [inline]
>  (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x241/0xae0
> block/bdev.c:787
> 1 lock held by syz-executor.1/9526:
>  #0: ffff8880174eb118 (&disk->open_mutex){+.+.}-{3:3}, at:
> blkdev_get_by_dev block/bdev.c:814 [inline]
>  #0: ffff8880174eb118 (&disk->open_mutex){+.+.}-{3:3}, at:
> blkdev_get_by_dev+0x241/0xae0 block/bdev.c:787
> 1 lock held by syz-executor.1/9537:
>  #0: ffffffff8c8f20e8 (floppy_mutex){+.+.}-{3:3}, at:
> fd_ioctl+0x25/0x50 drivers/block/floppy.c:3573
> 2 locks held by syz-executor.6/9486:
>  #0: ffff8880174eb118 (&disk->open_mutex){+.+.}-{3:3}, at:
> blkdev_get_by_dev block/bdev.c:814 [inline]
>  #0: ffff8880174eb118 (&disk->open_mutex){+.+.}-{3:3}, at:
> blkdev_get_by_dev+0x241/0xae0 block/bdev.c:787
>  #1: ffffffff8c8f20e8 (floppy_mutex){+.+.}-{3:3}, at:
> floppy_open+0x7f/0xdb0 drivers/block/floppy.c:3994
> 1 lock held by syz-executor.5/9503:
>  #0: ffff8880174eb118 (&disk->open_mutex){+.+.}-{3:3}, at:
> blkdev_get_by_dev block/bdev.c:814 [inline]
>  #0: ffff8880174eb118 (&disk->open_mutex){+.+.}-{3:3}, at:
> blkdev_get_by_dev+0x241/0xae0 block/bdev.c:787
>
> =============================================
>
> NMI backtrace for cpu 1
> CPU: 1 PID: 30 Comm: khungtaskd Tainted: G           OE
> 5.19.0-rc6-g2eae0556bb9d #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
>  nmi_trigger_cpumask_backtrace+0x1a1/0x1e0 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
>  watchdog+0xcc8/0x1010 kernel/hung_task.c:369
>  kthread+0x2e9/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 6574 Comm: rs:main Q:Reg Tainted: G           OE
> 5.19.0-rc6-g2eae0556bb9d #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:__rq_lockp kernel/sched/sched.h:1179 [inline]
> RIP: 0010:rq_pin_lock kernel/sched/sched.h:1525 [inline]
> RIP: 0010:rq_lock_irqsave kernel/sched/sched.h:1587 [inline]
> RIP: 0010:sched_ttwu_pending+0x114/0x570 kernel/sched/core.c:3741
> Code: 00 00 00 00 00 00 00 9c 5d fa f7 c5 00 02 00 00 0f 85 12 03 00
> 00 31 f6 4c 89 ff e8 e6 ad fe ff 49 8d 87 58 0d 00 00 48 89 c2 <48> 89
> 44 24 08 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 48 89 6c
> RSP: 0018:ffffc90000007d90 EFLAGS: 00000093
> RAX: ffff888063c3ac18 RBX: ffff88812cffd8b8 RCX: 0000000000000000
> RDX: ffff888063c3ac18 RSI: 0000000000000003 RDI: 0000000000000001
> RBP: 0000000000000046 R08: fffff52000000f9c R09: fffff52000000f9d
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 1ffff92000000fb9 R14: ffff88812cffd8c0 R15: ffff888063c39ec0
> FS:  00007f6eca9fd700(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6ec0000000 CR3: 000000001700a000 CR4: 0000000000150ef0
> Call Trace:
>  <IRQ>
>  __flush_smp_call_function_queue+0x451/0x9a0 kernel/smp.c:681
>  __sysvec_call_function_single+0x95/0x3e0 arch/x86/kernel/smp.c:248
>  sysvec_call_function_single+0x40/0xc0 arch/x86/kernel/smp.c:243
>  asm_sysvec_call_function_single+0x1b/0x20 arch/x86/include/asm/idtentry.h:657
> RIP: 0010:__do_softirq+0x193/0x908 kernel/softirq.c:557
> Code: 89 5c 24 08 48 89 44 24 18 48 c7 c7 60 1a cb 89 e8 d2 2d da ff
> 65 66 c7 05 f8 92 63 76 00 00 e8 b3 07 e1 f7 fb b8 ff ff ff ff <48> c7
> c3 c0 a0 a0 8b 41 0f bc c5 41 89 c7 41 83 c7 01 0f 85 ad 00
> RSP: 0018:ffffc90000007f80 EFLAGS: 00000206
> RAX: 00000000ffffffff RBX: ffff88810a591d80 RCX: 1ffffffff20d7bd6
> RDX: 0000000000000000 RSI: 0000000000000101 RDI: 0000000000000000
> RBP: ffffc9000386f648 R08: 0000000000000001 R09: fffffbfff20d0135
> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000080 R14: 0000000000000000 R15: 0000000000000000
>  invoke_softirq kernel/softirq.c:445 [inline]
>  __irq_exit_rcu kernel/softirq.c:650 [inline]
>  irq_exit_rcu+0xf2/0x130 kernel/softirq.c:662
>  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
> RIP: 0010:lock_is_held_type+0xff/0x140 kernel/locking/lockdep.c:5713
> Code: 00 00 b8 ff ff ff ff 65 0f c1 05 14 57 88 76 83 f8 01 75 29 9c
> 58 f6 c4 02 75 3d 48 f7 04 24 00 02 00 00 74 01 fb 48 83 c4 08 <44> 89
> e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 45 31 ed eb b9 0f 0b 48
> RSP: 0018:ffffc9000386f6f0 EFLAGS: 00000296
> RAX: 0000000000000046 RBX: 0000000000000004 RCX: 0000000000000001
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffffff8bd839e0 R08: fffffbfff1b7619a R09: fffffbfff1b7619b
> R10: 0000000000000001 R11: 000000000008a07a R12: ffff88810a591d80
> R13: 0000000000000000 R14: 00000000ffffffff R15: ffff88810a592858
>  lock_is_held include/linux/lockdep.h:279 [inline]
>  rcu_read_lock_sched_held+0x9c/0xd0 kernel/rcu/update.c:125
>  trace_lock_release include/trace/events/lock.h:69 [inline]
>  lock_release+0x524/0x6d0 kernel/locking/lockdep.c:5676
>  rcu_lock_release include/linux/rcupdate.h:274 [inline]
>  rcu_read_unlock include/linux/rcupdate.h:728 [inline]
>  mapping_get_entry mm/filemap.c:1902 [inline]
>  __filemap_get_folio+0x345/0x1210 mm/filemap.c:1946
>  pagecache_get_page+0x2e/0x290 mm/folio-compat.c:126
>  ext4_da_write_begin+0x3f9/0xaf0 fs/ext4/inode.c:2977
>  generic_perform_write+0x240/0x570 mm/filemap.c:3779
>  ext4_buffered_write_iter+0x11d/0x2e0 fs/ext4/file.c:270
>  ext4_file_write_iter+0x448/0x14e0 fs/ext4/file.c:679
>  call_write_iter include/linux/fs.h:2058 [inline]
>  new_sync_write+0x393/0x570 fs/read_write.c:504
>  vfs_write+0x7c4/0xab0 fs/read_write.c:591
>  ksys_write+0x127/0x250 fs/read_write.c:644
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f6ecf2101cd
> Code: c2 20 00 00 75 10 b8 01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31
> c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b
> 3c 24 48 89 c2 e8 f7 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007f6eca9fc590 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f6ec00243f0 RCX: 00007f6ecf2101cd
> RDX: 0000000000000310 RSI: 00007f6ec00243f0 RDI: 0000000000000009
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007f6ec0024170
> R13: 00007f6eca9fc5b0 R14: 000055b91e051440 R15: 0000000000000310
>  </TASK>
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>    0: 00 00                add    %al,(%rax)
>    2: 00 00                add    %al,(%rax)
>    4: 00 00                add    %al,(%rax)
>    6: 9c                    pushfq
>    7: 5d                    pop    %rbp
>    8: fa                    cli
>    9: f7 c5 00 02 00 00    test   $0x200,%ebp
>    f: 0f 85 12 03 00 00    jne    0x327
>   15: 31 f6                xor    %esi,%esi
>   17: 4c 89 ff              mov    %r15,%rdi
>   1a: e8 e6 ad fe ff        callq  0xfffeae05
>   1f: 49 8d 87 58 0d 00 00 lea    0xd58(%r15),%rax
>   26: 48 89 c2              mov    %rax,%rdx
> * 29: 48 89 44 24 08        mov    %rax,0x8(%rsp) <-- trapping instruction
>   2e: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
>   35: fc ff df
>   38: 48 c1 ea 03          shr    $0x3,%rdx
>   3c: 48                    rex.W
>   3d: 89                    .byte 0x89
>   3e: 6c                    insb   (%dx),%es:(%rdi)
>
> --
> Thanks and Regards,
>
> Dipanjan
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/CANX2M5ZSuHONz-TPVdGcW3q_n6Z2DKLM6M8RfG%2BmORA9CCQRsQ%40mail.gmail.com.
