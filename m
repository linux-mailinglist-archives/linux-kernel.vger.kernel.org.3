Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AD7552BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346684AbiFUHX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346325AbiFUHXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:23:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D719B1A073
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:23:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a29so20888282lfk.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQBZXrOyxKk17Qmb+htNurG7xfexjjlGMTk0ooZWqYM=;
        b=eyRARI+WbmnGKJkkQqsUO7kFGM+/ol2pgPBEblR5lmu3IzPh1hnE/5mzarHyF35t+E
         keBUoNnqsiT1oQxVZv3aQzyFAEz9y+NemxApgUhTK+1xihIZogM6/nMAf8OW2iCjRbR4
         QGpw68BWJu4e/jmEg8IGmiceS/KpSwS211Wb/pZ0QzSDRpqCQHvmbmbe4tjM1NmtL/1v
         B36Q6HCY3ujSMvyTgS77dRCyumFxJIyx4npqWfL1o7/7vMlKgXcZpPg733dem9w9TLRg
         lCNb2LuBJppDugHswoN2eSLi5xtM2b8W9ezUeBAbxEgpniALzAr6FrTTD7pL2RREcoA7
         8/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQBZXrOyxKk17Qmb+htNurG7xfexjjlGMTk0ooZWqYM=;
        b=KfbWdqM6HI0dn1OdkoE6Nn06bKrY0Rs6JIq2hac8rzX8VShNg9jkUfg5VAeNOzJmmd
         czq+sg7w83U6Bwwn11mpVBI7HmNyxK048+E8L67z4+Q91cApZ02cCZmOfkRZztceHZ0q
         xHojlxI4TYGKsg3OwNjjhcA2wimM1ndRyxG8W0+0VjNs4bqQ1wjmHSmVWOcLewUXgQ81
         mJP3aWUjDLOq0slB55+tEi3mLbP8AdlOgDN0xfZUQ1nmzHnWD0c0tWyYsHTuMhF1E+0D
         G4GONkcFV/QZUoTmQcxMts3jEhrmjJBaB1Qr/B0PFbTv4AehaRaeDcp9ydE9wVlu2dV+
         UKIQ==
X-Gm-Message-State: AJIora9wUxH7CKt1myZZ06FvouWIV+28DM7dSQslJl0Sjh/grwfxziRz
        3xEHsmWrduAbwkBqHfWnk5RULLtZRVKW1F1Zkb1MPQ==
X-Google-Smtp-Source: AGRyM1vBR4vGnynjGqTdbeqkOalCGcE31vMFLOtF7Mb9mQL+skciv0jUSm50dSYb3r3bFbsspVIOsKc6+vJocYsXGw8=
X-Received: by 2002:a05:6512:1056:b0:47f:6f00:66c2 with SMTP id
 c22-20020a056512105600b0047f6f0066c2mr5193794lfb.410.1655796226905; Tue, 21
 Jun 2022 00:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004a0dbe05e1d749e0@google.com> <20220621020814.sjszxp3uz43rka62@revolver>
In-Reply-To: <20220621020814.sjszxp3uz43rka62@revolver>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Jun 2022 09:23:35 +0200
Message-ID: <CACT4Y+YBDPkmTyVM9iYk5FUubv0Af5ZWc5g+1xUFxUae-mTXtg@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in binder_alloc_deferred_release
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     syzbot <syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arve@android.com" <arve@android.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hridya@google.com" <hridya@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maco@android.com" <maco@android.com>,
        "surenb@google.com" <surenb@google.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "minchan@kernel.org" <minchan@kernel.org>
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

On Tue, 21 Jun 2022 at 04:08, Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * syzbot <syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com> [220619 21:47]:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    6012273897fe Add linux-next specific files for 20220615
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=16596feff00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b4154677977b1776
> > dashboard link: https://syzkaller.appspot.com/bug?extid=58b51ac2b04e388ab7b0
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1024e510080000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113e407ff00000
> >
> > The issue was bisected to:
> >
> > commit 42086abba43463fbf495cb80173600284b4c4e8c
> > Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Date:   Tue Jun 14 19:00:27 2022 +0000
> >
> >     mm: start tracking VMAs with maple tree
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10ef827ff00000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=12ef827ff00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14ef827ff00000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:

Hi Liam,

Please also add the Reported-by tag.

\/\/\/\/\/\/\/\/\/\/\/\/\/\/

> > Reported-by: syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com
> > Fixes: 42086abba434 ("mm: start tracking VMAs with maple tree")
> >
> > ------------[ cut here ]------------
> > kernel BUG at drivers/android/binder_alloc.c:820!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 2934 Comm: kworker/0:3 Not tainted 5.19.0-rc2-next-20220615-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: events binder_deferred_func
> > RIP: 0010:binder_alloc_deferred_release+0x602/0x780 drivers/android/binder_alloc.c:820
> > Code: c6 80 16 c7 8a 48 c7 c7 80 b6 48 8d e8 57 86 05 fd 31 ff 89 c5 89 c6 e8 fc ba 5b fa 85 ed 74 c6 e9 78 57 55 02 e8 9e be 5b fa <0f> 0b c7 44 24 20 00 00 00 00 e9 27 ff ff ff e8 8a be 5b fa 48 89
> > RSP: 0018:ffffc9000de07bc8 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffff8880519971e0 RCX: 0000000000000000
> > RDX: ffff888026b0d7c0 RSI: ffffffff871f04b2 RDI: ffff888051997270
> > RBP: ffff888051997000 R08: 0000000000000000 R09: ffffffff8dbcac17
> > R10: fffffbfff1b79582 R11: 0000000000000000 R12: ffff888147653c60
> > R13: ffff8880519972d8 R14: ffff888147653d10 R15: dffffc0000000000
> > FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f99ddec19c1 CR3: 0000000077a01000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  binder_free_proc drivers/android/binder.c:4766 [inline]
>
> ...
>
>
> This task has alloc->vma set to a freed VMA.  What is happening is that
> I've added an allocation later in the mmap_region() code which is being
> failed by the fuzzer.  This failure means that the vma recorded in the
> binder code via the call_mmap() is going to be freed in the
> mmap_region() failure path, but the binder code does not know of the
> failure.
>
> I was going to move my preallocation above the call_mmap() to avoid this
> failure, but that will basically mask the issue(s) in binder.  There are
> two other possibilities that could cause the same binder failure.  The
> first being a rather unlikely arch_validate_flags() returning false.
> The second is a successful merge of the allocated VMA
> - also rare, but still possible.
>
> The code records a VMA to be used later and drops the mmap_lock.
> Shouldn't it record the *address* and look up the VMA when it is needed
> to avoid using a freed pointer?  There has been at least one other issue
> with recording the VMA [1].
>
> Anyways, the attached patch fixes the issue I've exposed by saving the
> start address and looking it up.  I've added lockdep checks for good
> measures.  It fixes the reproduces from this email, but may need more
> oversight.
>
>
> 1. https://lore.kernel.org/lkml/20190301230606.8302-1-tkjos@google.com/
>
> Thanks,
> Liam
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20220621020814.sjszxp3uz43rka62%40revolver.
