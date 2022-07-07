Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1718556AE46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiGGWVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbiGGWVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:21:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A61606A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:21:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id z1so9068593plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kt2LT6comTdXal4bhZijB53lifz1SzMyQpue9XFgaFU=;
        b=ML+oKPJ6Vn7q/ffwa+Pc6BfQ2XngIR3J7/7hUDBxYEpUuJKTm6D8Gfz7vDo9wz7JhA
         5YqPmye/+3j82YMycaGwU26RGwNo3frSketmUbiS1qMPhepi16oEbdUf12oDfzVLZU37
         rXpEd8wPL8PSvXuMuVrAnLbEap/7/7Nu++8ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kt2LT6comTdXal4bhZijB53lifz1SzMyQpue9XFgaFU=;
        b=pcR9bEUn2XCGhgXl01rqN2UwIhmRSEoXO6g+IU82eXGoTTKzeBVrpFhD7Xn15hYbpN
         PPirLRPxR63e/XDCXKceDhpTfKUpKWgSKmIZtnvWgagEtE6cJcDyWmSBh6xG9cXnrHAW
         EvJib9q+2BGHSGgzifj6ANMFdhiatZiG/X6ejXhPxxEyFbnzsEyHQN/SBlz18o24L3VV
         r0yLoycxnivP8094kZsQyhMCXcKuKqPL3BitvVbga9CahnH6FhmQwJwloERx2pblgdFt
         saK0N+HGU3PZ+lNadMtJ02qHDLhe7CXv09ky4XYBA2I/+PC92gftPvvM6T7BdSqPrfgJ
         FOWw==
X-Gm-Message-State: AJIora/cm8zQspgxEyIJdCTuMu1TEN6XNtDiEwIp5Ok+gc4qdma4Oe7/
        X/wWzwMSHPKEndjAXaJTTpDRf408U7gB5g==
X-Google-Smtp-Source: AGRyM1uVdavt/OgJOQdEfCgPR2xi3Z69IIBv53n1jt2AnDu7jXoLB9B0liJpKLSV45avmXRH8DB5wg==
X-Received: by 2002:a17:903:1c4:b0:16b:7928:95ce with SMTP id e4-20020a17090301c400b0016b792895cemr242280plh.158.1657232490601;
        Thu, 07 Jul 2022 15:21:30 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 66-20020a620445000000b005289bfcee91sm5545657pfe.59.2022.07.07.15.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:21:30 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v3 1/9] usb: typec: Add support for retimers
Date:   Thu,  7 Jul 2022 22:20:08 +0000
Message-Id: <20220707222045.1415417-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220707222045.1415417-1-pmalani@chromium.org>
References: <20220707222045.1415417-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a retimer device class and associated functions that register
and use retimer "switch" devices. These operate in a manner similar to
the "mode-switch" and help configure retimers that exist between the
Type-C connector and host controller(s).

Type C ports can be linked to retimers using firmware node device
references (again, in a manner similar to "mode-switch").

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v2:
- No changes.

Changes since v1:
- Change class name to "retimer"
- Change device type to "typec_retimer".

 drivers/usb/typec/Makefile        |   2 +-
 drivers/usb/typec/class.c         |   9 +-
 drivers/usb/typec/class.h         |   1 +
 drivers/usb/typec/retimer.c       | 168 ++++++++++++++++++++++++++++++
 drivers/usb/typec/retimer.h       |  15 +++
 include/linux/usb/typec_retimer.h |  45 ++++++++
 6 files changed, 238 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/typec/retimer.c
 create mode 100644 drivers/usb/typec/retimer.h
 create mode 100644 include/linux/usb/typec_retimer.h

diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 2f174cd3e5df..4955d9af0811 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TYPEC)		+= typec.o
-typec-y				:= class.o mux.o bus.o pd.o
+typec-y				:= class.o mux.o bus.o pd.o retimer.o
 typec-$(CONFIG_ACPI)		+= port-mapper.o
 obj-$(CONFIG_TYPEC)		+= altmodes/
 obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index bbc46b14f99a..9062836bb638 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2299,10 +2299,14 @@ static int __init typec_init(void)
 	if (ret)
 		goto err_unregister_bus;
 
-	ret = class_register(&typec_class);
+	ret = class_register(&retimer_class);
 	if (ret)
 		goto err_unregister_mux_class;
 
