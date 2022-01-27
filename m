Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC2449EC02
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344003AbiA0UDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343909AbiA0UCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:02:42 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E6CC0613EB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:41 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i186so1323397pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NWPDgDUwRl+84SzwunIQASVSIexCRProBcGwEVA3ZyQ=;
        b=oCNz3/TyoOC1Z4L+TGEGzc242VDcV1zOa2+4KpqoSchL9yglQa3dROPnlnWmSgibm6
         6FdcJLI6inymZ9YaC5K+b7GNCEgYSqJfiA0drHN9+5GRKTc6wlUr9xF8D4rI3iPKD07E
         +51WbfkKJVTDAand07akDTPtzYj2zVO+3ThYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NWPDgDUwRl+84SzwunIQASVSIexCRProBcGwEVA3ZyQ=;
        b=nNcaF2LeM9vJspsvdZTQUhzXXLa5N/V2Ps6wRFdZeh0Fcm7L/ZY5eKn3c5UMr26/u3
         Kbc4sT5DBJLjNmw9ClQ4Bh2KyRYLXxS/8YDg8WwCyslyBGtt+BbMMFxxy5ImhNMepxBm
         msIaBu81aalnZvh/r0bPGmEGvbTimUTTxOOWchICzNFsn0hb3dNw9iuevZSoUhMs9BJC
         DoYZ+43onGB3QcBVmoVDXZmr5Ni0qlq8rmbiVpybzPDgSvBHxBHtzKCdanklX9vRELw3
         jg6NpYRFt/+v3ZV9sRnHYMMCNlhJe6A9LOgGWrQZnY+1lf6XZ7Dkx4CkUwP1clCvsQ3N
         l1wQ==
X-Gm-Message-State: AOAM533VKK19rUxM8+7VpUJguIMUkojfWANI2cte7Qxj2YBZAVWAUPgA
        KEgvnlJleh/8/yUtGI+IalS8Yg==
X-Google-Smtp-Source: ABdhPJyZ+yxlFIH/w2575esD0A9Z3uwPXwkVYGsPiBy9KXIh12HY0oxwuUFjhhYoIin6PRGU1PyxnQ==
X-Received: by 2002:a62:e704:: with SMTP id s4mr4171414pfh.25.1643313760477;
        Thu, 27 Jan 2022 12:02:40 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:9246:1838:3243:3071])
        by smtp.gmail.com with ESMTPSA id k21sm6561190pff.33.2022.01.27.12.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:02:40 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 34/35] component: Get rid of drm_of_component_probe()
Date:   Thu, 27 Jan 2022 12:01:40 -0800
Message-Id: <20220127200141.1295328-35-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127200141.1295328-1-swboyd@chromium.org>
References: <20220127200141.1295328-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There aren't any users anymore so drop it.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/drm_of.c | 85 +++++++++-------------------------------
 include/drm/drm_of.h     | 12 ------
 2 files changed, 19 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 0fe822319aae..84e285432d13 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -99,18 +99,30 @@ void drm_of_component_match_add(struct device *master,
 }
 EXPORT_SYMBOL_GPL(drm_of_component_match_add);
 
