Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4AF58F05E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiHJQYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiHJQYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:24:01 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3E980F6D;
        Wed, 10 Aug 2022 09:23:58 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id b1d2a683a77102d0; Wed, 10 Aug 2022 18:23:56 +0200
Received: from kreacher.localnet (unknown [213.134.187.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 24A4066CF1C;
        Wed, 10 Aug 2022 18:23:56 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 3/5] ACPI: scan: Rearrange initialization of ACPI device objects
Date:   Wed, 10 Aug 2022 18:16:33 +0200
Message-ID: <1828627.tdWV9SEqCh@kreacher>
In-Reply-To: <12036348.O9o76ZdvQC@kreacher>
References: <12036348.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.55
X-CLIENT-HOSTNAME: 213.134.187.55
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeejrdehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrdehhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhn
 vghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The initialization of ACPI device objects is split between
acpi_init_device_object() and __acpi_device_add() that initializes
the dev field in struct acpi_device.  The "release" function pointer
is passed to __acpi_device_add() for this reason.

However, that split is artificial and all of the initialization can
be carried out by acpi_init_device_object(), so rearrange the code
to that end.  In particular, make acpi_init_device_object() take the
"release" pointer as an argument, along with the "type" which is
related to it, instead of __acpi_device_add().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h |    5 ++---
 drivers/acpi/power.c    |    5 +++--
 drivers/acpi/scan.c     |   27 ++++++++++++++-------------
 3 files changed, 19 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -673,8 +673,7 @@ static void acpi_store_pld_crc(struct ac
 	ACPI_FREE(pld);
 }
 
-static int __acpi_device_add(struct acpi_device *device,
-			     void (*release)(struct device *))
+static int __acpi_device_add(struct acpi_device *device)
 {
 	struct acpi_device_bus_id *acpi_device_bus_id;
 	int result;
@@ -730,11 +729,6 @@ static int __acpi_device_add(struct acpi
 
 	mutex_unlock(&acpi_device_lock);
 
-	if (device->parent)
-		device->dev.parent = &device->parent->dev;
-
-	device->dev.bus = &acpi_bus_type;
-	device->dev.release = release;
 	result = device_add(&device->dev);
 	if (result) {
 		dev_err(&device->dev, "Error registering device\n");
@@ -761,7 +755,7 @@ err_unlock:
 	return result;
 }
 
-int acpi_device_add(struct acpi_device *adev, void (*release)(struct device *))
+int acpi_device_add(struct acpi_device *adev)
 {
 	int ret;
 
@@ -769,7 +763,7 @@ int acpi_device_add(struct acpi_device *
 	if (ret)
 		return ret;
 
-	return __acpi_device_add(adev, release);
+	return __acpi_device_add(adev);
 }
 
 /* --------------------------------------------------------------------------
@@ -1776,12 +1770,19 @@ static bool acpi_device_enumeration_by_p
 }
 
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
-			     int type)
+			     int type, void (*release)(struct device *))
 {
+	struct acpi_device *parent = acpi_find_parent_acpi_dev(handle);
+
 	INIT_LIST_HEAD(&device->pnp.ids);
 	device->device_type = type;
 	device->handle = handle;
-	device->parent = acpi_find_parent_acpi_dev(handle);
+	if (parent) {
+		device->parent = parent;
+		device->dev.parent = &parent->dev;
+	}
+	device->dev.release = release;
+	device->dev.bus = &acpi_bus_type;
 	fwnode_init(&device->fwnode, &acpi_device_fwnode_ops);
 	acpi_set_device_status(device, ACPI_STA_DEFAULT);
 	acpi_device_get_busid(device);
@@ -1835,7 +1836,7 @@ static int acpi_add_single_object(struct
 	if (!device)
 		return -ENOMEM;
 
-	acpi_init_device_object(device, handle, type);
+	acpi_init_device_object(device, handle, type, acpi_device_release);
 	/*
 	 * Getting the status is delayed till here so that we can call
 	 * acpi_bus_get_status() and use its quirk handling.  Note that
@@ -1865,7 +1866,7 @@ static int acpi_add_single_object(struct
 		mutex_unlock(&acpi_dep_list_lock);
 
 	if (!result)
-		result = __acpi_device_add(device, acpi_device_release);
+		result = __acpi_device_add(device);
 
 	if (result) {
 		acpi_device_release(&device->dev);
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -102,10 +102,9 @@ struct acpi_device_bus_id {
 	struct list_head node;
 };
 
-int acpi_device_add(struct acpi_device *device,
-		    void (*release)(struct device *));
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
-			     int type);
+			     int type, void (*release)(struct device *));
+int acpi_device_add(struct acpi_device *device);
 int acpi_device_setup_files(struct acpi_device *dev);
 void acpi_device_remove_files(struct acpi_device *dev);
 void acpi_device_add_finalize(struct acpi_device *device);
Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -944,7 +944,8 @@ struct acpi_device *acpi_add_power_resou
 		return NULL;
 
 	device = &resource->device;
-	acpi_init_device_object(device, handle, ACPI_BUS_TYPE_POWER);
+	acpi_init_device_object(device, handle, ACPI_BUS_TYPE_POWER,
+				acpi_release_power_resource);
 	mutex_init(&resource->resource_lock);
 	INIT_LIST_HEAD(&resource->list_node);
 	INIT_LIST_HEAD(&resource->dependents);
@@ -968,7 +969,7 @@ struct acpi_device *acpi_add_power_resou
 	pr_info("%s [%s]\n", acpi_device_name(device), acpi_device_bid(device));
 
 	device->flags.match_driver = true;
-	result = acpi_device_add(device, acpi_release_power_resource);
+	result = acpi_device_add(device);
 	if (result)
 		goto err;
 



