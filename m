Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFD4478D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbhLQOMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:12:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:40646 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhLQOMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:12:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="303135892"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="303135892"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 06:12:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="683401263"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 06:12:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1myDxQ-007Rmr-5V;
        Fri, 17 Dec 2021 16:11:36 +0200
Date:   Fri, 17 Dec 2021 16:11:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] acpi: Store _PLD information and convert users
Message-ID: <Ybyal+QmjEQWI+hh@smile.fi.intel.com>
References: <20211217132415.39726-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217132415.39726-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 04:24:11PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> The _PLD buffer is no longer stored as requested by Rafael, so the
> drivers will need to continue to evaluate the _PLD if they need it.
> 
> The stored locations will therefore only contain the list of other
> devices that share the location, but that is most important, and in
> practice the main goal of the series in any case.
> 
> 
> v2 cover letter:
> 
> I'm now using the helpers device_match_acpi_dev() and
> device_match_fwnode() like Andy suggested. No other changes.
> 
> 
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

I guess I have given tag, anyway here we are, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S. AFAICS only the first patch was slightly changed.


> Heikki Krogerus (4):
>   acpi: Store the known device locations
>   usb: Link the ports to the connectors they are attached to
>   usb: typec: port-mapper: Convert to the component framework
>   usb: Remove usb_for_each_port()
> 
>  Documentation/ABI/testing/sysfs-bus-usb |   9 +
>  drivers/acpi/scan.c                     |  77 +++++++
>  drivers/usb/core/port.c                 |  32 +++
>  drivers/usb/core/usb.c                  |  46 ----
>  drivers/usb/typec/Makefile              |   3 +-
>  drivers/usb/typec/class.c               |   2 -
>  drivers/usb/typec/class.h               |  10 +-
>  drivers/usb/typec/port-mapper.c         | 280 +++---------------------
>  include/acpi/acpi_bus.h                 |  19 ++
>  include/linux/usb.h                     |   9 -
>  include/linux/usb/typec.h               |  12 -
>  11 files changed, 180 insertions(+), 319 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


