Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610E449D295
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244477AbiAZTic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:38:32 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63522 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbiAZTib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:38:31 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id cca96c41851dd446; Wed, 26 Jan 2022 20:38:29 +0100
Received: from kreacher.localnet (unknown [213.134.162.63])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6C48066B311;
        Wed, 26 Jan 2022 20:38:28 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform: x86: Replace acpi_bus_get_device()
Date:   Wed, 26 Jan 2022 20:38:27 +0100
Message-ID: <2631712.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.63
X-CLIENT-HOSTNAME: 213.134.162.63
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudeivddrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddrieefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhr
 tghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace acpi_bus_get_device() that is going to be dropped with
acpi_fetch_acpi_dev().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel/hid.c              |    7 ++-----
 drivers/platform/x86/intel/int3472/discrete.c |    5 ++---
 drivers/platform/x86/intel/vbtn.c             |    7 ++-----
 drivers/platform/x86/thinkpad_acpi.c          |   17 ++++++++---------
 drivers/platform/x86/x86-android-tablets.c    |    2 +-
 5 files changed, 15 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/platform/x86/intel/vbtn.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/intel/vbtn.c
+++ linux-pm/drivers/platform/x86/intel/vbtn.c
@@ -384,12 +384,9 @@ static acpi_status __init
 check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	const struct acpi_device_id *ids = context;
-	struct acpi_device *dev;
+	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
 
-	if (acpi_bus_get_device(handle, &dev) != 0)
-		return AE_OK;
-
-	if (acpi_match_device_ids(dev, ids) == 0)
+	if (dev && acpi_match_device_ids(dev, ids) == 0)
 		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
 			dev_info(&dev->dev,
 				 "intel-vbtn: created platform device\n");
Index: linux-pm/drivers/platform/x86/intel/hid.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/intel/hid.c
+++ linux-pm/drivers/platform/x86/intel/hid.c
@@ -726,12 +726,9 @@ static acpi_status __init
 check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	const struct acpi_device_id *ids = context;
-	struct acpi_device *dev;
+	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
 
-	if (acpi_bus_get_device(handle, &dev) != 0)
-		return AE_OK;
-
-	if (acpi_match_device_ids(dev, ids) == 0)
+	if (dev && acpi_match_device_ids(dev, ids) == 0)
 		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
 			dev_info(&dev->dev,
 				 "intel-hid: created platform device\n");
Index: linux-pm/drivers/platform/x86/thinkpad_acpi.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/thinkpad_acpi.c
+++ linux-pm/drivers/platform/x86/thinkpad_acpi.c
@@ -728,11 +728,10 @@ static void __init drv_acpi_handle_init(
 static acpi_status __init tpacpi_acpi_handle_locate_callback(acpi_handle handle,
 			u32 level, void *context, void **return_value)
 {
-	struct acpi_device *dev;
 	if (!strcmp(context, "video")) {
-		if (acpi_bus_get_device(handle, &dev))
-			return AE_OK;
-		if (strcmp(ACPI_VIDEO_HID, acpi_device_hid(dev)))
+		struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
+
+		if (!dev || strcmp(ACPI_VIDEO_HID, acpi_device_hid(dev)))
 			return AE_OK;
 	}
 
@@ -786,7 +785,6 @@ static void dispatch_acpi_notify(acpi_ha
 static int __init setup_acpi_notify(struct ibm_struct *ibm)
 {
 	acpi_status status;
-	int rc;
 
 	BUG_ON(!ibm->acpi);
 
@@ -796,9 +794,9 @@ static int __init setup_acpi_notify(stru
 	vdbg_printk(TPACPI_DBG_INIT,
 		"setting up ACPI notify for %s\n", ibm->name);
 
-	rc = acpi_bus_get_device(*ibm->acpi->handle, &ibm->acpi->device);
-	if (rc < 0) {
-		pr_err("acpi_bus_get_device(%s) failed: %d\n", ibm->name, rc);
+	ibm->acpi->device = acpi_fetch_acpi_dev(*ibm->acpi->handle);
+	if (!ibm->acpi->device) {
+		pr_err("acpi_fetch_acpi_dev(%s) failed\n", ibm->name);
 		return -ENODEV;
 	}
 
@@ -6723,7 +6721,8 @@ static int __init tpacpi_query_bcl_level
 	struct acpi_device *device, *child;
 	int rc;
 
-	if (acpi_bus_get_device(handle, &device))
+	device = acpi_fetch_acpi_dev(handle);
+	if (!device)
 		return 0;
 
 	rc = 0;
Index: linux-pm/drivers/platform/x86/intel/int3472/discrete.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/intel/int3472/discrete.c
+++ linux-pm/drivers/platform/x86/intel/int3472/discrete.c
@@ -112,7 +112,6 @@ static int skl_int3472_map_gpio_to_senso
 	struct acpi_device *adev;
 	acpi_handle handle;
 	acpi_status status;
-	int ret;
 
 	if (int3472->n_sensor_gpios >= INT3472_MAX_SENSOR_GPIOS) {
 		dev_warn(int3472->dev, "Too many GPIOs mapped\n");
@@ -139,8 +138,8 @@ static int skl_int3472_map_gpio_to_senso
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
 
-	ret = acpi_bus_get_device(handle, &adev);
-	if (ret)
+	adev = acpi_fetch_acpi_dev(handle);
+	if (!adev)
 		return -ENODEV;
 
 	table_entry = &int3472->gpios.table[int3472->n_sensor_gpios];
Index: linux-pm/drivers/platform/x86/x86-android-tablets.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/x86-android-tablets.c
+++ linux-pm/drivers/platform/x86/x86-android-tablets.c
@@ -104,7 +104,7 @@ static int x86_acpi_irq_helper_get(const
 			return -ENODEV;
 		}
 
-		acpi_bus_get_device(handle, &adev);
+		adev = acpi_fetch_acpi_dev(handle);
 		if (!adev) {
 			pr_err("error could not get %s adev\n", data->chip);
 			return -ENODEV;



