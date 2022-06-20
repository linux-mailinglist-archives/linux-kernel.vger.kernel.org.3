Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42485551188
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbiFTHbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiFTHbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:31:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F74EE29;
        Mon, 20 Jun 2022 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bgxTsD/B5HivoCPJ+6tCPHuAzzjouvx8SURS6XsGWd8=; b=ppW+QiT8+h3+z4R7HRhkGKKurD
        +PxpPFwubcoCYK3uvh/ImZvFCrcrujrqD0k2OfJOy8R+TN1bFNfCb1QACGRFdrm5GSrUMDBULck0b
        arkuRQSzT7IJ/UIhjBwba9xQS30Tm2ou7v8i0BRV4ybwMCUPtx2Jir669J9n2Wfr5mXe6czfb6Q0B
        2BDPhPN88PqB+oqQS5H88IT/cFgGEI6P7TU5atE+UhcMcbbPPprQdrOHYiroitHjZf16jCGye0VV6
        pt3KdgJuYY3HDCGLId1n58e/t2vYFQqvRamwnBF3TzYrq0ATRI3gPkIi0JHfa1akihmFIo0Kcydx0
        Z0tCTk+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3BsC-00GgG2-EP; Mon, 20 Jun 2022 07:31:00 +0000
Date:   Mon, 20 Jun 2022 00:31:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     syzbot <syzbot+4fe838aeddc9710946ca@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 relay_open_buf
Message-ID: <YrAiNACivHyPXvSU@infradead.org>
References: <000000000000d90a8005e1b7d62b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d90a8005e1b7d62b@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks pretty odd to me.  I can't really see anything that
would cause an atomic context (spinlock, irq disabling) anywhere near
blk_trace_ioctl.

