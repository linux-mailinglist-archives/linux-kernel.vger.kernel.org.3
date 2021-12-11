Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA8471655
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhLKVLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:11:21 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:34678 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhLKVLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:11:18 -0500
Received: by mail-il1-f199.google.com with SMTP id h10-20020a056e021b8a00b002a3f246adeaso12693032ili.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 13:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CYGR9bZw+KIePmDbKlN+yDXqrqSokfI8Kg57QmN2R08=;
        b=BIgR8yZIcU0IA3921ZPa5PhAtR6A/8XwinGgxDHtq/BwV/dYoW0Pq7hqfkrj4kofJ0
         CwZbuJ8N6NyMSDsUIzESW1I69xcr/sO6aAxIwZQRnoAYFNh1mTPNiV2oyYnhPBQtNv4J
         s8GqE3c3ER6YRDF0eOc5S9H4BE33G8Dfd0D1VGuFHl/DuiNEQyv59GpOOUH352mqMXQd
         53CGhN00o0PEKhhpQeAwNmSounzBNYJSWso0TGfjO23DW2SPPS3yAsYJe458Kyi4TzE5
         SrwQbtVGUOZhiRrch4hIeH0MN5688IfCJ3OQfHm/B/q1mp+gN4te8/tKwor2hqC/UAZV
         XmWg==
X-Gm-Message-State: AOAM531O/YkvmZwWvSLoECl5F9AH550fE4Izu/k5uTh9yCb733FjcbL7
        kBdlGqPYWFiP6YvGw3yj6n4EWoFy7L7xLGJoDdP28edpha1G
X-Google-Smtp-Source: ABdhPJymjaYNAjYQ48XUhE4xMGPHtNR/UJeJEwZ02kt+IgRx2mzJOo0Ae/bfuGwX2GGL6S8sHgWInfgmV8TD737O15Yf9vuSST9J
MIME-Version: 1.0
X-Received: by 2002:a05:6602:490:: with SMTP id y16mr27206525iov.162.1639257078190;
 Sat, 11 Dec 2021 13:11:18 -0800 (PST)
Date:   Sat, 11 Dec 2021 13:11:18 -0800
In-Reply-To: <00000000000050185105d2ac05d2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7549b05d2e54715@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15175f75b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1359a19d2230002
dashboard link: https://syzkaller.appspot.com/bug?extid=dcea9eda277e1090b35f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d842b1b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcea9eda277e1090b35f@syzkaller.appspotmail.com

INFO: task syz-executor.1:3674 can't die for more than 143 seconds.
task:syz-executor.1  state:D stack:23920 pid: 3674 ppid:     1 flags:0x00004004
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
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f345ee5e9d8
RSP: 002b:00007fff5c713cb0 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
RAX: 0000000000000003 RBX: 0000000000000003 RCX: 00007f345ee5e9d8
RDX: 0000000000090800 RSI: 00007f345eeb8256 RDI: 00000000ffffff9c
RBP: 00007fff5c713d7c R08: 0000000000090800 R09: 00007f345eeb8256
R10: 0000000000000000 R11: 0000000000000287 R12: 0000000000000000
R13: 00000000000b3eac R14: 000000000000000b R15: 00007fff5c713de0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/26:
 #0: ffffffff8bb818a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6460
1 lock held by klogd/2959:
2 locks held by getty/3289:
 #0: ffff88823bcca898 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002b962e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2077
2 locks held by kworker/u4:1/3705:
 #0: ffff8880b9c39c98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:489
 #1: ffff8880b9c27988 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3e7/0x4e0 kernel/sched/psi.c:891

=============================================


