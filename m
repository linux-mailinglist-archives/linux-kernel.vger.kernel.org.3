Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A92355A32C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiFXU6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiFXU6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:58:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37B11A80E;
        Fri, 24 Jun 2022 13:58:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o9so5048876edt.12;
        Fri, 24 Jun 2022 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=155eGLaVfsYg1uZ96Hc4viJr35SFIrp8VBxK1mzc1Hw=;
        b=KlM39a1EteRZ9Xnw7ncnM+PU173hbG+q0D0ZRnVThZqhHn6T/8VUa4KWonZtVhz8lC
         2oCnd3lw7Gp8MQ0FyMAc8H+YmlH0ZKeuMkROHQAOcCcOCQ+MXiY0KV+RXqxfLIy4jmyP
         qbqN8fCcGKtMuZIZJAeo3ZY02DNC0uw+PP2PXoWmIBbSD1OZIhMXk0y1InXmPDXJBe0Z
         q2h9VFoijg4qa4agnWFR4u1ZY0zlVPHdEcITfrok3174TuKI6Tm/IrgEqiiXQ+qOw2p7
         lmXCT09EiLyovVDJzzcdgl2EJx5SQpy84J9qh6/+8CyFw0q5mzlcjf2BHMLtdnlX0rxh
         EtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=155eGLaVfsYg1uZ96Hc4viJr35SFIrp8VBxK1mzc1Hw=;
        b=MqBT1SejF2O2ZtWSmaSXgzN1TDgvg4cR75iEYtCsvF2UHE8DuzBoWubD7RWA9AJsCa
         cVrGUTDK1tJ/bwPONH/o6vSZBs5Ra6NuU8HGsSyDFqtaBe6/83gFYtHB7Zt6h+6OJFww
         6Izn8CfAd4fY3oKxSiQq4V4CkmQJaV/9fVgpuyB3shCPoD25bF0U18wFUvrKkOByMDRp
         hwT6GpxuZkK4iFCtxoIveyn/0GY3EM0LmWK+ucFtfBhQ2KInEbeduvWqgRa4xeQRP8iw
         VIumi7IsDEanuNuPftadD4mcOGw0C8zyEylxN2/vbtZK5JyLbXgd7qeKPxm3wrid5o1A
         Fjrg==
X-Gm-Message-State: AJIora8JWPkS81Hr9mIF/9COSoOt6tvRU4+3Ejo5CM7upkjf3EpjrBSV
        YVzG7c+d3KyqC54rWl9KdfybGwvdq4I=
X-Google-Smtp-Source: AGRyM1vGzwxdGqXFpKq2LEic7aJDhaWoOcbVVmbmkF1VzZ4RG2kLqJcNpXkH4rSOLVAbY8sLy4H0RQ==
X-Received: by 2002:a05:6402:354d:b0:435:93f9:fc0b with SMTP id f13-20020a056402354d00b0043593f9fc0bmr1240272edd.288.1656104288922;
        Fri, 24 Jun 2022 13:58:08 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709061e4500b006feb6dee4absm1672666ejj.137.2022.06.24.13.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 13:58:08 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 1/3] platform/surface: aggregator: Move device registry helper functions to core module
Date:   Fri, 24 Jun 2022 22:57:58 +0200
Message-Id: <20220624205800.1355621-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624205800.1355621-1-luzmaximilian@gmail.com>
References: <20220624205800.1355621-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move helper functions for client device registration to the core module.
This simplifies addition of future DT/OF support and also allows us to
split out the device hub drivers into their own module.

At the same time, also improve device node validation a bit by not
silently skipping devices with invalid device UID specifiers. Further,
ensure proper lifetime management for the firmware/software nodes
associated with the added devices.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/bus.c     | 149 ++++++++++++++++--
 .../surface/surface_aggregator_registry.c     |  75 +--------
 include/linux/surface_aggregator/device.h     |  52 ++++++
 3 files changed, 187 insertions(+), 89 deletions(-)

