Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A090F59BCDF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiHVJbT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Aug 2022 05:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiHVJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:30:31 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62002F640
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:30:29 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e2-20020a056e020b2200b002e1a5b67e29so8054278ilu.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+GeY2Z9JkjROxefibd/WKD8kc2gQfMs0/5C3Ccicj1g=;
        b=yPJr/FHgyd2qNwMth5/ZjvUfUlvnnuRcTZWs1RRTdpjLGpzmkoBSxzmluCnG7UKaRS
         ur6RFTx9UQX+VLzPuTDdhyaWg20gqBhyhDEOJssPXEzvNUfYQY+ChwOjy5cpfmb8SJ+E
         yn8QnGq8VbnyJsm9T8qXVxKzveWfH8YXKp2hoqvgUpHR17JHusMCBc+gUIESFHWHRy04
         3vcV7Vw7ybk1/NVlR9Su7y1eHb8Pn0s5oRDPywszS6LC5mg+DsSr1TuF36pVrq3sIVfY
         jLlk5/hODB1pWGlvAQKT4gj9Po4PBwmuT9BczPxX7UyWfYCsSOiElpqipwK4Gu9rW7u2
         b5fw==
X-Gm-Message-State: ACgBeo2/Po648d7+LkVDKOZYfsWp50b3NR3SeoypDOFPcNbWUUeooovQ
        GREiwZ6xPNPeewyo/Uua12bc5HLLoCJYE0ASEG4KIaavRI0K
X-Google-Smtp-Source: AA6agR7BlTUJA81FGaMlPyefzNhku1rXRyfjGXIwkXKYzpl8hRcHebJdo5wW8ROs3I8GzbIctgJmFBIp5SwOLI1unVPskDOqZDwF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1074:b0:2e9:5068:9dd0 with SMTP id
 q20-20020a056e02107400b002e950689dd0mr6255315ilj.57.1661160629247; Mon, 22
 Aug 2022 02:30:29 -0700 (PDT)
Date:   Mon, 22 Aug 2022 02:30:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038a5d805e6d119e4@google.com>
Subject: [syzbot] possible deadlock in hci_unregister_dev
From:   syzbot <syzbot+c933391d8e4089f1f53e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

HEAD commit:    5b6a4bf680d6 Add linux-next specific files for 20220818
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ea94b5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
dashboard link: https://syzkaller.appspot.com/bug?extid=c933391d8e4089f1f53e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c933391d8e4089f1f53e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc1-next-20220818-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.5/21304 is trying to acquire lock:
ffff8880751049a8 ((work_completion)(&(&hdev->discov_off)->work)){+.+.}-{0:0}, at: __flush_work+0xdd/0xae0 kernel/workqueue.c:3066

but task is already holding lock:
ffff888075104078 (&hdev->lock){+.+.}-{3:3}, at: hci_unregister_dev+0x347/0x4e0 net/bluetooth/hci_core.c:2687

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&hdev->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       discov_off+0x88/0x1a0 net/bluetooth/mgmt.c:1033
       process_one_work+0x991/0x1610 kernel/workqueue.c:2289
       worker_thread+0x665/0x1080 kernel/workqueue.c:2436
       kthread+0x2e4/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

-> #0 ((work_completion)(&(&hdev->discov_off)->work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
       __flush_work+0x105/0xae0 kernel/workqueue.c:3069
       __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3160
       mgmt_index_removed+0x218/0x340 net/bluetooth/mgmt.c:8951
       hci_unregister_dev+0x34f/0x4e0 net/bluetooth/hci_core.c:2688
       vhci_release+0x7c/0xf0 drivers/bluetooth/hci_vhci.c:568
       __fput+0x27c/0xa90 fs/file_table.c:320
       task_work_run+0xdd/0x1a0 kernel/task_work.c:177
       exit_task_work include/linux/task_work.h:38 [inline]
       do_exit+0xc39/0x2b60 kernel/exit.c:814
       do_group_exit+0xd0/0x2a0 kernel/exit.c:944
       get_signal+0x238c/0x2610 kernel/signal.c:2858
       arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
       exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
       exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
       __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
       syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
       do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->lock);
                               lock((work_completion)(&(&hdev->discov_off)->work));
                               lock(&hdev->lock);
  lock((work_completion)(&(&hdev->discov_off)->work));

 *** DEADLOCK ***

1 lock held by syz-executor.5/21304:
 #0: ffff888075104078 (&hdev->lock){+.+.}-{3:3}, at: hci_unregister_dev+0x347/0x4e0 net/bluetooth/hci_core.c:2687

stack backtrace:
CPU: 1 PID: 21304 Comm: syz-executor.5 Not tainted 6.0.0-rc1-next-20220818-syzkaller #0
syz-executor.5[21304] cmdline: ��a�����
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:122 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:140
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __flush_work+0x105/0xae0 kernel/workqueue.c:3069
 __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3160
 mgmt_index_removed+0x218/0x340 net/bluetooth/mgmt.c:8951
 hci_unregister_dev+0x34f/0x4e0 net/bluetooth/hci_core.c:2688
 vhci_release+0x7c/0xf0 drivers/bluetooth/hci_vhci.c:568
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xc39/0x2b60 kernel/exit.c:814
 do_group_exit+0xd0/0x2a0 kernel/exit.c:944
 get_signal+0x238c/0x2610 kernel/signal.c:2858
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fce942adfa1
Code: Unable to access opcode bytes at RIP 0x7fce942adf77.
RSP: 002b:00007fce954540b0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: fffffffffffffdfc RBX: 00007fce9439bf80 RCX: 00007fce942adfa1
RDX: 00007fce954540f0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fce942e3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007fff7d48034f R14: 00007fce95454300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
