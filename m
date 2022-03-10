Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75374D3E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbiCJAcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiCJAcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:32:02 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D41F124C04
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:31:02 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id z4so3320419pgh.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 16:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XAK6UQcVdFywQafnZbczeEpSjkkUEsUm28p2DeHOwuM=;
        b=aoVvvC+wR80TWp9+dvnTBG5a42cYKc+R2euTCMM0LN6Bn/vS8rni+MvQX38gdCnzfS
         DZU0kDthmOQkY+sUUcFddx3aN0c40RMlhJ7AmQE4LbyIfXUa0qKAy85CHAQtmU5UmtSH
         EKSmccSOJGNAa4vMPQvBCTEDI8iecqzjbYoQouY4ht3OJH6Ktyo15JtYBJ1Wowax9Yyz
         r4LIrLXxUwKt1TnsWc4ytKxn2K3VF7ZdWdMWlhy7BFAu026Hdh84P4akKiM9dCpfEwm2
         9hRxdNNUcKh+DI69MFRL9RN0yVrcbWYA/nhuNbQ8pRFge3GCArtSQQNk5WUYkqqHsVJy
         3GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XAK6UQcVdFywQafnZbczeEpSjkkUEsUm28p2DeHOwuM=;
        b=KGF6+PqrHJ19Oxr8NOIhGHigmNpmrNe/b9Vn8jiTuZcQunposI5qxnKdPBUJS1vxvG
         8x8uwZt7xFA3soUuqrFf3d/nZKD7/BfhtBVt25L96l/5t5n5YDoLA5dwXOsTOkPxVsZB
         7eXQjjykf7vJMUrHI0gn8WzCdJHgfvu9cZra+oaqJ8PrFPL1f3ghFKtxd1CR/Cib3Z/C
         hyU102Na927AqpTQwCmctKCK0CXmepmIffG5yMP/fHwPw6QZLzjdDWx7rC0XxZrF9U/0
         U7bfTkg3lQ2Ws/2lJ9Ab1EGpX1bHvAJBRTllR6aAlNhmOFQft1W4rS7VtWP4aRTZFllr
         HFuw==
X-Gm-Message-State: AOAM5325xjPusq2jYKkvQ+jtY4h8YO/Ij6pxDvRbUWnSDdWrTDz0PYYV
        efbLytwK/m6j9aQTfescnzdbyiNQqIwTXPI7ITs=
X-Google-Smtp-Source: ABdhPJzYlVySOdrZmPs/c1gnoQZpE19IYyHyHgeqi5Z01bSBVV+Uw5v2Q7r51Ur9JJtyQEvf4KoN64b2+uL0ZvCvRmo=
X-Received: by 2002:a62:8c44:0:b0:4c4:8072:e588 with SMTP id
 m65-20020a628c44000000b004c48072e588mr2112278pfd.11.1646872261851; Wed, 09
 Mar 2022 16:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20220309091449.2753904-1-naoya.horiguchi@linux.dev>
 <CAHbLzkrmHS+nPbw1YZj-rE-ECgRr2nD40d-ZbxPvf05o-rmNcA@mail.gmail.com> <20220310000024.GA1577304@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20220310000024.GA1577304@hori.linux.bs1.fc.nec.co.jp>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 9 Mar 2022 16:30:50 -0800
