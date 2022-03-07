Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F2F4CF072
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbiCGDkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiCGDjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:39:53 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0BC4FC6E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:38:58 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso686157otj.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 19:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IfB2S6XxO3oINLSkwXHzJlzWc8RiEjEhsMeXd4hcF6A=;
        b=q9NJbfyaNZ+n0z0TuxIX2DFnL6ssvTr9720aleQGkjRaKmVZIifRbL+I1BP7vnuXXe
         nJmSbpJKaybbrQpoyAJMYPzn3ch2wLAQuKWsAC6JqoRvV1HVDgpulR9bEFQc7YgdQxVr
         YmJwePx8kAR0f6KanwVkiCMqVUiiCu5DNfR18aUQnb+WpSWjnKlwAqyEpVwZ86mWEzfm
         RPs1eZXIMzEupBSFnlECOTQ6ytZcU3xf8DdJ2kdAV4sFLYf4Ys1+Zct+hzVCEb7B6nE5
         RxycW4vrO0GAueTeTl3Ayb4bZK8WuegpZSMDo5pB9jZdPi8OlLqWEvG8c5sP8T+SmzAY
         QzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IfB2S6XxO3oINLSkwXHzJlzWc8RiEjEhsMeXd4hcF6A=;
        b=2epTUtwc60fwfVnbJQ2Q/q7sbjMrkp37k91LSNCCMBlC/HM7lYo5d9WrtDHVEZDkF8
         VJ0vVHLIro7iXblRNVl6Jwy9QtES5co23YGWh4gq4D6xNG280rzw6u/XhKaf/jAu3gHH
         B1QCKoIny0tw/wZBN58ghzNLWVtzDV2XcxP2HVVfyTNer6YUjPEG+jnJD//5kEnCUS9S
         yMnkg6qZ861dHucm1lPl+4+xr4XHyZLicWoo3KoXunjlDlp89tabpMZSGF9dzyM8CJeg
         e4h8T3kfUva53ETfkCDZHqzNaL41oso3DtFMgpWdqkh3TNYrLBvZdhNjzktw9qQvIQnd
         5jsg==
X-Gm-Message-State: AOAM532bsIJRnBE4Wertkfui5ijg9XffHI6e5yjI44fNszoQZfX07tbv
        13sDyuJFVIxcoR3dx1nYcyaD8g==
X-Google-Smtp-Source: ABdhPJx0C3QTWTO1qhOgp0Bg2EvTmPfKigT/v2zBJvXoaQNhDURC9LT7Z7agcbOpvmlcJSqmdi8qtQ==
X-Received: by 2002:a9d:5783:0:b0:5b2:379f:1b6f with SMTP id q3-20020a9d5783000000b005b2379f1b6fmr617267oth.209.1646624337698;
        Sun, 06 Mar 2022 19:38:57 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id o2-20020a05687072c200b000d9ae3e1fabsm5005172oak.12.2022.03.06.19.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 19:38:57 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 4/7] usb: typec: mux: Introduce indirection
Date:   Sun,  6 Mar 2022 19:40:37 -0800
Message-Id: <20220307034040.1111107-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than directly exposing the implementation's representation of the
typec muxes to the controller/clients, introduce an indirection object.

This enables the introduction of turning this relationship into a
one-to-many in the following patch.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Rebase ontop of new patch 3/7.
- Added "usb: " prefix to subject

Changes since v2:
- Picked up Heikki's ack.

Changes since v1:
- None

 drivers/usb/typec/bus.c               |   2 +-
 drivers/usb/typec/mux.c               | 193 ++++++++++++++++----------
 drivers/usb/typec/mux.h               |  12 +-
 drivers/usb/typec/mux/intel_pmc_mux.c |   8 +-
 drivers/usb/typec/mux/pi3usb30532.c   |   8 +-
 include/linux/usb/typec_mux.h         |  22 +--
 6 files changed, 148 insertions(+), 97 deletions(-)

diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index 78e0e78954f2..26ea2fdec17d 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -24,7 +24,7 @@ typec_altmode_set_mux(struct altmode *alt, unsigned long conf, void *data)
 	state.mode = conf;
 	state.data = data;
 
