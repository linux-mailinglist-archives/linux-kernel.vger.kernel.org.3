Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A6A4D50E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244937AbiCJRv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbiCJRvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:51:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFAE13397D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:50:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cx5so5955095pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3M3YBTPk1tjfk10JDkzUkRyFGOgVlE5988An5HSRp3g=;
        b=RMfrtH088l/fulXIlWNXa3Ymz+Ooam6s4LhkhpdzqNo3LlYJj1vwu+B8OaK+0ypuq1
         MMmCQo9WKR41chURgj19pOj7jtXKuhoRu6P1WRxp3KJAMiqeoq9V84dGBs53gLn2kgNE
         ORcYgWCegAfDAuPsCwPqGEwQqt06xv5KfzO7smzBeWLCMHjOjcvW45qKLbAz18WTeRGS
         N3toz9OVlNQV10NaNGpXW8exb7TIN5vx12GwIzyvB96pVQACa99rqpHcZdB2EcfuVasD
         Grpl+Pz/rdjD1fc8r7zzXcldmvQQxiAIQ21U5iq0bGZxTUSm4Yc1ElUwMiWu2bIpomEo
         D6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3M3YBTPk1tjfk10JDkzUkRyFGOgVlE5988An5HSRp3g=;
        b=0OPvyB9B7msJa+K9e6PhHqhbfNx8WnNnHqClNmjIaPVDjqvNTTHhE6zv/c3JcZPr/p
         N6FNfqjRfvPRogEz9jQq+f0tej4LjuibVYDI2I9gBYVWSHmPjtft2WwM5NoOVUfgKWx3
         pxgeT44f0FiRqfv8SNxJemz3ld2GprwWHzchORpeTWe6jTKT4Xxq5lwPTyGgCaexIm5F
         0nyZ20ROFd/w/ef0+IkosrQaks6lu16R3OZBoobVSbt9DjqNNL4dMYCAWbS5JB7s/aL0
         KOND7gPIcIAzfsYEVdu7ceb85+eoYmlSMtw4sOZuR83FvdquV4lFsQ1kD8DMWrJIvixy
         Y2Ig==
X-Gm-Message-State: AOAM530ynOs+ZITs2Uu+anRqFpp9VVRM94NNmX2hUt671Ar3peOC56mP
        mVHbRXPWEi6AGD3zmlGm7rMAYY6AQFyXf1+g4qFPIMklYhM=
X-Google-Smtp-Source: ABdhPJy2qBrVsUcdV+O+QA7KSmpVY761GhXicbgvxWExdju/uZESfiLW+gOoZm+yGkvcov3OIchzWcoN8n6+uko5w9M=
X-Received: by 2002:a17:902:bc47:b0:151:ac43:eae0 with SMTP id
 t7-20020a170902bc4700b00151ac43eae0mr6387435plz.117.1646934623070; Thu, 10
 Mar 2022 09:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20220309091449.2753904-1-naoya.horiguchi@linux.dev>
 <CAHbLzkrmHS+nPbw1YZj-rE-ECgRr2nD40d-ZbxPvf05o-rmNcA@mail.gmail.com>
 <20220310000024.GA1577304@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkpWV4oP86oe4BXop20KMJqwEmSkpFmZfT+q38hs90oqKA@mail.gmail.com>
 <2a61c5c1-a99b-9da9-b319-90f95a420ab1@huawei.com>
In-Reply-To: <2a61c5c1-a99b-9da9-b319-90f95a420ab1@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 10 Mar 2022 09:50:11 -0800
Message-ID: <CAHbLzkpXOYKQtN6xjSKShD8_h_dLy3GA6MZB9rLMvsXC3seERg@mail.gmail.com>
Subject: Re: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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

On Wed, Mar 9, 2022 at 10:24 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/3/10 8:30, Yang Shi wrote:
> > On Wed, Mar 9, 2022 at 4:01 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=
=80=E7=9B=B4=E4=B9=9F)
> > <naoya.horiguchi@nec.com> wrote:
> >>
> >> On Wed, Mar 09, 2022 at 01:55:30PM -0800, Yang Shi wrote:
> >>> On Wed, Mar 9, 2022 at 1:15 AM Naoya Horiguchi
> >>> <naoya.horiguchi@linux.dev> wrote:
> >>>>
> >>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> >>>>
> >>>> There is a race condition between memory_failure_hugetlb() and huget=
lb
> >>>> free/demotion, which causes setting PageHWPoison flag on the wrong p=
age
> >>>> (which was a hugetlb when memory_failrue() was called, but was remov=
ed
> >>>> or demoted when memory_failure_hugetlb() is called).  This results i=
n
> >>>> killing wrong processes.  So set PageHWPoison flag with holding page=
 lock,
