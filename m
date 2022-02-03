Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E814A86D8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351408AbiBCOrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:47:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:37909 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351338AbiBCOqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643899611; x=1675435611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ytp1ZbjWgyqpIz/beyPJzZFya/E0iLt3aeSshDMKWFY=;
  b=broMoIX2YWxiPuVOSGpA6NtdilPfxDYUzsNp1px6FjYidGAxMIPso0T3
   juCZzw5673XsnFdcaBjrd0xAR8cGyLcTMsb0OrJd1NBtuqcRcyfvcg9pf
   PvigG+HNA82tN8ivKs2BMh/gvsKQR9zp70eOODnclyl0XK+EfVZFiJPUK
   IWE2jys+rx+EDUFI1Nz2gtev2fLUpVaE5mfy99LZ5bbShqNaTgddyquGn
   2nQP/O1sXQATXKwwU4pHbIy1IRwQd9RRi/3LOXswAR/joXU+m8G5RNB1L
   WtwTs9tbYFqcrg48VhKh6n5lGcFgbT5OvPUFgOLjGEG8ciAVMU2OAqfdA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308883017"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="308883017"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:46:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="676788156"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2022 06:46:48 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] usb: typec: Functions for USB PD capabilities registration
Date:   Thu,  3 Feb 2022 17:46:56 +0300
Message-Id: <20220203144657.16527-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203144657.16527-1-heikki.krogerus@linux.intel.com>
References: <20220203144657.16527-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds functions that can be used to register and assign
USB Power Delivery Capabilities Messages so they are exposed
to the user via sysfs. By assigning the capabilities the
driver will create a symlink pointing to those capabilities
named "source_capabilities" and (or) "sink_capabilities"
depending on the role of the message (Source_Capablities or
Sink_Capabilities Message).

Ports can support multiple sets of capabilities but only one
that is advertised to the partner can be active at any given
time. Separate sysfs attribute files are added that can be
used to select the currently active capabilities message.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-class-typec |  22 ++
 drivers/usb/typec/class.c                   | 328 ++++++++++++++++++++
 drivers/usb/typec/class.h                   |   8 +
 include/linux/usb/typec.h                   |  15 +
 4 files changed, 373 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index 75088ecad2029..d60720befeeb3 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -141,6 +141,28 @@ Description:
 		- "reverse": CC2 orientation
 		- "unknown": Orientation cannot be determined.
 
+What:		/sys/class/typec/<port>/select_sink_capabilities
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file lists the available USB Power Delivery
+		Sink_Capabilities Messages, the same that can be read from the
+		"usb_power_delivery" sub-directory under the port device's sysfs
+		directory. The active message, the one that is advertised to the
+		partner, is in brackets. The active message can be changed by
+		writing to this file.
+
+What:		/sys/class/typec/<port>/select_source_capabilities
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file lists the available USB Power Delivery
+		Source_Capabilities Messages, the same that can be read from the
+		"usb_power_delivery" sub-directory under the port device's sysfs
+		directory. The active message, the one that is advertised to the
+		partner, is in brackets. The active message can be changed by
+		writing to this file.
+
 USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
 
 What:		/sys/class/typec/<port>-partner/accessory_mode
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 45a6f0c807cb5..eef0b59209331 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -15,6 +15,7 @@
 
 #include "bus.h"
 #include "class.h"
+#include "pd.h"
 
 static DEFINE_IDA(typec_index_ida);
 
