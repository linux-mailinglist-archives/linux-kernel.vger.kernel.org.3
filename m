Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580584A9FE7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiBDTSU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Feb 2022 14:18:20 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:33329 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiBDTSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:18:15 -0500
Received: by mail-yb1-f182.google.com with SMTP id j2so21777474ybu.0;
        Fri, 04 Feb 2022 11:18:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rF2I2DA+0q3Faqi//9eeFZH2An/KNd6jHtr045+f6EQ=;
        b=fX/rR6oe1n6KRMFuPRMpngbNaCDgmV4dqW3eJmHoViupu/iwGh/PZGQb5eb/KpGg+6
         tX37Lkd4BDrlCJG+tiUzbu6c+zLcc0V8IhhxjiifD36taB0RG4doZx/A6pm8SfduWUQ3
         7ccUsueNUIu/73Zu4mbwymyZWlsLiCj68iooc/O8stwWYCaD8ZO08+tVbHmVUbzqp1h2
         dVS4mp4uvaznOJj+PM1xZlkbJQhL8yLDbpTTJYiWYveQUGSnYX2IAufYO8h4J41mXP25
         HuTW5owUX6cfMzCyFC4iaLuGO0pbxilHVj7RkJKkbDwsbOxBvUbiaKaSk2jR3eE/4del
         U/jw==
X-Gm-Message-State: AOAM533L6grLJe503Pf6WNuF6YiHweZwjw8fpkqu2eDdwpCX66m7vZRd
        hXwLJpKa56QruElCvPY5mHeerJUoH1jWx8OoyoA=
X-Google-Smtp-Source: ABdhPJyWHSFrxNdQyaDQH/O5Z5KPywEqNf7nTD8KpJ+ZcvPiOAq/t+0N5aTtyL+HJLpL8MNhFUfXtsGIruJH1ZEvgQE=
X-Received: by 2002:a05:6902:c4:: with SMTP id i4mr628653ybs.343.1644002294920;
 Fri, 04 Feb 2022 11:18:14 -0800 (PST)
MIME-Version: 1.0
References: <20220201015518.3118404-1-wonchung@google.com> <Yfo+gYLLOGN69Re1@kuha.fi.intel.com>
 <CAOvb9ygyupib4cMXhcdeZmgNZmyaCmaTF98MHae+irY5ruZ1Qw@mail.gmail.com>
