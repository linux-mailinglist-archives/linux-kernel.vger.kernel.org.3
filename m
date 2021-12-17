Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3441479248
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbhLQRCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:02:01 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46940 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbhLQRCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:02:00 -0500
Received: by mail-ot1-f44.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so3599400oto.13;
        Fri, 17 Dec 2021 09:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8g5Lsj8WxuGD8LrSO5qJLGi0ggNwHZB9aqoikJwvsGM=;
        b=KO4uFyORxaMYbXteyVLfmhZ4Js/XvFIlD/sJAjaZVfmqbFTEn1sV6eqMP6Sz/jgNQC
         GEh8HZ8fzGbye8rGsDyHy2FL1XYNsDLB0D1oluzYS7yKrcD6Yx9rl+3e6E25FkH8AOOx
         3cXLceYbbnP9vXrAsJxhUBiMBJn7POe5Paj436Qj4EesMLYdr9njtk0sbtnnRUGkbBcx
         l4/BY0jn6jFiqlCnZPRNc1TB1IzAfj0SWdI9imI8nooFRyPdJtnMzdHRRAoL9BG0ltGV
         tKstzGUMyVdxTYgMGb2UYYsYmY+AC7+bGO66BO3/J5GwCRd79bhebAgI7Q4d209rsNSe
         Fs8Q==
X-Gm-Message-State: AOAM5332aVUNydJRdTMGinSYmVmTgAYgaCf7fP1Tdq0igmAL6zEW3wJ0
        cuRnkT/qtpaRRkWykl4SpZao4bnXJhybJsIvpuM=
X-Google-Smtp-Source: ABdhPJwYEwhOV1FAjDGBz5u0mu36ruUQNLhy02Bhf107/bjVVJgot/56+62cFieV+LFNasSTESlUDOc+3LqFR5rbG4I=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr2890397otu.254.1639760519595;
 Fri, 17 Dec 2021 09:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20211217132415.39726-1-heikki.krogerus@linux.intel.com> <20211217132415.39726-2-heikki.krogerus@linux.intel.com>
In-Reply-To: <20211217132415.39726-2-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 18:01:48 +0100
Message-ID: <CAJZ5v0g9HjLr8n3OQwMY0EK5GdCc+8CJnO3mEUXom3g2sz9jXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] acpi: Store the known device locations
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

On Fri, Dec 17, 2021 at 2:24 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> This adds a list that will hold all the detected device
> locations. The location of a device is known if it has
> Physical Location of Device (_PLD) object within its scope.

This paragraph isn't really accurate any more, because the location
information is not stored in that list.

To be precise, the new list is a list of entries that each contain a
list of devices sharing the same physical location information (and
thus presumably being physically located in the same place or
physically overlapping so to speak).

Honestly, I would change the terminology and naming  to reflect that
concept (see below).

> Each entry in the list represents a known location, and each
> of those locations can then have a list of devices that are
> currently assigned to those locations.
>
> The location entry that contains the current location of a
> device can be acquired with a new function
> acpi_device_get_location(). The location structure returned
> by this function contains the list of devices sharing it.
>
> The knowledge of the other devices that share a location
> can be used in device drivers that need to know the
> connections to other components inside a system. USB3 ports
> will for example always share their location with a USB2
> port.
>
> For now, the device locations can not be updated, so they
> will only contain lists the devices that are initially in
> those locations. But that can later be easily changed if
> needed by adding API that can be used to update the
> locations.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/acpi/scan.c     | 77 +++++++++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h | 19 ++++++++++
>  2 files changed, 96 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 5991dddbc9ceb..f147c0ad5f944 100644
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
> @@ -42,6 +43,8 @@ static LIST_HEAD(acpi_scan_handlers_list);
>  DEFINE_MUTEX(acpi_device_lock);
>  LIST_HEAD(acpi_wakeup_device_list);
>  static DEFINE_MUTEX(acpi_hp_context_lock);
> +static LIST_HEAD(acpi_location_list);

I would call this "acpi_location_sharing_list".

> +static DEFINE_MUTEX(acpi_location_lock);

And this "acpi_location_sharing_lock".

