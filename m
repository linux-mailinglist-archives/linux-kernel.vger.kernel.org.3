Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33B55A2856
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbiHZNQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344185AbiHZNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:15:50 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7863F371B9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:15:49 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id q67so1620007vsa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=59n2uy6bMEwTPlHrLsIoQ5BkYFCiua3TbUF1n0ZR9DU=;
        b=sfPFXHYL7jV0UIzY3/KsSjEWT9yyeK3p5Rpqe8jJVcARI5WGAIzGTt/2yxKZSLVjVX
         Q+0RzoD9n4L0jjfOqIWpjm2GdKdjbNzVPmOhPFIpAQKJoyV+PH7L1vJaa/cno3peCdss
         wh4/vFmRhgVHhl2ce0Tbx3UXmq2kyFrAigUwQd877n/uKQffc9vuGWQ72augd3lfoBda
         CDDOnn7MXSmIgj/qYt/+SYfR2miAlH1xZLfhClF4ZTOo7QQvaYRqTPNteyvkn2JGHw61
         awzIBLy1IfrVQKlDikieqjlgLUXeYEJrEBopXpdAfs1cAit9LvT2zomNrJ+6GiWx4Lvy
         ZFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=59n2uy6bMEwTPlHrLsIoQ5BkYFCiua3TbUF1n0ZR9DU=;
        b=U3x9iUHx75BLtM0GGVKAKCJipa2XOYWfRukPYPgsqZVpUSHqBzcaSmW6n8RTj8I+fX
         PMRuRoXIDAC93DSIhbG83H1rPxe7LGFvD88h+yGjr3fu32yWt9/NGLRhRfT9pa8vHyGv
         z+aEiW7XzY7t4NbjIeF5+4C7mVxV0rrN6EdjwIRWPygXQ8VUlUoYSTkeQqpZp//dnjzU
         NYF3XWaGnFtm94sSHirrxRU21gsYAVeaEKY60BVv8Ljci67f7HS0J4esBjfJKGJ3PrZH
         tdfROi32jnL8Jgjfub3jImriqKpgA1ZCq+y/XkehkBFCLrXq4Tu8A9HAYeYIi9Dutper
         1qRw==
X-Gm-Message-State: ACgBeo0QTPC7GmAUA5zBh5kBUKgE/8l38caTf3jydbpKlKtgdI3bdTqW
        abPH/jwoYfcG9AIqDP8a34sFewcmxiLZA70qxQpbdQ==
X-Google-Smtp-Source: AA6agR6PlDujz+oXUVecvczTK/svEkHdtMJ4EBTSmLSES/3EDjMO7G84YLviv2jT2w9h1v5ElNQH1l3nlLy4nr3zxVo=
X-Received: by 2002:a05:6102:5348:b0:390:8a9c:5376 with SMTP id
 bq8-20020a056102534800b003908a9c5376mr3074445vsb.53.1661519748475; Fri, 26
 Aug 2022 06:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004c3b1405e6b7de26@google.com> <f70b1cf7-0291-6ebc-68f8-db9c68963255@acm.org>
