Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D03357062E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiGKOue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiGKOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:50:32 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192766554C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:50:31 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e5so5124828iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2nQQyi2Y1Dyz7g7vcoV4Drg669ob6/r1QgJUbLSS7/4=;
        b=pmtSVmIXzowxFyD7MXFh4qHXxQi9j1PApnnhrBknTVUjQ8p3Yt4mX5GPmKUuVoN458
         7ywC0CpSFAAkMDcTNR0XnsIuhHerb6fqPSV5+DXwg5jTCLWAs2OIIoRzFBsZOJl132ao
         avLltGrkmmwzNhGURnU7Jaxph7lUy1zzkC9L7+aDZoL5d43rzC3E8I5jzy0OxFcNWmKA
         bTqpEt6gG7jFXfrjfvCI13C08n9lwsezuATR0fod6xiA8s3VyCrJzxAxGurIQfSbWx1a
         lM3JOCLr5k1sBv6Zy78gVDNUOqaRtzsrAMlAeMLCdR1815mbJGESv1wRc+E3b0htNQGe
         kO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2nQQyi2Y1Dyz7g7vcoV4Drg669ob6/r1QgJUbLSS7/4=;
        b=WUFYHKnJdgdeg4vAe9XvRKmvr7PzJTBSotuW2LZ6hHlPlYDZNJ4nDZsLGqHzlhXfGy
         I2lS8iOU/lIeowSUPa6A6VnvdFnVSPhLGEWqhc/29VKP1jsfmfORLT3Dos5UvRrGKzfo
         aN5a2a8rRLFYVC8slPg+dgUT4tysCBchW1afSk+3NgihH8PdTPVZ99qohC9SImGYgweA
         AOoiDk0oX7OiAxhkKptbbggCv5v9LS3uIP38eePfIurnom/dzu+VMKQFCTUBOGsNzWWt
         xyQOKt5FKCE26TNLR9/LPPH+ynXeAsyaf1bYNDKwH7cSOCkEFC0+iAX1hCbeE2xukmtt
         QgGQ==
X-Gm-Message-State: AJIora+IY54PQz9x4O7ufUZcwIxQzWatFTjMzm/Lidcj11QAmAOdtD79
        EPbcYl36HIFJ+on6p/j9TLRRkDraUU4vaR/89Z4=
X-Google-Smtp-Source: AGRyM1vJu2fLe8POaa5J0TsGCKK+09HMPkLCW9bZkbI0Ho5UBUyGTGHkf9Wal9RpHJxsUvMrIF/eZYjJ06X2ycEOo/U=
X-Received: by 2002:a05:6638:3829:b0:33f:5c61:650e with SMTP id
 i41-20020a056638382900b0033f5c61650emr2038325jav.185.1657551030446; Mon, 11
 Jul 2022 07:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com> <75e3bb4f88fa43097540f3e2023df8388def5719.camel@perches.com>
In-Reply-To: <75e3bb4f88fa43097540f3e2023df8388def5719.camel@perches.com>
From:   Yu-Jen Chang <arthurchang09@gmail.com>
Date:   Mon, 11 Jul 2022 22:50:19 +0800
Message-ID: <CAD4RrFPbT=R7rYZhN=9JFtTnaupVjrU3F+JN+Yuxzw2ns_AHBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
To:     Joe Perches <joe@perches.com>
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

Joe Perches <joe@perches.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=8810=E6=97=A5 =
=E9=80=B1=E6=97=A5 =E6=99=9A=E4=B8=8A11:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sun, 2022-07-10 at 22:28 +0800, Yu-Jen Chang wrote:
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
>
> It seems you did not test this with 32bit compilers as
> there are 64 bit constants without ull

Yeah, it is better to add ull at the end of the constant. I test with
32-bit compiler and it works. The compiler will use two or more
instruction to reach the same result.

See https://godbolt.org/z/svbj18foP

>
> > diff --git a/lib/string.c b/lib/string.c
> []
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
> > +                     if ((val + 0xfefefefefefefeffu) &
> > +                         (~val & 0x8080808080808080u))
>
> here.
>