-	return alt->mux->set(alt->mux, &state);
+	return typec_mux_set(alt->mux, &state);
 }
 
 static int typec_altmode_set_state(struct typec_altmode *adev,
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index d2aaf294b649..bb6c095b4af9 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -17,9 +17,13 @@
 #include "class.h"
 #include "mux.h"
 
+struct typec_switch {
+	struct typec_switch_dev *sw_dev;
+};
+
 static int switch_fwnode_match(struct device *dev, const void *fwnode)
 {
-	if (!is_typec_switch(dev))
+	if (!is_typec_switch_dev(dev))
 		return 0;
 
 	return dev_fwnode(dev) == fwnode;
@@ -49,7 +53,7 @@ static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				switch_fwnode_match);
 
-	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
+	return dev ? to_typec_switch_dev(dev) : ERR_PTR(-EPROBE_DEFER);
 }
 
 /**
@@ -63,12 +67,23 @@ static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
  */
 struct typec_switch *fwnode_typec_switch_get(struct fwnode_handle *fwnode)
 {
+	struct typec_switch_dev *sw_dev;
 	struct typec_switch *sw;
 
-	sw = fwnode_connection_find_match(fwnode, "orientation-switch", NULL,
-					  typec_switch_match);
-	if (!IS_ERR_OR_NULL(sw))
-		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
+	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
+	if (!sw)
+		return ERR_PTR(-ENOMEM);
+
+	sw_dev = fwnode_connection_find_match(fwnode, "orientation-switch", NULL,
+					      typec_switch_match);
+	if (IS_ERR_OR_NULL(sw_dev)) {
+		kfree(sw);
+		return ERR_CAST(sw_dev);
+	}
+
+	WARN_ON(!try_module_get(sw_dev->dev.parent->driver->owner));
+
+	sw->sw_dev = sw_dev;
 
 	return sw;
 }
