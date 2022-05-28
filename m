Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C60536A6F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 05:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353363AbiE1DU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 23:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiE1DUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 23:20:24 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED165D5CC
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 20:20:22 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id z19-20020a05660200d300b0066583f8cf2eso3759701ioe.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 20:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zSbiaklTWP4e9f9tYKPsl7ZSpO4EGSqD2E3JZK3Al8Y=;
        b=uA0FeoOci4G0BfXKEnAdd1Q+pqtD4ky807xoih1hAkN45xO6eMQ5T1PTTp665YMmpn
         EgjItNtiHrT/tMO1Ps9c6Er3jOnL9m/ehs8Z46Xj/w3dsxcvmorLyIg0uUohaAkmQCYz
         jXNOKpGaVtqrGkEJFAJdLdLuZWvl7wdI2cEKGIDtZx43YKyunuCskxcTG2/MEzyNrTKS
         G4BsWP6uiaZxVd2873rL8yvkEkP5IkJoerpsV2s0SG/l/jQDRWrePMMaOBQiYViAf89K
         yxDk+F0ENJkwjbOe/E8ZJcIZI3+uBQqNL8dbSaQNvWNgRCnV4QOBHZkWosvFxCn/YUTu
         K1eA==
X-Gm-Message-State: AOAM530nOsHzV4lr+Sf0f+tGSoYmrnnDJKWSQgOQyPZLb+Ww1Wcmy1M5
        74SQDR7ESG3Y+YMENJ65kUubDJCI6dAunYhJudHrf1Wb1XWT
X-Google-Smtp-Source: ABdhPJyjsjToOBbPFRuXB2o9n2D6plUd72qrVbj3/5tO1fZt2ziR/PL0btjmn+ooxfiqgSuhYeqRiudLtbzScN419pwjYoyeSIHf
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a5:b0:331:d3:c282 with SMTP id
 m37-20020a05663840a500b0033100d3c282mr1889620jam.107.1653708021997; Fri, 27
 May 2022 20:20:21 -0700 (PDT)
Date:   Fri, 27 May 2022 20:20:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036af2005e009e7e6@google.com>
Subject: [syzbot] memory leak in xas_nomem
From:   syzbot <syzbot+9e27a75a8c24f3fe75c1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    1e57930e9f40 Merge tag 'rcu.2022.05.19a' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17afc423f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5757003cb23a31a7
dashboard link: https://syzkaller.appspot.com/bug?extid=9e27a75a8c24f3fe75c1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bc056ef00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116b7d9df00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e27a75a8c24f3fe75c1@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810cb35d80 (size 576):
  comm "syz-executor883", pid 3623, jiffies 4294954631 (age 23.510s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    18 48 36 04 81 88 ff ff 98 5d b3 0c 81 88 ff ff  .H6......]......
  backtrace:
    [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
    [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
    [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
    [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
    [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
    [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
    [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
    [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
    [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
    [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
    [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
    [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
    [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
    [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
    [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
    [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
    [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
    [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810cb39d80 (size 576):
  comm "syz-executor883", pid 3622, jiffies 4294954659 (age 23.230s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    98 f8 cd 0d 81 88 ff ff 98 9d b3 0c 81 88 ff ff  ................
  backtrace:
    [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
    [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
    [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
    [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
    [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
    [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
    [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
    [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
    [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
    [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
    [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
    [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
    [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
    [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
    [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
    [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
    [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
    [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810cb35d80 (size 576):
  comm "syz-executor883", pid 3623, jiffies 4294954631 (age 29.410s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    18 48 36 04 81 88 ff ff 98 5d b3 0c 81 88 ff ff  .H6......]......
  backtrace:
    [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
    [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
    [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
    [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
    [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
    [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
    [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
    [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
    [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
    [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
    [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
    [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
    [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
    [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
    [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
    [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
    [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
    [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810cb39d80 (size 576):
  comm "syz-executor883", pid 3622, jiffies 4294954659 (age 29.130s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    98 f8 cd 0d 81 88 ff ff 98 9d b3 0c 81 88 ff ff  ................
  backtrace:
    [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
    [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
    [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
    [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
    [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
    [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
    [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
    [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
    [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
    [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
    [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
    [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
    [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
    [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
    [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
    [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
    [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
    [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810cb35d80 (size 576):
  comm "syz-executor883", pid 3623, jiffies 4294954631 (age 29.450s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    18 48 36 04 81 88 ff ff 98 5d b3 0c 81 88 ff ff  .H6......]......
  backtrace:
    [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
    [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
    [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
    [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
    [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
    [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
    [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
    [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
    [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
    [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
    [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
    [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
    [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
    [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
    [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
    [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
    [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
    [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810cb39d80 (size 576):
  comm "syz-executor883", pid 3622, jiffies 4294954659 (age 29.170s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    98 f8 cd 0d 81 88 ff ff 98 9d b3 0c 81 88 ff ff  ................
  backtrace:
    [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
    [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
    [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
    [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
    [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
    [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
    [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
    [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
    [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
    [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
    [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
    [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
    [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
    [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
    [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
    [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
    [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
    [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810cb35d80 (size 576):
  comm "syz-executor883", pid 3623, jiffies 4294954631 (age 29.490s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    18 48 36 04 81 88 ff ff 98 5d b3 0c 81 88 ff ff  .H6......]......
  backtrace:
    [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
    [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
    [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
    [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
    [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
    [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
    [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
    [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
    [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
    [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
    [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
    [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
    [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
    [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
    [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
    [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
    [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
    [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810cb39d80 (size 576):
  comm "syz-executor883", pid 3622, jiffies 4294954659 (age 29.210s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    98 f8 cd 0d 81 88 ff ff 98 9d b3 0c 81 88 ff ff  ................
  backtrace:
    [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
    [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
    [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
    [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
    [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
    [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
    [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
    [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
    [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
    [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
    [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
    [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
    [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
    [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
    [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
    [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
    [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
    [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

executing program
executing program
executing program
executing program


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
