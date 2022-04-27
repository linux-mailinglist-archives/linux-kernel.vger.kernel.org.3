Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4310551126E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358809AbiD0HcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353070AbiD0HcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:32:03 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2EF75E54
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:28:52 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e656032735so1146244fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xe8FABuG8EBRzlFuZqxkJTn034eQBQGks3jMhPh7wU0=;
        b=oRoQu1v3mQQmePsMZEVxp7Se5dy1lY+mPaUeXqXJyNpSf4+iGKVtxSskHDN5Giw2NU
         R6sMdhgfQLwSEtScgJPN08b9MseWpNLYomNMY3HHErQwWfb2N4pG5CJ5ZVFk6P3iQL+d
         CqbU1C49FYcQ7edlS7s/eIM9+qQBCT1IN/CwdHBhcW/Qeyky+X057U6QrsJAxdAu1F7w
         PdTxTRh6989fki4M2YMC/JvGJVjYZ0zgz7gj0yz1Keb0eiLTvZg8NjosLpE1N891TbpZ
         Yi4Aqkyt610Gnh3BOY4ssHIblshWuQ83/QG6H3VDU60syCw4J2K9x9mEiJqTRIrO3MLX
         8SWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xe8FABuG8EBRzlFuZqxkJTn034eQBQGks3jMhPh7wU0=;
        b=xFjJea3BaJNfmycidb9XuJifH3n/4iaK3MglQ9mbMFltA+puvUbo4NCObNHl34zdnf
         9+WWW5O/7fJgHxs7Fo0miqgGpj/fvMSFE5KpzqBc5ueGwbAmttCgFH8Ckj2hwt7ourDY
         ZJTSrUcGDuDW3gzKDvo37mkhgQeYgVCrKxwpBzSJBu6Zi8LBERVygwHt1rMGfYNVtIDp
         BgVgQBBNX6p+fe2SMleODAzZww4f+83AkeOWzh4ARG4y2FCU3zo/8BOK1bhYh4mhPnCw
         uB7StPYXu/c+chk/94WXiR/iuHOyiB5q69qwYyueTq7LhGcG+ipTBP2W0KZn3Oq19uHW
         BEZw==
X-Gm-Message-State: AOAM530M6auVQFERqHkQVlbsy1uhXzYzUN05VLH934e7EBzvRel9uJPN
        WoA3Y5JZO/CbybvPswDHCiuOXL58ykKyRg/mHoJB3A==
X-Google-Smtp-Source: ABdhPJwwYR7NgOQNocsejBispVE1Kqcoztn5bXoZLGNsKdRG5tw97+WV6PHzsn9i9ZpX2h2zvQGRSJEGZOxFhxYINXg=
X-Received: by 2002:a05:6870:d254:b0:db:12b5:da3 with SMTP id
 h20-20020a056870d25400b000db12b50da3mr15320744oac.211.1651044532032; Wed, 27
 Apr 2022 00:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000469c2805dd9181e9@google.com> <20220426133314.09661e25@gandalf.local.home>
In-Reply-To: <20220426133314.09661e25@gandalf.local.home>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Apr 2022 09:28:40 +0200
Message-ID: <CACT4Y+a-mZRFF_56hiB5wLZKL9obVxDT8NXi1maAZZcMiOfryg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in ring_buffer_lock_reserve
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     syzbot <syzbot+7cc6f78de62bf22bda9c@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 at 19:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Apr 2022 09:51:32 -0700
> syzbot <syzbot+7cc6f78de62bf22bda9c@syzkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    c00c5e1d157b Merge tag 'ext4_for_linus_stable' of git://gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16c71798f00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d1843173f299d1e8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7cc6f78de62bf22bda9c
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+7cc6f78de62bf22bda9c@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > Delta way too big! 8384096949562536641 ts=8384098609305280746 before=1659742744105 after=1659742744105 write stamp=8384098609305280746
>
> Looks like something in the test messed with the timestamp. As it went
> from 1659742744105 to 8384096949562536641, even for nanoseconds, that is a
> delta of 265 years!
>
>
> And looking at the console output, it looks like something happened because
> even that shows:
>
> [ 3577.088716][T18453] GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog
> [ 3577.088716][T18453] GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog
> [ 3577.088716][T17423] GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog
>
> [..]
>
> [8384098609.310217][T18453] GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog
> [8384098609.310217][T19083] overlayfs: conflicting lowerdir path
> [8384098609.310217][T18453] GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog
> [8384098609.310217][T18453] GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog
>
> And yes, if you change the time stamp between two events that use deltas
> between them, it will cause this warning. That's a feature not a bug.

