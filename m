Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131424AD0C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiBHFcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346977AbiBHElN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:41:13 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E7EC0401ED
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:41:11 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id ay7so5407400oib.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 20:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lApkzQz97x0mjsEJc+j9OKw9zJ/S3b/963aKxsBJZWE=;
        b=UUESrc5ssqMRmCaxq+U9GGNWZRYyVLIwHPaaKqw9Pq5DCbJZJzrBWe2w228S//BAbo
         2GB+0MUYTqCnsYFQi1hf6ZtQMlH/QJc0GEMZmDY/jZ4H6WoYwAlRgMGtwaH/uiNSkgYg
         nTGk7Y4kToyMqYzcrPg5ag+Rs4oGaNIxLG27uDyUSHNijdf45grJX327yP6uyHRqb6hM
         yx0A5X7B8IqkjD10OlX+MM5KjmlxN/6dKndtfp5j1V6dbKlGUrNrIHN/hx07XuY1pJWz
         hIuTYXgDpaF5umFDhP0mmmWQq+aNcvBdCzjcWxT2+EgveGt3BiYjCIQ7Gzm4t0bHvB8P
         tlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lApkzQz97x0mjsEJc+j9OKw9zJ/S3b/963aKxsBJZWE=;
        b=4BoxSzcfO6Jql/sNEY/Flyspwbs9fy2OHGe9bN6Jc8OtHwAEFIQnTndJEMNLrWM+W3
         qPAgKn/qTV0dIwXkoyIf3f9VhEHZ67v5m6wE3/WDsJCDS7MB46QPFTDfTCNp35Q3nx67
         WUJ3QSqif6U6ftWECWJdn/xZJ+r4NP6T9IhMPwu5rpkveXO7pQISP4pkwyQiFOEPZiSR
         HYy5Y/Lv7NnHtVcmQ1tO7E4RIHfI126/ZuI+15PU7LnGAAgiWM/pHrZYF0Hjm+BxUkwA
         Rc8mTHUS2wnRIaGnRu30N8sNmCXAz+JxCMTN4JuiZjmBpBB3EtubMm7yqdjl30wOI6oS
         o7wQ==
X-Gm-Message-State: AOAM532LZ8cVtazVofuyhOY/44Vnx6i/Hky7pPy65NvA2f8XdOZhlSLE
        ue08hhEDgKJwA8dU+K/Prkr4pF0o1XKhsg==
X-Google-Smtp-Source: ABdhPJw2UJVkuEOYTtWmqnSoR08eKh7Ztez+zBpPkO6aA6imDoQs7i5kE5FwAfA2l7hYB7w1HV35rA==
X-Received: by 2002:aca:ad97:: with SMTP id w145mr1029114oie.238.1644295270406;
        Mon, 07 Feb 2022 20:41:10 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id l14sm4709367ooq.12.2022.02.07.20.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 20:41:09 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-usb@vger.kernel.org
Subject: [PATCH 2/2] drm/msm/dp: Implement oob_hotplug_event()
Date:   Mon,  7 Feb 2022 20:43:28 -0800
Message-Id: <20220208044328.588860-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220208044328.588860-1-bjorn.andersson@linaro.org>
References: <20220208044328.588860-1-bjorn.andersson@linaro.org>
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

The Qualcomm DisplayPort driver contains traces of the necessary
plumbing to hook up USB HPD, in the form of the dp_hpd module and the
dp_usbpd_cb struct. Use this as basis for implementing the
oob_hotplug_event() callback, by amending the dp_hpd module with the
missing logic.

Overall the solution is similar to what's done downstream, but upstream
all the code to disect the HPD notification lives on the calling side of
drm_connector_oob_hotplug_event().

drm_connector_oob_hotplug_event() performs the lookup of the
drm_connector based on fwnode, hence the need to assign the fwnode in
dp_drm_connector_init().

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c |  8 ++++++++
 drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
 drivers/gpu/drm/msm/dp/dp_drm.c     | 10 ++++++++++
 drivers/gpu/drm/msm/dp/dp_hpd.c     | 19 +++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_hpd.h     |  4 ++++
 5 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 7cc4d21f2091..124a2f794382 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -414,6 +414,13 @@ static int dp_display_usbpd_configure_cb(struct device *dev)
 	return dp_display_process_hpd_high(dp);
 }
 
