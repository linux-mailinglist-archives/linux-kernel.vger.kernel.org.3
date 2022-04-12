Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE494FE1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355532AbiDLNPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356746AbiDLNOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:14:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A024C9FD4;
        Tue, 12 Apr 2022 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649768431; x=1681304431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QvrHRFmsLOTAvKPqihaR1OkWYHBwQjG74t37oPeFtO0=;
  b=eNfIOolQSmJOZTZSZd49bAKQYAEUtzJ4gUkNEeZSgI2VQTZ09ndJoOMA
   Tx6Q9GaLJwd+QPP3q/iivhAobJC7dVW0/6l2acnsltSjCVq5L1IeMrA4h
   qg3zEB0UaA7mspUdGlVi+cn6UYUtJ8YbkB4dXWE0teawVk14RY3wuU3O7
   Vj+JKOu2sjXnKo9lvilnXCbaf/Q4p2+rYn/AQa8FMYBUSQ4V7GvIqz2GA
   O+r/9EOiaEP0zXt41cKRG0lf1vLJFfSsXFfMz8D/MjAKcSa/1KEj0fkP/
   jGO1WfXxMGZFF79Ybxun4BpPofyzTIKXmPBJAWaE02AfL5x6eW5J1wP3K
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244250594"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="244250594"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="699825890"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2022 06:00:27 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Won Chung <wonchung@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] usb: typec: Separate USB Power Delivery from USB Type-C
Date:   Tue, 12 Apr 2022 16:00:21 +0300
Message-Id: <20220412130023.83927-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412130023.83927-1-heikki.krogerus@linux.intel.com>
References: <20220412130023.83927-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing a small subsystem for USB Power Delivery alone.
The idea with it is that we do not mix any more USB Power
Delivery information into the USB Type-C connectors only.
This separation will make it possible to register, or see,
the same USB Power Delivery objects also from other devices,
for example the normal USB devices that support the USB
Type-C Bridge Specification.

The subsystem will not deal with only the messages and
objects that were negotiated with the partner, but instead
messages and objects that can be used in the negotiation.
Every USB Power Delivery Subsystem kobject is therefore
independent of any device initially.

That allows the objects to shared and reconfigured. The
ports can decide which objects are to be advertised to the
partner before the contract is negotiated. It is also
possible to allow the user space to make that decision if
needed.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 .../testing/sysfs-kernel-usb_power_delivery   | 255 ++++++
 drivers/usb/typec/Makefile                    |   2 +-
 drivers/usb/typec/pd.c                        | 741 ++++++++++++++++++
 drivers/usb/typec/pd.h                        |  31 +
 include/linux/usb/pd.h                        |  33 +
 include/linux/usb/typec.h                     |  10 +
 6 files changed, 1071 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-usb_power_delivery
 create mode 100644 drivers/usb/typec/pd.c
 create mode 100644 drivers/usb/typec/pd.h