syzkaller recently learned how to write into /dev/cpu/n/msr bypassing
all restrictions.
This looks like it may be caused by a timestamp MSR update.
syzbot will not use msr.allow_writes=off command line argument:
https://github.com/google/syzkaller/commit/0ede5bfc57b8910f6436a23955422fae109636c2
It should prevent such writes.

Thanks for looking into this.

#syz invalid



> > WARNING: CPU: 0 PID: 19417 at kernel/trace/ring_buffer.c:2744 rb_check_timestamp+0x129/0x130 kernel/trace/ring_buffer.c:2734
> > Modules linked in:
> > CPU: 0 PID: 19417 Comm: syz-executor.2 Tainted: G S                5.18.0-rc3-syzkaller-00190-gc00c5e1d157b #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:rb_check_timestamp+0x129/0x130 kernel/trace/ring_buffer.c:2734
> > Code: e8 91 8a 48 0f 44 e8 48 c7 c7 e0 ea 91 8a 48 8b 34 24 4c 89 fa 4c 89 e9 4d 89 f0 49 89 d9 31 c0 55 e8 5b 17 c6 ff 48 83 c4 08 <0f> 0b e9 f4 fe ff ff 55 41 57 41 56 41 55 41 54 53 48 83 ec 58 49
> > RSP: 0018:ffffc90002bef798 EFLAGS: 00010082
> > RAX: 45645b4ce4a40800 RBX: 745a4d43a97ce0ea RCX: 0000000000040000
> > RDX: ffffc9000bb08000 RSI: 000000000000adf6 RDI: 000000000000adf7
> > RBP: ffffffff8a91e8e0 R08: ffffffff816ac162 R09: ffffed1017344f24
> > R10: ffffed1017344f24 R11: 1ffff11017344f23 R12: ffff888011468930
> > R13: 0000018270606e29 R14: 0000018270606e29 R15: 745a4d43a97ce0ea
> > FS:  00007ff57856c700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ff57759d090 CR3: 0000000073001000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  rb_add_timestamp+0x324/0x520 kernel/trace/ring_buffer.c:2772
> >  rb_update_event kernel/trace/ring_buffer.c:2809 [inline]
> >  __rb_reserve_next kernel/trace/ring_buffer.c:3565 [inline]
> >  rb_reserve_next_event kernel/trace/ring_buffer.c:3635 [inline]
> >  ring_buffer_lock_reserve+0x10df/0x22a0 kernel/trace/ring_buffer.c:3694
> >  __trace_buffer_lock_reserve kernel/trace/trace.c:949 [inline]
> >  trace_event_buffer_lock_reserve+0xd8/0x6a0 kernel/trace/trace.c:2821
> >  trace_event_buffer_reserve+0x2ae/0x3d0 kernel/trace/trace_events.c:496
> >  trace_event_raw_event_bpf_trace_printk+0xfd/0x210 kernel/trace/./bpf_trace.h:11
> >  trace_bpf_trace_printk+0x1c8/0x210 kernel/trace/./bpf_trace.h:11
> >  ____bpf_trace_printk kernel/trace/bpf_trace.c:388 [inline]
> >  bpf_trace_printk+0x194/0x200 kernel/trace/bpf_trace.c:371
> >  bpf_prog_0605f9f479290f07+0x2f/0x33
> >  bpf_dispatcher_nop_func include/linux/bpf.h:804 [inline]
> >  __bpf_prog_run include/linux/filter.h:628 [inline]
> >  bpf_prog_run include/linux/filter.h:635 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2022 [inline]
> >  bpf_trace_run2+0x18a/0x320 kernel/trace/bpf_trace.c:2059
> >  __bpf_trace_sys_exit+0x60/0x70 include/trace/events/syscalls.h:44
> >  trace_sys_exit+0xb2/0xd0 include/trace/events/syscalls.h:44
> >  syscall_exit_work+0x4a/0xe0 kernel/entry/common.c:245
> >  syscall_exit_to_user_mode_prepare+0x62/0x80 kernel/entry/common.c:276
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
> >  syscall_exit_to_user_mode+0xa/0x70 kernel/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7ff5774890e9
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ff57856c168 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: 0000000000000004 RBX: 00007ff57759bf60 RCX: 00007ff5774890e9
> > RDX: 0000000000000010 RSI: 0000000020000180 RDI: 0000000000000011
> > RBP: 00007ff5774e308d R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffe5033831f R14: 00007ff57856c300 R15: 0000000000022000
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20220426133314.09661e25%40gandalf.local.home.
