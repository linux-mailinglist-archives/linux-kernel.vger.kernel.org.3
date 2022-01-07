Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5954876A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347176AbiAGLkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:40:20 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:35613 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbiAGLkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:40:19 -0500
Received: by mail-io1-f69.google.com with SMTP id 123-20020a6b1481000000b006044f43fba9so3741646iou.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 03:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n3ekmp2i6f1YQkOgKb9lSL0B0nMiwimgnPxXDuVWlw0=;
        b=Spk9m2rRmik35MKNDj+aRNhryiEQrGS5guKRPKru+09L2EVlXiQDp+vuqCLT0e5mrX
         YTZetyKrPrapXpvylvQhMGWDKbXCedBrpWmg/09DcpoNx9nJtRgpCgCtYPQFGsXCjVfE
         qvbcF/LxcBYk1TzsAgyaNTN3TwplVvmRifxBJF4zqAfxLChnXIUgIqmFfD1d0Jh9AHQW
         /Xwy0sXZXtf4zMPWykyG88r2C0Kcv/UYBv6G+UDZQYfqVWufLWk2SN0sgYRFERQGoHqd
         A0F9fNZJSK4+btBDEkzpkClIGkxfi/yzqiYO7Cruigjog0OY4gUOJ68aQzoaxEUM4thb
         vcjw==
X-Gm-Message-State: AOAM531ZwzhCQxuqsxwW19aBRj5DAStVSU6U2++lZA3DEHIZtyVzvit/
        U3hxE8ocHzTrGR9vAJ/AeGm7xdPaFQlA0QBBBhAJW76r92Uv
X-Google-Smtp-Source: ABdhPJzjo8VmonUYDMwgOszztVOtelIZ2a6fktXO7TXYRvOLvd7apH3eiZr3Y0po9XhMzG4J03/Zeksu1WyV7LkvndvmCJUXJx4c
MIME-Version: 1.0
X-Received: by 2002:a02:ceb9:: with SMTP id z25mr28194942jaq.228.1641555618695;
 Fri, 07 Jan 2022 03:40:18 -0800 (PST)
Date:   Fri, 07 Jan 2022 03:40:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000880fca05d4fc73b0@google.com>
Subject: [syzbot] KMSAN: uninit-value in fat_subdirs
From:   syzbot <syzbot+ac94ae5f68b84197f41c@syzkaller.appspotmail.com>
To:     glider@google.com, hirofumi@mail.parknet.co.jp,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    81c325bbf94e kmsan: hooks: do not check memory in kmsan_in..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11506cb3b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
dashboard link: https://syzkaller.appspot.com/bug?extid=ac94ae5f68b84197f41c
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ac94ae5f68b84197f41c@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 7
=====================================================
BUG: KMSAN: uninit-value in fat_get_short_entry fs/fat/dir.c:875 [inline]
BUG: KMSAN: uninit-value in fat_subdirs+0x24b/0x460 fs/fat/dir.c:939
 fat_get_short_entry fs/fat/dir.c:875 [inline]
 fat_subdirs+0x24b/0x460 fs/fat/dir.c:939
 fat_read_root+0x92f/0xac0 fs/fat/inode.c:1413
 fat_fill_super+0x6e5b/0x7ff0 fs/fat/inode.c:1860
 vfat_fill_super+0xa6/0xc0 fs/fat/namei_vfat.c:1051
 mount_bdev+0x626/0x920 fs/super.c:1370
 vfat_mount+0xc9/0xe0 fs/fat/namei_vfat.c:1058
 legacy_get_tree+0x163/0x2e0 fs/fs_context.c:610
 vfs_get_tree+0xd8/0x5d0 fs/super.c:1500
 do_new_mount+0x7b5/0x16f0 fs/namespace.c:2988
 path_mount+0x1021/0x28b0 fs/namespace.c:3318
 do_mount fs/namespace.c:3331 [inline]
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount+0x8a8/0x9d0 fs/namespace.c:3516
 __ia32_sys_mount+0x157/0x1b0 fs/namespace.c:3516
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 folio_alloc+0x7b/0x180 mm/mempolicy.c:2201
 filemap_alloc_folio mm/filemap.c:1036 [inline]
 __filemap_get_folio+0xee2/0x1b20 mm/filemap.c:1951
 pagecache_get_page+0xc6/0x3a0 mm/folio-compat.c:125
 find_or_create_page include/linux/pagemap.h:489 [inline]
 grow_dev_page+0x1b6/0xe00 fs/buffer.c:949
 grow_buffers fs/buffer.c:1014 [inline]
 __getblk_slow fs/buffer.c:1041 [inline]
 __getblk_gfp+0x410/0x620 fs/buffer.c:1334
 __bread_gfp+0xb3/0x810 fs/buffer.c:1379
 sb_bread include/linux/buffer_head.h:303 [inline]
 fat_fill_super+0x38d2/0x7ff0 fs/fat/inode.c:1685
 vfat_fill_super+0xa6/0xc0 fs/fat/namei_vfat.c:1051
 mount_bdev+0x626/0x920 fs/super.c:1370
 vfat_mount+0xc9/0xe0 fs/fat/namei_vfat.c:1058
 legacy_get_tree+0x163/0x2e0 fs/fs_context.c:610
 vfs_get_tree+0xd8/0x5d0 fs/super.c:1500
 do_new_mount+0x7b5/0x16f0 fs/namespace.c:2988
 path_mount+0x1021/0x28b0 fs/namespace.c:3318
 do_mount fs/namespace.c:3331 [inline]
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount+0x8a8/0x9d0 fs/namespace.c:3516
 __ia32_sys_mount+0x157/0x1b0 fs/namespace.c:3516
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

CPU: 1 PID: 5570 Comm: syz-executor.3 Tainted: G        W         5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
