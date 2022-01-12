Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AAA48CA99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355948AbiALSF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:05:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51854 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbiALSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:05:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D6CD6194E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 18:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65652C36AEA;
        Wed, 12 Jan 2022 18:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642010724;
        bh=P4SJMdzZ/w0p3IRxTunoyNGtX9xXeDFT0O6Mk5nb/b0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BaQ74/g+lmwGzLFaq2zkjaiFIn7QS55t1a4EyoCcggGlKVMm8gKnPQUM7S0jfqxeZ
         gPzL1nC3lUSOx7G8vQuMNDKxNxrRCDz4ws/xdMjOGHAUUNT9K2oSJ4dmcfYuyerkQV
         38/VSNCMrsAnEYjBGN28zSfzgzkvwWZoxQnO7LF1IU7oB7Q58XaQGRUYjurb2bd2qh
         c5kZrKOCj8T5znhP8SV62h1AiEQTh5Fbz4JggLCf75yuP8jat0k1CUjYxzGS7xZE0c
         f/44uGER4zZsttHgnvlE9S3WmePy36lMVCANcjMnEAiKKW9MKAFEM5AOxQeww1UN6t
         fHqxiAQ0QHLoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 320F35C0292; Wed, 12 Jan 2022 10:05:24 -0800 (PST)
Date:   Wed, 12 Jan 2022 10:05:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        quic_neeraju@quicinc.com, frederic@kernel.org, urezki@gmail.com,
        boqun.feng@gmail.com
Subject: Re: [syzbot] KASAN: use-after-free Read in srcu_invoke_callbacks
Message-ID: <20220112180524.GA472951@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <00000000000081b56205d54c6667@google.com>
 <20220111134324.1727-1-hdanton@sina.com>
 <20220112094352.1785-1-hdanton@sina.com>
 <20220112171247.GM947480@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112171247.GM947480@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 09:12:47AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 12, 2022 at 05:43:52PM +0800, Hillf Danton wrote:
