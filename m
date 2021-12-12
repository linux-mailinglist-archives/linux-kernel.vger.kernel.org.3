Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E654471953
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 09:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhLLIkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 03:40:20 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:50937 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhLLIkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 03:40:19 -0500
Received: by mail-il1-f200.google.com with SMTP id i3-20020a056e021b0300b0029eceae8532so13243961ilv.17
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 00:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+fP7pu5dpdXTe1CRYltw1vlONCE28MLIQNF6LFml/2Y=;
        b=KRoDDBB0R4UJRQHl9Gz7XhyQql/yQkW/dl9wg4Lz7CdyOTtKou0yuVBhyFMG1fvsxf
         1SQme3EZ6oL9UYlr6D7jXioCQyHHVJfww4XTEv73fNaX+aR+hLopid3YaXi7RCq7MWs9
         21iYQGGMFZ4MR4RAeysS1JwC9YWajNFP8+krasUyAi6RVIwGzfgD5TYjh6yL0/1NXieS
         sNwBjD3QgNR4X7g495JpcPSuiPlMtsdQhoih4SGZZQT0k/V5XslIX+aPpgPaa11xPnW+
         4bQmU9NnFiQ+0vG/oJu4HaQjbJ8wwnHtrrZgqWs4oa7mXq+YfUkXw37cDsG/3wLAp94L
         QPig==
X-Gm-Message-State: AOAM531z44T6/Du2SLxWPsM/9vMIAYrcc3050rKHGiPt5kargXNuV7yp
        vLP/2eBVxuqmhwx8DeCCc+LJAMuKaYqLZpY7E/DaaxtkHTHf
X-Google-Smtp-Source: ABdhPJzqOR+4MNKjTcQnNIf1/86Ieop4B3cAMpT7jFIIk0ZcZWgmIgNT5RQcZ8JcDFioIr//U8lZtwDKdRvK+Lj1qeimTeuuqseM
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:: with SMTP id h8mr30716815ila.138.1639298419233;
 Sun, 12 Dec 2021 00:40:19 -0800 (PST)
Date:   Sun, 12 Dec 2021 00:40:19 -0800
In-Reply-To: <00000000000050185105d2ac05d2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5973605d2eee776@google.com>
Subject: Re: [syzbot] INFO: task can't die in reclaim_throttle
From:   syzbot <syzbot+dcea9eda277e1090b35f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ea922272cbe5 Add linux-next specific files for 20211210
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=130f5f75b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1359a19d2230002
dashboard link: https://syzkaller.appspot.com/bug?extid=dcea9eda277e1090b35f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f4a551b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1613df3ab00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcea9eda277e1090b35f@syzkaller.appspotmail.com

INFO: task syz-executor786:3696 can't die for more than 143 seconds.
task:syz-executor786 state:D stack:28344 pid: 3696 ppid:  3669 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4d90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1881
 reclaim_throttle+0x1ce/0x5e0 mm/vmscan.c:1072
 consider_reclaim_throttle mm/vmscan.c:3399 [inline]
 shrink_zones mm/vmscan.c:3486 [inline]
 do_try_to_free_pages+0x7cd/0x1620 mm/vmscan.c:3541
 try_to_free_mem_cgroup_pages+0x2cd/0x840 mm/vmscan.c:3855
 reclaim_high.constprop.0+0x190/0x250 mm/memcontrol.c:2299
 mem_cgroup_handle_over_high+0x18c/0x540 mm/memcontrol.c:2483
 tracehook_notify_resume include/linux/tracehook.h:198 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x1ab/0x290 kernel/entry/common.c:207
 irqentry_exit_to_user_mode+0x5/0x40 kernel/entry/common.c:313
 exc_page_fault+0xc6/0x180 arch/x86/mm/fault.c:1543
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:568
RIP: 0033:0x7fd40489c3ee
RSP: 002b:00007ffe50e3a520 EFLAGS: 00010202
RAX: 00007fd4049253d0 RBX: 00007fd40491e508 RCX: 00007fd40489c3cb
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 00005555571d1300
R10: 00005555571d15d0 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffe50e3a5a0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bb818a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6460
6 locks held by kworker/u4:2/50:
 #0: ffff8880b9d39c98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:489
 #1: ffff8880b9d27988 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x176/0x4e0 kernel/sched/psi.c:882
 #2: ffff8880b9d284d8 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:946
 #3: ffffffff90799400 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x12e/0x3e0 lib/debugobjects.c:661
 #4: ffffffff8ba4a548 (text_mutex){+.+.}-{3:3}, at: arch_jump_label_transform_apply+0xe/0x20 arch/x86/kernel/jump_label.c:145
 #5: ffff888010dbb138 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
 #5: ffff888010dbb138 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: __get_locked_pte+0x2b6/0x4d0 mm/memory.c:1722
1 lock held by syslogd/2955:
 #0: ffff8880b9d39c98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:489
2 locks held by getty/3289:
 #0: ffff88814a873098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002b962e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2077
3 locks held by syz-executor786/3925:
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1310 [inline]
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1296 [inline]
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1296
 #1: ffff88801dc3c888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x287/0x500 fs/kernfs/file.c:287
 #2: ffff888070e3c3a8 (kn->active#167){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ab/0x500 fs/kernfs/file.c:288
3 locks held by syz-executor786/3928:
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1310 [inline]
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1296 [inline]
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1296
 #1: ffff88801dc3cc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x287/0x500 fs/kernfs/file.c:287
 #2: ffff888070e3c3a8 (kn->active#167){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ab/0x500 fs/kernfs/file.c:288
3 locks held by syz-executor786/3931:
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1310 [inline]
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1296 [inline]
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1296
 #1: ffff888077934488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x287/0x500 fs/kernfs/file.c:287
 #2: ffff888070e3c3a8 (kn->active#167){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ab/0x500 fs/kernfs/file.c:288
3 locks held by syz-executor786/3933:
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1310 [inline]
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1296 [inline]
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1296
 #1: ffff88801dc3d488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x287/0x500 fs/kernfs/file.c:287
 #2: ffff888070e3c3a8 (kn->active#167){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ab/0x500 fs/kernfs/file.c:288
3 locks held by syz-executor786/3935:
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1310 [inline]
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1296 [inline]
 #0: ffff88807fb82460 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1296
 #1: ffff88801dc3d888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x287/0x500 fs/kernfs/file.c:287
 #2: ffff888070e3c3a8 (kn->active#167){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ab/0x500 fs/kernfs/file.c:288

=============================================


