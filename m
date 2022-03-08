Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6264D0E3F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 04:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiCHDSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 22:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiCHDSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 22:18:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAACBF7F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:17:37 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h13so10519279ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 19:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MTCdqGDIE1NaAeEeb7RPh4nQs4jFR4dA/CUROb5/hYc=;
        b=QpZ7XQUl5RTMO2n4lP5ka5cVkuzkEhHPSvHiYypsPJCCZvW1otNK58x41+29KZrBgA
         VnAmNaZk52Pj0rULC25z0mf2FlEjp43zngS7co+mnjk7U8Kdb8/t9oERCCPwNhIdZTRR
         xCaikuYuz6LVu5sQoonk5dRgtgoAfkuKI83qiK8ELylgmcmhQfqhlKdOR4Jjut1fQViV
         yyB7/mzjQTPbotbuI2lg6rZW98C9seXCar6UallWgIqbDWhhrcu3rKTi9MNtTUP9WKYb
         GLdb7Pw1Nny1U0JI7VMe/bq1Wuweejepc6AiqwBauC5NrISHu9nDGkAf+MiHQFkvUN/W
         G+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MTCdqGDIE1NaAeEeb7RPh4nQs4jFR4dA/CUROb5/hYc=;
        b=D1dVbRa/W2uWEEpBKsFraq3lPTz5m3xvt5epXz0+o6Ckpb4Zj7iqi0ad1TzRxwBLNe
         Rp6olekJzXeokf5rr5ZfBVADBcebVCCvPjqy1U4mrJu7a5gws5tWQg+cdJa2LiEF3dMH
         V7/QaDuw1Z7+Gbs8JupTbyXsVwmi9dg+vQZHXfBpUXyZqvhdRvD+K+M+dzBTL4Z3dA9p
         P2ycGcU6C7tCsPxy6ZK6W/OrSs2CloTnaMT2qn5iSYd8EmusCC6cfYwedoPbF4viXUDA
         cF4HCa9zMlTvsJDq7ubBACq4A3vT8bwn7mtBvtn+eKcur5aXV3/9FVA8cA+M3ZS0ptqO
         lqKA==
X-Gm-Message-State: AOAM533lAA0OdMg/1WcZPeIgD9NYVhgY+YW7a52cSJSpDG7HhwE/kfGn
        Y5Htsihjj4aNmiWIJlQOH9XIxi44FRoWj4JT6ssQvzHSgPbhfw==
X-Google-Smtp-Source: ABdhPJyjnWxKgQXrHGPwlIEVZHAk1dvNEXdCyBaYwxERPukHX27QFGdKgJeURAoKwn2DYxuBKT2w5XbPiuSUYaA2OOU=
X-Received: by 2002:a05:6402:51d0:b0:416:523e:a779 with SMTP id
 r16-20020a05640251d000b00416523ea779mr6039250edd.264.1646709455356; Mon, 07
 Mar 2022 19:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20220305004258.2484798-1-wonchung@google.com> <YiS/ei+GFF0bwBSr@kroah.com>
In-Reply-To: <YiS/ei+GFF0bwBSr@kroah.com>
From:   Won Chung <wonchung@google.com>
Date:   Mon, 7 Mar 2022 19:17:24 -0800
Message-ID: <CAOvb9yjbm=u1W_dyW1J--=HEMbcuUnZ521YkHu1moXyMyctv0g@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Add sysfs support for physical location
 of a device
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thank you for the review.

I have a few questions on your comments.