diff --git a/drivers/platform/surface/aggregator/bus.c b/drivers/platform/surface/aggregator/bus.c
index abbbb5b08b07..e0b0381a2834 100644
--- a/drivers/platform/surface/aggregator/bus.c
+++ b/drivers/platform/surface/aggregator/bus.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include <linux/surface_aggregator/controller.h>
@@ -14,6 +15,9 @@
 #include "bus.h"
 #include "controller.h"
 
+
+/* -- Device and bus functions. --------------------------------------------- */
+
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -46,6 +50,7 @@ static void ssam_device_release(struct device *dev)
 	struct ssam_device *sdev = to_ssam_device(dev);
 
 	ssam_controller_put(sdev->ctrl);
+	fwnode_handle_put(sdev->dev.fwnode);
 	kfree(sdev);
 }
 
@@ -363,6 +368,134 @@ void ssam_device_driver_unregister(struct ssam_device_driver *sdrv)
 }
 EXPORT_SYMBOL_GPL(ssam_device_driver_unregister);
 
+
+/* -- Bus registration. ----------------------------------------------------- */
+
+/**
+ * ssam_bus_register() - Register and set-up the SSAM client device bus.
+ */
+int ssam_bus_register(void)
+{
+	return bus_register(&ssam_bus_type);
+}
+
+/**
+ * ssam_bus_unregister() - Unregister the SSAM client device bus.
+ */
+void ssam_bus_unregister(void)
+{
+	return bus_unregister(&ssam_bus_type);
+}
+
+
+/* -- Helpers for controller and hub devices. ------------------------------- */
+
+static int ssam_device_uid_from_string(const char *str, struct ssam_device_uid *uid)
+{
+	u8 d, tc, tid, iid, fn;
+	int n;
+
+	n = sscanf(str, "%hhx:%hhx:%hhx:%hhx:%hhx", &d, &tc, &tid, &iid, &fn);
+	if (n != 5)
+		return -EINVAL;
+
+	uid->domain = d;
+	uid->category = tc;
+	uid->target = tid;
+	uid->instance = iid;
+	uid->function = fn;
+
+	return 0;
+}
+
+static int ssam_get_uid_for_node(struct fwnode_handle *node, struct ssam_device_uid *uid)
+{
+	const char *str = fwnode_get_name(node);
+
+	/*
+	 * To simplify definitions of firmware nodes, we set the device name
+	 * based on the UID of the device, prefixed with "ssam:".
+	 */
+	if (strncmp(str, "ssam:", strlen("ssam:")) != 0)
+		return -ENODEV;
+
+	str += strlen("ssam:");
+	return ssam_device_uid_from_string(str, uid);
+}
+
+static int ssam_add_client_device(struct device *parent, struct ssam_controller *ctrl,
+				  struct fwnode_handle *node)
+{
+	struct ssam_device_uid uid;
+	struct ssam_device *sdev;
+	int status;
+
+	status = ssam_get_uid_for_node(node, &uid);
+	if (status)
+		return status;
+
+	sdev = ssam_device_alloc(ctrl, uid);
+	if (!sdev)
+		return -ENOMEM;
+
+	sdev->dev.parent = parent;
+	sdev->dev.fwnode = fwnode_handle_get(node);
+
+	status = ssam_device_add(sdev);
+	if (status)
+		ssam_device_put(sdev);
+
+	return status;
+}
+
+/**
+ * __ssam_register_clients() - Register client devices defined under the
+ * given firmware node as children of the given device.
+ * @parent: The parent device under which clients should be registered.
+ * @ctrl: The controller with which client should be registered.
+ * @node: The firmware node holding definitions of the devices to be added.
+ *
+ * Register all clients that have been defined as children of the given root
+ * firmware node as children of the given parent device. The respective child
+ * firmware nodes will be associated with the correspondingly created child
+ * devices.
+ *
+ * The given controller will be used to instantiate the new devices. See
+ * ssam_device_add() for details.
+ *
+ * Note that, generally, the use of either ssam_device_register_clients() or
+ * ssam_register_clients() should be preferred as they directly use the
+ * firmware node and/or controller associated with the given device. This
+ * function is only intended for use when different device specifications (e.g.
+ * ACPI and firmware nodes) need to be combined (as is done in the platform hub
+ * of the device registry).
+ *
+ * Return: Returns zero on success, nonzero on failure.
+ */
+int __ssam_register_clients(struct device *parent, struct ssam_controller *ctrl,
+			    struct fwnode_handle *node)
+{
+	struct fwnode_handle *child;
+	int status;
+
+	fwnode_for_each_child_node(node, child) {
+		/*
+		 * Try to add the device specified in the firmware node. If
+		 * this fails with -ENODEV, the node does not specify any SSAM
+		 * device, so ignore it and continue with the next one.
+		 */
+		status = ssam_add_client_device(parent, ctrl, child);
+		if (status && status != -ENODEV)
+			goto err;
+	}
+
+	return 0;
+err:
+	ssam_remove_clients(parent);
+	return status;
+}
+EXPORT_SYMBOL_GPL(__ssam_register_clients);
+
 static int ssam_remove_device(struct device *dev, void *_data)
 {
 	struct ssam_device *sdev = to_ssam_device(dev);
@@ -387,19 +520,3 @@ void ssam_remove_clients(struct device *dev)
 	device_for_each_child_reverse(dev, NULL, ssam_remove_device);
 }
 EXPORT_SYMBOL_GPL(ssam_remove_clients);
