Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2DD46E627
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhLIKJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:09:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:45972 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232080AbhLIKJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:09:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="238007233"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="238007233"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 02:06:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="658709770"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 09 Dec 2021 02:06:07 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 09 Dec 2021 12:06:06 +0200
Date:   Thu, 9 Dec 2021 12:06:06 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] acpi: Store _PLD information and convert users
Message-ID: <YbHVDikM6eodP/MR@kuha.fi.intel.com>
References: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
 <CACeCKaf3_sqGbqh22Qe+7xEcajCTZt=WziqtPuzgGxW=-TPXbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKaf3_sqGbqh22Qe+7xEcajCTZt=WziqtPuzgGxW=-TPXbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for testing these..

On Wed, Dec 08, 2021 at 07:45:26PM -0800, Prashant Malani wrote:
> Hi Heikki,
> 
> On Tue, Dec 7, 2021 at 6:37 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi,
> >
> > This removes the need for the drivers to always separately evaluate
> > the _PLD. With the USB Type-C connector and USB port mapping this
> > allows us to start using the component framework and remove the custom
> > APIs.
> >
> > So far the only users of the _PLD information have been the USB
> > drivers, but it seems it will be used also at least in some camera
> > drivers later. These nevertheless touch mostly USB drivers.
> >
> > Rafael, is it still OK if Greg takes these?
> >
> > Prashant, can you test these?
> 
> I've applied the patches to a system with the requisite _PLD entries
> in firmware, and I'm not sure I can see the connectors getting created
> correctly.
> 
> My setup is:
> 
> Chromebook ------> Dell WD19TB dock (in USB+DisplayPort Alternate
> Mode) ----> USB Thumb drive.
> 
> Here is the lsusb -t output before connecting the dock (omitting
> unrelated busses):
> localhost ~ # lsusb -t
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/3p, 10000M/x2
> 
> Here is the lsusb -t output (omitting unrelated busses):
> localhost ~ # lsusb -t
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/3p, 10000M/x2
>     |__ Port 2: Dev 15, If 0, Class=Hub, Driver=hub/4p, 10000M
>         |__ Port 3: Dev 16, If 0, Class=Hub, Driver=hub/4p, 5000M
>             |__ Port 3: Dev 18, If 0, Class=Mass Storage,
> Driver=usb-storage, 5000M
>         |__ Port 4: Dev 17, If 0, Class=Vendor Specific Class,
> Driver=r8152, 5000M
> 
> I see the connector symlink for the root hub:
> 
> localhost ~ # cd /sys/bus/usb/devices
> localhost /sys/bus/usb/devices # ls 2-2/port/connector
> data_role  device  firmware_node  port1-cable  port1-partner  power
> power_operation_mode  power_role  preferred_role  subsystem
> supported_accessory_modes  uevent  usb2-port2  usb3-port2
> usb_power_delivery_revision  usb_typec_revision  vconn_source
> 
> But for none of the children devices:
> 
> localhost /sys/bus/usb/devices # ls 2-2.3/port/connector
> ls: cannot access '2-2.3/port/connector': No such file or directory
> localhost /sys/bus/usb/devices # ls 2-2.3.3/port/connector
> ls: cannot access '2-2.3.3/port/connector': No such file or directory
> localhost /sys/bus/usb/devices # ls 2-2.3\:1.0/port/connector
> ls: cannot access '2-2.3:1.0/port/connector': No such file or directory
> localhost /sys/bus/usb/devices # ls 2-2.3.3\:1.0/port/connector
> ls: cannot access '2-2.3.3:1.0/port/connector': No such file or directory
> 
> Is this as you intended with the series? My interpretation was that
> each connected usb device would get a "connector" symlink, but I may
> have misinterpreted this.

It is as intended. The usb ports on the board will have the connector
symlink, not the devices attached to them - the firmware is only aware
of the connectors on the board of course. It looks like this series is
working as it should.

If you want to extend this solution so that also every device in the
usb topology will have the link to the connector on board, then that
should be now possible, but that is out side of the scope of this
series. You need to propose that separately.

But I must ask, why can't you just walk down the topology until you
reach the on-board ports that will have the connector links?


thanks,

-- 
heikki
