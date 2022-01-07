Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CF8487091
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345486AbiAGCh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345477AbiAGCh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:37:58 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D59C061245;
        Thu,  6 Jan 2022 18:37:57 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id p5so5578050ybd.13;
        Thu, 06 Jan 2022 18:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wypQ1B8KjY0Soft/ehKx+C81O0i047qr+0bKMSezlyE=;
        b=ZSX0AjZWzsMncHFPoSX4wVtu1ShqU4f2e74sB1+uyHDZK78jKKLH1ISljHHZRTTwTc
         25HA7V46+Qj8snps1JcRhzt6PKLKnLnCi7Zlw0CdDNrAIXZGPudIYybqRL0bls3RfqHq
         /Kzegt1a3hUCQ0P5NIENkt5M6O0Vv2ftw4l3GbPZOQ5a0RVu68x8l/NHHNuHJ4Q3if+7
         s1fMTHNiLdU4QtQ8bhRYKSvLioICBuQIKjJvkRWY35gi/T8u6sUd7LIlqIyQOXGYj+Pb
         Nd1icj15dEzjRsVPJuJGHxwK3Y0gmsVtNYiG9ecBfV7J7svkunGnj728nIrXZvIe2FvT
         2ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wypQ1B8KjY0Soft/ehKx+C81O0i047qr+0bKMSezlyE=;
        b=4ZWuj0lO6z835oxY9ew72p3n4KD+kxbzoEZJVH84o7hy1jSFZwJkU+Icrprz4xr5xc
         oN6sBeGvq/a6uDQVHqO0Q8uEq6XdW/3NKylH1cH3VpiQzp2hAjuDekPG86QgDNFmwrti
         0ZADNBD2ibJJ6CLBaQ8Y87n9aN03gJ95QUl4KMWkgtA2sddfe+oxZHAnjFhLbM5QZ/OT
         Uu+mU+/k7NhafASt3c5YVam2x3kdA3rS44AmaqEx0qAC9bGgSMO01sl/YdRkbtu8Nasc
         RT4tQ3baP7bWTSU/5mnU884Rl7mT9+Fu/pE6rZPHjqALWXgrJPasd94M7liorbNVSWXQ
         R0eA==
X-Gm-Message-State: AOAM533xZvD2u3hcmdrpnAWQqjiHvFQBtexqgn954iLTuvqYTSc5X0VH
        eXu8f6PqgV2kqbyWC0sJcmvOwcVlsUGmfyyKJuE=
X-Google-Smtp-Source: ABdhPJybXPBDx44szVsqBODATOKTyxDlPIW2nev+koeFPjJaw5evJtOELlJDPHAZrh6W02kLH7gbmQMEad0DAT9uxNs=
X-Received: by 2002:a25:8a:: with SMTP id 132mr63689371yba.738.1641523077116;
 Thu, 06 Jan 2022 18:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20220105040439.3182-1-jj251510319013@gmail.com> <Ydb+L+wXfKzXyma9@kroah.com>
In-Reply-To: <Ydb+L+wXfKzXyma9@kroah.com>
From:   =?UTF-8?B?6Zmz5YGJ6YqY?= <jj251510319013@gmail.com>
Date:   Fri, 7 Jan 2022 10:37:19 +0800
Message-ID: <CAJwFiG+caDOp48R+EMATi9W_hCt-SBoEeeeEK8XGuRWai=bYug@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: function: Fix returning incorrect PNP string
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        balbi@kernel.org,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2022=E5=B9=B41=E6=9C=886=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:35=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, Jan 05, 2022 at 12:04:39PM +0800, Wei Ming Chen wrote:
> > There will be 2 leading bytes indicating the total length of
> > the PNP string, so I think we should add value by 2, otherwise
> > the PNP string copied to user will not contain the last 2 bytes
> >
> > Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> > ---
> >  drivers/usb/gadget/function/f_printer.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadg=
et/function/f_printer.c
> > index abec5c58f525..3fb00fd0b5ee 100644
> > --- a/drivers/usb/gadget/function/f_printer.c
> > +++ b/drivers/usb/gadget/function/f_printer.c
> > @@ -1005,9 +1005,11 @@ static int printer_func_setup(struct usb_functio=
n *f,
> >                               break;
> >                       }
> >                       value =3D strlen(dev->pnp_string);
> > +                     memcpy(buf + 2, dev->pnp_string, value);
> > +
> > +                     value +=3D 2;
> >                       buf[0] =3D (value >> 8) & 0xFF;
> >                       buf[1] =3D value & 0xFF;
> > -                     memcpy(buf + 2, dev->pnp_string, value);
> >                       DBG(dev, "1284 PNP String: %x %s\n", value,
> >                           dev->pnp_string);
> >                       break;
> > --
> > 2.25.1
> >
>
> Are you sure this is correct?
>
> How is this related to this recent thread:
>         https://lore.kernel.org/all/CAKjGFBUdjXcZoVV4jdrgTz4rKThTfZAK4Cqr=
eKmBZ4KHE+K1GA@mail.gmail.com/#t
>
> your change is different from what is proposed there, why?

I didn=E2=80=99t notice this thread before I send this patch, I think the
concept of my change is similar to Volodymyr Lisivka=E2=80=99s change, he/s=
he
introduced a separate variable for the PNP string length, I think it
may be clearer and more readable than just =E2=80=9Cvalue +=3D 2=E2=80=9D


Another thing that I am not too sure whether I am correct is this line of c=
ode

DBG(dev, "1284 PNP String: %x %s\n", value,
                             dev->pnp_string);

What Volodymyr Lisivka changed is like this

DBG(dev, "1284 PNP String: %x %s\n", pnp_length,
                             dev->pnp_string);

In my change, =E2=80=9Cvalue=E2=80=9D equals to =E2=80=9Cpnp_length + 2=E2=
=80=9D in Volodymyr
Lisivka=E2=80=99s change, and I think we should print =E2=80=9Cthe PNP stri=
ng length +
2=E2=80=9D instead of =E2=80=9Cthe PNP string length=E2=80=9D?


>
> thanks,
>
> greg k-h

thanks,

Wei Ming Chen
