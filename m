Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12DF468385
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384450AbhLDJWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:22:00 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:38820 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384430AbhLDJVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:21:53 -0500
Received: by mail-io1-f69.google.com with SMTP id l124-20020a6b3e82000000b005ed165a1506so4415858ioa.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 01:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BieNe7yuzJXqBMx62R9EP5CNnpY06fgxYI8rI82ZXHs=;
        b=glvSA7GeF9kMToAQirv9rdrENXNlGYcDfZBWqZoBSTEIlmTUhIyLTUgZkOzujbrGtw
         ti4DHi1KkGWf0YaVZXqq4qJCiO2tVItTCXSC4iHgIZUHXUg3ZddAMs9nDp/aVyAOLPQQ
         STV5Sk3jIq/e7/T2JyzdlJ+FL45NkEGbxZiAdudxRJy5fP3lRFE5L+gGhNIdlJmVc6kM
         Pvpf6JYH7WTUEBbVGhkUw7ZaBOr29BLPGBYDCUlb7ygP8/AAtHjWzrNBaF63DdO2Bo2l
         kuBpyAydg1sgKDnWJkwZLeT/dHQdtCLOHl3Odk9LFIbEMNWyFbhWQtkUK6dXs9r80KEP
         8mTw==
X-Gm-Message-State: AOAM530e/f74airK3EN5vwDOdD0MAkvapLonkFzlcXwn/pv7e9/j1ZEL
        GEqAp7YUPANcx7x7xr4xwaqHaZOX189+3Hjq6MWlgy0ALpgm
X-Google-Smtp-Source: ABdhPJwK+g7luujkCE5ZVxBlzyxt0QnOYsjHPTV3q/8dSsX+xVd4JRprWT3cMw6VYP/0aF5pkFjPe/jWsJ32tl18MW4XZtHBP5Om
MIME-Version: 1.0
X-Received: by 2002:a02:ba8b:: with SMTP id g11mr28396335jao.128.1638609508103;
 Sat, 04 Dec 2021 01:18:28 -0800 (PST)
Date:   Sat, 04 Dec 2021 01:18:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7fb8905d24e815b@google.com>
Subject: [syzbot] WARNING: refcount bug in v9fs_fid_find
From:   syzbot <syzbot+627aa2ba3ada9ff256dd@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    58e1100fdc59 MAINTAINERS: co-maintain random.c
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f41219b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=171728a464c05f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=627aa2ba3ada9ff256dd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+627aa2ba3ada9ff256dd@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 2 PID: 13516 at lib/refcount.c:25 refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
Modules linked in:
CPU: 2 PID: 13516 Comm: syz-executor.3 Not tainted 5.16.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
Code: 09 31 ff 89 de e8 d7 3f 9c fd 84 db 0f 85 36 ff ff ff e8 ea 3b 9c fd 48 c7 c7 20 4b 04 8a c6 05 96 c5 a1 09 01 e8 50 d2 25 05 <0f> 0b e9 17 ff ff ff e8 cb 3b 9c fd 0f b6 1d 7b c5 a1 09 31 ff 89
RSP: 0018:ffffc90002b1f8e8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815e5208 RDI: fffff52000563f0f
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff815defae R11: 0000000000000000 R12: ffff88802653b800
R13: ffff88802653b80c R14: 1ffff92000563f22 R15: 0000000000000000
FS:  00007f7d5c4e2700(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f07cbcd8000 CR3: 0000000069e46000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:199 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 v9fs_fid_find+0x471/0x4e0 fs/9p/fid.c:111
 v9fs_fid_lookup_with_uid+0xa2/0xae0 fs/9p/fid.c:160
 v9fs_fid_clone fs/9p/fid.h:27 [inline]
 v9fs_file_open+0x2de/0x870 fs/9p/vfs_file.c:60
 do_dentry_open+0x4c8/0x1250 fs/open.c:822
 do_open fs/namei.c:3426 [inline]
 path_openat+0x1cad/0x2750 fs/namei.c:3559
 do_filp_open+0x1aa/0x400 fs/namei.c:3586
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1212
 do_sys_open fs/open.c:1228 [inline]
 __do_sys_creat fs/open.c:1304 [inline]
 __se_sys_creat fs/open.c:1298 [inline]
 __x64_sys_creat+0xc9/0x120 fs/open.c:1298
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f7d5ef6cae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7d5c4e2188 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f7d5f07ff60 RCX: 00007f7d5ef6cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000140
RBP: 00007f7d5efc6f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe7bcaa9bf R14: 00007f7d5c4e2300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
