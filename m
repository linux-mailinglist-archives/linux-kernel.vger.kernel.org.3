Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825004B8F18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbiBPRZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:25:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiBPRZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:25:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F412B049F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:25:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D602C61BC8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACE8C340FA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645032309;
        bh=50gayj5BhaFY1KfY4J6wEv9LL/2KBrv3TJsZgjwCNeI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s12B1+AOmXryDhSPknuKL8IzRS63FtY1jW4IQTcFUQFmxCB1bHM2/Ad46I49kwf/J
         1N4t3B+0pmEk+VM3RGTCCPp4BMoEKUD4OApK6MSr126ucgMlswQUB5BXx26xHHuTIN
         nIDMmz2bSNAvv2YwZvqQkNZ1VSjzEi+/bEnRawkliB/xPF6w5v2/ZpnWvzzcu60YAt
         b0tbgWWS2iDyu+FNJTDx6MhZ0bonly7bCCQI8ozxMfHHeK9T6LKrcaRKo68YMdnAGW
         SkkcTyfQRZRWBGGpnaiNe0OT4YNd8PPdnGpvOZ+aTT7Oxn7WeP/AbgH0K6UKXbmysP
         GFlbvOO46XMmw==
Received: by mail-yb1-f180.google.com with SMTP id y6so7568380ybc.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:25:09 -0800 (PST)
X-Gm-Message-State: AOAM531kavWc+RfPi8mDyGCz2maxcxFdAd1GV+EdzGhbyHDbNzlJ1w0E
        YoAVejm2Be20iwmOsJXdqq9UdMJ+A2FUcPzkQGs=
X-Google-Smtp-Source: ABdhPJxjMQo5IVyxb0rl98kvZVGHXXkUZT6SL5l1mKrh+QNt5m3z6iWux2+7Z+U/R+Y+NG64b+eQtIGkKKWMvR0XD9c=
X-Received: by 2002:a5b:5d0:0:b0:623:c68d:d473 with SMTP id
 w16-20020a5b05d0000000b00623c68dd473mr2991953ybp.506.1645032308053; Wed, 16
 Feb 2022 09:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20200917112538.GD8409@ziepe.ca> <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca> <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1> <20200918173240.GY8409@ziepe.ca>
 <20200918204048.GC5962@xz-x1> <0af8c77e-ff60-cada-7d22-c7cfcf859b19@nvidia.com>
 <20200919000153.GZ8409@ziepe.ca> <20200921083505.GA5862@quack2.suse.cz>
 <20200921120301.GD8409@ziepe.ca> <CAFCwf10eNmwq2wD71xjUhqkvv5+_pJMR1nPug2RqNDcFT4H86Q@mail.gmail.com>
In-Reply-To: <CAFCwf10eNmwq2wD71xjUhqkvv5+_pJMR1nPug2RqNDcFT4H86Q@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 16 Feb 2022 19:24:41 +0200
X-Gmail-Original-Message-ID: <CAFCwf12KNkd43U8+hcfSL9RuT-T=7RrDExOK0eD4fe+3XiUrhw@mail.gmail.com>
Message-ID: <CAFCwf12KNkd43U8+hcfSL9RuT-T=7RrDExOK0eD4fe+3XiUrhw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 6:59 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Mon, Sep 21, 2020 at 3:03 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Sep 21, 2020 at 10:35:05AM +0200, Jan Kara wrote:
> > > > My thinking is to hit this issue you have to already be doing
> > > > FOLL_LONGTERM, and if some driver hasn't been properly marked and
> > > > regresses, the fix is to mark it.
> > > >
> > > > Remember, this use case requires the pin to extend after a system
> > > > call, past another fork() system call, and still have data-coherence.
> > > >
> > > > IMHO that can only happen in the FOLL_LONGTERM case as it inhernetly
> > > > means the lifetime of the pin is being controlled by userspace, not by
> > > > the kernel. Otherwise userspace could not cause new DMA touches after
> > > > fork.
> > >
> > > I agree that the new aggressive COW behavior is probably causing issues
> > > only for FOLL_LONGTERM users. That being said it would be nice if even
> > > ordinary threaded FOLL_PIN users would not have to be that careful about
> > > fork(2) and possible data loss due to COW - we had certainly reports of
> > > O_DIRECT IO loosing data due to fork(2) and COW exactly because it is very
> > > subtle how it behaves... But as I wrote above this is not urgent since that
> > > problematic behavior exists since the beginning of O_DIRECT IO in Linux.
> >
> > Yes, I agree - what I was thinking is to do this FOLL_LONGTERM for the
> > rc and then a small patch to make it wider for the next cycle so it
> > can test in linux-next for a responsible time period.
> >
> > Interesting to hear you confirm block has also seen subtle user
> > problems with this as well.
> >
> > Jason
> >
>
> Hi Jason, Linus,
> Sorry for waking up this thread, but I've filed a bug against this change:
> https://bugzilla.kernel.org/show_bug.cgi?id=215616
>
> In the past week, I've bisected a problem we have in one of our new
> demos running on our Gaudi accelerator, and after a very long
> bisection, I've come to this commit.
> All the details are in the bug, but the bottom line is that somehow,
> this patch causes corruption when the numa balancing feature is
> enabled AND we don't use process affinity AND we use GUP to pin pages
> so our accelerator can DMA to/from system memory.
>
> Either disabling numa balancing, using process affinity to bind to
> specific numa-node or reverting this patch causes the bug to
> disappear.
> I validated the bug and the revert on kernels 5.9, 5.11 and 5.17-rc4.
>
> You can see our GUP code in the driver in get_user_memory() in
> drivers/misc/habanalabs/common/memory.c.
> It is fairly standard and I think I got that line from Daniel (cc'ed
> on this email).
>
> I would appreciate help from the mm experts here to understand how to
> fix this, but it looks as if this simplification caused or exposed
> some race between numa migration code and GUP.
>
> Thanks,
> Oded

Although I wrote it inside the bug, I just wanted to specify here the
exact commit id in the tree:

2020-09-04 - 09854ba94c6aad7886996bfbee2530b3d8a7f4f4 -  mm:
do_wp_page() simplification <Linus Torvalds>

Thanks,
Oded
