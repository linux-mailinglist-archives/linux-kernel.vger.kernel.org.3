Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8445249FFE9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349516AbiA1SEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344097AbiA1SEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:04:08 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5B3C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:04:07 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id p7so11336572edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AX4YPG8Bm2SefDSCAE/JMNwLL1I+CwtsxeymBAcUoxs=;
        b=EUXSvGdsyU1/pueZOeOdUnTOHEVfReZlu7LORMtRpbGJ5PNZpDgyUVvKnCj1Vkrj5G
         6nrLq+Fb0C1GxGFVbSQrZuS0MsQlO5/4BdxQyaewTSw17hXal+MkhF2wQEP/fyh8i04K
         LaVcBA5wwlIszYU2H63FSGsMRMLNmflbxFUGemf19CjdHWGufq8t4RVnWHTD0izlG3vp
         Nx7nLfsNQmYCFG8JN6F6ZarWhvJrYOwzU9NgT0FYLlLpleRGUz2oNr1VfUget1tU4tHs
         vsPXvNX1XnI7zcVeYuRtJP6xn5u3f4yjt4beYSVZAPQPw7iRhZn1NrAhPIzV2+ljblwm
         xkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AX4YPG8Bm2SefDSCAE/JMNwLL1I+CwtsxeymBAcUoxs=;
        b=B/LrH597b0IPZ4eoU+rO8w2ZXjOw4gHawRbRXWiL56aTZt8+DKLzPn1uIuDhyMwcuZ
         lPZcdAOeILFu+ARK1/epypc5oesuVX8oushSNGd+hI66HNtVd7dKRzYbIADrwO+6HTl3
         0FoshMN25/qtkBBo+rCMScQ283zrNFp8E9zylYmMphd4p/wBTQklkjMxq82l1ckwKpiE
         fX3sIwtvvvo7QOiv5dBY/nrJV+Ys0pVdJm61/W3m9M8egdV0dZnXrRwef7Z8Edcbl3e0
         lDhbUibtF5p+F0+AbIKB0+yH1SLM8NKylQbyiqSnXEPPVzgbsw3/BDS/xlclRYx5oumC
         SY0g==
X-Gm-Message-State: AOAM532dN9uGr4qgipYMH9mEUPzdttMN0ivqXOKmdJF/0d03lagyFZer
        6ZAnOdcvJ+6R5vZYHbnonMPeq9Nn340KtgdWcUre9gmHKrqyWcQN
X-Google-Smtp-Source: ABdhPJy98gEpu1cihCDDjuwBP/RHPKRfkKQ+WMvbji+P1oPusBY08cb7zuU/N/brAJs6AXK+lQ4fiwBp/j8u+7Ym9jg=
X-Received: by 2002:a05:6402:354c:: with SMTP id f12mr9451578edd.210.1643393046184;
 Fri, 28 Jan 2022 10:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20220127234450.2218419-1-wonchung@google.com> <CAJZ5v0hNd6Xjx+RNOTfzXDeXDhgvdfsesNZsgQ2eTCDh42aNmA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hNd6Xjx+RNOTfzXDeXDhgvdfsesNZsgQ2eTCDh42aNmA@mail.gmail.com>
From:   Won Chung <wonchung@google.com>
Date:   Fri, 28 Jan 2022 10:03:54 -0800
Message-ID: <CAOvb9yjkTX1TgpTBfWWrv9rO-szRAre0EeTDj8aogwYQ=PVDiQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: device_sysfs: Add sysfs support for _PLD
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 4:04 AM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Fri, Jan 28, 2022 at 12:45 AM Won Chung <wonchung@google.com> wrote:
> >
> > When ACPI table includes _PLD fields for a device, create a new file
> > (pld) in sysfs to share _PLD fields.
> >
> > Signed-off-by: Won Chung <wonchung@google.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-acpi | 53 ++++++++++++++++++++++++
> >  drivers/acpi/device_sysfs.c              | 42 +++++++++++++++++++
> >  2 files changed, 95 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/A=
BI/testing/sysfs-bus-acpi
> > index 58abacf59b2a..7f4544c9d563 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-acpi
> > +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> > @@ -96,3 +96,56 @@ Description:
> >                 hardware, if the _HRV control method is present.  It is=
 mostly
> >                 useful for non-PCI devices because lspci can list the h=
ardware
> >                 version for PCI devices.
> > +
> > +What:          /sys/bus/acpi/devices/.../pld
> > +Date:          Jan, 2022
> > +Contact:       Rafael J. Wysocki <rjw@rjwysocki.net>
>
> Why do you think that it is appropriate to add contact information of
> someone to ABI documentation without asking them for their opinion?
>
> If you don't want to be the contact yourself, you can put linux-acpi in t=
here.

Hi Rafael,

Sorry for that. I thought I had to put the maintainer's contact there
since everything else in this file has your name and it's being sent
to you for a review. I actually sent another follow up email in this
email thread with the contact information changed to my name, but I
think I also did that incorrectly since I did not change the version
number in the email title. I will correctly send a new one.

