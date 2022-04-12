Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C424E4FE228
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355671AbiDLNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356747AbiDLNOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:14:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BBAB7FB;
        Tue, 12 Apr 2022 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649768434; x=1681304434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TSktTzp5pxfS1hg9UjcbF5ev/GAuyQvCEsQnZXwDQrM=;
  b=II7aTDfnCjShoMhLDe7S+CtmtjD4jmNgs1PLPgS7Npnc9QSkl13Q15WN
   tu1F8GSSoJv58sVYAaPDKtakEcN0/DPbEyHZdBLxrOEesCugh/eLjbBai
   OqHVEvZzEyncRYhNgvp3SF/uM6Rj4/mgMAtz1vtPsOYW3zbHg7+pss1hI
   6vnX/P0BcsJWcHi1eq1efwrTTXDn/5OmpZ+iz5W2bCdUqUr47v6njgOLb
   jqwzAV2dRy3ys/wzzcTYNIMg6fe/KvxXYsXXlPopIB0/bV8StpYsvPOYp
   ehkiY1g/ARKu39G6HYdrB0XjmcRZsCV9D5p4Q5LDdeGTSV+hClMSiXljE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244250603"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="244250603"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="699825909"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2022 06:00:30 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Won Chung <wonchung@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] usb: typec: USB Power Deliver helpers for ports and partners
Date:   Tue, 12 Apr 2022 16:00:22 +0300
Message-Id: <20220412130023.83927-3-heikki.krogerus@linux.intel.com>
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

All the USB Type-C Connector Class devices are protected, so
the drivers can not directly access them. This will adds a
few helpers that can be used to link the ports and partners
to the correct USB Power Delivery objects.

For ports a new optional sysfs attribute file is also added
that can be used to select the USB Power Delivery
capabilities that the port will advertise to the partner.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-class-typec |   8 +
 drivers/usb/typec/class.c                   | 153 ++++++++++++++++++++
 drivers/usb/typec/class.h                   |   4 +
 include/linux/usb/typec.h                   |  12 ++
 4 files changed, 177 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index 75088ecad2029..6c528f87ecaf0 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -141,6 +141,14 @@ Description:
 		- "reverse": CC2 orientation
 		- "unknown": Orientation cannot be determined.
 
+What:		/sys/class/typec/<port>/select_usb_power_delivery
+Date:		February 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Lists the USB Power Delivery Capabilities that the port can
+		advertise to the partner. The currently used capabilities are in
+		brackets. Selection happens by writing to the file.
+
 USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
 
 What:		/sys/class/typec/<port>-partner/accessory_mode
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index ee0e520707dd7..770d7d38c9b57 100644
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
+	[TYPEC_SINK]		= "sink-capabilities",
+	[TYPEC_SOURCE]		= "source-capabilities",
+};
+
 static const char * const typec_accessory_modes[] = {
 	[TYPEC_ACCESSORY_NONE]		= "none",
 	[TYPEC_ACCESSORY_AUDIO]		= "analog_audio",
@@ -720,6 +726,38 @@ void typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revisio
 }
 EXPORT_SYMBOL_GPL(typec_partner_set_pd_revision);
 
+/**
+ * typec_partner_set_pd - Declare USB Power Delivery Contract.
+ * @partner: The partner device.
+ * @pd: The USB PD instance.
+ *
+ * This routine can be used to declare USB Power Delivery Contract with @partner
+ * by linking @partner to @pd which contains the objects that were used during the
+ * negotiation of the contract.
+ *
+ * If @pd is NULL, the link is removed and the contract with @partner has ended.
+ */
+int typec_partner_set_pd(struct typec_partner *partner, struct pd *pd)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(partner) || partner->pd == pd)
+		return 0;
+
+	if (pd) {
+		ret = pd_link_device(pd, &partner->dev);
+		if (ret)
+			return ret;
+	} else {
+		pd_unlink_device(partner->pd, &partner->dev);
+	}
+
+	partner->pd = pd;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_partner_set_pd);
+
 /**
  * typec_partner_set_num_altmodes - Set the number of available partner altmodes
  * @partner: The partner to be updated.
@@ -1170,6 +1208,104 @@ EXPORT_SYMBOL_GPL(typec_unregister_cable);
 /* ------------------------------------------------------------------------- */
 /* USB Type-C ports */
 
