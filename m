Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B467D547BF6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 22:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiFLUWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiFLUWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 16:22:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02D520BCC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 13:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69B8A610AB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2120C34115;
        Sun, 12 Jun 2022 20:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655065324;
        bh=PIqp4j1tUAqwb8hJ355YY5uk1Z2g/5fIYR7ufySGDW4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=j6BdEh1KlWZEzKcSZS9OFTbyjZbn9O6VX/IaV9N/VFyKkGJu9a8VMwr+FDFDYG3tU
         fwZlT0omkChApWNQmgmgUlnzDfI3yehbWjhdnHIIBXCxk1LWVfVHmI8Bgewg3CAT7Z
         yvq02O71pGxuZa/SqovUm+s+4WQ3dHq2KV/aTtjvjuCuglMgdZwWkJQVGJaux3Gzes
         VpKGT/AaZG21kDHGEEcawN4oqdYylHF6RGgOGZivar2CZV14817vveeaBf3DzbffGi
         fSxD0F0duk6W+2K1GWgI6A0uTS0Ly/4ZXwQxiwnU+yVFQQDwga5xsEqC72E+5TfYgk
         159HL1/ASxFfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 521CA5C0266; Sun, 12 Jun 2022 13:22:04 -0700 (PDT)
Date:   Sun, 12 Jun 2022 13:22:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>,
        brauner@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in exit_tasks_rcu_finish
Message-ID: <20220612202204.GX1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <000000000000e2fc3f05e141f930@google.com>
 <87bkux1yn4.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkux1yn4.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 02:15:43PM -0500, Eric W. Biederman wrote:
> syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com> writes:
> 
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    6d0c80680317 Add linux-next specific files for 20220610
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13b52c2ff00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9bb26e7c5e8e4fa7e641
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> 
> I don't understand what is going on in linux-next kernel/rcu/tasks.h
> looks different than in Linus's tree.  Paul does that mean you have
> some staged rcu changes?

Less than 100 RCU-related patches in -rcu, so not all that bad.  ;-)

But yes, this could possibly be an issue in one of those patches.

> Eric
> 
> 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664 exit_tasks_rcu_finish_trace kernel/rcu/tasks.h:1664 [inline]
> > WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664 exit_tasks_rcu_finish+0x122/0x1b0 kernel/rcu/tasks.h:1006

The usual way for this warning to trigger is for these a task to exit
while in an RCU Tasks Trace read-side critical section:

	rcu_read_lock_trace();
	do_something_that_causes_task_exit();

> > Modules linked in:
> > CPU: 1 PID: 28639 Comm: syz-executor.3 Not tainted 5.19.0-rc1-next-20220610-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:exit_tasks_rcu_finish_trace kernel/rcu/tasks.h:1664 [inline]
> > RIP: 0010:exit_tasks_rcu_finish+0x122/0x1b0 kernel/rcu/tasks.h:1006
> > Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 62 0f b6 85 89 04 00 00 83 e0 01 08 d8 74 0e <0f> 0b 5b 48 89 ef 5d 41 5c e9 00 d2 ff ff 48 b8 00 00 00 00 00 fc
> > RSP: 0018:ffffc9000a497b58 EFLAGS: 00010202
> > RAX: 0000000000000001 RBX: 0000000000000201 RCX: 1ffff11004213b89
> > RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88802109dc49
> > RBP: ffff88802109d7c0 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000001 R12: ffff88802109dc40
> > R13: dffffc0000000000 R14: ffff88802109d7c0 R15: ffff88802109ddd0
> > FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f771379d090 CR3: 0000000051fd2000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  do_exit+0x18f2/0x2a00 kernel/exit.c:844
> >  do_group_exit+0xd2/0x2f0 kernel/exit.c:925
> >  get_signal+0x2542/0x2600 kernel/signal.c:2857

And in this case, the do_something_that_causes_task_exit() might
be reception of a fatal signal...

> >  arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
> >  exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
> >  exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
> >  syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294

...but it is also impolite to exit to usermode while in an RCU Tasks
read-side critical section.

It looks like this kernel was built with CONFIG_PROVE_LOCKING=y,
which should have complained if someone was exiting to userspace
while in an RCU Tasks Trace read-side critical section.

So, was there tracing of any kind in use during this test?

							Thanx, Paul

> >  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f7713689109
> > Code: Unable to access opcode bytes at RIP 0x7f77136890df.
> > RSP: 002b:00007f77125fe218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> > RAX: 0000000000000001 RBX: 00007f771379bf68 RCX: 00007f7713689109
> > RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f771379bf6c
> > RBP: 00007f771379bf60 R08: 00007fff2278d080 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f771379bf6c
> > R13: 00007fff22724c8f R14: 00007f77125fe300 R15: 0000000000022000
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
