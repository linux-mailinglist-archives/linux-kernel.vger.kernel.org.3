Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17CB47E03C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347111AbhLWIQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:16:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:28533 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239315AbhLWIQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640247379; x=1671783379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZGjf2BsKqKmCiWOumvWShxieb989cWfWjiqvu1NglXs=;
  b=MPy80rf2L6+okhZooKZsS6kol3HUmSV+ppp/wj0T6TfjZ1Em3JKJkt0E
   JekETYww5G6HsvZCzYxlGz9RkqsTtYx7NCemLmGqIdKbVucxHs7v2n0zG
   wlmkqONKwNY3OhN1WBCYS1VVylVzk1E99u0TcRtOoeCg5GWRejKPEzkbO
   7iPoMimD2qFm2WRu8FXBD09dza/0WopgA720tkJJia6kzKuv0JxhUM2gj
   qt13WxbTLvTW7ZYqjrw2dShsO6NM3TsyefYNSSfYLpWaqUdOj7DtLb2iL
   o9UZPF72CcMv9n3yT3zqUVH0xhq6DtzM3BrP37Sxw3nRb5ejQrC2x5OpM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="264990671"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="264990671"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 00:16:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="664515517"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 00:16:17 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] acpi: Store CRC-32 hash of the _PLD in struct acpi_device
Date:   Thu, 23 Dec 2021 11:16:17 +0300
Message-Id: <20211223081620.45479-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
References: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
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
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 17 insertions(+)

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
index 8e87ead2af341..f8c945418df23 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -360,6 +360,7 @@ struct acpi_gpio_mapping;
 
 /* Device */
 struct acpi_device {
+	u32 pld_crc;
 	int device_type;
 	acpi_handle handle;		/* no handle for fixed hardware */
 	struct fwnode_handle fwnode;
-- 
2.34.1

