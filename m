Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A726F4A54C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiBABwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiBABwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:52:15 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E99C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:52:14 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p15so48894940ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hrJDBg/8ZupD03UAWDJ1FQcLsBcQHd+dnocM/bsmtPk=;
        b=L6haaFknzdXxVkSZfEk/lVyuWR5+w5n8a++shoBSlzXkdwgEHQk1EhPqbKKxYEpZUC
         g0RNqHujp6JlBC8Q5q85tzbxPFFUMf5xsfquNZapQRxRT8iiHcaA75L0bey3tcRINdPn
         1eLpk7oahcOHYqWWD4gu6LzEwIpCMr20+zXI73QRhfQ9+9IQV6nIA2nhS9/1RSEg8Aux
         Hs9CjxYUEoXeR8Ah1QKHJotjRCgMqqopdjJUmDah/36MkNIWMV+Op3NVOp0biwJbIuY2
         y5CvUh/Uli6jx94RzNMRBBYxY7YJmNSKZaITNmLE3GEJMo1QFIZcFS5pZc89+yhOHl9y
         jw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hrJDBg/8ZupD03UAWDJ1FQcLsBcQHd+dnocM/bsmtPk=;
        b=ApJIzUL1JsuhQnI+tJWiNgrL4BGZPDhYxbXwfHH7a+tAEqL/GLI+eVMbX5jh76lD4J
         unO198+urv0jUue5Ax17nX1AjykFswtdyQ0bS3Lq2QnKrTIMOOAEKnys+NTuwbWfgXN8
         31QODUdrfUs3xWkfVG5uzbj2V3Q7UIOrIPzXcGYVDqVJRTyQ/u5MY+tbd6zRl8FIZe/I
         xOHcLFmm4TA7pKM8/ARK937ZRMeGSOZWRSCkMW4AD1BD56tgx7icKUVJfLrac0HZ97z+
         vceTyLQ0OuRn1MegINNXcTdBBNi4de0rvgNWvah7GlkKgxSU/hoBKaaN61CgaM1NFACY
         Qjow==
X-Gm-Message-State: AOAM5308EIuRCebNEsPolK2uxBTfCN9zebyu4zU2moDqpLRGjVBWXTrl
        jlJzpzAfxY+ERzC7yM95YGIlZFCxS5vFFaU0OC+pCQ==
X-Google-Smtp-Source: ABdhPJxzb/0RkjwXhRv5BhYk8nqCAweFbPC4NDUM/fR7INJ88O696fqRVlvlZKVQrBnM8uSLICB5GRD+aD6hzIE+fEg=
X-Received: by 2002:a17:907:968f:: with SMTP id hd15mr10995087ejc.208.1643680333258;
 Mon, 31 Jan 2022 17:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20220128180832.2329149-1-wonchung@google.com> <YfeQxYNzWltRQ7mq@kuha.fi.intel.com>
In-Reply-To: <YfeQxYNzWltRQ7mq@kuha.fi.intel.com>
From:   Won Chung <wonchung@google.com>
Date:   Mon, 31 Jan 2022 17:52:02 -0800
Message-ID: <CAOvb9yif2b1rGNGz4qbxnP6j-mUajSxTu2uXhhGc9TKKFd-VFQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: device_sysfs: Add sysfs support for _PLD
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 11:33 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Fri, Jan 28, 2022 at 06:08:32PM +0000, Won Chung wrote:
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
> > index 58abacf59b2a..3a9c6a4f4603 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-acpi
> > +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> > @@ -96,3 +96,56 @@ Description:
> >               hardware, if the _HRV control method is present.  It is m=
ostly
> >               useful for non-PCI devices because lspci can list the har=
dware
> >               version for PCI devices.
> > +
> > +What:                /sys/bus/acpi/devices/.../pld
> > +Date:                Jan, 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             This attribute contains the output of the device object's
> > +             _PLD control method, if present. This information provide=
s
> > +             details on physical location of a port.
> > +
> > +             Description on each _PLD field from ACPI specification:
> > +
> > +             =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +             GROUP_TOKEN     Unique numerical value identifying a grou=
p.
> > +             GROUP_POSITION  Identifies this device connection point=
=E2=80=99s
> > +                             position in the group.
> > +             USER_VISIBLE    Set if the device connection point can be
> > +                             seen by the user without disassembly.
> > +             DOCK            Set if the device connection point reside=
s
> > +                             in a docking station or port replicator.
> > +             BAY             Set if describing a device in a bay or if
> > +                             device connection point is a bay.
> > +             LID             Set if this device connection point resid=
es
> > +                             on the lid of laptop system.
> > +             PANEL           Describes which panel surface of the syst=
em=E2=80=99s
> > +                             housing the device connection point resid=
es on:
> > +                             0 - Top
> > +                             1 - Bottom
> > +                             2 - Left
> > +                             3 - Right
> > +                             4 - Front
> > +                             5 - Back
> > +                             6 - Unknown (Vertical Position and Horizo=
ntal
> > +                             Position will be ignored)
> > +             HORIZONTAL_     0 - Left
> > +             POSITION        1 - Center
> > +                             2 - Right
> > +             VERTICAL_       0 - Upper
> > +             POSITION        1 - Center
> > +                             2 - Lower
> > +             SHAPE           Describes the shape of the device connect=
ion
> > +                             point.
> > +                             0 - Round
> > +                             1 - Oval
> > +                             2 - Square
> > +                             3 - Vertical Rectangle
> > +                             4 - Horizontal Rectangle
> > +                             5 - Vertical Trapezoid
> > +                             6 - Horizontal Trapezoid
> > +                             7 - Unknown - Shape rendered as a Rectang=
le
> > +                             with dotted lines
> > +                             8 - Chamfered
> > +                             15:9 - Reserved
> > +             =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
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
> > +                     char *buf)
> > +{
> > +     struct acpi_device *acpi_dev =3D to_acpi_device(dev);
> > +     acpi_status status;
> > +     struct acpi_pld_info *pld;
> > +
> > +     status =3D acpi_get_physical_device_location(acpi_dev->handle, &p=
ld);
> > +     if (ACPI_FAILURE(status))
> > +             return -ENODEV;
> > +
> > +     return sprintf(buf, "GROUP_TOKEN=3D%u\n"
> > +             "GROUP_POSITION=3D%u\n"
> > +             "USER_VISIBLE=3D%u\n"
> > +             "DOCK=3D%u\n"
> > +             "BAY=3D%u\n"
> > +             "LID=3D%u\n"
> > +             "PANEL=3D%u\n"
> > +             "HORIZONTAL_POSITION=3D%u\n"
> > +             "VERTICAL_POSITION=3D%u\n"
> > +             "SHAPE=3D%u\n",
> > +             pld->group_token,
> > +             pld->group_position,
> > +             pld->user_visible,
> > +             pld->dock,
> > +             pld->bay,
> > +             pld->lid,
> > +             pld->panel,
> > +             pld->horizontal_position,
> > +             pld->vertical_position,
> > +             pld->shape);
> > +}
> > +static DEVICE_ATTR_RO(pld);
>
> Why not have a pld group (directory) and a separate attribute file for
> each field?
>
>
> thanks,
>
> --
> heikki

Hi Heikki,

Thank you for the review. It seems to be the convention to have a
separate attribute file for each field, as you pointed out. I have
made the change and sent v4.

Thanks,
Won
