Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133B749639F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379359AbiAURPK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jan 2022 12:15:10 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:44850 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbiAURPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:15:06 -0500
Received: by mail-qt1-f181.google.com with SMTP id f5so10598738qtp.11;
        Fri, 21 Jan 2022 09:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lmFYJSCcLqyJ3gmEXT1GTQFiLSiARI98tj+Ubi9SZeQ=;
        b=NDWYMxGjnyT8pHtEBnvkraDqJw7s3NG5jvhXxFz2/9pLe9Wo4BB+qzynV8PmEKmf2M
         tcjw40+vPV3t4trjDJAR2HzlU2NSUb0xhwAbjVHbNyyddDDoQDLSwpZaow2aY6KXg54d
         NT3rgS51Zo3igQoV6eB4+soMpxn7xmgIF6/ge8kliRWNBrYCPS+k02DpQL6ls62JSM4D
         3ADZtdAc1W/tjZXK4s2XNr8x6n/EAXMjQ9FEVEz51/JFs9QvDqdWq7ozO1D/BiqJ3bA1
         VqRk/A8mfkbVnWJbmvyPpTMn/7ivkrLI1yZZ0A4iROX284/jvFB9g52w6bW3ErAPjtRm
         ABIA==
X-Gm-Message-State: AOAM533zQVqSJ+mXcqH2+lz9R9hSUOsnAmZlNPFvGIubjYo0I1lJ0em5
        VNP9rVStz4lNYBzf7radFCcg/Tb4vfP9gxJda8d0xMOM
X-Google-Smtp-Source: ABdhPJwNokEUfO47u31kWlKtBBs/kxjVwO00ZzdECaIzLyfyZVKBSBi0s0IUukpHMiPYzaal1yKdbyNYkPUNVKxnCs4=
X-Received: by 2002:a05:622a:118b:: with SMTP id m11mr4044592qtk.369.1642785305913;
 Fri, 21 Jan 2022 09:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20220121143254.6432-1-sbinding@opensource.cirrus.com>
 <20220121143254.6432-8-sbinding@opensource.cirrus.com> <CAJZ5v0gK=-SXUDekg_2DtOuMsn6Ls4gS+nymei2Qa9ZEFvqGcA@mail.gmail.com>
 <019901d80ee7$a6bf2a90$f43d7fb0$@opensource.cirrus.com>
In-Reply-To: <019901d80ee7$a6bf2a90$f43d7fb0$@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Jan 2022 18:14:55 +0100
Message-ID: <CAJZ5v0j+DkX+-P1XxZ=HAnUzPjdkNFkXRTjJzhSH27KfDFAGDQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] platform/x86: serial-multi-instantiate: Add SPI support
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 5:55 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: 21 January 2022 15:31
> > To: Stefan Binding <sbinding@opensource.cirrus.com>
> > Cc: Mark Brown <broonie@kernel.org>; Rafael J . Wysocki
> > <rafael@kernel.org>; Len Brown <lenb@kernel.org>; Hans de Goede
> > <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>; Jaroslav
> > Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; moderated
> > list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM... <alsa-
> > devel@alsa-project.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; linux-spi <linux-spi@vger.kernel.org>; ACPI Devel
> > Maling List <linux-acpi@vger.kernel.org>; Platform Driver <platform-driver-
> > x86@vger.kernel.org>; patches@opensource.cirrus.com
> > Subject: Re: [PATCH v5 7/9] platform/x86: serial-multi-instantiate: Add SPI
> > support
> >
>
>
> > > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > > index 5b65d687f046..28f5bbf0f27a 100644
> > > --- a/drivers/platform/x86/Kconfig
> > > +++ b/drivers/platform/x86/Kconfig
> > > @@ -991,12 +991,12 @@ config TOPSTAR_LAPTOP
> > >           If you have a Topstar laptop, say Y or M here.
> > >
> > >  config SERIAL_MULTI_INSTANTIATE
> > > -       tristate "I2C multi instantiate pseudo device driver"
> > > -       depends on I2C && ACPI
> > > +       tristate "I2C and SPI multi instantiate pseudo device driver"
> > > +       depends on I2C && SPI && ACPI
> >
> > Should this be (I2C || SPI) && ACPI ?
>
> We made it dependent on both I2C and SPI because of how interconnected the
> serial-multi-instantiate driver is with both SPI and I2C. We felt attempting to make
> the driver compatible with one without the other would end up very complicated.

That's fine IMV, but it would be good to mention it in the changelog.

> > > @@ -146,7 +247,21 @@ static int smi_probe(struct platform_device *pdev)
> > >
> > >         platform_set_drvdata(pdev, smi);
> > >
> > > -       return smi_i2c_probe(pdev, adev, smi, inst_array);
> > > +       switch (node->bus_type) {
> > > +       case SMI_I2C:
> > > +               return smi_i2c_probe(pdev, adev, smi, node->instances);
> > > +       case SMI_SPI:
> > > +               return smi_spi_probe(pdev, adev, smi, node->instances);
> > > +       case SMI_AUTO_DETECT:
> > > +               if (i2c_acpi_client_count(adev) > 0)
> > > +                       return smi_i2c_probe(pdev, adev, smi, node->instances);
> > > +               else
> > > +                       return smi_spi_probe(pdev, adev, smi, node->instances);
> > > +       default:
> > > +               break;
> >
> > Why is this needed?
>
> This return code is attempting to ensure that we don’t try to guess whether we
> expect devices to be I2C or SPI - especially with regards to existing devices.
> We wanted to maintain compatibility with existing devices, which would all be
> I2C.
> For the device for which we are adding, the same HID is used by both the same
> chip for both I2C and SPI, so we also needed a way to support both.

I meant why was the "default" case needed.  Sorry for the confusion.