diff --git a/Documentation/ABI/testing/sysfs-kernel-usb_power_delivery b/Documentation/ABI/testing/sysfs-kernel-usb_power_delivery
new file mode 100644
index 0000000000000..4f56c99d5077f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-usb_power_delivery
@@ -0,0 +1,255 @@
+What:		/sys/kernel/usb_power_delivery
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory for USB Power Delivery Objects. Each object
+		(sub-directory) in this directory contains a set of USB Power
+		Delivery Capabilities and other USB Power Delivery details that
+		can be used to negotiate a USB Power Delivery Contract.
+
+		If a contract is been negotiated using one of the objects, that
+		object may also supply details about the other USB Power
+		Delivery Messages that were communicated.
+
+What:		/sys/kernel/usb_power_delivery/.../revision
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		File showing the USB Power Delivery Specification Revision used
+		in communication.
+
+What:		/sys/kernel/usb_power_delivery/.../version
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This is an optional attribute file showing the version of the
+		specific revision of the USB Power Delivery Specification. In
+		most cases the specification version is not known and the file
+		is not available.
+
+What:		/sys/kernel/usb_power_delivery/.../source-capabilities
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory containing the values of the Source Capabilities USB
+		Power Delivery Message.
+
+		The source capabilities message "Source_Capabilities" contains a
+		set of Power Data Objects (PDO), each representing a type of
+		power supply. The order of the PDO objects is defined in the USB
+		Power Delivery Specification. Each object in this directory will
+		have the object position number as the first character followed
+		by the object type name (":" as delimiter).
+
+			/sys/kernel/usb_power_delivery/.../source_capabilities/<position>:<type>
+
+What:		/sys/kernel/usb_power_delivery/.../sink-capabilities
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory containing the values of the Sink Capabilities USB
+		Power Delivery Message.
+
+		The sink capability message "Sink_Capabilities" contains a set
+		of Power Data Objects (PDO) just like with source capabilities,
+		but instead of describing the power capabilities, these objects
+		describe the power requirements.
+
+		The order of the objects in the sink capability message is the
+		same as with the source capabilities message.
+
+Fixed Supply Data Objects
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/<position>:fixed_supply
+Date:		April 2022
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
+What:		/sys/kernel/usb_power_delivery/.../<capability>/1:fixed_supply/dual_role_power
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file contains boolean value that tells does the device
+		support both source and sink power roles.
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/1:fixed_supply/usb_suspend_supported
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file shows the value of the USB Suspend Supported bit in
+		vSafe5V Fixed Supply Object. If the bit is set then the device
+		will follow the USB 2.0 and USB 3.2 rules for suspend and
+		resume.
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/1:fixed_supply/unconstrained_power
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file shows the value of the Unconstrained Power bit in
+		vSafe5V Fixed Supply Object. The bit is set when an external
+		source of power, powerful enough to power the entire system on
+		its own, is available for the device.
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/1:fixed_supply/usb_communication_capable
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file shows the value of the USB Communication Capable bit in
+		vSafe5V Fixed Supply Object.
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/1:fixed_supply/dual_role_data
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file shows the value of the Dual-Role Data bit in vSafe5V
+		Fixed Supply Object. Dual role data means ability act as both
+		USB host and USB device.
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/1:fixed_supply/unchunked_extended_messages_supported
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file shows the value of the Unchunked Extended Messages
+		Supported bit in vSafe5V Fixed Supply Object.
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/<position>:fixed_supply/voltage
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		The voltage the supply supports in millivolts.
+
+What:		/sys/kernel/usb_power_delivery/.../source-capabilities/<position>:fixed_supply/maximum_current
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Maximum current of the fixed source supply in milliamperes.
+
+What:		/sys/kernel/usb_power_delivery/.../sink-capabilities/<position>:fixed_supply/operational_current
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Operational current of the sink in milliamperes.
+
+What:		/sys/kernel/usb_power_delivery/.../sink-capabilities/<position>:fixed_supply/fast_role_swap_current
+Date:		April 2022
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
+What:		/sys/kernel/usb_power_delivery/.../<capability>/<position>:variable_supply
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory containing the attributes (the bit fields) defined for
+		Variable Supply PDO.
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/<position>:variable_supply/maximum_voltage
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Maximum Voltage in millivolts.
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/<position>:variable_supply/minimum_voltage
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Minimum Voltage in millivolts.
+
+What:		/sys/kernel/usb_power_delivery/.../source-capabilities/<position>:variable_supply/maximum_current
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		The maximum current in milliamperes that the source can supply
+		at the given Voltage range.
+
+What:		/sys/kernel/usb_power_delivery/.../sink-capabilities/<position>:variable_supply/operational_current
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		The operational current in milliamperes that the sink requires
+		at the given Voltage range.
+
+Battery Supply Data Objects
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/<position>:battery
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory containing the attributes (the bit fields) defined for
+		Battery PDO.
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/<position>:battery/maximum_voltage
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Maximum Voltage in millivolts.
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/<position>:battery/minimum_voltage
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Minimum Voltage in millivolts.
+
+What:		/sys/kernel/usb_power_delivery/.../source-capabilities/<position>:battery/maximum_power
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Maximum allowable Power in milliwatts.
+
+What:		/sys/kernel/usb_power_delivery/.../sink-capabilities/<position>:battery/operational_power
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		The operational power that the sink requires at the given
+		voltage range.
+
+Standard Power Range (SPR) Programmable Power Supply Objects
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/<position>:programmable_supply
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Directory containing the attributes (the bit fields) defined for
+		Programmable Power Supply (PPS) Augmented PDO (APDO).
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/<position>:programmable_supply/maximum_voltage
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Maximum Voltage in millivolts.
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/<position>:programmable_supply/minimum_voltage
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Minimum Voltage in millivolts.
+
+What:		/sys/kernel/usb_power_delivery/.../<capability>/<position>:programmable_supply/maximum_current
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Maximum Current in milliamperes.
+
+What:		/sys/kernel/usb_power_delivery/.../source-capabilities/<position>:programmable_supply/pps_power_limited
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		The PPS Power Limited bit indicates whether or not the source
+		supply will exceed the rated output power if requested.
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 43626acc0aafb..2f174cd3e5df1 100644
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
index 0000000000000..eb0c35191124a
--- /dev/null
+++ b/drivers/usb/typec/pd.c
@@ -0,0 +1,741 @@
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
+static struct kset *pd_kset;
+static DEFINE_IDA(pd_ida);
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
+	p->kobj.kset = pd_kset;
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
+	[TYPEC_SINK]    = "sink-capabilities",
+	[TYPEC_SOURCE]  = "source-capabilities",
+};
+
+static void pd_capabilities_release(struct kobject *kobj)
+{
+	kfree(to_pd_capabilities(kobj));
+}
+
+static struct kobj_type pd_capabilities_type = {
+	.release = pd_capabilities_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+/**
+ * pd_register_capabilities - Register a set of capabilities.
+ * @pd: The USB PD instance that the capabilities belong to.
+ * @desc: Description of the Capablities Message.
+ *
+ * This function registers a Capabilities Message described in @desc. The
+ * capabilities will have their own sub-directory under @pd in sysfs.
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
+	cap->pd = pd;
+	cap->role = desc->role;
+	cap->kobj.kset = pd_kset;
+	INIT_LIST_HEAD(&cap->pdos);
+
+	ret = kobject_init_and_add(&cap->kobj, &pd_capabilities_type, &pd->kobj,
+				   "%s", cap_name[cap->role]);
+	if (ret)
+		goto err_remove_capability;
+
+	for (i = 0; i < PDO_MAX_OBJECTS && desc->pdo[i]; i++) {
+		ret = add_pdo(cap, desc->pdo[i], i);
+		if (ret)
+			goto err_remove_pdos;
+	}
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
+	ida_simple_remove(&pd_ida, pd->id);
+	kfree(pd);
+}
+
+static struct kobj_type pd_type = {
+	.release = pd_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = pd_groups,
+};
+
+struct pd *pd_find(const char *name)
+{
+	struct kobject *kobj;
+	struct pd *pd = NULL;
+
+	spin_lock(&pd_kset->list_lock);
+
+	list_for_each_entry(kobj, &pd_kset->list, entry) {
+		if (kobj->ktype != &pd_type)
+			continue;
+		if (sysfs_streq(kobject_name(kobj), name)) {
+			pd = container_of(kobj, struct pd, kobj);
+			break;
+		}
+	}
+
+	spin_unlock(&pd_kset->list_lock);
+
+	return pd;
+}
+
+/**
+ * pd_register - Register USB Power Delivery Support.
+ * @desc: Description of the USB PD contract.
+ *
+ * This routine can be used to register USB Power Delivery capabilities that a
+ * device or devices can support. These capabilities represent all the
+ * capabilities that can be negotiated with a partner, so not only the Power
+ * Capabilities that are negotiated using the USB PD Capabilities Message.
+ *
+ * The USB Power Delivery Support object that this routine generates can be used
+ * as the parent object for all the actual USB Power Delivery Messages and
+ * objects that can be negotiated with the partner.
+ *
+ * Returns handle to struct pd or ERR_PTR.
+ */
+struct pd *pd_register(struct pd_desc *desc)
+{
+	struct pd *pd;
+	int ret;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return ERR_PTR(-ENOMEM);
+
+	ret = ida_simple_get(&pd_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0) {
+		kfree(pd);
+		return ERR_PTR(ret);
+	}
+
+	pd->id = ret;
+	pd->revision = desc->revision;
+	pd->version = desc->version;
+	pd->kobj.kset = pd_kset;
+
+	ret = kobject_init_and_add(&pd->kobj, &pd_type, NULL, "pd%d", pd->id);
+	if (ret) {
+		kobject_put(&pd->kobj);
+		return ERR_PTR(ret);
+	}
+
+	return pd;
+}
+EXPORT_SYMBOL_GPL(pd_register);
+
+/**
+ * pd_register - Unregister USB Power Delivery Support.
+ * @pd: The USB PD contract.
+ */
+void pd_unregister(struct pd *pd)
+{
+	if (IS_ERR_OR_NULL(pd))
+		return;
+
+	kobject_put(&pd->kobj);
+}
+EXPORT_SYMBOL_GPL(pd_unregister);
+
+/**
+ * pd_link_device - Link device to its USB PD object.
+ * @pd: The USB PD instance.
+ * @dev: The device.
+ *
+ * This function can be used to create a symlink named "usb_power_delivery" for
+ * @dev that points to @pd.
+ */
+int pd_link_device(struct pd *pd, struct device *dev)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(pd) || !dev)
+		return 0;
+
+	ret = sysfs_create_link(&dev->kobj, &pd->kobj, "usb_power_delivery");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&pd->kobj, &dev->kobj, dev_name(dev));
+	if (ret) {
+		sysfs_remove_link(&dev->kobj, "usb_power_delivery");
+		return ret;
+	}
+
+	kobject_get(&pd->kobj);
+	get_device(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pd_link_device);
+
+/**
+ * pd_link_device - Unlink device from its USB PD object.
+ * @pd: The USB PD instance.
+ * @dev: The device.
+ *
+ * Remove the symlink that was previously created with pd_link_device().
+ */
+void pd_unlink_device(struct pd *pd, struct device *dev)
+{
+	if (IS_ERR_OR_NULL(pd) || !dev)
+		return;
+
+	sysfs_remove_link(&dev->kobj, "usb_power_delivery");
+	sysfs_remove_link(&pd->kobj, dev_name(dev));
+	kobject_put(&pd->kobj);
+	put_device(dev);
+}
+EXPORT_SYMBOL_GPL(pd_unlink_device);
+
+/* -------------------------------------------------------------------------- */
+
+int __init pd_init(void)
+{
+	pd_kset = kset_create_and_add("usb_power_delivery", NULL, kernel_kobj);
+
+	return pd_kset ? 0 : -ENOMEM;
+}
+
+void __exit pd_exit(void)
+{
+	ida_destroy(&pd_ida);
+	kset_unregister(pd_kset);
+}
diff --git a/drivers/usb/typec/pd.h b/drivers/usb/typec/pd.h
new file mode 100644
index 0000000000000..d8b1511177079
--- /dev/null
+++ b/drivers/usb/typec/pd.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __USB_POWER_DELIVERY__
+#define __USB_POWER_DELIVERY__
+
+#include <linux/kobject.h>
+
+struct pd_capabilities {
+	struct kobject kobj;
+	struct pd *pd;
+	enum typec_role role;
+	struct list_head pdos;
+};
+
+struct pd {
+	int			id;
+	struct kobject		kobj;
+
+	u16			revision; /* 0300H = "3.0" */
+	u16			version;
+};
+
+#define to_pd_capabilities(o) container_of(o, struct pd_capabilities, kobj)
+#define to_pd(o) container_of(o, struct pd, kobj)
+
+struct pd *pd_find(const char *name);
+
+int pd_init(void);
+void pd_exit(void);
+
+#endif /* __USB_POWER_DELIVERY__ */
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 96b7ff66f074b..80e727a6730a8 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -495,4 +495,37 @@ static inline unsigned int rdo_max_power(u32 rdo)
 
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
+struct pd *pd_register(struct pd_desc *desc);
+void pd_unregister(struct pd *pd);
+
+int pd_link_device(struct pd *pd, struct device *dev);
+void pd_unlink_device(struct pd *pd, struct device *dev);
+
+#endif /* CONFIG_TYPEC */
+
 #endif /* __LINUX_USB_PD_H */
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index fdf737d48b3bf..45e28d14ae56e 100644
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
2.35.1

