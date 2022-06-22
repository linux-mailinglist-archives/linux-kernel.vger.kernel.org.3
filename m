Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE28F554414
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353500AbiFVHj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350702AbiFVHjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:39:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122A81147
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:39:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a2so26338442lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpoFW+roLjNkfVzi27lotcXGbUONBYrO8j5K1bb79oY=;
        b=kbCMinHOHgJ+dY7rP49xrxv17YR3b4E3lNHnF25ix/0UcD5RTbhhbbuTleAnphBnuy
         1QbJaLTFNanF6zG/XcV4fUks+L6DG+iAbYh4Qt26UPtukymJA8KMxtG1C4uwMJdCC/SC
         ZTFBw5A84FJdM+UljGYp6ZraFaTPuLj+Gbzdn9fsvanvrDxt6PEkg27XvuWQA3wadMAs
         uPZS3dZK1PC4UCLsfRw2lNSO2DgZcphU/bc6/1G6Tm+GUiETuHgT6opppEoLBPbvfzgf
         0JkmXJAuOKbe22KaUQJaqC/9ELamJo7mrgkTn2mKhDTlve1cqmppv1mJ0XDaN/f0UfNL
         Sjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpoFW+roLjNkfVzi27lotcXGbUONBYrO8j5K1bb79oY=;
        b=3drsWBCdfwycjWad6wHOCqEasL3vJsvmmUHBK7emK/VggdwDJy2K3wwoQGlPNCkMJl
         AbHWZ1BY8nB2nXhyjpTJXpQ4yL8n47xxFDlkoRd+5HifMWnzUVQZS0Ar/pE7/wJdsIxO
         rYcc0ja5PSx8iLd7u8ZW2W0tCLwxB0Riq5jVjZcq+2SJ8NiQaXCUE93TY0iW9DTFwJI6
         azmwnYS+ONCx04SuBM4cjE0R/vYuT5deFCYrsA+ttQDupeJKHAbtVbaMCA2W4y6cwHPQ
         UmkVGOYVe9BQ2QgktkSda4YOpnyufRuZHba/Aw1LEI3TtwMpEC7BXE+mWfhCDkujU2P/
         1EmQ==
X-Gm-Message-State: AJIora9e0Mw0DM/19TbqR5lHvIJhCnryTO/WxXCZZTicQmbI0uqXRiKj
        pozmgr4P+AyHaJ/RDFwD1FnbCJZcnL1Z++aKKXy3Mw==
X-Google-Smtp-Source: AGRyM1t+GS4+ww9D2RWi17NlG1U7emwJiyYYkN5EY+G3jwwmYRlylz+ImRKFxipBBH8zh99ZU1pqk6h8SOf/Ba96RDA=
X-Received: by 2002:a05:6512:1056:b0:47f:6f00:66c2 with SMTP id
 c22-20020a056512105600b0047f6f0066c2mr1306154lfb.410.1655883591113; Wed, 22
 Jun 2022 00:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f5004705e1db8bad@google.com> <YrGVYfPINRobj+cF@example.org>
 <8735fyhyvy.fsf@email.froward.int.ebiederm.org> <YrJJJMQa1qAspI/J@example.org>
In-Reply-To: <YrJJJMQa1qAspI/J@example.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 22 Jun 2022 09:39:39 +0200
Message-ID: <CACT4Y+aMNM+_ud_pJQs1ocG86R0v6rzVZCuLJ8Dh=ePTyfHH+Q@mail.gmail.com>
Subject: Re: [syzbot] memory leak in setup_mq_sysctls
To:     Alexey Gladkov <legion@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>
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

On Wed, 22 Jun 2022 at 00:41, Alexey Gladkov <legion@kernel.org> wrote:
>
> On Tue, Jun 21, 2022 at 09:30:57AM -0500, Eric W. Biederman wrote:
> > Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> >
> > > On Sun, Jun 19, 2022 at 11:52:25PM -0700, syzbot wrote:
> > >> Hello,
> > >>
> > >> syzbot found the following issue on:
> > >>
> > >> HEAD commit:    979086f5e006 Merge tag 'fs.fixes.v5.19-rc3' of git://git.k..
> > >> git tree:       upstream
> > >> console output: https://syzkaller.appspot.com/x/log.txt?x=1284331bf00000
> > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=c696a83383a77f81
> > >> dashboard link: https://syzkaller.appspot.com/bug?extid=b4b0d1b35442afbf6fd2
> > >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163e740ff00000
> > >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132b758bf00000
> > >>
> > >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > >> Reported-by: syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com
> > >
> > > I'm working on a fix that will remove this memory allocation entirely.
> >
> > Hmm. The memory should be freed when the corresponding namespace exits.
> > I see retire_mq_sysctls is being called to free this memory.  Alex do
> > you see any leaks when you read that code?
>
> I don't see a leak either. retire_mq_sysctls and retire_ipc_sysctls
> functions are identical and are called one by one. I don't understand how
> there can be an mq leak without an ipc leak. Unless it has something to do
> with mq_init_ns (just guess).

