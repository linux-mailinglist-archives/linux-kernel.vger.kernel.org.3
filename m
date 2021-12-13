Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFCA472A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhLMKeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:34:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:51591 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237508AbhLMKdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:33:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="238930003"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="238930003"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 02:32:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="660821525"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2021 02:32:36 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] acpi: Store _PLD information and convert users
Date:   Mon, 13 Dec 2021 13:32:38 +0300
Message-Id: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

