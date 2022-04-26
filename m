Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6306A510577
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347916AbiDZRg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiDZRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D921457A5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FD0D6168F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A73C385A4;
        Tue, 26 Apr 2022 17:33:15 +0000 (UTC)
Date:   Tue, 26 Apr 2022 13:33:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     syzbot <syzbot+7cc6f78de62bf22bda9c@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in ring_buffer_lock_reserve
Message-ID: <20220426133314.09661e25@gandalf.local.home>
In-Reply-To: <000000000000469c2805dd9181e9@google.com>
References: <000000000000469c2805dd9181e9@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 09:51:32 -0700
syzbot <syzbot+7cc6f78de62bf22bda9c@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c00c5e1d157b Merge tag 'ext4_for_linus_stable' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16c71798f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d1843173f299d1e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=7cc6f78de62bf22bda9c
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7cc6f78de62bf22bda9c@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> Delta way too big! 8384096949562536641 ts=8384098609305280746 before=1659742744105 after=1659742744105 write stamp=8384098609305280746

Looks like something in the test messed with the timestamp. As it went
from 1659742744105 to 8384096949562536641, even for nanoseconds, that is a
delta of 265 years!


And looking at the console output, it looks like something happened because
even that shows:

[ 3577.088716][T18453] GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog
[ 3577.088716][T18453] GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog
[ 3577.088716][T17423] GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog

[..]

[8384098609.310217][T18453] GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog
[8384098609.310217][T19083] overlayfs: conflicting lowerdir path
[8384098609.310217][T18453] GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog
[8384098609.310217][T18453] GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog

And yes, if you change the time stamp between two events that use deltas
between them, it will cause this warning. That's a feature not a bug.

-- Steve



> WARNING: CPU: 0 PID: 19417 at kernel/trace/ring_buffer.c:2744 rb_check_timestamp+0x129/0x130 kernel/trace/ring_buffer.c:2734
> Modules linked in:
> CPU: 0 PID: 19417 Comm: syz-executor.2 Tainted: G S                5.18.0-rc3-syzkaller-00190-gc00c5e1d157b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:rb_check_timestamp+0x129/0x130 kernel/trace/ring_buffer.c:2734
> Code: e8 91 8a 48 0f 44 e8 48 c7 c7 e0 ea 91 8a 48 8b 34 24 4c 89 fa 4c 89 e9 4d 89 f0 49 89 d9 31 c0 55 e8 5b 17 c6 ff 48 83 c4 08 <0f> 0b e9 f4 fe ff ff 55 41 57 41 56 41 55 41 54 53 48 83 ec 58 49
> RSP: 0018:ffffc90002bef798 EFLAGS: 00010082
> RAX: 45645b4ce4a40800 RBX: 745a4d43a97ce0ea RCX: 0000000000040000
> RDX: ffffc9000bb08000 RSI: 000000000000adf6 RDI: 000000000000adf7
> RBP: ffffffff8a91e8e0 R08: ffffffff816ac162 R09: ffffed1017344f24
> R10: ffffed1017344f24 R11: 1ffff11017344f23 R12: ffff888011468930
> R13: 0000018270606e29 R14: 0000018270606e29 R15: 745a4d43a97ce0ea
> FS:  00007ff57856c700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff57759d090 CR3: 0000000073001000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  rb_add_timestamp+0x324/0x520 kernel/trace/ring_buffer.c:2772
>  rb_update_event kernel/trace/ring_buffer.c:2809 [inline]
>  __rb_reserve_next kernel/trace/ring_buffer.c:3565 [inline]
>  rb_reserve_next_event kernel/trace/ring_buffer.c:3635 [inline]
>  ring_buffer_lock_reserve+0x10df/0x22a0 kernel/trace/ring_buffer.c:3694
>  __trace_buffer_lock_reserve kernel/trace/trace.c:949 [inline]
>  trace_event_buffer_lock_reserve+0xd8/0x6a0 kernel/trace/trace.c:2821
>  trace_event_buffer_reserve+0x2ae/0x3d0 kernel/trace/trace_events.c:496
>  trace_event_raw_event_bpf_trace_printk+0xfd/0x210 kernel/trace/./bpf_trace.h:11
>  trace_bpf_trace_printk+0x1c8/0x210 kernel/trace/./bpf_trace.h:11
>  ____bpf_trace_printk kernel/trace/bpf_trace.c:388 [inline]
>  bpf_trace_printk+0x194/0x200 kernel/trace/bpf_trace.c:371
>  bpf_prog_0605f9f479290f07+0x2f/0x33
>  bpf_dispatcher_nop_func include/linux/bpf.h:804 [inline]
>  __bpf_prog_run include/linux/filter.h:628 [inline]
>  bpf_prog_run include/linux/filter.h:635 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2022 [inline]
>  bpf_trace_run2+0x18a/0x320 kernel/trace/bpf_trace.c:2059
>  __bpf_trace_sys_exit+0x60/0x70 include/trace/events/syscalls.h:44
>  trace_sys_exit+0xb2/0xd0 include/trace/events/syscalls.h:44
>  syscall_exit_work+0x4a/0xe0 kernel/entry/common.c:245
>  syscall_exit_to_user_mode_prepare+0x62/0x80 kernel/entry/common.c:276
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
>  syscall_exit_to_user_mode+0xa/0x70 kernel/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7ff5774890e9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ff57856c168 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: 0000000000000004 RBX: 00007ff57759bf60 RCX: 00007ff5774890e9
> RDX: 0000000000000010 RSI: 0000000020000180 RDI: 0000000000000011
> RBP: 00007ff5774e308d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5033831f R14: 00007ff57856c300 R15: 0000000000022000
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

