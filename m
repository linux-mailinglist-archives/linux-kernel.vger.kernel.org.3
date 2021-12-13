Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1AD472A35
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbhLMKe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:34:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:51594 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237920AbhLMKdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:33:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="238930010"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="238930010"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 02:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="660821535"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2021 02:32:42 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] usb: Use the cached ACPI _PLD entry
Date:   Mon, 13 Dec 2021 13:32:40 +0300
Message-Id: <20211213103243.33657-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
References: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _PLD is now stored, so there is no need to separately
evaluate it.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/core/usb-acpi.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 50b2fc7fcc0e3..3b21c15be548f 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -176,22 +176,19 @@ usb_acpi_get_companion_for_port(struct usb_port *port_dev)
 static struct acpi_device *
 usb_acpi_find_companion_for_port(struct usb_port *port_dev)
 {
+	struct acpi_device_location *location;
 	struct acpi_device *adev;
-	struct acpi_pld_info *pld;
-	acpi_handle *handle;
-	acpi_status status;
 
 	adev = usb_acpi_get_companion_for_port(port_dev);
 	if (!adev)
 		return NULL;
 
-	handle = adev->handle;
-	status = acpi_get_physical_device_location(handle, &pld);
-	if (ACPI_SUCCESS(status) && pld) {
-		port_dev->location = USB_ACPI_LOCATION_VALID
-			| pld->group_token << 8 | pld->group_position;
-		port_dev->connect_type = usb_acpi_get_connect_type(handle, pld);
-		ACPI_FREE(pld);
+	location = acpi_device_get_location(adev);
+	if (location) {
+		port_dev->location = USB_ACPI_LOCATION_VALID |
+				     location->pld->group_token << 8 |
+				     location->pld->group_position;
+		port_dev->connect_type = usb_acpi_get_connect_type(adev->handle, location->pld);
 	}
 
 	return adev;
-- 
2.33.0

