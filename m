Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE24467B8D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhLCQkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:40:55 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42014 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382075AbhLCQky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:40:54 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id af30dad34f8a4c6f; Fri, 3 Dec 2021 17:37:29 +0100
Received: from kreacher.localnet (unknown [213.134.175.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id ABD6766AD69;
        Fri,  3 Dec 2021 17:37:28 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 2/2] ACPI: Use acpi_fetch_acpi_dev() instead of acpi_bus_get_device()
Date:   Fri, 03 Dec 2021 17:37:10 +0100
Message-ID: <10019174.nUPlyArG6x@kreacher>
In-Reply-To: <2828957.e9J7NaK4W3@kreacher>
References: <2828957.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.202
X-CLIENT-HOSTNAME: 213.134.175.202
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddujeehrddvtddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrvddtvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohep
 lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the ACPI code to use acpi_fetch_acpi_dev() instead of
acpi_bus_get_device() where applicable.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c       |    5 ++---
 drivers/acpi/device_pm.c        |   31 +++++++++++++------------------
 drivers/acpi/dock.c             |    3 +--
 drivers/acpi/pci_link.c         |   12 ++++--------
 drivers/acpi/pci_root.c         |   10 ++++------
 drivers/acpi/power.c            |    7 +++----
 drivers/acpi/processor_driver.c |   10 +++++++---
 drivers/acpi/processor_idle.c   |    2 +-
 drivers/acpi/property.c         |   11 +++++------
 drivers/acpi/resource.c         |    4 ++--
 drivers/acpi/thermal.c          |    9 ++++-----
 drivers/acpi/video_detect.c     |    6 ++----
 drivers/acpi/x86/s2idle.c       |    4 ++--
 13 files changed, 50 insertions(+), 64 deletions(-)

Index: linux-pm/drivers/acpi/acpi_video.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_video.c
+++ linux-pm/drivers/acpi/acpi_video.c
@@ -1733,13 +1733,12 @@ acpi_video_bus_match(acpi_handle handle,
 {
 	struct acpi_device *device = context;
 	struct acpi_device *sibling;
-	int result;
 
 	if (handle == device->handle)
 		return AE_CTRL_TERMINATE;
 
-	result = acpi_bus_get_device(handle, &sibling);
-	if (result)
+	sibling = acpi_fetch_acpi_dev(handle);
+	if (!sibling)
 		return AE_OK;
 
 	if (!strcmp(acpi_device_name(sibling), ACPI_VIDEO_BUS_NAME))
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -285,14 +285,12 @@ EXPORT_SYMBOL(acpi_device_set_power);
 
 int acpi_bus_set_power(acpi_handle handle, int state)
 {
-	struct acpi_device *device;
-	int result;
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 
-	result = acpi_bus_get_device(handle, &device);
-	if (result)
-		return result;
+	if (device)
+		return acpi_device_set_power(device, state);
 
-	return acpi_device_set_power(device, state);
+	return -ENODEV;
 }
 EXPORT_SYMBOL(acpi_bus_set_power);
 
@@ -410,21 +408,20 @@ EXPORT_SYMBOL_GPL(acpi_device_update_pow
 
 int acpi_bus_update_power(acpi_handle handle, int *state_p)
 {
-	struct acpi_device *device;
-	int result;
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 
-	result = acpi_bus_get_device(handle, &device);
-	return result ? result : acpi_device_update_power(device, state_p);
+	if (device)
+		return acpi_device_update_power(device, state_p);
+
+	return -ENODEV;
 }
 EXPORT_SYMBOL_GPL(acpi_bus_update_power);
 
 bool acpi_bus_power_manageable(acpi_handle handle)
 {
-	struct acpi_device *device;
-	int result;
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 
-	result = acpi_bus_get_device(handle, &device);
-	return result ? false : device->flags.power_manageable;
+	return device && device->flags.power_manageable;
 }
 EXPORT_SYMBOL(acpi_bus_power_manageable);
 
@@ -543,11 +540,9 @@ acpi_status acpi_remove_pm_notifier(stru
 
 bool acpi_bus_can_wakeup(acpi_handle handle)
 {
-	struct acpi_device *device;
-	int result;
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 
-	result = acpi_bus_get_device(handle, &device);
-	return result ? false : device->wakeup.flags.valid;
+	return device && device->wakeup.flags.valid;
 }
 EXPORT_SYMBOL(acpi_bus_can_wakeup);
 
Index: linux-pm/drivers/acpi/dock.c
===================================================================
--- linux-pm.orig/drivers/acpi/dock.c
+++ linux-pm/drivers/acpi/dock.c
@@ -489,9 +489,8 @@ static ssize_t docked_show(struct device
 			   struct device_attribute *attr, char *buf)
 {
 	struct dock_station *dock_station = dev->platform_data;
-	struct acpi_device *adev = NULL;
+	struct acpi_device *adev = acpi_fetch_acpi_dev(dock_station->handle);
 
-	acpi_bus_get_device(dock_station->handle, &adev);
 	return sysfs_emit(buf, "%u\n", acpi_device_enumerated(adev));
 }
 static DEVICE_ATTR_RO(docked);
Index: linux-pm/drivers/acpi/pci_link.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_link.c
+++ linux-pm/drivers/acpi/pci_link.c
@@ -606,12 +606,10 @@ static int acpi_pci_link_allocate(struct
 int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
 			       int *polarity, char **name)
 {
-	int result;
-	struct acpi_device *device;
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 	struct acpi_pci_link *link;
 
-	result = acpi_bus_get_device(handle, &device);
-	if (result) {
+	if (!device) {
 		acpi_handle_err(handle, "Invalid link device\n");
 		return -1;
 	}
@@ -658,12 +656,10 @@ int acpi_pci_link_allocate_irq(acpi_hand
  */
 int acpi_pci_link_free_irq(acpi_handle handle)
 {
-	struct acpi_device *device;
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 	struct acpi_pci_link *link;
-	acpi_status result;
 
-	result = acpi_bus_get_device(handle, &device);
-	if (result) {
+	if (!device) {
 		acpi_handle_err(handle, "Invalid link device\n");
 		return -1;
 	}
Index: linux-pm/drivers/acpi/pci_root.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_root.c
+++ linux-pm/drivers/acpi/pci_root.c
@@ -67,11 +67,10 @@ static struct acpi_scan_handler pci_root
  */
 int acpi_is_root_bridge(acpi_handle handle)
 {
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 	int ret;
-	struct acpi_device *device;
 
-	ret = acpi_bus_get_device(handle, &device);
-	if (ret)
+	if (!device)
 		return 0;
 
 	ret = acpi_match_device_ids(device, root_device_ids);
@@ -215,11 +214,10 @@ static acpi_status acpi_pci_query_osc(st
 
 struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
 {
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 	struct acpi_pci_root *root;
-	struct acpi_device *device;
 
-	if (acpi_bus_get_device(handle, &device) ||
-	    acpi_match_device_ids(device, root_device_ids))
+	if (!device || acpi_match_device_ids(device, root_device_ids))
 		return NULL;
 
 	root = acpi_driver_data(device);
Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -81,9 +81,9 @@ struct acpi_power_resource *to_power_res
 
 static struct acpi_power_resource *acpi_power_get_context(acpi_handle handle)
 {
-	struct acpi_device *device;
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 
-	if (acpi_bus_get_device(handle, &device))
+	if (!device)
 		return NULL;
 
 	return to_power_resource(device);
@@ -928,15 +928,14 @@ static void acpi_power_add_resource_to_l
 
 struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 {
+	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 	struct acpi_power_resource *resource;
-	struct acpi_device *device = NULL;
 	union acpi_object acpi_object;
 	struct acpi_buffer buffer = { sizeof(acpi_object), &acpi_object };
 	acpi_status status;
 	u8 state_dummy;
 	int result;
 
-	acpi_bus_get_device(handle, &device);
 	if (device)
 		return device;
 
Index: linux-pm/drivers/acpi/processor_driver.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_driver.c
+++ linux-pm/drivers/acpi/processor_driver.c
@@ -98,8 +98,13 @@ static int acpi_soft_cpu_online(unsigned
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 	struct acpi_device *device;
 
-	if (!pr || acpi_bus_get_device(pr->handle, &device))
+	if (!pr)
 		return 0;
+
+	device = acpi_fetch_acpi_dev(pr->handle);
+	if (!device)
+		return 0;
+
 	/*
 	 * CPU got physically hotplugged and onlined for the first time:
 	 * Initialize missing things.
@@ -125,9 +130,8 @@ static int acpi_soft_cpu_online(unsigned
 static int acpi_soft_cpu_dead(unsigned int cpu)
 {
 	struct acpi_processor *pr = per_cpu(processors, cpu);
-	struct acpi_device *device;
 
-	if (!pr || acpi_bus_get_device(pr->handle, &device))
+	if (!pr || !acpi_fetch_acpi_dev(pr->handle))
 		return 0;
 
 	acpi_processor_reevaluate_tstate(pr, true);
Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -1099,7 +1099,7 @@ static int acpi_processor_get_lpi_info(s
 
 	status = acpi_get_parent(handle, &pr_ahandle);
 	while (ACPI_SUCCESS(status)) {
-		acpi_bus_get_device(pr_ahandle, &d);
+		d = acpi_fetch_acpi_dev(pr_ahandle);
 		handle = pr_ahandle;
 
 		if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -687,9 +687,9 @@ int __acpi_node_get_property_reference(c
 		if (index)
 			return -EINVAL;
 
-		ret = acpi_bus_get_device(obj->reference.handle, &device);
-		if (ret)
-			return ret == -ENODEV ? -EINVAL : ret;
+		device = acpi_fetch_acpi_dev(obj->reference.handle);
+		if (!device)
+			return -EINVAL;
 
 		args->fwnode = acpi_fwnode_handle(device);
 		args->nargs = 0;
@@ -719,9 +719,8 @@ int __acpi_node_get_property_reference(c
 		if (element->type == ACPI_TYPE_LOCAL_REFERENCE) {
 			struct fwnode_handle *ref_fwnode;
 
-			ret = acpi_bus_get_device(element->reference.handle,
-						  &device);
-			if (ret)
+			device = acpi_fetch_acpi_dev(element->reference.handle);
+			if (!device)
 				return -EINVAL;
 
 			nargs = 0;
Index: linux-pm/drivers/acpi/resource.c
===================================================================
--- linux-pm.orig/drivers/acpi/resource.c
+++ linux-pm/drivers/acpi/resource.c
@@ -791,9 +791,9 @@ static acpi_status acpi_res_consumer_cb(
 {
 	struct resource *res = context;
 	struct acpi_device **consumer = (struct acpi_device **) ret;
-	struct acpi_device *adev;
+	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
 
-	if (acpi_bus_get_device(handle, &adev))
+	if (!adev)
 		return AE_OK;
 
 	if (acpi_dev_consumes_res(adev, res)) {
Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -697,7 +697,6 @@ static int acpi_thermal_cooling_device_c
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_thermal *tz = thermal->devdata;
 	struct acpi_device *dev;
-	acpi_status status;
 	acpi_handle handle;
 	int i;
 	int j;
@@ -715,8 +714,8 @@ static int acpi_thermal_cooling_device_c
 		for (i = 0; i < tz->trips.passive.devices.count;
 		    i++) {
 			handle = tz->trips.passive.devices.handles[i];
-			status = acpi_bus_get_device(handle, &dev);
-			if (ACPI_FAILURE(status) || dev != device)
+			dev = acpi_fetch_acpi_dev(handle);
+			if (dev != device)
 				continue;
 			if (bind)
 				result =
@@ -741,8 +740,8 @@ static int acpi_thermal_cooling_device_c
 		    j < tz->trips.active[i].devices.count;
 		    j++) {
 			handle = tz->trips.active[i].devices.handles[j];
-			status = acpi_bus_get_device(handle, &dev);
-			if (ACPI_FAILURE(status) || dev != device)
+			dev = acpi_fetch_acpi_dev(handle);
+			if (dev != device)
 				continue;
 			if (bind)
 				result = thermal_zone_bind_cooling_device
Index: linux-pm/drivers/acpi/video_detect.c
===================================================================
--- linux-pm.orig/drivers/acpi/video_detect.c
+++ linux-pm/drivers/acpi/video_detect.c
@@ -59,18 +59,16 @@ static void acpi_video_parse_cmdline(voi
 static acpi_status
 find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
+	struct acpi_device *acpi_dev = acpi_fetch_acpi_dev(handle);
 	long *cap = context;
 	struct pci_dev *dev;
-	struct acpi_device *acpi_dev;
 
 	static const struct acpi_device_id video_ids[] = {
 		{ACPI_VIDEO_HID, 0},
 		{"", 0},
 	};
-	if (acpi_bus_get_device(handle, &acpi_dev))
-		return AE_OK;
 
-	if (!acpi_match_device_ids(acpi_dev, video_ids)) {
+	if (acpi_dev && !acpi_match_device_ids(acpi_dev, video_ids)) {
 		dev = acpi_get_pci_dev(handle);
 		if (!dev)
 			return AE_OK;
Index: linux-pm/drivers/acpi/x86/s2idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/x86/s2idle.c
+++ linux-pm/drivers/acpi/x86/s2idle.c
@@ -293,9 +293,9 @@ static void lpi_check_constraints(void)
 
 	for (i = 0; i < lpi_constraints_table_size; ++i) {
 		acpi_handle handle = lpi_constraints_table[i].handle;
-		struct acpi_device *adev;
+		struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
 
-		if (!handle || acpi_bus_get_device(handle, &adev))
+		if (!adev)
 			continue;
 
 		acpi_handle_debug(handle,



