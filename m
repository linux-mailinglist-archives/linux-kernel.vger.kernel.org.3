Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E157046F657
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhLIWEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhLIWEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:04:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F80C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PPC0L6Vu252aZRUugEEHroxKTSnmzeoFgZjVuaxmUHk=; b=snWVQjsBk/8Uq3H1zvDDk+aa9X
        BAzecOFfQoibjDqIn9N+Ft0JoCwwgnTgQCuiXmUyQpP+wDSO4Tqtu4LFRy/ljA+qIG+ObqPypf5e/
        wf8m2R9WSu8h3K+zNJ/vRr9jZi9Lwe46j8I647eH0gs4VYilXjc40j4myHohF8VRdDx05z5ZBms0g
        PensRZYGhm2ki+1As8IF2PFMoXON4He5Ya8wO9sltrpnpq3hgl6h3g7g0dij83GveyawCLLv8yvSu
        ZhieM5t3votm2E8Y/mtnFKcimrdbFy+i96kmifSXydiO657YVvYROevFjQI1rf4sQXFYSBI3hCAZQ
        vFaoTMJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvRTG-009lV2-SG; Thu, 09 Dec 2021 22:00:58 +0000
Date:   Thu, 9 Dec 2021 22:00:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     syzbot <syzbot+dcea9eda277e1090b35f@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [syzbot] INFO: task can't die in reclaim_throttle
Message-ID: <YbJ8mjvo+k9r9xpM@casper.infradead.org>
References: <00000000000050185105d2ac05d2@google.com>
 <d0a2acda-c939-73fa-477c-58a2d6bb28f7@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a2acda-c939-73fa-477c-58a2d6bb28f7@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 03:51:00PM +0100, Vlastimil Babka wrote:
> On 12/9/21 01:52, syzbot wrote:
> > Hello,
> 
> + CC Mel

I don't know that this is Mel's fault.  We've been absolutely beastly
to the MM here.

page_cache_ra_unbounded() calls memalloc_nofs_save() so that page
reclaim won't try to reclaim pages that we've already allocated and
locked.

Then mempool_alloc() has set NOMEMALLOC, NORETRY and NOWARN, then called
kmem_cache_alloc() which has unfortunately fallen all the way into the
page allocator.  And gone to sleep for 143 seconds by the looks of things.
Hm, maybe that is Mel's fault, then.  But still, we've asked the MM to
do reclaim with one hand tied behind its back (we're clearly on the
second round in mempool_alloc() here, so we might have GFP_IO set).

> > syzbot found the following issue on:
> > 
> > HEAD commit:    4eee8d0b64ec Add linux-next specific files for 20211208
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=113d8d75b00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=20b74d9da4ce1ef1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=dcea9eda277e1090b35f
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+dcea9eda277e1090b35f@syzkaller.appspotmail.com
> > 
> > INFO: task syz-executor.5:925 can't die for more than 143 seconds.
> > task:syz-executor.5  state:D
> >  stack:23840 pid:  925 ppid:   565 flags:0x00004006
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:4986 [inline]
> >  __schedule+0xab2/0x4d90 kernel/sched/core.c:6296
> >  schedule+0xd2/0x260 kernel/sched/core.c:6369
> >  schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1881
> >  reclaim_throttle+0x1ce/0x5e0 mm/vmscan.c:1072
> >  consider_reclaim_throttle mm/vmscan.c:3399 [inline]
> >  shrink_zones mm/vmscan.c:3486 [inline]
> >  do_try_to_free_pages+0x7cd/0x1620 mm/vmscan.c:3541
> >  try_to_free_pages+0x29f/0x750 mm/vmscan.c:3776
> >  __perform_reclaim mm/page_alloc.c:4603 [inline]
> >  __alloc_pages_direct_reclaim mm/page_alloc.c:4624 [inline]
> >  __alloc_pages_slowpath.constprop.0+0xa9e/0x2080 mm/page_alloc.c:5014
> >  __alloc_pages+0x412/0x500 mm/page_alloc.c:5389
> >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2271
> >  alloc_slab_page mm/slub.c:1799 [inline]
> >  allocate_slab mm/slub.c:1952 [inline]
> >  new_slab+0x2a9/0x3a0 mm/slub.c:2004
> >  ___slab_alloc+0x6be/0xd60 mm/slub.c:3019
> >  __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3106
> >  slab_alloc_node mm/slub.c:3197 [inline]
> >  slab_alloc mm/slub.c:3239 [inline]
> >  kmem_cache_alloc+0x35c/0x3a0 mm/slub.c:3244
> >  mempool_alloc+0x146/0x350 mm/mempool.c:392
> >  bvec_alloc+0x16b/0x200 block/bio.c:206
> >  bio_alloc_bioset+0x376/0x4a0 block/bio.c:481
> >  bio_alloc include/linux/bio.h:371 [inline]
> >  mpage_alloc+0x2f/0x1b0 fs/mpage.c:79
> >  do_mpage_readpage+0xfa9/0x2590 fs/mpage.c:306
> >  mpage_readahead+0x3db/0x920 fs/mpage.c:389
> >  read_pages+0x1db/0x790 mm/readahead.c:129
> >  page_cache_ra_unbounded+0x585/0x780 mm/readahead.c:238
> >  do_page_cache_ra+0xf9/0x140 mm/readahead.c:268
> >  do_sync_mmap_readahead mm/filemap.c:3058 [inline]
> >  filemap_fault+0x157f/0x21c0 mm/filemap.c:3151
> >  __do_fault+0x10d/0x790 mm/memory.c:3846
> >  do_read_fault mm/memory.c:4161 [inline]
> >  do_fault mm/memory.c:4290 [inline]
> >  handle_pte_fault mm/memory.c:4548 [inline]
> >  __handle_mm_fault+0x2761/0x4160 mm/memory.c:4683
> >  handle_mm_fault+0x1c8/0x790 mm/memory.c:4781
> >  faultin_page mm/gup.c:939 [inline]
> >  __get_user_pages+0x503/0xf80 mm/gup.c:1160
> >  populate_vma_page_range+0x24d/0x330 mm/gup.c:1492
> >  __mm_populate+0x1ea/0x3e0 mm/gup.c:1601
> >  mm_populate include/linux/mm.h:2698 [inline]
> >  vm_mmap_pgoff+0x20e/0x290 mm/util.c:524
> >  ksys_mmap_pgoff+0x40d/0x5a0 mm/mmap.c:1630
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7fd1c83f6af9
> > RSP: 002b:00007fd1c736c188 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> > RAX: ffffffffffffffda RBX: 00007fd1c8509f60 RCX: 00007fd1c83f6af9
> > RDX: 0000000001000002 RSI: 0000000000b36000 RDI: 0000000020000000
> > RBP: 00007fd1c8450ff7 R08: 0000000000000004 R09: 0000000000000000
> > R10: 0000000000028011 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007fff309a431f R14: 00007fd1c736c300 R15: 0000000000022000
> >  </TASK>
> > 
> > Showing all locks held in the system:
> > 1 lock held by khungtaskd/26:
> >  #0: ffffffff8bb828a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6460
> > 1 lock held by kswapd1/99:
> > 1 lock held by in:imklog/6230:
> >  #0: ffff888021d92370 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:994
> > 1 lock held by syz-executor.5/925:
> > 
> > =============================================
> > 
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> 
> 
