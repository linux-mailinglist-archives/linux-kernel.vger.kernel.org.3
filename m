Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941CD553EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354534AbiFUWlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354673AbiFUWlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:41:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799F2326D1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CD25ECE1C1D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 22:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA80C3411C;
        Tue, 21 Jun 2022 22:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655851305;
        bh=0oB16qRCrLiUJ4H2+CN0kCYVAVZG/1VaNpHQtdm6bOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5i7uYLjNi0kmF6NokFWm44kHT3BSXu8Pg+EtbYEr6Xg2KRs5LXeiWrTAfIMc89F6
         y6a0TQ1CIaQo1T45LZHioITAKoSqTS/cqiLp67lsYc6Bi3HvcJaoVqrtCZ+PqeKZ15
         3i8P4QPtYRKVbIaJ/ooGudL+C4EjCe0CgLWYX/bgV//aKlb7y4s9l7q1ZVv4Rn5jOD
         dOG025dMkGiSzLd0si2WQSOZHin9394Bb9QcW6+T2eiGoju6dYun7YYKq2rP5WzoGt
         jZrrz0R8TGohG+WmbO+jj/isDhCNVEp9ncCgRZfsUclFgyOL4U28LCDjq4oWfVGwgv
         XXkkzeEYWj3vA==
Date:   Wed, 22 Jun 2022 00:41:40 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [syzbot] memory leak in setup_mq_sysctls
Message-ID: <YrJJJMQa1qAspI/J@example.org>
References: <000000000000f5004705e1db8bad@google.com>
 <YrGVYfPINRobj+cF@example.org>
 <8735fyhyvy.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735fyhyvy.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:30:57AM -0500, Eric W. Biederman wrote:
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> 
> > On Sun, Jun 19, 2022 at 11:52:25PM -0700, syzbot wrote:
> >> Hello,
> >> 
> >> syzbot found the following issue on:
> >> 
> >> HEAD commit:    979086f5e006 Merge tag 'fs.fixes.v5.19-rc3' of git://git.k..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1284331bf00000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=c696a83383a77f81
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=b4b0d1b35442afbf6fd2
> >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163e740ff00000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132b758bf00000
> >> 
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com
> >
> > I'm working on a fix that will remove this memory allocation entirely.
> 
> Hmm. The memory should be freed when the corresponding namespace exits.
> I see retire_mq_sysctls is being called to free this memory.  Alex do
> you see any leaks when you read that code?

I don't see a leak either. retire_mq_sysctls and retire_ipc_sysctls
functions are identical and are called one by one. I don't understand how
there can be an mq leak without an ipc leak. Unless it has something to do
with mq_init_ns (just guess).

> So it looks like either someone broke this in linux-next or there
> is a bug in the memory leak detector, or something truly strange
> like a memory stop is going on.

I will take a look.

> I don't see any changes to the ipc subdirectory since v5.19-rc1 in
> commit 979086f5e006 ("Merge tag 'fs.fixes.v5.19-rc3' of git://git.k.." )
> so the idea that the code is broken in linux-next is out.
> 
> Which leaves the memory leak detector having trouble with this,
> or something like a memory stomp is causing problems.
> 
> Catalin is it possible that the clever use of ctl_table_arg to hold the
> reference to the table before it is freed is confusing the memory leak
> detector?  The idiom is old enough I don't expect so, but I have seen
> bugs lurk for a long time.
> 
> Which leaves just a memory stomp or something even stranger in the code.
> syzkaller can you reproduce this on Linus's branch?
> 
> Eric
> 
> >> executing program
> >> BUG: memory leak
> >> unreferenced object 0xffff888112fc9200 (size 512):
> >>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
> >>   hex dump (first 32 bytes):
> >>     ef d3 60 85 ff ff ff ff 0c 9b d2 12 81 88 ff ff  ..`.............
> >>     04 00 00 00 a4 01 00 00 00 00 00 00 00 00 00 00  ................
> >>   backtrace:
> >>     [<ffffffff814b6eb3>] kmemdup+0x23/0x50 mm/util.c:129
> >>     [<ffffffff82219a9b>] kmemdup include/linux/fortify-string.h:456 [inline]
> >>     [<ffffffff82219a9b>] setup_mq_sysctls+0x4b/0x1c0 ipc/mq_sysctl.c:89
> >>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
> >>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
> >>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
> >>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
> >>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
> >>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
> >>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
> >>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
> >>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >> 
> >> BUG: memory leak
> >> unreferenced object 0xffff888112fd5f00 (size 256):
> >>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
> >>   hex dump (first 32 bytes):
> >>     00 92 fc 12 81 88 ff ff 00 00 00 00 01 00 00 00  ................
> >>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>   backtrace:
> >>     [<ffffffff816fea1b>] kmalloc include/linux/slab.h:605 [inline]
> >>     [<ffffffff816fea1b>] kzalloc include/linux/slab.h:733 [inline]
> >>     [<ffffffff816fea1b>] __register_sysctl_table+0x7b/0x7f0 fs/proc/proc_sysctl.c:1344
> >>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
> >>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
> >>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
> >>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
> >>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
> >>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
> >>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
> >>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
> >>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
> >>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >> 
> >> BUG: memory leak
> >> unreferenced object 0xffff888112fbba00 (size 256):
> >>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
> >>   hex dump (first 32 bytes):
> >>     78 ba fb 12 81 88 ff ff 00 00 00 00 01 00 00 00  x...............
> >>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>   backtrace:
> >>     [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
> >>     [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
> >>     [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
> >>     [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
> >>     [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
> >>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
> >>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
> >>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
> >>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
> >>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
> >>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
> >>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
> >>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
> >>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
> >>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >> 
> >> BUG: memory leak
> >> unreferenced object 0xffff888112fbb900 (size 256):
> >>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
> >>   hex dump (first 32 bytes):
> >>     78 b9 fb 12 81 88 ff ff 00 00 00 00 01 00 00 00  x...............
> >>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>   backtrace:
> >>     [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
> >>     [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
> >>     [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
> >>     [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
> >>     [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
> >>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
> >>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
> >>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
> >>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
> >>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
> >>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
> >>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
> >>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
> >>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
> >>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >> 
> >> 
> >> 
> >> ---
> >> This report is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >> 
> >> syzbot will keep track of this issue. See:
> >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >> syzbot can test patches for this issue, for details see:
> >> https://goo.gl/tpsmEJ#testing-patches
> >> 
> 

-- 
Rgrds, legion

