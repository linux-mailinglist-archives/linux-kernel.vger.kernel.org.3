Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D990B55A57D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiFYA2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFYA2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:28:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAAC60C6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:28:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so4228536pjj.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eo8KDBuZXXGU61Q/REIAXbWL789r8BFDqM6ILHy0GQM=;
        b=X3EZN9OGPC6PS+9+mT48UmEgC+O2kwcm3I3xcESHkSVeR0ZbfV1oGLNfSg50WpINH9
         pSix1Le24zQAMuiNbXkz1lSEcs/tFo3W9sYE4+dqJj3o+j4DlXABR3Nwjp6Q2HwuHWm8
         B7Pm5hLJ5DcHSyTq8ryNVgyyu6ldZceSv94RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eo8KDBuZXXGU61Q/REIAXbWL789r8BFDqM6ILHy0GQM=;
        b=pdF6w6FFfCGZ2LGHblQcSkzHGdSeMdxrMM3zZ+nB6NvhvDecC9sRvWpmTAq8Ph6Dph
         QgcbDqbyBms1oangcCotkB1l/D7rELHew0eQTRU9vRlc7Y7G5+vafWcmTH0Svq9Ecmi0
         pU2/jHf/6gddc53NfhgDqsW1qUlNDsuq3NBYmhp7pBuC45IUM9yxuZZRnQpx3tOpTKG0
         LvoI9PapfzdyFRTF7TT6V2nbgJN7tyMQqYyZKZdQ29ZTgdySe18HTnu3AbHjfEBYuzZr
         1QKNk7WwU8K3hPIZny0Wl23yeJ1DBm90yiEVRHWJ4KJvMI5qWzZSv3PdLiRM6hL+3ueg
         rdjw==
X-Gm-Message-State: AJIora8oGw9/0STaF56byttFynsdO/s6+TLR+pSfkBOAVt1RlN+j/rK8
        5PajyIYRtJ/iHsG0KoT6gR57lg==
X-Google-Smtp-Source: AGRyM1sW3fUXJAX0S08UlrfgeD5PfIjD5YtbHF7C9U9Yi5lr+A5PUn8RqH648X/V5Iu4JmB007GB5w==
X-Received: by 2002:a17:902:9a8d:b0:167:77c3:4c86 with SMTP id w13-20020a1709029a8d00b0016777c34c86mr1732142plp.122.1656116893344;
        Fri, 24 Jun 2022 17:28:13 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:b71b:2e04:d67e:178e])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm2367421pll.194.2022.06.24.17.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 17:28:12 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH] drm/msm/dp: Remove encoder pointer from struct msm_dp
Date:   Fri, 24 Jun 2022 17:28:11 -0700
Message-Id: <20220625002811.3225344-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to stash the encoder here. Instead we can simply pass it
around as an argument.

Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 +---
 drivers/gpu/drm/msm/dp/dp_display.h | 1 -
 drivers/gpu/drm/msm/dp/dp_drm.c     | 8 ++++----
 drivers/gpu/drm/msm/dp/dp_drm.h     | 2 +-
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index da5c03a8cc4c..798fd5398b48 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1621,8 +1621,6 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 		return ret;
 	}
 
-	dp_display->encoder = encoder;
-
 	ret = dp_display_get_next_bridge(dp_display);
 	if (ret)
 		return ret;
@@ -1638,7 +1636,7 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 
 	priv->bridges[priv->num_bridges++] = dp_display->bridge;
 
-	dp_display->connector = dp_drm_connector_init(dp_display);
+	dp_display->connector = dp_drm_connector_init(dp_display, encoder);
 	if (IS_ERR(dp_display->connector)) {
 		ret = PTR_ERR(dp_display->connector);
 		DRM_DEV_ERROR(dev->dev,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 4f9fe4d7610b..dcedf021f7fe 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -15,7 +15,6 @@ struct msm_dp {
 	struct device *codec_dev;
 	struct drm_bridge *bridge;
 	struct drm_connector *connector;
-	struct drm_encoder *encoder;
 	struct drm_bridge *next_bridge;
 	bool is_connected;
 	bool audio_enabled;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 62d58b9c4647..6df25f7662e7 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -116,7 +116,7 @@ struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_device *
 	}
 
 	if (dp_display->next_bridge) {
-		rc = drm_bridge_attach(dp_display->encoder,
+		rc = drm_bridge_attach(encoder,
 					dp_display->next_bridge, bridge,
 					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (rc < 0) {
@@ -130,15 +130,15 @@ struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_device *
 }
 
 /* connector initialization */
-struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display)
+struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display, struct drm_encoder *encoder)
 {
 	struct drm_connector *connector = NULL;
 
-	connector = drm_bridge_connector_init(dp_display->drm_dev, dp_display->encoder);
+	connector = drm_bridge_connector_init(dp_display->drm_dev, encoder);
 	if (IS_ERR(connector))
 		return connector;
 
-	drm_connector_attach_encoder(connector, dp_display->encoder);
+	drm_connector_attach_encoder(connector, encoder);
 
 	return connector;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index f4b1ed1e24f7..82035dbb0578 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -19,7 +19,7 @@ struct msm_dp_bridge {
 
 #define to_dp_bridge(x)     container_of((x), struct msm_dp_bridge, bridge)
 
-struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display);
+struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display, struct drm_encoder *encoder);
 struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_device *dev,
 			struct drm_encoder *encoder);
 

base-commit: 24df12013853ac59c52cc726e9cbe51e38d09eda
-- 
https://chromeos.dev

