Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CEE4980F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbiAXNXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:23:24 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:48928 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242817AbiAXNXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:23:22 -0500
Received: by mail-il1-f198.google.com with SMTP id t18-20020a92ca92000000b002b952c60bfbso8125110ilo.15
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 05:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UwVYcwjIbXXhRYDfOcKoTuvxpfCtFVOrX+FsCBnaKME=;
        b=hkKDbUunrwapTQtKm/s0N/WsKpWwIswT89qku74XzJnNDO0kvLsbvegtphKezlC+gx
         7/u3bOYMd2sP3i4xNmLuDI0DTZfi41jVFKJB3eX02awzyTh9mbZigw95yN+v/y7c5/6M
         EmKRDHfo8o/DU0f0xC++fDk/KLHid3GKNLw+v2bBdVLDbff9fJ1IaDtFwoqz12OKe2Z3
         32aWa+w2w80JGDYBJkYG8mi62DUP9U0KCMROLY7s9s4MJEBVD+cy96EiVYcKD2R8riYy
         JFraQimEfCiIf1FEDpQY84OJpqxQGCj0rhoFCGud1E3ldr58P/QWPftZ6byxi4Wa2wE8
         qYxA==
X-Gm-Message-State: AOAM532QYtihtM4gHPcQN8kee1TXk5ajUC0VBYFlxKeaxjRstFo8D116
        JOSu5KkPEYkuF36pbzaEbnZ5LUdA7/UwD6n4up0S6cFeaFbd
X-Google-Smtp-Source: ABdhPJw/vHFHHVex5TcHa8lOoHF8V1vZ9VrUAs3BV26xmI87lZ6a9xYoIt2EDGVC3C152c7Ce+Wxvk7dXV2U5mfeEqex5vLaGosO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1213:: with SMTP id a19mr8299952ilq.14.1643030602129;
 Mon, 24 Jan 2022 05:23:22 -0800 (PST)
Date:   Mon, 24 Jan 2022 05:23:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006527b405d653df1f@google.com>
Subject: [syzbot] INFO: task can't die in show_free_areas
From:   syzbot <syzbot+8f41dccfb6c03cc36fd6@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    74e5dee6a5b9 Add linux-next specific files for 20220124
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16fbb967b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2242b42e3f4b745
dashboard link: https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f41dccfb6c03cc36fd6@syzkaller.appspotmail.com

INFO: task syz-executor.5:19074 can't die for more than 143 seconds.
task:syz-executor.5  state:R  running task     stack:26128 pid:19074 ppid:  3634 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4db0 kernel/sched/core.c:6295
 preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:6461
 preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:35
 vprintk_emit+0x1c9/0x4f0 kernel/printk/printk.c:2249
 vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
 _printk+0xba/0xed kernel/printk/printk.c:2269
 show_free_areas+0xc99/0x1120 mm/page_alloc.c:6082
 show_mem+0x31/0x191 lib/show_mem.c:17
 warn_alloc_show_mem mm/page_alloc.c:4214 [inline]
 warn_alloc.cold+0x121/0x189 mm/page_alloc.c:4239
 __vmalloc_area_node mm/vmalloc.c:2982 [inline]
 __vmalloc_node_range+0xe0a/0x1040 mm/vmalloc.c:3110
 __vmalloc_node mm/vmalloc.c:3160 [inline]
 vzalloc+0x67/0x80 mm/vmalloc.c:3238
 n_tty_open+0x16/0x170 drivers/tty/n_tty.c:1813
 tty_ldisc_open+0x9b/0x110 drivers/tty/tty_ldisc.c:433
 tty_ldisc_setup+0x43/0x100 drivers/tty/tty_ldisc.c:740
 tty_init_dev.part.0+0x1f4/0x610 drivers/tty/tty_io.c:1443
 tty_init_dev include/linux/err.h:36 [inline]
 tty_open_by_driver drivers/tty/tty_io.c:2086 [inline]
 tty_open+0xb16/0x1000 drivers/tty/tty_io.c:2133
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x1240 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0116f1e059
RSP: 002b:00007f01157ee168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f0117031370 RCX: 00007f0116f1e059
RDX: 0000000000000000 RSI: 0000000020000200 RDI: ffffffffffffff9c
RBP: 00007f0116f7808d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd12bd1c4f R14: 00007f01157ee300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u4:0/8:
 #0: ffff8880b9d39c58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:489
 #1: ffff8880b9d27948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x176/0x4e0 kernel/sched/psi.c:882
 #2: ffff8880b9d28498 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:946
1 lock held by khungtaskd/26:
 #0: ffffffff8bb83ae0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6460
2 locks held by getty/3283:
 #0: ffff888022a54098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002b632e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2077
5 locks held by kworker/0:12/18357:
 #0: ffff8880b9c39c58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:489
 #1: ffff8880b9c27948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3e7/0x4e0 kernel/sched/psi.c:891
 #2: ffff8880b9c28498 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:946
 #3: ffffffff9077a3d0 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x12e/0x3e0 lib/debugobjects.c:661
 #4: ffffffff90797a10 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_check_no_obj_freed lib/debugobjects.c:980 [inline]
 #4: ffffffff90797a10 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_check_no_obj_freed+0xc7/0x420 lib/debugobjects.c:1023
3 locks held by syz-executor.5/19074:

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
