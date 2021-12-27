Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041ED47FC59
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 12:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbhL0LxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 06:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbhL0LxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 06:53:10 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F93AC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 03:53:10 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id y130so19531407ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 03:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2wtn22ZQj6nuMCA7EcfwmmH3vdiJIuziM7/bdnMli9k=;
        b=Ri5e+o+okzSSjDYY+xR11iW1su1dChz4alrWdMbn9swQnKc827HKuuXkhUEj1nN/BF
         GZNQTe0NPa5UGp7Jj2LN9Febrtv3hpCrl5Ih/Q/XSN42+tOO51JZTi347flO+1x3HXTu
         DuTGGSaUCZEcwT7POo2SrPcTKjZxgmL/BI9Z32IUuAyoK4Io6U5n+TMbBCENDd2iNKcp
         J2SsdwFR54mea0VFVAlH2fiw9XYJCnFk6bTyOO2zLfginxOLEF0cpssyk/D3wBq45S9N
         qo1S8Kxiyqk0mPSEi78deeNZ0+m5PRffoF1DRp/2HjOwiWBUgmIZu3AMpQ+MEUAo5SDT
         tkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2wtn22ZQj6nuMCA7EcfwmmH3vdiJIuziM7/bdnMli9k=;
        b=8JiJUbKox0Ty5/BNmemtxjy8y9Nbs2ZzzXeIS99bLPRhCFddmk32neuAL3kvQ8/nwL
         812DsWxdVwTG0JwvAEDQvTHgTMwRvV8ZneeM66y66SYJ+tGqhcocER6qUmIrNTgyEHvv
         fjM7qYxGzjXGaa0SfBwDa4LOVDksvBYfu0dOFddqryKmgnhBJaqkCmkXYVTKWH6OOj+f
         D3UztwCZhodaTMvoR+ZNy168i3+XlRG/+B7cxAnw/2OUNzE6OYjkoWdp9FtaRSmglAyo
         3RyIOQTp3lU5Rs1G7Jr/kHTf0UvZKfWuBPdwXsbsvats4jeggjq5Na5rNST5vNkerDJK
         DK4g==
X-Gm-Message-State: AOAM530SYF7EpMNigtbSwfib5TUIcwep3vNqI3C7321fED5I3f23VvHn
        vhkl0vpO1TS9++uU1NGMCQn5f8RZQADh4VCtbLMLpEH+PkuIyZF9
X-Google-Smtp-Source: ABdhPJzbp6+zVfGc/ClBvGcpyCmS4UFR+CzLYqoiZd0+pr+fXJCpvkYhLIZJkUSja9kFFwbC0U80j7ZIjQ5VM/uklXI=
X-Received: by 2002:a25:7742:: with SMTP id s63mr2983187ybc.242.1640605989141;
 Mon, 27 Dec 2021 03:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20211227090917.35838-1-hbh25y@gmail.com> <87h7aus8v0.fsf@igel.home>
In-Reply-To: <87h7aus8v0.fsf@igel.home>
From:   Hangyu Hua <hbh25y@gmail.com>
Date:   Mon, 27 Dec 2021 19:52:58 +0800
Message-ID: <CAOo-nLJG71QqqD0-cJDyH0rY2VTx1eO9nHVQ5MCe8J0iiME_vw@mail.gmail.com>
Subject: Re: [PATCH] m68k/kernel: array out of bound access in process_uboot_commandline
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

But commandp[len -1] is used to add a zero-terminated. If we don't use
commandp[0]=3D0 in len =3D=3D 0,
than commandp will not have a zero-terminated. I think strings may
make some errors beacause of this.

Thanks.


Andreas Schwab <schwab@linux-m68k.org> =E4=BA=8E2021=E5=B9=B412=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=B8=80 17:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On Dez 27 2021, Hangyu Hua wrote:
>
> > diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
> > index 928dbd33fc4a..05eca6f653b5 100644
> > --- a/arch/m68k/kernel/uboot.c
> > +++ b/arch/m68k/kernel/uboot.c
> > @@ -101,5 +101,8 @@ __init void process_uboot_commandline(char *command=
p, int size)
> >       }
> >
> >       parse_uboot_commandline(commandp, len);
> > -     commandp[len - 1] =3D 0;
> > +     if (len > 0)
> > +             commandp[len - 1] =3D 0;
> > +     else
> > +             commandp[0] =3D 0;
>
> If len =3D=3D 0 then even commandp[0] is OOB.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