On Sun, Mar 6, 2022 at 6:04 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Mar 05, 2022 at 12:42:58AM +0000, Won Chung wrote:
> > When ACPI table includes _PLD fields for a device, create a new
> > directory (physical_location) in sysfs to share _PLD fields.
> >
> > Currently without PLD information, when there are multiple of same
> > devices, it is hard to distinguish which device corresponds to which
> > physical device at which location. For example, when there are two Type
> > C connectors, it is hard to find out which connector corresponds to the
> > Type C port on the left panel versus the Type C port on the right panel=
.
> > With PLD information provided, we can determine which specific device a=
t
> > which location is doing what.
> >
> > _PLD output includes much more fields, but only generic fields are adde=
d
> > and exposed to sysfs, so that non-ACPI devices can also support it in
> > the future. The minimal generic fields needed for locating a device are
> > the following.
> > - panel
> > - vertical_position
> > - horizontal_position
> > - dock
> > - lid
> >
> > Signed-off-by: Won Chung <wonchung@google.com>
> > ---
> >
> > Changes from v2
> > - Use sysfs_emit to create files.
> > - Correct mix of spaces and tabs.
> >
> > Changes from v1
> > - Correct directory names in Documentation.
> > - Clarify namings in core.c
> >
> >  .../testing/sysfs-devices-physical_location   |  42 ++++++
> >  drivers/base/core.c                           | 139 ++++++++++++++++++
> >  include/linux/device.h                        |  73 +++++++++
> >  3 files changed, 254 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-devices-physical_lo=
cation
> >
> > diff --git a/Documentation/ABI/testing/sysfs-devices-physical_location =
b/Documentation/ABI/testing/sysfs-devices-physical_location
> > new file mode 100644
> > index 000000000000..202324b87083
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-devices-physical_location
> > @@ -0,0 +1,42 @@
> > +What:                /sys/devices/.../physical_location
> > +Date:                March 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             This directory contains information on physical location =
of
> > +             the device connection point with respect to the system's
> > +             housing.
> > +
> > +What:                /sys/devices/.../physical_location/panel
> > +Date:                March 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             Describes which panel surface of the system=E2=80=99s hou=
sing the
> > +             device connection point resides on.
> > +
> > +What:                /sys/devices/.../physical_location/vertical_posit=
ion
> > +Date:                March 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             Describes vertical position of the device connection poin=
t on
> > +             the panel surface.
> > +
> > +What:                /sys/devices/.../physical_location/horizontal_pos=
ition
> > +Date:                March 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             Describes horizontal position of the device connection po=
int on
> > +             the panel surface.
> > +
> > +What:                /sys/devices/.../physical_location/dock
> > +Date:                March 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             "Yes" if the device connection point resides in a docking
> > +             station or a port replicator. "No" otherwise.
> > +
> > +What:                /sys/devices/.../physical_location/lid
> > +Date:                March 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             "Yes" if the device connection point resides on the lid o=
f
> > +             laptop system. "No" otherwise.
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 7bb957b11861..9cfa71ad21f3 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2466,6 +2466,136 @@ static ssize_t removable_show(struct device *de=
v, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(removable);
> >
> > +static int dev_add_physical_location(struct device *dev)
> > +{
> > +#if defined(CONFIG_ACPI)
> > +     struct acpi_pld_info *pld;
> > +     acpi_status status;
> > +
> > +     if (!has_acpi_companion(dev))
> > +             return 0;
> > +
> > +     status =3D acpi_get_physical_device_location(ACPI_HANDLE(dev), &p=
ld);
> > +     if (ACPI_FAILURE(status) || !pld)
> > +             return 0;
> > +
> > +     dev->location =3D (struct device_location) {
> > +             .panel =3D pld->panel,
> > +             .vertical_position =3D pld->vertical_position,
> > +             .horizontal_position =3D pld->horizontal_position,
> > +             .dock =3D pld->dock,
> > +             .lid =3D pld->lid,
> > +     };
>
> Is this a memcpy()?  Ick, that's odd.
>
> > +
> > +     return 1;
>
> Kernel functions do not return "1" as success.  Or as an error.
> Positive numbers are ONLY for when to return the number of bytes
> consumed/written or the like.
>
> > +#else
>
> I have asked multiple times to not put #ifdef in .c files.  I can't take
> this patch for that fact alone (also big hint, if acpi is not enabled,
> loads of these functions and the structure itself should not be present
> at all...)
>
>
>
>
>
> > +     return 0;
> > +#endif
> > +}
> > +
> > +static ssize_t panel_show(struct device *dev, struct device_attribute =
*attr,
> > +     char *buf)
> > +{
> > +     const char *panel;
> > +
> > +     switch (dev->location.panel) {
> > +     case DEVICE_PANEL_TOP:
> > +             panel =3D "top";
> > +             break;
> > +     case DEVICE_PANEL_BOTTOM:
> > +             panel =3D "bottom";
> > +             break;
> > +     case DEVICE_PANEL_LEFT:
> > +             panel =3D "left";
> > +             break;
> > +     case DEVICE_PANEL_RIGHT:
> > +             panel =3D "right";
> > +             break;
> > +     case DEVICE_PANEL_FRONT:
> > +             panel =3D "front";
> > +             break;
> > +     case DEVICE_PANEL_BACK:
> > +             panel =3D "back";
> > +             break;
> > +     default:
> > +             panel =3D "unknown";
> > +     }
> > +     return sysfs_emit(buf, "%s\n", panel);
> > +}
> > +static DEVICE_ATTR_RO(panel);
> > +
> > +static ssize_t vertical_position_show(struct device *dev,
> > +     struct device_attribute *attr, char *buf)
> > +{
> > +     const char *vertical_position;
> > +
> > +     switch (dev->location.vertical_position) {
> > +     case DEVICE_VERT_POS_UPPER:
> > +             vertical_position =3D "upper";
> > +             break;
> > +     case DEVICE_VERT_POS_CENTER:
> > +             vertical_position =3D "center";
> > +             break;
> > +     case DEVICE_VERT_POS_LOWER:
> > +             vertical_position =3D "lower";
> > +             break;
> > +     default:
> > +             vertical_position =3D "unknown";
> > +     }
> > +     return sysfs_emit(buf, "%s\n", vertical_position);
> > +}
> > +static DEVICE_ATTR_RO(vertical_position);
> > +
> > +static ssize_t horizontal_position_show(struct device *dev,
> > +     struct device_attribute *attr, char *buf)
> > +{
> > +     const char *horizontal_position;
> > +
> > +     switch (dev->location.horizontal_position) {
> > +     case DEVICE_HORI_POS_LEFT:
> > +             horizontal_position =3D "left";
> > +             break;
> > +     case DEVICE_HORI_POS_CENTER:
> > +             horizontal_position =3D "center";
> > +             break;
> > +     case DEVICE_HORI_POS_RIGHT:
> > +             horizontal_position =3D "right";
> > +             break;
> > +     default:
> > +             horizontal_position =3D "unknown";
> > +     }
> > +     return sysfs_emit(buf, "%s\n", horizontal_position);
> > +}
> > +static DEVICE_ATTR_RO(horizontal_position);
> > +
> > +static ssize_t dock_show(struct device *dev, struct device_attribute *=
attr,
> > +     char *buf)
>
> Did you run your patch through checkpatch.pl?
>
> Please do so.
>

I think I did run checkpatch.pl. I tried again but there is no issue
other than a warning that the maintainers list may need to be updated
due to a new file. Do you think there is a style issue here?

> > +{
> > +     return sysfs_emit(buf, "%s\n", dev->location.dock ? "yes" : "no")=
;
> > +}
> > +static DEVICE_ATTR_RO(dock);
> > +
> > +static ssize_t lid_show(struct device *dev, struct device_attribute *a=
ttr,
> > +     char *buf)
> > +{
> > +     return sysfs_emit(buf, "%s\n", dev->location.lid ? "yes" : "no");
> > +}
> > +static DEVICE_ATTR_RO(lid);
> > +
> > +static struct attribute *dev_attr_physical_location[] =3D {
> > +     &dev_attr_panel.attr,
> > +     &dev_attr_vertical_position.attr,
> > +     &dev_attr_horizontal_position.attr,
> > +     &dev_attr_dock.attr,
> > +     &dev_attr_lid.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group dev_attr_physical_location_group =
=3D {
> > +     .name =3D "physical_location",
>
> I'm all for being verbose, but why not just "location"?  What other type
> of location is there for a device?

For USB ports, there seems to be a "location" file for u32 value
representing ACPI PLD group token and group location.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/usb/core/port.c#n20

Would you prefer renaming that "location" file to something else and
have this one as "location" directory? Or would "physical_location" be
okay?

>
> > +     .attrs =3D dev_attr_physical_location,
> > +};
> > +
> >  int device_add_groups(struct device *dev, const struct attribute_group=
 **groups)
> >  {
> >       return sysfs_create_groups(&dev->kobj, groups);
> > @@ -2649,8 +2779,17 @@ static int device_add_attrs(struct device *dev)
> >                       goto err_remove_dev_waiting_for_supplier;
> >       }
> >
> > +     if (dev_add_physical_location(dev)) {
> > +             error =3D device_add_group(dev,
> > +                     &dev_attr_physical_location_group);
> > +             if (error)
> > +                     goto err_remove_dev_physical_location;
> > +     }
> > +
> >       return 0;
> >
> > + err_remove_dev_physical_location:
> > +     device_remove_group(dev, &dev_attr_physical_location_group);
> >   err_remove_dev_waiting_for_supplier:
> >       device_remove_file(dev, &dev_attr_waiting_for_supplier);
> >   err_remove_dev_online:
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 93459724dcde..424be9cb735e 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -386,6 +386,75 @@ struct dev_msi_info {
> >  #endif
> >  };
> >
> > +/**
> > + * enum device_location_panel - Describes which panel surface of the s=
ystem's
> > + * housing the device connection point resides on.
> > + * @DEVICE_PANEL_TOP: Device connection point is on the top panel.
> > + * @DEVICE_PANEL_BOTTOM: Device connection point is on the bottom pane=
l.
> > + * @DEVICE_PANEL_LEFT: Device connection point is on the left panel.
> > + * @DEVICE_PANEL_RIGHT: Device connection point is on the right panel.
> > + * @DEVICE_PANEL_FRONT: Device connection point is on the front panel.
> > + * @DEVICE_PANEL_BACK: Device connection point is on the back panel.
> > + * @DEVICE_PANEL_UNKNOWN: The panel with device connection point is un=
known.
> > + */
> > +enum device_location_panel {
> > +     DEVICE_PANEL_TOP,
> > +     DEVICE_PANEL_BOTTOM,
> > +     DEVICE_PANEL_LEFT,
> > +     DEVICE_PANEL_RIGHT,
> > +     DEVICE_PANEL_FRONT,
> > +     DEVICE_PANEL_BACK,
> > +     DEVICE_PANEL_UNKNOWN,
> > +};
> > +
> > +/**
> > + * enum device_location_vertical_position - Describes vertical positio=
n of the
> > + * device connection point on the panel surface.
> > + * @DEVICE_VERT_POS_UPPER: Device connection point is at upper part of=
 panel.
> > + * @DEVICE_VERT_POS_CENTER: Device connection point is at center part =
of panel.
> > + * @DEVICE_VERT_POS_LOWER: Device connection point is at lower part of=
 panel.
> > + */
> > +enum device_location_vertical_position {
> > +     DEVICE_VERT_POS_UPPER,
> > +     DEVICE_VERT_POS_CENTER,
> > +     DEVICE_VERT_POS_LOWER,
> > +};
> > +
> > +/**
> > + * enum device_location_horizontal_position - Describes horizontal pos=
ition of
> > + * the device connection point on the panel surface.
> > + * @DEVICE_HORI_POS_LEFT: Device connection point is at left part of p=
anel.
> > + * @DEVICE_HORI_POS_CENTER: Device connection point is at center part =
of panel.
> > + * @DEVICE_HORI_POS_RIGHT: Device connection point is at right part of=
 panel.
> > + */
> > +enum device_location_horizontal_position {
> > +     DEVICE_HORI_POS_LEFT,
> > +     DEVICE_HORI_POS_CENTER,
> > +     DEVICE_HORI_POS_RIGHT,
> > +};
>
> Why do these enum values need to be in device.h?  Can they just live in
> drivers/base/ somewhere?
>

I was thinking that since these are information about device, they
could live in and be accessed through device.
Do you think this is not a good place for these enum and struct? Maybe
a new driver/base/location.h?

>
> > +
> > +/**
> > + * struct device_location - Device data related to physical location o=
f the
> > + * device connection point.
> > + * @panel: Panel surface of the system's housing that the device conne=
ction
> > + *         point resides on.
> > + * @vertical_position: Vertical position of the device connection poin=
t within
> > + *                     the panel.
> > + * @horizontal_position: Horizontal position of the device connection =
point
> > + *                       within the panel.
> > + * @dock: Set if the device connection point resides in a docking stat=
ion or
> > + *        port replicator.
> > + * @lid: Set if this device connection point resides on the lid of lap=
top
> > + *       system.
> > + */
> > +struct device_location {
> > +     enum device_location_panel panel;
> > +     enum device_location_vertical_position vertical_position;
> > +     enum device_location_horizontal_position horizontal_position;
> > +     bool dock;
> > +     bool lid;
>
> How badly did you just inflate all device structures in the kernel?  Did
> you use 'pahole' to see if you added padding or not?
>

I did not use pahole. I tried it and it is giving 16 bytes for struct
device_location and 2 bytes of padding.
Would using device location* instead be better since that would be 8
bytes of inflation?

> > +};
> > +
> >  /**
> >   * struct device - The basic device structure
> >   * @parent:  The device's "parent" device, the device to which it is a=
ttached.
> > @@ -456,6 +525,8 @@ struct dev_msi_info {
> >   * @removable:  Whether the device can be removed from the system. Thi=
s
> >   *              should be set by the subsystem / bus driver that disco=
vered
> >   *              the device.
> > + * @location:        Describes physical location of the device connect=
ion point in
> > + *           the system housing.
> >   *
> >   * @offline_disabled: If set, the device is permanently online.
> >   * @offline: Set after successful invocation of bus type's .offline().
> > @@ -569,6 +640,8 @@ struct device {
> >
> >       enum device_removable   removable;
> >
> > +     struct device_location  location;
>
> See, you just call it "location" here, not "physical_location", so why
> does userspace get a bigger name than the kernel does?  :)
>
> thanks,
>
> greg k-h


Thank you,
Won
