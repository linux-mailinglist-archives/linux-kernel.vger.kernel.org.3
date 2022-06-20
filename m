Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3212155134A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbiFTIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbiFTIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:50:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CCE12D05
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:50:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t25so16124456lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aORH+F9A3lVDL8oYX/qeIaZfQ9gEPRL7wZifmFpJLWg=;
        b=nh31U/C501CtniSos35VWwXeTq8PZlZ14OAJUyxe18rSyDRu0KdBJKwquKBzf/nXPl
         NT61mtH0dQqsxsysNR6DC1wDNT4xm6IeN0c3uptsga2V22ApkSVZqLlbS3WfsQa0PWJ0
         x+QPpgj+jvFKxoaWq9rvLVjjkxQO9RNdSdl4jQXvT07WG3ctfGHZiqQ7QcoG62IReuQa
         24DAsN/oo6ItzHF4E0DH5DH9WC+KyeooFTR3UeftUr6QbKuZUGVK52yEq5f97G3CrqDl
         aLf3DhVCetimcNJmDp98wXYYyQe60Z1UwxOG3BI6QbUEPoQr9To5W0LSnirQEmHDSLOS
         o5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aORH+F9A3lVDL8oYX/qeIaZfQ9gEPRL7wZifmFpJLWg=;
        b=cAfLV4Gln25R9ZeWKTYt2nbgNwc3EyzEs8GM1sRKyPV1cgVNOLZY+XJ1lH6WclbxCf
         TTR2UO5acJRkqvtSoUNIMI8aaEazwl09UJHLwNJrgthVoqjofPJOIGnNOacLzumLFNV8
         CJ2lLqMeFs6DXxDxijHPFrAnTsfLK3Js5l474gFTGliui20OvZzEPpdtp5CLGhWLUNVw
         vKHPvnxozZQ+n6/5Mh6k1/8KP1IPhSii2ZvngOb50J4U3RKQLzf1nbG/9L975Wdvyv47
         ahHKaLi0G1HF6f1fkLLA7M9y6hOnIqLZe4J/lv0T2C3+/3Fj4QvtQLZVud2BIm0mGBdw
         xLEg==
X-Gm-Message-State: AJIora/WAjP/EbiIb9u9roOyW4ggakIa1B6XBb5EDuOfw4xZtNw7IzKQ
        43u9HXa1zXnvCKbwVT4YC2Q7pPgLqEL8mKLAZsjaOw==
X-Google-Smtp-Source: AGRyM1v2ZbOiKUkpgfBS5LiCYpUWZQxg2hNNm7bfOcyACvMRtlQWi2ZiGITj7BVYZcwNRdIAQSDu7iY485bOe02MrqQ=
X-Received: by 2002:ac2:4f11:0:b0:479:3554:79d with SMTP id
 k17-20020ac24f11000000b004793554079dmr12913290lfr.417.1655715023225; Mon, 20
 Jun 2022 01:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d90a8005e1b7d62b@google.com> <YrAiNACivHyPXvSU@infradead.org>
