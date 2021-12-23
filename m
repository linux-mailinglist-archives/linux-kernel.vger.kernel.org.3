Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA1B47E035
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243195AbhLWIQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:16:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:28533 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239315AbhLWIQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640247374; x=1671783374;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=caOSOHFYfroqQvIFz1XFx/aHEFOYI6OG0vAjNDRw6/I=;
  b=B10z07FVvkX3u2wgO0eOlx+XWhc3tQYyqR0/j2JuaHC56qCTP84MdWQz
   Z8a6IselC5ZPRvGbtyct85h/cX6a0WCZeTVNgRsC03at1/aVq7yQQl2qC
   Ma6dueAZBmCUYpHvUjQExqE/w5KboexQK5XLnIWHNpUMPRdpaFRgTtU2e
   cMa/EaUEVt2alZ/cUI55K+IQPUqhcTTrNf6Cy2/lHx1RBefqXNhK+06o3
   5Zlfgb1YZ7O+ZLQuJJegEnI7x8dOkGYu4O0J1/GRK4ku+DLmHVBc8yYQ0
   m52vDGcIHotSbzDkjRbJc+lv/OXXRZj1MXqbydgHatnKyd1F1zIaqIoB3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="264990656"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="264990656"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 00:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="664515512"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 00:16:11 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] acpi: Store _PLD information and convert users
Date:   Thu, 23 Dec 2021 11:16:15 +0300
Message-Id: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The last version (v4) was not properly cleaned up. Should be now OK.


v4 cover letter:

Now only storing the crc hash to a new member in struct acpi_device,
just like proposed by Rafael. In port-mapper.c I'm then scanning the
acpi bus separately with every port in order to find the matching
devices.


v3 cover letter:

The _PLD buffer is no longer stored as requested by Rafael, so the
drivers will need to continue to evaluate the _PLD if they need it.

The stored locations will therefore only contain the list of other
devices that share the location, but that is most important, and in
practice the main goal of the series in any case.


v2 cover letter:

I'm now using the helpers device_match_acpi_dev() and
device_match_fwnode() like Andy suggested. No other changes.


The original cover letter:

This removes the need for the drivers to always separately evaluate
the _PLD. With the USB Type-C connector and USB port mapping this
allows us to start using the component framework and remove the custom
APIs.

So far the only users of the _PLD information have been the USB
drivers, but it seems it will be used also at least in some camera
drivers later. These nevertheless touch mostly USB drivers.

thanks,

Heikki Krogerus (5):
  acpi: Export acpi_bus_type
  acpi: Store CRC-32 hash of the _PLD in struct acpi_device
  usb: Link the ports to the connectors they are attached to
  usb: typec: port-mapper: Convert to the component framework
  usb: Remove usb_for_each_port()

 Documentation/ABI/testing/sysfs-bus-usb |   9 +
 drivers/acpi/bus.c                      |   1 +
 drivers/acpi/scan.c                     |  16 ++
 drivers/usb/core/port.c                 |  32 +++
 drivers/usb/core/usb.c                  |  46 ----
 drivers/usb/typec/Makefile              |   3 +-
 drivers/usb/typec/class.c               |   2 -
 drivers/usb/typec/class.h               |  10 +-
 drivers/usb/typec/port-mapper.c         | 279 ++++--------------------
 include/acpi/acpi_bus.h                 |   1 +
 include/linux/usb.h                     |   9 -
 include/linux/usb/typec.h               |  12 -
 12 files changed, 105 insertions(+), 315 deletions(-)

-- 
2.34.1

