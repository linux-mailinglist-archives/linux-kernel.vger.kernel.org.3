Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E430746BDE2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhLGOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:41:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:48397 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237989AbhLGOlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:41:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237528417"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237528417"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 06:37:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="657725063"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2021 06:37:51 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] acpi: Store _PLD information and convert users
Date:   Tue,  7 Dec 2021 17:37:52 +0300
Message-Id: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

Heikki Krogerus (5):
  acpi: Store the Physical Location of Device (_PLD) information
  usb: Use the cached ACPI _PLD entry
  usb: Link the ports to the connectors they are attached to
  usb: typec: port-mapper: Convert to the component framework
  usb: Remove usb_for_each_port()

 Documentation/ABI/testing/sysfs-bus-usb |   9 +
 drivers/acpi/scan.c                     |  79 +++++++
 drivers/usb/core/port.c                 |  32 +++
 drivers/usb/core/usb-acpi.c             |  17 +-
 drivers/usb/core/usb.c                  |  46 ----
 drivers/usb/typec/Makefile              |   3 +-
 drivers/usb/typec/class.c               |   2 -
 drivers/usb/typec/class.h               |  10 +-
 drivers/usb/typec/port-mapper.c         | 280 +++---------------------
 include/acpi/acpi_bus.h                 |  14 ++
 include/linux/usb.h                     |   9 -
 include/linux/usb/typec.h               |  12 -
 12 files changed, 184 insertions(+), 329 deletions(-)

-- 
2.33.0