In-Reply-To: <YrAiNACivHyPXvSU@infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Jun 2022 10:50:11 +0200
Message-ID: <CACT4Y+YmyOMq1exWFy2z9fqfXcrzxB8yvWEo9gcXHfiS+Oa4FQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in relay_open_buf
To:     Christoph Hellwig <hch@infradead.org>
Cc:     syzbot <syzbot+4fe838aeddc9710946ca@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/\/\/\/\/\/\/\/\/\/\/\/\On Mon, 20 Jun 2022 at 09:31, Christoph
Hellwig <hch@infradead.org> wrote:
>
> This looks pretty odd to me.  I can't really see anything that
> would cause an atomic context (spinlock, irq disabling) anywhere near
> blk_trace_ioctl.
>
> On Sat, Jun 18, 2022 at 05:16:23AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    6012273897fe Add linux-next specific files for 20220615
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16406cb0080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b4154677977b1776
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4fe838aeddc9710946ca
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+4fe838aeddc9710946ca@syzkaller.appspotmail.com
> >
> > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> > preempt_count: 1, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by syz-executor.5/10461:
> >  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> > Preemption disabled at:
> > [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> > [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> > [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293

/\/\/\/\/\/\/\/\/\/\/\/\

Maybe this is the unclosed left-over disable?


> > CPU: 0 PID: 10461 Comm: syz-executor.5 Not tainted 5.19.0-rc2-next-20220615-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
> >  might_alloc include/linux/sched/mm.h:274 [inline]
> >  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
> >  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
> >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
> >  relay_alloc_buf kernel/relay.c:124 [inline]
> >  relay_create_buf kernel/relay.c:165 [inline]
> >  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
> >  relay_open_buf kernel/relay.c:384 [inline]
> >  relay_open kernel/relay.c:520 [inline]
> >  relay_open+0x4fb/0xa00 kernel/relay.c:477
> >  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
> >  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
> >  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
> >  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f2933089109
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> > RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> > RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
> >  </TASK>
> > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> > preempt_count: 1, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by syz-executor.5/10461:
> >  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> > Preemption disabled at:
> > [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> > [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> > [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> > CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
> >  might_alloc include/linux/sched/mm.h:274 [inline]
> >  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
> >  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
> >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
> >  relay_alloc_buf kernel/relay.c:124 [inline]
> >  relay_create_buf kernel/relay.c:165 [inline]
> >  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
> >  relay_open_buf kernel/relay.c:384 [inline]
> >  relay_open kernel/relay.c:520 [inline]
> >  relay_open+0x4fb/0xa00 kernel/relay.c:477
> >  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
> >  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
> >  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
> >  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f2933089109
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> > RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> > RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
> >  </TASK>
> > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> > preempt_count: 1, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by syz-executor.5/10461:
> >  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> > Preemption disabled at:
> > [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> > [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> > [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> > CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
> >  might_alloc include/linux/sched/mm.h:274 [inline]
> >  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
> >  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
> >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
> >  relay_alloc_buf kernel/relay.c:124 [inline]
> >  relay_create_buf kernel/relay.c:165 [inline]
> >  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
> >  relay_open_buf kernel/relay.c:384 [inline]
> >  relay_open kernel/relay.c:520 [inline]
> >  relay_open+0x4fb/0xa00 kernel/relay.c:477
> >  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
> >  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
> >  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
> >  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f2933089109
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> > RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> > RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
> >  </TASK>
> > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> > preempt_count: 1, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by syz-executor.5/10461:
> >  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> > Preemption disabled at:
> > [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> > [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> > [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> > CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
> >  might_alloc include/linux/sched/mm.h:274 [inline]
> >  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
> >  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
> >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
> >  relay_alloc_buf kernel/relay.c:124 [inline]
> >  relay_create_buf kernel/relay.c:165 [inline]
> >  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
> >  relay_open_buf kernel/relay.c:384 [inline]
> >  relay_open kernel/relay.c:520 [inline]
> >  relay_open+0x4fb/0xa00 kernel/relay.c:477
> >  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
> >  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
> >  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
> >  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f2933089109
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> > RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> > RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
> >  </TASK>
> > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> > preempt_count: 2, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by syz-executor.5/10461:
> >  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> > Preemption disabled at:
> > [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> > [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> > [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> > CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
> >  might_alloc include/linux/sched/mm.h:274 [inline]
> >  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
> >  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
> >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
> >  relay_alloc_buf kernel/relay.c:124 [inline]
> >  relay_create_buf kernel/relay.c:165 [inline]
> >  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
> >  relay_open_buf kernel/relay.c:384 [inline]
> >  relay_open kernel/relay.c:520 [inline]
> >  relay_open+0x4fb/0xa00 kernel/relay.c:477
> >  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
> >  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
> >  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
> >  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f2933089109
> > Code: Unable to access opcode bytes at RIP 0x7f29330890df.
> > RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> > RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> > RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
> >  </TASK>
> > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> > preempt_count: 2, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by syz-executor.5/10461:
> >  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> > Preemption disabled at:
> > [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> > [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> > [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> > CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
> >  might_alloc include/linux/sched/mm.h:274 [inline]
> >  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
> >  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
> >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
> >  relay_alloc_buf kernel/relay.c:124 [inline]
> >  relay_create_buf kernel/relay.c:165 [inline]
> >  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
> >  relay_open_buf kernel/relay.c:384 [inline]
> >  relay_open kernel/relay.c:520 [inline]
> >  relay_open+0x4fb/0xa00 kernel/relay.c:477
> >  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
> >  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
> >  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
> >  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f2933089109
> > Code: Unable to access opcode bytes at RIP 0x7f29330890df.
> > RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> > RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> > RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
> >  </TASK>
> > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> > preempt_count: 2, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by syz-executor.5/10461:
> >  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> > Preemption disabled at:
> > [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> > [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> > [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> > CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
> >  might_alloc include/linux/sched/mm.h:274 [inline]
> >  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
> >  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
> >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
> >  relay_alloc_buf kernel/relay.c:124 [inline]
> >  relay_create_buf kernel/relay.c:165 [inline]
> >  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
> >  relay_open_buf kernel/relay.c:384 [inline]
> >  relay_open kernel/relay.c:520 [inline]
> >  relay_open+0x4fb/0xa00 kernel/relay.c:477
> >  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
> >  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
> >  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
> >  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f2933089109
> > Code: Unable to access opcode bytes at RIP 0x7f29330890df.
> > RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> > RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> > RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
> >  </TASK>
> > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> > preempt_count: 2, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by syz-executor.5/10461:
> >  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> > Preemption disabled at:
> > [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> > [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> > [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> > CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
> >  might_alloc include/linux/sched/mm.h:274 [inline]
> >  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
> >  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
> >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
> >  relay_alloc_buf kernel/relay.c:124 [inline]
> >  relay_create_buf kernel/relay.c:165 [inline]
> >  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
> >  relay_open_buf kernel/relay.c:384 [inline]
> >  relay_open kernel/relay.c:520 [inline]
> >  relay_open+0x4fb/0xa00 kernel/relay.c:477
> >  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
> >  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
> >  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
> >  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f2933089109
> > Code: Unable to access opcode bytes at RIP 0x7f29330890df.
> > RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> > RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> > RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
> >  </TASK>
> > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> > preempt_count: 2, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by syz-executor.5/10461:
> >  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> > Preemption disabled at:
> > [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> > [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> > [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> > CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
> >  might_alloc include/linux/sched/mm.h:274 [inline]
> >  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
> >  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
> >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
> >  relay_alloc_buf kernel/relay.c:124 [inline]
> >  relay_create_buf kernel/relay.c:165 [inline]
> >  relay_open_buf.part.0+0x2a7/0xc00 kernel/relay.c:387
> >  relay_open_buf kernel/relay.c:384 [inline]
> >  relay_open kernel/relay.c:520 [inline]
> >  relay_open+0x4fb/0xa00 kernel/relay.c:477
> >  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
> >  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
> >  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
> >  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f2933089109
> > Code: Unable to access opcode bytes at RIP 0x7f29330890df.
> > RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> > RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> > RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
> >  </TASK>
> > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> > preempt_count: 2, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by syz-executor.5/10461:
> >  #0: ffff888146a4f718 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xa9/0x270 kernel/trace/blktrace.c:735
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open kernel/relay.c:518 [inline]
> >  #1: ffffffff8bdee228 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x389/0xa00 kernel/relay.c:477
> > Preemption disabled at:
> > [<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> > [<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
> > [<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
> > CPU: 0 PID: 10461 Comm: syz-executor.5 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
> >  might_alloc include/linux/sched/mm.h:274 [inline]
> >  prepare_alloc_pages+0x3d8/0x570 mm/page_alloc.c:5290
> >  __alloc_pages+0x145/0x510 mm/page_alloc.c:5501
> >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
> >  __get_free_pages+0x8/0x40 mm/page_alloc.c:5561
> >  kasan_populate_vmalloc_pte mm/kasan/shadow.c:271 [inline]
> >  kasan_populate_vmalloc_pte+0x25/0x160 mm/kasan/shadow.c:262
> >  apply_to_pte_range mm/memory.c:2648 [inline]
> >  apply_to_pmd_range mm/memory.c:2692 [inline]
> >  apply_to_pud_range mm/memory.c:2728 [inline]
> >  apply_to_p4d_range mm/memory.c:2764 [inline]
> >  __apply_to_page_range+0x68c/0x1030 mm/memory.c:2798
> >  alloc_vmap_area+0xacf/0x1d30 mm/vmalloc.c:1625
> >  __get_vm_area_node+0x142/0x3f0 mm/vmalloc.c:2483
> >  get_vm_area_caller mm/vmalloc.c:2536 [inline]
> >  vmap+0x131/0x330 mm/vmalloc.c:2831
> >  relay_alloc_buf kernel/relay.c:129 [inline]
> >  relay_create_buf kernel/relay.c:165 [inline]
> >  relay_open_buf.part.0+0x4b2/0xc00 kernel/relay.c:387
> >  relay_open_buf kernel/relay.c:384 [inline]
> >  relay_open kernel/relay.c:520 [inline]
> >  relay_open+0x4fb/0xa00 kernel/relay.c:477
> >  do_blk_trace_setup+0x4bc/0xb60 kernel/trace/blktrace.c:559
> >  __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:599
> >  blk_trace_ioctl+0x13b/0x270 kernel/trace/blktrace.c:740
> >  blkdev_ioctl+0x181/0x800 block/ioctl.c:603
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f2933089109
> > Code: Unable to access opcode bytes at RIP 0x7f29330890df.
> > RSP: 002b:00007f2934150168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f293319bf60 RCX: 00007f2933089109
> > RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000003
> > RBP: 00007f29330e305d R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffe5646271f R14: 00007f2934150300 R15: 0000000000022000
> >  </TASK>
> > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10461, name: syz-executor.5
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> ---end quoted text---
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/YrAiNACivHyPXvSU%40infradead.org.
