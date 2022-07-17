Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F35778D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 01:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiGQXdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 19:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiGQXdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 19:33:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EBE12630;
        Sun, 17 Jul 2022 16:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jynpIxdrhIWFUZHBsK9AW+1pEI5ibhBI26B63sydOPU=; b=bUgVKb6gAbAZhLzC/GCzwuFhSd
        WN7jeG34yUdvFBcZcohl5dfKz9yUE3LgA8JDewqJGRQTqF4Aze0tMwMfbQV/5UB/bbSnJRsKxM77b
        Gf1iRYFrzgrNWkPX1RAjpscLegkMzLwRuqx21S9GgR0J5m+fqJPCtFpn9jj/hqlLtZGsPPK84h9T9
        AwQO5OuU524LfrTCL/xCf+YzOyc4XmxCklL66lnsxpijNnpOU20+lp3g4xJOFeP7Mp4Gd2Sa8GohA
        e0mpf5TfEdT5ZfNGd6QfBpsMzKk68flDsaqr92pWSFgzAYP/JnUoklYLJlk8KQAwvB1nHMa3b+1Gk
        67jTBQQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDDlR-00CD3H-Ft; Sun, 17 Jul 2022 23:33:29 +0000
Date:   Mon, 18 Jul 2022 00:33:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     jlayton@kernel.org, neilb@suse.de,
        damien.lemoal@opensource.wdc.com, jack@suse.cz,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: KASAN: vmalloc-out-of-bounds Read in cleanup_bitmap_list
Message-ID: <YtScSS/uqhL0+5S3@casper.infradead.org>
References: <CAEK-7J+fkLceCTCqGoz_tNcN85iDVsMjeecfBZ-Eq9ZE5qVj3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEK-7J+fkLceCTCqGoz_tNcN85iDVsMjeecfBZ-Eq9ZE5qVj3A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 03:24:33PM -0700, Dipanjan Das wrote:
> Hi,
> 
> We would like to report the following bug which has been found by our
> modified version of syzkaller.

Modified how?  Something you need to understand is that we are
_drowning_ in syzbot bug reports.  We are not short on bugs to fix, we
are short on people to fix them.  Having a new source of bug reports
is just not helpful.

If you're generating these bug reports by fuzzing a filesystem image,
then I can see how it happens.  If it's a normal filesystem image,
then the code looks fine.

The obvious integer overflow is:

                                   unsigned int bmap_nr)
...
        int mem = bmap_nr * sizeof(struct reiserfs_bitmap_node *);

but I don't even know if that's where to look.

