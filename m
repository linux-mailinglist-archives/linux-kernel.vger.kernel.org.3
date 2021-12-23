Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0E47E05B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347181AbhLWIYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:24:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:35791 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347146AbhLWIYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640247857; x=1671783857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8g1iuk3ghWAuPckGIO1BkLHCUR6qyahtF5nvankjCc=;
  b=CyntnZoCrMuz1dHrftS9JS+EEzzwG7s3uf1W5KcF0rrcZUFTSsDZmmv/
   w16F/CWLZIVzRiYSHyZ9RgvciXx5WbJKo48J6SUdVt08RGcoX+FHlPflr
   Jq1DQaNk1rXZyzJxFVVr5nzERDE2qWvOZIQ35ulEP+89kXEyKFRVjnoij
   c5zI+AGD3syGrdw8xz7r/mXvMGCuVDm2cTOKgR5WHxTXSN6KtCoNiNrSZ
   531VsGFzkVzskn1EDorTkcR2Du85UWIDI5mouPWeoyEi5Mg2oC4VaBkfi
   k45Q3zTGrYzVRmyez0HaJk/yYfmfTLKgTLHI8uZHOGQM40pg70fyl81zB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240735617"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="240735617"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 00:24:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="664517186"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 00:24:14 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] usb: typec: port-mapper: Convert to the component framework
Date:   Thu, 23 Dec 2021 11:24:22 +0300
Message-Id: <20211223082422.45637-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
References: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of trying to keep track of the connections to the
USB Type-C connectors separately, letting the component
framework take care of that.

From now on every USB Type-C connector will register itself
as "aggregate" - component master - and anything that can be
connected to it inside the system can then simply register
itself as a generic component.

The matching of the components and the connector shall rely
on ACPI _PLD initially. Before registering itself as the
aggregate, the connector will find all other ACPI devices
that have matching _PLD crc hash with it (matching value in
the pld_crc member of struct acpi_device), and add a
component match entry for each one of them. Because only
ACPI is supported for now, the driver shall only be build
when ACPI is supported.

This removes the need for the custom API that the driver
exposed. The components and the connector can therefore
exist completely independently of each other. The order in
which they are registered, as well as are they modules or
not, is now irrelevant.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/Makefile      |   3 +-
 drivers/usb/typec/class.c       |   2 -
 drivers/usb/typec/class.h       |  10 +-
 drivers/usb/typec/port-mapper.c | 279 +++++---------------------------
 include/linux/usb/typec.h       |  12 --
 5 files changed, 46 insertions(+), 260 deletions(-)

diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index a0adb8947a301..57870a2bd7873 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TYPEC)		+= typec.o
-typec-y				:= class.o mux.o bus.o port-mapper.o
+typec-y				:= class.o mux.o bus.o
+typec-$(CONFIG_ACPI)		+= port-mapper.o
 obj-$(CONFIG_TYPEC)		+= altmodes/
 obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
 obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index aeef453aa6585..45a6f0c807cb5 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2039,8 +2039,6 @@ struct typec_port *typec_register_port(struct device *parent,
 
 	ida_init(&port->mode_ids);
 	mutex_init(&port->port_type_lock);
-	mutex_init(&port->port_list_lock);
-	INIT_LIST_HEAD(&port->port_list);
 
 	port->id = id;
 	port->ops = cap->ops;
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index aef03eb7e1523..0f1bd6d19d67e 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -54,11 +54,6 @@ struct typec_port {
 
 	const struct typec_capability	*cap;
 	const struct typec_operations   *ops;
-
-	struct list_head		port_list;
-	struct mutex			port_list_lock; /* Port list lock */
-
-	void				*pld;
 };
 
 #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
@@ -79,7 +74,12 @@ extern const struct device_type typec_port_dev_type;
 extern struct class typec_mux_class;
 extern struct class typec_class;
 
+#if defined(CONFIG_ACPI)
 int typec_link_ports(struct typec_port *connector);
 void typec_unlink_ports(struct typec_port *connector);
+#else
+static inline int typec_link_ports(struct typec_port *connector) { return 0; }
+static inline void typec_unlink_ports(struct typec_port *connector) { }
+#endif
 
 #endif /* __USB_TYPEC_CLASS__ */
diff --git a/drivers/usb/typec/port-mapper.c b/drivers/usb/typec/port-mapper.c
index 9b0991bdf391a..07d307418b470 100644
--- a/drivers/usb/typec/port-mapper.c
+++ b/drivers/usb/typec/port-mapper.c
@@ -7,273 +7,72 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/usb.h>
-#include <linux/usb/typec.h>
+#include <linux/component.h>
 
 #include "class.h"
 
-struct port_node {
-	struct list_head list;
-	struct device *dev;
-	void *pld;
-};
-
-static int acpi_pld_match(const struct acpi_pld_info *pld1,
-			  const struct acpi_pld_info *pld2)
-{
-	if (!pld1 || !pld2)
-		return 0;
-
-	/*
-	 * To speed things up, first checking only the group_position. It seems
-	 * to often have the first unique value in the _PLD.
-	 */
-	if (pld1->group_position == pld2->group_position)
-		return !memcmp(pld1, pld2, sizeof(struct acpi_pld_info));
-
-	return 0;
-}
-
-static void *get_pld(struct device *dev)
+static int typec_aggregate_bind(struct device *dev)
 {
-#ifdef CONFIG_ACPI
-	struct acpi_pld_info *pld;
-	acpi_status status;
-
-	if (!has_acpi_companion(dev))
-		return NULL;
-
-	status = acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld);
-	if (ACPI_FAILURE(status))
-		return NULL;
-
-	return pld;
-#else
-	return NULL;
-#endif
-}
-
-static void free_pld(void *pld)
-{
-#ifdef CONFIG_ACPI
-	ACPI_FREE(pld);
-#endif
+	return component_bind_all(dev, NULL);
 }
 
