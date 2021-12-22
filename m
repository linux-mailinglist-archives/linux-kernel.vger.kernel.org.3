Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09E647D3B4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbhLVOc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:32:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:11411 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237079AbhLVOc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640183578; x=1671719578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mc3eEF32twp+4v2iMG+L9rWfvVCKFKKo2Cyu5ED3ixA=;
  b=Kj4b7dR94dr9PzWvxIYU5cfGmXnnKIdxJIe30Dl/8N3qI1Hz97S9LpNP
   JZfhdaLbK1B4vjf9wGkCReOSNFoQ5JHRyKxrB05b9OJzmeFwYUpVpiysc
   9R1wQUCuH2o6jojUZSBdG3DmUq4CfL0Ks1kf4p66kHuzTToRK5X8vqMbA
   JX7ZnYaWynwG/UNyA0C4OUf88o8xOJQJZiZv0X4UEgT4wAmJ1sc5XJiFM
   WruIgKLPrlqvnpvLR5Dy/3t9U/6bCqT1rIzCng6hjS5JWeb5Pk8x2mnLW
   WfBc1D0j4DHbzDNDR8PbuiTcydJF9xb7aw6YIkJtFfJ088OYKWYo3c/v3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240580538"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240580538"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 06:32:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="664285109"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2021 06:32:49 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] acpi: Store _PLD information and convert users
Date:   Wed, 22 Dec 2021 17:32:53 +0300
Message-Id: <20211222143258.82305-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
 include/acpi/acpi_bus.h                 |  14 +-
 include/linux/usb.h                     |   9 -
 include/linux/usb/typec.h               |  12 -
 12 files changed, 117 insertions(+), 316 deletions(-)

-- 
2.34.1