@@ -26,6 +27,11 @@ struct class typec_class = {
 /* ------------------------------------------------------------------------- */
 /* Common attributes */
 
+static const char * const cap_name[] = {
+	[TYPEC_SINK]		= "sink_capabilities",
+	[TYPEC_SOURCE]		= "source_capabilities",
+};
+
 static const char * const typec_accessory_modes[] = {
 	[TYPEC_ACCESSORY_NONE]		= "none",
 	[TYPEC_ACCESSORY_AUDIO]		= "analog_audio",
@@ -589,6 +595,100 @@ EXPORT_SYMBOL_GPL(typec_unregister_altmode);
 /* ------------------------------------------------------------------------- */
 /* Type-C Partners */
 
+/**
+ * typec_partner_set_pd_capabilities - Create link to the USB PD capabilities
+ * @partner: USB Type-C partner
+ * @cap: USB Power Delivery capabilities
+ *
+ * The link will be named "source_capabilities" or "sink_capabilities" depending
+ * on the role of @cap.
+ */
+int typec_partner_set_pd_capabilities(struct typec_partner *partner, struct pd_capabilities *cap)
+{
+	int ret;
+
+	if (!cap)
+		return -EINVAL;
+
+	if ((is_source(cap->role) && partner->source_caps) || partner->sink_caps)
+		return -EEXIST;
+
+	ret = sysfs_create_link(&partner->dev.kobj, &cap->kobj, cap_name[cap->role]);
+	if (ret)
+		return ret;
+
+	if (is_source(cap->role))
+		partner->source_caps = cap;
+	else
+		partner->sink_caps = cap;
+
+	kobject_get(&cap->kobj);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_partner_set_pd_capabilities);
+
+/**
+ * typec_partner_unset_pd_capabilities - Remove link to the USB PD capabilities
+ * @port: USB Type-C partner
+ * @cap: USB Power Delivery capabilities
+ */
+void typec_partner_unset_pd_capabilities(struct typec_partner *partner, enum typec_role role)
+{
+	struct pd_capabilities *cap;
+
+	if (is_source(role)) {
+		cap = partner->source_caps;
+		partner->source_caps = NULL;
+	} else {
+		cap = partner->sink_caps;
+		partner->sink_caps = NULL;
+	}
+
+	if (!cap)
+		return;
+
+	sysfs_remove_link(&partner->dev.kobj, cap_name[role]);
+	kobject_put(&cap->kobj);
+}
+EXPORT_SYMBOL_GPL(typec_partner_unset_pd_capabilities);
+
+/**
+ * typec_partner_register_pd - Register USB Power Delivery support
+ * @partner: The partner device that support USB Power Delivery
+ * @desc: Description of the USB Power Delivery support
+ *
+ * The function returns pointer to struct pd, or errno on failure.
+ */
+struct pd *typec_partner_register_pd(struct typec_partner *partner, struct pd_desc *desc)
+{
+	struct pd *pd;
+
+	if (partner->pd)
+		return ERR_PTR(-EEXIST);
+
+	pd = pd_register(&partner->dev, desc);
+	if (!IS_ERR(pd))
+		partner->pd = pd;
+
+	return pd;
+}
+EXPORT_SYMBOL_GPL(typec_partner_register_pd);
+
+/**
+ * typec_partner_unregister_pd - Unregister USB Power Delivery sysfs directory
+ * @partner: The partner device
+ */
+void typec_partner_unregister_pd(struct typec_partner *partner)
+{
+	if (!partner->pd)
+		return;
+
+	pd_unregister(partner->pd);
+	partner->pd = NULL;
+}
+EXPORT_SYMBOL_GPL(typec_partner_unregister_pd);
+
 static ssize_t accessory_mode_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
@@ -1170,6 +1270,234 @@ EXPORT_SYMBOL_GPL(typec_unregister_cable);
 /* ------------------------------------------------------------------------- */
 /* USB Type-C ports */
 
+/**
+ * typec_port_set_pd_capabilities - Create link to the USB PD capabilities
+ * @port: USB Type-C port
+ * @cap: Active USB Power Delivery capabilities
+ *
+ * Creates a link to the currently active capabilities @cap for @port, i.e.
+ * capabilities that are advertised to the partner. Both roles have their own
+ * active capabilities, so the link will be "source_capabilities" or
+ * "sink_capabilities" depending on the role of @cap.
+ */
+int typec_port_set_pd_capabilities(struct typec_port *port, struct pd_capabilities *cap)
+{
+	int ret;
+
+	if (!cap)
+		return -EINVAL;
+
+	if (is_source(cap->role) && port->source_caps)
+		kobject_put(&port->source_caps->kobj);
+	else if (port->sink_caps)
+		kobject_put(&port->sink_caps->kobj);
+
+	sysfs_remove_link(&port->dev.kobj, cap_name[cap->role]);
+
+	ret = sysfs_create_link(&port->dev.kobj, &cap->kobj, cap_name[cap->role]);
+	if (ret)
+		return ret;
+
+	if (is_source(cap->role))
+		port->source_caps = cap;
+	else
+		port->sink_caps = cap;
+
+	kobject_get(&cap->kobj);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_port_set_pd_capabilities);
+
+/**
+ * typec_port_unset_pd_capabilities - Remove link to the USB PD capabilities
+ * @port: USB Type-C port
+ * @cap: Active USB Power Delivery capabilities
+ */
+int typec_port_unset_pd_capabilities(struct typec_port *port, struct pd_capabilities *cap)
+{
+	if (is_source(cap->role)) {
+		if (port->source_caps != cap)
+			return -EINVAL;
+		port->source_caps = NULL;
+	} else {
+		if (port->sink_caps != cap)
+			return -EINVAL;
+		port->sink_caps = NULL;
+	}
+
+	sysfs_remove_link(&port->dev.kobj, cap_name[cap->role]);
+	kobject_put(&cap->kobj);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_port_unset_pd_capabilities);
+
+static ssize_t select_source_capabilities_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t size)
+{
+	struct typec_port *port = to_typec_port(dev);
+	struct pd_capabilities *cap;
+	int ret;
+	int i;
+
+	if (!port->ops || !port->ops->capabilities_set)
+		return -EOPNOTSUPP;
+
+	if (sscanf(buf, "source_capabilities%d", &i) != 1)
+		return -EINVAL;
+
+	list_for_each_entry(cap, &port->pd->source_capabilities, node) {
+		if (cap->id == i) {
+			ret = port->ops->capabilities_set(port, cap);
+			if (ret)
+				return ret;
+			return size;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t select_source_capabilities_show(struct device *dev,
+					       struct device_attribute *attr, char *buf)
+{
+	struct typec_port *port = to_typec_port(dev);
+	const char *name = cap_name[TYPEC_SOURCE];
+	struct pd_capabilities *cap;
+	ssize_t ret = 0;
+
+	list_for_each_entry(cap, &port->pd->source_capabilities, node) {
+		if (cap == port->source_caps)
+			ret += sysfs_emit(buf + ret, "[%s%d] ", name, cap->id);
+		else
+			ret += sysfs_emit(buf + ret, "%s%d ", name, cap->id);
+	}
+
+	buf[ret - 1] = '\n';
+
+	return ret;
+}
+static DEVICE_ATTR_RW(select_source_capabilities);
+
+static ssize_t select_sink_capabilities_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t size)
+{
+	struct typec_port *port = to_typec_port(dev);
+	struct pd_capabilities *cap;
+	int ret;
+	int i;
+
+	if (!port->ops || !port->ops->capabilities_set)
+		return -EOPNOTSUPP;
+
+	if (sscanf(buf, "sink_capabilities%d", &i) != 1)
+		return -EINVAL;
+
+	list_for_each_entry(cap, &port->pd->sink_capabilities, node) {
+		if (cap->id == i) {
+			ret = port->ops->capabilities_set(port, cap);
+			if (ret)
+				return ret;
+			return size;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t select_sink_capabilities_show(struct device *dev,
+					     struct device_attribute *attr, char *buf)
+{
+	struct typec_port *port = to_typec_port(dev);
+	const char *name = cap_name[TYPEC_SINK];
+	struct pd_capabilities *cap;
+	ssize_t ret = 0;
+
+	list_for_each_entry(cap, &port->pd->sink_capabilities, node) {
+		if (cap == port->sink_caps)
+			ret += sysfs_emit(buf + ret, "[%s%d] ", name, cap->id);
+		else
+			ret += sysfs_emit(buf + ret, "%s%d ", name, cap->id);
+	}
+
+	buf[ret - 1] = '\n';
+
+	return ret;
+}
+static DEVICE_ATTR_RW(select_sink_capabilities);
+
+static struct attribute *port_attrs[] = {
+	&dev_attr_select_source_capabilities.attr,
+	&dev_attr_select_sink_capabilities.attr,
+	NULL
+};
+
+static umode_t port_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct typec_port *port = to_typec_port(kobj_to_dev(kobj));
+
+	if (!port->ops || !port->ops->capabilities_set)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group port_group = {
+	.is_visible = port_attr_is_visible,
+	.attrs = port_attrs,
+};
+
+/**
+ * typec_port_register_pd - Register USB Power Delivery support
+ * @port: The port that support USB Power Delivery
+ * @desc: Description of the USB Power Delivery support
+ *
+ * This directory will house all the USB Power Delivery objects of @port that
+ * the operating system can access. The function returns pointer to struct
+ * pd, or errno on failure.
+ */
+struct pd *typec_port_register_pd(struct typec_port *port, struct pd_desc *desc)
+{
+	struct pd *pd;
+	int ret;
+
+	if (port->pd)
+		return ERR_PTR(-EEXIST);
+
+	pd = pd_register(&port->dev, desc);
+	if (IS_ERR(pd))
+		return pd;
+
+	port->pd = pd;
+
+	ret = sysfs_create_group(&port->dev.kobj, &port_group);
+	if (ret) {
+		pd_unregister(pd);
+		return ERR_PTR(ret);
+	}
+
+	return pd;
+}
+EXPORT_SYMBOL_GPL(typec_port_register_pd);
+
+/**
+ * typec_port_unregister_pd - Unregister USB Power Delivery sysfs directory
+ * @port: The port device
+ */
+void typec_port_unregister_pd(struct typec_port *port)
+{
+	if (!port->pd)
+		return;
+
+	sysfs_remove_group(&port->dev.kobj, &port_group);
+	pd_unregister(port->pd);
+	port->pd = NULL;
+}
+EXPORT_SYMBOL_GPL(typec_port_unregister_pd);
+
 static const char * const typec_orientations[] = {
 	[TYPEC_ORIENTATION_NONE]	= "unknown",
 	[TYPEC_ORIENTATION_NORMAL]	= "normal",
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index 0f1bd6d19d67e..db1b6bbd4c779 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -33,6 +33,10 @@ struct typec_partner {
 	int				num_altmodes;
 	u16				pd_revision; /* 0300H = "3.0" */
 	enum usb_pd_svdm_ver		svdm_version;
+
+	struct pd			*pd;
+	struct pd_capabilities		*source_caps;
+	struct pd_capabilities		*sink_caps;
 };
 
 struct typec_port {
@@ -40,6 +44,10 @@ struct typec_port {
 	struct device			dev;
 	struct ida			mode_ids;
 
+	struct pd			*pd;
+	struct pd_capabilities		*source_caps;
+	struct pd_capabilities		*sink_caps;
+
 	int				prefer_role;
 	enum typec_data_role		data_role;
 	enum typec_role			pwr_role;
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index a7525b9931b69..a315802b50039 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -22,6 +22,10 @@ struct typec_altmode_ops;
 struct fwnode_handle;
 struct device;
 
+struct pd_capabilities;
+struct pd_desc;
+struct pd;
+
 enum typec_port_type {
 	TYPEC_PORT_SRC,
 	TYPEC_PORT_SNK,
@@ -231,6 +235,7 @@ struct typec_operations {
 	int (*vconn_set)(struct typec_port *port, enum typec_role role);
 	int (*port_type_set)(struct typec_port *port,
 			     enum typec_port_type type);
+	int (*capabilities_set)(struct typec_port *port, struct pd_capabilities *cap);
 };
 
 enum usb_pd_svdm_ver {
@@ -315,4 +320,14 @@ void typec_partner_set_svdm_version(struct typec_partner *partner,
 				    enum usb_pd_svdm_ver svdm_version);
 int typec_get_negotiated_svdm_version(struct typec_port *port);
 
+struct pd *typec_partner_register_pd(struct typec_partner *partner, struct pd_desc *desc);
+void typec_partner_unregister_pd(struct typec_partner *partner);
+int typec_partner_set_pd_capabilities(struct typec_partner *partner, struct pd_capabilities *cap);
+void typec_partner_unset_pd_capabilities(struct typec_partner *partner, enum typec_role role);
+
+struct pd *typec_port_register_pd(struct typec_port *port, struct pd_desc *desc);
+void typec_port_unregister_pd(struct typec_port *port);
+int typec_port_set_pd_capabilities(struct typec_port *port, struct pd_capabilities *cap);
+int typec_port_unset_pd_capabilities(struct typec_port *port, struct pd_capabilities *cap);
+
 #endif /* __LINUX_USB_TYPEC_H */
-- 
2.34.1