In-Reply-To: <f70b1cf7-0291-6ebc-68f8-db9c68963255@acm.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 26 Aug 2022 15:15:37 +0200
Message-ID: <CANp29Y7bgwDzd47E6h8gseYuu5YXF-ABRrhVXFXS-HF7PhF-Dw@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in blk_mq_map_swqueue
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+ea55456e1ff28ef7f9ff@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        "'Aleksandr Nogikh' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 7:48 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 8/20/22 20:24, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    3cc40a443a04 Merge tag 'nios2_fixes_v6.0' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13cf3c7b080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f267ed4fb258122a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ea55456e1ff28ef7f9ff
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ea55456e1ff28ef7f9ff@syzkaller.appspotmail.com
> >
> > scsi 0:0:1:0: Direct-Access     Google   PersistentDisk   1    PQ: 0 ANSI: 6
> > BUG: unable to handle page fault for address: ffffdc0000000000
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 12026067
> > P4D 12026067 PUD 0
> > Oops: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 46 Comm: kworker/u4:3 Not tainted 6.0.0-rc1-syzkaller-00017-g3cc40a443a04 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> > Workqueue: events_unbound async_run_entry_fn
> > RIP: 0010:blk_mq_map_swqueue+0xa86/0x1630 block/blk-mq.c:3722
> > Code: 00 00 fc ff df 43 0f b6 04 37 84 c0 0f 85 49 02 00 00 41 0f b7 45 00 8d 48 01 66 41 89 4d 00 48 8d 1c c3 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 4c 8b 7c 24 68 74 08 48 89 df e8 36 7b c1 fd 48 8b
> > RSP: 0000:ffffc90000b77380 EFLAGS: 00010a06
> > RAX: 1fffe00000000000 RBX: ffff000000000000 RCX: 0000000000000001
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> > RBP: ffffc90000b774f0 R08: ffffffff841bbbaa R09: ffffed1004143326
> > R10: ffffed1004143326 R11: 1ffff11004143325 R12: dffffc0000000000
> > R13: ffff888020a1998e R14: dffffc0000000000 R15: 1ffff11004143331
> > FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffdc0000000000 CR3: 000000000ca8e000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >   blk_mq_init_allocated_queue+0x1a31/0x1c20 block/blk-mq.c:4119
> >   blk_mq_init_queue_data block/blk-mq.c:3908 [inline]
> >   blk_mq_init_queue+0x9f/0x120 block/blk-mq.c:3918
> >   scsi_alloc_sdev+0x697/0x9d0 drivers/scsi/scsi_scan.c:335
> >   scsi_probe_and_add_lun+0x1d1/0x4ab0 drivers/scsi/scsi_scan.c:1191
> >   __scsi_scan_target+0x1fb/0x10e0 drivers/scsi/scsi_scan.c:1673
> >   scsi_scan_channel drivers/scsi/scsi_scan.c:1761 [inline]
> >   scsi_scan_host_selected+0x394/0x6c0 drivers/scsi/scsi_scan.c:1790
> >   do_scsi_scan_host drivers/scsi/scsi_scan.c:1929 [inline]
> >   do_scan_async+0x12e/0x7b0 drivers/scsi/scsi_scan.c:1939
> >   async_run_entry_fn+0xa6/0x400 kernel/async.c:127
> >   process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
> >   worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
> >   kthread+0x266/0x300 kernel/kthread.c:376
> >   ret_from_fork+0x1f/0x30
> >   </TASK>
> > Modules linked in:
> > CR2: ffffdc0000000000
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:blk_mq_map_swqueue+0xa86/0x1630 block/blk-mq.c:3722
> > Code: 00 00 fc ff df 43 0f b6 04 37 84 c0 0f 85 49 02 00 00 41 0f b7 45 00 8d 48 01 66 41 89 4d 00 48 8d 1c c3 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 4c 8b 7c 24 68 74 08 48 89 df e8 36 7b c1 fd 48 8b
> > RSP: 0000:ffffc90000b77380 EFLAGS: 00010a06
> > RAX: 1fffe00000000000 RBX: ffff000000000000 RCX: 0000000000000001
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> > RBP: ffffc90000b774f0 R08: ffffffff841bbbaa R09: ffffed1004143326
> > R10: ffffed1004143326 R11: 1ffff11004143325 R12: dffffc0000000000
> > R13: ffff888020a1998e R14: dffffc0000000000 R15: 1ffff11004143331
> > FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffdc0000000000 CR3: 000000000ca8e000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess), 5 bytes skipped:
> >     0:        43 0f b6 04 37          movzbl (%r15,%r14,1),%eax
> >     5:        84 c0                   test   %al,%al
> >     7:        0f 85 49 02 00 00       jne    0x256
> >     d:        41 0f b7 45 00          movzwl 0x0(%r13),%eax
> >    12:        8d 48 01                lea    0x1(%rax),%ecx
> >    15:        66 41 89 4d 00          mov    %cx,0x0(%r13)
> >    1a:        48 8d 1c c3             lea    (%rbx,%rax,8),%rbx
> >    1e:        48 89 d8                mov    %rbx,%rax
> >    21:        48 c1 e8 03             shr    $0x3,%rax
> > * 25: 42 80 3c 30 00          cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
> >    2a:        4c 8b 7c 24 68          mov    0x68(%rsp),%r15
> >    2f:        74 08                   je     0x39
> >    31:        48 89 df                mov    %rbx,%rdi
> >    34:        e8 36 7b c1 fd          callq  0xfdc17b6f
> >    39:        48                      rex.W
> >    3a:        8b                      .byte 0x8b
>
> Hi Dmitry,
>
> This issue and also another report that has been shared recently on the
> linux-scsi mailing list look like USB issues to me. Who is the right person
> to make sure that the USB mailing list is included for USB related issues?
>
> Thanks,
>
> Bart.

Hi Bart,

Syzbot would have included the USB mailing list and the USB
maintainers if it saw that the bug might be related to this subsystem.
The bot's guess was that it was the BLOCK LAYER subsystem, so it Cc'd
only the general lists and linux-block@vger.kernel.org

Is there anything in this bug report that can reliably indicate that
the bug has to do with USB? If there is, we can definitely adjust our
guilty subsystem recognition logic.

--
Best Regards
Aleksandr

>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/f70b1cf7-0291-6ebc-68f8-db9c68963255%40acm.org.