-static int __link_port(struct typec_port *con, struct port_node *node)
+static void typec_aggregate_unbind(struct device *dev)
 {
-	int ret;
-
-	ret = sysfs_create_link(&node->dev->kobj, &con->dev.kobj, "connector");
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_link(&con->dev.kobj, &node->dev->kobj,
-				dev_name(node->dev));
-	if (ret) {
-		sysfs_remove_link(&node->dev->kobj, "connector");
-		return ret;
-	}
-
-	list_add_tail(&node->list, &con->port_list);
-
-	return 0;
+	component_unbind_all(dev, NULL);
 }
 
-static int link_port(struct typec_port *con, struct port_node *node)
-{
-	int ret;
-
-	mutex_lock(&con->port_list_lock);
-	ret = __link_port(con, node);
-	mutex_unlock(&con->port_list_lock);
-
-	return ret;
-}
-
-static void __unlink_port(struct typec_port *con, struct port_node *node)
-{
-	sysfs_remove_link(&con->dev.kobj, dev_name(node->dev));
-	sysfs_remove_link(&node->dev->kobj, "connector");
-	list_del(&node->list);
-}
-
-static void unlink_port(struct typec_port *con, struct port_node *node)
-{
-	mutex_lock(&con->port_list_lock);
-	__unlink_port(con, node);
-	mutex_unlock(&con->port_list_lock);
-}
-
-static struct port_node *create_port_node(struct device *port)
-{
-	struct port_node *node;
-
-	node = kzalloc(sizeof(*node), GFP_KERNEL);
-	if (!node)
-		return ERR_PTR(-ENOMEM);
-
-	node->dev = get_device(port);
-	node->pld = get_pld(port);
-
-	return node;
-}
-
-static void remove_port_node(struct port_node *node)
-{
-	put_device(node->dev);
-	free_pld(node->pld);
-	kfree(node);
-}
-
-static int connector_match(struct device *dev, const void *data)
-{
-	const struct port_node *node = data;
-
-	if (!is_typec_port(dev))
-		return 0;
-
-	return acpi_pld_match(to_typec_port(dev)->pld, node->pld);
-}
-
-static struct device *find_connector(struct port_node *node)
-{
-	if (!node->pld)
-		return NULL;
-
-	return class_find_device(&typec_class, NULL, node, connector_match);
-}
-
-/**
- * typec_link_port - Link a port to its connector
- * @port: The port device
- *
- * Find the connector of @port and create symlink named "connector" for it.
- * Returns 0 on success, or errno in case of a failure.
- *
- * NOTE. The function increments the reference count of @port on success.
- */
-int typec_link_port(struct device *port)
-{
-	struct device *connector;
-	struct port_node *node;
-	int ret;
-
-	node = create_port_node(port);
-	if (IS_ERR(node))
-		return PTR_ERR(node);
-
-	connector = find_connector(node);
-	if (!connector) {
-		ret = 0;
-		goto remove_node;
-	}
-
-	ret = link_port(to_typec_port(connector), node);
-	if (ret)
-		goto put_connector;
-
-	return 0;
-
-put_connector:
-	put_device(connector);
-remove_node:
-	remove_port_node(node);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(typec_link_port);
-
-static int port_match_and_unlink(struct device *connector, void *port)
-{
-	struct port_node *node;
-	struct port_node *tmp;
-	int ret = 0;
-
-	if (!is_typec_port(connector))
-		return 0;
-
-	mutex_lock(&to_typec_port(connector)->port_list_lock);
-	list_for_each_entry_safe(node, tmp, &to_typec_port(connector)->port_list, list) {
-		ret = node->dev == port;
-		if (ret) {
-			unlink_port(to_typec_port(connector), node);
-			remove_port_node(node);
-			put_device(connector);
-			break;
-		}
-	}
-	mutex_unlock(&to_typec_port(connector)->port_list_lock);
+static const struct component_master_ops typec_aggregate_ops = {
+	.bind = typec_aggregate_bind,
+	.unbind = typec_aggregate_unbind,
+};
 
-	return ret;
-}
+struct each_port_arg {
+	struct typec_port *port;
+	struct component_match *match;
+};
 
-/**
- * typec_unlink_port - Unlink port from its connector
- * @port: The port device
- *
- * Removes the symlink "connector" and decrements the reference count of @port.
- */
-void typec_unlink_port(struct device *port)
+static int typec_port_compare(struct device *dev, void *fwnode)
 {
-	class_for_each_device(&typec_class, NULL, port, port_match_and_unlink);
+	return device_match_fwnode(dev, fwnode);
 }
-EXPORT_SYMBOL_GPL(typec_unlink_port);
 
-static int each_port(struct device *port, void *connector)
+static int typec_port_match(struct device *dev, void *data)
 {
-	struct port_node *node;
-	int ret;
-
-	node = create_port_node(port);
-	if (IS_ERR(node))
-		return PTR_ERR(node);
+	struct acpi_device *adev = to_acpi_device(dev);
+	struct each_port_arg *arg = data;
+	struct acpi_device *con_adev;
 
-	if (!connector_match(connector, node)) {
-		remove_port_node(node);
+	con_adev = ACPI_COMPANION(&arg->port->dev);
+	if (con_adev == adev)
 		return 0;
-	}
-
-	ret = link_port(to_typec_port(connector), node);
-	if (ret) {
-		remove_port_node(node->pld);
-		return ret;
-	}
-
-	get_device(connector);
 
+	if (con_adev->pld_crc == adev->pld_crc)
+		component_match_add(&arg->port->dev, &arg->match, typec_port_compare,
+				    acpi_fwnode_handle(adev));
 	return 0;
 }
 
 int typec_link_ports(struct typec_port *con)
 {
-	int ret = 0;
+	struct each_port_arg arg = { .port = con, .match = NULL };
 
-	con->pld = get_pld(&con->dev);
-	if (!con->pld)
-		return 0;
+	bus_for_each_dev(&acpi_bus_type, NULL, &arg, typec_port_match);
 
-	ret = usb_for_each_port(&con->dev, each_port);
-	if (ret)
-		typec_unlink_ports(con);
-
-	return ret;
+	/*
+	 * REVISIT: Now each connector can have only a single component master.
+	 * So far only the USB ports connected to the USB Type-C connector share
+	 * the _PLD with it, but if there one day is something else (like maybe
+	 * the DisplayPort ACPI device object) that also shares the _PLD with
+	 * the connector, every one of those needs to have its own component
+	 * master, because each different type of component needs to be bind to
+	 * the connector independently of the other components. That requires
+	 * improvements to the component framework. Right now you can only have
+	 * one master per device.
+	 */
+	return component_master_add_with_match(&con->dev, &typec_aggregate_ops, arg.match);
 }
 
 void typec_unlink_ports(struct typec_port *con)
 {
-	struct port_node *node;
-	struct port_node *tmp;
-
-	mutex_lock(&con->port_list_lock);
-
-	list_for_each_entry_safe(node, tmp, &con->port_list, list) {
-		__unlink_port(con, node);
-		remove_port_node(node);
-		put_device(&con->dev);
-	}
-
-	mutex_unlock(&con->port_list_lock);
-
-	free_pld(con->pld);
+	component_master_del(&con->dev, &typec_aggregate_ops);
 }
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index e2e44bb1dad85..7ba45a97eeae3 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -305,16 +305,4 @@ void typec_partner_set_svdm_version(struct typec_partner *partner,
 				    enum usb_pd_svdm_ver svdm_version);
 int typec_get_negotiated_svdm_version(struct typec_port *port);
 
-#if IS_REACHABLE(CONFIG_TYPEC)
-int typec_link_port(struct device *port);
-void typec_unlink_port(struct device *port);
-#else
-static inline int typec_link_port(struct device *port)
-{
-	return 0;
-}
-
-static inline void typec_unlink_port(struct device *port) { }
-#endif
-
 #endif /* __LINUX_USB_TYPEC_H */
-- 
2.34.1

