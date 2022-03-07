Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D5E4CF074
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiCGDkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiCGDjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:39:53 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5505950B0D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:38:59 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id n7so4151764oif.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 19:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VheSCVj8Yl31dXKqa/0FM4m2FeHwlfejig1mIBA1w1E=;
        b=oBplwgeSvfZ9viMxpHAHaWotY7E+yY4DVfU9bBgVlxQVaprUr5RgKg/9UhyWDBCV7j
         M7VOCULKGFBFwdY+aTSOAUd0oTVUNJuLpqdwvNcnYK7XgTgmd08WZ3kvYwBACSslDeLz
         0aNTNKJqg8mhQhspQZa1jBHFgL9XT+c7t02iuif/ig5lpfqvk0xvxiPXI0pIk1C+DKSK
         6LwUXR7GhAHJYdCfwQ0S6i0cnNRZEFpx1X921yVrm4+vtYlc+MWpSC9FyxAFcT49I581
         LlC7WP4LiRq1PW3WxQVQW4HPNVHWt/fXVDn7Esl+cyHMEQWRdk9YwDAnJD5axH7exrbp
         jEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VheSCVj8Yl31dXKqa/0FM4m2FeHwlfejig1mIBA1w1E=;
        b=FOHAbrzYSqSwxI01/lhGbD7+kR58CbTH0yPEvrV3vZBzhEGSZ0WlVS9vdPWpCRrdaF
         qsEUhqOnbcMCKsVWfhP1su93LGJ8PACI5+6Gi9aMRj1jtK3PZJ/PXebVokyJyUW57LKA
         xBzFrLURaPPsiVaQWBrOEy1HVNOT4mbzgclOyQIECXQ35W9QnDT2+ii2L8+3169E2nqI
         eXsmTFvW5vObz2oXIZ6YlPy0gg4Tqgpx7SXgxOkSewWQe6VRDHufSKWOLr6nXoaHMOPh
         sio8V8qQ4zZ2Yfcp1SRm7gW4EKLZPyGSx3hX64T19SSLs6b8SHYktTYsY2Wc51gM9obb
         AEJg==
X-Gm-Message-State: AOAM531mLz8JD5dNy+no5j3Fm8iLZBZ9ksa/nzfX7L9kem/VhyrZVuHA
        WsTlf6p7eLuQxSr0JNx2W5oFGg==
X-Google-Smtp-Source: ABdhPJwguLhW08OhxFvcnXI4yRuJOXzeYAHh+Zgz/ARnf6C0vUsB+Ra7sqWXQDAepF6jrEfuBiVv7w==
X-Received: by 2002:aca:f241:0:b0:2cd:92b7:5640 with SMTP id q62-20020acaf241000000b002cd92b75640mr16575690oih.75.1646624338680;
        Sun, 06 Mar 2022 19:38:58 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id o2-20020a05687072c200b000d9ae3e1fabsm5005172oak.12.2022.03.06.19.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 19:38:58 -0800 (PST)
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
Subject: [PATCH v4 5/7] usb: typec: mux: Allow multiple mux_devs per mux
Date:   Sun,  6 Mar 2022 19:40:38 -0800
Message-Id: <20220307034040.1111107-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the Qualcomm platforms the USB/DP PHY handles muxing and orientation
switching of the SuperSpeed lines, but the SBU lines needs to be
connected and switched by external (to the SoC) hardware.

It's therefor necessary to be able to have the TypeC controller operate
multiple TypeC muxes and switches. Use the newly introduced indirection
object to handle this, to avoid having to taint the TypeC controllers
with knowledge about the downstream hardware configuration.

The max number of devs per indirection is set to 3, which account for
being able to mux/switch the USB HS, SS and SBU lines, as per defined
defined in the usb-c-connector binding. This number could be grown if
need arrises at a later point in time.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Added "usb:" prefix to subject

Changes since v2:
- Picked up Heikki's ack.

