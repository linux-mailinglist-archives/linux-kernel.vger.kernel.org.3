Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAB74CDBDD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbiCDSNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241549AbiCDSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:12:50 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F61D0865
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:12:02 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id j2so18563611ybu.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xzfKPD5to4R2Bd+WBSaca36O0Si+C+IzxNFQer6L/H8=;
        b=se47QukWTkmDk0oc6Ju0sSM2RFFaeomrZK8g1T40UJU7a7W5UzKYpIHUM7EVwwXk0D
         cFnL3aYsE/gMj5BEuxD2d3ywniOV6VfefjIUgLlOQfbaFvFiihDZ1vFPhaWr7EKR3LO7
         ErTifCLLw8UrwwBORNKCErgc2hCL+oKaC62n7qZfiiuYYPVvkhjcSvyK2l5emxbUHZOa
         TKfuv6SqXMEi6Sxgnjk2XZkOsQrCapFTgDcb4gr2w8VVmyl928rMCsBLHhpQVwZaDbTi
         pBhNcOhdtX36BuDRtkM9wrRpaj1UEUdrGs8ZrHBDLk8Up+iNFzDbjTQ7BowHS8W8WKLM
         Jx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=xzfKPD5to4R2Bd+WBSaca36O0Si+C+IzxNFQer6L/H8=;
        b=IpNuCzCidIsdctuHkF8QcMCX1WkD71zAuu1qGJXJaQcuk6Y6yRoYToOn1tL3YmPEz0
         XciRRGajq/gdYKWYRl5SOhheAfrCrPyfaaSVP/Lx4p6gO1o+jDhZw3DohN10258FWIZn
         EUZRX+R/sFVdlJsvl+w3iwxlqHj6yqLOx905oDwrrmyucqZXN6JqMxTVaQYg7YCYtnk0
         ANv+1SdIdPadY+45IQwEKlrowIvaPXTGaxwIhU4sU4wGgoO5iN7lii3h4+fQd27VNSo8
         fTNOUhC2IDdy/S+oNZD54ZbK1XAoBG2E1ucuQvak47/LdC41vtcfRH8WiK0ogrQQJ0HU
         4H0g==
X-Gm-Message-State: AOAM531ehGJr1yNEB2Dq61mAWEEJXI/R7Zprr25mHjBIgk9YckoS/aTq
        TyyHnUI3jJxOs2UKZ5P+yOCdwPoj5EbDINWeGRauaA==
X-Google-Smtp-Source: ABdhPJx0jTEAj3nMFsSAtR9pblueUIZH6hMsGsssX/DHz7KvuWbjNdQ+IIzNp0ksVahHyD/MEzll9nP71P9jH0CL1Hs=
X-Received: by 2002:a25:b5c7:0:b0:628:1f48:12fa with SMTP id
 d7-20020a25b5c7000000b006281f4812famr27246728ybg.466.1646417521436; Fri, 04
 Mar 2022 10:12:01 -0800 (PST)
