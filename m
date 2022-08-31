Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EB65A804C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiHaOfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiHaOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:35:34 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D596218E1F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:35:32 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id q10-20020a0566022f0a00b00688d703717bso8751375iow.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=WXaJAZ2MWFYdF36wziQhVxf0uszdOkCCLhumYClSVQo=;
        b=nZAIZAxFyPVhM5Xz/p5XzbtGz2KGMEfrncpr+4TW31785Ilq1cgYCPnGAKVOaQuPo/
         hGoH4QJaJB86knURQadz3aKIHKsMF2+yQzlTOcn72IPh+APFfwwU/5paPzFJsaa5Rr0f
         pW/JiQTc3qVNpqPQBtcBA9OUo8Q961TLB2mQVa1CNQw7GJ0rLK7Ao03BEf3A0mcYWryC
         sx31TVLFiQW9g9SnT6lKNN+lcdpvm3Qs2xPwxiShryqlJwN0yU3Kxexfr7H/bdabHvAi
         8QBB41mg3LOiyqpG9goOeIyyPEyIXgHyxpj0rQG6iTmS4+XEx+3IhMcBhNGGK9vNPSTH
         J65g==
X-Gm-Message-State: ACgBeo13G/yM1HdJF5KD2b5LE9DIQvCuvkbg7oEL5Bo2eKWjsRYyiQzJ
        /qye/hK6qgRchGpIej0dqnodmgN9fXBYB8saCBa7QtyJjA3V
X-Google-Smtp-Source: AA6agR4f0yfFac2l5mMkYv6Whuuyzl4KTiFvbrcUg36fBjMQ2x6ed+Jqk+DMnEhYEyciZMFHknGl4TsG83Ohkr6dhgAzjR+hX4yc
MIME-Version: 1.0
X-Received: by 2002:a02:b1c5:0:b0:349:c080:b371 with SMTP id
 u5-20020a02b1c5000000b00349c080b371mr15380892jah.136.1661956532260; Wed, 31
 Aug 2022 07:35:32 -0700 (PDT)
Date:   Wed, 31 Aug 2022 07:35:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bcd87205e78a68d8@google.com>
Subject: [syzbot] INFO: task hung in blk_freeze_queue (3)
From:   syzbot <syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com>
To:     brauner@kernel.org, broonie@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        madvenka@linux.microsoft.com, mark.rutland@arm.com,
        scott@os.amperecomputing.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
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

HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1233470b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
dashboard link: https://syzkaller.appspot.com/bug?extid=38e6c55d4969a14c1534
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f59dad080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160918e5080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com

INFO: task syz-executor245:3083 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor245 state:D stack:    0 pid: 3083 ppid:  3071 flags:0x00000001
Call trace:
 __switch_to+0x180/0x28c arch/arm64/kernel/process.c:557
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0x414/0x570 kernel/sched/core.c:6494
 schedule+0x64/0xa4 kernel/sched/core.c:6570
 blk_mq_freeze_queue_wait+0x94/0xf4 block/blk-mq.c:180
 blk_freeze_queue+0x94/0xa8 block/blk-mq.c:207
 blk_mq_freeze_queue+0x20/0x30 block/blk-mq.c:216
 nbd_add_socket+0x78/0x26c drivers/block/nbd.c:1123
 __nbd_ioctl+0x80/0x320 drivers/block/nbd.c:1464
 nbd_ioctl+0xec/0x13c drivers/block/nbd.c:1521
 blkdev_ioctl+0x250/0x764 block/ioctl.c:614
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
INFO: task udevd:3084 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:    0 pid: 3084 ppid:  2560 flags:0x00000000
Call trace:
 __switch_to+0x180/0x28c arch/arm64/kernel/process.c:557
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0x414/0x570 kernel/sched/core.c:6494
 schedule+0x64/0xa4 kernel/sched/core.c:6570
 io_schedule+0x38/0x104 kernel/sched/core.c:8714
 folio_wait_bit_common+0x458/0x9f8 mm/filemap.c:1298
 folio_put_wait_locked mm/filemap.c:1472 [inline]
 do_read_cache_folio+0x78/0x550 mm/filemap.c:3501
 read_cache_folio+0x40/0x54 mm/filemap.c:3551
 read_mapping_folio include/linux/pagemap.h:762 [inline]
 read_part_sector+0x60/0x1d8 block/partitions/core.c:714
 adfspart_check_ICS+0x4c/0x38c block/partitions/acorn.c:360
 check_partition block/partitions/core.c:146 [inline]
 blk_add_partitions block/partitions/core.c:599 [inline]
 bdev_disk_changed+0x340/0x63c block/partitions/core.c:685
 blkdev_get_whole+0x1b0/0x1f8 block/bdev.c:684
 blkdev_get_by_dev+0x178/0x2fc block/bdev.c:821
 blkdev_open+0x84/0xd8 block/fops.c:485
 do_dentry_open+0x318/0x688 fs/open.c:878
 vfs_open+0x38/0x48 fs/open.c:1014
 do_open fs/namei.c:3557 [inline]
 path_openat+0xe34/0x11c4 fs/namei.c:3691
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1338
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/10:
 #0: ffff80000d4a3568 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/11:
 #0: ffff80000d4a3bb8 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/26:
 #0: ffff80000d4a3440 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:279
2 locks held by getty/2712:
 #0: ffff0000c730a898 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x58 drivers/tty/tty_ldisc.c:244
 #1: ffff80000f67e2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x19c/0x88c drivers/tty/n_tty.c:2177
1 lock held by syz-executor245/3083:
 #0: ffff0000c5ccd998 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_ioctl+0x70/0x13c drivers/block/nbd.c:1514
1 lock held by udevd/3084:
 #0: ffff0000c5daacc8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xfc/0x2fc block/bdev.c:812

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
