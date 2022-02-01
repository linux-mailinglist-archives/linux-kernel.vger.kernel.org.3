Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1E24A54C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiBABul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiBABuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:50:40 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC34C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:50:40 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b13so30988917edn.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vX8lJ/5irFUbrQshrGKk6fkPcADVUFCEGVOJFcb+mTI=;
        b=sYD2zyJEoz0fDTJJIZbrppOA1xMwCQB+cNxzVXb0h0dPlrFD2LpXKpDRj358NqIgs/
         JuMsxJwMPp8B8HhxfF/8kwyUcO8RyzmLD030ShqTwwqNY0GpX8qXMgt1zCTcuTFj1ihS
         e29TjT/vZDa4m4LeO/SMK1rf84treEcYkZfjY+OK2EA+EZkRl9oE9bySFXp9Ik0HcucE
         kBxLN+4Kalhl61HFQDYl06QpgBYHQFvWZ7jajs0OXwgaCdQtar340Q2nx/LbsV6vX4pn
         g0QBXumC3e0/tnYlDoOFHrraZkjq4DaoDyQ7lhEK29xJkrKTuPzk9W7k+7LkP8tPRfpe
         V1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vX8lJ/5irFUbrQshrGKk6fkPcADVUFCEGVOJFcb+mTI=;
        b=1oaiN/VgNS+Zlbby1vRipbYYXxwSQ6BVGEDB4Dje2CTPUCu0SPtAMwbRUUdTI3MHLm
         z9sFzWtM2ge0opNRPujHRLNDkfGMXyf9X83mWYf1oEytJhCh5+PhM2y1Cc8auG1loTCJ
         +KS1UD5A+iETL/5sC0zeumpIt+XqKnbw/xmM1WRP3SzHOPT4pYJ9agccCqe+cMEW8VXA
         zUNVWEHAoDYpbFK2LeYWBnDkGVqzep8uLIS+3lqh8NbTWeXz71JfI6SSgHWpV4Hc2H0m
         nXP+Y/NBXnRRx539ntHoSaNTxPX2vUzvLXUbl/aLlfBdw+u2sM63myXJNTBOUCa34MNP
         wmoA==
X-Gm-Message-State: AOAM531ms1kiFnQQC0bERQQsu2sAq8qxoBle7gU2i1wUYeHDH+oFO/SV
        jaa6AYujkfwnggHNWRMre3fsZxtlg9+pDYrOaCnR26PxyUI=
X-Google-Smtp-Source: ABdhPJxCouayNuZTUdGVvLMO4egBm+KCI0nU5UkqGu9ZqFrhV5ilFNDk2UeMv9el1IUTl78Lhw2qeVqpRNreWTsC9Wk=
X-Received: by 2002:aa7:c906:: with SMTP id b6mr23294970edt.8.1643680238544;
 Mon, 31 Jan 2022 17:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20220128180832.2329149-1-wonchung@google.com> <YfeQxYNzWltRQ7mq@kuha.fi.intel.com>
In-Reply-To: <YfeQxYNzWltRQ7mq@kuha.fi.intel.com>
From:   Won Chung <wonchung@google.com>
Date:   Mon, 31 Jan 2022 17:50:27 -0800
Message-ID: <CAOvb9yiUUcyXx=_EgzFU6EqGHrnUWkKwRLPTEVM6SXyO0hXP6w@mail.gmail.com>
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

Hi Heikki,

Thank you for the review. It seems to be the convention to have a
separate attribute file for each field, as you pointed out. I have
made the change and sent v4.

Thanks,
Won


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