-static int _drm_of_component_probe(struct device *dev,
+/**
+ * drm_of_aggregate_probe - Generic probe function for a component based aggregate host
+ * @dev: device containing the OF node
+ * @compare_of: compare function used for matching components
+ * @adrv: aggregate driver to be used
+ *
+ * Parse the platform device OF node and bind all the components associated
+ * with the aggregate device. Interface ports are added before the encoders in
+ * order to satisfy their .bind_component requirements
+ * See Documentation/devicetree/bindings/graph.txt for the bindings.
+ *
+ * Returns zero if successful, or one of the standard error codes if it fails.
+ */
+int drm_of_aggregate_probe(struct device *dev,
 			   int (*compare_of)(struct device *, void *),
-			   struct component_match **matchptr)
+			   struct aggregate_driver *adrv)
 {
 	struct device_node *ep, *port, *remote;
+	struct component_match *match = NULL;
 	int i;
 
 	if (!dev->of_node)
 		return -EINVAL;
 
-	*matchptr = NULL;
-
 	/*
 	 * Bind the crtc's ports first, so that drm_of_find_possible_crtcs()
 	 * called from encoder's .bind callbacks works as expected
@@ -121,7 +133,7 @@ static int _drm_of_component_probe(struct device *dev,
 			break;
 
 		if (of_device_is_available(port->parent))
-			drm_of_component_match_add(dev, matchptr, compare_of,
+			drm_of_component_match_add(dev, &match, compare_of,
 						   port);
 
 		of_node_put(port);
@@ -132,7 +144,7 @@ static int _drm_of_component_probe(struct device *dev,
 		return -ENODEV;
 	}
 
-	if (!*matchptr) {
+	if (!match) {
 		dev_err(dev, "no available port\n");
 		return -ENODEV;
 	}
@@ -162,72 +174,13 @@ static int _drm_of_component_probe(struct device *dev,
 				continue;
 			}
 
-			drm_of_component_match_add(dev, matchptr, compare_of,
+			drm_of_component_match_add(dev, &match, compare_of,
 						   remote);
 			of_node_put(remote);
 		}
 		of_node_put(port);
 	}
 
-	return 0;
-}
-
-/**
- * drm_of_component_probe - Generic probe function for a component based master
- * @dev: master device containing the OF node
- * @compare_of: compare function used for matching components
- * @m_ops: component master ops to be used
- *
- * Parse the platform device OF node and bind all the components associated
- * with the master. Interface ports are added before the encoders in order to
- * satisfy their .bind requirements
- * See Documentation/devicetree/bindings/graph.txt for the bindings.
- *
- * Deprecated: Use drm_of_aggregate_probe() instead.
- *
- * Returns zero if successful, or one of the standard error codes if it fails.
- */
-int drm_of_component_probe(struct device *dev,
-			   int (*compare_of)(struct device *, void *),
-			   const struct component_master_ops *m_ops)
-{
-
-	struct component_match *match;
-	int ret;
-
-	ret = _drm_of_component_probe(dev, compare_of, &match);
-	if (ret)
-		return ret;
-
-	return component_master_add_with_match(dev, m_ops, match);
-}
-EXPORT_SYMBOL(drm_of_component_probe);
-
-
-/**
- * drm_of_aggregate_probe - Generic probe function for a component based aggregate host
- * @dev: device containing the OF node
- * @compare_of: compare function used for matching components
- * @adrv: aggregate driver to be used
- *
- * Parse the platform device OF node and bind all the components associated
- * with the aggregate device. Interface ports are added before the encoders in
- * order to satisfy their .bind_component requirements
- * See Documentation/devicetree/bindings/graph.txt for the bindings.
- *
- * Returns zero if successful, or one of the standard error codes if it fails.
- */
-int drm_of_aggregate_probe(struct device *dev,
-			   int (*compare_of)(struct device *, void *),
-			   struct aggregate_driver *adrv)
-{
-	struct component_match *match;
-	int ret;
-
-	ret = _drm_of_component_probe(dev, compare_of, &match);
-	if (ret)
-		return ret;
-
 	return component_aggregate_register(dev, adrv, match);
 }
 EXPORT_SYMBOL(drm_of_aggregate_probe);
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index 7c7b0d8377a7..4709ff2f04eb 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -8,7 +8,6 @@
 #endif
 
 struct aggregate_driver;
-struct component_master_ops;
 struct component_match;
 struct device;
 struct drm_device;
@@ -38,9 +37,6 @@ void drm_of_component_match_add(struct device *master,
 				struct component_match **matchptr,
 				int (*compare)(struct device *, void *),
 				struct device_node *node);
-int drm_of_component_probe(struct device *dev,
-			   int (*compare_of)(struct device *, void *),
-			   const struct component_master_ops *m_ops);
 int drm_of_aggregate_probe(struct device *dev,
 			   int (*compare_of)(struct device *, void *),
 			   struct aggregate_driver *adrv);
@@ -75,14 +71,6 @@ drm_of_component_match_add(struct device *master,
 {
 }
 
-static inline int
-drm_of_component_probe(struct device *dev,
-		       int (*compare_of)(struct device *, void *),
-		       const struct component_master_ops *m_ops)
-{
-	return -EINVAL;
-}
-
 static inline int
 drm_of_aggregate_probe(struct device *dev,
 		       int (*compare_of)(struct device *, void *),
-- 
https://chromeos.dev

