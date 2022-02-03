Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E23C4A86DD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351380AbiBCOqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:46:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:37909 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351337AbiBCOqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643899609; x=1675435609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xmPUnvWYY95aUtqvJ3oWJMhLqj0UrqBApxDxiNKGOl8=;
  b=KlgT7AIt7D4f7X/JVVLoTClqLXjDU/0dVV5seQvJ26WKXaGxaqO8rpGv
   zPzPZIOcImA7/VLe3cXDuRtNPAUABgJ0QCHoSWN3T808PMRFIefxqeheE
   Yz5giP1gyfJUIFI/lm2NxsPcKQ1C9uW+TNp41GLoAQy7+gG6p1R5EtXaq
   BHIj/uqCVO0vkhIn6okScxt94QTv67YGHh+1y/aTQC4/KeNO0bfGhcYPQ
   0ra0kZaYAT2yZ0IlF/N3AwF//q3GrUwjcYbK68wrH0+mMBH8npJLx0A4A
   AtrwoyQqJ1zFo/7okOzPDCcPMH63+gA3ZkQ+c7bZ8bjxP0wjlbIlFaJIA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308883006"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="308883006"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:46:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="676788147"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2022 06:46:45 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] usb: typec: Separate USB Power Delivery from USB Type-C
Date:   Thu,  3 Feb 2022 17:46:55 +0300
Message-Id: <20220203144657.16527-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203144657.16527-1-heikki.krogerus@linux.intel.com>
References: <20220203144657.16527-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing a separate sysfs directory "usb_power_delivery"
for the devices. This directory should be used to expose all
the USB Power Delivery (USB PD) objects and other details a
device supports from now on.

Initially only USB Type-C devices can expose their USB Power
Delivery capabilities, but later any device attached to the
USB bus may potentially be able to expose them too. That is
already possible with devices that support the USB Type-C
Bridge standard. The API that is introduced here that can be
used to register the USB PD support does not depend on USB
Type-C devices, but it is made part of USB Type-C Connector
Class for now.

First adding support for registration of the Power Data
Objects (PDO) that are part of the Source_Capabilities and
Sink_Capabilities Messages. The content of the Request
Message will likely follow soon.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 .../testing/sysfs-devices-usb_power_delivery  | 273 ++++++++
 drivers/usb/typec/Makefile                    |   2 +-
 drivers/usb/typec/pd.c                        | 651 ++++++++++++++++++
 drivers/usb/typec/pd.h                        |  39 ++
 include/linux/usb/pd.h                        |  30 +
 include/linux/usb/typec.h                     |  10 +
 6 files changed, 1004 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-usb_power_delivery
 create mode 100644 drivers/usb/typec/pd.c
 create mode 100644 drivers/usb/typec/pd.h

