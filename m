Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC4479A6A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhLRKvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhLRKvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:51:49 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2949EC061574;
        Sat, 18 Dec 2021 02:51:49 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v138so13621480ybb.8;
        Sat, 18 Dec 2021 02:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxJ7JH45rLXiSU3+aN2yNpOSO5F5cYEYrj9rOlywRRg=;
        b=BAKI+GviUI8n3lQWAVvVlkib2VgmK5f+A0Aa9ISYgLcr8nlE/esN90rdEI9Bb1Z0Go
         sgS2ZbE85KuQvZRCn3dkUbpUpjSd19yo8f0MUBkkAhnrOqd8HZUtWwKvsyJh/RETgvxw
         GaBJuPiCTQARXofraXNOis39V2cLXfpt19UlpMOH+4mVcCd7eIs9w0F1Q+M54AOyyUab
         1ka2Af/KZMFmHnQSIsFrT76vIH9BhXWODXwE+c6FRBlt3FU8hxyIoEVdcLU4V9CLGdlv
         j4Q4y5TF83TdolJuV2HX9cS6NBDQ12XqOdCDCJMIm0G5UCcqilkICWmxvJpE4h28BpvU
         5zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxJ7JH45rLXiSU3+aN2yNpOSO5F5cYEYrj9rOlywRRg=;
        b=EeBIo1sXCVxSeBtOhVW5HQutKxrvvmkBcT/N8WGNYBJDTkYSONn5S8Z0NcmKAKBA/c
         FmBIF9jAnHpRdhoXUgmwNzGb8yc84/QSKKd9Vefnhfhx5eqVSXzTJNV+rTRsSKGpHi/u
         GnmnIvAkUrm1PHE7tvdUrq54b5kD7MNAPtsQMW4ntI31CSyc+nIStayczWNKMwme9cDL
         pVUJbVIZIL6rz00vRhEHMPpuOgWfaRLgubhDXUeJL4eR+bm5GAN9mSBURZAWljLrPgQe
         +dwzsIpKcfk5/188XB+76SEwOdYsqQHN1jm0VgtA+psP/MIrKzj0c1pDWUHYvNTlukNu
         I7Dw==
X-Gm-Message-State: AOAM532HTRWWAtgs87Hs70c98Jg2aghCG6FA0m7r3t1BRyJzH2xf+BsG
        cpqJw7J7g9h2FWBAlBWVJX0KTIup4Le/T+9OJx0=
X-Google-Smtp-Source: ABdhPJwBkbYHW45zl7gKf9xcmGhMck5sxtO5kzB3/Tpf/psu/ZQ5E5ptTns8bAdFMj09pACnF/ew70F8Vj/cGFMZ3UQ=
X-Received: by 2002:a25:148a:: with SMTP id 132mr9575158ybu.251.1639824708373;
 Sat, 18 Dec 2021 02:51:48 -0800 (PST)
MIME-Version: 1.0
References: <20211217141715.29747-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211217141715.29747-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <b94e0a92-1995-926c-95df-17365f03eed0@omp.ru>
In-Reply-To: <b94e0a92-1995-926c-95df-17365f03eed0@omp.ru>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 18 Dec 2021 10:51:22 +0000
Message-ID: <CA+V-a8tU6XCYw2B32obgOkezd_YMqBkpWA_EuJzK=nCmkuWtQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ata: pata_platform: Merge pata_of_platform into pata_platform
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Thank you for the review.

On Fri, Dec 17, 2021 at 9:38 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> Hello!
>
> On 12/17/21 5:17 PM, Lad Prabhakar wrote:
>
> > Merge the OF pata_of_platform driver into pata_platform.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> [...]
>
> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > index a7da8ea7b3ed..0fab5cae45d5 100644
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -1122,7 +1122,8 @@ config PATA_PLATFORM
> >
> >  config PATA_OF_PLATFORM
> >       tristate "OpenFirmware platform device PATA support"
> > -     depends on PATA_PLATFORM && OF
> > +     depends on OF
> > +     select PATA_PLATFORM
> >       help
> >         This option enables support for generic directly connected ATA
> >         devices commonly found on embedded systems with OpenFirmware
>
>    Hm, why in the world you're keeping this Konfig entry? You doint even use it
> anywhere... :-/
>
There are defconfig users of it, but luckily as Rob pointed out they
even have PATA_PLATFORM enabled so will be dropping it.

