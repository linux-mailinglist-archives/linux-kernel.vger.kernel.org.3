Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AD9473074
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbhLMP23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:28:29 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:39889 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhLMP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:28:27 -0500
Received: by mail-il1-f198.google.com with SMTP id d3-20020a056e021c4300b002a23bcd5ee7so15056496ilg.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aysPfNqjxpRXiA7lBlJLG8Lfatc36uOx/7qWhJ61vc0=;
        b=h8LQXV6Ncx76BRZa/hdbhTYvteohGTCosr7+EZlcT+GG44tdkzFs+WxG8p5XYvAjTa
         ngnQpQf8NmoETMduC473IMCfISZJHqhtcCaM0aFrxSqqU7Uy24twavWEAzJzo82F7ytN
         yNJw2uZNfLNcHue90Ne9oms6Xzpo9mGCY/iShq6exB6P3u7eyqS8szDfcMiAdn049ie3
         vhE3mGfj38dV7WnIud8FWGo6aYPMCtTqqsCkX9jIWql+Sp4TU4LNNyM1zNhZ6u+g4POv
         MYCSrcRh9ARp5bPzs+VhesetPxjniL+ULq5M6O5qUT91APJ4ZVmjaRK/25s6KhkJX0wx
         QmHw==
X-Gm-Message-State: AOAM5318bBBofFEKwmybC4HNho9a4oZmXOlXIoyfwDVXHjxGCAXEbf/Q
        3pPd+laA/+mQ0qzntJGa/PO7HOOsPiES09TzxMqokMz6krHr
X-Google-Smtp-Source: ABdhPJyyJJHgD7cWOTWpnl40UVtKrJ2E/+AkP55QQPE6obPaAC4zLCzSQrGwqQhCsQvEeVRyQ9fKxL03U22X2U21IC14ls3ck3QL
MIME-Version: 1.0
X-Received: by 2002:a05:6638:32aa:: with SMTP id f42mr33140073jav.115.1639409306499;
 Mon, 13 Dec 2021 07:28:26 -0800 (PST)
Date:   Mon, 13 Dec 2021 07:28:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005affb705d308b986@google.com>
Subject: [syzbot] KMSAN: uninit-value in udf_evict_inode (2)
From:   syzbot <syzbot+9ca499bb57a2b9e4c652@syzkaller.appspotmail.com>
To:     glider@google.com, jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8b936c96768e kmsan: core: remove the accidentally committe..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12c9f1beb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e00a8959fdd3f3e8
dashboard link: https://syzkaller.appspot.com/bug?extid=9ca499bb57a2b9e4c652
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ca499bb57a2b9e4c652@syzkaller.appspotmail.com

UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2020/09/19 18:44 (1000)
=====================================================
BUG: KMSAN: uninit-value in udf_evict_inode+0x2b6/0x830 fs/udf/inode.c:148
 udf_evict_inode+0x2b6/0x830 fs/udf/inode.c:148
 evict+0x4f7/0xdc0 fs/inode.c:590
 iput_final fs/inode.c:1670 [inline]
 iput+0xc5d/0x1110 fs/inode.c:1696
 udf_new_inode+0x5d2/0x16e0 fs/udf/ialloc.c:89
 udf_tmpfile+0x7e/0x2d0 fs/udf/namei.c:631
 vfs_tmpfile+0x2d9/0x5b0 fs/namei.c:3474
 do_tmpfile+0x29f/0x6c0 fs/namei.c:3509
 path_openat+0x4116/0x5dd0 fs/namei.c:3550
 do_filp_open+0x306/0x760 fs/namei.c:3586
 do_sys_openat2+0x263/0x8f0 fs/open.c:1212
 do_sys_open fs/open.c:1228 [inline]
 __do_compat_sys_openat fs/open.c:1288 [inline]
 __se_compat_sys_openat fs/open.c:1286 [inline]
 __ia32_compat_sys_openat+0x353/0x3c0 fs/open.c:1286
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was stored to memory at:
 udf_new_inode+0xac1/0x16e0 fs/udf/ialloc.c:67
 udf_tmpfile+0x7e/0x2d0 fs/udf/namei.c:631
 vfs_tmpfile+0x2d9/0x5b0 fs/namei.c:3474
 do_tmpfile+0x29f/0x6c0 fs/namei.c:3509
 path_openat+0x4116/0x5dd0 fs/namei.c:3550
 do_filp_open+0x306/0x760 fs/namei.c:3586
 do_sys_openat2+0x263/0x8f0 fs/open.c:1212
 do_sys_open fs/open.c:1228 [inline]
 __do_compat_sys_openat fs/open.c:1288 [inline]
 __se_compat_sys_openat fs/open.c:1286 [inline]
 __ia32_compat_sys_openat+0x353/0x3c0 fs/open.c:1286
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was stored to memory at:
 udf_alloc_inode+0x28a/0x2c0 fs/udf/super.c:149
 alloc_inode fs/inode.c:235 [inline]
 new_inode_pseudo+0xa6/0x5a0 fs/inode.c:944
 new_inode+0x5a/0x3c0 fs/inode.c:973
 udf_new_inode+0x139/0x16e0 fs/udf/ialloc.c:60
 udf_tmpfile+0x7e/0x2d0 fs/udf/namei.c:631
 vfs_tmpfile+0x2d9/0x5b0 fs/namei.c:3474
 do_tmpfile+0x29f/0x6c0 fs/namei.c:3509
 path_openat+0x4116/0x5dd0 fs/namei.c:3550
 do_filp_open+0x306/0x760 fs/namei.c:3586
 do_sys_openat2+0x263/0x8f0 fs/open.c:1212
 do_sys_open fs/open.c:1228 [inline]
 __do_compat_sys_openat fs/open.c:1288 [inline]
 __se_compat_sys_openat fs/open.c:1286 [inline]
 __ia32_compat_sys_openat+0x353/0x3c0 fs/open.c:1286
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0xbc7/0x10a0 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 alloc_slab_page mm/slub.c:1810 [inline]
 allocate_slab+0x287/0x1c20 mm/slub.c:1947
 new_slab mm/slub.c:2010 [inline]
 ___slab_alloc+0xbdf/0x1e90 mm/slub.c:3039
 __slab_alloc mm/slub.c:3126 [inline]
 slab_alloc_node mm/slub.c:3217 [inline]
 slab_alloc mm/slub.c:3259 [inline]
 kmem_cache_alloc+0xbb3/0x11c0 mm/slub.c:3264
 udf_alloc_inode+0x60/0x2c0 fs/udf/super.c:139
 alloc_inode fs/inode.c:235 [inline]
 new_inode_pseudo+0xa6/0x5a0 fs/inode.c:944
 new_inode+0x5a/0x3c0 fs/inode.c:973
 udf_new_inode+0x139/0x16e0 fs/udf/ialloc.c:60
 udf_tmpfile+0x7e/0x2d0 fs/udf/namei.c:631
 vfs_tmpfile+0x2d9/0x5b0 fs/namei.c:3474
 do_tmpfile+0x29f/0x6c0 fs/namei.c:3509
 path_openat+0x4116/0x5dd0 fs/namei.c:3550
 do_filp_open+0x306/0x760 fs/namei.c:3586
 do_sys_openat2+0x263/0x8f0 fs/open.c:1212
 do_sys_open fs/open.c:1228 [inline]
 __do_compat_sys_openat fs/open.c:1288 [inline]
 __se_compat_sys_openat fs/open.c:1286 [inline]
 __ia32_compat_sys_openat+0x353/0x3c0 fs/open.c:1286
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

CPU: 1 PID: 9774 Comm: syz-executor.4 Not tainted 5.16.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
