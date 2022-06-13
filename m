Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652AB549DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350766AbiFMT1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350630AbiFMT1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:27:02 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A215F45
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:50:48 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y12so6874005ior.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMrUQEZvJYNdbTMwYF5VJfqFknA2kh4UzRrP2Bm40iA=;
        b=QV6eQNqyR77FT7qqRgan+L7Nw1LHnHt+EPBSPQDbzl18gTRzBfZX6jzIoVsnqYqSQd
         HVLTShUbbUQru/befjleL5S5wmq3cXQcrkeAVrCypJuT7cTl2CC9YdjoxmHZLUt9qR4Q
         iNEHY6w8HPcezzgT82b2fRR1XFva7INjXPW95zQK9y+2Yg3vAxnJ247fcdS/1ZWuAR0r
         LjKvzuarNBW57Eyk0r4VpZCkHa5Nq+KbZdO8TndTSqgC1/PBjLZtplfg3d7LLs4gvZdg
         RKm/wqBFxjxGHXRjaruiDdx+MJiuidTD4F+uwvm/VEg4a/5iOO+/032pyP81kEfnOUQx
         GiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMrUQEZvJYNdbTMwYF5VJfqFknA2kh4UzRrP2Bm40iA=;
        b=qX6a1zWE4EgehYpwRBcwUpYWzuv2N6o2oqV7cJEsfxGS/i2v8GlSV0LFQRLTWciWVl
         SyxEphFOlyZR9fcBMXwfv/Fe3czWVVQtHBBKynI8keppg9IukqI+aZ+K0RtkeZUXxddu
         9liN3MyOB0XC/kqvF5b5edZTijnkyxfuXbadkOOiwp6xHw3sdkl0tm4LtdlZ1SM7JbEE
         G3/l3OtrkhpoWXK7miSrSVmbYF6WsK/OyaemoIB7gmgscKaODdGXj/V8laxF9tJp4Dcl
         GkBQ9MhVd51IGXnEoWbknSjulxZQE91QNEwZWck4k6sy3Wbbb/Yhusk6i8pF1wkCzucc
         qAYA==
X-Gm-Message-State: AOAM533CriNJ+qRJ8QHpgxyUcgrGUjIGtDYr3K+eZA9rLjf/TbX6XySe
        8TcPS4y1oXQnDkIzj9rHw5TIqxPApvfXQStnkWOFzg==
X-Google-Smtp-Source: ABdhPJzl0X0tWSVTNAqy/D1HTd37Hb0MJJHy3k2gfviagoWaHYSTCRzec3+5skrx342Gcw2tBA2fq6+6N46lqbBBtNo=
X-Received: by 2002:a05:6638:25c8:b0:332:198c:dbf6 with SMTP id
 u8-20020a05663825c800b00332198cdbf6mr565876jat.52.1655142647488; Mon, 13 Jun
 2022 10:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000039bfb905e14ea9d0@google.com> <20220613104128.fc55ed6ab63c428e502bc483@linux-foundation.org>
In-Reply-To: <20220613104128.fc55ed6ab63c428e502bc483@linux-foundation.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 13 Jun 2022 10:50:11 -0700
Message-ID: <CAJHvVcjkivTP07xkPe3E9+EAtwFsOJhcXHZMMDJXe4RfrEpCQw@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in mcopy_continue
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+3f1e5c1dea3a2e66ea9a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        Peter Xu <peterx@redhat.com>
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

I think this is the problem Peter Xu pointed out, and has been fixed
in v2 of the patch (which has us return -EFAULT instead of -ENOENT).

I think this based on:

This page has a link to the line on which the bug happened:
https://syzkaller.appspot.com/bug?extid=3f1e5c1dea3a2e66ea9a
It links to this line:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/mm/userfaultfd.c?id=6d0c806803170f120f8cb97b321de7bd89d3a791#n642

So, it seems this is the BUG that was triggered:

if (unlikely(err == -ENOENT)) {
        BUG_ON(!page);
}

On Mon, Jun 13, 2022 at 10:41 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sun, 12 Jun 2022 23:47:26 -0700 syzbot <syzbot+3f1e5c1dea3a2e66ea9a@syzkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    6d0c80680317 Add linux-next specific files for 20220610
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13a777f7f00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3f1e5c1dea3a2e66ea9a
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+3f1e5c1dea3a2e66ea9a@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > kernel BUG at mm/userfaultfd.c:642!
>
> Thanks.  I'm looking suspiciously at "mm: userfaultfd: fix
> UFFDIO_CONTINUE on fallocated shmem pages"?
>
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 14685 Comm: syz-executor.4 Not tainted 5.19.0-rc1-next-20220610-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:__mcopy_atomic mm/userfaultfd.c:642 [inline]
> > RIP: 0010:mcopy_continue+0x80f/0x1360 mm/userfaultfd.c:699
> > Code: a8 ff 49 83 fd fe 0f 85 bd fd ff ff e8 ba ca a8 ff 0f 1f 44 00 00 e8 b0 ca a8 ff e8 ab ca a8 ff 48 8b 7c 24 20 e8 51 76 8b ff <0f> 0b e8 9a ca a8 ff 0f 0b e8 93 ca a8 ff 4d 89 ee 31 ff 41 81 e6
> > RSP: 0018:ffffc900058f7b70 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: ffff8880226dee58 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801a0b4228
> > RBP: 0000000020531000 R08: 0000000000000001 R09: ffff88801a0b422f
> > R10: ffffed1003416845 R11: 0000000000000001 R12: 0000000000000000
> > R13: fffffffffffffffe R14: 00000000fffffffe R15: ffff88801a0b4140
> > FS:  00007f91409ee700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b2c522000 CR3: 000000001d578000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  userfaultfd_continue fs/userfaultfd.c:1893 [inline]
> >  userfaultfd_ioctl+0x1818/0x41f0 fs/userfaultfd.c:2017
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f913f889109
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f91409ee168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f913f99c030 RCX: 00007f913f889109
> > RDX: 0000000020000040 RSI: 00000000c020aa07 RDI: 0000000000000004
> > RBP: 00007f913f8e30ad R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffcb29c401f R14: 00007f91409ee300 R15: 0000000000022000
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:__mcopy_atomic mm/userfaultfd.c:642 [inline]
> > RIP: 0010:mcopy_continue+0x80f/0x1360 mm/userfaultfd.c:699
> > Code: a8 ff 49 83 fd fe 0f 85 bd fd ff ff e8 ba ca a8 ff 0f 1f 44 00 00 e8 b0 ca a8 ff e8 ab ca a8 ff 48 8b 7c 24 20 e8 51 76 8b ff <0f> 0b e8 9a ca a8 ff 0f 0b e8 93 ca a8 ff 4d 89 ee 31 ff 41 81 e6
> > RSP: 0018:ffffc900058f7b70 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: ffff8880226dee58 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801a0b4228
> > RBP: 0000000020531000 R08: 0000000000000001 R09: ffff88801a0b422f
> > R10: ffffed1003416845 R11: 0000000000000001 R12: 0000000000000000
> > R13: fffffffffffffffe R14: 00000000fffffffe R15: ffff88801a0b4140
> > FS:  00007f91409ee700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f91409cd718 CR3: 000000001d578000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