Are they feed on this error path:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ipc/namespace.c?id=979086f5e0066b4eff66e1eee123da228489985c#n64
?
I don't see where it calls retire_mq_sysctls.

> > So it looks like either someone broke this in linux-next or there
> > is a bug in the memory leak detector, or something truly strange
> > like a memory stop is going on.
>
> I will take a look.
>
> > I don't see any changes to the ipc subdirectory since v5.19-rc1 in
> > commit 979086f5e006 ("Merge tag 'fs.fixes.v5.19-rc3' of git://git.k.." )
> > so the idea that the code is broken in linux-next is out.
> >
> > Which leaves the memory leak detector having trouble with this,
> > or something like a memory stomp is causing problems.
> >
> > Catalin is it possible that the clever use of ctl_table_arg to hold the
> > reference to the table before it is freed is confusing the memory leak
> > detector?  The idiom is old enough I don't expect so, but I have seen
> > bugs lurk for a long time.
> >
> > Which leaves just a memory stomp or something even stranger in the code.
> > syzkaller can you reproduce this on Linus's branch?
> >
> > Eric
> >
> > >> executing program
> > >> BUG: memory leak
> > >> unreferenced object 0xffff888112fc9200 (size 512):
> > >>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
> > >>   hex dump (first 32 bytes):
> > >>     ef d3 60 85 ff ff ff ff 0c 9b d2 12 81 88 ff ff  ..`.............
> > >>     04 00 00 00 a4 01 00 00 00 00 00 00 00 00 00 00  ................
> > >>   backtrace:
> > >>     [<ffffffff814b6eb3>] kmemdup+0x23/0x50 mm/util.c:129
> > >>     [<ffffffff82219a9b>] kmemdup include/linux/fortify-string.h:456 [inline]
> > >>     [<ffffffff82219a9b>] setup_mq_sysctls+0x4b/0x1c0 ipc/mq_sysctl.c:89
> > >>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
> > >>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
> > >>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
> > >>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
> > >>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
> > >>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
> > >>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
> > >>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
> > >>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > >>
> > >> BUG: memory leak
> > >> unreferenced object 0xffff888112fd5f00 (size 256):
> > >>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
> > >>   hex dump (first 32 bytes):
> > >>     00 92 fc 12 81 88 ff ff 00 00 00 00 01 00 00 00  ................
> > >>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >>   backtrace:
> > >>     [<ffffffff816fea1b>] kmalloc include/linux/slab.h:605 [inline]
> > >>     [<ffffffff816fea1b>] kzalloc include/linux/slab.h:733 [inline]
> > >>     [<ffffffff816fea1b>] __register_sysctl_table+0x7b/0x7f0 fs/proc/proc_sysctl.c:1344
> > >>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
> > >>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
> > >>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
> > >>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
> > >>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
> > >>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
> > >>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
> > >>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
> > >>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
> > >>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > >>
> > >> BUG: memory leak
> > >> unreferenced object 0xffff888112fbba00 (size 256):
> > >>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
> > >>   hex dump (first 32 bytes):
> > >>     78 ba fb 12 81 88 ff ff 00 00 00 00 01 00 00 00  x...............
> > >>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >>   backtrace:
> > >>     [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
> > >>     [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
> > >>     [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
> > >>     [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
> > >>     [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
> > >>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
> > >>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
> > >>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
> > >>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
> > >>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
> > >>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
> > >>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
> > >>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
> > >>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
> > >>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > >>
> > >> BUG: memory leak
> > >> unreferenced object 0xffff888112fbb900 (size 256):
> > >>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
> > >>   hex dump (first 32 bytes):
> > >>     78 b9 fb 12 81 88 ff ff 00 00 00 00 01 00 00 00  x...............
> > >>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >>   backtrace:
> > >>     [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
> > >>     [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
> > >>     [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
> > >>     [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
> > >>     [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
> > >>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
> > >>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
> > >>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
> > >>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
> > >>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
> > >>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
> > >>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
> > >>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
> > >>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
> > >>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > >>
> > >>
> > >>
> > >> ---
> > >> This report is generated by a bot. It may contain errors.
> > >> See https://goo.gl/tpsmEJ for more information about syzbot.
> > >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >>
> > >> syzbot will keep track of this issue. See:
> > >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >> syzbot can test patches for this issue, for details see:
> > >> https://goo.gl/tpsmEJ#testing-patches
