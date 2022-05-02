Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC30E517513
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbiEBQz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242939AbiEBQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:55:06 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87899631E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:51:36 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id e189so15742572oia.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWIj5XjudX8ZwKmXgDnwRObetYeWm37zDI6l+yR/ihs=;
        b=Sp/FUrX5zI2N06RD4DR+xOi24dqOkObe8zr9tYE0EGpTOuGfvN47tg499hizdi3Myk
         DUl0fDFhRHNGbupJeMlroEay6+/hahHxsfNtr2gJYLRFtBDlyG03fTg5mur1W3DcRrld
         ieTFMOJiPpIkcHk1y3+rLqB5R1co/IP5yHgD3n3Vv53KYF2/oks2nWE1eL2Cs2AHNP7U
         w8JQ05YnWl+QUry2ouMeleUoth0OUB/yoyBN1vffPpCl5CZ/Ghb6ZOATNk1WkRAWL761
         8LxHXds4rkGlD2MRNGltcY98jOlRx7Hdf/pSbwCetb7GbQ1TmE3Cx/RUaThRK5xxZuvO
         H6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWIj5XjudX8ZwKmXgDnwRObetYeWm37zDI6l+yR/ihs=;
        b=MVEJXPC6azZFCW/6gpdqvrcwnKx049GiJat+ZJXTCvu6YBkVGNT7TqsvB+rXd2FjMM
         Z1Un7bQuXR83s/VWJHst6S+Lg539Mzp47i0SX1QR4iH3QN8iClu4ljv0hto7KVDyejqB
         E40zBKTn4W26lCvaOOurs11r6JadHR6Ks7VyD+DIV3oE8Tvh6R3l8oUaeU13uPan2lyE
         3eQDyME8HhF7nsdXApPw2HboaqtIuK6tLluMiYuKM4nhMN0drWNgvCD8wUUcEtTlX9bk
         JeoIsfa0J13A9cVtX35Ngg3SnZencBJC8jZOqKNgH4vmp0o8g802lvlBgcHGURbS0qXJ
         f4qg==
X-Gm-Message-State: AOAM530LoQAU+w7Ez2qD8EK84hrv4KlnjrSE6t9L2knodoF20dnQyiy6
        /cW3XokyNl5eRkvxvebG7+paMQ==
X-Google-Smtp-Source: ABdhPJwioWFjOz3Z7WvAxE0s6ITwJY5Qzmol26dBhzEum01WzoDcAxgc3a1qC97RF/mBAFXlTgWMnA==
X-Received: by 2002:a05:6808:11c7:b0:2f9:f96c:d0ee with SMTP id p7-20020a05680811c700b002f9f96cd0eemr31730oiv.134.1651510295829;
        Mon, 02 May 2022 09:51:35 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h11-20020a4add8b000000b0035eb4e5a6ccsm4029422oov.34.2022.05.02.09.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:51:35 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v4 4/5] drm/msm/dp: remove most of usbpd-related remains
