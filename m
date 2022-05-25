Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4915341CF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245517AbiEYQ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbiEYQ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:58:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3649CC98
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99BCE6170D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 16:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C6AC385B8;
        Wed, 25 May 2022 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653497924;
        bh=eHONafaui2lKovtDvnHPOGEGYY/yJ94hAQtVwJm7CTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yCg+YMztY65Sba28/Q7aKXtgqrTHiEJtfNs0jKEEJP3c8MHwS3ZKG2nZzjE237yiz
         jEL58YOc3HIW1TliCgby0Pmh8QfLwMKD1sabVfgJVAIN3p9wkMTuLA+CAALq8A77PE
         C2VMnow7jfVa3l9lxgJuUfFZiLK1l4/Lkrfh6HXk=
Date:   Wed, 25 May 2022 09:58:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in do_sync_mmap_readahead
Message-Id: <20220525095842.f97b64de9cbcc0e15d1257a6@linux-foundation.org>
In-Reply-To: <0000000000008cfbca05dfd6db81@google.com>
References: <0000000000008cfbca05dfd6db81@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 07:26:22 -0700 syzbot <syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3b5e1590a267 Merge tag 'gpio-fixes-for-v5.18' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15ae2bfdf00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d84df8e1a4c4d5a4
> dashboard link: https://syzkaller.appspot.com/bug?extid=5b96d55e5b54924c77ad
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in do_sync_mmap_readahead+0x465/0x9f0 mm/filemap.c:3006
> Read of size 8 at addr ffff88801fedb050 by task syz-executor.5/1755

A race?

#ifdef CONFIG_TRANSPARENT_HUGEPAGE
	/* Use the readahead code, even if readahead is disabled */
	if (vmf->vma->vm_flags & VM_HUGEPAGE) {
		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
		ra->size = HPAGE_PMD_NR;
		/*
		 * Fetch two PMD folios, so we get the chance to actually
		 * readahead, unless we've been told not to.
		 */
-->		if (!(vmf->vma->vm_flags & VM_RAND_READ))
			ra->size *= 2;
		ra->async_size = HPAGE_PMD_NR;
		page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
		return fpin;
	}
#endif

Reading from vmf->vma->vm_flags was OK, then it suddenly wasn't.

