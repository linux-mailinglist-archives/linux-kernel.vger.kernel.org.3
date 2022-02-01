Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F316C4A5E94
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiBAOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:52:51 -0500
Received: from mail-yb1-f181.google.com ([209.85.219.181]:44629 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbiBAOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:52:50 -0500
Received: by mail-yb1-f181.google.com with SMTP id r65so51605829ybc.11;
        Tue, 01 Feb 2022 06:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yriV3jrREEgzkPR54dv4q5A+98LvC0ePS/Zx7NSyEBA=;
        b=4Z4UcrrVlRSgtlY90JBin8w2ceUpKwnPmfgpq6dd5utdBDO2JKv4XG58fjk+6UYDmC
         ewzcEYj7ap0rEECId92qrzkAROwPxEkyp8TG8qBAiwSOEQhqodgcyVika6k1p2qZ87oy
         Z/SYaD1KJUBvyA6nxbbULPuM9hzDLsHWU14BcZjtCdUCptAcFm5D5ub0FvVp6zpbzOzy
         O2iwuGvhPpdA9z5FwakwMmEDQfAzR6TtBB+dy3F9uo5pnIlNFWCiUN1aVBoABASh7k01
         4GjCS4bIBO5yznRnPt5DUzaFgAqAGWBO9SxBCSIboLJUgjwKOs7uVUHhUk3zckzIaNNU
         AFnw==
X-Gm-Message-State: AOAM532yoWyrtHIR6YmX9qdt8L3PfRgVUy+clnu3VcnLNTKlIR52sLZA
        +0uf5s4haR21L08euLKFTyqgvBnfk73LdahRhR6O1kI0
X-Google-Smtp-Source: ABdhPJwaJImvyobUjfAmbGN6jDMtgtsvo6mZe7/B6yfYsZC0x9D8AMv6LnK9U7CnT98B2f8aS4FAxVzsxPw5ZySwc+U=
X-Received: by 2002:a05:6902:1507:: with SMTP id q7mr38572163ybu.343.1643727169529;
 Tue, 01 Feb 2022 06:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
 <20220121172431.6876-2-sbinding@opensource.cirrus.com> <c821953a-6572-d60d-6a00-fccd541268c5@redhat.com>
In-Reply-To: <c821953a-6572-d60d-6a00-fccd541268c5@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Feb 2022 15:52:38 +0100
Message-ID: <CAJZ5v0jGqUvZS113VewgsGm8cMJc2B=M5KyqmOHTPNy+R8KeEQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] spi: Make spi_alloc_device and spi_add_device
 public again
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 3:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/21/22 18:24, Stefan Binding wrote:
> > This functions were previously made private since they
> > were not used. However, these functions will be needed
> > again.
> >
> > Partial revert of commit da21fde0fdb3
> > ("spi: Make several public functions private to spi.c")
> >
> > Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

The series also looks good to me from the ACPI side, so what tree
should it go into?

> > ---
> >  drivers/spi/spi.c       |  6 ++++--
> >  include/linux/spi/spi.h | 12 ++++++++++++
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 4599b121d744..1eb84101c4ad 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -532,7 +532,7 @@ static DEFINE_MUTEX(board_lock);
> >   *
> >   * Return: a pointer to the new device, or NULL.
> >   */
> > -static struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
> > +struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
> >  {
> >       struct spi_device       *spi;
> >
> > @@ -557,6 +557,7 @@ static struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
> >       device_initialize(&spi->dev);
> >       return spi;
> >  }
> > +EXPORT_SYMBOL_GPL(spi_alloc_device);
> >
> >  static void spi_dev_set_name(struct spi_device *spi)
> >  {
> > @@ -652,7 +653,7 @@ static int __spi_add_device(struct spi_device *spi)
> >   *
> >   * Return: 0 on success; negative errno on failure
> >   */
> > -static int spi_add_device(struct spi_device *spi)
> > +int spi_add_device(struct spi_device *spi)
> >  {
> >       struct spi_controller *ctlr = spi->controller;
> >       struct device *dev = ctlr->dev.parent;
> > @@ -673,6 +674,7 @@ static int spi_add_device(struct spi_device *spi)
> >       mutex_unlock(&ctlr->add_lock);
> >       return status;
> >  }
> > +EXPORT_SYMBOL_GPL(spi_add_device);
> >
> >  static int spi_add_device_locked(struct spi_device *spi)
> >  {
> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> > index 7ab3fed7b804..0346a3ff27fd 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -1452,7 +1452,19 @@ spi_register_board_info(struct spi_board_info const *info, unsigned n)
> >   * use spi_new_device() to describe each device.  You can also call
> >   * spi_unregister_device() to start making that device vanish, but
> >   * normally that would be handled by spi_unregister_controller().
> > + *
> > + * You can also use spi_alloc_device() and spi_add_device() to use a two
> > + * stage registration sequence for each spi_device. This gives the caller
> > + * some more control over the spi_device structure before it is registered,
> > + * but requires that caller to initialize fields that would otherwise
> > + * be defined using the board info.
> >   */
> > +extern struct spi_device *
> > +spi_alloc_device(struct spi_controller *ctlr);
> > +
> > +extern int
> > +spi_add_device(struct spi_device *spi);
> > +
> >  extern struct spi_device *
> >  spi_new_device(struct spi_controller *, struct spi_board_info *);
> >
> >
>
