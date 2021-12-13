Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF667472C03
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbhLMMLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:11:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:25736 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhLMMLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:11:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="262844164"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="262844164"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 04:11:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="681613560"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 04:11:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwk9f-005bkK-P9;
        Mon, 13 Dec 2021 14:10:07 +0200
Date:   Mon, 13 Dec 2021 14:10:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] acpi: Store _PLD information and convert users
Message-ID: <Ybc4H2/eOSyAavjM@smile.fi.intel.com>
References: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 01:32:38PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> I'm now using the helpers device_match_acpi_dev() and
> device_match_fwnode() like Andy suggested. No other changes.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> The original cover letter:
> 
> This removes the need for the drivers to always separately evaluate
> the _PLD. With the USB Type-C connector and USB port mapping this
> allows us to start using the component framework and remove the custom
> APIs.
> 
> So far the only users of the _PLD information have been the USB
> drivers, but it seems it will be used also at least in some camera
> drivers later. These nevertheless touch mostly USB drivers.
> 
> Rafael, is it still OK if Greg takes these?
> 
> Prashant, can you test these?
> 
> thanks,
> 
> 
> Heikki Krogerus (5):
>   acpi: Store the Physical Location of Device (_PLD) information
>   usb: Use the cached ACPI _PLD entry
>   usb: Link the ports to the connectors they are attached to
>   usb: typec: port-mapper: Convert to the component framework
>   usb: Remove usb_for_each_port()
> 
>  Documentation/ABI/testing/sysfs-bus-usb |   9 +
>  drivers/acpi/scan.c                     |  79 +++++++
>  drivers/usb/core/port.c                 |  32 +++
>  drivers/usb/core/usb-acpi.c             |  17 +-
>  drivers/usb/core/usb.c                  |  46 ----
>  drivers/usb/typec/Makefile              |   3 +-
>  drivers/usb/typec/class.c               |   2 -
>  drivers/usb/typec/class.h               |  10 +-
>  drivers/usb/typec/port-mapper.c         | 280 +++---------------------
>  include/acpi/acpi_bus.h                 |  14 ++
>  include/linux/usb.h                     |   9 -
>  include/linux/usb/typec.h               |  12 -
>  12 files changed, 184 insertions(+), 329 deletions(-)
> 
> -- 
> 2.33.0
> 

-- 
With Best Regards,
Andy Shevchenko