> 
> CPU: 0 PID: 1755 Comm: syz-executor.5 Not tainted 5.18.0-rc7-syzkaller-00136-g3b5e1590a267 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
>  print_address_description+0x65/0x4b0 mm/kasan/report.c:313
>  print_report+0xf4/0x210 mm/kasan/report.c:429
>  kasan_report+0xfb/0x130 mm/kasan/report.c:491
>  do_sync_mmap_readahead+0x465/0x9f0 mm/filemap.c:3006
>  filemap_fault+0x349/0xf20 mm/filemap.c:3138
>  __do_fault+0x139/0x4f0 mm/memory.c:3915
>  do_read_fault mm/memory.c:4240 [inline]
>  do_fault mm/memory.c:4369 [inline]
>  handle_pte_fault mm/memory.c:4627 [inline]
>  __handle_mm_fault mm/memory.c:4763 [inline]
>  handle_mm_fault+0x2bbb/0x3940 mm/memory.c:4861
>  faultin_page mm/gup.c:878 [inline]
>  __get_user_pages+0x4fd/0x1150 mm/gup.c:1099
>  populate_vma_page_range+0x216/0x2b0 mm/gup.c:1442
>  __mm_populate+0x2ea/0x4d0 mm/gup.c:1555
>  mm_populate include/linux/mm.h:2701 [inline]
>  vm_mmap_pgoff+0x241/0x2f0 mm/util.c:524
>  ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1628
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7faf9f4890e9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fafa06c9168 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007faf9f59bf60 RCX: 00007faf9f4890e9
> RDX: 0000000001000006 RSI: 0000000000b34900 RDI: 0000000020000000
> RBP: 00007faf9f4e308d R08: 0000000000000004 R09: 0000000000000000
> R10: 0000000000028011 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff03616e1f R14: 00007fafa06c9300 R15: 0000000000022000
>  </TASK>
> 
> Allocated by task 1755:
>  kasan_save_stack mm/kasan/common.c:38 [inline]
>  kasan_set_track mm/kasan/common.c:45 [inline]
>  set_alloc_info mm/kasan/common.c:436 [inline]
>  __kasan_slab_alloc+0xb2/0xe0 mm/kasan/common.c:469
>  kasan_slab_alloc include/linux/kasan.h:224 [inline]
>  slab_post_alloc_hook mm/slab.h:749 [inline]
>  slab_alloc_node mm/slub.c:3217 [inline]
>  slab_alloc mm/slub.c:3225 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3232 [inline]
>  kmem_cache_alloc+0x199/0x2f0 mm/slub.c:3242
>  vm_area_alloc+0x20/0xe0 kernel/fork.c:459
>  mmap_region+0xbef/0x1730 mm/mmap.c:1771
>  do_mmap+0x7a7/0xdf0 mm/mmap.c:1582
>  vm_mmap_pgoff+0x1e5/0x2f0 mm/util.c:519
>  ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1628
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Freed by task 1759:
>  kasan_save_stack mm/kasan/common.c:38 [inline]
>  kasan_set_track+0x4c/0x70 mm/kasan/common.c:45
>  kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
>  ____kasan_slab_free+0xd8/0x110 mm/kasan/common.c:366
>  kasan_slab_free include/linux/kasan.h:200 [inline]
>  slab_free_hook mm/slub.c:1728 [inline]
>  slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1754
>  slab_free mm/slub.c:3510 [inline]
>  kmem_cache_free+0xc7/0x270 mm/slub.c:3527
>  remove_vma mm/mmap.c:189 [inline]
>  remove_vma_list mm/mmap.c:2625 [inline]
>  __do_munmap+0x1b4f/0x1cd0 mm/mmap.c:2863
>  do_munmap mm/mmap.c:2871 [inline]
>  munmap_vma_range mm/mmap.c:604 [inline]
>  mmap_region+0x97a/0x1730 mm/mmap.c:1746
>  do_mmap+0x7a7/0xdf0 mm/mmap.c:1582
>  vm_mmap_pgoff+0x1e5/0x2f0 mm/util.c:519
>  ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1628
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> The buggy address belongs to the object at ffff88801fedb000
>  which belongs to the cache vm_area_struct of size 200
> The buggy address is located 80 bytes inside of
>  200-byte region [ffff88801fedb000, ffff88801fedb0c8)
> 
> The buggy address belongs to the physical page:
> page:ffffea00007fb6c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fedb
> memcg:ffff88801b6a0001
> flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888140006a00
> raw: 0000000000000000 00000000000f000f 00000001ffffffff ffff88801b6a0001
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 20293, tgid 20293 (modprobe), ts 461559890566, free_ts 461429792689
>  prep_new_page mm/page_alloc.c:2441 [inline]
>  get_page_from_freelist+0x72e/0x7a0 mm/page_alloc.c:4182
>  __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5408
>  alloc_slab_page+0x70/0xf0 mm/slub.c:1799
>  allocate_slab+0x5e/0x560 mm/slub.c:1944
>  new_slab mm/slub.c:2004 [inline]
>  ___slab_alloc+0x41e/0xcd0 mm/slub.c:3005
>  __slab_alloc mm/slub.c:3092 [inline]
>  slab_alloc_node mm/slub.c:3183 [inline]
>  slab_alloc mm/slub.c:3225 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3232 [inline]
>  kmem_cache_alloc+0x246/0x2f0 mm/slub.c:3242
>  vm_area_alloc+0x20/0xe0 kernel/fork.c:459
>  mmap_region+0xbef/0x1730 mm/mmap.c:1771
>  do_mmap+0x7a7/0xdf0 mm/mmap.c:1582
>  vm_mmap_pgoff+0x1e5/0x2f0 mm/util.c:519
>  ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1628
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1356 [inline]
>  free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1406
>  free_unref_page_prepare mm/page_alloc.c:3328 [inline]
>  free_unref_page_list+0x12c/0x890 mm/page_alloc.c:3460
>  release_pages+0x2a04/0x2cb0 mm/swap.c:980
>  __pagevec_release+0x7d/0xf0 mm/swap.c:1000
>  pagevec_release include/linux/pagevec.h:82 [inline]
>  folio_batch_release include/linux/pagevec.h:146 [inline]
>  truncate_inode_pages_range+0x4a2/0x17b0 mm/truncate.c:373
>  kill_bdev block/bdev.c:77 [inline]
>  blkdev_flush_mapping+0x181/0x350 block/bdev.c:656
>  blkdev_put_whole block/bdev.c:687 [inline]
>  blkdev_put+0x49f/0x790 block/bdev.c:947
>  blkdev_close+0x55/0x80 block/fops.c:512
>  __fput+0x3b9/0x820 fs/file_table.c:317
>  task_work_run+0x146/0x1c0 kernel/task_work.c:164
>  exit_task_work include/linux/task_work.h:37 [inline]
>  do_exit+0x547/0x1eb0 kernel/exit.c:795
>  do_group_exit+0x23b/0x2f0 kernel/exit.c:925
>  get_signal+0x172f/0x1780 kernel/signal.c:2864
>  arch_do_signal_or_restart+0x8d/0x750 arch/x86/kernel/signal.c:867
>  exit_to_user_mode_loop+0x74/0x160 kernel/entry/common.c:166
>  exit_to_user_mode_prepare+0xad/0x110 kernel/entry/common.c:201
> 
> Memory state around the buggy address:
>  ffff88801fedaf00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
>  ffff88801fedaf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff88801fedb000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                  ^
>  ffff88801fedb080: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
>  ffff88801fedb100: fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
