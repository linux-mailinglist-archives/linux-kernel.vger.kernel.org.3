Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD3483F8F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiADKDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:03:18 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:48975 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiADKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:03:17 -0500
Received: by mail-il1-f200.google.com with SMTP id k1-20020a92c9c1000000b002b43128af01so19310929ilq.15
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 02:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J8A1XgGlAEaiBhKwX89IXTy/77Y1cHQmnJJ+Cm54414=;
        b=BIgTnrqv1KqWp5j7RvTp2nZXk3I6IETLf8V+bcnQY8iXMkVlUs6pgAm1onbQWsKRNX
         AEfT248pnJTNnLjVhpJ+C3GxPOCZmp5UeLn3a76a1sPJPY5UsFV8QJTUUI8Ynx7sVhhw
         mlmNvrgBsaSiVJqk8sbFOOBGRT8owLTU2dZmwghARV8Ii9F1H22+ApDzyfecKnYV1xl9
         BErV1PzznMBQiuaUUgBOa5ZCnJ7xv8oVf1cGMYbTXtWbVpcN8q/EMtSerEsDSdf3yxy2
         APHbFwCF1XSKY9WRX1S/e0DCTHNDOuyIVuy/UnbshsIBuLvS0znKm+DnskP0qU0KlACk
         2u3A==
X-Gm-Message-State: AOAM5310x497L8m9VBFuuXDfYHjq+5KUvhyEVlFiP5e9BQEmiW69Wpxj
        qOaATcacnnaqaZCfsuvYy7IHN6pUhiOtd1VhqbR0tINr5AGW
X-Google-Smtp-Source: ABdhPJzles1c3lbSI8RKsh2tmGlxY6oCdCe7Kuh7VZ11Hlf51gfYD6EOoV8vUrtYUPkoVwJgwt1DoWsHO//Fi7R2pEi9XS87MeK8
MIME-Version: 1.0
X-Received: by 2002:a6b:5111:: with SMTP id f17mr22689256iob.180.1641290597159;
 Tue, 04 Jan 2022 02:03:17 -0800 (PST)
Date:   Tue, 04 Jan 2022 02:03:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004591305d4bebf11@google.com>
Subject: [syzbot] KMSAN: uninit-value in mpol_rebind_task (2)
From:   syzbot <syzbot+217f792c92599518a2ab@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, glider@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    81c325bbf94e kmsan: hooks: do not check memory in kmsan_in..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=112b8f7db00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
dashboard link: https://syzkaller.appspot.com/bug?extid=217f792c92599518a2ab
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13366ea5b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14526cb3b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+217f792c92599518a2ab@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in mpol_rebind_policy mm/mempolicy.c:352 [inline]
BUG: KMSAN: uninit-value in mpol_rebind_task+0x2ac/0x2c0 mm/mempolicy.c:368
 mpol_rebind_policy mm/mempolicy.c:352 [inline]
 mpol_rebind_task+0x2ac/0x2c0 mm/mempolicy.c:368
 cpuset_change_task_nodemask kernel/cgroup/cpuset.c:1711 [inline]
 cpuset_attach+0x787/0x15e0 kernel/cgroup/cpuset.c:2278
 cgroup_migrate_execute+0x1023/0x1d20 kernel/cgroup/cgroup.c:2515
 cgroup_migrate kernel/cgroup/cgroup.c:2771 [inline]
 cgroup_attach_task+0x540/0x8b0 kernel/cgroup/cgroup.c:2804
 __cgroup1_procs_write+0x5cc/0x7a0 kernel/cgroup/cgroup-v1.c:520
 cgroup1_tasks_write+0x94/0xb0 kernel/cgroup/cgroup-v1.c:539
 cgroup_file_write+0x4c2/0x9e0 kernel/cgroup/cgroup.c:3852
 kernfs_fop_write_iter+0x66a/0x9f0 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write fs/read_write.c:503 [inline]
 vfs_write+0x1318/0x2030 fs/read_write.c:590
 ksys_write+0x28b/0x510 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0xdb/0x120 fs/read_write.c:652
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3251 [inline]
 slab_alloc mm/slub.c:3259 [inline]
 kmem_cache_alloc+0x902/0x11c0 mm/slub.c:3264
 mpol_new mm/mempolicy.c:293 [inline]
 do_set_mempolicy+0x421/0xb70 mm/mempolicy.c:853
 kernel_set_mempolicy mm/mempolicy.c:1504 [inline]
 __do_sys_set_mempolicy mm/mempolicy.c:1510 [inline]
 __se_sys_set_mempolicy+0x44c/0xb60 mm/mempolicy.c:1507
 __x64_sys_set_mempolicy+0xd8/0x110 mm/mempolicy.c:1507
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

CPU: 1 PID: 3479 Comm: syz-executor124 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
