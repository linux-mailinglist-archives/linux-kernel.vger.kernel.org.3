Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C854257B22D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiGTH5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiGTH53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:57:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D07C61D61;
        Wed, 20 Jul 2022 00:57:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y4so22707699edc.4;
        Wed, 20 Jul 2022 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MxntfceLQpS5cr2854ESrKtpAQ2Xc+2aoetpkswIx5M=;
        b=BVA5f/a37wVobL1NbmE4jBRc4Fm71JHdKskhzyT5Me8fyRQ85m3h8snYeW6XKh7aWG
         Iew7f37BB9DKQWUckEpkHJIei/D9i9BW8LEaIr/DDfjLQNPqUd4gaD1S2ivE5Wc+gCGf
         YH7H6gIJgMdlGarnZwPdFIUkOWJa/dBSvX3Ib4qYS62TLUzPyEiUJDBjimb8T9fjbEb4
         KelgAAfKzYznYUa3gMG7pGz4QUszMfNVXDF8MeRW+mO9IVmobZ1WGCsUANISdId9q34g
         jhHtEYKOxBaW50QcOHjErfVWEqNpeGS3NhnRHsggA6iSMzRrMBABYawZ84F8obQ4Oehq
         ALtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MxntfceLQpS5cr2854ESrKtpAQ2Xc+2aoetpkswIx5M=;
        b=6d5lAFC1i5QyZuVK9BWi9dDzwQzD7LYLbYArFkZMF/Z8wHCPa8F5bPcEc9CoHxhqjU
         c9DbAlTrG8hx7k6IOfIfMo2+8ZKytX6dGQhs/v9Ld9f59fbZwT8d+Wi+wlmHyoF+8Efp
         LCv3/dRl4t6PP8gls0YfkcStatp4GfmdZbth973liRO+B4+K6+i0cYSQ/c3QBny3z4mG
         ATgCvLDM6IwPj+EBpsFuyDjgVpNrxoA3SjyKkIbg2hJYc5cFY248I9PUtUak6ebmFKZL
         fAr88Wb6f0OOpiOUzs4p0KnQRqQ6tqWFUb5WkCzWKIKm/8RmlJ4KiWaPCNUO2VYE2ZOj
         NGXw==
X-Gm-Message-State: AJIora9SVQuRfmTtKOJ1g5bRmXoesziop7PS13WQqJRW2kgB4YDDSKOk
        Ez+7P5txV6SvKcLyjGj8f9pXGNojEEROVkr3S1A=
X-Google-Smtp-Source: AGRyM1tUd1pi9orJB1ioe7Y5BB1kbT76Q3I1kj+N8639rfVXloxvVhZR4Ii19nWsux2OUDF7P7G1UACF4E2zTk16mus=
X-Received: by 2002:a05:6402:d05:b0:435:b2a6:94eb with SMTP id
 eb5-20020a0564020d0500b00435b2a694ebmr48331581edb.87.1658303847062; Wed, 20
 Jul 2022 00:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220720072346.33511-1-dzm91@hust.edu.cn> <604f2d3f-659c-3312-d69f-c133aec275ca@wanadoo.fr>
In-Reply-To: <604f2d3f-659c-3312-d69f-c133aec275ca@wanadoo.fr>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 20 Jul 2022 15:56:16 +0800
Message-ID: <CAD-N9QUKWsRHWme+fQ8KtBXKFB=cU8spa0eu3u4iVXuOE3x5cw@mail.gmail.com>
Subject: Re: [PATCH] usb: trancevibrator: simplify tv_probe
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 3:46 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 20/07/2022 =C3=A0 09:23, Dongliang Mu a =C3=A9crit :
> > From: Dongliang Mu <mudongliangabcd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane=
.org>
> >
> > The function tv_probe does not need to invoke kfree when the
> > allocation fails. So let's simplify the code of tv_probe.
> > Another change is to remove a redundant space.
> >
> > Signed-off-by: Dongliang Mu <mudongliangabcd-Re5JQEeQqe8AvxtiuMwx3w@pub=
lic.gmane.org>
> > ---
> >   drivers/usb/misc/trancevibrator.c | 13 +++----------
> >   1 file changed, 3 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/tranc=
evibrator.c
> > index 26baba3ab7d7..30d4d774d448 100644
> > --- a/drivers/usb/misc/trancevibrator.c
> > +++ b/drivers/usb/misc/trancevibrator.c
> > @@ -84,29 +84,22 @@ static int tv_probe(struct usb_interface *interface=
,
> >   {
> >       struct usb_device *udev =3D interface_to_usbdev(interface);
> >       struct trancevibrator *dev;
> > -     int retval;
> >
> >       dev =3D kzalloc(sizeof(struct trancevibrator), GFP_KERNEL);
> > -     if (!dev) {
> > -             retval =3D -ENOMEM;
> > -             goto error;
> > -     }
> > +     if (!dev)
> > +             return -ENOMEM;
> >
> >       dev->udev =3D usb_get_dev(udev);
> >       usb_set_intfdata(interface, dev);
> >
> >       return 0;
>
> Hi,
>
> looks like:
>
> error:
>         kfree(dev);
>         return retval;
>
> at the end of the function can be removed as-well.
>

My patch actually removes them.

> Just my 2c.
>
> CJ