>
>  /*
>   * The UART device described by the SPCR table is the only object which needs
> @@ -485,6 +488,7 @@ static void acpi_device_del(struct acpi_device *device)
>                         break;
>                 }
>
> +       list_del(&device->location_list);
>         list_del(&device->wakeup_list);
>         mutex_unlock(&acpi_device_lock);
>
> @@ -654,6 +658,76 @@ static int acpi_tie_acpi_dev(struct acpi_device *adev)
>         return 0;
>  }
>
> +static void acpi_store_device_location(struct acpi_device *adev)

This can be called "acpi_dev_save_location_sharing_info()".

> +{
> +       struct acpi_device_location *location;
> +       struct acpi_pld_info *pld;
> +       acpi_status status;
> +       u32 crc;
> +
> +       status = acpi_get_physical_device_location(adev->handle, &pld);
> +       if (ACPI_FAILURE(status))
> +               return;
> +
> +       crc = crc32(~0, pld, sizeof(*pld));
> +
> +       mutex_lock(&acpi_location_lock);
> +
> +       list_for_each_entry(location, &acpi_location_list, node)
> +               if (location->pld_crc == crc)
> +                       goto out_add_to_location;
> +
> +       /* The location does not exist yet so creating it. */
> +
> +       location = kzalloc(sizeof(*location), GFP_KERNEL);
> +       if (!location) {
> +               acpi_handle_err(adev->handle, "Unable to store location\n");
> +               goto err_unlock;
> +       }
> +
> +       list_add_tail(&location->node, &acpi_location_list);
> +       INIT_LIST_HEAD(&location->devices);
> +       location->pld_crc = crc;
> +
> +out_add_to_location:
> +       list_add_tail(&adev->location_list, &location->devices);
> +
> +err_unlock:
> +       ACPI_FREE(pld);
> +       mutex_unlock(&acpi_location_lock);
> +}
> +
> +/**
> + * acpi_device_get_location - Get the device location
> + * @adev: ACPI device handle
> + *
> + * Return a pointer to a struct acpi_device_location object containing the
> + * location information obtained by evaluating _PLD (Physical Location of
> + * Device) for @adev when it is available, along with the list of devices
> + * sharing the same location information (if any), or NULL otherwise.
> + */
> +struct acpi_device_location *acpi_device_get_location(struct acpi_device *adev)

And this "acpi_dev_get_location_sharing_info()".

> +{
> +       struct acpi_device_location *location;
> +       struct list_head *tmp;
> +
> +       mutex_lock(&acpi_location_lock);
> +
> +       list_for_each_entry(location, &acpi_location_list, node) {
> +               list_for_each(tmp, &location->devices) {
> +                       if (tmp == &adev->location_list)
> +                               goto out_unlock;
> +               }
> +       }
> +       location = NULL;
> +
> +out_unlock:
> +       mutex_unlock(&acpi_location_lock);
> +
> +       return location;
> +}
> +EXPORT_SYMBOL_GPL(acpi_device_get_location);
> +
>  static int __acpi_device_add(struct acpi_device *device,
>                              void (*release)(struct device *))
>  {
> @@ -670,6 +744,7 @@ static int __acpi_device_add(struct acpi_device *device,
>         INIT_LIST_HEAD(&device->wakeup_list);
>         INIT_LIST_HEAD(&device->physical_node_list);
>         INIT_LIST_HEAD(&device->del_list);
> +       INIT_LIST_HEAD(&device->location_list);
>         mutex_init(&device->physical_node_lock);
>
>         mutex_lock(&acpi_device_lock);
> @@ -712,6 +787,8 @@ static int __acpi_device_add(struct acpi_device *device,
>         if (device->wakeup.flags.valid)
>                 list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
>
> +       acpi_store_device_location(device);
> +
>         mutex_unlock(&acpi_device_lock);
>
>         if (device->parent)
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index d6fe27b695c3d..9123884e4e7ec 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -354,6 +354,18 @@ struct acpi_device_data {
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

"acpi_dev_location_sharing_info" ?

> +       struct list_head devices;
> +       struct list_head node;
> +       u32 pld_crc;
> +};
> +
>  struct acpi_gpio_mapping;
>
>  /* Device */
> @@ -366,6 +378,7 @@ struct acpi_device {
>         struct list_head node;
>         struct list_head wakeup_list;
>         struct list_head del_list;
> +       struct list_head location_list;

"location_sharing_list" ?

>         struct acpi_device_status status;
>         struct acpi_device_flags flags;
>         struct acpi_device_pnp pnp;
> @@ -731,11 +744,17 @@ static inline void acpi_bus_put_acpi_device(struct acpi_device *adev)
>  {
>         acpi_dev_put(adev);
>  }
> +
> +struct acpi_device_location *acpi_device_get_location(struct acpi_device *adev);
>  #else  /* CONFIG_ACPI */
>
>  static inline int register_acpi_bus_type(void *bus) { return 0; }
>  static inline int unregister_acpi_bus_type(void *bus) { return 0; }
>
> +static inline struct acpi_device_location *acpi_device_get_location(struct acpi_device *adev)
> +{
> +       return NULL;
> +}
>  #endif                         /* CONFIG_ACPI */
>
>  #endif /*__ACPI_BUS_H__*/
> --

And overall I'm wondering if this can be achieved by storing the
pld_crc directly in struct acpi_device and doing a
bus_for_each_dev(&acpi_bus_type, ...) walk every time a list of
devices sharing a _PLD is needed?

It looks like typec_link_ports() is the only user of this and it can
easily afford doing a walk like the above if I'm not mistaken.