@@ -82,16 +97,22 @@ EXPORT_SYMBOL_GPL(fwnode_typec_switch_get);
  */
 void typec_switch_put(struct typec_switch *sw)
 {
-	if (!IS_ERR_OR_NULL(sw)) {
-		module_put(sw->dev.parent->driver->owner);
-		put_device(&sw->dev);
-	}
+	struct typec_switch_dev *sw_dev;
+
+	if (IS_ERR_OR_NULL(sw))
+		return;
+
+	sw_dev = sw->sw_dev;
+
+	module_put(sw_dev->dev.parent->driver->owner);
+	put_device(&sw_dev->dev);
+	kfree(sw);
 }
 EXPORT_SYMBOL_GPL(typec_switch_put);
 
 static void typec_switch_release(struct device *dev)
 {
-	kfree(to_typec_switch(dev));
+	kfree(to_typec_switch_dev(dev));
 }
 
 const struct device_type typec_switch_dev_type = {
@@ -109,85 +130,93 @@ const struct device_type typec_switch_dev_type = {
  * connector to the USB controllers. USB Type-C plugs can be inserted
  * right-side-up or upside-down.
  */
-struct typec_switch *
+struct typec_switch_dev *
 typec_switch_register(struct device *parent,
 		      const struct typec_switch_desc *desc)
 {
-	struct typec_switch *sw;
+	struct typec_switch_dev *sw_dev;
 	int ret;
 
 	if (!desc || !desc->set)
 		return ERR_PTR(-EINVAL);
 
-	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
-	if (!sw)
+	sw_dev = kzalloc(sizeof(*sw_dev), GFP_KERNEL);
+	if (!sw_dev)
 		return ERR_PTR(-ENOMEM);
 
-	sw->set = desc->set;
+	sw_dev->set = desc->set;
 
-	device_initialize(&sw->dev);
-	sw->dev.parent = parent;
-	sw->dev.fwnode = desc->fwnode;
-	sw->dev.class = &typec_mux_class;
-	sw->dev.type = &typec_switch_dev_type;
-	sw->dev.driver_data = desc->drvdata;
-	ret = dev_set_name(&sw->dev, "%s-switch", desc->name ? desc->name : dev_name(parent));
+	device_initialize(&sw_dev->dev);
+	sw_dev->dev.parent = parent;
+	sw_dev->dev.fwnode = desc->fwnode;
+	sw_dev->dev.class = &typec_mux_class;
+	sw_dev->dev.type = &typec_switch_dev_type;
+	sw_dev->dev.driver_data = desc->drvdata;
+	ret = dev_set_name(&sw_dev->dev, "%s-switch", desc->name ? desc->name : dev_name(parent));
 	if (ret) {
-		put_device(&sw->dev);
+		put_device(&sw_dev->dev);
 		return ERR_PTR(ret);
 	}
 
-	ret = device_add(&sw->dev);
+	ret = device_add(&sw_dev->dev);
 	if (ret) {
 		dev_err(parent, "failed to register switch (%d)\n", ret);
-		put_device(&sw->dev);
+		put_device(&sw_dev->dev);
 		return ERR_PTR(ret);
 	}
 
-	return sw;
+	return sw_dev;
 }
 EXPORT_SYMBOL_GPL(typec_switch_register);
 
 int typec_switch_set(struct typec_switch *sw,
 		     enum typec_orientation orientation)
 {
+	struct typec_switch_dev *sw_dev;
+
 	if (IS_ERR_OR_NULL(sw))
 		return 0;
 
-	return sw->set(sw, orientation);
+	sw_dev = sw->sw_dev;
+
+	return sw_dev->set(sw_dev, orientation);
 }
 EXPORT_SYMBOL_GPL(typec_switch_set);
 
 /**
  * typec_switch_unregister - Unregister USB Type-C orientation switch
- * @sw: USB Type-C orientation switch
+ * @sw_dev: USB Type-C orientation switch
  *
  * Unregister switch that was registered with typec_switch_register().
  */
-void typec_switch_unregister(struct typec_switch *sw)
+void typec_switch_unregister(struct typec_switch_dev *sw_dev)
 {
-	if (!IS_ERR_OR_NULL(sw))
-		device_unregister(&sw->dev);
+	if (!IS_ERR_OR_NULL(sw_dev))
+		device_unregister(&sw_dev->dev);
 }
 EXPORT_SYMBOL_GPL(typec_switch_unregister);
 
-void typec_switch_set_drvdata(struct typec_switch *sw, void *data)
+void typec_switch_set_drvdata(struct typec_switch_dev *sw_dev, void *data)
 {
-	dev_set_drvdata(&sw->dev, data);
+	dev_set_drvdata(&sw_dev->dev, data);
 }
 EXPORT_SYMBOL_GPL(typec_switch_set_drvdata);
 
-void *typec_switch_get_drvdata(struct typec_switch *sw)
+void *typec_switch_get_drvdata(struct typec_switch_dev *sw_dev)
 {
-	return dev_get_drvdata(&sw->dev);
+	return dev_get_drvdata(&sw_dev->dev);
 }
 EXPORT_SYMBOL_GPL(typec_switch_get_drvdata);
 
 /* ------------------------------------------------------------------------- */
 
+struct typec_mux {
+	struct typec_mux_dev *mux_dev;
+};
+
 static int mux_fwnode_match(struct device *dev, const void *fwnode)
 {
-	if (!is_typec_mux(dev))
+	if (!is_typec_mux_dev(dev))
 		return 0;
 
 	return dev_fwnode(dev) == fwnode;
@@ -249,7 +278,7 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				mux_fwnode_match);
 
-	return dev ? to_typec_mux(dev) : ERR_PTR(-EPROBE_DEFER);
+	return dev ? to_typec_mux_dev(dev) : ERR_PTR(-EPROBE_DEFER);
 }
 
 /**
@@ -265,12 +294,23 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
 struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
 				       const struct typec_altmode_desc *desc)
 {
+	struct typec_mux_dev *mux_dev;
 	struct typec_mux *mux;
 
-	mux = fwnode_connection_find_match(fwnode, "mode-switch", (void *)desc,
-					   typec_mux_match);
-	if (!IS_ERR_OR_NULL(mux))
-		WARN_ON(!try_module_get(mux->dev.parent->driver->owner));
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	mux_dev = fwnode_connection_find_match(fwnode, "mode-switch", (void *)desc,
+					       typec_mux_match);
+	if (IS_ERR_OR_NULL(mux_dev)) {
+		kfree(mux);
+		return ERR_CAST(mux_dev);
+	}
+
+	WARN_ON(!try_module_get(mux_dev->dev.parent->driver->owner));
+
+	mux->mux_dev = mux_dev;
 
 	return mux;
 }
@@ -284,25 +324,34 @@ EXPORT_SYMBOL_GPL(fwnode_typec_mux_get);
  */
 void typec_mux_put(struct typec_mux *mux)
 {
-	if (!IS_ERR_OR_NULL(mux)) {
-		module_put(mux->dev.parent->driver->owner);
-		put_device(&mux->dev);
-	}
+	struct typec_mux_dev *mux_dev;
+
+	if (IS_ERR_OR_NULL(mux))
+		return;
+
+	mux_dev = mux->mux_dev;
+	module_put(mux_dev->dev.parent->driver->owner);
+	put_device(&mux_dev->dev);
+	kfree(mux);
 }
 EXPORT_SYMBOL_GPL(typec_mux_put);
 
 int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 {
+	struct typec_mux_dev *mux_dev;
+
 	if (IS_ERR_OR_NULL(mux))
 		return 0;
 
-	return mux->set(mux, state);
+	mux_dev = mux->mux_dev;
+
+	return mux_dev->set(mux_dev, state);
 }
 EXPORT_SYMBOL_GPL(typec_mux_set);
 
 static void typec_mux_release(struct device *dev)
 {
-	kfree(to_typec_mux(dev));
+	kfree(to_typec_mux_dev(dev));
 }
 
 const struct device_type typec_mux_dev_type = {
@@ -320,66 +369,66 @@ const struct device_type typec_mux_dev_type = {
  * the pins on the connector need to be reconfigured. This function registers
  * multiplexer switches routing the pins on the connector.
  */
-struct typec_mux *
+struct typec_mux_dev *
 typec_mux_register(struct device *parent, const struct typec_mux_desc *desc)
 {
-	struct typec_mux *mux;
+	struct typec_mux_dev *mux_dev;
 	int ret;
 
 	if (!desc || !desc->set)
 		return ERR_PTR(-EINVAL);
 
-	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
-	if (!mux)
+	mux_dev = kzalloc(sizeof(*mux_dev), GFP_KERNEL);
+	if (!mux_dev)
 		return ERR_PTR(-ENOMEM);
 
-	mux->set = desc->set;
+	mux_dev->set = desc->set;
 
-	device_initialize(&mux->dev);
-	mux->dev.parent = parent;
-	mux->dev.fwnode = desc->fwnode;
-	mux->dev.class = &typec_mux_class;
-	mux->dev.type = &typec_mux_dev_type;
-	mux->dev.driver_data = desc->drvdata;
-	ret = dev_set_name(&mux->dev, "%s-mux", desc->name ? desc->name : dev_name(parent));
+	device_initialize(&mux_dev->dev);
+	mux_dev->dev.parent = parent;
+	mux_dev->dev.fwnode = desc->fwnode;
+	mux_dev->dev.class = &typec_mux_class;
+	mux_dev->dev.type = &typec_mux_dev_type;
+	mux_dev->dev.driver_data = desc->drvdata;
+	ret = dev_set_name(&mux_dev->dev, "%s-mux", desc->name ? desc->name : dev_name(parent));
 	if (ret) {
-		put_device(&mux->dev);
+		put_device(&mux_dev->dev);
 		return ERR_PTR(ret);
 	}
 
-	ret = device_add(&mux->dev);
+	ret = device_add(&mux_dev->dev);
 	if (ret) {
 		dev_err(parent, "failed to register mux (%d)\n", ret);
-		put_device(&mux->dev);
+		put_device(&mux_dev->dev);
 		return ERR_PTR(ret);
 	}
 
-	return mux;
+	return mux_dev;
 }
 EXPORT_SYMBOL_GPL(typec_mux_register);
 
 /**
  * typec_mux_unregister - Unregister Multiplexer Switch
- * @mux: USB Type-C Connector Multiplexer/DeMultiplexer
+ * @mux_dev: USB Type-C Connector Multiplexer/DeMultiplexer
  *
  * Unregister mux that was registered with typec_mux_register().
  */
-void typec_mux_unregister(struct typec_mux *mux)
+void typec_mux_unregister(struct typec_mux_dev *mux_dev)
 {
-	if (!IS_ERR_OR_NULL(mux))
-		device_unregister(&mux->dev);
+	if (!IS_ERR_OR_NULL(mux_dev))
+		device_unregister(&mux_dev->dev);
 }
 EXPORT_SYMBOL_GPL(typec_mux_unregister);
 
-void typec_mux_set_drvdata(struct typec_mux *mux, void *data)
+void typec_mux_set_drvdata(struct typec_mux_dev *mux_dev, void *data)
 {
-	dev_set_drvdata(&mux->dev, data);
+	dev_set_drvdata(&mux_dev->dev, data);
 }
 EXPORT_SYMBOL_GPL(typec_mux_set_drvdata);
 
-void *typec_mux_get_drvdata(struct typec_mux *mux)
+void *typec_mux_get_drvdata(struct typec_mux_dev *mux_dev)
 {
-	return dev_get_drvdata(&mux->dev);
+	return dev_get_drvdata(&mux_dev->dev);
 }
 EXPORT_SYMBOL_GPL(typec_mux_get_drvdata);
 
diff --git a/drivers/usb/typec/mux.h b/drivers/usb/typec/mux.h
index b1d6e837cb74..58f0f28b6dc8 100644
--- a/drivers/usb/typec/mux.h
+++ b/drivers/usb/typec/mux.h
@@ -5,23 +5,23 @@
 
 #include <linux/usb/typec_mux.h>
 
-struct typec_switch {
+struct typec_switch_dev {
 	struct device dev;
 	typec_switch_set_fn_t set;
 };
 
-struct typec_mux {
+struct typec_mux_dev {
 	struct device dev;
 	typec_mux_set_fn_t set;
 };
 
-#define to_typec_switch(_dev_) container_of(_dev_, struct typec_switch, dev)
-#define to_typec_mux(_dev_) container_of(_dev_, struct typec_mux, dev)
+#define to_typec_switch_dev(_dev_) container_of(_dev_, struct typec_switch_dev, dev)
+#define to_typec_mux_dev(_dev_) container_of(_dev_, struct typec_mux_dev, dev)
 
 extern const struct device_type typec_switch_dev_type;
 extern const struct device_type typec_mux_dev_type;
 
-#define is_typec_switch(dev) ((dev)->type == &typec_switch_dev_type)
-#define is_typec_mux(dev) ((dev)->type == &typec_mux_dev_type)
+#define is_typec_switch_dev(dev) ((dev)->type == &typec_switch_dev_type)
+#define is_typec_mux_dev(dev) ((dev)->type == &typec_mux_dev_type)
 
 #endif /* __USB_TYPEC_MUX__ */
diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 2cdd22130834..51d8f3b88128 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -121,8 +121,8 @@ struct pmc_usb_port {
 	int num;
 	u32 iom_status;
 	struct pmc_usb *pmc;
-	struct typec_mux *typec_mux;
-	struct typec_switch *typec_sw;
+	struct typec_mux_dev *typec_mux;
+	struct typec_switch_dev *typec_sw;
 	struct usb_role_switch *usb_sw;
 
 	enum typec_orientation orientation;
@@ -416,7 +416,7 @@ static int pmc_usb_connect(struct pmc_usb_port *port, enum usb_role role)
 }
 
 static int
-pmc_usb_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
+pmc_usb_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
 {
 	struct pmc_usb_port *port = typec_mux_get_drvdata(mux);
 
@@ -452,7 +452,7 @@ pmc_usb_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 	return -EOPNOTSUPP;
 }
 
-static int pmc_usb_set_orientation(struct typec_switch *sw,
+static int pmc_usb_set_orientation(struct typec_switch_dev *sw,
 				   enum typec_orientation orientation)
 {
 	struct pmc_usb_port *port = typec_switch_get_drvdata(sw);
diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/pi3usb30532.c
index 7afe275b17d0..6ce9f282594e 100644
--- a/drivers/usb/typec/mux/pi3usb30532.c
+++ b/drivers/usb/typec/mux/pi3usb30532.c
@@ -23,8 +23,8 @@
 struct pi3usb30532 {
 	struct i2c_client *client;
 	struct mutex lock; /* protects the cached conf register */
-	struct typec_switch *sw;
-	struct typec_mux *mux;
+	struct typec_switch_dev *sw;
+	struct typec_mux_dev *mux;
 	u8 conf;
 };
 
@@ -45,7 +45,7 @@ static int pi3usb30532_set_conf(struct pi3usb30532 *pi, u8 new_conf)
 	return 0;
 }
 
-static int pi3usb30532_sw_set(struct typec_switch *sw,
+static int pi3usb30532_sw_set(struct typec_switch_dev *sw,
 			      enum typec_orientation orientation)
 {
 	struct pi3usb30532 *pi = typec_switch_get_drvdata(sw);
@@ -74,7 +74,7 @@ static int pi3usb30532_sw_set(struct typec_switch *sw,
 }
 
 static int
-pi3usb30532_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
+pi3usb30532_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
 {
 	struct pi3usb30532 *pi = typec_mux_get_drvdata(mux);
 	u8 new_conf;
diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index a9d9957933dc..ee57781dcf28 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -8,11 +8,13 @@
 
 struct device;
 struct typec_mux;
+struct typec_mux_dev;
 struct typec_switch;
+struct typec_switch_dev;
 struct typec_altmode;
 struct fwnode_handle;
 
-typedef int (*typec_switch_set_fn_t)(struct typec_switch *sw,
+typedef int (*typec_switch_set_fn_t)(struct typec_switch_dev *sw,
 				     enum typec_orientation orientation);
 
 struct typec_switch_desc {
@@ -32,13 +34,13 @@ static inline struct typec_switch *typec_switch_get(struct device *dev)
 	return fwnode_typec_switch_get(dev_fwnode(dev));
 }
 
-struct typec_switch *
+struct typec_switch_dev *
 typec_switch_register(struct device *parent,
 		      const struct typec_switch_desc *desc);
-void typec_switch_unregister(struct typec_switch *sw);
+void typec_switch_unregister(struct typec_switch_dev *sw);
 
-void typec_switch_set_drvdata(struct typec_switch *sw, void *data);
-void *typec_switch_get_drvdata(struct typec_switch *sw);
+void typec_switch_set_drvdata(struct typec_switch_dev *sw, void *data);
+void *typec_switch_get_drvdata(struct typec_switch_dev *sw);
 
 struct typec_mux_state {
 	struct typec_altmode *alt;
@@ -46,7 +48,7 @@ struct typec_mux_state {
 	void *data;
 };
 
-typedef int (*typec_mux_set_fn_t)(struct typec_mux *mux,
+typedef int (*typec_mux_set_fn_t)(struct typec_mux_dev *mux,
 				  struct typec_mux_state *state);
 
 struct typec_mux_desc {
@@ -67,11 +69,11 @@ typec_mux_get(struct device *dev, const struct typec_altmode_desc *desc)
 	return fwnode_typec_mux_get(dev_fwnode(dev), desc);
 }
 
-struct typec_mux *
+struct typec_mux_dev *
 typec_mux_register(struct device *parent, const struct typec_mux_desc *desc);
-void typec_mux_unregister(struct typec_mux *mux);
+void typec_mux_unregister(struct typec_mux_dev *mux);
 
-void typec_mux_set_drvdata(struct typec_mux *mux, void *data);
-void *typec_mux_get_drvdata(struct typec_mux *mux);
+void typec_mux_set_drvdata(struct typec_mux_dev *mux, void *data);
+void *typec_mux_get_drvdata(struct typec_mux_dev *mux);
 
 #endif /* __USB_TYPEC_MUX */
-- 
2.33.1