In-Reply-To: <CAOvb9ygyupib4cMXhcdeZmgNZmyaCmaTF98MHae+irY5ruZ1Qw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Feb 2022 20:18:04 +0100
Message-ID: <CAJZ5v0hGxYv1xagc+ZQFhvpLpcbs1c1szZZahR7wsDm=i5AcJg@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: device_sysfs: Add sysfs support for _PLD
To:     Won Chung <wonchung@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 9:43 PM Won Chung <wonchung@google.com> wrote:
>
> Hi Heikki,
>
> Thank you for the review!
>
> On Wed, Feb 2, 2022 at 12:19 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi Won,
> >
> > On Tue, Feb 01, 2022 at 01:55:18AM +0000, Won Chung wrote:
> > > When ACPI table includes _PLD fields for a device, create a new
> > > directory (pld) in sysfs to share _PLD fields.
> >
> > I think you need to explain what needs this information in user space.
> >
> > > Signed-off-by: Won Chung <wonchung@google.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-acpi | 107 +++++++++++++++++++++++
> > >  drivers/acpi/device_sysfs.c              |  55 ++++++++++++
> > >  include/acpi/acpi_bus.h                  |   1 +
> > >  3 files changed, 163 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
> > > index 58abacf59b2a..b8b71c8f3cfd 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-acpi
> > > +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> > > @@ -96,3 +96,110 @@ Description:
> > >               hardware, if the _HRV control method is present.  It is mostly
> > >               useful for non-PCI devices because lspci can list the hardware
> > >               version for PCI devices.
> > > +
> > > +What:                /sys/bus/acpi/devices/.../pld/
> > > +Date:                Feb, 2022
> > > +Contact:     Won Chung <wonchung@google.com>
> > > +Description:
> > > +             This directory contains the output of the device object's _PLD
> > > +             control method, if present. This information provides details
> > > +             on physical location of a device.
> > > +
> > > +What:                /sys/bus/acpi/devices/.../pld/revision
> > > +Date:                Feb, 2022
> > > +Contact:     Won Chung <wonchung@google.com>
> > > +Description:
> > > +             The current revision is 0x2.
> > > +
> > > +What:           /sys/bus/acpi/devices/.../pld/group_token
> > > +Date:           Feb, 2022
> > > +Contact:        Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Unique numerical value identifying a group.
> > > +
> > > +What:           /sys/bus/acpi/devices/.../pld/group_position
> > > +Date:           Feb, 2022
> > > +Contact:        Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Identifies this device connection point’s position in the group.
> > > +
> > > +What:           /sys/bus/acpi/devices/.../pld/user_visible
> > > +Date:           Feb, 2022
> > > +Contact:        Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Set if the device connection point can be seen by the user
> > > +             without disassembly.
> > > +
> > > +What:           /sys/bus/acpi/devices/.../pld/dock
> > > +Date:           Feb, 2022
> > > +Contact:        Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Set if the device connection point resides in a docking station
> > > +             or port replicator.
> > > +
> > > +What:           /sys/bus/acpi/devices/.../pld/bay
> > > +Date:           Feb, 2022
> > > +Contact:        Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Set if describing a device in a bay or if device connection
> > > +             point is a bay.
> > > +
> > > +What:           /sys/bus/acpi/devices/.../pld/lid
> > > +Date:           Feb, 2022
> > > +Contact:        Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Set if this device connection point resides on the lid of
> > > +             laptop system.
> > > +
> > > +What:           /sys/bus/acpi/devices/.../pld/panel
> > > +Date:           Feb, 2022
> > > +Contact:        Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Describes which panel surface of the system’s housing the
> > > +             device connection point resides on:
> > > +             0 - Top
> > > +             1 - Bottom
> > > +             2 - Left
> > > +             3 - Right
> > > +             4 - Front
> > > +             5 - Back
> > > +             6 - Unknown (Vertical Position and Horizontal Position will be
> > > +             ignored)
> > > +
> > > +What:           /sys/bus/acpi/devices/.../pld/vertical_position
> > > +Date:           Feb, 2022
> > > +Contact:        Won Chung <wonchung@google.com>
> > > +Description:
> > > +             0 - Upper
> > > +             1 - Center
> > > +             2 - Lower
> > > +
> > > +What:           /sys/bus/acpi/devices/.../pld/horizontal_position
> > > +Date:           Feb, 2022
> > > +Contact:        Won Chung <wonchung@google.com>
> > > +Description:
> > > +             ACPI specification does not define horizontal position field.
> > > +             Can be used as either
> > > +             0 - Left
> > > +             1 - Center
> > > +             2 - Right
> > > +             or
> > > +             0 - Leftmost
> > > +             and higher numbers going toward the right.
> > > +
> > > +What:           /sys/bus/acpi/devices/.../pld/shape
> > > +Date:           Feb, 2022
> > > +Contact:        Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Describes the shape of the device connection point.
> > > +             0 - Round
> > > +             1 - Oval
> > > +             2 - Square
> > > +             3 - Vertical Rectangle
> > > +             4 - Horizontal Rectangle
> > > +             5 - Vertical Trapezoid
> > > +             6 - Horizontal Trapezoid
> > > +             7 - Unknown - Shape rendered as a Rectangle with dotted lines
> > > +             8 - Chamfered
> > > +             15:9 - Reserved
> > > +
> > > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > > index d5d6403ba07b..610be93635a0 100644
> > > --- a/drivers/acpi/device_sysfs.c
> > > +++ b/drivers/acpi/device_sysfs.c
> > > @@ -509,6 +509,49 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
> > >  }
> > >  static DEVICE_ATTR_RO(status);
> > >
> > > +#define DEV_ATTR_PLD_PROP(prop) \
> > > +     static ssize_t prop##_show(struct device *dev, struct device_attribute *attr, \
> > > +             char *buf) \
> > > +{ \
> > > +     struct acpi_device *acpi_dev = to_acpi_device(dev); \
> > > +     if (acpi_dev->pld == NULL) \
> > > +             return -EIO; \
> > > +     return sprintf(buf, "%u\n", acpi_dev->pld->prop); \
> > > +}; \
> >
> > Ah, you are storing the _PLD below. Before there were concerns about
> > the memory that the cached _PLD information would consume. Another way
> > of doing this would be to just always evaluate the _PLD here.
> >
> > Rafael needs to comment on this. My personal opinion is that let's
> > just store the thing.
> >
>
> By "always evaluate the _PLD here", you mean something like
>   acpi_get_physical_device_location(dev->handle, &pld)
> for every _PLD field, right?
>
> I will wait for Rafael's comment on this.

So I would like to get back to the very beginning: Do you need full
_PLD output to address the issue at hand?

If so, do you really need it for all devices that have _PLD?

If not, then why waste memory for all that stuff?