-
-/**
- * ssam_bus_register() - Register and set-up the SSAM client device bus.
- */
-int ssam_bus_register(void)
-{
-	return bus_register(&ssam_bus_type);
-}
-
-/**
- * ssam_bus_unregister() - Unregister the SSAM client device bus.
- */
-void ssam_bus_unregister(void)
-{
-	return bus_unregister(&ssam_bus_type);
-}
diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index f1c5905f1c16..c680792a037e 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -286,76 +286,6 @@ static const struct software_node *ssam_node_group_sp8[] = {
 };
 
 
-/* -- Device registry helper functions. ------------------------------------- */
-
-static int ssam_uid_from_string(const char *str, struct ssam_device_uid *uid)
-{
-	u8 d, tc, tid, iid, fn;
-	int n;
-
-	n = sscanf(str, "ssam:%hhx:%hhx:%hhx:%hhx:%hhx", &d, &tc, &tid, &iid, &fn);
-	if (n != 5)
-		return -EINVAL;
-
-	uid->domain = d;
-	uid->category = tc;
-	uid->target = tid;
-	uid->instance = iid;
-	uid->function = fn;
-
-	return 0;
-}
-
-static int ssam_hub_add_device(struct device *parent, struct ssam_controller *ctrl,
-			       struct fwnode_handle *node)
-{
-	struct ssam_device_uid uid;
-	struct ssam_device *sdev;
-	int status;
-
-	status = ssam_uid_from_string(fwnode_get_name(node), &uid);
-	if (status)
-		return status;
-
-	sdev = ssam_device_alloc(ctrl, uid);
-	if (!sdev)
-		return -ENOMEM;
-
-	sdev->dev.parent = parent;
-	sdev->dev.fwnode = node;
-
-	status = ssam_device_add(sdev);
-	if (status)
-		ssam_device_put(sdev);
-
-	return status;
-}
-
-static int ssam_hub_register_clients(struct device *parent, struct ssam_controller *ctrl,
-				     struct fwnode_handle *node)
-{
-	struct fwnode_handle *child;
-	int status;
-
-	fwnode_for_each_child_node(node, child) {
-		/*
-		 * Try to add the device specified in the firmware node. If
-		 * this fails with -EINVAL, the node does not specify any SSAM
-		 * device, so ignore it and continue with the next one.
-		 */
-
-		status = ssam_hub_add_device(parent, ctrl, child);
-		if (status && status != -EINVAL)
-			goto err;
-	}
-
-	return 0;
-err:
-	ssam_remove_clients(parent);
-	return status;
-}
-
-
 /* -- SSAM generic subsystem hub driver framework. -------------------------- */
 
 enum ssam_hub_state {
@@ -385,7 +315,6 @@ struct ssam_hub {
 static void ssam_hub_update_workfn(struct work_struct *work)
 {
 	struct ssam_hub *hub = container_of(work, struct ssam_hub, update_work.work);
-	struct fwnode_handle *node = dev_fwnode(&hub->sdev->dev);
 	enum ssam_hub_state state;
 	int status = 0;
 
@@ -425,7 +354,7 @@ static void ssam_hub_update_workfn(struct work_struct *work)
 	hub->state = state;
 
 	if (hub->state == SSAM_HUB_CONNECTED)
-		status = ssam_hub_register_clients(&hub->sdev->dev, hub->sdev->ctrl, node);
+		status = ssam_device_register_clients(hub->sdev);
 	else
 		ssam_remove_clients(&hub->sdev->dev);
 
@@ -769,7 +698,7 @@ static int ssam_platform_hub_probe(struct platform_device *pdev)
 
 	set_secondary_fwnode(&pdev->dev, root);
 
-	status = ssam_hub_register_clients(&pdev->dev, ctrl, root);
+	status = __ssam_register_clients(&pdev->dev, ctrl, root);
 	if (status) {
 		set_secondary_fwnode(&pdev->dev, NULL);
 		software_node_unregister_node_group(nodes);
diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 6cf7e80312d5..46c45d1b6368 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -15,6 +15,7 @@
 
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/types.h>
 
 #include <linux/surface_aggregator/controller.h>
@@ -375,11 +376,62 @@ void ssam_device_driver_unregister(struct ssam_device_driver *d);
 /* -- Helpers for controller and hub devices. ------------------------------- */
 
 #ifdef CONFIG_SURFACE_AGGREGATOR_BUS
+
+int __ssam_register_clients(struct device *parent, struct ssam_controller *ctrl,
+			    struct fwnode_handle *node);
 void ssam_remove_clients(struct device *dev);
+
 #else /* CONFIG_SURFACE_AGGREGATOR_BUS */
+
+static inline int __ssam_register_clients(struct device *parent, struct ssam_controller *ctrl,
+					  struct fwnode_handle *node)
+{
+	return 0;
+}
+
 static inline void ssam_remove_clients(struct device *dev) {}
+
 #endif /* CONFIG_SURFACE_AGGREGATOR_BUS */
 
+/**
+ * ssam_register_clients() - Register all client devices defined under the
+ * given parent device.
+ * @dev: The parent device under which clients should be registered.
+ * @ctrl: The controller with which client should be registered.
+ *
+ * Register all clients that have via firmware nodes been defined as children
+ * of the given (parent) device. The respective child firmware nodes will be
+ * associated with the correspondingly created child devices.
+ *
+ * The given controller will be used to instantiate the new devices. See
+ * ssam_device_add() for details.
+ *
+ * Return: Returns zero on success, nonzero on failure.
+ */
+static inline int ssam_register_clients(struct device *dev, struct ssam_controller *ctrl)
+{
+	return __ssam_register_clients(dev, ctrl, dev_fwnode(dev));
+}
+
+/**
+ * ssam_device_register_clients() - Register all client devices defined under
+ * the given SSAM parent device.
+ * @sdev: The parent device under which clients should be registered.
+ *
+ * Register all clients that have via firmware nodes been defined as children
+ * of the given (parent) device. The respective child firmware nodes will be
+ * associated with the correspondingly created child devices.
+ *
+ * The controller used by the parent device will be used to instantiate the new
+ * devices. See ssam_device_add() for details.
+ *
+ * Return: Returns zero on success, nonzero on failure.
+ */
+static inline int ssam_device_register_clients(struct ssam_device *sdev)
+{
+	return ssam_register_clients(&sdev->dev, sdev->ctrl);
+}
+
 
 /* -- Helpers for client-device requests. ----------------------------------- */
 
-- 
2.36.1

