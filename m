Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3817147D3BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245735AbhLVOdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:33:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:11411 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241363AbhLVOc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640183579; x=1671719579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h8k9ye2hTJ6yHM8BoJpMdH5OdZfBijgONexo4CQafGs=;
  b=VONjftBEg0QpbOH2C75muv+nap3D5C7NKtY4usc7HLyLYoHRRLRi4ZZU
   xUcKgzwdUi5v4QL5MrzHwPcjy4ogTPPZqPUfs5rIX7gaCDa1lgsUSPF1Q
   Bc2PtNZuShTICc2tCfzysb/hmIF/e0d5Xi5S0NMGpGnqLO3BLJ0SoRMhl
   C3xPIN7gBXVPtjp9NMIs4PW6TSt+7hg80DhrHPiN4cgfVREuFcBrbADH/
   nbfQEN+mah3G4pwZ1x0M+QC15xQVRaaxkOigg5b9VQeShs0ohqnMFnNHy
   RdgLNnPmIEMzxFIyl+y5jYENnXgwrUmhCepiYQ2X+Ln+1kkLwVd5fSiQA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240580552"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240580552"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 06:32:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="664285132"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2021 06:32:55 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] acpi: Store CRC-32 hash of the _PLD in struct acpi_device
Date:   Wed, 22 Dec 2021 17:32:55 +0300
Message-Id: <20211222143258.82305-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222143258.82305-1-heikki.krogerus@linux.intel.com>
References: <20211222143258.82305-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Storing CRC-32 hash of the Physical Location of Device
object (_PLD) with devices that have it. The hash is stored
to a new struct acpi_device member "pld_crc".

The hash makes it easier to find devices that share a
location, as there is no need to evaluate the entire object
every time. Knowledge about devices that share a location
can be used in device drivers that need to know the
connections to other components inside a system. USB3 ports
will for example always share their location with a USB2
port.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/scan.c     | 16 ++++++++++++++++
 include/acpi/acpi_bus.h | 14 +++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7ff55a197a583..113414c46b713 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -19,6 +19,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pgtable.h>
+#include <linux/crc32.h>
 
 #include "internal.h"
 
@@ -667,6 +668,19 @@ static int acpi_tie_acpi_dev(struct acpi_device *adev)
 	return 0;
 }
 
+static void acpi_store_pld_crc(struct acpi_device *adev)
+{
+	struct acpi_pld_info *pld;
+	acpi_status status;
+
+	status = acpi_get_physical_device_location(adev->handle, &pld);
+	if (ACPI_FAILURE(status))
+		return;
+
+	adev->pld_crc = crc32(~0, pld, sizeof(*pld));
+	ACPI_FREE(pld);
+}
+
 static int __acpi_device_add(struct acpi_device *device,
 			     void (*release)(struct device *))
 {
@@ -725,6 +739,8 @@ static int __acpi_device_add(struct acpi_device *device,
 	if (device->wakeup.flags.valid)
 		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
 
+	acpi_store_pld_crc(device);
+
 	mutex_unlock(&acpi_device_lock);
 
 	if (device->parent)
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 8e87ead2af341..1977db19458ed 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -356,10 +356,23 @@ struct acpi_device_data {
 	struct list_head subnodes;
 };
 
+/*
+ * struct acpi_device_location - Device location based on _PLD
+ * @devices: List of devices that share this location
+ * @node: Entry in the internal list of locations
+ * @pld_crc: CRC-32 hash of the _PLD
+ */
+struct acpi_device_location {
+	struct list_head devices;
+	struct list_head node;
+	u32 pld_crc;
+};
+
 struct acpi_gpio_mapping;
 
 /* Device */
 struct acpi_device {
+	u32 pld_crc;
 	int device_type;
 	acpi_handle handle;		/* no handle for fixed hardware */
 	struct fwnode_handle fwnode;
@@ -739,7 +752,6 @@ static inline void acpi_bus_put_acpi_device(struct acpi_device *adev)
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
 static inline int unregister_acpi_bus_type(void *bus) { return 0; }
-
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/
-- 
2.34.1