On Sat, Jun 18, 2022 at 05:16:23AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6012273897fe Add linux-next specific files for 20220615
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16406cb0080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b4154677977b1776
> dashboard link: https://syzkaller.appspot.com/bug?extid=4fe838aeddc9710946ca
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4fe838aeddc9710946ca@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz-executor.5/10461:
>  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> Preemption disabled at:
> [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> CPU: 0 PID: 10461 Comm: syz-executor.5 Not tainted 5.19.0-rc2-next-20220615-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
>  might_alloc include/linux/sched/mm.h:274 [inline]
>  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
>  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
>  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
>  relay_alloc_buf kernel/relay.c:124 [inline]
>  relay_create_buf kernel/relay.c:165 [inline]
>  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
>  relay_open_buf kernel/relay.c:384 [inline]
>  relay_open kernel/relay.c:520 [inline]
>  relay_open+0x4fb/0xa00 kernel/relay.c:477
>  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
>  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
>  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
>  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f2933089109
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
>  </TASK>
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz-executor.5/10461:
>  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> Preemption disabled at:
> [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
>  might_alloc include/linux/sched/mm.h:274 [inline]
>  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
>  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
>  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
>  relay_alloc_buf kernel/relay.c:124 [inline]
>  relay_create_buf kernel/relay.c:165 [inline]
>  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
>  relay_open_buf kernel/relay.c:384 [inline]
>  relay_open kernel/relay.c:520 [inline]
>  relay_open+0x4fb/0xa00 kernel/relay.c:477
>  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
>  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
>  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
>  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f2933089109
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
>  </TASK>
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz-executor.5/10461:
>  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> Preemption disabled at:
> [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
>  might_alloc include/linux/sched/mm.h:274 [inline]
>  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
>  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
>  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
>  relay_alloc_buf kernel/relay.c:124 [inline]
>  relay_create_buf kernel/relay.c:165 [inline]
>  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
>  relay_open_buf kernel/relay.c:384 [inline]
>  relay_open kernel/relay.c:520 [inline]
>  relay_open+0x4fb/0xa00 kernel/relay.c:477
>  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
>  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
>  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
>  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f2933089109
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
>  </TASK>
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz-executor.5/10461:
>  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> Preemption disabled at:
> [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
>  might_alloc include/linux/sched/mm.h:274 [inline]
>  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
>  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
>  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
>  relay_alloc_buf kernel/relay.c:124 [inline]
>  relay_create_buf kernel/relay.c:165 [inline]
>  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
>  relay_open_buf kernel/relay.c:384 [inline]
>  relay_open kernel/relay.c:520 [inline]
>  relay_open+0x4fb/0xa00 kernel/relay.c:477
>  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
>  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
>  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
>  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f2933089109
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
>  </TASK>
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> preempt_count: 2, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz-executor.5/10461:
>  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> Preemption disabled at:
> [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
>  might_alloc include/linux/sched/mm.h:274 [inline]
>  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
>  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
>  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
>  relay_alloc_buf kernel/relay.c:124 [inline]
>  relay_create_buf kernel/relay.c:165 [inline]
>  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
>  relay_open_buf kernel/relay.c:384 [inline]
>  relay_open kernel/relay.c:520 [inline]
>  relay_open+0x4fb/0xa00 kernel/relay.c:477
>  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
>  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
>  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
>  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f2933089109
> Code: Unable to access opcode bytes at RIP 0x7f29330890df.
> RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
>  </TASK>
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> preempt_count: 2, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz-executor.5/10461:
>  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> Preemption disabled at:
> [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
>  might_alloc include/linux/sched/mm.h:274 [inline]
>  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
>  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
>  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
>  relay_alloc_buf kernel/relay.c:124 [inline]
>  relay_create_buf kernel/relay.c:165 [inline]
>  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
>  relay_open_buf kernel/relay.c:384 [inline]
>  relay_open kernel/relay.c:520 [inline]
>  relay_open+0x4fb/0xa00 kernel/relay.c:477
>  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
>  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
>  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
>  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f2933089109
> Code: Unable to access opcode bytes at RIP 0x7f29330890df.
> RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
>  </TASK>
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> preempt_count: 2, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz-executor.5/10461:
>  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> Preemption disabled at:
> [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
>  might_alloc include/linux/sched/mm.h:274 [inline]
>  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
>  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
>  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
>  relay_alloc_buf kernel/relay.c:124 [inline]
>  relay_create_buf kernel/relay.c:165 [inline]
>  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
>  relay_open_buf kernel/relay.c:384 [inline]
>  relay_open kernel/relay.c:520 [inline]
>  relay_open+0x4fb/0xa00 kernel/relay.c:477
>  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
>  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
>  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
>  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f2933089109
> Code: Unable to access opcode bytes at RIP 0x7f29330890df.
> RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
>  </TASK>
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> preempt_count: 2, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz-executor.5/10461:
>  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> Preemption disabled at:
> [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
>  might_alloc include/linux/sched/mm.h:274 [inline]
>  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
>  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
>  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
>  relay_alloc_buf kernel/relay.c:124 [inline]
>  relay_create_buf kernel/relay.c:165 [inline]
>  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
>  relay_open_buf kernel/relay.c:384 [inline]
>  relay_open kernel/relay.c:520 [inline]
>  relay_open+0x4fb/0xa00 kernel/relay.c:477
>  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
>  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
>  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
>  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f2933089109
> Code: Unable to access opcode bytes at RIP 0x7f29330890df.
> RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
>  </TASK>
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> preempt_count: 2, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz-executor.5/10461:
>  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> Preemption disabled at:
> [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
>  might_alloc include/linux/sched/mm.h:274 [inline]
>  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
>  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
>  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
>  relay_alloc_buf kernel/relay.c:124 [inline]
>  relay_create_buf kernel/relay.c:165 [inline]
>  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
>  relay_open_buf kernel/relay.c:384 [inline]
>  relay_open kernel/relay.c:520 [inline]
>  relay_open+0x4fb/0xa00 kernel/relay.c:477
>  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
>  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
>  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
>  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f2933089109
> Code: Unable to access opcode bytes at RIP 0x7f29330890df.
> RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
>  </TASK>
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> preempt_count: 2, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz-executor.5/10461:
>  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
>  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> Preemption disabled at:
> [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
>  might_alloc include/linux/sched/mm.h:274 [inline]
>  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
>  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
>  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
>  __get_free_pages+0x8/0x40 mm/page_alloc.c:5561
>  kasan_populate_vmalloc_pte mm/kasan/shadow.c:271 [inline]
>  kasan_populate_vmalloc_pte+0x25/0x160 mm/kasan/shadow.c:262
>  apply_to_pte_range mm/memory.c:2648 [inline]
>  apply_to_pmd_range mm/memory.c:2692 [inline]
>  apply_to_pud_range mm/memory.c:2728 [inline]
>  apply_to_p4d_range mm/memory.c:2764 [inline]
>  __apply_to_page_range+0x68c/0x1030 mm/memory.c:2798
>  alloc_vmap_area+0xacf/0x1d30 mm/vmalloc.c:1625
>  __get_vm_area_node+0x142/0x3f0 mm/vmalloc.c:2483
>  get_vm_area_caller mm/vmalloc.c:2536 [inline]
>  vmap+0x131/0x330 mm/vmalloc.c:2831
>  relay_alloc_buf kernel/relay.c:129 [inline]
>  relay_create_buf kernel/relay.c:165 [inline]
>  relay_open_buf.part.0+0x4b2/0xc00 kernel/relay.c:387
>  relay_open_buf kernel/relay.c:384 [inline]
>  relay_open kernel/relay.c:520 [inline]
>  relay_open+0x4fb/0xa00 kernel/relay.c:477
>  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
>  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
>  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
>  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f2933089109
> Code: Unable to access opcode bytes at RIP 0x7f29330890df.
> RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
>  </TASK>
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
---end quoted text---
