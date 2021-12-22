Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4AC47D57F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344098AbhLVQzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:55:45 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]:33511 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344065AbhLVQzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:55:43 -0500
Received: by mail-qv1-f49.google.com with SMTP id kk22so2910039qvb.0;
        Wed, 22 Dec 2021 08:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIb3KCoZoalgYMtgmFngJ24Q0HvmYtjyPu5slr0rQdQ=;
        b=DLXkkMEszE1oHbruA0G7zDYTRjfuuidZ95XvuWhb0ILGj9Dv3vagFhggMr2cTZxagS
         lqgprkLYEJuJDzPWQ4EDgPfCWkSzyikwjIV5UxtR4QoJWnqyXZjUTn4Y4XdZ0wKENVBI
         mia6FUpW9gjLF1t/QgYSGoI1Dhv+/5Ui+8qREF4GR5DOdDaEzEKuGSI4a5Wnttww4sqv
         KXaGJjzLub8TRi52l79dOw+kWZ1zMYTTRwafBxQEeuy7j2Qva45waEbk/S0/p2WmJKja
         VIAL5FeBDB7SZJ13mGz9vrbTVGc2HXv7aFSQqKt4fcSU5ZTaIdjR6VlhPbMaPfdbNzN4
         jaaQ==
X-Gm-Message-State: AOAM532fQpSKWhjkln7tEhHxsMleLa4OlmdXn9GATSra+GF+RgK/P920
        iSmTfRfdU8Gury522ZQLgJKNH+mmYtYGT8jGhcI=
X-Google-Smtp-Source: ABdhPJymkX1fhwwH/6Txl9mzAlT7e0it1er0umoDlgwA2LuTswxYFbPjBNHrPwaxC0z+TuDOwadxxbZp2j33dAamR8Q=
X-Received: by 2002:a05:6214:2345:: with SMTP id hu5mr3191985qvb.130.1640192142943;
 Wed, 22 Dec 2021 08:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20211222143258.82305-1-heikki.krogerus@linux.intel.com> <20211222143258.82305-3-heikki.krogerus@linux.intel.com>
In-Reply-To: <20211222143258.82305-3-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Dec 2021 17:55:32 +0100
Message-ID: <CAJZ5v0iJhM2p+GDR+Ta0QZLdsvar=ybef8DnEHV1=-E-swdL0g@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] acpi: Store CRC-32 hash of the _PLD in struct acpi_device
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 3:33 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Storing CRC-32 hash of the Physical Location of Device
> object (_PLD) with devices that have it. The hash is stored
> to a new struct acpi_device member "pld_crc".
>
> The hash makes it easier to find devices that share a
> location, as there is no need to evaluate the entire object
> every time. Knowledge about devices that share a location
> can be used in device drivers that need to know the
> connections to other components inside a system. USB3 ports
> will for example always share their location with a USB2
> port.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/acpi/scan.c     | 16 ++++++++++++++++
>  include/acpi/acpi_bus.h | 14 +++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 7ff55a197a583..113414c46b713 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -19,6 +19,7 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pgtable.h>
> +#include <linux/crc32.h>
>
>  #include "internal.h"
>
> @@ -667,6 +668,19 @@ static int acpi_tie_acpi_dev(struct acpi_device *adev)
>         return 0;
>  }
>
> +static void acpi_store_pld_crc(struct acpi_device *adev)
> +{
> +       struct acpi_pld_info *pld;
> +       acpi_status status;
> +
> +       status = acpi_get_physical_device_location(adev->handle, &pld);
> +       if (ACPI_FAILURE(status))
> +               return;
> +
> +       adev->pld_crc = crc32(~0, pld, sizeof(*pld));
> +       ACPI_FREE(pld);
> +}
> +
>  static int __acpi_device_add(struct acpi_device *device,
>                              void (*release)(struct device *))
>  {
> @@ -725,6 +739,8 @@ static int __acpi_device_add(struct acpi_device *device,
>         if (device->wakeup.flags.valid)
>                 list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
>
> +       acpi_store_pld_crc(device);
> +
>         mutex_unlock(&acpi_device_lock);
>
>         if (device->parent)
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 8e87ead2af341..1977db19458ed 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -356,10 +356,23 @@ struct acpi_device_data {
>         struct list_head subnodes;
>  };
>
> +/*
> + * struct acpi_device_location - Device location based on _PLD
> + * @devices: List of devices that share this location
> + * @node: Entry in the internal list of locations
> + * @pld_crc: CRC-32 hash of the _PLD
> + */
> +struct acpi_device_location {
> +       struct list_head devices;
> +       struct list_head node;
> +       u32 pld_crc;
> +};

Does this get used anywhere or is it a leftover from the previous version?

> +
>  struct acpi_gpio_mapping;
>
>  /* Device */
>  struct acpi_device {
> +       u32 pld_crc;
>         int device_type;
>         acpi_handle handle;             /* no handle for fixed hardware */
>         struct fwnode_handle fwnode;
> @@ -739,7 +752,6 @@ static inline void acpi_bus_put_acpi_device(struct acpi_device *adev)
>
>  static inline int register_acpi_bus_type(void *bus) { return 0; }
>  static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> -
>  #endif                         /* CONFIG_ACPI */
>
>  #endif /*__ACPI_BUS_H__*/
> --
> 2.34.1
>
