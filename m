Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1B552254E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiEJUOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiEJUOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:14:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6712F1A82E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:14:03 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p12so159774pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DUzehr5/WVjL8qU2Hhmc4z1UOFK/igoFfwz7SYv3SuU=;
        b=FK/uP2sqm4PA+iTuTOw9AHlnxLeLvs/2DmFJjZLlevCJ0Os/8Ujbb3/YC/pvOZsdOy
         EGV440Vp4/1/E6YECIBaKnkqtGYVEHdAKOM5nB8H5VCLOQxC/guqkvRpnPOucq1azu5G
         H3sTB/LkQLnn/UUjLSL3LzZCHo8Z82aa5CLxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DUzehr5/WVjL8qU2Hhmc4z1UOFK/igoFfwz7SYv3SuU=;
        b=A0G9X+IeOo/nGL6BydtJnz19/GCmbWIiIxIRXkCt67XUzb4whmqHfVeGv4QCNb4giZ
         wuzLya0SmyScMJO5UG/jh1bYwpyi1RQvGQXaLGCmfAvn9J/VdpcclSbgAOf8OFy7EkUy
         /vmp223MKtHDhK7LBuzfp5XN1CgX6ao7O5KG10/gHsir0JElpWEtcQOOav7TUSLFif8/
         EEcLy7S65mHRR3MIq9LbBojTKTvBuq2ZyU33zCFUtYchfOyzWEzge1lJBsA72bkfvgVj
         HlD2pjl23fWFeic6SlVAG6H7CQyEj4J95/XmMoNsIeZpGFNbyNo0Nlf0n8p0hDvA/GxM
         YmAg==
X-Gm-Message-State: AOAM532OzeNLR5jJPcbpHEnG8P1xxl/4dLs+VLP8kFiljWQKWBj8fSiy
        YBYNvKJQDwwkCV5U7hKQY1g5AQ==
X-Google-Smtp-Source: ABdhPJw1DnT71ONYuAfGck1I9ifq2RpS3pd461/n3OJS5+buAJwc493OLPwnPeGsVXsyy6glR2bqxA==
X-Received: by 2002:a62:1d09:0:b0:50d:fa91:a4c5 with SMTP id d9-20020a621d09000000b0050dfa91a4c5mr22174472pfd.25.1652213642912;
        Tue, 10 May 2022 13:14:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6f08:624c:c762:d238])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902704800b0015e8d4eb247sm26605plt.145.2022.05.10.13.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:14:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     quic_khsieh@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_sbillaka@quicinc.com, quic_aravindh@quicinc.com,
        freedreno@lists.freedesktop.org, ville.syrjala@linux.intel.com,
        quic_abhinavk@quicinc.com, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        tzimmermann@suse.de, Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/probe-helper: Add helper for drm_helper_probe_single_connector_modes()
Date:   Tue, 10 May 2022 13:13:33 -0700
Message-Id: <20220510131309.v2.1.I2dd93486c6952bd52f2020904de0133970d11b29@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_helper_probe_single_connector_modes() is a bit long. Let's
break a chunk off to update and validate modes. This helps avoid one
goto and also will allow us to more easily call the helper a second
time in a future patch without adding looping or another goto.

This change is intended to be a no-op change--just code movement.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---

Changes in v2:
- Two underscores for __drm_helper_update_and_validate().
- Return err and use WARN_ON instead of returning a bool.

 drivers/gpu/drm/drm_probe_helper.c | 107 ++++++++++++++++-------------
 1 file changed, 61 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 682359512996..ff3dd9a5da70 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -354,6 +354,61 @@ drm_helper_probe_detect(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_helper_probe_detect);
 