Message-ID: <CAHbLzkpWV4oP86oe4BXop20KMJqwEmSkpFmZfT+q38hs90oqKA@mail.gmail.com>
Subject: Re: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 4:01 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Wed, Mar 09, 2022 at 01:55:30PM -0800, Yang Shi wrote:
> > On Wed, Mar 9, 2022 at 1:15 AM Naoya Horiguchi
> > <naoya.horiguchi@linux.dev> wrote:
> > >
> > > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > >
> > > There is a race condition between memory_failure_hugetlb() and hugetl=
b
> > > free/demotion, which causes setting PageHWPoison flag on the wrong pa=
ge
> > > (which was a hugetlb when memory_failrue() was called, but was remove=
d
> > > or demoted when memory_failure_hugetlb() is called).  This results in
> > > killing wrong processes.  So set PageHWPoison flag with holding page =
lock,
> > >
> > > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > ---
> > >  mm/memory-failure.c | 27 ++++++++++++---------------
> > >  1 file changed, 12 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > index ac6492e36978..fe25eee8f9d6 100644
> > > --- a/mm/memory-failure.c
> > > +++ b/mm/memory-failure.c
> > > @@ -1494,24 +1494,11 @@ static int memory_failure_hugetlb(unsigned lo=
ng pfn, int flags)
> > >         int res;
> > >         unsigned long page_flags;
> > >
> > > -       if (TestSetPageHWPoison(head)) {
> > > -               pr_err("Memory failure: %#lx: already hardware poison=
ed\n",
> > > -                      pfn);
> > > -               res =3D -EHWPOISON;
> > > -               if (flags & MF_ACTION_REQUIRED)
> > > -                       res =3D kill_accessing_process(current, page_=
to_pfn(head), flags);
> > > -               return res;
> > > -       }
> > > -
> > > -       num_poisoned_pages_inc();
> > > -
> > >         if (!(flags & MF_COUNT_INCREASED)) {
> > >                 res =3D get_hwpoison_page(p, flags);
> >
> > I'm not an expert of hugetlb, I may be wrong. I'm wondering how this
> > could solve the race? Is the below race still possible?
> >
> > __get_hwpoison_page()
> >   head =3D compound_head(page)
> >
> > hugetlb demotion (1G --> 2M)
> >   get_hwpoison_huge_page(head, &hugetlb);
>
> Thanks for the comment.
> I assume Miaohe's patch below introduces additional check to detect the
> race.  The patch calls compound_head() for the raw error page again, so
> the demotion case should be detected.  I'll make the dependency clear in
> the commit log.
>
> https://lore.kernel.org/linux-mm/20220228140245.24552-2-linmiaohe@huawei.=
com/
>
> >
> >
> > Then the head may point to a 2M page, but the hwpoisoned subpage is
> > not in that 2M range?
> >
> >
> > >                 if (!res) {
> > >                         lock_page(head);
> > >                         if (hwpoison_filter(p)) {
> > > -                               if (TestClearPageHWPoison(head))
> > > -                                       num_poisoned_pages_dec();
> > >                                 unlock_page(head);
> > >                                 return -EOPNOTSUPP;
> > >                         }
> > > @@ -1544,13 +1531,16 @@ static int memory_failure_hugetlb(unsigned lo=
ng pfn, int flags)
> > >         page_flags =3D head->flags;
> > >
> > >         if (hwpoison_filter(p)) {
> > > -               if (TestClearPageHWPoison(head))
> > > -                       num_poisoned_pages_dec();
> > >                 put_page(p);
> > >                 res =3D -EOPNOTSUPP;
> > >                 goto out;
> > >         }
> > >
> > > +       if (TestSetPageHWPoison(head))
> >
> > And I don't think "head" is still the head you expected if the race
> > happened. I think we need to re-retrieve the head once the page
> > refcount is bumped and locked.
>
> I think the above justification works for this.
> When the kernel reaches this line, the hugepage is properly pinned withou=
t being
> freed or demoted, so "head" is still pointing to the same head page as ex=
pected.

I think Mike's comment in the earlier email works for this too. The
huge page may get demoted before the page is pinned and locked, so the
actual hwpoisoned subpage may belong to another smaller huge page now.


>
> Thanks,
> Naoya Horiguchi
>
> >
> > > +               goto already_hwpoisoned;
> > > +
> > > +       num_poisoned_pages_inc();
> > > +
> > >         /*
> > >          * TODO: hwpoison for pud-sized hugetlb doesn't work right no=
w, so
> > >          * simply disable it. In order to make it work properly, we n=
eed
> > > @@ -1576,6 +1566,13 @@ static int memory_failure_hugetlb(unsigned lon=
g pfn, int flags)
> > >  out:
> > >         unlock_page(head);
> > >         return res;
> > > +already_hwpoisoned:
> > > +       unlock_page(head);
> > > +       pr_err("Memory failure: %#lx: already hardware poisoned\n", p=
fn);
> > > +       res =3D -EHWPOISON;
> > > +       if (flags & MF_ACTION_REQUIRED)
> > > +               res =3D kill_accessing_process(current, page_to_pfn(h=
ead), flags);
> > > +       return res;
> > >  }
> > >
> > >  static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
> > > --
> > > 2.25.1
> > >
