Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE90F4A79A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347259AbiBBUnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347254AbiBBUnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:43:00 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7411C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 12:42:59 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m4so1023423ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 12:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fk2q4Q0zld5x4Xvk+uJDZE7KsH5E8yoaj60l2KU2+a4=;
        b=jnB+G/V5FAbLKQ9muBuKcGhiioXz0GWOmUTcj89hosGNXwksEQ7UmnAfbFLtzy4Pip
         MABUcjlIVYDZwrCBBlMglAJdX2fGKSKRaHVpxghArTXGJW9XvSBHXyGzldoZTnC49Epd
         j/bGMsHQKX5X3Jg/qYvdOv1a/2j59qBCnO44bABZFeFu/JKAKr3GlEuuZcExfL/QhnrK
         /qDB2pVoVc2Rel5cB9ACmJtHEv8wz2zOxKl15y+qaiArQh5jMKkCKYdbP/pRC0+00qiW
         03pAUY4tPZposmcrqMfqihBwwy5NqtE7B2bnZQI4lQ2ood/XlWeRwd2yVpzfsLTx4krZ
         OKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fk2q4Q0zld5x4Xvk+uJDZE7KsH5E8yoaj60l2KU2+a4=;
        b=BCqu2xnjwLhruQTVsTlNvON5UI3GudvI5zZhwcye4JBPW71I5Jw4CABZLLO21q4/h7
         hlKo/b3iedhIf8psZeB9P+6rgL1eWP0V85H6WHMLlCnw/ZT7VT231B/72iTJybQt7sNp
         5OEdj7Fkf0fsbYE59K49x+QFemOt2ROGfvcD1o84067bXKoqZMqxERYQIQTl1IVm2K9/
         1dZR1TF1YNkfiHqKsl/eeVG5dqEfopB2FgF3XncEF+xbRnadWp4ZzbY56YmtPQJWJcYa
         C5ZGmNosaC1TPSCLQuqhncnMrxF+rTGAVdrQkxxomcjPy/eW+g5b4ZO+RxVrn7J9k8OH
         dT1w==
X-Gm-Message-State: AOAM533ydojZWGwhqeEEQpqXLCK7BtygXZ1a294Mj8HdIamMHHrXy2X3
        m9RoV0riI+Xek1VWYm6g9NwslUJKHN3HMLjF3eRD9QuytFX9O/Hc
X-Google-Smtp-Source: ABdhPJzoM+LWmMajgtTaAqRNhWJ5PQ6McP9nKnF+R2oYhUZ2xZ03SMwgimWNES4XP02ajcmRyy9O+9O/InNnd4PEMUw=
X-Received: by 2002:a17:906:9b87:: with SMTP id dd7mr22427499ejc.758.1643834578053;
 Wed, 02 Feb 2022 12:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20220201015518.3118404-1-wonchung@google.com> <Yfo+gYLLOGN69Re1@kuha.fi.intel.com>
In-Reply-To: <Yfo+gYLLOGN69Re1@kuha.fi.intel.com>
From:   Won Chung <wonchung@google.com>
Date:   Wed, 2 Feb 2022 12:42:47 -0800
Message-ID: <CAOvb9ygyupib4cMXhcdeZmgNZmyaCmaTF98MHae+irY5ruZ1Qw@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: device_sysfs: Add sysfs support for _PLD
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

Hi Heikki,

Thank you for the review!

On Wed, Feb 2, 2022 at 12:19 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Won,
>
> On Tue, Feb 01, 2022 at 01:55:18AM +0000, Won Chung wrote:
> > When ACPI table includes _PLD fields for a device, create a new
> > directory (pld) in sysfs to share _PLD fields.
>
> I think you need to explain what needs this information in user space.
>
> > Signed-off-by: Won Chung <wonchung@google.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-acpi | 107 +++++++++++++++++++++++
> >  drivers/acpi/device_sysfs.c              |  55 ++++++++++++
> >  include/acpi/acpi_bus.h                  |   1 +
> >  3 files changed, 163 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/A=
BI/testing/sysfs-bus-acpi
> > index 58abacf59b2a..b8b71c8f3cfd 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-acpi
> > +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> > @@ -96,3 +96,110 @@ Description:
> >               hardware, if the _HRV control method is present.  It is m=
ostly
> >               useful for non-PCI devices because lspci can list the har=
dware
> >               version for PCI devices.
> > +
> > +What:                /sys/bus/acpi/devices/.../pld/
> > +Date:                Feb, 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             This directory contains the output of the device object's=
 _PLD
