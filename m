Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F925372F8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 01:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiE2Xjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 19:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiE2Xjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 19:39:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E655627158
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 16:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DA1B0CE0E16
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED80C385A9;
        Sun, 29 May 2022 23:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653867576;
        bh=ChvZGRzjNy/5pL6NQ06zFXWcMzXaPCwBkFBGIC5cEUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nsLKOymprVfyiTw1eOGvvp0D7F+6ZaNwm1BQmiST2OzDxwDiJmi/Ikh4pebsQ8srw
         1U0qVTOVVSkjOBMwA5+b3N4dWtKZCulaNb5CfQoRLdSRpDlHtOSSctpsGj3bM7MvIV
         gxeNVRxsRKJ+SNbqF6152VekWME5SnzFH3551oN0=
Date:   Sun, 29 May 2022 16:39:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+9e27a75a8c24f3fe75c1@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] memory leak in xas_nomem
Message-Id: <20220529163935.5118b4f91e2c5c3378ab326f@linux-foundation.org>
In-Reply-To: <00000000000036af2005e009e7e6@google.com>
References: <00000000000036af2005e009e7e6@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 20:20:21 -0700 syzbot <syzbot+9e27a75a8c24f3fe75c1@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1e57930e9f40 Merge tag 'rcu.2022.05.19a' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17afc423f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5757003cb23a31a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=9e27a75a8c24f3fe75c1
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bc056ef00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116b7d9df00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9e27a75a8c24f3fe75c1@syzkaller.appspotmail.com
> 
> BUG: memory leak

(hopefully cc's willy)

> unreferenced object 0xffff88810cb35d80 (size 576):
>   comm "syz-executor883", pid 3623, jiffies 4294954631 (age 23.510s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     18 48 36 04 81 88 ff ff 98 5d b3 0c 81 88 ff ff  .H6......]......
>   backtrace:
>     [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
>     [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
>     [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
>     [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
>     [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
>     [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
>     [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
>     [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
>     [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
>     [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
>     [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
>     [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
>     [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
>     [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
>     [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
>     [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
>     [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
>     [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> BUG: memory leak
> unreferenced object 0xffff88810cb39d80 (size 576):
>   comm "syz-executor883", pid 3622, jiffies 4294954659 (age 23.230s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     98 f8 cd 0d 81 88 ff ff 98 9d b3 0c 81 88 ff ff  ................
>   backtrace:
>     [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
>     [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
>     [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
>     [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
>     [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
>     [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
>     [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
>     [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
>     [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
>     [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
>     [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
>     [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
>     [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
>     [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
>     [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
>     [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
>     [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
>     [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> BUG: memory leak
> unreferenced object 0xffff88810cb35d80 (size 576):
>   comm "syz-executor883", pid 3623, jiffies 4294954631 (age 29.410s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     18 48 36 04 81 88 ff ff 98 5d b3 0c 81 88 ff ff  .H6......]......
>   backtrace:
>     [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
>     [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
>     [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
>     [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
>     [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
>     [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
>     [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
>     [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
>     [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
>     [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
>     [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
>     [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
>     [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
>     [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
>     [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
>     [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
>     [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
>     [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> BUG: memory leak
> unreferenced object 0xffff88810cb39d80 (size 576):
>   comm "syz-executor883", pid 3622, jiffies 4294954659 (age 29.130s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     98 f8 cd 0d 81 88 ff ff 98 9d b3 0c 81 88 ff ff  ................
>   backtrace:
>     [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
>     [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
>     [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
>     [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
>     [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
>     [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
>     [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
>     [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
>     [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
>     [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
>     [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
>     [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
>     [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
>     [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
>     [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
>     [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
>     [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
>     [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> BUG: memory leak
> unreferenced object 0xffff88810cb35d80 (size 576):
>   comm "syz-executor883", pid 3623, jiffies 4294954631 (age 29.450s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     18 48 36 04 81 88 ff ff 98 5d b3 0c 81 88 ff ff  .H6......]......
>   backtrace:
>     [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
>     [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
>     [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
>     [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
>     [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
>     [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
>     [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
>     [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
>     [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
>     [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
>     [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
>     [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
>     [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
>     [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
>     [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
>     [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
>     [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
>     [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> BUG: memory leak
> unreferenced object 0xffff88810cb39d80 (size 576):
>   comm "syz-executor883", pid 3622, jiffies 4294954659 (age 29.170s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     98 f8 cd 0d 81 88 ff ff 98 9d b3 0c 81 88 ff ff  ................
>   backtrace:
>     [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
>     [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
>     [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
>     [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
>     [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
>     [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
>     [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
>     [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
>     [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
>     [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
>     [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
>     [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
>     [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
>     [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
>     [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
>     [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
>     [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
>     [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> BUG: memory leak
> unreferenced object 0xffff88810cb35d80 (size 576):
>   comm "syz-executor883", pid 3623, jiffies 4294954631 (age 29.490s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     18 48 36 04 81 88 ff ff 98 5d b3 0c 81 88 ff ff  .H6......]......
>   backtrace:
>     [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
>     [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
>     [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
>     [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
>     [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
>     [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
>     [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
>     [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
>     [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
>     [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
>     [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
>     [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
>     [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
>     [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
>     [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
>     [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
>     [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
>     [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> BUG: memory leak
> unreferenced object 0xffff88810cb39d80 (size 576):
>   comm "syz-executor883", pid 3622, jiffies 4294954659 (age 29.210s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     98 f8 cd 0d 81 88 ff ff 98 9d b3 0c 81 88 ff ff  ................
>   backtrace:
>     [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
>     [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
>     [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626
>     [<ffffffff8148a224>] split_huge_page include/linux/huge_mm.h:191 [inline]
>     [<ffffffff8148a224>] truncate_inode_partial_folio+0x3e4/0x5f0 mm/truncate.c:243
>     [<ffffffff814a78a0>] shmem_undo_range+0x3d0/0xbe0 mm/shmem.c:966
>     [<ffffffff814a8e51>] shmem_truncate_range mm/shmem.c:1044 [inline]
>     [<ffffffff814a8e51>] shmem_fallocate+0x1e1/0x910 mm/shmem.c:2671
>     [<ffffffff815b5c6c>] vfs_fallocate+0x31c/0x670 fs/open.c:308
>     [<ffffffff815237e3>] madvise_remove mm/madvise.c:965 [inline]
>     [<ffffffff815237e3>] madvise_vma_behavior+0x7d3/0x1000 mm/madvise.c:989
>     [<ffffffff8151f2fc>] madvise_walk_vmas+0x11c/0x1d0 mm/madvise.c:1221
>     [<ffffffff8152437b>] do_madvise mm/madvise.c:1399 [inline]
>     [<ffffffff8152437b>] do_madvise+0x23b/0x320 mm/madvise.c:1357
>     [<ffffffff8152478a>] __do_sys_madvise mm/madvise.c:1412 [inline]
>     [<ffffffff8152478a>] __se_sys_madvise mm/madvise.c:1410 [inline]
>     [<ffffffff8152478a>] __x64_sys_madvise+0x2a/0x30 mm/madvise.c:1410
>     [<ffffffff84565f15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84565f15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> executing program
> executing program
> executing program
> executing program
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