diff --git a/Documentation/ABI/testing/sysfs-devices-usb_power_delivery b/Documentation/ABI/testing/sysfs-devices-usb_power_delivery
new file mode 100644
index 0000000000000..10b005e8e315a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-usb_power_delivery
@@ -0,0 +1,273 @@
+What:		/sys/devices/.../usb_power_delivery
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory containing details about the USB Power Delivery
+		support of given device.
+
+		When representing the USB Power Delivery Messages, if the
+		message can contain multiple objects (like the capabilities
+		messages - Source_Capabilities and Sink_Capabilities), each
+		message will have its own sub-directory and that sub-directory
+		will then have a separate folder for each object.
+
+			usb_power_delivery/<message>/<object>/<attributes>
+
+		Otherwise the sub-directory will be for the object itself (for
+		example the Battery Status Message can only contain a single
+		Battery Status Data Object).
+
+			usb_power_delivery/<object>/<attributes>
+
+What:		/sys/devices/.../usb_power_delivery/revision
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		File showing the USB Power Delivery Specification Revision used
+		in communication.
+
+What:		/sys/devices/.../usb_power_delivery/version
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This is an optional attribute file showing the version of the
+		specific revision of the USB Power Delivery Specification that
+		the device supports. In most cases the specification version is
+		not known and the file is not available.
+
+What:		/sys/devices/.../usb_power_delivery/source_capabilities<index>
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory containing the source capabilities for a given USB
+		Power Delivery capable device. Ports on a system can have
+		multiple sets of source capabilities defined for them. The first
+		directory is always named "source_capabilities" (index 0), but
+		starting from the second capabilities set the index number is
+		added to the directory name ("source_capabilities",
+		"source-capabillities1", ...).
+
+		The source capabilities message "Source_Capabilities" contains a
+		set of Power Data Objects (PDO), each representing a type of
+		power supply the device supports. The order of the PDO objects
+		is defined in USB Power Delivery Specification. Each object in
+		this directory will have the object position number as the first
+		character followed by the object type name (":" as delimiter).
+
+			/sys/devices/.../usb_power_delivery/<capability>/<position>:<type>
+
+What:		/sys/devices/.../usb_power_delivery/sink_capabilities<index>
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory containing the sink capabilities of a given USB Power
+		Delivery capable device. Ports on a system can have multiple
+		sets of sink capabilities defined for them. The first directory
+		is always named "sink_capabilities" (index 0), but starting from
+		the second set the index number is added to the directory name
+		("sink_capabilities", "sink_capabilities1", ...).
+
+		The sink capability message "Sink_Capabilities" contains a set
+		of Power Data Objects (PDO) just like with source capabilities,
+		but instead of describing the power capabilities, these objects
+		describe the power requirements the device has for each type of
+		object.
+
+		The order of the objects in the sink capability message is the
+		same as it's in the source capabilities message.
+
+Fixed Supply Data Objects
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/<position>:fixed_supply
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory containing the attributes (the bit fields) defined for
+		Fixed Supply PDO.
+
+		The directory "1:fixed_supply" is special. USB Power Delivery
+		Specification dictates that the first PDO (at object position
+		1), and the only mandatory PDO, is always the vSafe5V Fixed
+		Supply Object. vSafe5V Object has additional fields defined for
+		it that the other Fixed Supply Objects do not have and that are
+		related to the USB capabilities rather than power capabilities.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/1:fixed_supply/dual_role_power
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file contains boolean value that tells does the device
+		support both source and sink power roles.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/1:fixed_supply/usb_suspend_supported
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file shows the value of the USB Suspend Supported bit in
+		vSafe5V Fixed Supply Object. If the bit is set then the device
+		will follow the USB 2.0 and USB 3.2 rules for suspend and
+		resume.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/1:fixed_supply/unconstrained_power
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file shows the value of the Unconstrained Power bit in
+		vSafe5V Fixed Supply Object. The bit is set when an external
+		source of power, powerful enough to power the entire system on
+		its own, is available for the device.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/1:fixed_supply/usb_communication_capable
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file shows the value of the USB Communication Capable bit in
+		vSafe5V Fixed Supply Object.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/1:fixed_supply/dual_role_data
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file shows the value of the Dual-Role Data bit in vSafe5V
+		Fixed Supply Object. Dual role data means ability act as both
+		USB host and USB device.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/1:fixed_supply/unchunked_extended_messages_supported
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file shows the value of the Unchunked Extended Messages
+		Supported bit in vSafe5V Fixed Supply Object.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/<position>:fixed_supply/voltage
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		The voltage the supply supports in millivolts.
+
+What:		/sys/devices/.../usb_power_delivery/source_capabilities/<position>:fixed_supply/maximum_current
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Maximum current of the fixed source supply in milliamperes.
+
+What:		/sys/devices/.../usb_power_delivery/sink_capabilities/<position>:fixed_supply/operational_current
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Operational current of the sink in milliamperes.
+
+What:		/sys/devices/.../usb_power_delivery/sink_capabilities/<position>:fixed_supply/fast_role_swap_current
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file contains the value of the "Fast Role Swap USB Type-C
+		Current" field that tells the current level the sink requires
+		after a Fast Role Swap.
+		0 - Fast Swap not supported"
+		1 - Default USB Power"
+		2 - 1.5A@5V"
+		3 - 3.0A@5V"
+
+Variable Supply Data Objects
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/<position>:variable_supply
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory containing the attributes (the bit fields) defined for
+		Variable Supply PDO.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/<position>:variable_supply/maximum_voltage
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Maximum Voltage in millivolts.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/<position>:variable_supply/minimum_voltage
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Minimum Voltage in millivolts.
+
+What:		/sys/devices/.../usb_power_delivery/source_capabilities/<position>:variable_supply/maximum_current
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		The maximum current in milliamperes that the source can supply
+		at the given Voltage range.
+
+What:		/sys/devices/.../usb_power_delivery/sink_capabilities/<position>:variable_supply/operational_current
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		The operational current in milliamperes that the sink requires
+		at the given Voltage range.
+
+Battery Supply Data Objects
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/<position>:battery
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory containing the attributes (the bit fields) defined for
+		Battery PDO.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/<position>:battery/maximum_voltage
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Maximum Voltage in millivolts.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/<position>:battery/minimum_voltage
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Minimum Voltage in millivolts.
+
+What:		/sys/devices/.../usb_power_delivery/source_capabilities/<position>:battery/maximum_power
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Maximum allowable Power in milliwatts.
+
+What:		/sys/devices/.../usb_power_delivery/sink_capabilities/<position>:battery/operational_power
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		The operational power that the sink requires at the given
+		voltage range.
+
+Standard Power Range (SPR) Programmable Power Supply Objects
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/<position>:programmable_supply
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory containing the attributes (the bit fields) defined for
+		Programmable Power Supply (PPS) Augmented PDO (APDO).
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/<position>:programmable_supply/maximum_voltage
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Maximum Voltage in millivolts.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/<position>:programmable_supply/minimum_voltage
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Minimum Voltage in millivolts.
+
+What:		/sys/devices/.../usb_power_delivery/<capability>/<position>:programmable_supply/maximum_current
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Maximum Current in milliamperes.
+
+What:		/sys/devices/.../usb_power_delivery/source_capabilities/<position>:programmable_supply/pps_power_limited
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		The PPS Power Limited bit indicates whether or not the source
+		supply will exceed the rated output power if requested.
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 57870a2bd7873..4b71a1f5c7e87 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TYPEC)		+= typec.o
-typec-y				:= class.o mux.o bus.o
+typec-y				:= class.o mux.o bus.o pd.o
 typec-$(CONFIG_ACPI)		+= port-mapper.o
 obj-$(CONFIG_TYPEC)		+= altmodes/
 obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
