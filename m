Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29F758F061
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiHJQYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiHJQYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:24:03 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788827E834;
        Wed, 10 Aug 2022 09:24:01 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 628687f6e8a7044b; Wed, 10 Aug 2022 18:23:59 +0200
Received: from kreacher.localnet (unknown [213.134.187.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id ED44E66CF1C;
        Wed, 10 Aug 2022 18:23:58 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1 1/5] ACPI: Rename acpi_bus_get/put_acpi_device()
Date:   Wed, 10 Aug 2022 18:14:22 +0200
Message-ID: <4763162.31r3eYUQgx@kreacher>
In-Reply-To: <12036348.O9o76ZdvQC@kreacher>
References: <12036348.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.55
X-CLIENT-HOSTNAME: 213.134.187.55
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeejrdehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrdehhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhn
 vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqhhifmhhonhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuggvlhhvrghrvgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvght
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

Because acpi_bus_get_acpi_device() is completely analogous to
acpi_fetch_acpi_dev(), rename it to acpi_get_acpi_dev() and
add a kerneldoc comment to it.

Accordingly, rename acpi_bus_put_acpi_device() to acpi_put_acpi_dev()
and update all of the users of these two functions.

While at it, move the acpi_fetch_acpi_dev() header next to the
acpi_get_acpi_dev() header in the header file holding them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c               |    6 +++---
 drivers/acpi/device_pm.c         |    4 ++--
 drivers/acpi/irq.c               |    4 ++--
 drivers/acpi/scan.c              |   21 ++++++++++++++++-----
 drivers/hwmon/acpi_power_meter.c |    2 +-
 include/acpi/acpi_bus.h          |    6 +++---
 6 files changed, 27 insertions(+), 16 deletions(-)

Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -511,7 +511,6 @@ extern int unregister_acpi_notifier(stru
  * External Functions
  */
 
-struct acpi_device *acpi_fetch_acpi_dev(acpi_handle handle);
 acpi_status acpi_bus_get_status_handle(acpi_handle handle,
 				       unsigned long long *sta);
 int acpi_bus_get_status(struct acpi_device *device);
@@ -766,9 +765,10 @@ static inline void acpi_dev_put(struct a
 		put_device(&adev->dev);
 }
 
-struct acpi_device *acpi_bus_get_acpi_device(acpi_handle handle);
+struct acpi_device *acpi_fetch_acpi_dev(acpi_handle handle);
+struct acpi_device *acpi_get_acpi_dev(acpi_handle handle);
 
-static inline void acpi_bus_put_acpi_device(struct acpi_device *adev)
+static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 {
 	acpi_dev_put(adev);
 }
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -429,7 +429,7 @@ void acpi_device_hotplug(struct acpi_dev
 	acpi_evaluate_ost(adev->handle, src, ost_code, NULL);
 
  out:
-	acpi_bus_put_acpi_device(adev);
+	acpi_put_acpi_dev(adev);
 	mutex_unlock(&acpi_scan_lock);
 	unlock_device_hotplug();
 }
@@ -599,11 +599,22 @@ static void get_acpi_device(void *dev)
 	acpi_dev_get(dev);
 }
 
-struct acpi_device *acpi_bus_get_acpi_device(acpi_handle handle)
+/**
+ * acpi_get_acpi_dev - Retrieve ACPI device object and reference count it.
+ * @handle: ACPI handle associated with the requested ACPI device object.
+ *
+ * Return a pointer to the ACPI device object associated with @handle and bump
+ * up that object's reference counter (under the ACPI Namespace lock), if
+ * present, or return NULL otherwise.
+ *
+ * The ACPI device object reference acquired by this function needs to be
+ * dropped via acpi_dev_put().
+ */
+struct acpi_device *acpi_get_acpi_dev(acpi_handle handle)
 {
 	return handle_to_device(handle, get_acpi_device);
 }
-EXPORT_SYMBOL_GPL(acpi_bus_get_acpi_device);
+EXPORT_SYMBOL_GPL(acpi_get_acpi_dev);
 
 static struct acpi_device_bus_id *acpi_device_bus_id_match(const char *dev_id)
 {
@@ -2238,7 +2249,7 @@ static int acpi_dev_get_first_consumer_d
 {
 	struct acpi_device *adev;
 
-	adev = acpi_bus_get_acpi_device(dep->consumer);
+	adev = acpi_get_acpi_dev(dep->consumer);
 	if (adev) {
 		*(struct acpi_device **)data = adev;
 		return 1;
@@ -2291,7 +2302,7 @@ static bool acpi_scan_clear_dep_queue(st
 
 static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
 {
-	struct acpi_device *adev = acpi_bus_get_acpi_device(dep->consumer);
+	struct acpi_device *adev = acpi_get_acpi_dev(dep->consumer);
 
 	if (adev) {
 		adev->dep_unmet--;
Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -511,7 +511,7 @@ static void acpi_bus_notify(acpi_handle
 		break;
 	}
 
-	adev = acpi_bus_get_acpi_device(handle);
+	adev = acpi_get_acpi_dev(handle);
 	if (!adev)
 		goto err;
 
@@ -524,14 +524,14 @@ static void acpi_bus_notify(acpi_handle
 	}
 
 	if (!hotplug_event) {
-		acpi_bus_put_acpi_device(adev);
+		acpi_put_acpi_dev(adev);
 		return;
 	}
 
 	if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
 		return;
 
-	acpi_bus_put_acpi_device(adev);
+	acpi_put_acpi_dev(adev);
 
  err:
 	acpi_evaluate_ost(handle, type, ost_code, NULL);
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -497,7 +497,7 @@ static void acpi_pm_notify_handler(acpi_
 
 	acpi_handle_debug(handle, "Wake notify\n");
 
-	adev = acpi_bus_get_acpi_device(handle);
+	adev = acpi_get_acpi_dev(handle);
 	if (!adev)
 		return;
 
@@ -515,7 +515,7 @@ static void acpi_pm_notify_handler(acpi_
 
 	mutex_unlock(&acpi_pm_notifier_lock);
 
-	acpi_bus_put_acpi_device(adev);
+	acpi_put_acpi_dev(adev);
 }
 
 /**
Index: linux-pm/drivers/acpi/irq.c
===================================================================
--- linux-pm.orig/drivers/acpi/irq.c
+++ linux-pm/drivers/acpi/irq.c
@@ -111,12 +111,12 @@ acpi_get_irq_source_fwhandle(const struc
 	if (WARN_ON(ACPI_FAILURE(status)))
 		return NULL;
 
-	device = acpi_bus_get_acpi_device(handle);
+	device = acpi_get_acpi_dev(handle);
 	if (WARN_ON(!device))
 		return NULL;
 
 	result = &device->fwnode;
-	acpi_bus_put_acpi_device(device);
+	acpi_put_acpi_dev(device);
 	return result;
 }
 
Index: linux-pm/drivers/hwmon/acpi_power_meter.c
===================================================================
--- linux-pm.orig/drivers/hwmon/acpi_power_meter.c
+++ linux-pm/drivers/hwmon/acpi_power_meter.c
@@ -598,7 +598,7 @@ static int read_domain_devices(struct ac
 			continue;
 
 		/* Create a symlink to domain objects */
-		obj = acpi_bus_get_acpi_device(element->reference.handle);
+		obj = acpi_get_acpi_dev(element->reference.handle);
 		resource->domain_devices[i] = obj;
 		if (!obj)
 			continue;



