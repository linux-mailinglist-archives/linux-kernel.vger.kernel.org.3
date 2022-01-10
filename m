Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA34B489BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiAJO7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiAJO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:59:01 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10413C06173F;
        Mon, 10 Jan 2022 06:59:01 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m4so13160789edb.10;
        Mon, 10 Jan 2022 06:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/v7/SBL7OndFJiOowJ8cyCY2ULEGJWIlLTFRcsV3eoY=;
        b=ojBH/IpEl26sk0FqVmOU8piF0nbkO2/qIbD+27fgV+JOX4V4M8Qd8ElpX+nBVjvx7W
         fwVdlGli3YOmFuUfJuElLj5sNrIP1vjcl3u8yNiqG6CyR206ADhgpZoDPHxrYI2RJz5+
         siRKZLUq8CGLwGE/Rmzr12XiQvqpE3sCB8SRQK/odGPjvaEm7BGG4atnIaCfBoUBXBee
         IyDnOtD2bj+W546ML//YlV7Eqm/28QcL5KFjIKAX1TdtlTn3Sj9qGp3Hch4QVq0JLmuo
         p1DiX4sWourhOZLuFt0cjUI8UfwnLrs2033IoSMGvF+DnGzDf4tYFxd2/mpBBUgqu3Pe
         USBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/v7/SBL7OndFJiOowJ8cyCY2ULEGJWIlLTFRcsV3eoY=;
        b=R49Hpf+b1xCU92z3JB9lkSal7FV/uajKDaJ8QnyD/EO5dVFXLLVXVS9h8RWSEaBtmI
         M+GhdGiPArsjdl3lTtCTanni6iMQKrYA7R+IIy9QbAmI1TAhmWxuxBMw9Ta2XbHxs1OM
         ZVUJOrQCxMODSb/YkDhgE84m+fglIJDt6JRKuNLZOXQG0c2L3YNv9FNVU2d34fu6wtZp
         twFbu3PM/ev8s62usEy1fI9XRetomHNhUTIZwECkXk/NxBH+P+dvu/CUENTCrhBVyBAU
         gmV+Ica5L189uehP1WiZMC/1ytjPORdNIUzILLBRHtuMA7kLdnmxAqKk84AvHimmQTu+
         fh+g==
X-Gm-Message-State: AOAM5302042F8PuIkFdCbNfAiJD+rf84CHZSVQO0x+XS2w3oZcnRzxEl
        L+D8KUjUrbdyEYV9+bnblxUJwTtG9Fsy2EXKkgI=
X-Google-Smtp-Source: ABdhPJxF9UAGt8Tq09N699eWVjizOf4v4o23jdSnv6YzvXvALNEA9D9gBwjqnDxEXL7+8Dlzx+ZSRIL/TpcGgL/N2QM=
X-Received: by 2002:a17:906:713:: with SMTP id y19mr81185ejb.723.1641826739634;
 Mon, 10 Jan 2022 06:58:59 -0800 (PST)
MIME-Version: 1.0
From:   cruise k <cruise4k@gmail.com>
Date:   Mon, 10 Jan 2022 22:58:48 +0800
Message-ID: <CAKcFiNC=MfYVW-Jt9A3=FPJpTwCD2PL_ULNCpsCVE5s8ZeBQgQ@mail.gmail.com>
Subject: KASAN: use-after-free Read in start_motor
To:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Syzkaller found the following issue:

HEAD commit: 75acfdb Linux 5.16-rc8
git tree: upstream
console output: https://pastebin.com/raw/yHnKW716
kernel config: https://pastebin.com/raw/XsnKfdRt

And hope the report log can help you.


==================================================================
BUG: KASAN: use-after-free in start_motor+0x31b/0x3f0
Read of size 4 at addr ffff88801961c800 by task kworker/u16:1/10

CPU: 0 PID: 10 Comm: kworker/u16:1 Not tainted 5.16.0-rc8+ #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: floppy fd_timer_workfn
Call Trace:
 <TASK>
 dump_stack_lvl+0xcd/0x134
 print_address_description.constprop.0.cold+0x93/0x347
 kasan_report.cold+0x83/0xdf
 start_motor+0x31b/0x3f0
 floppy_ready+0x7f/0x19b0
 process_one_work+0x9df/0x16a0
 worker_thread+0x90/0xe20
 kthread+0x405/0x4f0
 ret_from_fork+0x1f/0x30
 </TASK>

Allocated by task 17012:
 kasan_save_stack+0x1e/0x50
 __kasan_kmalloc+0xa9/0xd0
 kmem_cache_alloc_trace+0x198/0x390
 fd_locked_ioctl+0xa33/0x23d0
 fd_ioctl+0x35/0x50
 blkdev_ioctl+0x37a/0x800
 __x64_sys_ioctl+0x193/0x200
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 17012:
 kasan_save_stack+0x1e/0x50
 kasan_set_track+0x21/0x30
 kasan_set_free_info+0x20/0x30
 __kasan_slab_free+0x100/0x140
 kfree+0x107/0x4c0
 raw_cmd_free+0x72/0x140
 fd_locked_ioctl+0x19b4/0x23d0
 fd_ioctl+0x35/0x50
 blkdev_ioctl+0x37a/0x800
 __x64_sys_ioctl+0x193/0x200
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88801961c800
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 0 bytes inside of
 128-byte region [ffff88801961c800, ffff88801961c880)
The buggy address belongs to the page:
page:ffffea0000658700 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x1961c
head:ffffea0000658700 order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888010c428c0
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask
0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 16049, ts 140600618188, free_ts 140590103353
 prep_new_page+0x1a6/0x240
 get_page_from_freelist+0x1eec/0x3b50
 __alloc_pages+0x30c/0x6e0
 alloc_pages+0x115/0x240
 new_slab+0x35e/0x4b0
 ___slab_alloc+0xae6/0x1120
 __slab_alloc.isra.0+0x4d/0xa0
 __kmalloc+0x345/0x3d0
 tomoyo_supervisor+0xca7/0xe30
 tomoyo_path_permission+0x270/0x3a0
 tomoyo_path_perm+0x352/0x420
 tomoyo_path_symlink+0x94/0xe0
 security_path_symlink+0xdf/0x150
 do_symlinkat+0x107/0x2a0
 __x64_sys_symlink+0x75/0x90
 do_syscall_64+0x35/0xb0
page last free stack trace:
 free_pcp_prepare+0x474/0x9f0
 free_unref_page+0x19/0x5b0
 __unfreeze_partials+0x343/0x360
 qlist_free_all+0x5a/0xc0
 kasan_quarantine_reduce+0x13d/0x180
 __kasan_slab_alloc+0xa2/0xc0
 slab_post_alloc_hook+0x4d/0x4a0
 __kmalloc+0x190/0x3d0
 tomoyo_supervisor+0xca7/0xe30
 tomoyo_path_permission+0x270/0x3a0
 tomoyo_path_perm+0x2fc/0x420
 tomoyo_path_unlink+0x8e/0xd0
 security_path_unlink+0xd7/0x150
 do_unlinkat+0x369/0x660
 __x64_sys_unlink+0x3e/0x50
 do_syscall_64+0x35/0xb0

Memory state around the buggy address:
 ffff88801961c700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801961c780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801961c800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88801961c880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801961c900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