Won

>
> > +Description:
> > +               This attribute contains the output of the device object=
's
> > +               _PLD control method, if present. This information provi=
des
> > +               details on physical location of a port.
> > +
> > +               Description on each _PLD field from ACPI specification:
> > +
> > +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +               GROUP_TOKEN     Unique numerical value identifying a gr=
oup.
> > +               GROUP_POSITION  Identifies this device connection point=
=E2=80=99s
> > +                               position in the group.
> > +               USER_VISIBLE    Set if the device connection point can =
be
> > +                               seen by the user without disassembly.
> > +               DOCK            Set if the device connection point resi=
des
> > +                               in a docking station or port replicator=
.
> > +               BAY             Set if describing a device in a bay or =
if
> > +                               device connection point is a bay.
> > +               LID             Set if this device connection point res=
ides
> > +                               on the lid of laptop system.
> > +               PANEL           Describes which panel surface of the sy=
stem=E2=80=99s
> > +                               housing the device connection point res=
ides on:
> > +                               0 - Top
> > +                               1 - Bottom
> > +                               2 - Left
> > +                               3 - Right
> > +                               4 - Front
> > +                               5 - Back
> > +                               6 - Unknown (Vertical Position and Hori=
zontal
> > +                               Position will be ignored)
> > +               HORIZONTAL_     0 - Left
> > +               POSITION        1 - Center
> > +                               2 - Right
> > +               VERTICAL_       0 - Upper
> > +               POSITION        1 - Center
> > +                               2 - Lower
> > +               SHAPE           Describes the shape of the device conne=
ction
> > +                               point.
> > +                               0 - Round
> > +                               1 - Oval
> > +                               2 - Square
> > +                               3 - Vertical Rectangle
> > +                               4 - Horizontal Rectangle
> > +                               5 - Vertical Trapezoid
> > +                               6 - Horizontal Trapezoid
> > +                               7 - Unknown - Shape rendered as a Recta=
ngle
> > +                               with dotted lines
> > +                               8 - Chamfered
> > +                               15:9 - Reserved
> > +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index d5d6403ba07b..8d4df5fb1c45 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -509,6 +509,40 @@ static ssize_t status_show(struct device *dev, str=
uct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(status);
> >
> > +static ssize_t pld_show(struct device *dev, struct device_attribute *a=
ttr,
> > +                       char *buf)
> > +{
> > +       struct acpi_device *acpi_dev =3D to_acpi_device(dev);
> > +       acpi_status status;
> > +       struct acpi_pld_info *pld;
> > +
> > +       status =3D acpi_get_physical_device_location(acpi_dev->handle, =
&pld);
> > +       if (ACPI_FAILURE(status))
> > +               return -ENODEV;
> > +
> > +       return sprintf(buf, "GROUP_TOKEN=3D%u\n"
> > +               "GROUP_POSITION=3D%u\n"
> > +               "USER_VISIBLE=3D%u\n"
> > +               "DOCK=3D%u\n"
> > +               "BAY=3D%u\n"
> > +               "LID=3D%u\n"
> > +               "PANEL=3D%u\n"
> > +               "HORIZONTAL_POSITION=3D%u\n"
> > +               "VERTICAL_POSITION=3D%u\n"
> > +               "SHAPE=3D%u\n",
> > +               pld->group_token,
> > +               pld->group_position,
> > +               pld->user_visible,
> > +               pld->dock,
> > +               pld->bay,
> > +               pld->lid,
> > +               pld->panel,
> > +               pld->horizontal_position,
> > +               pld->vertical_position,
> > +               pld->shape);
> > +}
> > +static DEVICE_ATTR_RO(pld);
> > +
> >  /**
> >   * acpi_device_setup_files - Create sysfs attributes of an ACPI device=
.
> >   * @dev: ACPI device object.
> > @@ -595,6 +629,12 @@ int acpi_device_setup_files(struct acpi_device *de=
v)
> >                                                     &dev_attr_real_powe=
r_state);
> >         }
> >
> > +       if (acpi_has_method(dev->handle, "_PLD")) {
> > +               result =3D device_create_file(&dev->dev, &dev_attr_pld)=
;
> > +               if (result)
> > +                       goto end;
> > +       }
> > +
> >         acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
> >
> >  end:
> > @@ -645,4 +685,6 @@ void acpi_device_remove_files(struct acpi_device *d=
ev)
> >                 device_remove_file(&dev->dev, &dev_attr_status);
> >         if (dev->handle)
> >                 device_remove_file(&dev->dev, &dev_attr_path);
> > +       if (acpi_has_method(dev->handle, "_PLD"))
> > +               device_remove_file(&dev->dev, &dev_attr_pld);
> >  }
> > --
> > 2.35.0.rc0.227.g00780c9af4-goog
> >
