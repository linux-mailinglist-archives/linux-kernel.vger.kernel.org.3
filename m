Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706DE467B8F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382108AbhLCQlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:41:00 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53754 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382087AbhLCQk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:40:56 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id efa5b0d3f41f30b2; Fri, 3 Dec 2021 17:37:31 +0100
Received: from kreacher.localnet (unknown [213.134.175.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7551466AD69;
        Fri,  3 Dec 2021 17:37:30 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/2] ACPI: scan: Introduce acpi_fetch_acpi_dev()
Date:   Fri, 03 Dec 2021 17:36:20 +0100
Message-ID: <3173027.44csPzL39Z@kreacher>
In-Reply-To: <2828957.e9J7NaK4W3@kreacher>
References: <2828957.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.202
X-CLIENT-HOSTNAME: 213.134.175.202
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddujeehrddvtddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrvddtvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohep
 lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce acpi_fetch_acpi_dev() as a more reasonable replacement for
acpi_bus_get_device() and modify the code in scan.c to use it instead
of the latter.

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c     |   34 ++++++++++++++++++++++++----------
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 25 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -135,12 +135,12 @@ bool acpi_scan_is_offline(struct acpi_de
 static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
 				    void **ret_p)
 {
-	struct acpi_device *device = NULL;
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 	struct acpi_device_physical_node *pn;
 	bool second_pass = (bool)data;
 	acpi_status status = AE_OK;
 
-	if (acpi_bus_get_device(handle, &device))
+	if (!device)
 		return AE_OK;
 
 	if (device->handler && !device->handler->hotplug.enabled) {
@@ -180,10 +180,10 @@ static acpi_status acpi_bus_offline(acpi
 static acpi_status acpi_bus_online(acpi_handle handle, u32 lvl, void *data,
 				   void **ret_p)
 {
-	struct acpi_device *device = NULL;
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 	struct acpi_device_physical_node *pn;
 
-	if (acpi_bus_get_device(handle, &device))
+	if (!device)
 		return AE_OK;
 
 	mutex_lock(&device->physical_node_lock);
@@ -599,6 +599,19 @@ int acpi_bus_get_device(acpi_handle hand
 }
 EXPORT_SYMBOL(acpi_bus_get_device);
 
+/**
+ * acpi_fetch_acpi_dev - Retrieve ACPI device object.
+ * @handle: ACPI handle associated with the requested ACPI device object.
+ *
+ * Return a pointer to the ACPI device object associated with @handle, if
+ * present, or NULL otherwise.
+ */
+struct acpi_device *acpi_fetch_acpi_dev(acpi_handle handle)
+{
+	return handle_to_device(handle, NULL);
+}
+EXPORT_SYMBOL_GPL(acpi_fetch_acpi_dev);
+
 static void get_acpi_device(void *dev)
 {
 	acpi_dev_get(dev);
@@ -799,7 +812,7 @@ static const char * const acpi_ignore_de
 
 static struct acpi_device *acpi_bus_get_parent(acpi_handle handle)
 {
-	struct acpi_device *device = NULL;
+	struct acpi_device *device;
 	acpi_status status;
 
 	/*
@@ -814,7 +827,9 @@ static struct acpi_device *acpi_bus_get_
 		status = acpi_get_parent(handle, &handle);
 		if (ACPI_FAILURE(status))
 			return status == AE_NULL_ENTRY ? NULL : acpi_root;
-	} while (acpi_bus_get_device(handle, &device));
+
+		device = acpi_fetch_acpi_dev(handle);
+	} while (!device);
 	return device;
 }
 
@@ -2003,11 +2018,10 @@ static bool acpi_bus_scan_second_pass;
 static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 				      struct acpi_device **adev_p)
 {
-	struct acpi_device *device = NULL;
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 	acpi_object_type acpi_type;
 	int type;
 
-	acpi_bus_get_device(handle, &device);
 	if (device)
 		goto out;
 
@@ -2548,8 +2562,8 @@ int __init acpi_scan_init(void)
 	if (result)
 		goto out;
 
-	result = acpi_bus_get_device(ACPI_ROOT_OBJECT, &acpi_root);
-	if (result)
+	acpi_root = acpi_fetch_acpi_dev(ACPI_ROOT_OBJECT);
+	if (!acpi_root)
 		goto out;
 
 	/* Fixed feature devices do not exist on HW-reduced platform */
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -505,6 +505,7 @@ extern int unregister_acpi_notifier(stru
  */
 
 int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device);
+struct acpi_device *acpi_fetch_acpi_dev(acpi_handle handle);
 acpi_status acpi_bus_get_status_handle(acpi_handle handle,
 				       unsigned long long *sta);
 int acpi_bus_get_status(struct acpi_device *device);