+static int __drm_helper_update_and_validate(struct drm_connector *connector,
+					    uint32_t maxX, uint32_t maxY,
+					    struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_display_mode *mode;
+	int mode_flags = 0;
+	int ret;
+
+	drm_connector_list_update(connector);
+
+	if (connector->interlace_allowed)
+		mode_flags |= DRM_MODE_FLAG_INTERLACE;
+	if (connector->doublescan_allowed)
+		mode_flags |= DRM_MODE_FLAG_DBLSCAN;
+	if (connector->stereo_allowed)
+		mode_flags |= DRM_MODE_FLAG_3D_MASK;
+
+	list_for_each_entry(mode, &connector->modes, head) {
+		if (mode->status != MODE_OK)
+			continue;
+
+		mode->status = drm_mode_validate_driver(dev, mode);
+		if (mode->status != MODE_OK)
+			continue;
+
+		mode->status = drm_mode_validate_size(mode, maxX, maxY);
+		if (mode->status != MODE_OK)
+			continue;
+
+		mode->status = drm_mode_validate_flag(mode, mode_flags);
+		if (mode->status != MODE_OK)
+			continue;
+
+		ret = drm_mode_validate_pipeline(mode, connector, ctx,
+						 &mode->status);
+		if (ret) {
+			drm_dbg_kms(dev,
+				    "drm_mode_validate_pipeline failed: %d\n",
+				    ret);
+
+			if (drm_WARN_ON_ONCE(dev, ret != -EDEADLK))
+				mode->status = MODE_ERROR;
+			else
+				return -EDEADLK;
+		}
+
+		if (mode->status != MODE_OK)
+			continue;
+		mode->status = drm_mode_validate_ycbcr420(mode, connector);
+	}
+
+	return 0;
+}
+
 /**
  * drm_helper_probe_single_connector_modes - get complete set of display modes
  * @connector: connector to probe
@@ -421,7 +476,6 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 	const struct drm_connector_helper_funcs *connector_funcs =
 		connector->helper_private;
 	int count = 0, ret;
-	int mode_flags = 0;
 	bool verbose_prune = true;
 	enum drm_connector_status old_status;
 	struct drm_modeset_acquire_ctx ctx;
@@ -519,52 +573,13 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 			   connector->status == connector_status_unknown))
 		count = drm_add_modes_noedid(connector, 1024, 768);
 	count += drm_helper_probe_add_cmdline_mode(connector);
-	if (count == 0)
-		goto prune;
-
-	drm_connector_list_update(connector);
-
-	if (connector->interlace_allowed)
-		mode_flags |= DRM_MODE_FLAG_INTERLACE;
-	if (connector->doublescan_allowed)
-		mode_flags |= DRM_MODE_FLAG_DBLSCAN;
-	if (connector->stereo_allowed)
-		mode_flags |= DRM_MODE_FLAG_3D_MASK;
-
-	list_for_each_entry(mode, &connector->modes, head) {
-		if (mode->status != MODE_OK)
-			continue;
-
-		mode->status = drm_mode_validate_driver(dev, mode);
-		if (mode->status != MODE_OK)
-			continue;
-
-		mode->status = drm_mode_validate_size(mode, maxX, maxY);
-		if (mode->status != MODE_OK)
-			continue;
-
-		mode->status = drm_mode_validate_flag(mode, mode_flags);
-		if (mode->status != MODE_OK)
-			continue;
-
-		ret = drm_mode_validate_pipeline(mode, connector, &ctx,
-						 &mode->status);
-		if (ret) {
-			drm_dbg_kms(dev,
-				    "drm_mode_validate_pipeline failed: %d\n",
-				    ret);
-
-			if (drm_WARN_ON_ONCE(dev, ret != -EDEADLK)) {
-				mode->status = MODE_ERROR;
-			} else {
-				drm_modeset_backoff(&ctx);
-				goto retry;
-			}
+	if (count != 0) {
+		ret = __drm_helper_update_and_validate(connector, maxX, maxY, &ctx);
+		if (ret == -EDEADLK) {
+			drm_modeset_backoff(&ctx);
+			goto retry;
 		}
-
-		if (mode->status != MODE_OK)
-			continue;
-		mode->status = drm_mode_validate_ycbcr420(mode, connector);
+		WARN_ON(ret);
 	}
 
 prune:
-- 
2.36.0.550.gb090851708-goog

