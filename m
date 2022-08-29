Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BB75A57A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiH2Xdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiH2Xdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:33:33 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D604981B05
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:33:32 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id g5-20020a92cda5000000b002e954ecceb0so6965576ild.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=+R+0POhYwWHNdAeI2INPDZ+vmXYXil0g1qA/NRpeirA=;
        b=fc1sm2oaBt4uB7Hni6qthVwJ1ErxbwrDhvIEGGhBM8beOzJI4kZ7JOz5+HlLGnMp1l
         DVJJSn9NoAPNXfDN8pxcU2tXsX3T9a24LjvHzUH4F7eI8YJMtYBQUCH1+eB/shFwC6fs
         jKNw7jOpw0e4jcC66HMLDORlXVd7GU6INs9R0gKSJBtkQLZ4AHiWWKs9u3dm0lb6jD73
         jprSGgbX48RYT4w2mgN+/jGdqww7tYfD9xCAsfJtjVYpoa2ye3LN9Kk0mo4VY1cGLC9R
         EqBdOw2WuSsrGvgrpnszSN5yWr1/QW9TG+depKJE+MI7Px7OFDwPoNJ/RZnQOEVaO7Yl
         fcrw==
X-Gm-Message-State: ACgBeo1cllUjnEhjJoSTb7nyz37s8mCCq/Mb3PQI5KvfzT8E9Q3UtqdN
        a4Ze490S9Ywr53fTNW5GSKIDjY/qv4mof430L5XPjHzHhrGC
X-Google-Smtp-Source: AA6agR76/ewUy/7FdUKWGxvetl2NLw9y3QxJ5/AYU0oDq6bhMKrKOp6UUn5+ZCUuiTKrblwx5vbCaze5AQefABcZycNQYHVckGbK
MIME-Version: 1.0
X-Received: by 2002:a92:c569:0:b0:2eb:5c94:9a1c with SMTP id
 b9-20020a92c569000000b002eb5c949a1cmr186312ilj.135.1661816012188; Mon, 29 Aug
 2022 16:33:32 -0700 (PDT)
Date:   Mon, 29 Aug 2022 16:33:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016b90805e769b1d2@google.com>
Subject: [syzbot] kernel BUG in f2fs_init_xattr_caches
From:   syzbot <syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13a4e48b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
dashboard link: https://syzkaller.appspot.com/bug?extid=81684812ea68216e08c5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114f2fa3080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cd7fa3080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 20
 loop0: unable to read partition table
loop0: partition table beyond EOD, truncated
F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
------------[ cut here ]------------
kernel BUG at mm/slub.c:5893!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3038 Comm: syz-executor368 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : create_unique_id mm/slub.c:5973 [inline]
pc : sysfs_slab_add+0x258/0x260 mm/slub.c:5950
lr : kmalloc include/linux/slab.h:600 [inline]
lr : create_unique_id mm/slub.c:5890 [inline]
lr : sysfs_slab_add+0xa0/0x260 mm/slub.c:5950
sp : ffff80001288b990
x29: ffff80001288b990 x28: ffff0000c9717380 x27: ffff0000c376cd00
x26: 0000000000020000 x25: ffff80000eee7000 x24: ffff80000eef6000
x23: 0000000000000000 x22: ffff0000c1be5b00 x21: 0000000000000008
x20: ffff0000c376cd00 x19: ffff0000c376cd00 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80000dbb8658 x15: ffff0000c6ae4f80
x14: 0000000000000010 x13: 0000000000000000 x12: ffff0000c6ae4f80
x11: ff808000095ee038 x10: 0000000000000000 x9 : 0cbee7d022858900
x8 : 0cbee7d022858900 x7 : ffff8000084b7280 x6 : 0000000000000000
x5 : 0000000000000cc0 x4 : 0000000000000080 x3 : 0000000000000040
x2 : ffff0000c0001200 x1 : ffff80000cb90cf9 x0 : 0000000000000000
Call trace:
 sysfs_slab_add+0x258/0x260 mm/slub.c:5973
 __kmem_cache_create+0x60/0x118 mm/slub.c:4899
 create_cache mm/slab_common.c:229 [inline]
 kmem_cache_create_usercopy+0x19c/0x31c mm/slab_common.c:335
 kmem_cache_create+0x1c/0x28 mm/slab_common.c:390
 f2fs_kmem_cache_create fs/f2fs/f2fs.h:2766 [inline]
 f2fs_init_xattr_caches+0x78/0xb4 fs/f2fs/xattr.c:808
 f2fs_fill_super+0x1050/0x1e0c fs/f2fs/super.c:4149
 mount_bdev+0x1b8/0x210 fs/super.c:1400
 f2fs_mount+0x44/0x58 fs/f2fs/super.c:4512
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: a9415ff8 a8c47bfd d50323bf d65f03c0 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
