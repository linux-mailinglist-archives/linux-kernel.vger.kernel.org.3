Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4E470119
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbhLJNDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:03:04 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:55070 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbhLJNDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:03:01 -0500
Received: by mail-il1-f197.google.com with SMTP id f5-20020a056e02168500b002a169f37fbcso10343093ila.21
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 04:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QXA1J4Lp8ue2OKdc5uzeLUVNYIb4bIFu9fxJrspE9qE=;
        b=Qer31WCB4jz4OU3QI6E9OzDrcqwYcFWi/jkdomDAF0WN3waRE+l50I2X2DkC4tw6w1
         tXc7rsF0vD9HGOX9nTZwY1rpTPYB8eZs8FmlTGhTI/ezm83REtF2KGHSdQdGV6gvNEJp
         GDV7Ft1YPuEop1eBodwvqWzw4/Ee071jv03Mb0F5tioNZ/kml7YgvX6BnTUGATBwTGMN
         HBcDeNv8k5+om+6u7WwwDusPWkAqX2uzsKM4D5MGWfIPaPDn0a6+XnG9Z5eY+CJHKRZG
         VAemscLrUOUw9GJStFWVx815xC+oOWObSGP34UX6mW7sh7oFxusend/Z9woSlKpXQwyn
         EQcA==
X-Gm-Message-State: AOAM531JTzWfKnbjW6yvOCHDZmI8uh18/1Gzf/EAMiOVsYYOTqSHrsBx
        NhfK//bT21PC0K9DxDqMyh/8he/flqv/uzQ4Eas9Qe7bMXPY
X-Google-Smtp-Source: ABdhPJyJ/96NUshW7LvPD4Qb/y9KCPOsHzIc6XUx4gcS1TWQEYElPjP+1g/Uh/mRVJXnEVmPYC4Zp+4cT/AvLVXxy0yA6SsvSBNP
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d0:: with SMTP id g16mr19604046ioo.70.1639141166144;
 Fri, 10 Dec 2021 04:59:26 -0800 (PST)
