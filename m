Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3C6478C25
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhLQNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:24:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:36394 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232592AbhLQNYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:24:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="220433342"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="220433342"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 05:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="662843748"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2021 05:24:08 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] acpi: Store _PLD information and convert users
Date:   Fri, 17 Dec 2021 16:24:11 +0300
Message-Id: <20211217132415.39726-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

Rafael, is it still OK if Greg takes these?

Prashant, can you test these?

thanks,

Heikki Krogerus (4):
  acpi: Store the known device locations
  usb: Link the ports to the connectors they are attached to
  usb: typec: port-mapper: Convert to the component framework
  usb: Remove usb_for_each_port()

 Documentation/ABI/testing/sysfs-bus-usb |   9 +
 drivers/acpi/scan.c                     |  77 +++++++
 drivers/usb/core/port.c                 |  32 +++
 drivers/usb/core/usb.c                  |  46 ----
 drivers/usb/typec/Makefile              |   3 +-
 drivers/usb/typec/class.c               |   2 -
 drivers/usb/typec/class.h               |  10 +-
 drivers/usb/typec/port-mapper.c         | 280 +++---------------------
 include/acpi/acpi_bus.h                 |  19 ++
 include/linux/usb.h                     |   9 -
 include/linux/usb/typec.h               |  12 -
 11 files changed, 180 insertions(+), 319 deletions(-)

-- 
2.34.1