MIME-Version: 1.0
References: <20220303013716.1739717-1-wonchung@google.com>
In-Reply-To: <20220303013716.1739717-1-wonchung@google.com>
From:   Won Chung <wonchung@google.com>
Date:   Fri, 4 Mar 2022 10:11:50 -0800
Message-ID: <CAOvb9yji5ZOQH5dxYYeFEDfX1yp+fHUgpMtaiQy72QNfyTrn+w@mail.gmail.com>
Subject: Re: [PATCH] driver core: Add sysfs support for physical location of a device
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 5:37 PM Won Chung <wonchung@google.com> wrote:
>
> When ACPI table includes _PLD fields for a device, create a new
> directory (physical_location) in sysfs to share _PLD fields.
>
> Currently without PLD information, when there are multiple of same
> devices, it is hard to distinguish which device corresponds to which
> physical device at which location. For example, when there are two Type
> C connectors, it is hard to find out which connector corresponds to the
> Type C port on the left panel versus the Type C port on the right panel.
> With PLD information provided, we can determine which specific device at
> which location is doing what.
>
> _PLD output includes much more fields, but only generic fields are added
> and exposed to sysfs, so that non-ACPI devices can also support it in
> the future. The minimal generic fields needed for locating a device are
> the following.
> - panel
> - vertical_position
> - horizontal_position
> - dock
> - lid
>
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
>  .../ABI/testing/sysfs-devices-location        |  42 ++++++
>  drivers/base/core.c                           | 138 ++++++++++++++++++
>  include/linux/device.h                        |  73 +++++++++
>  3 files changed, 253 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-location
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-location b/Documenta=
tion/ABI/testing/sysfs-devices-location
> new file mode 100644
> index 000000000000..bde81ce97a61
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-location
> @@ -0,0 +1,42 @@
> +What:          /sys/devices/.../location
> +Date:          March 2022
> +Contact:       Won Chung <wonchung@google.com>
> +Description:
> +               This directory contains information on physical location =
of
> +               the device connection point with respect to the system's
> +               housing.
> +
> +What:           /sys/devices/.../location/panel
> +Date:           March 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +               Describes which panel surface of the system=E2=80=99s hou=
sing the
> +               device connection point resides on.
> +
> +What:           /sys/devices/.../location/vertical_position
> +Date:           March 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +               Describes vertical position of the device connection poin=
t on
> +               the panel surface.
> +
> +What:           /sys/devices/.../location/horizontal_position
> +Date:           March 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +               Describes horizontal position of the device connection po=
int on
> +               the panel surface.
> +
> +What:           /sys/devices/.../location/dock
> +Date:           March 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +               "Yes" if the device connection point resides in a docking
> +               station or a port replicator. "No" otherwise.
> +
> +What:           /sys/devices/.../location/lid
> +Date:           March 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +               "Yes" if the device connection point resides on the lid o=
f
> +               laptop system. "No" otherwise.
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 7bb957b11861..6b30007a319a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2466,6 +2466,136 @@ static ssize_t removable_show(struct device *dev,=
 struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(removable);
>
> +static int dev_get_and_add_location(struct device *dev)
> +{
> +#if defined(CONFIG_ACPI)
> +       struct acpi_pld_info *pld;
> +       acpi_status status;
> +
> +       if (!has_acpi_companion(dev))
> +               return 0;
> +
> +       status =3D acpi_get_physical_device_location(ACPI_HANDLE(dev), &p=
ld);
> +       if (ACPI_FAILURE(status))
> +               return 0;
> +
> +       dev->location =3D (struct device_location) {
> +               .panel =3D pld->panel,
> +               .vertical_position =3D pld->vertical_position,
> +               .horizontal_position =3D pld->horizontal_position,
> +               .dock =3D pld->dock,
> +               .lid =3D pld->lid,
> +       };
> +
> +       return 1;
> +#else
> +       return 0;
> +#endif
> +}
> +
> +static ssize_t panel_show(struct device *dev, struct device_attribute *a=
ttr,
> +       char *buf)
> +{
> +       const char *panel;
> +
> +       switch (dev->location.panel) {
> +       case DEVICE_PANEL_TOP:
> +               panel =3D "top";
> +               break;
> +       case DEVICE_PANEL_BOTTOM:
> +               panel =3D "bottom";
> +               break;
> +       case DEVICE_PANEL_LEFT:
> +               panel =3D "left";
> +               break;
> +       case DEVICE_PANEL_RIGHT:
> +               panel =3D "right";
> +               break;
> +       case DEVICE_PANEL_FRONT:
> +               panel =3D "front";
> +               break;
> +       case DEVICE_PANEL_BACK:
> +               panel =3D "back";
> +               break;
> +       default:
> +               panel =3D "unknown";
> +       }
> +       return sprintf(buf, "%s\n", panel);
> +}
> +static DEVICE_ATTR_RO(panel);
> +
> +static ssize_t vertical_position_show(struct device *dev,
> +       struct device_attribute *attr, char *buf)
> +{
> +       const char *vertical_position;
> +
> +       switch (dev->location.vertical_position) {
> +       case DEVICE_VERT_POS_UPPER:
> +               vertical_position =3D "upper";
> +               break;
> +       case DEVICE_VERT_POS_CENTER:
> +               vertical_position =3D "center";
> +               break;
> +       case DEVICE_VERT_POS_LOWER:
> +               vertical_position =3D "lower";
> +               break;
> +       default:
> +               vertical_position =3D "unknown";
> +       }
> +       return sprintf(buf, "%s\n", vertical_position);
> +}
> +static DEVICE_ATTR_RO(vertical_position);
> +
> +static ssize_t horizontal_position_show(struct device *dev,
> +       struct device_attribute *attr, char *buf)
> +{
> +       const char *horizontal_position;
> +
> +       switch (dev->location.horizontal_position) {
> +       case DEVICE_HORI_POS_LEFT:
> +               horizontal_position =3D "left";
> +               break;
> +       case DEVICE_HORI_POS_CENTER:
> +               horizontal_position =3D "center";
> +               break;
> +       case DEVICE_HORI_POS_RIGHT:
> +               horizontal_position =3D "right";
> +               break;
> +       default:
> +               horizontal_position =3D "unknown";
> +       }
> +       return sprintf(buf, "%s\n", horizontal_position);
> +}
> +static DEVICE_ATTR_RO(horizontal_position);
> +
> +static ssize_t dock_show(struct device *dev, struct device_attribute *at=
tr,
> +       char *buf)
> +{
> +       return sprintf(buf, "%s\n", dev->location.dock ? "yes" : "no");
> +}
> +static DEVICE_ATTR_RO(dock);
> +
> +static ssize_t lid_show(struct device *dev, struct device_attribute *att=
r,
> +       char *buf)
> +{
> +       return sprintf(buf, "%s\n", dev->location.lid ? "yes" : "no");
> +}
> +static DEVICE_ATTR_RO(lid);
> +
> +static struct attribute *dev_attr_location[] =3D {
> +       &dev_attr_panel.attr,
> +       &dev_attr_vertical_position.attr,
> +       &dev_attr_horizontal_position.attr,
> +       &dev_attr_dock.attr,
> +       &dev_attr_lid.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group dev_attr_location_group =3D {
> +       .name =3D "physical_location",
> +       .attrs =3D dev_attr_location,
> +};
> +
>  int device_add_groups(struct device *dev, const struct attribute_group *=
*groups)
>  {
>         return sysfs_create_groups(&dev->kobj, groups);
> @@ -2649,8 +2779,16 @@ static int device_add_attrs(struct device *dev)
>                         goto err_remove_dev_waiting_for_supplier;
>         }
>
> +       if (dev_get_and_add_location(dev)) {
> +               error =3D device_add_group(dev, &dev_attr_location_group)=
;
> +               if (error)
> +                       goto err_remove_dev_location;
> +       }
> +
>         return 0;
>
> + err_remove_dev_location:
> +       device_remove_group(dev, &dev_attr_location_group);
>   err_remove_dev_waiting_for_supplier:
>         device_remove_file(dev, &dev_attr_waiting_for_supplier);
>   err_remove_dev_online:
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 93459724dcde..424be9cb735e 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -386,6 +386,75 @@ struct dev_msi_info {
>  #endif
>  };
>
> +/**
> + * enum device_location_panel - Describes which panel surface of the sys=
tem's
> + * housing the device connection point resides on.
> + * @DEVICE_PANEL_TOP: Device connection point is on the top panel.
> + * @DEVICE_PANEL_BOTTOM: Device connection point is on the bottom panel.
> + * @DEVICE_PANEL_LEFT: Device connection point is on the left panel.
> + * @DEVICE_PANEL_RIGHT: Device connection point is on the right panel.
> + * @DEVICE_PANEL_FRONT: Device connection point is on the front panel.
> + * @DEVICE_PANEL_BACK: Device connection point is on the back panel.
> + * @DEVICE_PANEL_UNKNOWN: The panel with device connection point is unkn=
own.
> + */
> +enum device_location_panel {
> +       DEVICE_PANEL_TOP,
> +       DEVICE_PANEL_BOTTOM,
> +       DEVICE_PANEL_LEFT,
> +       DEVICE_PANEL_RIGHT,
> +       DEVICE_PANEL_FRONT,
> +       DEVICE_PANEL_BACK,
> +       DEVICE_PANEL_UNKNOWN,
> +};
> +
> +/**
> + * enum device_location_vertical_position - Describes vertical position =
of the
> + * device connection point on the panel surface.
> + * @DEVICE_VERT_POS_UPPER: Device connection point is at upper part of p=
anel.
> + * @DEVICE_VERT_POS_CENTER: Device connection point is at center part of=
 panel.
> + * @DEVICE_VERT_POS_LOWER: Device connection point is at lower part of p=
anel.
> + */
> +enum device_location_vertical_position {
> +       DEVICE_VERT_POS_UPPER,
> +       DEVICE_VERT_POS_CENTER,
> +       DEVICE_VERT_POS_LOWER,
> +};
> +
> +/**
> + * enum device_location_horizontal_position - Describes horizontal posit=
ion of
> + * the device connection point on the panel surface.
> + * @DEVICE_HORI_POS_LEFT: Device connection point is at left part of pan=
el.
> + * @DEVICE_HORI_POS_CENTER: Device connection point is at center part of=
 panel.
> + * @DEVICE_HORI_POS_RIGHT: Device connection point is at right part of p=
anel.
> + */
> +enum device_location_horizontal_position {
> +       DEVICE_HORI_POS_LEFT,
> +       DEVICE_HORI_POS_CENTER,
> +       DEVICE_HORI_POS_RIGHT,
> +};
> +
> +/**
> + * struct device_location - Device data related to physical location of =
the
> + * device connection point.
> + * @panel: Panel surface of the system's housing that the device connect=
ion
> + *         point resides on.
> + * @vertical_position: Vertical position of the device connection point =
within
> + *                     the panel.
> + * @horizontal_position: Horizontal position of the device connection po=
int
> + *                       within the panel.
> + * @dock: Set if the device connection point resides in a docking statio=
n or
> + *        port replicator.
> + * @lid: Set if this device connection point resides on the lid of lapto=
p
> + *       system.
> + */
> +struct device_location {
> +       enum device_location_panel panel;
> +       enum device_location_vertical_position vertical_position;
> +       enum device_location_horizontal_position horizontal_position;
> +       bool dock;
> +       bool lid;
> +};
> +
>  /**
>   * struct device - The basic device structure
>   * @parent:    The device's "parent" device, the device to which it is a=
ttached.
> @@ -456,6 +525,8 @@ struct dev_msi_info {
>   * @removable:  Whether the device can be removed from the system. This
>   *              should be set by the subsystem / bus driver that discove=
red
>   *              the device.
> + * @location:  Describes physical location of the device connection poin=
t in
> + *             the system housing.
>   *
>   * @offline_disabled: If set, the device is permanently online.
>   * @offline:   Set after successful invocation of bus type's .offline().
> @@ -569,6 +640,8 @@ struct device {
>
>         enum device_removable   removable;
>
> +       struct device_location  location;
> +
>         bool                    offline_disabled:1;
>         bool                    offline:1;
>         bool                    of_node_reused:1;
> --
> 2.35.1.574.g5d30c73bfb-goog
>

Hi,

I will send a new patch v2 to correct directory names in Documentation
and also clarify some naming in core.c.

Won