> > +             control method, if present. This information provides det=
ails
> > +             on physical location of a device.
> > +
> > +What:                /sys/bus/acpi/devices/.../pld/revision
> > +Date:                Feb, 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             The current revision is 0x2.
> > +
> > +What:           /sys/bus/acpi/devices/.../pld/group_token
> > +Date:           Feb, 2022
> > +Contact:        Won Chung <wonchung@google.com>
> > +Description:
> > +             Unique numerical value identifying a group.
> > +
> > +What:           /sys/bus/acpi/devices/.../pld/group_position
> > +Date:           Feb, 2022
> > +Contact:        Won Chung <wonchung@google.com>
> > +Description:
> > +             Identifies this device connection point=E2=80=99s positio=
n in the group.
> > +
> > +What:           /sys/bus/acpi/devices/.../pld/user_visible
> > +Date:           Feb, 2022
> > +Contact:        Won Chung <wonchung@google.com>
> > +Description:
> > +             Set if the device connection point can be seen by the use=
r
> > +             without disassembly.
> > +
> > +What:           /sys/bus/acpi/devices/.../pld/dock
> > +Date:           Feb, 2022
> > +Contact:        Won Chung <wonchung@google.com>
> > +Description:
> > +             Set if the device connection point resides in a docking s=
tation
> > +             or port replicator.
> > +
> > +What:           /sys/bus/acpi/devices/.../pld/bay
> > +Date:           Feb, 2022
> > +Contact:        Won Chung <wonchung@google.com>
> > +Description:
> > +             Set if describing a device in a bay or if device connecti=
on
> > +             point is a bay.
> > +
> > +What:           /sys/bus/acpi/devices/.../pld/lid
> > +Date:           Feb, 2022
> > +Contact:        Won Chung <wonchung@google.com>
> > +Description:
> > +             Set if this device connection point resides on the lid of
> > +             laptop system.
> > +
> > +What:           /sys/bus/acpi/devices/.../pld/panel
> > +Date:           Feb, 2022
> > +Contact:        Won Chung <wonchung@google.com>
> > +Description:
> > +             Describes which panel surface of the system=E2=80=99s hou=
sing the
> > +             device connection point resides on:
> > +             0 - Top
> > +             1 - Bottom
> > +             2 - Left
> > +             3 - Right
> > +             4 - Front
> > +             5 - Back
> > +             6 - Unknown (Vertical Position and Horizontal Position wi=
ll be
> > +             ignored)
> > +
> > +What:           /sys/bus/acpi/devices/.../pld/vertical_position
> > +Date:           Feb, 2022
> > +Contact:        Won Chung <wonchung@google.com>
> > +Description:
> > +             0 - Upper
> > +             1 - Center
> > +             2 - Lower
> > +
> > +What:           /sys/bus/acpi/devices/.../pld/horizontal_position
> > +Date:           Feb, 2022
> > +Contact:        Won Chung <wonchung@google.com>
> > +Description:
> > +             ACPI specification does not define horizontal position fi=
eld.
> > +             Can be used as either
> > +             0 - Left
> > +             1 - Center
> > +             2 - Right
> > +             or
> > +             0 - Leftmost
> > +             and higher numbers going toward the right.
> > +
> > +What:           /sys/bus/acpi/devices/.../pld/shape
> > +Date:           Feb, 2022
> > +Contact:        Won Chung <wonchung@google.com>
> > +Description:
> > +             Describes the shape of the device connection point.
> > +             0 - Round
> > +             1 - Oval
> > +             2 - Square
> > +             3 - Vertical Rectangle
> > +             4 - Horizontal Rectangle
> > +             5 - Vertical Trapezoid
> > +             6 - Horizontal Trapezoid
> > +             7 - Unknown - Shape rendered as a Rectangle with dotted l=
ines
> > +             8 - Chamfered
> > +             15:9 - Reserved
> > +
> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index d5d6403ba07b..610be93635a0 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -509,6 +509,49 @@ static ssize_t status_show(struct device *dev, str=
uct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(status);
> >
> > +#define DEV_ATTR_PLD_PROP(prop) \
> > +     static ssize_t prop##_show(struct device *dev, struct device_attr=
ibute *attr, \
> > +             char *buf) \
> > +{ \
> > +     struct acpi_device *acpi_dev =3D to_acpi_device(dev); \
> > +     if (acpi_dev->pld =3D=3D NULL) \
> > +             return -EIO; \
> > +     return sprintf(buf, "%u\n", acpi_dev->pld->prop); \
> > +}; \
>
> Ah, you are storing the _PLD below. Before there were concerns about
> the memory that the cached _PLD information would consume. Another way
> of doing this would be to just always evaluate the _PLD here.
>
> Rafael needs to comment on this. My personal opinion is that let's
> just store the thing.
>

