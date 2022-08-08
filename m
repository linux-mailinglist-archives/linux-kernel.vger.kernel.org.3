Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14CB58C780
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242824AbiHHL0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiHHL0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:26:15 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0783E0A5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:26:14 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s5-20020a056e02216500b002dde8b02f62so6388663ilv.15
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 04:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=3irFrXv3REG5wxAgtft4NjnGiayOela6WnpI7Xdmj6g=;
        b=M+NIenhiXcijVzyuziBFPMojt/tj1OY6XjDJ+dyvKE5lFPh3wFnlHwEHcLXoQp46sR
         8y5KZdSGJZqAteSFIy6FU5FNg4R4ePAFtl3rHQYD0YfzVvGPo5gxEqZjIRvNFpmgGWqI
         zs2+KeWN4oVXzUNkbYMY9PhAoqk76vcukFCgmo8gbVqqi0KRBM/+eXbfwZhfdByIv1rF
         lQOI2PUjFGHpNTbFAVxowyQYD9uwP/RktDH08J7qRZ6/TVr5bYH1hgfVte5w8sBdgBAa
         tEI67rStUeCWryA4t6yJn3VjhZYK9lk5jQ5VO/cjMjWgnJfYwtt+A2iso9IZN/415moV
         J2vw==
X-Gm-Message-State: ACgBeo3KRfSlL0l7R99xxXgPoVMJPc3lCsVXe4b309iRSCKP+Bv9P7GD
        jyfGuKYVfzRAVIo6iuf8mn9O2n1MpmV51tWRcyj5lx7AL0fB
X-Google-Smtp-Source: AA6agR6F79tRsviGVjwhaMnqzpQ1e1VI1Z2hVH1Hxle9npvayNABg5SDvghFbUEV+IgcpkwQ1yt93kNVbPJMD2kegK47xh0rqvMy
MIME-Version: 1.0
X-Received: by 2002:a05:6638:300e:b0:335:c73c:3d25 with SMTP id
 r14-20020a056638300e00b00335c73c3d25mr7911971jak.77.1659957974355; Mon, 08
 Aug 2022 04:26:14 -0700 (PDT)
Date:   Mon, 08 Aug 2022 04:26:14 -0700
In-Reply-To: <20220808111439.2119-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067595b05e5b9154f@google.com>
Subject: Re: [syzbot] possible deadlock in ext4_xattr_get
From:   syzbot <syzbot+62120febbd1ee3c3c860@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in ext4_xattr_get

loop0: detected capacity change from 0 to 512
EXT4-fs (loop0): mounted filesystem without journal. Quota mode: none.
======================================================
WARNING: possible circular locking dependency detected
5.19.0-rc4-next-20220628-syzkaller-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/4081 is trying to acquire lock:
ffff888073393cf8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_get+0x14e/0xa10 fs/ext4/xattr.c:650

but task is already holding lock:
ffff888073394030 (&ea_inode->i_rwsem#9/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
ffff888073394030 (&ea_inode->i_rwsem#9/1){+.+.}-{3:3}, at: chown_common+0x364/0x710 fs/open.c:727

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ea_inode->i_rwsem#9/1){+.+.}-{3:3}:
       down_write+0x90/0x150 kernel/locking/rwsem.c:1542
       inode_lock include/linux/fs.h:761 [inline]
       ext4_xattr_inode_write fs/ext4/xattr.c:1391 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1529 [inline]
       ext4_xattr_set_entry+0x2ec5/0x3800 fs/ext4/xattr.c:1653
       ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2206
       ext4_xattr_set_handle+0x964/0x1500 fs/ext4/xattr.c:2363
       ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2476
       __vfs_setxattr+0x115/0x180 fs/xattr.c:182
       __vfs_setxattr_noperm+0x125/0x5f0 fs/xattr.c:216
       __vfs_setxattr_locked+0x1cf/0x260 fs/xattr.c:277
       vfs_setxattr+0x13f/0x330 fs/xattr.c:303
       setxattr+0x146/0x160 fs/xattr.c:611
       path_setxattr+0x197/0x1c0 fs/xattr.c:630
       __do_sys_setxattr fs/xattr.c:646 [inline]
       __se_sys_setxattr fs/xattr.c:642 [inline]
       __x64_sys_setxattr+0xc0/0x160 fs/xattr.c:642
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

-> #0 (&ei->xattr_sem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2abe/0x5660 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5665 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
       down_read+0x98/0x440 kernel/locking/rwsem.c:1489
       ext4_xattr_get+0x14e/0xa10 fs/ext4/xattr.c:650
       __vfs_getxattr+0xd9/0x140 fs/xattr.c:401
       cap_inode_need_killpriv+0x3c/0x60 security/commoncap.c:301
       security_inode_need_killpriv+0x40/0x90 security/security.c:1420
       notify_change+0x6e7/0x1440 fs/attr.c:351
       chown_common+0x61b/0x710 fs/open.c:734
       do_fchownat+0x126/0x1e0 fs/open.c:765
       __do_sys_fchownat fs/open.c:780 [inline]
       __se_sys_fchownat fs/open.c:777 [inline]
       __x64_sys_fchownat+0xba/0x150 fs/open.c:777
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ea_inode->i_rwsem#9/1);
                               lock(&ei->xattr_sem);
                               lock(&ea_inode->i_rwsem#9/1);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

2 locks held by syz-executor.0/4081:
 #0: ffff88807a612460 (sb_writers#4){.+.+}-{0:0}, at: do_fchownat+0x101/0x1e0 fs/open.c:762
 #1: ffff888073394030 (&ea_inode->i_rwsem#9/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff888073394030 (&ea_inode->i_rwsem#9/1){+.+.}-{3:3}, at: chown_common+0x364/0x710 fs/open.c:727

stack backtrace:
CPU: 0 PID: 4081 Comm: syz-executor.0 Not tainted 5.19.0-rc4-next-20220628-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2abe/0x5660 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 down_read+0x98/0x440 kernel/locking/rwsem.c:1489
 ext4_xattr_get+0x14e/0xa10 fs/ext4/xattr.c:650
 __vfs_getxattr+0xd9/0x140 fs/xattr.c:401
 cap_inode_need_killpriv+0x3c/0x60 security/commoncap.c:301
 security_inode_need_killpriv+0x40/0x90 security/security.c:1420
 notify_change+0x6e7/0x1440 fs/attr.c:351
 chown_common+0x61b/0x710 fs/open.c:734
 do_fchownat+0x126/0x1e0 fs/open.c:765
 __do_sys_fchownat fs/open.c:780 [inline]
 __se_sys_fchownat fs/open.c:777 [inline]
 __x64_sys_fchownat+0xba/0x150 fs/open.c:777
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7febbbc89209
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007febbcdc0168 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007febbbd9bf60 RCX: 00007febbbc89209
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007febbbce3161 R08: 0000000000001000 R09: 0000000000000000
R10: 000000000000ee01 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd5bc171ff R14: 00007febbcdc0300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13ec5671080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=62120febbd1ee3c3c860
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162cf612080000

