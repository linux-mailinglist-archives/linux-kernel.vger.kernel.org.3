Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591AB478C28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbhLQNYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:24:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:36394 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232592AbhLQNYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:24:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="220433346"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="220433346"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 05:24:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="662843753"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2021 05:24:10 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] acpi: Store the known device locations
Date:   Fri, 17 Dec 2021 16:24:12 +0300
Message-Id: <20211217132415.39726-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217132415.39726-1-heikki.krogerus@linux.intel.com>
References: <20211217132415.39726-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a list that will hold all the detected device
locations. The location of a device is known if it has
Physical Location of Device (_PLD) object within its scope.

Each entry in the list represents a known location, and each
of those locations can then have a list of devices that are
currently assigned to those locations.

The location entry that contains the current location of a
device can be acquired with a new function
acpi_device_get_location(). The location structure returned
by this function contains the list of devices sharing it.

The knowledge of the other devices that share a location
can be used in device drivers that need to know the
connections to other components inside a system. USB3 ports
will for example always share their location with a USB2
port.

For now, the device locations can not be updated, so they
will only contain lists the devices that are initially in
those locations. But that can later be easily changed if
needed by adding API that can be used to update the
locations.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/scan.c     | 77 +++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h | 19 ++++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5991dddbc9ceb..f147c0ad5f944 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -19,6 +19,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pgtable.h>
+#include <linux/crc32.h>
 
 #include "internal.h"
 
@@ -42,6 +43,8 @@ static LIST_HEAD(acpi_scan_handlers_list);
 DEFINE_MUTEX(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 static DEFINE_MUTEX(acpi_hp_context_lock);
+static LIST_HEAD(acpi_location_list);
+static DEFINE_MUTEX(acpi_location_lock);
 
 /*
  * The UART device described by the SPCR table is the only object which needs
@@ -485,6 +488,7 @@ static void acpi_device_del(struct acpi_device *device)
 			break;
 		}
 
+	list_del(&device->location_list);
 	list_del(&device->wakeup_list);
 	mutex_unlock(&acpi_device_lock);
 
@@ -654,6 +658,76 @@ static int acpi_tie_acpi_dev(struct acpi_device *adev)
 	return 0;
 }
 
+static void acpi_store_device_location(struct acpi_device *adev)
+{
+	struct acpi_device_location *location;
+	struct acpi_pld_info *pld;
+	acpi_status status;
+	u32 crc;
+
+	status = acpi_get_physical_device_location(adev->handle, &pld);
+	if (ACPI_FAILURE(status))
+		return;
+
+	crc = crc32(~0, pld, sizeof(*pld));
+
+	mutex_lock(&acpi_location_lock);
+
+	list_for_each_entry(location, &acpi_location_list, node)
+		if (location->pld_crc == crc)
+			goto out_add_to_location;
+
+	/* The location does not exist yet so creating it. */
+
+	location = kzalloc(sizeof(*location), GFP_KERNEL);
+	if (!location) {
+		acpi_handle_err(adev->handle, "Unable to store location\n");
+		goto err_unlock;
+	}
+
+	list_add_tail(&location->node, &acpi_location_list);
+	INIT_LIST_HEAD(&location->devices);
+	location->pld_crc = crc;
+
+out_add_to_location:
+	list_add_tail(&adev->location_list, &location->devices);
+
+err_unlock:
+	ACPI_FREE(pld);
+	mutex_unlock(&acpi_location_lock);
+}
+
+/**
+ * acpi_device_get_location - Get the device location
+ * @adev: ACPI device handle
+ *
+ * Return a pointer to a struct acpi_device_location object containing the
+ * location information obtained by evaluating _PLD (Physical Location of
+ * Device) for @adev when it is available, along with the list of devices
+ * sharing the same location information (if any), or NULL otherwise.
+ */
+struct acpi_device_location *acpi_device_get_location(struct acpi_device *adev)
+{
+	struct acpi_device_location *location;
+	struct list_head *tmp;
+
+	mutex_lock(&acpi_location_lock);
+
+	list_for_each_entry(location, &acpi_location_list, node) {
+		list_for_each(tmp, &location->devices) {
+			if (tmp == &adev->location_list)
+				goto out_unlock;
+		}
+	}
+	location = NULL;
+
+out_unlock:
+	mutex_unlock(&acpi_location_lock);
+
+	return location;
+}
+EXPORT_SYMBOL_GPL(acpi_device_get_location);
+
 static int __acpi_device_add(struct acpi_device *device,
 			     void (*release)(struct device *))
 {
@@ -670,6 +744,7 @@ static int __acpi_device_add(struct acpi_device *device,
 	INIT_LIST_HEAD(&device->wakeup_list);
 	INIT_LIST_HEAD(&device->physical_node_list);
 	INIT_LIST_HEAD(&device->del_list);
+	INIT_LIST_HEAD(&device->location_list);
 	mutex_init(&device->physical_node_lock);
 
 	mutex_lock(&acpi_device_lock);
@@ -712,6 +787,8 @@ static int __acpi_device_add(struct acpi_device *device,
 	if (device->wakeup.flags.valid)
 		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
 
+	acpi_store_device_location(device);
+
 	mutex_unlock(&acpi_device_lock);
 
 	if (device->parent)
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index d6fe27b695c3d..9123884e4e7ec 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -354,6 +354,18 @@ struct acpi_device_data {
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
@@ -366,6 +378,7 @@ struct acpi_device {
 	struct list_head node;
 	struct list_head wakeup_list;
 	struct list_head del_list;
+	struct list_head location_list;
 	struct acpi_device_status status;
 	struct acpi_device_flags flags;
 	struct acpi_device_pnp pnp;
@@ -731,11 +744,17 @@ static inline void acpi_bus_put_acpi_device(struct acpi_device *adev)
 {
 	acpi_dev_put(adev);
 }
+
+struct acpi_device_location *acpi_device_get_location(struct acpi_device *adev);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
 static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
+static inline struct acpi_device_location *acpi_device_get_location(struct acpi_device *adev)
+{
+	return NULL;
+}
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/
-- 
2.34.1