Changes since v1:
- Improved the motivation for the 3 in the commit message.
- kfree sw and mux in error paths

 drivers/usb/typec/mux.c | 128 ++++++++++++++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index bb6c095b4af9..fd55c2c516a5 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -17,8 +17,11 @@
 #include "class.h"
 #include "mux.h"
 
+#define TYPEC_MUX_MAX_DEVS	3
+
 struct typec_switch {
-	struct typec_switch_dev *sw_dev;
+	struct typec_switch_dev *sw_devs[TYPEC_MUX_MAX_DEVS];
+	unsigned int num_sw_devs;
 };
 
 static int switch_fwnode_match(struct device *dev, const void *fwnode)
@@ -67,25 +70,50 @@ static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
  */
 struct typec_switch *fwnode_typec_switch_get(struct fwnode_handle *fwnode)
 {
-	struct typec_switch_dev *sw_dev;
+	struct typec_switch_dev *sw_devs[TYPEC_MUX_MAX_DEVS];
 	struct typec_switch *sw;
+	int count;
+	int err;
+	int i;
 
 	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
 	if (!sw)
 		return ERR_PTR(-ENOMEM);
 
-	sw_dev = fwnode_connection_find_match(fwnode, "orientation-switch", NULL,
-					      typec_switch_match);
-	if (IS_ERR_OR_NULL(sw_dev)) {
+	count = fwnode_connection_find_matches(fwnode, "orientation-switch", NULL,
+					       typec_switch_match,
+					       (void **)sw_devs,
+					       ARRAY_SIZE(sw_devs));
+	if (count <= 0) {
 		kfree(sw);
-		return ERR_CAST(sw_dev);
+		return NULL;
 	}
 
-	WARN_ON(!try_module_get(sw_dev->dev.parent->driver->owner));
+	for (i = 0; i < count; i++) {
+		if (IS_ERR(sw_devs[i])) {
+			err = PTR_ERR(sw_devs[i]);
+			goto put_sw_devs;
+		}
+	}
 
-	sw->sw_dev = sw_dev;
+	for (i = 0; i < count; i++) {
+		WARN_ON(!try_module_get(sw_devs[i]->dev.parent->driver->owner));
+		sw->sw_devs[i] = sw_devs[i];
+	}
+
+	sw->num_sw_devs = count;
 
 	return sw;
+
+put_sw_devs:
+	for (i = 0; i < count; i++) {
+		if (!IS_ERR(sw_devs[i]))
+			put_device(&sw_devs[i]->dev);
+	}
+
+	kfree(sw);
+
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(fwnode_typec_switch_get);
 
@@ -98,14 +126,17 @@ EXPORT_SYMBOL_GPL(fwnode_typec_switch_get);
 void typec_switch_put(struct typec_switch *sw)
 {
 	struct typec_switch_dev *sw_dev;
+	unsigned int i;
 
 	if (IS_ERR_OR_NULL(sw))
 		return;
 
-	sw_dev = sw->sw_dev;
+	for (i = 0; i < sw->num_sw_devs; i++) {
+		sw_dev = sw->sw_devs[i];
 
-	module_put(sw_dev->dev.parent->driver->owner);
-	put_device(&sw_dev->dev);
+		module_put(sw_dev->dev.parent->driver->owner);
+		put_device(&sw_dev->dev);
+	}
 	kfree(sw);
 }
 EXPORT_SYMBOL_GPL(typec_switch_put);
@@ -173,13 +204,21 @@ int typec_switch_set(struct typec_switch *sw,
 		     enum typec_orientation orientation)
 {
 	struct typec_switch_dev *sw_dev;
+	unsigned int i;
+	int ret;
 
 	if (IS_ERR_OR_NULL(sw))
 		return 0;
 
-	sw_dev = sw->sw_dev;
+	for (i = 0; i < sw->num_sw_devs; i++) {
+		sw_dev = sw->sw_devs[i];
+
+		ret = sw_dev->set(sw_dev, orientation);
+		if (ret)
+			return ret;
+	}
 
-	return sw_dev->set(sw_dev, orientation);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(typec_switch_set);
 
@@ -211,7 +250,8 @@ EXPORT_SYMBOL_GPL(typec_switch_get_drvdata);
 /* ------------------------------------------------------------------------- */
 
 struct typec_mux {
-	struct typec_mux_dev *mux_dev;
+	struct typec_mux_dev *mux_devs[TYPEC_MUX_MAX_DEVS];
+	unsigned int num_mux_devs;
 };
 
 static int mux_fwnode_match(struct device *dev, const void *fwnode)
@@ -294,25 +334,50 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
 struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
 				       const struct typec_altmode_desc *desc)
 {
-	struct typec_mux_dev *mux_dev;
+	struct typec_mux_dev *mux_devs[TYPEC_MUX_MAX_DEVS];
 	struct typec_mux *mux;
+	int count;
+	int err;
+	int i;
 
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
 		return ERR_PTR(-ENOMEM);
 
-	mux_dev = fwnode_connection_find_match(fwnode, "mode-switch", (void *)desc,
-					       typec_mux_match);
-	if (IS_ERR_OR_NULL(mux_dev)) {
+	count = fwnode_connection_find_matches(fwnode, "mode-switch",
+					       (void *)desc, typec_mux_match,
+					       (void **)mux_devs,
+					       ARRAY_SIZE(mux_devs));
+	if (count <= 0) {
 		kfree(mux);
-		return ERR_CAST(mux_dev);
+		return NULL;
 	}
 
-	WARN_ON(!try_module_get(mux_dev->dev.parent->driver->owner));
+	for (i = 0; i < count; i++) {
+		if (IS_ERR(mux_devs[i])) {
+			err = PTR_ERR(mux_devs[i]);
+			goto put_mux_devs;
+		}
+	}
+
+	for (i = 0; i < count; i++) {
+		WARN_ON(!try_module_get(mux_devs[i]->dev.parent->driver->owner));
+		mux->mux_devs[i] = mux_devs[i];
+	}
 
-	mux->mux_dev = mux_dev;
+	mux->num_mux_devs = count;
 
 	return mux;
+
+put_mux_devs:
+	for (i = 0; i < count; i++) {
+		if (!IS_ERR(mux_devs[i]))
+			put_device(&mux_devs[i]->dev);
+	}
+
+	kfree(mux);
+
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(fwnode_typec_mux_get);
 
@@ -325,13 +390,16 @@ EXPORT_SYMBOL_GPL(fwnode_typec_mux_get);
 void typec_mux_put(struct typec_mux *mux)
 {
 	struct typec_mux_dev *mux_dev;
+	unsigned int i;
 
 	if (IS_ERR_OR_NULL(mux))
 		return;
 
-	mux_dev = mux->mux_dev;
-	module_put(mux_dev->dev.parent->driver->owner);
-	put_device(&mux_dev->dev);
+	for (i = 0; i < mux->num_mux_devs; i++) {
+		mux_dev = mux->mux_devs[i];
+		module_put(mux_dev->dev.parent->driver->owner);
+		put_device(&mux_dev->dev);
+	}
 	kfree(mux);
 }
 EXPORT_SYMBOL_GPL(typec_mux_put);
@@ -339,13 +407,21 @@ EXPORT_SYMBOL_GPL(typec_mux_put);
 int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 {
 	struct typec_mux_dev *mux_dev;
+	unsigned int i;
+	int ret;
 
 	if (IS_ERR_OR_NULL(mux))
 		return 0;
 
-	mux_dev = mux->mux_dev;
+	for (i = 0; i < mux->num_mux_devs; i++) {
+		mux_dev = mux->mux_devs[i];
+
+		ret = mux_dev->set(mux_dev, state);
+		if (ret)
+			return ret;
+	}
 
-	return mux_dev->set(mux_dev, state);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(typec_mux_set);
 
-- 
2.33.1