> [...]
> > diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> > index cb3134bf88eb..b8d8d51bc562 100644
> > --- a/drivers/ata/pata_platform.c
> > +++ b/drivers/ata/pata_platform.c
> > @@ -11,21 +11,42 @@
> >   * License.  See the file "COPYING" in the main directory of this archive
> >   * for more details.
> >   */
> > -#include <linux/kernel.h>
> > -#include <linux/module.h>
> > -#include <linux/blkdev.h>
> > -#include <scsi/scsi_host.h>
> >  #include <linux/ata.h>
> > +#include <linux/ata_platform.h>
> > +#include <linux/blkdev.h>
> > +#include <linux/kernel.h>
> >  #include <linux/libata.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> >  #include <linux/platform_device.h>
> > -#include <linux/ata_platform.h>
> > +#include <scsi/scsi_host.h>
>
>    I'd make the sorting of the #include's a separate patch...
>
OK.

> [...]
> > +/**
> > + * struct pata_platform_priv - Private info
> > + * @io_res: Resource representing I/O base
> > + * @ctl_res: Resource representing CTL base
> > + * @irq_res: Resource representing IRQ and its flags
> > + * @ioport_shift: I/O port shift
> > + * @mask: PIO mask
> > + * @sht: scsi_host_template to use when registering
> > + * @use16bit: Flag to indicate 16-bit IO instead of 32-bit
> > + */
> > +struct pata_platform_priv {
> > +     struct resource *io_res;
> > +     struct resource *ctl_res;
> > +     struct resource *irq_res;
> > +     unsigned int ioport_shift;
> > +     int mask;
>
>    Why not pio_mask?
>
OK

> > +     struct scsi_host_template *sht;
> > +     bool use16bit;
> > +};
> >
> >  /*
> >   * Provide our own set_mode() as we don't want to change anything that has
> [...]
> > @@ -168,23 +180,83 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
> [...]
> >
> > -static int pata_platform_probe(struct platform_device *pdev)
> > +static int pata_of_platform_get_pdata(struct platform_device *ofdev,
> > +                                   struct pata_platform_priv *priv)
> >  {
> > -     struct resource *io_res;
> > +     struct device_node *dn = ofdev->dev.of_node;
> >       struct resource *ctl_res;
> >       struct resource *irq_res;
> > +     struct resource *io_res;
>
>    Should be declared before ctl_res...
>
Any reason why?

>
> > +     int pio_mode = 0;
> > +     int irq;
> > +     int ret;
> > +
> > +     ctl_res = devm_kzalloc(&ofdev->dev, sizeof(*ctl_res), GFP_KERNEL);
> > +     io_res = devm_kzalloc(&ofdev->dev, sizeof(*io_res), GFP_KERNEL);
> > +     irq_res = devm_kzalloc(&ofdev->dev, sizeof(*irq_res), GFP_KERNEL);
> > +     if (!ctl_res || !io_res || !irq_res)
> > +             return -ENOMEM;
>
>    Can't we get away from these allocated resources? Or at least irq_res?
>
Do you have any suggestions?

> [...]
> > +     priv->use16bit = of_property_read_bool(dn, "ata-generic,use16bit");
> > +
> > +     priv->mask = 1 << pio_mode;
> > +     priv->mask |= (1 << pio_mode) - 1;
>
>    You can make use of GENMASK(pio_mode, 0), in a separate pre-patch (or post-patch?).
>
OK

> [...]
> > @@ -198,32 +270,63 @@ static int pata_platform_probe(struct platform_device *pdev)
> [...]
> > +static int pata_platform_probe(struct platform_device *pdev)
> > +{
> > +     struct pata_platform_priv *priv;
> > +     int ret;
> > +
> > +     priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     if (!dev_of_node(&pdev->dev))
> > +             ret = pata_platform_get_pdata(pdev, priv);
> > +     else
> > +             ret = pata_of_platform_get_pdata(pdev, priv);
> > +
>
>    No need for empty line here...
>
OK

> > +     if (ret)
> > +             return ret;
> > +
> > +     priv->sht = &pata_platform_sht;
>
>    Aren't those structures identical between the formerly separate drivers?
>
Yes so are you suggesting to drop sht from priv and use it directly?

Cheers,
Prabhakar

> [...]
>
> MBR, Sergey
