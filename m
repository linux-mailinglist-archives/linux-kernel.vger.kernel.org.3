Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9547679A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhLPB4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhLPB4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:56:41 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F24C061574;
        Wed, 15 Dec 2021 17:56:41 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z5so81921622edd.3;
        Wed, 15 Dec 2021 17:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EQBUB2ACklwhR+QWAcWKGTDjdT61AMlQl9smcE+d7t4=;
        b=IC0U+5dHCgzWTTXcqdY9ZnJ5m4A+4Zvvtqg5Kx572pZsQ0rFhY+Peew2M/VKqsXGk1
         L45df0EQZeQeKDp+vIo3iOwJVvukYoElpHAHf0cqsAn+sDk9wdrkX7pw6yUU8fu49xFs
         XVZlZMHETKCJnexfJEBgaGscXlW8t03fB6u9fsjRMwoV5pKKCZb0bsW846e6Xq6XhUQz
         kolDEI4GedxumhZ6FaGVjER6UNmJ2vhkN9fWvIFxK8Kjl61ltOnNHHLaueiijWQBJGPu
         npYCFqgrQ6id/ERSn88tUYu8J+0ZAc0akp4utdil0lwNYOPsgLcbhIzyuUznM+FLD83I
         1q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQBUB2ACklwhR+QWAcWKGTDjdT61AMlQl9smcE+d7t4=;
        b=HQC93i2Vl9frjp8aYWeJGbtZpf3+jtVNhbJHsBCyapOw+I3haOHjUVyU2E+/XKUrB5
         IIkvfu4sAyDtQMj7C5qXhZIyu744QKKX0D3YZ/ceSqmqTI6QwLmV2q4r5Liao+wfW6fD
         ixvTYYYY1xoJEEHr9esyUqK0hfcfXQmJYNPHd2UczsHo98IVJIS9TK9WNDRaW3k0KXku
         LyparXlThEGQWhJ7B5TTArA2myj0WDppTh2jxe9IXzpi3CfrdC9mzA8HiuHbhwhwl/6a
         vuQoBBemtBkq7tvBRrRCgmmGxZV+RJJ1RGbHUB2r4W1jImNIMAtu0SEWSeE/NdIIgFDQ
         a6UQ==
X-Gm-Message-State: AOAM531WJ45TrhnxrHJwYw5DlsZm5JcR55Hy2n3P/T4tpXWi6OoW3+jd
        68u2BFwRjnNpTDPB+Snu1fLFD7h/FTuwORxr5utwrLvNnRz5rg==
X-Google-Smtp-Source: ABdhPJxvpMNrt4v3vwavM+prMY817HnRGLE0wfFbTTjew7PvcylfUxZu2Ubz4aoxUM081ltNdSng5y/v914pAWjvmjs=
X-Received: by 2002:a05:6402:405:: with SMTP id q5mr18125176edv.62.1639619799667;
 Wed, 15 Dec 2021 17:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20211116163208.75879-1-mudongliangabcd@gmail.com> <20211214143204.4b574351@coco.lan>
In-Reply-To: <20211214143204.4b574351@coco.lan>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 16 Dec 2021 09:56:13 +0800
Message-ID: <CAD-N9QXR2aPpFgpXTNR+jbpNhW1d8OqhB_cdyNVm1b85pmxKZg@mail.gmail.com>
Subject: Re: [PATCH] media: msi2500: fix UAF in the msi2500_disconnect
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Antti Palosaari <crope@iki.fi>, linux-media@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 9:32 PM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> Em Wed, 17 Nov 2021 00:32:07 +0800
> Dongliang Mu <mudongliangabcd@gmail.com> escreveu:
>
> > In msi2500_probe, it invokes spi_alloc_master to allocate master
> > controller and spi_register_master to register master controller.
> > Then in msi2500_disconnect, it calls spi_unregister_master to unregister
> > the master controller. And in spi_unregister_master, it calls put_device
> > to decrease the refcount and the device object will be freed then. As a
> > result, the dereference of dev->lock will cause a use-after-free bug.
> >
> > Fix it by changing spi_alloc_master to devm_spi_alloc_master, and
> > removing spi_master_put in the error handling code.
> >
> > Note that this patch can prevent UAF occurring any more
> >
> > Fixes: fd8b5f502929 ("msi2500: move msi3101 out of staging and rename")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/media/usb/msi2500/msi2500.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
> > index 71de6b4c4e4c..64c3ec9f1d0c 100644
> > --- a/drivers/media/usb/msi2500/msi2500.c
> > +++ b/drivers/media/usb/msi2500/msi2500.c
> > @@ -1220,7 +1220,7 @@ static int msi2500_probe(struct usb_interface *intf,
> >       }
> >
> >       /* SPI master adapter */
> > -     master = spi_alloc_master(dev->dev, 0);
> > +     master = devm_spi_alloc_master(dev->dev, 0);
>
> We had some bad past experiences on using devm_* on USB media devices,
> as there are almost always multiple drivers loaded and multiple
> interfaces.
>
> Could you please fix the free logic instead of using devm_*?

Hi Mauro,

When I resume working on this patch, I found this UAF bug is already
fixed in the spi part and merged to the upstream.

The correct fix is spi: fix use-after-free of the add_lock mutex [1].
So let's forget this patch.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6c53b45c71b4920b5e62f0ea8079a1da382b9434


>
> Regards,
> Mauro
>
> >       if (master == NULL) {
> >               ret = -ENOMEM;
> >               goto err_unregister_v4l2_dev;
> > @@ -1233,7 +1233,6 @@ static int msi2500_probe(struct usb_interface *intf,
> >       spi_master_set_devdata(master, dev);
> >       ret = spi_register_master(master);
> >       if (ret) {
> > -             spi_master_put(master);
> >               goto err_unregister_v4l2_dev;
> >       }
> >
>
>
>
> Thanks,
> Mauro
