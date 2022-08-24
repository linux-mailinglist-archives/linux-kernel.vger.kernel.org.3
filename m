Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0458F59F3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiHXGlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiHXGlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:41:20 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD5A85AA9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:41:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w13so9132501pgq.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=B//9714xaO/5VkQGzcWcTijzTIFauq5s4YCnkbmyNc4=;
        b=GDOPO5ZaTaBCu4Ge4iuppxOjKMpjH89pxRTToKJeiiaN3rmBPYnHSZjZ3/jcfT/tsH
         Cyj/mciJKez8LyJM/BVvnjgZ46vckaerlkTbieBUUXok846PNdDbu5lS7KQC5ExOek5h
         LeMT7HNnjINsD33/2UHfZQWPxFalFEwKtpq7M3bhTbotjxFcUYhW4ughJEWqemdSkvVR
         /hCkTCxOzra3zXaK6eYPAbNDMnMl87A+gKxRo0AhIMZXLVPmeqTqFF4rFXYfjEy95Lyh
         VsfxyHnF1aYJLi2fv7c4ejf/BmXC6564OkTBYBk64tkSHvmh27FXxMTvHr64ugw41r5P
         Hdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=B//9714xaO/5VkQGzcWcTijzTIFauq5s4YCnkbmyNc4=;
        b=uLRXZolRN/ktjFfvdEvOKkUxzZT0zX9Z2HKU9BXfpcRBtTKZRVbb91deN8PpsIdFkO
         HzvRuQIevy6o23VW/ZftRcS2dFu0nbwlRrpwUKlwTshFNfcFtAF+r8KnaIo18OGdQNdU
         p3lzLpQ6Ug5grZw+W+E24NtqeLYo0ibkc5VzKaGIvJA+Dm9FVHngIZBb8txeUQExHST1
         szM8SqcEVfOmvuMzB/GkgH0Y/3Ng5bdCEmcwJ47YjcsXbAIFK3ju9X8gldi3FqKuFAQN
         T9HqxVN+rq1ZpWULU6T8PVg2CjG1nr3rSARjf+4kl2bpIXd4QZmNV9gQpMUVeQu08n33
         lJDQ==
X-Gm-Message-State: ACgBeo0YyYsXTkJfS4lSaY6qOQDHEgJXnEfmisvIcc6EpUblKLgNv0kV
        3IY4Cbcayp3ZGg+VxS5NsUS49BkOEOtSzlzTX20=
X-Google-Smtp-Source: AA6agR5HV3c2GD1bpoxv+vW6nCKqor7aFcKdjH5yX8BpYdBK0SaVWw3dv3UN9bfwRdao8wHgB/M40vZp92skImwpnFM=
X-Received: by 2002:a63:f24e:0:b0:41d:7381:ee6b with SMTP id
 d14-20020a63f24e000000b0041d7381ee6bmr22899269pgk.305.1661323279512; Tue, 23
 Aug 2022 23:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220824055637.10676-1-zhouzhouyi@gmail.com> <8d8bfc81-b584-20f4-65ae-d626f019cdf4@csgroup.eu>
In-Reply-To: <8d8bfc81-b584-20f4-65ae-d626f019cdf4@csgroup.eu>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 24 Aug 2022 14:41:08 +0800
Message-ID: <CAABZP2w7jw4OHXPDANNabaD1L1BbUG8ymu9zLGEt5xA8YgZ3ow@mail.gmail.com>
Subject: Re: [PATCH linux-next] mm: fix used but uninitialized variable
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank Christophe for reviewing my patch

On Wed, Aug 24, 2022 at 2:10 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 24/08/2022 =C3=A0 07:56, Zhouyi Zhou a =C3=A9crit :
> > In function walk_hugetlb_range, the local variable err may
> > be used uninitialzed when:
> > ops->pte_hole in side of "else if (ops->pte_hole)" is false.
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> > Dear mm Developers:
> >
> > When I build kernel using "make CC=3Dclang-14"
> > the compiler complains following:
> >
> > CC      mm/pagewalk.o
> > mm/pagewalk.c:318:12: error: variable 'err' is used uninitialized whene=
ver 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> >                  else if (ops->pte_hole)
> >                           ^~~~~~~~~~~~~
> > mm/pagewalk.c:321:7: note: uninitialized use occurs here
> >                  if (err)
> >                      ^~~
> > mm/pagewalk.c:318:8: note: remove the 'if' if its condition is always t=
rue
> >                  else if (ops->pte_hole)
> >                       ^~~~~~~~~~~~~~~~~~
> > mm/pagewalk.c:311:10: note: initialize the variable 'err' to silence th=
is warning
> >                  int err;
> >                         ^
> >                          =3D 0
> > 1 error generated.
> > make[1]: *** [scripts/Makefile.build:250: mm/pagewalk.o] Error 1
> > make: *** [Makefile:2006: mm] Error 2
> >
> > I initialize that variable outside of the for loop because we can assig=
n 0 to err
> > only once in this function.
> >
> > After my fix, I can compile the kernel.
> >
> > Many Thanks
> > Zhouyi
> > --
> >   mm/pagewalk.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index 54b2a1beeeb3..b6eb330e8ecd 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -306,9 +306,9 @@ static int walk_hugetlb_range(unsigned long addr, u=
nsigned long end,
> >       unsigned long hmask =3D huge_page_mask(h);
> >       unsigned long sz =3D huge_page_size(h);
> >       const struct mm_walk_ops *ops =3D walk->ops;
> > +     int err =3D 0;
>
> Why do you move it back outside of the for loop allthough it is
> exclusively used inside the loop ?
I move it outside of the for loop for performance consideration. Because
if we initialize err inside, there will be an assignment statement
every iteration.
>
> >
> >       for (; addr < end; addr =3D next) {
> > -             int err;
>
> Another solution would be to add an explicit else, setting err =3D 0 in
> the if/else if sequence.
Thank Christophe for your valuable advice, I am going to prepare a 2nd vers=
ion

Thanks
Zhouyi
>
> >               pte_t *pte =3D huge_pte_offset(walk->mm, addr & hmask, sz=
);
> >
> >               next =3D hugetlb_entry_end(h, addr, end);
