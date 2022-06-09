Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5499D544EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbiFIOVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiFIOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:20:41 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1056C27CD50;
        Thu,  9 Jun 2022 07:20:39 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id f20ad430356f000d; Thu, 9 Jun 2022 16:20:38 +0200
Received: from kreacher.localnet (unknown [213.134.186.232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8695866C7CA;
        Thu,  9 Jun 2022 16:20:37 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 11/16] ACPI: scan: Walk ACPI device's children using driver core
Date:   Thu, 09 Jun 2022 16:07:17 +0200
Message-ID: <3639830.MHq7AAxBmi@kreacher>
In-Reply-To: <1843211.tdWV9SEqCh@kreacher>
References: <1843211.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.186.232
X-CLIENT-HOSTNAME: 213.134.186.232
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeeirddvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekiedrvdefvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhi
 nhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of walking the list of children of an ACPI device directly, use
acpi_dev_for_each_child() or acpi_dev_for_each_child_reverse() to carry
out an action for all of the given ACPI device's children.

This will help to eliminate the children list head from struct
acpi_device as it is redundant and it is used in questionable ways
in some places (in particular, locking is needed for walking the
list pointed to it safely, but it is often missing).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   59 +++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -334,10 +334,9 @@ static int acpi_scan_device_check(struct
 	return error;
 }
 
-static int acpi_scan_bus_check(struct acpi_device *adev)
+static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
 {
 	struct acpi_scan_handler *handler = adev->handler;
-	struct acpi_device *child;
 	int error;
 
 	acpi_bus_get_status(adev);
@@ -353,19 +352,14 @@ static int acpi_scan_bus_check(struct ac
 		dev_warn(&adev->dev, "Namespace scan failure\n");
 		return error;
 	}
-	list_for_each_entry(child, &adev->children, node) {
-		error = acpi_scan_bus_check(child);
-		if (error)
-			return error;
-	}
-	return 0;
+	return acpi_dev_for_each_child(adev, acpi_scan_bus_check, NULL);
 }
 
 static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
 {
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
-		return acpi_scan_bus_check(adev);
+		return acpi_scan_bus_check(adev, NULL);
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		return acpi_scan_device_check(adev);
 	case ACPI_NOTIFY_EJECT_REQUEST:
@@ -2187,9 +2181,8 @@ static int acpi_scan_attach_handler(stru
 	return ret;
 }
 
-static void acpi_bus_attach(struct acpi_device *device, bool first_pass)
+static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 {
-	struct acpi_device *child;
 	bool skip = !first_pass && device->flags.visited;
 	acpi_handle ejd;
 	int ret;
@@ -2206,7 +2199,7 @@ static void acpi_bus_attach(struct acpi_
 		device->flags.initialized = false;
 		acpi_device_clear_enumerated(device);
 		device->flags.power_manageable = 0;
-		return;
+		return 0;
 	}
 	if (device->handler)
 		goto ok;
@@ -2224,7 +2217,7 @@ static void acpi_bus_attach(struct acpi_
 
 	ret = acpi_scan_attach_handler(device);
 	if (ret < 0)
-		return;
+		return 0;
 
 	device->flags.match_driver = true;
 	if (ret > 0 && !device->flags.enumeration_by_parent) {
@@ -2234,19 +2227,20 @@ static void acpi_bus_attach(struct acpi_
 
 	ret = device_attach(&device->dev);
 	if (ret < 0)
-		return;
+		return 0;
 
 	if (device->pnp.type.platform_id || device->flags.enumeration_by_parent)
 		acpi_default_enumeration(device);
 	else
 		acpi_device_set_enumerated(device);
 
- ok:
-	list_for_each_entry(child, &device->children, node)
-		acpi_bus_attach(child, first_pass);
+ok:
+	acpi_dev_for_each_child(device, acpi_bus_attach, first_pass);
 
 	if (!skip && device->handler && device->handler->hotplug.notify_online)
 		device->handler->hotplug.notify_online(device);
+
+	return 0;
 }
 
 static int acpi_dev_get_first_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
@@ -2274,7 +2268,7 @@ static void acpi_scan_clear_dep_fn(struc
 	cdw = container_of(work, struct acpi_scan_clear_dep_work, work);
 
 	acpi_scan_lock_acquire();
-	acpi_bus_attach(cdw->adev, true);
+	acpi_bus_attach(cdw->adev, (void *)true);
 	acpi_scan_lock_release();
 
 	acpi_dev_put(cdw->adev);
@@ -2432,7 +2426,7 @@ int acpi_bus_scan(acpi_handle handle)
 	if (!device)
 		return -ENODEV;
 
-	acpi_bus_attach(device, true);
+	acpi_bus_attach(device, (void *)true);
 
 	if (!acpi_bus_scan_second_pass)
 		return 0;
@@ -2446,25 +2440,17 @@ int acpi_bus_scan(acpi_handle handle)
 				    acpi_bus_check_add_2, NULL, NULL,
 				    (void **)&device);
 
-	acpi_bus_attach(device, false);
+	acpi_bus_attach(device, NULL);
 
 	return 0;
 }
 EXPORT_SYMBOL(acpi_bus_scan);
 
-/**
- * acpi_bus_trim - Detach scan handlers and drivers from ACPI device objects.
- * @adev: Root of the ACPI namespace scope to walk.
- *
- * Must be called under acpi_scan_lock.
- */
-void acpi_bus_trim(struct acpi_device *adev)
+int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
 {
 	struct acpi_scan_handler *handler = adev->handler;
-	struct acpi_device *child;
 
-	list_for_each_entry_reverse(child, &adev->children, node)
-		acpi_bus_trim(child);
+	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
 
 	adev->flags.match_driver = false;
 	if (handler) {
@@ -2482,6 +2468,19 @@ void acpi_bus_trim(struct acpi_device *a
 	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
 	adev->flags.initialized = false;
 	acpi_device_clear_enumerated(adev);
+
+	return 0;
+}
+
+/**
+ * acpi_bus_trim - Detach scan handlers and drivers from ACPI device objects.
+ * @adev: Root of the ACPI namespace scope to walk.
+ *
+ * Must be called under acpi_scan_lock.
+ */
+void acpi_bus_trim(struct acpi_device *adev)
+{
+	acpi_bus_trim_one(adev, NULL);
 }
 EXPORT_SYMBOL_GPL(acpi_bus_trim);
 