> >>>>
> >>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> >>>> ---
> >>>>  mm/memory-failure.c | 27 ++++++++++++---------------
> >>>>  1 file changed, 12 insertions(+), 15 deletions(-)
> >>>>
> >>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >>>> index ac6492e36978..fe25eee8f9d6 100644
> >>>> --- a/mm/memory-failure.c
> >>>> +++ b/mm/memory-failure.c
> >>>> @@ -1494,24 +1494,11 @@ static int memory_failure_hugetlb(unsigned l=
ong pfn, int flags)
> >>>>         int res;
> >>>>         unsigned long page_flags;
> >>>>
> >>>> -       if (TestSetPageHWPoison(head)) {
> >>>> -               pr_err("Memory failure: %#lx: already hardware poiso=
ned\n",
> >>>> -                      pfn);
> >>>> -               res =3D -EHWPOISON;
> >>>> -               if (flags & MF_ACTION_REQUIRED)
> >>>> -                       res =3D kill_accessing_process(current, page=
_to_pfn(head), flags);
> >>>> -               return res;
> >>>> -       }
> >>>> -
> >>>> -       num_poisoned_pages_inc();
> >>>> -
> >>>>         if (!(flags & MF_COUNT_INCREASED)) {
> >>>>                 res =3D get_hwpoison_page(p, flags);
> >>>
> >>> I'm not an expert of hugetlb, I may be wrong. I'm wondering how this
> >>> could solve the race? Is the below race still possible?
> >>>
> >>> __get_hwpoison_page()
> >>>   head =3D compound_head(page)
> >>>
> >>> hugetlb demotion (1G --> 2M)
> >>>   get_hwpoison_huge_page(head, &hugetlb);
> >>
> >> Thanks for the comment.
> >> I assume Miaohe's patch below introduces additional check to detect th=
e
> >> race.  The patch calls compound_head() for the raw error page again, s=
o
> >> the demotion case should be detected.  I'll make the dependency clear =
in
> >> the commit log.
> >>
> >> https://lore.kernel.org/linux-mm/20220228140245.24552-2-linmiaohe@huaw=
ei.com/
> >>
> >>>
> >>>
> >>> Then the head may point to a 2M page, but the hwpoisoned subpage is
> >>> not in that 2M range?
> >>>
> >>>
> >>>>                 if (!res) {
> >>>>                         lock_page(head);
> >>>>                         if (hwpoison_filter(p)) {
> >>>> -                               if (TestClearPageHWPoison(head))
> >>>> -                                       num_poisoned_pages_dec();
> >>>>                                 unlock_page(head);
> >>>>                                 return -EOPNOTSUPP;
> >>>>                         }
> >>>> @@ -1544,13 +1531,16 @@ static int memory_failure_hugetlb(unsigned l=
ong pfn, int flags)
> >>>>         page_flags =3D head->flags;
> >>>>
> >>>>         if (hwpoison_filter(p)) {
> >>>> -               if (TestClearPageHWPoison(head))
> >>>> -                       num_poisoned_pages_dec();
> >>>>                 put_page(p);
> >>>>                 res =3D -EOPNOTSUPP;
> >>>>                 goto out;
> >>>>         }
> >>>>
> >>>> +       if (TestSetPageHWPoison(head))
> >>>
> >>> And I don't think "head" is still the head you expected if the race
> >>> happened. I think we need to re-retrieve the head once the page
> >>> refcount is bumped and locked.
> >>
> >> I think the above justification works for this.
> >> When the kernel reaches this line, the hugepage is properly pinned wit=
hout being
> >> freed or demoted, so "head" is still pointing to the same head page as=
 expected.
> >
> > I think Mike's comment in the earlier email works for this too. The
> > huge page may get demoted before the page is pinned and locked, so the
> > actual hwpoisoned subpage may belong to another smaller huge page now.
> >
>
> I thinks Naoya assumes that there is a check before we use "head":
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5444a8ef4867..0d7c58340a98 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1534,6 +1534,17 @@ static int memory_failure_hugetlb(unsigned long pf=
n, int flags)
>         }
>
>         lock_page(head);
> +
> +       /**
> +        * The page could have changed compound pages due to race window.
> +        * If this happens just bail out.
> +        */
> +       if (!PageHuge(p) || compound_head(p) !=3D head) {
> +               action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED)=
;
> +               res =3D -EBUSY;
> +               goto out;
> +       }
> +
>         page_flags =3D head->flags;
>
>         if (hwpoison_filter(p)) {
> --
> from: https://lore.kernel.org/linux-mm/20220228140245.24552-2-linmiaohe@h=
uawei.com/

Aha, thanks, I missed that. Yeah, we definitely need to revalidate the page=
.

>
> Thanks.
>
> >
> >>
> >> Thanks,
> >> Naoya Horiguchi
> >>
> >>>
> >>>> +               goto already_hwpoisoned;
> >>>> +
> >>>> +       num_poisoned_pages_inc();
> >>>> +
> >>>>         /*
> >>>>          * TODO: hwpoison for pud-sized hugetlb doesn't work right n=
ow, so
> >>>>          * simply disable it. In order to make it work properly, we =
need
> >>>> @@ -1576,6 +1566,13 @@ static int memory_failure_hugetlb(unsigned lo=
ng pfn, int flags)
> >>>>  out:
> >>>>         unlock_page(head);
> >>>>         return res;
> >>>> +already_hwpoisoned:
> >>>> +       unlock_page(head);
> >>>> +       pr_err("Memory failure: %#lx: already hardware poisoned\n", =
pfn);
> >>>> +       res =3D -EHWPOISON;
> >>>> +       if (flags & MF_ACTION_REQUIRED)
> >>>> +               res =3D kill_accessing_process(current, page_to_pfn(=
head), flags);
> >>>> +       return res;
> >>>>  }
> >>>>
> >>>>  static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
> >>>> --
> >>>> 2.25.1
> >>>>
> > .
> >
>