+void dp_display_oob_hotplug_event(struct msm_dp *dp_display, bool hpd_state)
+{
+	struct dp_display_private *dp = container_of(dp_display, struct dp_display_private, dp_display);
+
+	dp->usbpd->oob_event(dp->usbpd, hpd_state);
+}
+
 static int dp_display_usbpd_disconnect_cb(struct device *dev)
 {
 	struct dp_display_private *dp = dev_get_dp_display_private(dev);
@@ -1251,6 +1258,7 @@ static int dp_display_probe(struct platform_device *pdev)
 	dp->pdev = pdev;
 	dp->name = "drm_dp";
 	dp->dp_display.connector_type = desc->connector_type;
+	dp->dp_display.dev = &pdev->dev;
 
 	rc = dp_init_sub_modules(dp);
 	if (rc) {
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index e3adcd578a90..1f856b3bca79 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -11,6 +11,7 @@
 #include "disp/msm_disp_snapshot.h"
 
 struct msm_dp {
+	struct device *dev;
 	struct drm_device *drm_dev;
 	struct device *codec_dev;
 	struct drm_bridge *bridge;
@@ -40,5 +41,6 @@ bool dp_display_check_video_test(struct msm_dp *dp_display);
 int dp_display_get_test_bpp(struct msm_dp *dp_display);
 void dp_display_signal_audio_start(struct msm_dp *dp_display);
 void dp_display_signal_audio_complete(struct msm_dp *dp_display);
+void dp_display_oob_hotplug_event(struct msm_dp *dp_display, bool hpd_state);
 
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index d4d360d19eba..665568197c49 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -123,6 +123,13 @@ static enum drm_mode_status dp_connector_mode_valid(
 	return dp_display_validate_mode(dp_disp, mode->clock);
 }
 
+static void dp_oob_hotplug_event(struct drm_connector *connector, bool hpd_state)
+{
+	struct msm_dp *dp_disp = to_dp_connector(connector)->dp_display;
+
+	dp_display_oob_hotplug_event(dp_disp, hpd_state);
+}
+
 static const struct drm_connector_funcs dp_connector_funcs = {
 	.detect = dp_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
@@ -130,6 +137,7 @@ static const struct drm_connector_funcs dp_connector_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.oob_hotplug_event = dp_oob_hotplug_event,
 };
 
 static const struct drm_connector_helper_funcs dp_connector_helper_funcs = {
@@ -160,6 +168,8 @@ struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display)
 	if (ret)
 		return ERR_PTR(ret);
 
+	connector->fwnode = fwnode_handle_get(dev_fwnode(dp_display->dev));
+
 	drm_connector_helper_add(connector, &dp_connector_helper_funcs);
 
 	/*
diff --git a/drivers/gpu/drm/msm/dp/dp_hpd.c b/drivers/gpu/drm/msm/dp/dp_hpd.c
index db98a1d431eb..3e62852a18b4 100644
--- a/drivers/gpu/drm/msm/dp/dp_hpd.c
+++ b/drivers/gpu/drm/msm/dp/dp_hpd.c
@@ -7,6 +7,7 @@
 
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <drm/drm_print.h>
 
 #include "dp_hpd.h"
 
@@ -45,6 +46,23 @@ int dp_hpd_connect(struct dp_usbpd *dp_usbpd, bool hpd)
 	return rc;
 }
 
+static void dp_hpd_oob_event(struct dp_usbpd *dp_usbpd, bool hpd_state)
+{
+	struct dp_hpd_private *hpd_priv = container_of(dp_usbpd, struct dp_hpd_private, dp_usbpd);
+
+	DRM_DEBUG_DP("hpd_state: %d connected: %d\n", hpd_state, dp_usbpd->connected);
+
+	if (!dp_usbpd->connected && hpd_state) {
+		dp_usbpd->connected = true;
+		hpd_priv->dp_cb->configure(hpd_priv->dev);
+	} else if (!hpd_state) {
+		dp_usbpd->connected = false;
+		hpd_priv->dp_cb->disconnect(hpd_priv->dev);
+	} else {
+		hpd_priv->dp_cb->attention(hpd_priv->dev);
+	}
+}
+
 struct dp_usbpd *dp_hpd_get(struct device *dev, struct dp_usbpd_cb *cb)
 {
 	struct dp_hpd_private *dp_hpd;
@@ -62,6 +80,7 @@ struct dp_usbpd *dp_hpd_get(struct device *dev, struct dp_usbpd_cb *cb)
 	dp_hpd->dp_cb = cb;
 
 	dp_hpd->dp_usbpd.connect = dp_hpd_connect;
+	dp_hpd->dp_usbpd.oob_event = dp_hpd_oob_event;
 
 	return &dp_hpd->dp_usbpd;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_hpd.h b/drivers/gpu/drm/msm/dp/dp_hpd.h
index 8feec5aa5027..310ecc2a8538 100644
--- a/drivers/gpu/drm/msm/dp/dp_hpd.h
+++ b/drivers/gpu/drm/msm/dp/dp_hpd.h
@@ -29,7 +29,9 @@ enum plug_orientation {
  * @hpd_irq: Change in the status since last message
  * @alt_mode_cfg_done: bool to specify alt mode status
  * @debug_en: bool to specify debug mode
+ * @connected: cable currently connected
  * @connect: simulate disconnect or connect for debug mode
+ * @oob_event: deliver oob event to the usbpd code
  */
 struct dp_usbpd {
 	enum plug_orientation orientation;
@@ -41,8 +43,10 @@ struct dp_usbpd {
 	bool hpd_irq;
 	bool alt_mode_cfg_done;
 	bool debug_en;
+	bool connected;
 
 	int (*connect)(struct dp_usbpd *dp_usbpd, bool hpd);
+	void (*oob_event)(struct dp_usbpd *dp_usbpd, bool hpd_state);
 };
 
 /**
-- 
2.33.1

