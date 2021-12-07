Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA4946B62B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhLGIlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhLGIlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:41:12 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8722FC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 00:37:42 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bf8so26520421oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 00:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89Xwan8ItV/N/elD2Nw4JJQYF/4fozL+k5X8mIfTuqE=;
        b=X3U0yqla0ZettlIRR2U3uP0hx6rTJFNuuIn9WxKNOg7ICs9bP8R4BftQvB2E4SMgR/
         1UtRpdZYAaAVh+J3b/H+slzNv/2xF++AU041vWwDYf02+kyQ+dDWdCuaE43jrsufBpFr
         9aobdsyWLM0WBKeGtRSjzw1QsfXAQWRtMcMNZtqzTvnOJT1hooYNo1RxDSDguGuL+7g8
         9GGewTl4W5m1pPcWNQhYwDpB77vxV5ghiP1RbkhwuBbLqjVf0umwuIpxE/L+lo3jstRE
         91P2T9HeUav86KdwjRx8DsD2qD1K7AUsY3IQmIih5Jpbmr8tNIHEkcWR5H/oJ6MxhkZT
         1fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89Xwan8ItV/N/elD2Nw4JJQYF/4fozL+k5X8mIfTuqE=;
        b=CGWRGUX5krORtuV0uB2H+KOqD+la49SQZnv71SoPsyJCSnBxmlyTXvErEStXT1Z/3n
         dWeZC9p0D+j9dsynDWQb1K2f1kEqhKi467EJXK8FsXvDOjn5fV6a4hYX2yaX0Vchzx+i
         8R3Lpr1eSyW2/5HPW9eOj9Xl3YR68p5BMJfvX3I6huu/wcAtF8vbdbFUQiGVajnI2BOe
         8OK/4/nSBI6t+KKFIE22luclWANvnLc+/Xxkd1mRzf1y4HPHg+DoWgMjBP5yY2Ix0Iqq
         9zzj2w5bHP3sDBJMKUaJP1m3TL/O1j/LAouzS3w7Ru26EID/Baod9ywFqGbM0oxn9klq
         nSnw==
X-Gm-Message-State: AOAM533GF11DSDoW64Ugf3X+hyZt0lkCF7RVQpzp7adFuP7emk1kL9qq
        LhF+6x1ddCvAquRNCr6mgP2lr+fq/Ha/SMCFAp0GcA==
X-Google-Smtp-Source: ABdhPJzpgVfQyheJozzv4cR1ZAH4dVyUrqeHxyYfwcSt1BR6FsTV5YduqrJOdrq3V+OkC6sfvA+xrXX0JJvNeTlV414=
X-Received: by 2002:a05:6808:ec9:: with SMTP id q9mr3754831oiv.160.1638866261588;
 Tue, 07 Dec 2021 00:37:41 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c3eace05d24f0189@google.com> <20211206154159.GP5112@ziepe.ca>
 <CACT4Y+bnJ5M84RjUONFYMXSOpzC5UOq2DxVNoQkq6c6nYwG9Og@mail.gmail.com> <20211206173550.GQ5112@ziepe.ca>
In-Reply-To: <20211206173550.GQ5112@ziepe.ca>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 Dec 2021 09:37:30 +0100
Message-ID: <CACT4Y+atv60UELnQJqejS_Z+uBYYERha4-o1dViwVuSLpb-Tfw@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in rdma_listen (2)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com>,
        avihaih@nvidia.com, dledford@redhat.com, haakon.bugge@oracle.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 18:35, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Dec 06, 2021 at 04:46:40PM +0100, Dmitry Vyukov wrote:
> > On Mon, 6 Dec 2021 at 16:42, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Sat, Dec 04, 2021 at 01:54:17AM -0800, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    bf152b0b41dc Merge tag 'for_linus' of git://git.kernel.org..
> > >
> > > ??
> > >
> > > This commit is nearly a year old?
> > >
> > > $ git describe --contains bf152b0b41dc
> > > v5.12-rc4~28
> > >
> > > I think this has probably been fixed since, why did a report for such
> > > an old kernel get sent?
> >
> > Hi Jason,
> >
> > Oh, that's because the arm32 kernel was broken for that period, so
> > syzbot tested the latest working kernel. There is a more fresh x86_64
> > crash available on the dashboard:
> > https://syzkaller.appspot.com/bug?extid=c94a3675a626f6333d74
>
> ??
>
> There is nothing there newer than a year?
>
> Jason

In the Crashes table there are 2 crashes, one is the one that was
reported in this email and the second happened on upstream commit
5833291ab6de (you can search by this hash on the page).
5833291ab6de is newer than a year:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=5833291ab6de
