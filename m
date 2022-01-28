Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9843E49F8DE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbiA1MGB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jan 2022 07:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242285AbiA1MF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:05:59 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FCBC061714;
        Fri, 28 Jan 2022 04:05:58 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id k31so17841539ybj.4;
        Fri, 28 Jan 2022 04:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TgzhZFyMml3IDw50VoDt1Rff9sLTG9oPwM7aa7E2VdM=;
        b=d8MNPAuSJrlLFsBdLFMEfJBVNhbsNPQsWZsWw8Nh/bjN7YLUfdUL6KB2aH4F3BJ2NJ
         pasVN/7ILW3MtY0uI30puKHv1boKuU6cpEs+nhnY5CVfd74OyGzXK8PIwUmzYpSyv1Ub
         lW/pys8x8NJ+PvUogS4gfnXsuiw9eJZRR6WXV4hO1ZCXqLwHQIYiP8LAJdLTGrYjqfNw
         rpG1iLBEVJRC0U2MBaapo1LzW6L/U7oUQMCL5TorZFv8TsNtwxKAs+lxcvXAbDs5OJ4i
         wMSFqsY+CNUmh/yjcEy2fpn92q7jQmRQt7K917HrxwGbG3TcVWFYP/6EWxVc/RK1h+qF
         K1pQ==
X-Gm-Message-State: AOAM530AuFNyOFUmtHYad07CH8u1+IHnIwMUt21GtbEoeXzsJsFnDB9h
        SnAUJCNgWRVD7k0QT9V/Kwc9oH0juFESlh4hsQY=
X-Google-Smtp-Source: ABdhPJwBUV2JEFV0H3z3HF5iItbdYe5yrGWaSwdRlwzLDUwZnv24vR5E7QH2wzrY+VtqO3qg7ZIwOEaJAeeuDEIh/2U=
X-Received: by 2002:a25:180a:: with SMTP id 10mr13500919yby.552.1643371497956;
 Fri, 28 Jan 2022 04:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20220127234450.2218419-1-wonchung@google.com>
In-Reply-To: <20220127234450.2218419-1-wonchung@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Jan 2022 13:04:45 +0100
Message-ID: <CAJZ5v0hNd6Xjx+RNOTfzXDeXDhgvdfsesNZsgQ2eTCDh42aNmA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: device_sysfs: Add sysfs support for _PLD
To:     Won Chung <wonchung@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
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

On Fri, Jan 28, 2022 at 12:45 AM Won Chung <wonchung@google.com> wrote:
>
> When ACPI table includes _PLD fields for a device, create a new file
> (pld) in sysfs to share _PLD fields.
>
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-acpi | 53 ++++++++++++++++++++++++
>  drivers/acpi/device_sysfs.c              | 42 +++++++++++++++++++
>  2 files changed, 95 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
> index 58abacf59b2a..7f4544c9d563 100644
> --- a/Documentation/ABI/testing/sysfs-bus-acpi
> +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> @@ -96,3 +96,56 @@ Description:
>                 hardware, if the _HRV control method is present.  It is mostly
>                 useful for non-PCI devices because lspci can list the hardware
>                 version for PCI devices.
> +
> +What:          /sys/bus/acpi/devices/.../pld
> +Date:          Jan, 2022
> +Contact:       Rafael J. Wysocki <rjw@rjwysocki.net>

Why do you think that it is appropriate to add contact information of
someone to ABI documentation without asking them for their opinion?

If you don't want to be the contact yourself, you can put linux-acpi in there.

> +Description:
> +               This attribute contains the output of the device object's
> +               _PLD control method, if present. This information provides
> +               details on physical location of a port.
> +
> +               Description on each _PLD field from ACPI specification:
> +
> +               =============== ============================================
> +               GROUP_TOKEN     Unique numerical value identifying a group.
> +               GROUP_POSITION  Identifies this device connection point’s
> +                               position in the group.
> +               USER_VISIBLE    Set if the device connection point can be
> +                               seen by the user without disassembly.
> +               DOCK            Set if the device connection point resides
> +                               in a docking station or port replicator.
> +               BAY             Set if describing a device in a bay or if
> +                               device connection point is a bay.
> +               LID             Set if this device connection point resides
> +                               on the lid of laptop system.
> +               PANEL           Describes which panel surface of the system’s
> +                               housing the device connection point resides on:
> +                               0 - Top
> +                               1 - Bottom
> +                               2 - Left
> +                               3 - Right
> +                               4 - Front
> +                               5 - Back
> +                               6 - Unknown (Vertical Position and Horizontal
> +                               Position will be ignored)
> +               HORIZONTAL_     0 - Left
> +               POSITION        1 - Center
> +                               2 - Right
> +               VERTICAL_       0 - Upper
> +               POSITION        1 - Center
> +                               2 - Lower
> +               SHAPE           Describes the shape of the device connection
> +                               point.
> +                               0 - Round
> +                               1 - Oval
> +                               2 - Square
> +                               3 - Vertical Rectangle
> +                               4 - Horizontal Rectangle
> +                               5 - Vertical Trapezoid
> +                               6 - Horizontal Trapezoid
> +                               7 - Unknown - Shape rendered as a Rectangle
> +                               with dotted lines
> +                               8 - Chamfered
> +                               15:9 - Reserved
> +               =============== ===============================================
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index d5d6403ba07b..8d4df5fb1c45 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -509,6 +509,40 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(status);
>
> +static ssize_t pld_show(struct device *dev, struct device_attribute *attr,
> +                       char *buf)
> +{
> +       struct acpi_device *acpi_dev = to_acpi_device(dev);
> +       acpi_status status;
> +       struct acpi_pld_info *pld;
> +
> +       status = acpi_get_physical_device_location(acpi_dev->handle, &pld);
> +       if (ACPI_FAILURE(status))
> +               return -ENODEV;
> +
> +       return sprintf(buf, "GROUP_TOKEN=%u\n"
> +               "GROUP_POSITION=%u\n"
> +               "USER_VISIBLE=%u\n"
> +               "DOCK=%u\n"
> +               "BAY=%u\n"
> +               "LID=%u\n"
> +               "PANEL=%u\n"
> +               "HORIZONTAL_POSITION=%u\n"
> +               "VERTICAL_POSITION=%u\n"
> +               "SHAPE=%u\n",
> +               pld->group_token,
> +               pld->group_position,
> +               pld->user_visible,
> +               pld->dock,
> +               pld->bay,
> +               pld->lid,
> +               pld->panel,
> +               pld->horizontal_position,
> +               pld->vertical_position,
> +               pld->shape);
> +}
> +static DEVICE_ATTR_RO(pld);
> +
>  /**
>   * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
>   * @dev: ACPI device object.
> @@ -595,6 +629,12 @@ int acpi_device_setup_files(struct acpi_device *dev)
>                                                     &dev_attr_real_power_state);
>         }
>
> +       if (acpi_has_method(dev->handle, "_PLD")) {
> +               result = device_create_file(&dev->dev, &dev_attr_pld);
> +               if (result)
> +                       goto end;
> +       }
> +
>         acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
>
>  end:
> @@ -645,4 +685,6 @@ void acpi_device_remove_files(struct acpi_device *dev)
>                 device_remove_file(&dev->dev, &dev_attr_status);
>         if (dev->handle)
>                 device_remove_file(&dev->dev, &dev_attr_path);
> +       if (acpi_has_method(dev->handle, "_PLD"))
> +               device_remove_file(&dev->dev, &dev_attr_pld);
>  }
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>