> ======================================================
> description: KASAN: vmalloc-out-of-bounds Read in cleanup_bitmap_list
> affected file: fs/reiserfs/journal.c
> kernel version: 5.19-rc6
> kernel commit: 32346491ddf24599decca06190ebca03ff9de7f8
> git tree: upstream
> kernel config: attached
> crash reproducer: none
> ======================================================
> Crash log:
> 
> BUG: KASAN: vmalloc-out-of-bounds in
> cleanup_bitmap_list.isra.0.part.0+0x4a0/0x5e0
> fs/reiserfs/journal.c:231
> Read of size 8 at addr ffffc900136dd008 by task syz-executor.2/13172
> 
> CPU: 0 PID: 13172 Comm: syz-executor.2 Tainted: G           OE
> 5.19.0-rc6-g2eae0556bb9d #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:313 [inline]
>  print_report.cold+0x176/0x659 mm/kasan/report.c:429
>  kasan_report+0x8a/0x1b0 mm/kasan/report.c:491
>  cleanup_bitmap_list.isra.0.part.0+0x4a0/0x5e0 fs/reiserfs/journal.c:231
>  cleanup_bitmap_list fs/reiserfs/journal.c:227 [inline]
>  free_list_bitmaps+0x68/0x100 fs/reiserfs/journal.c:249
>  free_journal_ram+0xfc/0x500 fs/reiserfs/journal.c:1887
>  do_journal_release fs/reiserfs/journal.c:1960 [inline]
>  journal_release_error+0x72/0x90 fs/reiserfs/journal.c:1978
>  reiserfs_fill_super+0x114d/0x2f10 fs/reiserfs/super.c:2225
>  mount_bdev+0x34d/0x410 fs/super.c:1367
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
>  do_new_mount fs/namespace.c:3040 [inline]
>  path_mount+0x1228/0x1cb0 fs/namespace.c:3370
>  do_mount+0xf3/0x110 fs/namespace.c:3383
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __x64_sys_mount+0x18f/0x230 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f121408fe8e
> Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f121266a9f8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f121408fe8e
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f121266aa50
> RBP: 00007f121266aa90 R08: 00007f121266aa90 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
> R13: 0000000020000100 R14: 00007f121266aa50 R15: 0000000020000040
>  </TASK>
> 
> The buggy address belongs to the virtual mapping at
>  [ffffc900136dd000, ffffc900136df000) created by:
>  reiserfs_allocate_list_bitmaps+0x54/0x100 fs/reiserfs/journal.c:290
> 
> The buggy address belongs to the physical page:
> page:ffffea00054c2700 refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x15309c
> flags: 0x17ff00000000000(node=0|zone=2|lastcpupid=0x7ff)
> raw: 017ff00000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask
> 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 13172,
> tgid 13167 (syz-executor.2), ts 141798727963, free_ts 133661424124
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook mm/page_alloc.c:2449 [inline]
>  prep_new_page+0x297/0x330 mm/page_alloc.c:2456
>  get_page_from_freelist+0x2142/0x3c80 mm/page_alloc.c:4198
>  __alloc_pages+0x321/0x710 mm/page_alloc.c:5426
>  __alloc_pages_bulk+0x974/0x1590 mm/page_alloc.c:5374
>  alloc_pages_bulk_array_mempolicy+0x12d/0x430 mm/mempolicy.c:2367
>  vm_area_alloc_pages mm/vmalloc.c:2899 [inline]
>  __vmalloc_area_node mm/vmalloc.c:2995 [inline]
>  __vmalloc_node_range+0x52f/0x1360 mm/vmalloc.c:3165
>  __vmalloc_node mm/vmalloc.c:3230 [inline]
>  vzalloc+0x67/0x80 mm/vmalloc.c:3303
>  reiserfs_allocate_list_bitmaps+0x54/0x100 fs/reiserfs/journal.c:290
>  journal_init+0x3ca/0x64d0 fs/reiserfs/journal.c:2732
>  reiserfs_fill_super+0xbbb/0x2f10 fs/reiserfs/super.c:2024
>  mount_bdev+0x34d/0x410 fs/super.c:1367
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
>  do_new_mount fs/namespace.c:3040 [inline]
>  path_mount+0x1228/0x1cb0 fs/namespace.c:3370
>  do_mount+0xf3/0x110 fs/namespace.c:3383
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __x64_sys_mount+0x18f/0x230 fs/namespace.c:3568
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1371 [inline]
>  free_pcp_prepare+0x51f/0xd00 mm/page_alloc.c:1421
>  free_unref_page_prepare mm/page_alloc.c:3343 [inline]
>  free_unref_page+0x19/0x5b0 mm/page_alloc.c:3438
>  kasan_depopulate_vmalloc_pte+0x5c/0x70 mm/kasan/shadow.c:359
>  apply_to_pte_range mm/memory.c:2625 [inline]
>  apply_to_pmd_range mm/memory.c:2669 [inline]
>  apply_to_pud_range mm/memory.c:2705 [inline]
>  apply_to_p4d_range mm/memory.c:2741 [inline]
>  __apply_to_page_range+0x66e/0xf50 mm/memory.c:2775
>  kasan_release_vmalloc+0xa2/0xb0 mm/kasan/shadow.c:469
>  __purge_vmap_area_lazy+0x8fe/0x1c90 mm/vmalloc.c:1722
>  drain_vmap_area_work+0x52/0xe0 mm/vmalloc.c:1751
>  process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
>  worker_thread+0x623/0x1070 kernel/workqueue.c:2436
>  kthread+0x2e9/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> 
> Memory state around the buggy address:
>  ffffc900136dcf00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>  ffffc900136dcf80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> >ffffc900136dd000: 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>                       ^
>  ffffc900136dd080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>  ffffc900136dd100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> ==================================================================
> 
> -- 
> Thanks & Regards,
> 
> Dipanjan