By "always evaluate the _PLD here", you mean something like
  acpi_get_physical_device_location(dev->handle, &pld)
for every _PLD field, right?

I will wait for Rafael's comment on this.

> > +static DEVICE_ATTR_RO(prop)
> > +
> > +DEV_ATTR_PLD_PROP(revision);
> > +DEV_ATTR_PLD_PROP(group_token);
> > +DEV_ATTR_PLD_PROP(group_position);
> > +DEV_ATTR_PLD_PROP(user_visible);
> > +DEV_ATTR_PLD_PROP(dock);
> > +DEV_ATTR_PLD_PROP(bay);
> > +DEV_ATTR_PLD_PROP(lid);
> > +DEV_ATTR_PLD_PROP(panel);
> > +DEV_ATTR_PLD_PROP(vertical_position);
> > +DEV_ATTR_PLD_PROP(horizontal_position);
> > +DEV_ATTR_PLD_PROP(shape);
> > +
> > +static struct attribute *dev_attr_pld[] =3D {
> > +     &dev_attr_revision.attr,
> > +     &dev_attr_group_token.attr,
> > +     &dev_attr_group_position.attr,
> > +     &dev_attr_user_visible.attr,
> > +     &dev_attr_dock.attr,
> > +     &dev_attr_bay.attr,
> > +     &dev_attr_lid.attr,
> > +     &dev_attr_panel.attr,
> > +     &dev_attr_vertical_position.attr,
> > +     &dev_attr_horizontal_position.attr,
> > +     &dev_attr_shape.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group dev_attr_pld_group =3D {
> > +     .name =3D "pld",
> > +     .attrs =3D dev_attr_pld,
> > +};
> > +
> >  /**
> >   * acpi_device_setup_files - Create sysfs attributes of an ACPI device=
.
> >   * @dev: ACPI device object.
> > @@ -595,6 +638,16 @@ int acpi_device_setup_files(struct acpi_device *de=
v)
> >                                                   &dev_attr_real_power_=
state);
> >       }
> >
> > +     if (acpi_has_method(dev->handle, "_PLD")) {
> > +             status =3D acpi_get_physical_device_location(dev->handle,
> > +                     &dev->pld);
> > +             if (ACPI_FAILURE(status))
> > +                     goto end;
> > +             result =3D device_add_group(&dev->dev, &dev_attr_pld_grou=
p);
> > +             if (result)
> > +                     goto end;
> > +     }
>
> You probable want to store the pld in acpi_store_pld_crc(). Perhaps
> also rename that function to just acpi_store_pld() at the same time.
>
> Here you just want to create the sysfs group.
>

Got it. I will send v5 with this change.

> >       acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
> >
> >  end:
> > @@ -645,4 +698,6 @@ void acpi_device_remove_files(struct acpi_device *d=
ev)
> >               device_remove_file(&dev->dev, &dev_attr_status);
> >       if (dev->handle)
> >               device_remove_file(&dev->dev, &dev_attr_path);
> > +     if (acpi_has_method(dev->handle, "_PLD"))
> > +             device_remove_group(&dev->dev, &dev_attr_pld_group);
> >  }
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index ca88c4706f2b..929e726a666b 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -381,6 +381,7 @@ struct acpi_device {
> >       struct acpi_hotplug_context *hp;
> >       struct acpi_driver *driver;
> >       const struct acpi_gpio_mapping *driver_gpios;
> > +     struct acpi_pld_info *pld;
> >       void *driver_data;
> >       struct device dev;
> >       unsigned int physical_node_count;
> > --
>
> thanks,
>
> --
> heikki

Thank you,
Won
