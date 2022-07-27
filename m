Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FDC5834AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbiG0VIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbiG0VIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:08:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978FB66109
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:06:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id oy13so33645837ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+aKQXmn1Jw2CVO587bDpYzipESoFc04t5jWC8SZjgL0=;
        b=KLZatY7w0N5sxQzxNpp64/VpLWi/gZ47bhxV/V9cKv4G+jvhuhy+XpJ1j0sOZ3CcWh
         T/r71gttJh1dYDzQKYE4Stxy2y4kfP2zkitdvRXtTM5uzKYinFoo3vMEU4E78jSIVUjb
         hq7RbA0QOnx4MFKmdjgv9c/92TanV5aH6ZMh5IWcchBMfZXgFD/NFn5zkQv32rrEe4pj
         P91RB/N5ysNcWNFmOWcFvJ/6Wl6cZQZxV4w2Zx3LMAfrI3tAeILomtYyYpuS49TLCra1
         vvTpW6AwpIeL0GRLHZ5rwfPE3GKisH3hjwF0T84BQCKWlcCVhDPtT+yi4GH7iPAkCxpE
         0ajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+aKQXmn1Jw2CVO587bDpYzipESoFc04t5jWC8SZjgL0=;
        b=KBdA0lpds2gapjCkCaYtZ7cqLjVZicuqJdOfeVGBt+7iWGd9+x4MbK1JjMXOSePJwf
         RjAlmbKt34Y5n3pu0bww6bSZONUXFOCpTC3xNmf952SrbM93qmUt/bz77f3AIih28ER6
         7axNkdqDgXnu8eeLSgqp0isFUcN1RWSSEMGZexJTIeL+5okOBL62UUBJeD6nfD3N0OfB
         bFO5+4k7wPCQh9HfVgJUSEHGvMIfTz9T5eSFRxmlkhcAnCl16uHxrMTFnSnk/hNcWYJh
         OACRllkzPbtouAPAV2D5o5xCGkfRrydu2MJYiM9XQU+p4zIrLuSQUtX4hc4vSiDf4cru
         hTVA==
X-Gm-Message-State: AJIora9EQZ4mcbeyDL601RNlkJgOAiXMS3BB+RxCvo0fp2oj+q7OmjmY
        2EcVHjNzSzRo7hC87FzvewaoMb+rbWv7rkM5Lr4=
X-Google-Smtp-Source: AGRyM1tyFJqVmOe917YQbjpt8qIwYtJ4oSlizCBiCCyoY1LKXwK9pnwqCgzkBorCTKv8BiJirQ3cvhuvfil1ItdFAfc=
X-Received: by 2002:a17:907:97d6:b0:72f:97d9:978d with SMTP id
 js22-20020a17090797d600b0072f97d9978dmr18535258ejc.684.1658955966280; Wed, 27
 Jul 2022 14:06:06 -0700 (PDT)
MIME-Version: 1.0
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Wed, 27 Jul 2022 14:05:54 -0700
Message-ID: <CANX2M5avK4Ov3msZhuv5hkF-osJ7UUmQKpyp9f=o+_sJpHB36Q@mail.gmail.com>
Subject: INFO: task hung in gfs2_read_super
To:     rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     syzkaller@googlegroups.com, fleischermarius@googlemail.com,
        its.priyanka.bose@gmail.com
Content-Type: multipart/mixed; boundary="00000000000011a1c705e4cfc9e1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000011a1c705e4cfc9e1
Content-Type: text/plain; charset="UTF-8"

Hi,

We would like to report the following bug which has been found by our
modified version of syzkaller.

