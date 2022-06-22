Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC48555221
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377304AbiFVRQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358257AbiFVRQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:16:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF49B98
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88EFF61BF2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 17:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A3CC34114;
        Wed, 22 Jun 2022 17:16:22 +0000 (UTC)
Date:   Wed, 22 Jun 2022 18:16:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        syzbot <syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] memory leak in setup_mq_sysctls
Message-ID: <YrNOYrb0TCZ1VGDq@arm.com>
References: <000000000000f5004705e1db8bad@google.com>
 <YrGVYfPINRobj+cF@example.org>
 <8735fyhyvy.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735fyhyvy.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:30:57AM -0500, Eric W. Biederman wrote:
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> > On Sun, Jun 19, 2022 at 11:52:25PM -0700, syzbot wrote:
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
[...]
> Catalin is it possible that the clever use of ctl_table_arg to hold the
> reference to the table before it is freed is confusing the memory leak
> detector?  The idiom is old enough I don't expect so, but I have seen
> bugs lurk for a long time.

As long as the addresses are not obfuscated and can be reached from some
root object (e.g. in the .data/.bss section), there shouldn't be a
problem. There are some occasional brief false positives as kmemleak
doesn't stop the world during scanning but IIRC syszbot does the
scanning twice to reduce them.

Some comments in the traces below:

> >>   backtrace:
> >>     [<ffffffff814b6eb3>] kmemdup+0x23/0x50 mm/util.c:129
> >>     [<ffffffff82219a9b>] kmemdup include/linux/fortify-string.h:456 [inline]
> >>     [<ffffffff82219a9b>] setup_mq_sysctls+0x4b/0x1c0 ipc/mq_sysctl.c:89

This one allocate a struct ctl_table.

> >>   backtrace:
> >>     [<ffffffff816fea1b>] kmalloc include/linux/slab.h:605 [inline]
> >>     [<ffffffff816fea1b>] kzalloc include/linux/slab.h:733 [inline]
> >>     [<ffffffff816fea1b>] __register_sysctl_table+0x7b/0x7f0 fs/proc/proc_sysctl.c:1344
> >>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112

This allocates struct ctl_table_header and IIUC, it stores a pointer to
the table allocated above. So if this one leaks, the ctl_table object
would also be reported as a leak.

> >>   backtrace:
> >>     [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
> >>     [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
> >>     [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
> >>     [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
> >>     [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
> >>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
[...]
> >>   backtrace:
> >>     [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
> >>     [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
> >>     [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
> >>     [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
> >>     [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
> >>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112

These two places allocate a struct ctl_dir. Are the ctl_dir objects
supposed to have a pointer to the previously allocated header or the
other way around? At a quick look, I think it's the latter as
insert_header() stores 'dir' into header->parent. Anyway, for some
reason kmemleak cannot reach the ctl_dir or ctl_table_header objects.
If one refers the other, we should focus on tracking down the parent
object.

I'll stare at the code a bit more tomorrow.

-- 
Catalin