new file mode 100644
index 0000000000000..b2f0d677a6bce
--- /dev/null
+++ b/drivers/usb/typec/pd.c
@@ -0,0 +1,651 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USB Power Delivery sysfs entries
+ *
+ * Copyright (C) 2022, Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/usb/pd.h>
+
+#include "pd.h"
+
+#define to_pdo(o) container_of(o, struct pdo, kobj)
+
+struct pdo {
+	struct kobject kobj;
+	int object_position;
+	u32 pdo;
+	struct list_head node;
+};
+
+static void pdo_release(struct kobject *kobj)
+{
+	kfree(to_pdo(kobj));
+}
+
+/* -------------------------------------------------------------------------- */
+/* Fixed Supply */
+
+static ssize_t
+dual_role_power_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", !!(to_pdo(kobj)->pdo & PDO_FIXED_DUAL_ROLE));
+}
+
+static ssize_t
+usb_suspend_supported_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", !!(to_pdo(kobj)->pdo & PDO_FIXED_SUSPEND));
+}
+
+static ssize_t
+unconstrained_power_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", !!(to_pdo(kobj)->pdo & PDO_FIXED_EXTPOWER));
+}
+
+static ssize_t
+usb_communication_capable_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", !!(to_pdo(kobj)->pdo & PDO_FIXED_USB_COMM));
+}
+
+static ssize_t
+dual_role_data_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", !!(to_pdo(kobj)->pdo & PDO_FIXED_DATA_SWAP));
+}
+
+static ssize_t
+unchunked_extended_messages_supported_show(struct kobject *kobj,
+					   struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", !!(to_pdo(kobj)->pdo & PDO_FIXED_UNCHUNK_EXT));
+}
+
+/*
+ * REVISIT: Peak Current requires access also to the RDO.
+static ssize_t
+peak_current_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	...
+}
+*/
+
+static ssize_t
+fast_role_swap_current_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", to_pdo(kobj)->pdo >> PDO_FIXED_FRS_CURR_SHIFT) & 3;
+}
+
+static ssize_t
+voltage_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%umV\n", pdo_fixed_voltage(to_pdo(kobj)->pdo));
+}
+
+/* Shared with Variable supplies, both source and sink */
+static ssize_t current_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%umA\n", pdo_max_current(to_pdo(kobj)->pdo));
+}
+
+/* These additional details are only available with vSafe5V supplies */
+static struct kobj_attribute dual_role_power_attr = __ATTR_RO(dual_role_power);
+static struct kobj_attribute usb_suspend_supported_attr = __ATTR_RO(usb_suspend_supported);
+static struct kobj_attribute unconstrained_power_attr = __ATTR_RO(unconstrained_power);
+static struct kobj_attribute usb_communication_capable_attr = __ATTR_RO(usb_communication_capable);
+static struct kobj_attribute dual_role_data_attr = __ATTR_RO(dual_role_data);
+static struct kobj_attribute
+unchunked_extended_messages_supported_attr = __ATTR_RO(unchunked_extended_messages_supported);
+
+/* Visible on all Fixed type source supplies */
+/*static struct kobj_attribute peak_current_attr = __ATTR_RO(peak_current);*/
+/* Visible on Fixed type sink supplies */
+static struct kobj_attribute fast_role_swap_current_attr = __ATTR_RO(fast_role_swap_current);
+
+/* Shared with Variable type supplies */
+static struct kobj_attribute maximum_current_attr = {
+	.attr = {
+		.name = "maximum_current",
+		.mode = 0444,
+	},
+	.show = current_show,
+};
+
+static struct kobj_attribute operational_current_attr = {
+	.attr = {
+		.name = "operational_current",
+		.mode = 0444,
+	},
+	.show = current_show,
+};
+
+/* Visible on all Fixed type supplies */
+static struct kobj_attribute voltage_attr = __ATTR_RO(voltage);
+
+static struct attribute *source_fixed_supply_attrs[] = {
+	&dual_role_power_attr.attr,
+	&usb_suspend_supported_attr.attr,
+	&unconstrained_power_attr.attr,
+	&usb_communication_capable_attr.attr,
+	&dual_role_data_attr.attr,
+	&unchunked_extended_messages_supported_attr.attr,
+	/*&peak_current_attr.attr,*/
+	&voltage_attr.attr,
+	&maximum_current_attr.attr,
+	NULL
+};
+
+static umode_t fixed_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	if (to_pdo(kobj)->object_position &&
+	    /*attr != &peak_current_attr.attr &&*/
+	    attr != &voltage_attr.attr &&
+	    attr != &maximum_current_attr.attr &&
+	    attr != &operational_current_attr.attr)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group source_fixed_supply_group = {
+	.is_visible = fixed_attr_is_visible,
+	.attrs = source_fixed_supply_attrs,
+};
+__ATTRIBUTE_GROUPS(source_fixed_supply);
+
+static struct kobj_type source_fixed_supply_type = {
+	.release = pdo_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = source_fixed_supply_groups,
+};
+
+static struct attribute *sink_fixed_supply_attrs[] = {
+	&dual_role_power_attr.attr,
+	&usb_suspend_supported_attr.attr,
+	&unconstrained_power_attr.attr,
+	&usb_communication_capable_attr.attr,
+	&dual_role_data_attr.attr,
+	&unchunked_extended_messages_supported_attr.attr,
+	&fast_role_swap_current_attr.attr,
+	&voltage_attr.attr,
+	&operational_current_attr.attr,
+	NULL
+};
+
+static const struct attribute_group sink_fixed_supply_group = {
+	.is_visible = fixed_attr_is_visible,
+	.attrs = sink_fixed_supply_attrs,
+};
+__ATTRIBUTE_GROUPS(sink_fixed_supply);
+
+static struct kobj_type sink_fixed_supply_type = {
+	.release = pdo_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = sink_fixed_supply_groups,
+};
+
+/* -------------------------------------------------------------------------- */
+/* Variable Supply */
+
+static ssize_t
+maximum_voltage_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%umV\n", pdo_max_voltage(to_pdo(kobj)->pdo));
+}
+
+static ssize_t
+minimum_voltage_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%umV\n", pdo_min_voltage(to_pdo(kobj)->pdo));
+}
+
+/* Shared with Battery */
+static struct kobj_attribute maximum_voltage_attr = __ATTR_RO(maximum_voltage);
+static struct kobj_attribute minimum_voltage_attr = __ATTR_RO(minimum_voltage);
+
+static struct attribute *source_variable_supply_attrs[] = {
+	&maximum_voltage_attr.attr,
+	&minimum_voltage_attr.attr,
+	&maximum_current_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(source_variable_supply);
+
+static struct kobj_type source_variable_supply_type = {
+	.release = pdo_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = source_variable_supply_groups,
+};
+
+static struct attribute *sink_variable_supply_attrs[] = {
+	&maximum_voltage_attr.attr,
+	&minimum_voltage_attr.attr,
+	&operational_current_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(sink_variable_supply);
+
+static struct kobj_type sink_variable_supply_type = {
+	.release = pdo_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = sink_variable_supply_groups,
+};
+
+/* -------------------------------------------------------------------------- */
+/* Battery */
+
+static ssize_t
+maximum_power_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%umW\n", pdo_max_power(to_pdo(kobj)->pdo));
+}
+
+static ssize_t
+operational_power_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%umW\n", pdo_max_power(to_pdo(kobj)->pdo));
+}
+
+static struct kobj_attribute maximum_power_attr = __ATTR_RO(maximum_power);
+static struct kobj_attribute operational_power_attr = __ATTR_RO(operational_power);
+
+static struct attribute *source_battery_attrs[] = {
+	&maximum_voltage_attr.attr,
+	&minimum_voltage_attr.attr,
+	&maximum_power_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(source_battery);
+
+static struct kobj_type source_battery_type = {
+	.release = pdo_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = source_battery_groups,
+};
+
+static struct attribute *sink_battery_attrs[] = {
+	&maximum_voltage_attr.attr,
+	&minimum_voltage_attr.attr,
+	&operational_power_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(sink_battery);
+
+static struct kobj_type sink_battery_type = {
+	.release = pdo_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = sink_battery_groups,
+};
+
+/* -------------------------------------------------------------------------- */
+/* Standard Power Range (SPR) Programmable Power Supply (PPS) */
+
+static ssize_t
+pps_power_limited_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", !!(to_pdo(kobj)->pdo & BIT(27)));
+}
+
+static ssize_t
+pps_max_voltage_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%umV\n", pdo_pps_apdo_max_voltage(to_pdo(kobj)->pdo));
+}
+
+static ssize_t
+pps_min_voltage_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%umV\n", pdo_pps_apdo_min_voltage(to_pdo(kobj)->pdo));
+}
+
+static ssize_t
+pps_max_current_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%umA\n", pdo_pps_apdo_max_current(to_pdo(kobj)->pdo));
+}
+
+static struct kobj_attribute pps_power_limited_attr = __ATTR_RO(pps_power_limited);
+
+static struct kobj_attribute pps_max_voltage_attr = {
+	.attr = {
+		.name = "maximum_voltage",
+		.mode = 0444,
+	},
+	.show = pps_max_voltage_show,
+};
+
+static struct kobj_attribute pps_min_voltage_attr = {
+	.attr = {
+		.name = "minimum_voltage",
+		.mode = 0444,
+	},
+	.show = pps_min_voltage_show,
+};
+
+static struct kobj_attribute pps_max_current_attr = {
+	.attr = {
+		.name = "maximum_current",
+		.mode = 0444,
+	},
+	.show = pps_max_current_show,
+};
+
+static struct attribute *source_pps_attrs[] = {
+	&pps_power_limited_attr.attr,
+	&pps_max_voltage_attr.attr,
+	&pps_min_voltage_attr.attr,
+	&pps_max_current_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(source_pps);
+
+static struct kobj_type source_pps_type = {
+	.release = pdo_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = source_pps_groups,
+};
+
+static struct attribute *sink_pps_attrs[] = {
+	&pps_max_voltage_attr.attr,
+	&pps_min_voltage_attr.attr,
+	&pps_max_current_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(sink_pps);
+
+static struct kobj_type sink_pps_type = {
+	.release = pdo_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = sink_pps_groups,
+};
+
+/* -------------------------------------------------------------------------- */
+
+static const char * const supply_name[] = {
+	[PDO_TYPE_FIXED] = "fixed_supply",
+	[PDO_TYPE_BATT]  = "battery",
+	[PDO_TYPE_VAR]	 = "variable_supply",
+};
+
+static const char * const apdo_supply_name[] = {
+	[APDO_TYPE_PPS]  = "programmable_supply",
+};
+
+static struct kobj_type *source_type[] = {
+	[PDO_TYPE_FIXED] = &source_fixed_supply_type,
+	[PDO_TYPE_BATT]  = &source_battery_type,
+	[PDO_TYPE_VAR]   = &source_variable_supply_type,
+};
+
+static struct kobj_type *source_apdo_type[] = {
+	[APDO_TYPE_PPS]  = &source_pps_type,
+};
+
+static struct kobj_type *sink_type[] = {
+	[PDO_TYPE_FIXED] = &sink_fixed_supply_type,
+	[PDO_TYPE_BATT]  = &sink_battery_type,
+	[PDO_TYPE_VAR]   = &sink_variable_supply_type,
+};
+
+static struct kobj_type *sink_apdo_type[] = {
+	[APDO_TYPE_PPS]  = &sink_pps_type,
+};
+
+/* REVISIT: Export when EPR_*_Capabilities need to be supported. */
+static int add_pdo(struct pd_capabilities *cap, u32 pdo, int position)
+{
+	struct kobj_type *type;
+	const char *name;
+	struct pdo *p;
+	int ret;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	p->pdo = pdo;
+	p->object_position = position;
+
+	if (pdo_type(pdo) == PDO_TYPE_APDO) {
+		/* FIXME: Only PPS supported for now! Skipping others. */
+		if (pdo_apdo_type(pdo) > APDO_TYPE_PPS) {
+			dev_warn(kobj_to_dev(cap->kobj.parent->parent),
+				 "%s: Unknown APDO type. PDO 0x%08x\n",
+				 kobject_name(&cap->kobj), pdo);
+			kfree(p);
+			return 0;
+		}
+
+		if (is_source(cap->role))
+			type = source_apdo_type[pdo_apdo_type(pdo)];
+		else
+			type = sink_apdo_type[pdo_apdo_type(pdo)];
+
+		name = apdo_supply_name[pdo_apdo_type(pdo)];
+	} else {
+		if (is_source(cap->role))
+			type = source_type[pdo_type(pdo)];
+		else
+			type = sink_type[pdo_type(pdo)];
+
+		name = supply_name[pdo_type(pdo)];
+	}
+
+	ret = kobject_init_and_add(&p->kobj, type, &cap->kobj, "%u:%s", position + 1, name);
+	if (ret) {
+		kobject_put(&p->kobj);
+		return ret;
+	}
+
+	list_add_tail(&p->node, &cap->pdos);
+
+	return 0;
+}
+
+/* -------------------------------------------------------------------------- */
+
+static const char * const cap_name[] = {
+	[TYPEC_SINK]    = "sink_capabilities",
+	[TYPEC_SOURCE]  = "source_capabilities",
+};
+
+static void pd_capabilities_release(struct kobject *kobj)
+{
+	struct pd_capabilities *cap = to_pd_capabilities(kobj);
+
+	if (is_source(cap->role))
+		ida_simple_remove(&cap->pd->source_cap_ids, cap->id);
+	else
+		ida_simple_remove(&cap->pd->sink_cap_ids, cap->id);
+
+	kfree(cap);
+}
+
+static struct kobj_type pd_capabilities_type = {
+	.release = pd_capabilities_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+/**
+ * pd_register_capabilities - Register a set of capabilities
+ * @pd: The USB PD instance that the capabilities belong to
+ * @desc: Description of the capablities message
+ *
+ * This function registers a Capability Message described in @desc. The
+ * capabilities will have their own sub-directory under @pd in sysfs. @pd can
+ * have multiple sets of capabilities defined for it.
+ *
+ * The function returns pointer to struct pd_capabilities, or ERR_PRT(errno).
+ */
+struct pd_capabilities *pd_register_capabilities(struct pd *pd, struct pd_caps_desc *desc)
+{
+	struct pd_capabilities *cap;
+	struct pdo *pdo, *tmp;
+	int ret;
+	int i;
+
+	cap = kzalloc(sizeof(*cap), GFP_KERNEL);
+	if (!cap)
+		return ERR_PTR(-ENOMEM);
+
+	ret = ida_simple_get(is_source(desc->role) ? &pd->source_cap_ids :
+			     &pd->sink_cap_ids, 0, 0, GFP_KERNEL);
+	if (ret < 0) {
+		kfree(cap);
+		return ERR_PTR(ret);
+	}
+
+	cap->id = ret;
+	cap->pd = pd;
+	cap->role = desc->role;
+	INIT_LIST_HEAD(&cap->pdos);
+
+	if (cap->id)
+		ret = kobject_init_and_add(&cap->kobj, &pd_capabilities_type, &pd->kobj,
+					   "%s%u", cap_name[cap->role], cap->id);
+	else
+		ret = kobject_init_and_add(&cap->kobj, &pd_capabilities_type, &pd->kobj,
+					   "%s", cap_name[cap->role]);
+	if (ret)
+		goto err_remove_capability;
+
+	for (i = 0; i < PDO_MAX_OBJECTS && desc->pdo[i]; i++) {
+		ret = add_pdo(cap, desc->pdo[i], i);
+		if (ret)
+			goto err_remove_pdos;
+	}
+
+	if (is_source(cap->role))
+		list_add_tail(&cap->node, &pd->source_capabilities);
+	else
+		list_add_tail(&cap->node, &pd->sink_capabilities);
+
+	return cap;
+
+err_remove_pdos:
+	list_for_each_entry_safe(pdo, tmp, &cap->pdos, node) {
+		list_del(&pdo->node);
+		kobject_put(&pdo->kobj);
+	}
+
+err_remove_capability:
+	kobject_put(&cap->kobj);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(pd_register_capabilities);
+
+/**
+ * pd_unregister_capabilities - Unregister a set of capabilities
+ * @cap: The capabilities
+ */
+void pd_unregister_capabilities(struct pd_capabilities *cap)
+{
+	struct pdo *pdo, *tmp;
+
+	if (!cap)
+		return;
+
+	list_for_each_entry_safe(pdo, tmp, &cap->pdos, node) {
+		list_del(&pdo->node);
+		kobject_put(&pdo->kobj);
+	}
+
+	list_del(&cap->node);
+	kobject_put(&cap->kobj);
+}
+EXPORT_SYMBOL_GPL(pd_unregister_capabilities);
+
+/* -------------------------------------------------------------------------- */
+
+static ssize_t revision_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct pd *pd = to_pd(kobj);
+
+	return sysfs_emit(buf, "%u.%u\n", (pd->revision >> 8) & 0xff, (pd->revision >> 4) & 0xf);
+}
+
+static ssize_t version_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct pd *pd = to_pd(kobj);
+
+	return sysfs_emit(buf, "%u.%u\n", (pd->version >> 8) & 0xff, (pd->version >> 4) & 0xf);
+}
+
+static struct kobj_attribute revision_attr = __ATTR_RO(revision);
+static struct kobj_attribute version_attr = __ATTR_RO(version);
+
+static struct attribute *pd_attrs[] = {
+	&revision_attr.attr,
+	&version_attr.attr,
+	NULL
+};
+
+static umode_t pd_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct pd *pd = to_pd(kobj);
+
+	if (attr == &version_attr.attr && !pd->version)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group pd_group = {
+	.is_visible = pd_attr_is_visible,
+	.attrs = pd_attrs,
+};
+__ATTRIBUTE_GROUPS(pd);
+
+static void pd_release(struct kobject *kobj)
+{
+	struct pd *pd = to_pd(kobj);
+
+	ida_destroy(&pd->source_cap_ids);
+	ida_destroy(&pd->sink_cap_ids);
+	put_device(pd->dev);
+	kfree(pd);
+}
+
+static struct kobj_type pd_type = {
+	.release = pd_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = pd_groups,
+};
+
+struct pd *pd_register(struct device *dev, struct pd_desc *desc)
+{
+	struct pd *pd;
+	int ret;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return ERR_PTR(-ENOMEM);
+
+	ida_init(&pd->sink_cap_ids);
+	ida_init(&pd->source_cap_ids);
+	INIT_LIST_HEAD(&pd->sink_capabilities);
+	INIT_LIST_HEAD(&pd->source_capabilities);
+
+	pd->dev = get_device(dev);
+	pd->revision = desc->revision;
+	pd->version = desc->version;
+
+	ret = kobject_init_and_add(&pd->kobj, &pd_type, &dev->kobj, "usb_power_delivery");
+	if (ret) {
+		kobject_put(&pd->kobj);
+		return ERR_PTR(ret);
+	}
+
+	return pd;
+}
+
+void pd_unregister(struct pd *pd)
+{
+	kobject_put(&pd->kobj);
+}
diff --git a/drivers/usb/typec/pd.h b/drivers/usb/typec/pd.h
new file mode 100644
index 0000000000000..a24416e05a3c2
--- /dev/null
+++ b/drivers/usb/typec/pd.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __USB_POWER_DELIVERY__
+#define __USB_POWER_DELIVERY__
+
+#include <linux/kobject.h>
+
+struct pd_capabilities {
+	struct kobject kobj;
+	unsigned int id;
+	struct pd *pd;
+	enum typec_role role;
+	struct list_head pdos;
+	struct list_head node;
+};
+
+struct pd {
+	struct kobject		kobj;
+	struct device		*dev;
+
+	u16			revision; /* 0300H = "3.0" */
+	u16			version;
+
+	struct ida		source_cap_ids;
+	struct ida		sink_cap_ids;
+	struct list_head	source_capabilities;
+	struct list_head	sink_capabilities;
+};
+
+#define to_pd_capabilities(o) container_of(o, struct pd_capabilities, kobj)
+#define to_pd(o) container_of(o, struct pd, kobj)
+
+struct pd *pd_register(struct device *dev, struct pd_desc *desc);
+void pd_unregister(struct pd *pd);
+
+int pd_init(void);
+void pd_exit(void);
+
+#endif /* __USB_POWER_DELIVERY__ */
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 96b7ff66f074b..9cf78fa32623d 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -495,4 +495,34 @@ static inline unsigned int rdo_max_power(u32 rdo)
 
 #define PD_P_SNK_STDBY_MW	2500	/* 2500 mW */
 
+#if IS_ENABLED(CONFIG_TYPEC)
+
+/**
+ * pd_desc - USB Power Delivery Descriptor
+ * @revision: USB Power Delivery Specification Revision
+ * @version: USB Power Delivery Specicication Version - optional
+ */
+struct pd_desc {
+	u16 revision;
+	u16 version;
+};
+
+/**
+ * pd_caps_desc - Description of USB Power Delivery Capabilities Message
+ * @pdo: The Power Data Objects in the Capability Message
+ * @role: Power role of the capabilities
+ */
+struct pd_caps_desc {
+	u32 pdo[PDO_MAX_OBJECTS];
+	enum typec_role role;
+};
+
+struct pd_capabilities *pd_register_capabilities(struct pd *pd, struct pd_caps_desc *desc);
+void pd_unregister_capabilities(struct pd_capabilities *cap);
+
+struct pd *pd_register(struct device *dev, struct pd_desc *desc);
+void pd_unregister(struct pd *pd);
+
+#endif /* CONFIG_TYPEC */
+
 #endif /* __LINUX_USB_PD_H */
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 7ba45a97eeae3..a7525b9931b69 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -52,6 +52,16 @@ enum typec_role {
 	TYPEC_SOURCE,
 };
 
+static inline int is_sink(enum typec_role role)
+{
+	return role == TYPEC_SINK;
+}
+
+static inline int is_source(enum typec_role role)
+{
+	return role == TYPEC_SOURCE;
+}
+
 enum typec_pwr_opmode {
 	TYPEC_PWR_MODE_USB,
 	TYPEC_PWR_MODE_1_5A,
-- 
2.34.1