+/**
+ * typec_port_set_pd_capabilities - Assign USB PD for port.
+ * @port: USB Type-C port.
+ * @pd: USB PD instance.
+ *
+ * This routine can be used to set the USB Power Delivery Capabilities for @port
+ * that it will advertise to the partner.
+ *
+ * If @pd is NULL, the assignment is removed.
+ */
+int typec_port_set_pd(struct typec_port *port, struct pd *pd)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(port) || port->pd == pd)
+		return 0;
+
+	if (pd) {
+		ret = pd_link_device(pd, &port->dev);
+		if (ret)
+			return ret;
+	} else {
+		pd_unlink_device(port->pd, &port->dev);
+	}
+
+	port->pd = pd;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_port_set_pd);
+
+static ssize_t select_usb_power_delivery_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t size)
+{
+	struct typec_port *port = to_typec_port(dev);
+	struct pd *pd;
+
+	if (!port->ops || !port->ops->pd_set)
+		return -EOPNOTSUPP;
+
+	pd = pd_find(buf);
+	if (!pd)
+		return -EINVAL;
+
+	return port->ops->pd_set(port, pd);
+}
+
+static ssize_t select_usb_power_delivery_show(struct device *dev,
+					      struct device_attribute *attr, char *buf)
+{
+	struct typec_port *port = to_typec_port(dev);
+	struct pd **pds;
+	struct pd *pd;
+	int ret = 0;
+
+	if (!port->ops || !port->ops->pd_get)
+		return -EOPNOTSUPP;
+
+	pds = port->ops->pd_get(port);
+	if (!pds)
+		return 0;
+
+	for (pd = pds[0]; pd; pd++) {
+		if (pd == port->pd)
+			ret += sysfs_emit(buf + ret, "[%s] ", kobject_name(&pd->kobj));
+		else
+			ret += sysfs_emit(buf + ret, "%s ", kobject_name(&pd->kobj));
+	}
+
+	buf[ret - 1] = '\n';
+
+	return ret;
+}
+static DEVICE_ATTR_RW(select_usb_power_delivery);
+
+static struct attribute *port_attrs[] = {
+	&dev_attr_select_usb_power_delivery.attr,
+	NULL
+};
+
+static umode_t port_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct typec_port *port = to_typec_port(kobj_to_dev(kobj));
+
+	if (!port->pd || !port->ops || !port->ops->pd_get)
+		return 0;
+	if (!port->ops->pd_set)
+		return 0444;
+
+	return attr->mode;
+}
+
+static const struct attribute_group pd_group = {
+	.is_visible = port_attr_is_visible,
+	.attrs = port_attrs,
+};
+
 static const char * const typec_orientations[] = {
 	[TYPEC_ORIENTATION_NONE]	= "unknown",
 	[TYPEC_ORIENTATION_NORMAL]	= "normal",
@@ -1581,6 +1717,7 @@ static const struct attribute_group typec_group = {
 
 static const struct attribute_group *typec_groups[] = {
 	&typec_group,
+	&pd_group,
 	NULL
 };
 
@@ -2123,6 +2260,13 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	ret = typec_port_set_pd(port, cap->pd);
+	if (ret) {
+		dev_err(&port->dev, "failed to link pd\n");
+		device_unregister(&port->dev);
+		return ERR_PTR(ret);
+	}
+
 	ret = typec_link_ports(port);
 	if (ret)
 		dev_warn(&port->dev, "failed to create symlinks (%d)\n", ret);
@@ -2141,6 +2285,7 @@ void typec_unregister_port(struct typec_port *port)
 {
 	if (!IS_ERR_OR_NULL(port)) {
 		typec_unlink_ports(port);
+		typec_port_set_pd(port, NULL);
 		device_unregister(&port->dev);
 	}
 }
@@ -2162,8 +2307,15 @@ static int __init typec_init(void)
 	if (ret)
 		goto err_unregister_mux_class;
 
+	ret = pd_init();
+	if (ret)
+		goto err_unregister_class;
+
 	return 0;
 
+err_unregister_class:
+	class_unregister(&typec_class);
+
 err_unregister_mux_class:
 	class_unregister(&typec_mux_class);
 
@@ -2176,6 +2328,7 @@ subsys_initcall(typec_init);
 
 static void __exit typec_exit(void)
 {
+	pd_exit();
 	class_unregister(&typec_class);
 	ida_destroy(&typec_index_ida);
 	bus_unregister(&typec_bus);
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index 0f1bd6d19d67e..6c638fd8d85cb 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -33,6 +33,8 @@ struct typec_partner {
 	int				num_altmodes;
 	u16				pd_revision; /* 0300H = "3.0" */
 	enum usb_pd_svdm_ver		svdm_version;
+
+	struct pd			*pd;
 };
 
 struct typec_port {
@@ -40,6 +42,8 @@ struct typec_port {
 	struct device			dev;
 	struct ida			mode_ids;
 
+	struct pd			*pd;
+
 	int				prefer_role;
 	enum typec_data_role		data_role;
 	enum typec_role			pwr_role;
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 45e28d14ae56e..3855cd07925d3 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -22,6 +22,8 @@ struct typec_altmode_ops;
 struct fwnode_handle;
 struct device;
 
+struct pd;
+
 enum typec_port_type {
 	TYPEC_PORT_SRC,
 	TYPEC_PORT_SNK,
@@ -223,6 +225,8 @@ struct typec_partner_desc {
  * @pr_set: Set Power Role
  * @vconn_set: Source VCONN
  * @port_type_set: Set port type
+ * @pd_get: Get available USB Power Delivery Capabilities.
+ * @pd_set: Set USB Power Delivery Capabilities.
  */
 struct typec_operations {
 	int (*try_role)(struct typec_port *port, int role);
@@ -231,6 +235,8 @@ struct typec_operations {
 	int (*vconn_set)(struct typec_port *port, enum typec_role role);
 	int (*port_type_set)(struct typec_port *port,
 			     enum typec_port_type type);
+	struct pd **(*pd_get)(struct typec_port *port);
+	int (*pd_set)(struct typec_port *port, struct pd *pd);
 };
 
 enum usb_pd_svdm_ver {
@@ -250,6 +256,7 @@ enum usb_pd_svdm_ver {
  * @accessory: Supported Accessory Modes
  * @fwnode: Optional fwnode of the port
  * @driver_data: Private pointer for driver specific info
+ * @pd: Optional USB Power Delivery Support
  * @ops: Port operations vector
  *
  * Static capabilities of a single USB Type-C port.
@@ -267,6 +274,8 @@ struct typec_capability {
 	struct fwnode_handle	*fwnode;
 	void			*driver_data;
 
+	struct pd		*pd;
+
 	const struct typec_operations	*ops;
 };
 
@@ -318,4 +327,7 @@ void typec_partner_set_svdm_version(struct typec_partner *partner,
 				    enum usb_pd_svdm_ver svdm_version);
 int typec_get_negotiated_svdm_version(struct typec_port *port);
 
+int typec_port_set_pd(struct typec_port *port, struct pd *pd);
+int typec_partner_set_pd(struct typec_partner *partner, struct pd *pd);
+
 #endif /* __LINUX_USB_TYPEC_H */
-- 
2.35.1

