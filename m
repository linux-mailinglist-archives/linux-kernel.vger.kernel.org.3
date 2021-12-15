Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2593A475811
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbhLOLoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:44:02 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36517 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLOLoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:44:00 -0500
Received: by mail-ot1-f42.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so24579529otl.3;
        Wed, 15 Dec 2021 03:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDFurzzW6+axA8XFUcMsrdWmTYDYkQifXI+dGxGlLEE=;
        b=s9Fw7LEzLnsrbUCrh7VZC0hMm0Vmj9P7rtqCWhuFI32CTbgHpnlhsWvvHcAs2VnbDM
         jasLq7BCY66lXwY02MwnlmWcf4v8TgHheMvgTucXcqszzuWAY+7sigeBUQ9l5xcp7dfF
         HtfoljXBHmripP3XjM0bbpvZAu/EALkBW+5aJycQvti+/CoQ+w/Pt8iMrG5UUHEHstqs
         q9ABAxDEhlCTsLWwi8/zr3J+LTJowZ8J/ArAYzF9vJhCHNg25voPML2p/5LkAoaxuuSY
         eP7niqcxIEXtMrVvf/6ci+6fLdmGD7SRa2wI9e1wog5wVLFVwQVS6082QhJew8sOvV8t
         R9lw==
X-Gm-Message-State: AOAM531xpxFHoIo0o3JIW8RpXxUoGrKwNzDvN3Wat/OQkC1mx0l62peL
        q/FcXXVu4e/z501Fb9MC1vmZPlACvCFVrqhH1MM=
X-Google-Smtp-Source: ABdhPJx7ky6VZuxPtC9Phu2oIefILexn2he7PbhjDmo+Nnq4QIJNku8qSMy0Bp5MKla3qm/LGJ6mtoTNItaq4mR3cm4=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr8183101otj.16.1639568640036;
 Wed, 15 Dec 2021 03:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20211213103243.33657-1-heikki.krogerus@linux.intel.com> <20211213103243.33657-2-heikki.krogerus@linux.intel.com>
In-Reply-To: <20211213103243.33657-2-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Dec 2021 12:43:48 +0100
Message-ID: <CAJZ5v0jq5ve9+V3k5Vi=vJAheSyQbAsNmi6An9=oKxkyVed5bw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] acpi: Store the Physical Location of Device (_PLD) information
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

On Mon, Dec 13, 2021 at 11:32 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> This will remove the need for the drivers to always evaluate
> the _PLD separately.

This seems to hinge on the assumption that _PLD must return the same
data every time it is evaluated, but that is not required by the
specification AFAICS.

If this really is the case, I would mention this assumption here
explicitly and maybe even in a comment next to the code.

> Because the _PLD may be shared between devices - for example
> the USB2 and USB3 ports that share the same connector have
> always the same _PLD - every unique _PLD that is detected is
> registered as a single entry and stored in a dedicated list.
> Then each of those entries will hold a list of devices that
> share the location - have identical _PLD.
>
> The location entry can be acquired with a new function
> acpi_device_get_location(). The location structure that the
> function returns contrains the _PLD of the device and the

"The location structure returned by this function contains the _PLD
return package for the device and the list of devices sharing it."

> list the other devices that share it.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/acpi/scan.c     | 79 +++++++++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h | 14 ++++++++
>  2 files changed, 93 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 5991dddbc9ceb..9946ca4451ebc 100644
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
> +static DEFINE_MUTEX(acpi_location_lock);
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
> @@ -654,6 +658,78 @@ static int acpi_tie_acpi_dev(struct acpi_device *adev)
>         return 0;
>  }
>
> +static void acpi_store_device_location(struct acpi_device *adev)
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
> +       list_for_each_entry(location, &acpi_location_list, node) {
> +               if (location->pld_crc == crc) {
> +                       ACPI_FREE(pld);
> +                       goto out_add_to_location;
> +               }
> +       }
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
> +       location->pld = pld;
> +       location->pld_crc = crc;
> +
> +out_add_to_location:
> +       list_add_tail(&adev->location_list, &location->devices);
> +
> +err_unlock:
> +       mutex_unlock(&acpi_location_lock);
> +}
> +
> +/**
> + * acpi_device_get_location - Get the device location
> + * @adev: ACPI device handle
> + *
> + * Returns the location of @adev when it's known.

I would write it this way:

"Return a pointer to a struct acpi_device_location object containing
the location information obtained by evaluating _PLD (Physical
Location of Device) for @adev when it is available, along with the
list of devices sharing the same location information (if any), or
NULL otherwise"

The location is known for all
> + * ACPI devices that have _PLD (Physical Location of Device). When the location
> + * is not known, the function returns NULL.
> + */
> +struct acpi_device_location *acpi_device_get_location(struct acpi_device *adev)
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
> @@ -670,6 +746,7 @@ static int __acpi_device_add(struct acpi_device *device,
>         INIT_LIST_HEAD(&device->wakeup_list);
>         INIT_LIST_HEAD(&device->physical_node_list);
>         INIT_LIST_HEAD(&device->del_list);
> +       INIT_LIST_HEAD(&device->location_list);
>         mutex_init(&device->physical_node_lock);
>
>         mutex_lock(&acpi_device_lock);
> @@ -712,6 +789,8 @@ static int __acpi_device_add(struct acpi_device *device,
>         if (device->wakeup.flags.valid)
>                 list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
>
> +       acpi_store_device_location(device);
> +
>         mutex_unlock(&acpi_device_lock);
>
>         if (device->parent)
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index d6fe27b695c3d..1a4af747198a4 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -354,6 +354,13 @@ struct acpi_device_data {
>         struct list_head subnodes;
>  };
>

This needs to be documented.

> +struct acpi_device_location {
> +       u32 pld_crc;
> +       struct acpi_pld_info *pld;
> +       struct list_head node;
> +       struct list_head devices;
> +};
> +
>  struct acpi_gpio_mapping;
>
>  /* Device */
> @@ -366,6 +373,7 @@ struct acpi_device {
>         struct list_head node;
>         struct list_head wakeup_list;
>         struct list_head del_list;
> +       struct list_head location_list;
>         struct acpi_device_status status;
>         struct acpi_device_flags flags;
>         struct acpi_device_pnp pnp;
> @@ -731,11 +739,17 @@ static inline void acpi_bus_put_acpi_device(struct acpi_device *adev)
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

One overall problem I see here is that it potentially stores a bunch
of _PLD buffers that will never be used, which is a waste of memory.

It may be better to make acpi_device_get_location() evaluate _PLD for
the target device if it cannot be found in the list and either update
one of the existing entries if the crc matches and return the pld data
from there, or add a new item to the list and return its pld data.