======================================================
description: INFO: task hung in gfs2_read_super
affected file: fs/gfs2/ops_fstype.c
kernel version: 5.10.131
kernel commit: 8f95261a006489c828f1d909355669875649668b
git tree: upstream
kernel config: https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
crash reproducer: attached
======================================================
Crash log:
======================================================
INFO: task syz-executor.5:11140 blocked for more than 143 seconds.
      Tainted: G           OE     5.10.131+ #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:27224 pid:11140 ppid:  7772 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3792 [inline]
 __schedule+0x8ef/0x20c0 kernel/sched/core.c:4541
 schedule+0xcf/0x270 kernel/sched/core.c:4619
 io_schedule+0x17/0x70 kernel/sched/core.c:6292
 wait_on_page_bit_common+0x333/0xf10 mm/filemap.c:1277
 wait_on_page_locked include/linux/pagemap.h:674 [inline]
 gfs2_read_super+0xd28/0x1250 fs/gfs2/ops_fstype.c:266
 init_names fs/gfs2/ops_fstype.c:371 [inline]
 gfs2_fill_super+0x14f2/0x2750 fs/gfs2/ops_fstype.c:1166
 get_tree_bdev+0x421/0x740 fs/super.c:1344
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1298
 vfs_get_tree+0x89/0x2f0 fs/super.c:1549
 do_new_mount fs/namespace.c:2899 [inline]
 path_mount+0x11c6/0x1b70 fs/namespace.c:3229
 do_mount+0xf3/0x110 fs/namespace.c:3242
 __do_sys_mount fs/namespace.c:3450 [inline]
 __se_sys_mount fs/namespace.c:3427 [inline]
 __x64_sys_mount+0x18f/0x230 fs/namespace.c:3427
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fdd892684ed
RSP: 002b:00007fdd87218be8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fdd89386f60 RCX: 00007fdd892684ed
RDX: 0000000020000180 RSI: 0000000020000140 RDI: 0000000020000040
RBP: 00007fdd892d42e1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc29abc18f R14: 00007fdd89386f60 R15: 00007fdd87218d80
INFO: task syz-executor.7:11142 blocked for more than 143 seconds.
      Tainted: G           OE     5.10.131+ #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.7  state:D stack:26472 pid:11142 ppid:  7769 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3792 [inline]
 __schedule+0x8ef/0x20c0 kernel/sched/core.c:4541
 schedule+0xcf/0x270 kernel/sched/core.c:4619
 rwsem_down_read_slowpath+0x4be/0xfa0 kernel/locking/rwsem.c:1099
 __down_read kernel/locking/rwsem.c:1341 [inline]
 down_read+0x1e7/0x430 kernel/locking/rwsem.c:1506
 iterate_supers+0xdb/0x290 fs/super.c:692
 ksys_sync+0x86/0x150 fs/sync.c:114
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fba021af4ed
RSP: 002b:00007fba0015fbe8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007fba022cdf60 RCX: 00007fba021af4ed
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fba0221b2e1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe2a11fc2f R14: 00007fba022cdf60 R15: 00007fba0015fd80
INFO: task syz-executor.7:11156 blocked for more than 143 seconds.
      Tainted: G           OE     5.10.131+ #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.7  state:D stack:28616 pid:11156 ppid:  7769 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3792 [inline]
 __schedule+0x8ef/0x20c0 kernel/sched/core.c:4541
 schedule+0xcf/0x270 kernel/sched/core.c:4619
 rwsem_down_read_slowpath+0x4be/0xfa0 kernel/locking/rwsem.c:1099
 __down_read kernel/locking/rwsem.c:1341 [inline]
 down_read+0x1e7/0x430 kernel/locking/rwsem.c:1506
 iterate_supers+0xdb/0x290 fs/super.c:692
 ksys_sync+0x86/0x150 fs/sync.c:114
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fba021af4ed
RSP: 002b:00007fba0013ebe8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007fba022ce040 RCX: 00007fba021af4ed
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fba0221b2e1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe2a11fc2f R14: 00007fba022ce040 R15: 00007fba0013ed80
INFO: task syz-executor.7:11157 blocked for more than 143 seconds.
      Tainted: G           OE     5.10.131+ #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.7  state:D stack:29384 pid:11157 ppid:  7769 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3792 [inline]
 __schedule+0x8ef/0x20c0 kernel/sched/core.c:4541
 schedule+0xcf/0x270 kernel/sched/core.c:4619
 rwsem_down_read_slowpath+0x4be/0xfa0 kernel/locking/rwsem.c:1099
 __down_read kernel/locking/rwsem.c:1341 [inline]
 down_read+0x1e7/0x430 kernel/locking/rwsem.c:1506
 iterate_supers+0xdb/0x290 fs/super.c:692
 ksys_sync+0x86/0x150 fs/sync.c:114
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fba021af4ed
RSP: 002b:00007fba0011dbe8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007fba022ce120 RCX: 00007fba021af4ed
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fba0221b2e1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe2a11fc2f R14: 00007fba022ce120 R15: 00007fba0011dd80
INFO: task syz-executor.7:11158 blocked for more than 143 seconds.
      Tainted: G           OE     5.10.131+ #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.7  state:D stack:29384 pid:11158 ppid:  7769 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3792 [inline]
 __schedule+0x8ef/0x20c0 kernel/sched/core.c:4541
 schedule+0xcf/0x270 kernel/sched/core.c:4619
 rwsem_down_read_slowpath+0x4be/0xfa0 kernel/locking/rwsem.c:1099
 __down_read kernel/locking/rwsem.c:1341 [inline]
 down_read+0x1e7/0x430 kernel/locking/rwsem.c:1506
 iterate_supers+0xdb/0x290 fs/super.c:692
 ksys_sync+0x86/0x150 fs/sync.c:114
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fba021af4ed
RSP: 002b:00007fba000fcbe8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007fba022ce200 RCX: 00007fba021af4ed
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fba0221b2e1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe2a11fc2f R14: 00007fba022ce200 R15: 00007fba000fcd80
INFO: task syz-executor.7:11159 blocked for more than 143 seconds.
      Tainted: G           OE     5.10.131+ #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.7  state:D stack:29384 pid:11159 ppid:  7769 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3792 [inline]
 __schedule+0x8ef/0x20c0 kernel/sched/core.c:4541
 schedule+0xcf/0x270 kernel/sched/core.c:4619
 rwsem_down_read_slowpath+0x4be/0xfa0 kernel/locking/rwsem.c:1099
 __down_read kernel/locking/rwsem.c:1341 [inline]
 down_read+0x1e7/0x430 kernel/locking/rwsem.c:1506
 iterate_supers+0xdb/0x290 fs/super.c:692
 ksys_sync+0x86/0x150 fs/sync.c:114
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fba021af4ed
RSP: 002b:00007fba000dbbe8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007fba022ce2e0 RCX: 00007fba021af4ed
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fba0221b2e1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe2a11fc2f R14: 00007fba022ce2e0 R15: 00007fba000dbd80
INFO: task syz-executor.7:11160 blocked for more than 143 seconds.
      Tainted: G           OE     5.10.131+ #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.7  state:D stack:29384 pid:11160 ppid:  7769 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3792 [inline]
 __schedule+0x8ef/0x20c0 kernel/sched/core.c:4541
 schedule+0xcf/0x270 kernel/sched/core.c:4619
 rwsem_down_read_slowpath+0x4be/0xfa0 kernel/locking/rwsem.c:1099
 __down_read kernel/locking/rwsem.c:1341 [inline]
 down_read+0x1e7/0x430 kernel/locking/rwsem.c:1506
 iterate_supers+0xdb/0x290 fs/super.c:692
 ksys_sync+0x86/0x150 fs/sync.c:114
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fba021af4ed
RSP: 002b:00007fba000babe8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007fba022ce3c0 RCX: 00007fba021af4ed
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fba0221b2e1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe2a11fc2f R14: 00007fba022ce3c0 R15: 00007fba000bad80