> > On Tue, 11 Jan 2022 11:05:00 -0800 Paul E. McKenney wrote:
> > > On Tue, Jan 11, 2022 at 09:43:24PM +0800, Hillf Danton wrote:
> > > > On Tue, 11 Jan 2022 03:03:17 -0800
> > > > > Hello,
> > > > > 
> > > > > syzbot found the following issue on:
> > > > > 
> > > > > HEAD commit:    3770333b3f8c Add linux-next specific files for 20220106
> > > > > git tree:       linux-next
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=171aa4e3b00000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f9eb40d9f910b474
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=4f789823c1abc5accf13
> > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b08f53b00000
> > > > > 
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com
> > > > > 
> > > > > ==================================================================
> > > > > BUG: KASAN: use-after-free in rcu_seq_snap kernel/rcu/rcu.h:91 [inline]
> > > > > BUG: KASAN: use-after-free in srcu_invoke_callbacks+0x391/0x3c0 kernel/rcu/srcutree.c:1283
> > > > > Read of size 8 at addr ffff8880189b6968 by task kworker/0:1/7
> > > > > 
> > > > > CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.16.0-rc8-next-20220106-syzkaller #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > > Workqueue: rcu_gp srcu_invoke_callbacks
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > > > >  print_address_description.constprop.0.cold+0xa5/0x3ed mm/kasan/report.c:255
> > > > >  __kasan_report mm/kasan/report.c:442 [inline]
> > > > >  kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
> > > > >  rcu_seq_snap kernel/rcu/rcu.h:91 [inline]
> > > 
> > > This can happen when a given srcu_struct was passed to cleanup_srcu_struct
> > > before all callbacks were invoked.
> > > 
> > > > >  srcu_invoke_callbacks+0x391/0x3c0 kernel/rcu/srcutree.c:1283
> > > > >  process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
> > > > >  worker_thread+0x657/0x1110 kernel/workqueue.c:2454
> > > > >  kthread+0x2e9/0x3a0 kernel/kthread.c:377
> > > > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > > > >  </TASK>
> > > > > 
> > > > > Allocated by task 19830:
> > > > >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> > > > >  kasan_set_track mm/kasan/common.c:45 [inline]
> > > > >  set_alloc_info mm/kasan/common.c:436 [inline]
> > > > >  __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
> > > > >  kasan_slab_alloc include/linux/kasan.h:260 [inline]
> > > > >  slab_post_alloc_hook mm/slab.h:738 [inline]
> > > > >  slab_alloc_node mm/slub.c:3230 [inline]
> > > > >  kmem_cache_alloc_node+0x255/0x3e0 mm/slub.c:3266
> > > 
> > > The memory in question was allocated by blk_alloc_queue().
> > > 
> > > > >  blk_alloc_queue+0x5ad/0x870 block/blk-core.c:446
> > > > >  blk_mq_init_queue_data block/blk-mq.c:3878 [inline]
> > > > >  __blk_mq_alloc_disk+0x8c/0x1c0 block/blk-mq.c:3902
> > > > >  nbd_dev_add+0x3b2/0xcd0 drivers/block/nbd.c:1765
> > > > >  nbd_genl_connect+0x11f3/0x1930 drivers/block/nbd.c:1948
> > > > >  genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:731
> > > > >  genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
> > > > >  genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:792
> > > > >  netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
> > > > >  genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
> > > > >  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
> > > > >  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1343
> > > > >  netlink_sendmsg+0x904/0xdf0 net/netlink/af_netlink.c:1919
> > > > >  sock_sendmsg_nosec net/socket.c:705 [inline]
> > > > >  sock_sendmsg+0xcf/0x120 net/socket.c:725
> > > > >  ____sys_sendmsg+0x6e8/0x810 net/socket.c:2410
> > > > >  ___sys_sendmsg+0xf3/0x170 net/socket.c:2464
> > > > >  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2493
> > > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > 
> > > > > Freed by task 13:
> > > > >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> > > > >  kasan_set_track+0x21/0x30 mm/kasan/common.c:45
> > > > >  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
> > > > >  ____kasan_slab_free mm/kasan/common.c:366 [inline]
> > > > >  ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
> > > > >  kasan_slab_free include/linux/kasan.h:236 [inline]
> > > > >  slab_free_hook mm/slub.c:1728 [inline]
> > > > >  slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
> > > > >  slab_free mm/slub.c:3509 [inline]
> > > > >  kmem_cache_free+0xdb/0x3b0 mm/slub.c:3526
> > > 
> > > This is an RCU (not SRCU!) callback.
> > > 
> > > > >  rcu_do_batch kernel/rcu/tree.c:2536 [inline]
> > > > >  rcu_core+0x7b8/0x1540 kernel/rcu/tree.c:2787
> > > > >  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
> > > > > 
> > > > > Last potentially related work creation:
> > > > >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> > > > >  __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
> > > 
> > > This matches the RCU callback.
> > > 
> > > > >  call_rcu+0x99/0x730 kernel/rcu/tree.c:3072
> > > > >  kobject_cleanup lib/kobject.c:705 [inline]
> > > > >  kobject_release lib/kobject.c:736 [inline]
> > > > >  kref_put include/linux/kref.h:65 [inline]
> > > > >  kobject_put+0x1c8/0x540 lib/kobject.c:753
> > > > >  disk_release+0x19a/0x260 block/genhd.c:1116
> > > > >  device_release+0x9f/0x240 drivers/base/core.c:2229
> > > > >  kobject_cleanup lib/kobject.c:705 [inline]
> > > > >  kobject_release lib/kobject.c:736 [inline]
> > > > >  kref_put include/linux/kref.h:65 [inline]
> > > > >  kobject_put+0x1c8/0x540 lib/kobject.c:753
> > > > >  put_device+0x1b/0x30 drivers/base/core.c:3512
> > > > >  put_disk block/genhd.c:1368 [inline]
> > > > >  blk_cleanup_disk+0x6b/0x80 block/genhd.c:1384
> > > > >  nbd_dev_remove+0x44/0xf0 drivers/block/nbd.c:253
> > > > >  process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
> > > > >  worker_thread+0x657/0x1110 kernel/workqueue.c:2454
> > > > >  kthread+0x2e9/0x3a0 kernel/kthread.c:377
> > > > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > > > > 
> > > > > Second to last potentially related work creation:
> > > > >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> > > > >  __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
> > > > >  insert_work+0x48/0x370 kernel/workqueue.c:1368
> > > > >  __queue_work+0x5ca/0xf30 kernel/workqueue.c:1534
> > > > >  __queue_delayed_work+0x1c8/0x270 kernel/workqueue.c:1682
> > > > >  queue_delayed_work_on+0x105/0x120 kernel/workqueue.c:1718
> > > > >  process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
> > > > >  worker_thread+0x657/0x1110 kernel/workqueue.c:2454
> > > > >  kthread+0x2e9/0x3a0 kernel/kthread.c:377
> > > > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > > > > 
> > > > > The buggy address belongs to the object at ffff8880189b5c70
> > > > >  which belongs to the cache request_queue_srcu of size 3816
> > > > > The buggy address is located 3320 bytes inside of
> > > > >  3816-byte region [ffff8880189b5c70, ffff8880189b6b58)
> > > > > The buggy address belongs to the page:
> > > > > page:ffffea0000626c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x189b0
> > > > > head:ffffea0000626c00 order:3 compound_mapcount:0 compound_pincount:0
> > > > > flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> > > > > raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888012787140
> > > > > raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
> > > > > page dumped because: kasan: bad access detected
> > > > > page_owner tracks the page as allocated
> > > > > page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 14963, ts 196854875504, free_ts 196839673140
> > > > >  prep_new_page mm/page_alloc.c:2434 [inline]
> > > > >  get_page_from_freelist+0xa72/0x2f40 mm/page_alloc.c:4165
> > > > >  __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5381
> > > > >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2271
> > > > >  alloc_slab_page mm/slub.c:1799 [inline]
> > > > >  allocate_slab mm/slub.c:1944 [inline]
> > > > >  new_slab+0x28d/0x380 mm/slub.c:2004
> > > > >  ___slab_alloc+0x6be/0xd60 mm/slub.c:3018
> > > > >  __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3105
> > > > >  slab_alloc_node mm/slub.c:3196 [inline]
> > > > >  kmem_cache_alloc_node+0x122/0x3e0 mm/slub.c:3266
> > > 
> > > Again blk_alloc_queue().
> > > 
> > > > >  blk_alloc_queue+0x5ad/0x870 block/blk-core.c:446
> > > > >  blk_mq_init_queue_data block/blk-mq.c:3878 [inline]
> > > > >  __blk_mq_alloc_disk+0x8c/0x1c0 block/blk-mq.c:3902
> > > > >  nbd_dev_add+0x3b2/0xcd0 drivers/block/nbd.c:1765
> > > > >  nbd_genl_connect+0x11f3/0x1930 drivers/block/nbd.c:1948
> > > > >  genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:731
> > > > >  genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
> > > > >  genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:792
> > > > >  netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
> > > > >  genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
> > > > >  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
> > > > >  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1343
> > > > > page last free stack trace:
> > > > >  reset_page_owner include/linux/page_owner.h:24 [inline]
> > > > >  free_pages_prepare mm/page_alloc.c:1352 [inline]
> > > > >  free_pcp_prepare+0x414/0xb60 mm/page_alloc.c:1404
> > > > >  free_unref_page_prepare mm/page_alloc.c:3325 [inline]
> > > > >  free_unref_page+0x19/0x690 mm/page_alloc.c:3404
> > > > >  __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2536
> > > > >  qlink_free mm/kasan/quarantine.c:157 [inline]
> > > > >  qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:176
> > > > >  kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:283
> > > > >  __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
> > > > >  kasan_slab_alloc include/linux/kasan.h:260 [inline]
> > > > >  slab_post_alloc_hook mm/slab.h:738 [inline]
> > > > >  slab_alloc_node mm/slub.c:3230 [inline]
> > > > >  slab_alloc mm/slub.c:3238 [inline]
> > > > >  __kmalloc+0x1e7/0x340 mm/slub.c:4420
> > > > >  kmalloc include/linux/slab.h:586 [inline]
> > > > >  tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
> > > > >  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
> > > > >  tomoyo_path_perm+0x21b/0x400 security/tomoyo/file.c:822
> > > > >  security_inode_getattr+0xcf/0x140 security/security.c:1326
> > > > >  vfs_getattr fs/stat.c:157 [inline]
> > > > >  vfs_statx+0x164/0x390 fs/stat.c:225
> > > > >  vfs_fstatat fs/stat.c:243 [inline]
> > > > >  __do_sys_newfstatat+0x96/0x120 fs/stat.c:412
> > > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > 
> > > > > Memory state around the buggy address:
> > > > >  ffff8880189b6800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > >  ffff8880189b6880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > > >ffff8880189b6900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > >                                                           ^
> > > > >  ffff8880189b6980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > >  ffff8880189b6a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > > ==================================================================
> > > > 
> > > > To fix the uaf, add completion to sdp and wait for sdp->work to complete
> > > > even after work flush while cleaning ssp up.
> > > 
> > > Good catch!!!
> > > 
> > > First, restating the usage rules to help explain the failure scenario:
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > You are supposed to wait until all SRCU callbacks for a given srcu_struct
> > > have been invoked before invoking cleanup_srcu_struct().  There is an
> > > srcu_barrier() to help with this, but for it to do you any good you have
> > > to have made sure that you stopped calling call_srcu() before invoking
> > > srcu_barrier().
> > > 
> > > Failing to follow this rule, that is, invoking cleanup_srcu_struct()
> > > before all the corresponding SRCU callbacks have been invoked, could
> > > indeed result in the mess above, and much worse.
> > > 
> > > There are checks in  cleanup_srcu_struct() for this sort of thing,
> > > namely:
> > > 
> > > 	if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
> > > 
> > > However, such checks cannot be perfect.  For example, the
> > > cleanup_srcu_struct() might be invoked just a bit too early,
> > > after the last callback was invoked (hence the above WARN_ON() not
> > > triggering) and just before the call to rcu_seq_snap() at the end of
> > > srcu_invoke_callbacks() (hence KASAN being unhappy with that call to
> > > srcu_seq_snap()).
> > > 
> > > So:
> > > 
> > > 1.	Make sure that you stop invoking call_srcu() before starting the
> > > 	process of freeing that srcu_struct.  In addition, you of course
> > > 	need to make sure that you have stopped passing the srcu_struct
> > > 	in question to anything else.
> > > 
> > > 2.	Once all CPUs agree that you have stopped invoking call_srcu(),
> > > 	invoke srcu_barrier() to ensure that all callbacks have been
> > > 	invoked.  Keep in mind that srcu_barrier() is only guaranteed
> > > 	to wait for callbacks queued by calls to call_srcu() that happen
> > > 	-before- that call to srcu_barrier().  This is one of those cases
> > > 	where being almost correct has nothing to do with being correct.
> > > 
> > > 3.	Then, and only then, is it safe to invoke cleanup_srcu_struct().
> > > 
> > > Of course, if you never use call_srcu() on a given srcu_struct,
> > > you don't need to invoke srcu_barrier().
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > Except that srcu_invoke_callbacks() accesses the various srcu_struct
> > > fields after the last rcu_barrier() callback was invoked.   Which
> > > means that the following sequence of events can happen:
> > > 
> > > o	Task A invokes the last call_srcu().
> > > 
> > > o	Later, Task B invokes rcu_barrier().
> > > 
> > > o	The last rcu_barrier() callback is invoked by CPU 0 from
> > > 	within srcu_invoke_callbacks(), which awakens Task B.
> > > 
> > > o	Task B invokes cleanup_srcu_struct(), which is perfectly legal
> > > 	given that Task B followed the rules called out above.
> > > 
> > > o	But now CPU 0 continues executing srcu_invoke_callbacks(),
> > > 	which accesses srcu_struct fields and related structures
> > > 	that were freed by cleanup_srcu_struct().
> > > 
> > > As both you and syzbot say, use after free bug.
> > > 
> > > > Only for thoughts now.
> > > > 
> > > > Hillf
> > > > 
> > > > +++ y/kernel/rcu/srcutree.c
> > > > @@ -74,6 +74,12 @@ do {									\
> > > >  #define spin_unlock_irqrestore_rcu_node(p, flags)			\
> > > >  	spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags)	\
> > > >  
> > > > +static inline void init_completion_done(struct completion *x)
> > > > +{
> > > > +	x->done = 1;
> > > > +	init_swait_queue_head(&x->wait);
> > > 
> > > This is small enough that it should be inlined.
> > > 
> > > But it turns out that we don't really need it.
> > > 
> > > > +}
> > > > +
> > > >  /*
> > > >   * Initialize SRCU combining tree.  Note that statically allocated
> > > >   * srcu_struct structures might already have srcu_read_lock() and
> > > > @@ -150,6 +156,7 @@ static void init_srcu_struct_nodes(struc
> > > >  		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
> > > >  		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
> > > >  		sdp->ssp = ssp;
> > > > +		init_completion_done(&sdp->work_done);
> > > >  		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> > > >  	}
> > > >  }
> > > > @@ -378,6 +385,7 @@ void cleanup_srcu_struct(struct srcu_str
> > > >  
> > > >  		del_timer_sync(&sdp->delay_work);
> > > >  		flush_work(&sdp->work);
> > > > +		wait_for_completion(&sdp->work_done);
> > > 
> > > With the changes described below, this happens once rather than once
> > > per CPU.  The trick is to make use of the ordering that is already
> > > provided by the atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt) in the
> > > rcu_barrier() function's callback function, that is, srcu_barrier_cb(),
> > > but by moving this to the end of srcu_barrier().
> > > 
> > > 
> > > >  		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
> > > >  			return; /* Forgot srcu_barrier(), so just leak it! */
> > > >  	}
> > > > @@ -1248,6 +1256,7 @@ static void srcu_invoke_callbacks(struct
> > > >  	struct srcu_struct *ssp;
> > > >  
> > > >  	sdp = container_of(work, struct srcu_data, work);
> > > > +	reinit_completion(&sdp->work_done);
> > > 
> > > We can avoid this by reusing the existing ->srcu_barrier_completion.
> > > 
> > > >  	ssp = sdp->ssp;
> > > >  	rcu_cblist_init(&ready_cbs);
> > > > @@ -1257,7 +1266,7 @@ static void srcu_invoke_callbacks(struct
> > > >  	if (sdp->srcu_cblist_invoking ||
> > > >  	    !rcu_segcblist_ready_cbs(&sdp->srcu_cblist)) {
> > > >  		spin_unlock_irq_rcu_node(sdp);
> > > > -		return;  /* Someone else on the job or nothing to do. */
> > > > +		goto out;  /* Someone else on the job or nothing to do. */
> > > >  	}
> > > >  
> > > >  	/* We are on the job!  Extract and invoke ready callbacks. */
> > > > @@ -1287,6 +1296,9 @@ static void srcu_invoke_callbacks(struct
> > > >  	spin_unlock_irq_rcu_node(sdp);
> > > >  	if (more)
> > > >  		srcu_schedule_cbs_sdp(sdp, 0);
> > > > +	else
> > > > +out:
> > > > +		complete(&sdp->work_done);
> > > 
> > > This is too ugly to live.  ;-)
> > > 
> > > And it should also be executed in srcu_barrier().  This can be done using
> > > a flag that is cleared early on in rcu_barrier() and then set by the last
> > > rcu_barrier() callback (the same one that does the complete() invocation).
> > > 
> > > Plus we really do want to execute complete() in the case where there are
> > > callbacks in order to increase the probability of cleanup_srcu_struct()
> > > finding SRCU-abuse bugs.
> > > 
> > > >  }
> > > >  
> > > >  /*
> > > > +++ y/include/linux/srcutree.h
> > > > @@ -40,6 +40,7 @@ struct srcu_data {
> > > >  						/*  ->srcu_data_have_cbs[]. */
> > > >  	int cpu;
> > > >  	struct srcu_struct *ssp;
> > > > +	struct completion work_done;
> > > 
> > > All we really need to add here is a flag that allows srcu_barrier_cb()
> > > to signal srcu_invoke_callbacks().
> > > 
> > > OK, I didn't do a really good job of describing what I am after, so here
> > > is a patch with your Reported-by and that of syzbot.
> > > 
> > > Thoughts?
> > > 
> > > 							Thanx, Paul
> > > 
> > 
> > Hi Paul,
> > 
> > Thank you for taking a look at it.
> > 
> > > ------------------------------------------------------------------------
> > > 
> > > commit b01a1d25f93633c89f782ec5d3830beeb3892030
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Tue Jan 11 10:30:07 2022 -0800
> > > 
> > >     srcu: Prevent srcu_barrier()->cleanup_srcu_struct() use-after-free
> > >     
> > >     Currently, srcu_barrier() will return immediately after its last
> > >     srcu_barrier_cb() has been invoked, thus guaranteeing that all previous
> > >     callbacks have been completely invoked, as required.  Unfortunately,
> > >     this is insufficient in the case where the call to srcu_barrier()
> > >     is immediately followed by a call to cleanup_srcu_struct().  In this
> > >     case, srcu_invoke_callbacks() will access the srcu_struct and related
> > >     structures after invoking the callbacks, and these structures might have
> > >     already have been freed by cleanup_srcu_struct().
> > >     
> > >     This can happen as follows:
> > >     
> > >     o       Task A invokes the last call_srcu().
> > >     
> > >     o       Later, Task B invokes rcu_barrier().
> > >     
> > >     o       The last rcu_barrier() callback is invoked by CPU 0 from
> > >             within srcu_invoke_callbacks(), which awakens Task B.
> > >     
> > >     o       Task B invokes cleanup_srcu_struct(), which is perfectly legal
> > >             assuming that Task B waited until the last call_srcu()
> > > 	    completed before invoking rcu_barrier().
> > >     
> > >     o       But now CPU 0 continues executing srcu_invoke_callbacks(),
> > >             which accesses srcu_struct fields and related structures
> > >             that were freed by cleanup_srcu_struct().
> > >     
> > >     This commit fixes this by moving the complete() call that awakens
> > >     srcu_barrier() from the the srcu_barrier_cb() callback to the end of
> > >     srcu_invoke_callbacks().  This requires introducing a per-srcu_data
> > >     structure ->srcu_barrier_cb_done flag that allows srcu_barrier_cb()
> > >     to tell srcu_invoke_callbacks() that a wakeup might be required.
> > >     
> > >     Link: https://lore.kernel.org/all/00000000000081b56205d54c6667@google.com/
> > >     Reported-by: syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com
> > >     Reported-by: Hillf Danton <hdanton@sina.com>
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > index cb1f4351e8baa..339dd55fbea5c 100644
> > > --- a/include/linux/srcutree.h
> > > +++ b/include/linux/srcutree.h
> > > @@ -32,6 +32,7 @@ struct srcu_data {
> > >  	unsigned long srcu_gp_seq_needed;	/* Furthest future GP needed. */
> > >  	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
> > >  	bool srcu_cblist_invoking;		/* Invoking these CBs? */
> > > +	bool srcu_barrier_cb_done;		/* This CPU's srcu_rcu_barrier_cb() done? */
> > >  	struct timer_list delay_work;		/* Delay for CB invoking */
> > >  	struct work_struct work;		/* Context for CB invoking. */
> > >  	struct rcu_head srcu_barrier_head;	/* For srcu_barrier() use. */
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 6833d88871816..128034f858897 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1088,13 +1088,9 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_srcu);
> > >   */
> > >  static void srcu_barrier_cb(struct rcu_head *rhp)
> > >  {
> > > -	struct srcu_data *sdp;
> > > -	struct srcu_struct *ssp;
> > > +	struct srcu_data *sdp = container_of(rhp, struct srcu_data, srcu_barrier_head);
> > >  
> > > -	sdp = container_of(rhp, struct srcu_data, srcu_barrier_head);
> > > -	ssp = sdp->ssp;
> > > -	if (atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt))
> > > -		complete(&ssp->srcu_barrier_completion);
> > > +	sdp->srcu_barrier_cb_done = true;
> > 
> > Currently no waiter is waken up without running the last callback, given
> > atomic_dec_and_test().
> > 
> > >  }
> > >  
> > >  /**
> > > @@ -1287,6 +1283,15 @@ static void srcu_invoke_callbacks(struct work_struct *work)
> > >  	spin_unlock_irq_rcu_node(sdp);
> > >  	if (more)
> > >  		srcu_schedule_cbs_sdp(sdp, 0);
> > > +
> > > +	// Do complete() to wake up srcu_barrier() here to ensure no
> > > +	// use-after-free should cleanup_srcu_struct() be invoked immediately
> > > +	// after the return from srcu_barrier().
> > > +	if (sdp->srcu_barrier_cb_done) {
> > > +		sdp->srcu_barrier_cb_done = false;
> > > +		if (atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt))
> > > +			complete(&ssp->srcu_barrier_completion);
> > > +	}
> > >  }
> > 
> > After this patch no waiter is waken up without running the last callback, given
> > atomic_dec_and_test(), while the uaf says it is not safe to derefer ssp in the
> > workqueue work callback after flushing work. I mean moving wakeup to the end of
> > WQ work callback does not do more than flush_work().
> > 
> > 	cleanup_srcu_struct()
> > 	  flush_work(&sdp->work)
> 
> Heh!!!
> 
> It is worse than that.  There are no callers of srcu_barrier() outside
> of RCU and rcutorture.  So neither of our patches can possibly have any
> effect whatsoever!
> 
> Given that you have shown that the flush_work() covers the race window I
> was thinking that I was seeing, I will revert mine.  Or can you provide
> a detailed sequence of events no SRCU API calls for a given srcu_struct
> fail to happen before happen before the cleanup_srcu_struct() but still
> result in a use-after-free error?
> 
> And here I was thinking that that COVID booster a few days ago hadn't
> impaired my mental abilities.  :-/
> 
> Given that there are no srcu_barrier() invocations, any use of call_srcu()
> in an unloadable module is suspect.  From what I can see, the only
> invocations of call_srcu() from a module are in fs/dlm/lowcomms.c.
> So can fs/dlm be unloaded?  Might it have been unloaded in this test?
> For that matter, why does fs/dlm need a per-instance srcu_struct?
> At first glance, it looks like a single global srcu_struct would
> serve just as well.  This would not make srcu_barrier() unnecessary at
> module-unload time, but it would make it so that only one srcu_barrier()
> was required at that time.
> 
> Another possibility is that something is invoking cleanup_srcu_struct()
> too early.  If any other use of that same srcu_struct could happen
> concurrently with that cleanup_srcu_struct(), then we could see this
> sort of problem.
> 
> Another possibility, this time within SRCU, is if some set of race
> conditions can result in SRCU's internals doing an extra unnecessary
> grace period.  If this race happened for the last synchronize_srcu()
> prior to the cleanup_srcu_struct(), that could explain this issue.

And in the meantime, please see below for a patch designed to catch
extra-SRCU-grace-period isseus.

Again, thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit d730d54e543e5cf7376ff61e3ad407490f08c85e
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jan 12 09:52:44 2022 -0800

    srcu: Tighten cleanup_srcu_struct() GP checks
    
    Currently, cleanup_srcu_struct() checks for a grace period in progress,
    but it does not check for a grace period that has not yet started but
    which might start at any time.  Such a situation could result in a
    use-after-free bug, so this commit adds a check for a grace period that
    is needed but not yet started to cleanup_srcu_struct().
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 128034f858897..c78391a5e20dc 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -382,9 +382,11 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 			return; /* Forgot srcu_barrier(), so just leak it! */
 	}
 	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
+	    WARN_ON(rcu_seq_current(&ssp->srcu_gp_seq) != ssp->srcu_gp_seq_needed) ||
 	    WARN_ON(srcu_readers_active(ssp))) {
-		pr_info("%s: Active srcu_struct %p state: %d\n",
-			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)));
+		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
+			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)),
+			rcu_seq_current(&ssp->srcu_gp_seq), ssp->srcu_gp_seq_needed);
 		return; /* Caller forgot to stop doing call_srcu()? */
 	}
 	free_percpu(ssp->sda);