Date:   Mon,  2 May 2022 09:53:15 -0700
Message-Id: <20220502165316.4167199-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502165316.4167199-1-bjorn.andersson@linaro.org>
References: <20220502165316.4167199-1-bjorn.andersson@linaro.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Remove most of remains of downstream usbpd code. Mainline kernel uses
different approach for managing Type-C / USB-PD, so this remains unused.
Do not touch usbpd callbacks for now, since they look useful enough as
an example of how to handle connect/disconnect (to be rewritten into .

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
[bjorn: Cleaned up dp_display_usbpd_attention() prototype as well]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- New patch

 drivers/gpu/drm/msm/Makefile        |  1 -
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 -
 drivers/gpu/drm/msm/dp/dp_debug.c   |  6 +--
 drivers/gpu/drm/msm/dp/dp_debug.h   |  4 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 55 ++++----------------
 drivers/gpu/drm/msm/dp/dp_hpd.c     | 67 -------------------------
 drivers/gpu/drm/msm/dp/dp_hpd.h     | 78 -----------------------------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  1 -
 drivers/gpu/drm/msm/dp/dp_power.c   |  2 +-
 drivers/gpu/drm/msm/dp/dp_power.h   |  3 +-
 10 files changed, 16 insertions(+), 202 deletions(-)
 delete mode 100644 drivers/gpu/drm/msm/dp/dp_hpd.c
 delete mode 100644 drivers/gpu/drm/msm/dp/dp_hpd.h

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 66395ee0862a..c417443168f6 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -123,7 +123,6 @@ msm-$(CONFIG_DRM_MSM_DP)+= dp/dp_aux.o \
 	dp/dp_ctrl.o \
 	dp/dp_display.o \
 	dp/dp_drm.o \
-	dp/dp_hpd.o \
 	dp/dp_link.o \
 	dp/dp_panel.o \
 	dp/dp_parser.o \
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 0745fde01b45..52648b56f54b 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -14,7 +14,6 @@
 #include "dp_catalog.h"
 
 struct dp_ctrl {
-	bool orientation;
 	atomic_t aborted;
 	u32 pixel_rate;
 	bool wide_bus_en;
diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
index 075969da9418..25ea2d3e3e12 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.c
+++ b/drivers/gpu/drm/msm/dp/dp_debug.c
@@ -21,7 +21,6 @@
 struct dp_debug_private {
 	struct dentry *root;
 
-	struct dp_usbpd *usbpd;
 	struct dp_link *link;
 	struct dp_panel *panel;
 	struct drm_connector *connector;
@@ -234,14 +233,14 @@ static void dp_debug_init(struct dp_debug *dp_debug, struct drm_minor *minor)
 }
 
 struct dp_debug *dp_debug_get(struct device *dev, struct dp_panel *panel,
-		struct dp_usbpd *usbpd, struct dp_link *link,
+		struct dp_link *link,
 		struct drm_connector *connector, struct drm_minor *minor)
 {
 	struct dp_debug_private *debug;
 	struct dp_debug *dp_debug;
 	int rc;
 
-	if (!dev || !panel || !usbpd || !link) {
+	if (!dev || !panel || !link) {
 		DRM_ERROR("invalid input\n");
 		rc = -EINVAL;
 		goto error;
@@ -254,7 +253,6 @@ struct dp_debug *dp_debug_get(struct device *dev, struct dp_panel *panel,
 	}
 
 	debug->dp_debug.debug_en = false;
-	debug->usbpd = usbpd;
 	debug->link = link;
 	debug->panel = panel;
 	debug->dev = dev;
diff --git a/drivers/gpu/drm/msm/dp/dp_debug.h b/drivers/gpu/drm/msm/dp/dp_debug.h
index 8c0d0b5178fd..be350cb393ee 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.h
+++ b/drivers/gpu/drm/msm/dp/dp_debug.h
@@ -42,7 +42,7 @@ struct dp_debug {
  * for debugfs input to be communicated with existing modules
  */
 struct dp_debug *dp_debug_get(struct device *dev, struct dp_panel *panel,
-		struct dp_usbpd *usbpd, struct dp_link *link,
+		struct dp_link *link,
 		struct drm_connector *connector,
 		struct drm_minor *minor);
 
@@ -59,7 +59,7 @@ void dp_debug_put(struct dp_debug *dp_debug);
 
 static inline
 struct dp_debug *dp_debug_get(struct device *dev, struct dp_panel *panel,
-		struct dp_usbpd *usbpd, struct dp_link *link,
+		struct dp_link *link,
 		struct drm_connector *connector, struct drm_minor *minor)
 {
 	return ERR_PTR(-EINVAL);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c68d6007c2c6..b447446d75e9 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -14,7 +14,6 @@
 
 #include "msm_drv.h"
 #include "msm_kms.h"
-#include "dp_hpd.h"
 #include "dp_parser.h"
 #include "dp_power.h"
 #include "dp_catalog.h"
@@ -88,7 +87,6 @@ struct dp_display_private {
 	struct platform_device *pdev;
 	struct dentry *root;
 
-	struct dp_usbpd   *usbpd;
 	struct dp_parser  *parser;
 	struct dp_power   *power;
 	struct dp_catalog *catalog;
@@ -98,7 +96,6 @@ struct dp_display_private {
 	struct dp_ctrl    *ctrl;
 	struct dp_debug   *debug;
 
-	struct dp_usbpd_cb usbpd_cb;
 	struct dp_display_mode dp_mode;
 	struct msm_dp dp_display;
 
@@ -442,7 +439,7 @@ static void dp_display_host_init(struct dp_display_private *dp)
 		dp->dp_display.connector_type, dp->core_initialized,
 		dp->phy_initialized);
 
-	dp_power_init(dp->power, false);
+	dp_power_init(dp->power);
 	dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
 	dp_aux_init(dp->aux);
 	dp->core_initialized = true;
@@ -460,24 +457,15 @@ static void dp_display_host_deinit(struct dp_display_private *dp)
 	dp->core_initialized = false;
 }
 
-static int dp_display_usbpd_configure_cb(struct device *dev)
+static int dp_display_usbpd_configure(struct dp_display_private *dp)
 {
-	struct dp_display_private *dp = dev_get_dp_display_private(dev);
-
 	dp_display_host_phy_init(dp);
 
 	return dp_display_process_hpd_high(dp);
 }
 
-static int dp_display_usbpd_disconnect_cb(struct device *dev)
-{
-	return 0;
-}
-
-static int dp_display_notify_disconnect(struct device *dev)
+static int dp_display_notify_disconnect(struct dp_display_private *dp)
 {
-	struct dp_display_private *dp = dev_get_dp_display_private(dev);
-
 	dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
 
 	return 0;
@@ -535,11 +523,10 @@ static int dp_display_handle_irq_hpd(struct dp_display_private *dp)
 	return 0;
 }
 
-static int dp_display_usbpd_attention_cb(struct device *dev)
+static int dp_display_usbpd_attention(struct dp_display_private *dp)
 {
 	int rc = 0;
 	u32 sink_request;
-	struct dp_display_private *dp = dev_get_dp_display_private(dev);
 
 	/* check for any test request issued by sink */
 	rc = dp_link_process_request(dp->link);
@@ -558,13 +545,9 @@ static int dp_display_usbpd_attention_cb(struct device *dev)
 
 static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 {
-	struct dp_usbpd *hpd = dp->usbpd;
 	u32 state;
 	int ret;
 
-	if (!hpd)
-		return 0;
-
 	mutex_lock(&dp->event_mutex);
 
 	state =  dp->hpd_state;
@@ -588,7 +571,7 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 		return 0;
 	}
 
-	ret = dp_display_usbpd_configure_cb(&dp->pdev->dev);
+	ret = dp_display_usbpd_configure(dp);
 	if (ret) {	/* link train failed */
 		dp->hpd_state = ST_DISCONNECTED;
 	} else {
@@ -632,12 +615,8 @@ static void dp_display_handle_plugged_change(struct msm_dp *dp_display,
 
 static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 {
-	struct dp_usbpd *hpd = dp->usbpd;
 	u32 state;
 
-	if (!hpd)
-		return 0;
-
 	mutex_lock(&dp->event_mutex);
 
 	state = dp->hpd_state;
@@ -657,7 +636,7 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 		if (dp->link->sink_count == 0) {
 			dp_display_host_phy_exit(dp);
 		}
-		dp_display_notify_disconnect(&dp->pdev->dev);
+		dp_display_notify_disconnect(dp);
 		mutex_unlock(&dp->event_mutex);
 		return 0;
 	} else if (state == ST_DISCONNECT_PENDING) {
@@ -667,7 +646,7 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 		dp_ctrl_off_link(dp->ctrl);
 		dp_display_host_phy_exit(dp);
 		dp->hpd_state = ST_DISCONNECTED;
-		dp_display_notify_disconnect(&dp->pdev->dev);
+		dp_display_notify_disconnect(dp);
 		mutex_unlock(&dp->event_mutex);
 		return 0;
 	}
@@ -679,7 +658,7 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 	 * We don't need separate work for disconnect as
 	 * connect/attention interrupts are disabled
 	 */
-	dp_display_notify_disconnect(&dp->pdev->dev);
+	dp_display_notify_disconnect(dp);
 
 	if (state == ST_DISPLAY_OFF) {
 		dp->hpd_state = ST_DISCONNECTED;
@@ -725,7 +704,7 @@ static int dp_irq_hpd_handle(struct dp_display_private *dp, u32 data)
 		return 0;
 	}
 
-	dp_display_usbpd_attention_cb(&dp->pdev->dev);
+	dp_display_usbpd_attention(dp);
 
 	drm_dbg_dp(dp->drm_dev, "After, type=%d hpd_state=%d\n",
 			dp->dp_display.connector_type, state);
@@ -747,24 +726,10 @@ static int dp_init_sub_modules(struct dp_display_private *dp)
 {
 	int rc = 0;
 	struct device *dev = &dp->pdev->dev;
-	struct dp_usbpd_cb *cb = &dp->usbpd_cb;
 	struct dp_panel_in panel_in = {
 		.dev = dev,
 	};
 
-	/* Callback APIs used for cable status change event */
-	cb->configure  = dp_display_usbpd_configure_cb;
-	cb->disconnect = dp_display_usbpd_disconnect_cb;
-	cb->attention  = dp_display_usbpd_attention_cb;
-
-	dp->usbpd = dp_hpd_get(dev, cb);
-	if (IS_ERR(dp->usbpd)) {
-		rc = PTR_ERR(dp->usbpd);
-		DRM_ERROR("failed to initialize hpd, rc = %d\n", rc);
-		dp->usbpd = NULL;
-		goto error;
-	}
-
 	dp->parser = dp_parser_get(dp->pdev);
 	if (IS_ERR(dp->parser)) {
 		rc = PTR_ERR(dp->parser);
@@ -1533,7 +1498,7 @@ void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
 	dp = container_of(dp_display, struct dp_display_private, dp_display);
 	dev = &dp->pdev->dev;
 
-	dp->debug = dp_debug_get(dev, dp->panel, dp->usbpd,
+	dp->debug = dp_debug_get(dev, dp->panel,
 					dp->link, dp->dp_display.connector,
 					minor);
 	if (IS_ERR(dp->debug)) {
diff --git a/drivers/gpu/drm/msm/dp/dp_hpd.c b/drivers/gpu/drm/msm/dp/dp_hpd.c
deleted file mode 100644
index db98a1d431eb..000000000000
--- a/drivers/gpu/drm/msm/dp/dp_hpd.c
+++ /dev/null
@@ -1,67 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
- */
-
-#define pr_fmt(fmt)	"[drm-dp] %s: " fmt, __func__
-
-#include <linux/slab.h>
-#include <linux/device.h>
-
-#include "dp_hpd.h"
-
-/* DP specific VDM commands */
-#define DP_USBPD_VDM_STATUS	0x10
-#define DP_USBPD_VDM_CONFIGURE	0x11
-
-/* USBPD-TypeC specific Macros */
-#define VDM_VERSION		0x0
-#define USB_C_DP_SID		0xFF01
-
-struct dp_hpd_private {
-	struct device *dev;
-	struct dp_usbpd_cb *dp_cb;
-	struct dp_usbpd dp_usbpd;
-};
-
-int dp_hpd_connect(struct dp_usbpd *dp_usbpd, bool hpd)
-{
-	int rc = 0;
-	struct dp_hpd_private *hpd_priv;
-
-	hpd_priv = container_of(dp_usbpd, struct dp_hpd_private,
-					dp_usbpd);
-
-	if (!hpd_priv->dp_cb || !hpd_priv->dp_cb->configure
-				|| !hpd_priv->dp_cb->disconnect) {
-		pr_err("hpd dp_cb not initialized\n");
-		return -EINVAL;
-	}
-	if (hpd)
-		hpd_priv->dp_cb->configure(hpd_priv->dev);
-	else
-		hpd_priv->dp_cb->disconnect(hpd_priv->dev);
-
-	return rc;
-}
-
-struct dp_usbpd *dp_hpd_get(struct device *dev, struct dp_usbpd_cb *cb)
-{
-	struct dp_hpd_private *dp_hpd;
-
-	if (!cb) {
-		pr_err("invalid cb data\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	dp_hpd = devm_kzalloc(dev, sizeof(*dp_hpd), GFP_KERNEL);
-	if (!dp_hpd)
-		return ERR_PTR(-ENOMEM);
-
-	dp_hpd->dev = dev;
-	dp_hpd->dp_cb = cb;
-
-	dp_hpd->dp_usbpd.connect = dp_hpd_connect;
-
-	return &dp_hpd->dp_usbpd;
-}
diff --git a/drivers/gpu/drm/msm/dp/dp_hpd.h b/drivers/gpu/drm/msm/dp/dp_hpd.h
deleted file mode 100644
index 8feec5aa5027..000000000000
--- a/drivers/gpu/drm/msm/dp/dp_hpd.h
+++ /dev/null
@@ -1,78 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
- */
-
-#ifndef _DP_HPD_H_
-#define _DP_HPD_H_
-
-//#include <linux/usb/usbpd.h>
-
-#include <linux/types.h>
-#include <linux/device.h>
-
-enum plug_orientation {
-	ORIENTATION_NONE,
-	ORIENTATION_CC1,
-	ORIENTATION_CC2,
-};
-
-/**
- * struct dp_usbpd - DisplayPort status
- *
- * @orientation: plug orientation configuration
- * @low_pow_st: low power state
- * @adaptor_dp_en: adaptor functionality enabled
- * @multi_func: multi-function preferred
- * @usb_config_req: request to switch to usb
- * @exit_dp_mode: request exit from displayport mode
- * @hpd_irq: Change in the status since last message
- * @alt_mode_cfg_done: bool to specify alt mode status
- * @debug_en: bool to specify debug mode
- * @connect: simulate disconnect or connect for debug mode
- */
-struct dp_usbpd {
-	enum plug_orientation orientation;
-	bool low_pow_st;
-	bool adaptor_dp_en;
-	bool multi_func;
-	bool usb_config_req;
-	bool exit_dp_mode;
-	bool hpd_irq;
-	bool alt_mode_cfg_done;
-	bool debug_en;
-
-	int (*connect)(struct dp_usbpd *dp_usbpd, bool hpd);
-};
-
-/**
- * struct dp_usbpd_cb - callback functions provided by the client
- *
- * @configure: called by usbpd module when PD communication has
- * been completed and the usb peripheral has been configured on
- * dp mode.
- * @disconnect: notify the cable disconnect issued by usb.
- * @attention: notify any attention message issued by usb.
- */
-struct dp_usbpd_cb {
-	int (*configure)(struct device *dev);
-	int (*disconnect)(struct device *dev);
-	int (*attention)(struct device *dev);
-};
-
-/**
- * dp_hpd_get() - setup hpd module
- *
- * @dev: device instance of the caller
- * @cb: struct containing callback function pointers.
- *
- * This function allows the client to initialize the usbpd
- * module. The module will communicate with HPD module.
- */
-struct dp_usbpd *dp_hpd_get(struct device *dev, struct dp_usbpd_cb *cb);
-
-int dp_hpd_register(struct dp_usbpd *dp_usbpd);
-void dp_hpd_unregister(struct dp_usbpd *dp_usbpd);
-int dp_hpd_connect(struct dp_usbpd *dp_usbpd, bool hpd);
-
-#endif /* _DP_HPD_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index acb1987fa45f..d55e28f1000f 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -10,7 +10,6 @@
 
 #include "dp_aux.h"
 #include "dp_link.h"
-#include "dp_hpd.h"
 
 struct edid;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_power.c b/drivers/gpu/drm/msm/dp/dp_power.c
index d9e011775ad8..faa3bfbccc9e 100644
--- a/drivers/gpu/drm/msm/dp/dp_power.c
+++ b/drivers/gpu/drm/msm/dp/dp_power.c
@@ -352,7 +352,7 @@ void dp_power_client_deinit(struct dp_power *dp_power)
 
 }
 
-int dp_power_init(struct dp_power *dp_power, bool flip)
+int dp_power_init(struct dp_power *dp_power)
 {
 	int rc = 0;
 	struct dp_power_private *power = NULL;
diff --git a/drivers/gpu/drm/msm/dp/dp_power.h b/drivers/gpu/drm/msm/dp/dp_power.h
index e3f959ffae12..a3dec200785e 100644
--- a/drivers/gpu/drm/msm/dp/dp_power.h
+++ b/drivers/gpu/drm/msm/dp/dp_power.h
@@ -26,13 +26,12 @@ struct dp_power {
  * dp_power_init() - enable power supplies for display controller
  *
  * @power: instance of power module
- * @flip: bool for flipping gpio direction
  * return: 0 if success or error if failure.
  *
  * This API will turn on the regulators and configures gpio's
  * aux/hpd.
  */
-int dp_power_init(struct dp_power *power, bool flip);
+int dp_power_init(struct dp_power *power);
 
 /**
  * dp_power_deinit() - turn off regulators and gpios.
-- 
2.35.1