Showing all locks held in the system:
1 lock held by khungtaskd/1658:
 #0: ffffffff8b336d60 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6389
1 lock held by in:imklog/7747:
 #0: ffff88810f7745f0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe9/0x100 fs/file.c:1003
1 lock held by syz-executor.5/11140:
 #0: ffff888111f9c0e0 (&type->s_umount_key#48/1){+.+.}-{3:3}, at:
alloc_super+0x194/0xa40 fs/super.c:229
1 lock held by syz-executor.7/11142:
 #0: ffff888111f9c0e0 (&type->s_umount_key#65){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:692
1 lock held by syz-executor.7/11156:
 #0: ffff888111f9c0e0 (&type->s_umount_key#65){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:692
1 lock held by syz-executor.7/11157:
 #0: ffff888111f9c0e0 (&type->s_umount_key#65){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:692
1 lock held by syz-executor.7/11158:
 #0: ffff888111f9c0e0 (&type->s_umount_key#65){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:692
1 lock held by syz-executor.7/11159:
 #0: ffff888111f9c0e0 (&type->s_umount_key#65){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:692
1 lock held by syz-executor.7/11160:
 #0: ffff888111f9c0e0 (&type->s_umount_key#65){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:692

-- 
Thanks and Regards,

Dipanjan

--00000000000011a1c705e4cfc9e1
Content-Type: text/x-csrc; charset="US-ASCII"; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l643h3u40>
X-Attachment-Id: f_l643h3u40

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRSAKCiNpbmNsdWRlIDxkaXJlbnQuaD4KI2lu
Y2x1ZGUgPGVuZGlhbi5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNp
bmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0ZGFyZy5oPgojaW5jbHVkZSA8c3RkYm9vbC5o
PgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGli
Lmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5cy9wcmN0bC5oPgojaW5jbHVkZSA8
c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMu
aD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDx0aW1lLmg+CiNpbmNsdWRlIDx1bmlz
dGQuaD4KCnN0YXRpYyB2b2lkIHNsZWVwX21zKHVpbnQ2NF90IG1zKQp7Cgl1c2xlZXAobXMgKiAx
MDAwKTsKfQoKc3RhdGljIHVpbnQ2NF90IGN1cnJlbnRfdGltZV9tcyh2b2lkKQp7CglzdHJ1Y3Qg
dGltZXNwZWMgdHM7CglpZiAoY2xvY2tfZ2V0dGltZShDTE9DS19NT05PVE9OSUMsICZ0cykpCgll
eGl0KDEpOwoJcmV0dXJuICh1aW50NjRfdCl0cy50dl9zZWMgKiAxMDAwICsgKHVpbnQ2NF90KXRz
LnR2X25zZWMgLyAxMDAwMDAwOwp9CgpzdGF0aWMgYm9vbCB3cml0ZV9maWxlKGNvbnN0IGNoYXIq
IGZpbGUsIGNvbnN0IGNoYXIqIHdoYXQsIC4uLikKewoJY2hhciBidWZbMTAyNF07Cgl2YV9saXN0
IGFyZ3M7Cgl2YV9zdGFydChhcmdzLCB3aGF0KTsKCXZzbnByaW50ZihidWYsIHNpemVvZihidWYp
LCB3aGF0LCBhcmdzKTsKCXZhX2VuZChhcmdzKTsKCWJ1ZltzaXplb2YoYnVmKSAtIDFdID0gMDsK
CWludCBsZW4gPSBzdHJsZW4oYnVmKTsKCWludCBmZCA9IG9wZW4oZmlsZSwgT19XUk9OTFkgfCBP
X0NMT0VYRUMpOwoJaWYgKGZkID09IC0xKQoJCXJldHVybiBmYWxzZTsKCWlmICh3cml0ZShmZCwg
YnVmLCBsZW4pICE9IGxlbikgewoJCWludCBlcnIgPSBlcnJubzsKCQljbG9zZShmZCk7CgkJZXJy
bm8gPSBlcnI7CgkJcmV0dXJuIGZhbHNlOwoJfQoJY2xvc2UoZmQpOwoJcmV0dXJuIHRydWU7Cn0K
CnN0YXRpYyBsb25nIHN5el9vcGVuX2Rldih2b2xhdGlsZSBsb25nIGEwLCB2b2xhdGlsZSBsb25n
IGExLCB2b2xhdGlsZSBsb25nIGEyKQp7CglpZiAoYTAgPT0gMHhjIHx8IGEwID09IDB4YikgewoJ
CWNoYXIgYnVmWzEyOF07CgkJc3ByaW50ZihidWYsICIvZGV2LyVzLyVkOiVkIiwgYTAgPT0gMHhj
ID8gImNoYXIiIDogImJsb2NrIiwgKHVpbnQ4X3QpYTEsICh1aW50OF90KWEyKTsKCQlyZXR1cm4g
b3BlbihidWYsIE9fUkRXUiwgMCk7Cgl9IGVsc2UgewoJCWNoYXIgYnVmWzEwMjRdOwoJCWNoYXIq
IGhhc2g7CgkJc3RybmNweShidWYsIChjaGFyKilhMCwgc2l6ZW9mKGJ1ZikgLSAxKTsKCQlidWZb
c2l6ZW9mKGJ1ZikgLSAxXSA9IDA7CgkJd2hpbGUgKChoYXNoID0gc3RyY2hyKGJ1ZiwgJyMnKSkp
IHsKCQkJKmhhc2ggPSAnMCcgKyAoY2hhcikoYTEgJSAxMCk7CgkJCWExIC89IDEwOwoJCX0KCQly
ZXR1cm4gb3BlbihidWYsIGEyLCAwKTsKCX0KfQoKc3RhdGljIHZvaWQga2lsbF9hbmRfd2FpdChp
bnQgcGlkLCBpbnQqIHN0YXR1cykKewoJa2lsbCgtcGlkLCBTSUdLSUxMKTsKCWtpbGwocGlkLCBT
SUdLSUxMKTsKCWZvciAoaW50IGkgPSAwOyBpIDwgMTAwOyBpKyspIHsKCQlpZiAod2FpdHBpZCgt
MSwgc3RhdHVzLCBXTk9IQU5HIHwgX19XQUxMKSA9PSBwaWQpCgkJCXJldHVybjsKCQl1c2xlZXAo
MTAwMCk7Cgl9CglESVIqIGRpciA9IG9wZW5kaXIoIi9zeXMvZnMvZnVzZS9jb25uZWN0aW9ucyIp
OwoJaWYgKGRpcikgewoJCWZvciAoOzspIHsKCQkJc3RydWN0IGRpcmVudCogZW50ID0gcmVhZGRp
cihkaXIpOwoJCQlpZiAoIWVudCkKCQkJCWJyZWFrOwoJCQlpZiAoc3RyY21wKGVudC0+ZF9uYW1l
LCAiLiIpID09IDAgfHwgc3RyY21wKGVudC0+ZF9uYW1lLCAiLi4iKSA9PSAwKQoJCQkJY29udGlu
dWU7CgkJCWNoYXIgYWJvcnRbMzAwXTsKCQkJc25wcmludGYoYWJvcnQsIHNpemVvZihhYm9ydCks
ICIvc3lzL2ZzL2Z1c2UvY29ubmVjdGlvbnMvJXMvYWJvcnQiLCBlbnQtPmRfbmFtZSk7CgkJCWlu
dCBmZCA9IG9wZW4oYWJvcnQsIE9fV1JPTkxZKTsKCQkJaWYgKGZkID09IC0xKSB7CgkJCQljb250
aW51ZTsKCQkJfQoJCQlpZiAod3JpdGUoZmQsIGFib3J0LCAxKSA8IDApIHsKCQkJfQoJCQljbG9z
ZShmZCk7CgkJfQoJCWNsb3NlZGlyKGRpcik7Cgl9IGVsc2UgewoJfQoJd2hpbGUgKHdhaXRwaWQo
LTEsIHN0YXR1cywgX19XQUxMKSAhPSBwaWQpIHsKCX0KfQoKc3RhdGljIHZvaWQgc2V0dXBfdGVz
dCgpCnsKCXByY3RsKFBSX1NFVF9QREVBVEhTSUcsIFNJR0tJTEwsIDAsIDAsIDApOwoJc2V0cGdy
cCgpOwoJd3JpdGVfZmlsZSgiL3Byb2Mvc2VsZi9vb21fc2NvcmVfYWRqIiwgIjEwMDAiKTsKfQoK
c3RhdGljIHZvaWQgZXhlY3V0ZV9vbmUodm9pZCk7CgojZGVmaW5lIFdBSVRfRkxBR1MgX19XQUxM
CgpzdGF0aWMgdm9pZCBsb29wKHZvaWQpCnsKCWludCBpdGVyID0gMDsKCWZvciAoOzsgaXRlcisr
KSB7CgkJaW50IHBpZCA9IGZvcmsoKTsKCQlpZiAocGlkIDwgMCkKCWV4aXQoMSk7CgkJaWYgKHBp
ZCA9PSAwKSB7CgkJCXNldHVwX3Rlc3QoKTsKCQkJZXhlY3V0ZV9vbmUoKTsKCQkJZXhpdCgwKTsK
CQl9CgkJaW50IHN0YXR1cyA9IDA7CgkJdWludDY0X3Qgc3RhcnQgPSBjdXJyZW50X3RpbWVfbXMo
KTsKCQlmb3IgKDs7KSB7CgkJCWlmICh3YWl0cGlkKC0xLCAmc3RhdHVzLCBXTk9IQU5HIHwgV0FJ
VF9GTEFHUykgPT0gcGlkKQoJCQkJYnJlYWs7CgkJCXNsZWVwX21zKDEpOwoJCQlpZiAoY3VycmVu
dF90aW1lX21zKCkgLSBzdGFydCA8IDUwMDApCgkJCQljb250aW51ZTsKCQkJa2lsbF9hbmRfd2Fp
dChwaWQsICZzdGF0dXMpOwoJCQlicmVhazsKCQl9Cgl9Cn0KCnVpbnQ2NF90IHJbMl0gPSB7MHhm
ZmZmZmZmZmZmZmZmZmZmLCAweGZmZmZmZmZmZmZmZmZmZmZ9OwoKdm9pZCBleGVjdXRlX29uZSh2
b2lkKQp7CgkJaW50cHRyX3QgcmVzID0gMDsKbWVtY3B5KCh2b2lkKikweDIwMDAwMmMwLCAiL2Rl
di9uYmQjXDAwMCIsIDEwKTsKCXJlcyA9IC0xOwpyZXMgPSBzeXpfb3Blbl9kZXYoMHgyMDAwMDJj
MCwgMCwgMCk7CglpZiAocmVzICE9IC0xKQoJCXJbMF0gPSByZXM7CglyZXMgPSBzeXNjYWxsKF9f
TlJfc29ja2V0cGFpciwgMHgxZXVsLCA1dWwsIDAsIDB4MjAwMDFjODB1bCk7CglpZiAocmVzICE9
IC0xKQpyWzFdID0gKih1aW50MzJfdCopMHgyMDAwMWM4MDsKCXN5c2NhbGwoX19OUl9pb2N0bCwg
clswXSwgMHhhYjAwLCByWzFdKTsKbWVtY3B5KCh2b2lkKikweDIwMDAwMDAwLCAiLi9maWxlMFww
MDAiLCA4KTsKCXN5c2NhbGwoX19OUl9ta2RpciwgMHgyMDAwMDAwMHVsLCAwdWwpOwptZW1jcHko
KHZvaWQqKTB4MjAwMDAwNDAsICIvZGV2L25iZCIsIDgpOwoqKHVpbnQ4X3QqKTB4MjAwMDAwNDgg
PSAweDMwOwoqKHVpbnQ4X3QqKTB4MjAwMDAwNDkgPSAwOwptZW1jcHkoKHZvaWQqKTB4MjAwMDAx
NDAsICIuL2ZpbGUwXDAwMCIsIDgpOwptZW1jcHkoKHZvaWQqKTB4MjAwMDAxODAsICJnZnMyXDAw
MCIsIDUpOwoJc3lzY2FsbChfX05SX21vdW50LCAweDIwMDAwMDQwdWwsIDB4MjAwMDAxNDB1bCwg
MHgyMDAwMDE4MHVsLCAwdWwsIDB1bCk7Cgp9CmludCBtYWluKHZvaWQpCnsKCQlzeXNjYWxsKF9f
TlJfbW1hcCwgMHgxZmZmZjAwMHVsLCAweDEwMDB1bCwgMHVsLCAweDMydWwsIC0xLCAwdWwpOwoJ
c3lzY2FsbChfX05SX21tYXAsIDB4MjAwMDAwMDB1bCwgMHgxMDAwMDAwdWwsIDd1bCwgMHgzMnVs
LCAtMSwgMHVsKTsKCXN5c2NhbGwoX19OUl9tbWFwLCAweDIxMDAwMDAwdWwsIDB4MTAwMHVsLCAw
dWwsIDB4MzJ1bCwgLTEsIDB1bCk7CgkJCWxvb3AoKTsKCXJldHVybiAwOwp9Cg==
--00000000000011a1c705e4cfc9e1
Content-Type: application/octet-stream; name="repro.syz"
Content-Disposition: attachment; filename="repro.syz"
Content-Transfer-Encoding: base64
Content-ID: <f_l643h3um1>
X-Attachment-Id: f_l643h3um1

cjAgPSBzeXpfb3Blbl9kZXYkbmRiKCYoMHg3ZjAwMDAwMDAyYzApLCAweDAsIDB4MCkKc29ja2V0
cGFpcigweDFlLCAweDUsIDB4MCwgJigweDdmMDAwMDAwMWM4MCk9ezxyMT0+MHhmZmZmZmZmZmZm
ZmZmZmZmfSkKaW9jdGwkTkJEX1NFVF9TT0NLKHIwLCAweGFiMDAsIHIxKQpta2RpcigmKDB4N2Yw
MDAwMDAwMDAwKT0nLi9maWxlMFx4MDAnLCAweDApCm1vdW50KCYoMHg3ZjAwMDAwMDAwNDApPUBu
YmQ9eycvZGV2L25iZCcsIDB4MH0sICYoMHg3ZjAwMDAwMDAxNDApPScuL2ZpbGUwXHgwMCcsICYo
MHg3ZjAwMDAwMDAxODApPSdnZnMyXHgwMCcsIDB4MCwgMHgwKQo=
--00000000000011a1c705e4cfc9e1--
