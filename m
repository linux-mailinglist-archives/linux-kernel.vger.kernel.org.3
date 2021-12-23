Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C7947E028
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbhLWIEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:04:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:27737 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242745AbhLWIEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640246683; x=1671782683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i+YD/pNRVPPsMYgsiZ0v66EnAsM8Wm2IxjTw8+56sVQ=;
  b=eiktmwc+Kbnp4sTdFUComIRiv+UzjUnVQ3HS9uNy7+jBkPmI61Tc/d3c
   yhSJ79drUIq5lLlfHy+lwpHfWUR9tU3z6h+wOXUw289aJmgGK4N78sIgR
   IfrccaSNvjVIq9NSwSQpAC53LpLXfkJgT/sXkRlaiCFJ13YtwO7LCat0x
   QoKgzEhplwGhmETbEgt239+F/W36AArLIpXdkggc1OhmsxZPCabVTe1NB
   7eWcYn/kKNQIl49sK/3iZCKed6AmD9UROSldllBf9J6BOIiWeFSd7YNHR
   INdRTpgXP7BI4yhqFGUeN+gDwIg+PU4UebvnzhapQ4E1Wh29SUSopvB5r
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="301544454"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="301544454"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 00:04:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="664513558"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 23 Dec 2021 00:04:38 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 23 Dec 2021 10:04:38 +0200
Date:   Thu, 23 Dec 2021 10:04:38 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] acpi: Store CRC-32 hash of the _PLD in struct
 acpi_device
Message-ID: <YcQtlg5QtrMa4xzz@kuha.fi.intel.com>
References: <20211222143258.82305-1-heikki.krogerus@linux.intel.com>
 <20211222143258.82305-3-heikki.krogerus@linux.intel.com>
 <CAJZ5v0iJhM2p+GDR+Ta0QZLdsvar=ybef8DnEHV1=-E-swdL0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iJhM2p+GDR+Ta0QZLdsvar=ybef8DnEHV1=-E-swdL0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 05:55:32PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 22, 2021 at 3:33 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Storing CRC-32 hash of the Physical Location of Device
> > object (_PLD) with devices that have it. The hash is stored
> > to a new struct acpi_device member "pld_crc".
> >
> > The hash makes it easier to find devices that share a
> > location, as there is no need to evaluate the entire object
> > every time. Knowledge about devices that share a location
> > can be used in device drivers that need to know the
> > connections to other components inside a system. USB3 ports
> > will for example always share their location with a USB2
> > port.
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/acpi/scan.c     | 16 ++++++++++++++++
> >  include/acpi/acpi_bus.h | 14 +++++++++++++-
> >  2 files changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 7ff55a197a583..113414c46b713 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/dma-map-ops.h>
> >  #include <linux/platform_data/x86/apple.h>
> >  #include <linux/pgtable.h>
> > +#include <linux/crc32.h>
> >
> >  #include "internal.h"
> >
> > @@ -667,6 +668,19 @@ static int acpi_tie_acpi_dev(struct acpi_device *adev)
> >         return 0;
> >  }
> >
> > +static void acpi_store_pld_crc(struct acpi_device *adev)
> > +{
> > +       struct acpi_pld_info *pld;
> > +       acpi_status status;
> > +
> > +       status = acpi_get_physical_device_location(adev->handle, &pld);
> > +       if (ACPI_FAILURE(status))
> > +               return;
> > +
> > +       adev->pld_crc = crc32(~0, pld, sizeof(*pld));
> > +       ACPI_FREE(pld);
> > +}
> > +
> >  static int __acpi_device_add(struct acpi_device *device,
> >                              void (*release)(struct device *))
> >  {
> > @@ -725,6 +739,8 @@ static int __acpi_device_add(struct acpi_device *device,
> >         if (device->wakeup.flags.valid)
> >                 list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
> >
> > +       acpi_store_pld_crc(device);
> > +
> >         mutex_unlock(&acpi_device_lock);
> >
> >         if (device->parent)
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 8e87ead2af341..1977db19458ed 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -356,10 +356,23 @@ struct acpi_device_data {
> >         struct list_head subnodes;
> >  };
> >
> > +/*
> > + * struct acpi_device_location - Device location based on _PLD
> > + * @devices: List of devices that share this location
> > + * @node: Entry in the internal list of locations
> > + * @pld_crc: CRC-32 hash of the _PLD
> > + */
> > +struct acpi_device_location {
> > +       struct list_head devices;
> > +       struct list_head node;
> > +       u32 pld_crc;
> > +};
> 
> Does this get used anywhere or is it a leftover from the previous version?

No. I'm sorry that was supposed to be removed. I'll resend.

thanks,

-- 
heikki
