Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF1A57063F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiGKOw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiGKOwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:52:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29730709B9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:52:53 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h200so5100674iof.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IOmSXtIObJZCkHHKPwMtA28vY3wQaei+yVFr9ly6L/Y=;
        b=OhJZu5sWJ01VJVRnzDcozrUQv3TZwnfjvju5/n5ng4b6K85snksKvm5auSi1QeEBd3
         V5dXdPWM53I4wspOMxpxBh8yfGBtpkvXcD5e5suhLVAStn3Cs3InjEA7QUFLVdhqEvqM
         22Q7kJLW6XC9JGuMl/TqzxkFfygdZ0HzY/iWrrnaBI+lZTEH72XwEAuBQOTrf8R2G0Dn
         +oxi7kbn3/0XQbiugQE5vkpSxRWqGUbwEJkifpE5vL1dl7OQGB2RoiSrUvtL2igFEPJK
         ruIr1n20JUmJQkpuP+pUhi1RhhY6wCj+nTloaKmY9zEW/nP2bcgRuQtUlLtNs9uZt7wb
         4/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IOmSXtIObJZCkHHKPwMtA28vY3wQaei+yVFr9ly6L/Y=;
        b=OenGXu6GT8SOEBe6siMAAJAMc2ISsVazPRhTYll8qGn+FSWm6qdTf7b+p/AQtjEhgJ
         4/WHdSHJFir9S7MAZ2JPcUx6Od04YovuJMYs6hmOe/0aJlKChCtmRh8VD56xbWUJB2ZU
         RhJv7h4r4RAXoIbCJ0Xf3J4qZdGvRRrn1BMkqjjAXeBnBFPv8uyMpOXfQQYh8ptF+jLM
         hWHrQIcbntvPUf6dTNJZhTuz3Uegp3/Hdt2N4aK99l6KYNE2EYfJnXjB+3c6Vei4uL5h
         U7DYvcWVtftznijC6Z65TGjfYkUFc0zNIBCwf9pxhYzKYfWPwSnQBNj7ZvKBzcmRpLBw
         cNkQ==
X-Gm-Message-State: AJIora//x+oVbC6jnoAq3LPvmfSrp+bYctd442sqPG+pVSHDd/7XPCVB
        5DnHFOzHxUJ6k/EaJ9G9a1u5MLyAsQrXesP/sc7oKxvT5r0=
X-Google-Smtp-Source: AGRyM1vtPDdCC2NmCHaSrRsZHpu0Qwq9jZCnyJk0nWgjqHI5s0fBT26fLvZL/+8xaqrMwnL+oIQbyXXw1RgoGB1j04s=
X-Received: by 2002:a05:6638:4188:b0:33f:66d8:408b with SMTP id
 az8-20020a056638418800b0033f66d8408bmr923333jab.295.1657551172145; Mon, 11
 Jul 2022 07:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com> <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
In-Reply-To: <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
From:   Yu-Jen Chang <arthurchang09@gmail.com>
Date:   Mon, 11 Jul 2022 22:52:41 +0800
Message-ID: <CAD4RrFPihC+8LScC1RJ5GfOsLs4kze0QwALS1ykNH_m89Z1NGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
To:     Andrey Semashev <andrey.semashev@gmail.com>
Cc:     andy@kernel.org, akinobu.mita@gmail.com,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        linux-kernel@vger.kernel.org
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

Andrey Semashev <andrey.semashev@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E5=87=8C=E6=99=A84:01=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On 7/10/22 17:28, Yu-Jen Chang wrote:
> > The original version of memchr() is implemented with the byte-wise
> > comparing technique, which does not fully use 64-bits or 32-bits
> > registers in CPU. We use word-wide comparing so that 8 characters
> > can be compared at the same time on CPU. This code is base on
> > David Laight's implementation.
> >
> > We create two files to measure the performance. The first file
> > contains on average 10 characters ahead the target character.
> > The second file contains at least 1000 characters ahead the
> > target character. Our implementation of =E2=80=9Cmemchr()=E2=80=9D is s=
lightly
> > better in the first test and nearly 4x faster than the orginal
> > implementation in the second test.
> >
> > Signed-off-by: Yu-Jen Chang <arthurchang09@gmail.com>
> > Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
> > ---
> >  lib/string.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/lib/string.c b/lib/string.c
> > index 80469e6c3..8ca965431 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -905,21 +905,35 @@ EXPORT_SYMBOL(strnstr);
> >  #ifndef __HAVE_ARCH_MEMCHR
> >  /**
> >   * memchr - Find a character in an area of memory.
> > - * @s: The memory area
> > + * @p: The memory area
> >   * @c: The byte to search for
> > - * @n: The size of the area.
> > + * @length: The size of the area.
> >   *
> >   * returns the address of the first occurrence of @c, or %NULL
> >   * if @c is not found
> >   */
> > -void *memchr(const void *s, int c, size_t n)
> > +void *memchr(const void *p, int c, unsigned long length)
> >  {
> > -     const unsigned char *p =3D s;
> > -     while (n-- !=3D 0) {
> > -             if ((unsigned char)c =3D=3D *p++) {
> > -                     return (void *)(p - 1);
> > +     u64 mask, val;
> > +     const void *end =3D p + length;
> > +
> > +     c &=3D 0xff;
> > +     if (p <=3D end - 8) {
> > +             mask =3D c;
> > +             MEMCHR_MASK_GEN(mask);
> > +
> > +             for (; p <=3D end - 8; p +=3D 8) {
> > +                     val =3D *(u64 *)p ^ mask;
>
> What if p is not aligned to 8 (or 4 on 32-bit targets) bytes? Not all
> targets support (efficient) unaligned loads, do they?

I think it works if p is not aligned to 8 or 4 bytes.

Let's say the string is 10 bytes. The for loop here will search the first
8 bytes. If the target character is in the last 2 bytes, the second for
loop will find it. It also work like this on 32-bit machine.

>
> > +                     if ((val + 0xfefefefefefefeffu) &
> > +                         (~val & 0x8080808080808080u))
> > +                             break;
> >               }
> >       }
> > +
> > +     for (; p < end; p++)
> > +             if (*(unsigned char *)p =3D=3D c)
> > +                     return (void *)p;
> > +
> >       return NULL;
> >  }
> >  EXPORT_SYMBOL(memchr);
>