Date:   Fri, 10 Dec 2021 04:59:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1de5405d2ca4ae2@google.com>
Subject: [syzbot] KMSAN: uninit-value in make_kuid
From:   syzbot <syzbot+ce39644883793043ee77@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        cxfcosmos@gmail.com, ebiederm@xmission.com, glider@google.com,
        legion@kernel.org, linux-kernel@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b0f85c4ccdd4 kmsan: report: add dump_stack_print_info()
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1704eaf9b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e00a8959fdd3f3e8
dashboard link: https://syzkaller.appspot.com/bug?extid=ce39644883793043ee77
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce39644883793043ee77@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in map_id_range_down_base kernel/user_namespace.c:288 [inline]
BUG: KMSAN: uninit-value in map_id_range_down kernel/user_namespace.c:302 [inline]
BUG: KMSAN: uninit-value in map_id_down kernel/user_namespace.c:317 [inline]
BUG: KMSAN: uninit-value in make_kuid+0x450/0xc70 kernel/user_namespace.c:394
 map_id_range_down_base kernel/user_namespace.c:288 [inline]
 map_id_range_down kernel/user_namespace.c:302 [inline]
 map_id_down kernel/user_namespace.c:317 [inline]
 make_kuid+0x450/0xc70 kernel/user_namespace.c:394
 p9pdu_vreadf net/9p/protocol.c:167 [inline]
 p9pdu_readf+0x1378/0x4fc0 net/9p/protocol.c:526
 p9pdu_vreadf net/9p/protocol.c:312 [inline]
 p9pdu_readf+0x1cd0/0x4fc0 net/9p/protocol.c:526
 p9_client_getattr_dotl+0x2de/0x7f0 net/9p/client.c:1768
 v9fs_refresh_inode_dotl+0xb9/0x320 fs/9p/vfs_inode_dotl.c:958
 v9fs_lookup_revalidate+0x33d/0x440 fs/9p/vfs_dentry.c:85
 complete_walk+0x5a0/0x680 fs/namei.c:914
 path_lookupat+0x441/0x8a0 fs/namei.c:2456
 filename_lookup+0x66e/0xa50 fs/namei.c:2480
 user_path_at_empty+0x135/0x430 fs/namei.c:2801
 user_path_at include/linux/namei.h:57 [inline]
 do_mount fs/namespace.c:3328 [inline]
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount+0x7f9/0xa10 fs/namespace.c:3516
 __ia32_sys_mount+0x157/0x1b0 fs/namespace.c:3516
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was stored to memory at:
 pdu_read net/9p/protocol.c:48 [inline]
 p9pdu_vreadf net/9p/protocol.c:163 [inline]
 p9pdu_readf+0x1288/0x4fc0 net/9p/protocol.c:526
 p9pdu_vreadf net/9p/protocol.c:312 [inline]
 p9pdu_readf+0x1cd0/0x4fc0 net/9p/protocol.c:526
 p9_client_getattr_dotl+0x2de/0x7f0 net/9p/client.c:1768
 v9fs_refresh_inode_dotl+0xb9/0x320 fs/9p/vfs_inode_dotl.c:958
 v9fs_lookup_revalidate+0x33d/0x440 fs/9p/vfs_dentry.c:85
 complete_walk+0x5a0/0x680 fs/namei.c:914
 path_lookupat+0x441/0x8a0 fs/namei.c:2456
 filename_lookup+0x66e/0xa50 fs/namei.c:2480
 user_path_at_empty+0x135/0x430 fs/namei.c:2801
 user_path_at include/linux/namei.h:57 [inline]
 do_mount fs/namespace.c:3328 [inline]
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount+0x7f9/0xa10 fs/namespace.c:3516
 __ia32_sys_mount+0x157/0x1b0 fs/namespace.c:3516
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was stored to memory at:
 _copy_to_iter+0x1697/0x25c0 lib/iov_iter.c:670
 __copy_page_to_iter lib/iov_iter.c:858 [inline]
 copy_page_to_iter+0x18b7/0x2650 lib/iov_iter.c:883
 pipe_read+0x12ca/0x2380 fs/pipe.c:305
 __kernel_read+0xb34/0x1380 fs/read_write.c:439
 kernel_read+0x278/0x490 fs/read_write.c:457
 p9_fd_read net/9p/trans_fd.c:263 [inline]
 p9_read_work+0x456/0x1bf0 net/9p/trans_fd.c:298
 process_one_work+0xdc2/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10f1/0x2290 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 _copy_from_iter+0x15eb/0x2520 lib/iov_iter.c:770
 copy_page_from_iter+0x1302/0x1330 lib/iov_iter.c:908
 pipe_write+0x2b9c/0x2dd0 fs/pipe.c:466
 __kernel_write+0xb3e/0x1380 fs/read_write.c:535
 kernel_write+0x47c/0xa50 fs/read_write.c:564
 p9_fd_write net/9p/trans_fd.c:428 [inline]
 p9_write_work+0xa41/0x17a0 net/9p/trans_fd.c:479
 process_one_work+0xdc2/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10f1/0x2290 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 pdu_write net/9p/protocol.c:57 [inline]
 p9pdu_vwritef+0x3799/0x5120 net/9p/protocol.c:379
 p9pdu_writef+0x23a/0x280 net/9p/protocol.c:539
 p9pdu_vwritef+0x21f0/0x5120 net/9p/protocol.c:490
 p9_client_prepare_req+0x9e3/0x1090 net/9p/client.c:703
 p9_client_rpc+0x276/0x1460 net/9p/client.c:734
 p9_client_setattr+0x115/0x2c0 net/9p/client.c:1894
 v9fs_vfs_setattr_dotl+0x7e2/0xd70 fs/9p/vfs_inode_dotl.c:588
 notify_change+0x1fe3/0x2170 fs/attr.c:410
 chown_common+0x84e/0xca0 fs/open.c:678
 do_fchownat+0x2f8/0x500 fs/open.c:709
 ksys_lchown include/linux/syscalls.h:1335 [inline]
 __do_sys_lchown16 kernel/uid16.c:30 [inline]
 __se_sys_lchown16 kernel/uid16.c:28 [inline]
 __ia32_sys_lchown16+0x200/0x250 kernel/uid16.c:28
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was stored to memory at:
 p9pdu_vwritef+0x3d7f/0x5120 net/9p/protocol.c:378
 p9pdu_writef+0x23a/0x280 net/9p/protocol.c:539
 p9pdu_vwritef+0x21f0/0x5120 net/9p/protocol.c:490
 p9_client_prepare_req+0x9e3/0x1090 net/9p/client.c:703
 p9_client_rpc+0x276/0x1460 net/9p/client.c:734
 p9_client_setattr+0x115/0x2c0 net/9p/client.c:1894
 v9fs_vfs_setattr_dotl+0x7e2/0xd70 fs/9p/vfs_inode_dotl.c:588
 notify_change+0x1fe3/0x2170 fs/attr.c:410
 chown_common+0x84e/0xca0 fs/open.c:678
 do_fchownat+0x2f8/0x500 fs/open.c:709
 ksys_lchown include/linux/syscalls.h:1335 [inline]
 __do_sys_lchown16 kernel/uid16.c:30 [inline]
 __se_sys_lchown16 kernel/uid16.c:28 [inline]
 __ia32_sys_lchown16+0x200/0x250 kernel/uid16.c:28
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was stored to memory at:
 v9fs_vfs_setattr_dotl+0x5c8/0xd70 fs/9p/vfs_inode_dotl.c:567
 notify_change+0x1fe3/0x2170 fs/attr.c:410
 chown_common+0x84e/0xca0 fs/open.c:678
 do_fchownat+0x2f8/0x500 fs/open.c:709
 ksys_lchown include/linux/syscalls.h:1335 [inline]
 __do_sys_lchown16 kernel/uid16.c:30 [inline]
 __se_sys_lchown16 kernel/uid16.c:28 [inline]
 __ia32_sys_lchown16+0x200/0x250 kernel/uid16.c:28
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Local variable newattrs created at:
 chown_common+0x120/0xca0 fs/open.c:647
 do_fchownat+0x2f8/0x500 fs/open.c:709

CPU: 0 PID: 15704 Comm: syz-executor.2 Not tainted 5.16.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
