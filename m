Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E664B46BDE8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhLGOlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:41:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:48408 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237989AbhLGOlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:41:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237528438"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237528438"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 06:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="657725100"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2021 06:37:59 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] usb: Use the cached ACPI _PLD entry
Date:   Tue,  7 Dec 2021 17:37:54 +0300
Message-Id: <20211207143757.21895-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
References: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
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

