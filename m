Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22661510765
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352300AbiDZSuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbiDZSuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:50:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF1E89CC2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:47:11 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id i62so4612925pgd.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNPhuCT76qA1HQ8jsp8ivJVMa3tulsabXFtzJpJBhPs=;
        b=d0R9Datgcjx0dtRH18O4eGeuP/02RmWwNyFLxcUk94GR9KyWIR5HHfvio5VldwlFY/
         POd6UXcXZ3ABHMsIn954aXk19N1evea074yhvchiWA+N6RouViWkvoLmYWrzocY1sGMn
         rL/XObfXzumEiwmDgAy6r3BNCbFRdLZqhpLBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNPhuCT76qA1HQ8jsp8ivJVMa3tulsabXFtzJpJBhPs=;
        b=ex+9yatVtJlLli9vOhG2gzxfAfj0327NkqDMj5XHrHxcXwao6Z2julp4W36ykhOS4K
         qYd7E6RxgURgIM1GKIxWmjhBzl0VO1fEd3ZLCbckcHkuzNsEX1EuzvRqeY3sULrMvmjR
         zuXjbWTswYjJqWKMMmMHSEhcpsKMvmp3I0Y0890ejpbz8D5LXpmN+p/SyUmDuFyfgg7r
         ua9TJ+CKd/DxODEsYitdcFHLOGdlyg7oawWKLKuhZ09pCgE2uwUJVaSr0RF6LcTLG3oH
         DhQG+YvWth7IGvUWAfJkuABaytyBahYeabjTnZ6RCggm++YeT/wZwNBaSa3rlj6JGqny
         13tg==
X-Gm-Message-State: AOAM532rqjFfpDvYbAgK1WbS6smDmRNW14uepGH1qFx1rws4N4YpG0pv
        A5UrFcp7jjFvbHlh48qJguSHqA==
X-Google-Smtp-Source: ABdhPJzpVJ4/P4pT54blJ/GUKBW2RU9EpDtmWHh7QkA9X5s7rM+Lwfc6H9IyqTdQUFnUIeJSkVZe7g==
X-Received: by 2002:a65:6a16:0:b0:39d:4f3:67e6 with SMTP id m22-20020a656a16000000b0039d04f367e6mr21199191pgu.84.1650998830924;
        Tue, 26 Apr 2022 11:47:10 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:8e92:9f42:eda6:c0ee])
        by smtp.gmail.com with ESMTPSA id p185-20020a62d0c2000000b0050d1f7c515esm12584396pfg.219.2022.04.26.11.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:47:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     dmitry.baryshkov@linaro.org, swboyd@chromium.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        robdclark@gmail.com, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_sbillaka@quicinc.com,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/probe-helper: Add helper for drm_helper_probe_single_connector_modes()
Date:   Tue, 26 Apr 2022 11:46:50 -0700
Message-Id: <20220426114627.1.I2dd93486c6952bd52f2020904de0133970d11b29@changeid>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---

 drivers/gpu/drm/drm_probe_helper.c | 105 ++++++++++++++++-------------
 1 file changed, 59 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 682359512996..819225629010 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -354,6 +354,61 @@ drm_helper_probe_detect(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_helper_probe_detect);
 
+static bool _drm_helper_update_and_validate(struct drm_connector *connector,
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
+				return true;
+		}
+
+		if (mode->status != MODE_OK)
+			continue;
+		mode->status = drm_mode_validate_ycbcr420(mode, connector);
+	}
+
+	return false;
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
@@ -519,52 +573,11 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
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
+		if (_drm_helper_update_and_validate(connector, maxX, maxY, &ctx)) {
+			drm_modeset_backoff(&ctx);
+			goto retry;
 		}
-
-		if (mode->status != MODE_OK)
-			continue;
-		mode->status = drm_mode_validate_ycbcr420(mode, connector);
 	}
 
 prune:
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

