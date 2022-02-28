Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AB14C617D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiB1C76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiB1C74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:59:56 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7B139B82
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 18:59:19 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id d21so17705714yba.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 18:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=34pLy5corG+HXHvvIyE030KIDUh7wwaXX8KPYqoWC0k=;
        b=FwVj6ufawxpi9pivekPtYpQj4eJVmPnKCPuxl4736Po6Y/uSYhIfoMzOaKPvSMRWVQ
         KZ+Hkhg/J80BJsFx6+KlrdIPggrxm850i3K459gfcxdjFulSiQzFG6bwa3PHlzP0rmUX
         lT6UtPnBk/aioeF7Se4Xt5/y8ZEJVKwT3//EUdyI0JNF8KOsT6EODS3St71J/OZwri4T
         6plDDOHax8EX7NNPy45F0h+dNA3FL5F42ZlzMH2d4e+LI8kNynY5D2JWgpFHGATzYCt4
         D6gAxLzpSfWc8SpHWcpQiQ8HH9wtnBmL/V9tiDAQOw5ZCraXzXy9tRSC5Dc+Aizwj40e
         AjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=34pLy5corG+HXHvvIyE030KIDUh7wwaXX8KPYqoWC0k=;
        b=uzplzUJmwk2hOROICKCnaF6R0H4IYTV7+xdTiREYCrMWFMPxn1HmQWSV9WnoL8inDr
         C31lHUReFiHdgGRqwHrKnEREHUmKXOIzIcEBdlV/2UgMbn2oI3SROI+Etr9ZcC9K4Fjk
         dZXKB5E3+TvijaE9UBnMgdGokaF3peM1T9qGpNqOwuSjcYkgwxwyoPyMS5H/3WgQuDr+
         huhxg/0WAYOJ+enEFH6dbJsAkLnpRoFJb/wwAtaBzIrZjq+5xVvhQRjvK2T3Ee+28LTZ
         h4o23wdkN07I6ntxQjj+ux/e67mdMt5+eg51axgf9wuhF7ZbLTXIRw3CtQtpnwm7uhrC
         S44g==
X-Gm-Message-State: AOAM533dmoYThXzrXc8JAa59d+3giV8dnsPF8ATXRF2oV9pDoVkLY2La
        KhwfWorI3JLNUlhWS58czMlZvjsK9l8BGhsaaFg=
X-Google-Smtp-Source: ABdhPJx17uih3i6ODEN3id8kh8gZFy9yeB6zIG9sWlB4vQQnbYHTsmfDrwmGXujKHoes/ym712n0m7bo4NmvUjdoTSQ=
X-Received: by 2002:a25:c00b:0:b0:624:4382:9d0a with SMTP id
 c11-20020a25c00b000000b0062443829d0amr16841787ybf.436.1646017158396; Sun, 27
 Feb 2022 18:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20220209134018.8242-1-liuyuntao10@huawei.com> <95d1dc4e-fc3b-fe3c-5d85-218a7410e966@oracle.com>
In-Reply-To: <95d1dc4e-fc3b-fe3c-5d85-218a7410e966@oracle.com>
From:   Zhenguo Yao <yaozhenguo1@gmail.com>
Date:   Mon, 28 Feb 2022 10:59:07 +0800
Message-ID: <CA+WzARn63QzU0h2NfPDzgk=fs5=uiHHGaXZcye+qmGyLWRoFog@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: fix a truncation issue in hugepages parameter
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     liuyuntao <liuyuntao10@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, wuxu.wu@huawei.com,
        fangchuangchuang@huawei.com, windspectator@gmail.com
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

Mike Kravetz <mike.kravetz@oracle.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=8810=
=E6=97=A5=E5=91=A8=E5=9B=9B 08:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2/9/22 05:40, liuyuntao wrote:
> > From: Liu Yuntao <liuyuntao10@huawei.com>
> >
> > When we specify a large number for node in hugepages parameter,
> > it may be parsed to another number due to truncation in this statement:
> >       node =3D tmp;
> >
> > For example, add following parameter in command line:
> >       hugepagesz=3D1G hugepages=3D4294967297:5
> > and kernel will allocate 5 hugepages for node 1 instead of ignoring it.
> >
> > I move the validation check earlier to fix this issue, and slightly
> > simplifies the condition here.
> >
> > Fixes: b5389086ad7be0 ("hugetlbfs: extend the definition of hugepages p=
arameter to support node allocation")
> > Signed-off-by: Liu Yuntao <liuyuntao10@huawei.com>
> > ---
> >  mm/hugetlb.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 61895cc01d09..0929547f6ad6 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4159,10 +4159,10 @@ static int __init hugepages_setup(char *s)
> >                               pr_warn("HugeTLB: architecture can't supp=
ort node specific alloc, ignoring!\n");
> >                               return 0;
> >                       }
> > +                     if (tmp >=3D nr_online_nodes)
> > +                             goto invalid;
> >                       node =3D tmp;
>
> I am surprised none of the automated checking complained about that
> assignment.
>
> >                       p +=3D count + 1;
> > -                     if (node < 0 || node >=3D nr_online_nodes)
>
> I can't remember, but I think that check for node < 0 was added to handle
> overflow during the above assignment.  Do you remember Zhenguo Yao?
>
Sorry for my late reply.  This check for node < 0 was added
to handle node parameter overflow from the earliest version:
https://lore.kernel.org/lkml/20210820030536.25737-1-yaozhenguo1@gmail.com/
Parameter of node allocation was:  hugepages_node=3Dxx hugepages=3Dxx at th=
is
version. With the changing of the code, this check has lost its effect.

> > -                             goto invalid;
> >                       /* Parse hugepages */
> >                       if (sscanf(p, "%lu%n", &tmp, &count) !=3D 1)
> >                               goto invalid;
>
> Thanks,
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>
> --
> Mike Kravetz