+	ret = class_register(&typec_class);
+	if (ret)
+		goto err_unregister_retimer_class;
+
 	ret = usb_power_delivery_init();
 	if (ret)
 		goto err_unregister_class;
@@ -2312,6 +2316,9 @@ static int __init typec_init(void)
 err_unregister_class:
 	class_unregister(&typec_class);
 
+err_unregister_retimer_class:
+	class_unregister(&retimer_class);
+
 err_unregister_mux_class:
 	class_unregister(&typec_mux_class);
 
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index b531f9853bc0..43fcf9e37a8c 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -76,6 +76,7 @@ extern const struct device_type typec_port_dev_type;
 #define is_typec_port(dev) ((dev)->type == &typec_port_dev_type)
 
 extern struct class typec_mux_class;
+extern struct class retimer_class;
 extern struct class typec_class;
 
 #if defined(CONFIG_ACPI)
diff --git a/drivers/usb/typec/retimer.c b/drivers/usb/typec/retimer.c
new file mode 100644
index 000000000000..051eaa7d2899
--- /dev/null
+++ b/drivers/usb/typec/retimer.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 Google LLC
+ *
+ * USB Type-C Retimer support.
+ * Author: Prashant Malani <pmalani@chromium.org>
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#include "class.h"
+#include "retimer.h"
+
+static bool dev_name_ends_with(struct device *dev, const char *suffix)
+{
+	const char *name = dev_name(dev);
+	const int name_len = strlen(name);
+	const int suffix_len = strlen(suffix);
+
+	if (suffix_len > name_len)
+		return false;
+
+	return strcmp(name + (name_len - suffix_len), suffix) == 0;
+}
+
+static int retimer_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-retimer");
+}
+
+static void *typec_retimer_match(struct fwnode_handle *fwnode, const char *id, void *data)
+{
+	struct device *dev  = class_find_device(&retimer_class, NULL, fwnode,
+						retimer_fwnode_match);
+
+	return dev ? to_typec_retimer(dev) : ERR_PTR(-EPROBE_DEFER);
+}
+
+/**
+ * fwnode_typec_retimer_get - Find USB Type-C retimer.
+ * @fwnode: The caller device node.
+ *
+ * Finds a retimer linked to the caller. This function is primarily meant for the
+ * Type-C drivers. Returns a reference to the retimer on success, NULL if no
+ * matching connection was found, or ERR_PTR(-EPROBE_DEFER) when a connection
+ * was found but the retimer has not been enumerated yet.
+ */
+struct typec_retimer *fwnode_typec_retimer_get(struct fwnode_handle *fwnode)
+{
+	struct typec_retimer *retimer;
+
+	retimer = fwnode_connection_find_match(fwnode, "retimer-switch", NULL, typec_retimer_match);
+	if (!IS_ERR_OR_NULL(retimer))
+		WARN_ON(!try_module_get(retimer->dev.parent->driver->owner));
+
+	return retimer;
+}
+EXPORT_SYMBOL_GPL(fwnode_typec_retimer_get);
+
+/**
+ * typec_retimer_put - Release handle to a retimer.
+ * @retimer: USB Type-C Connector Retimer.
+ *
+ * Decrements reference count for @retimer.
+ */
+void typec_retimer_put(struct typec_retimer *retimer)
+{
+	if (!IS_ERR_OR_NULL(retimer)) {
+		module_put(retimer->dev.parent->driver->owner);
+		put_device(&retimer->dev);
+	}
+}
+EXPORT_SYMBOL_GPL(typec_retimer_put);
+
+int typec_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
+{
+	if (IS_ERR_OR_NULL(retimer))
+		return 0;
+
+	return retimer->set(retimer, state);
+}
+EXPORT_SYMBOL_GPL(typec_retimer_set);
+
+static void typec_retimer_release(struct device *dev)
+{
+	kfree(to_typec_retimer(dev));
+}
+
+static const struct device_type typec_retimer_dev_type = {
+	.name = "typec_retimer",
+	.release = typec_retimer_release,
+};
+
+/**
+ * typec_retimer_register - Register a retimer device.
+ * @parent: Parent device.
+ * @desc: Retimer description.
+ *
+ * Some USB Type-C connectors have their physical lines routed through retimers before they
+ * reach muxes or host controllers. In some cases (for example: using alternate modes)
+ * these retimers need to be reconfigured appropriately. This function registers retimer
+ * switches which route and potentially modify the signals on the Type C physical lines
+ * enroute to the host controllers.
+ */
+struct typec_retimer *
+typec_retimer_register(struct device *parent, const struct typec_retimer_desc *desc)
+{
+	struct typec_retimer *retimer;
+	int ret;
+
+	if (!desc || !desc->set)
+		return ERR_PTR(-EINVAL);
+
+	retimer = kzalloc(sizeof(*retimer), GFP_KERNEL);
+	if (!retimer)
+		return ERR_PTR(-ENOMEM);
+
+	retimer->set = desc->set;
+
+	device_initialize(&retimer->dev);
+	retimer->dev.parent = parent;
+	retimer->dev.fwnode = desc->fwnode;
+	retimer->dev.class = &retimer_class;
+	retimer->dev.type = &typec_retimer_dev_type;
+	retimer->dev.driver_data = desc->drvdata;
+	dev_set_name(&retimer->dev, "%s-retimer",
+		     desc->name ? desc->name : dev_name(parent));
+
+	ret = device_add(&retimer->dev);
+	if (ret) {
+		dev_err(parent, "failed to register retimer (%d)\n", ret);
+		put_device(&retimer->dev);
+		return ERR_PTR(ret);
+	}
+
+	return retimer;
+}
+EXPORT_SYMBOL_GPL(typec_retimer_register);
+
+/**
+ * typec_retimer_unregister - Unregister retimer device.
+ * @retimer: USB Type-C Connector retimer.
+ *
+ * Unregister retimer that was registered with typec_retimer_register().
+ */
+void typec_retimer_unregister(struct typec_retimer *retimer)
+{
+	if (!IS_ERR_OR_NULL(retimer))
+		device_unregister(&retimer->dev);
+}
+EXPORT_SYMBOL_GPL(typec_retimer_unregister);
+
+void *typec_retimer_get_drvdata(struct typec_retimer *retimer)
+{
+	return dev_get_drvdata(&retimer->dev);
+}
+EXPORT_SYMBOL_GPL(typec_retimer_get_drvdata);
+
+struct class retimer_class = {
+	.name = "retimer",
+	.owner = THIS_MODULE,
+};
diff --git a/drivers/usb/typec/retimer.h b/drivers/usb/typec/retimer.h
new file mode 100644
index 000000000000..fa15951d4846
--- /dev/null
+++ b/drivers/usb/typec/retimer.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __USB_TYPEC_RETIMER__
+#define __USB_TYPEC_RETIMER__
+
+#include <linux/usb/typec_retimer.h>
+
+struct typec_retimer {
+	struct device dev;
+	typec_retimer_set_fn_t set;
+};
+
+#define to_typec_retimer(_dev_) container_of(_dev_, struct typec_retimer, dev)
+
+#endif /* __USB_TYPEC_RETIMER__ */
diff --git a/include/linux/usb/typec_retimer.h b/include/linux/usb/typec_retimer.h
new file mode 100644
index 000000000000..5e036b3360e2
--- /dev/null
+++ b/include/linux/usb/typec_retimer.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __USB_TYPEC_RETIMER
+#define __USB_TYPEC_RETIMER
+
+#include <linux/property.h>
+#include <linux/usb/typec.h>
+
+struct device;
+struct typec_retimer;
+struct typec_altmode;
+struct fwnode_handle;
+
+struct typec_retimer_state {
+	struct typec_altmode *alt;
+	unsigned long mode;
+	void *data;
+};
+
+typedef int (*typec_retimer_set_fn_t)(struct typec_retimer *retimer,
+				      struct typec_retimer_state *state);
+
+struct typec_retimer_desc {
+	struct fwnode_handle *fwnode;
+	typec_retimer_set_fn_t set;
+	const char *name;
+	void *drvdata;
+};
+
+struct typec_retimer *fwnode_typec_retimer_get(struct fwnode_handle *fwnode);
+void typec_retimer_put(struct typec_retimer *retimer);
+int typec_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state);
+
+static inline struct typec_retimer *typec_retimer_get(struct device *dev)
+{
+	return fwnode_typec_retimer_get(dev_fwnode(dev));
+}
+
+struct typec_retimer *
+typec_retimer_register(struct device *parent, const struct typec_retimer_desc *desc);
+void typec_retimer_unregister(struct typec_retimer *retimer);
+
+void *typec_retimer_get_drvdata(struct typec_retimer *retimer);
+
+#endif /* __USB_TYPEC_RETIMER */
-- 
2.37.0.rc0.161.g10f37bed90-goog

