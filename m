Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1DD58E5B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiHJDsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiHJDrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:47:51 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587BC8048F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:47:42 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10dc1b16c12so16415792fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OrvhzzFeEQ614iYpJi4RpAo3OO9GtQhsYPoeao237mM=;
        b=o2KWV7fzDUx5XIhnKNSex0s3xUanf9/PrjC9cgwIFruevVqDb+fSg3/J69STGtLDed
         KXvhBTwD/6SF3YJq1YugVdjrUC9vbFyBWEMuAXIaLjrcUUL43XTgKlU1lmquBciQyNyu
         sCG5QboEU2v1XYLtbS5zlTFoX5xRT6lxW51+KDYulxkSBVYSilnPeNLTxg0IILpRNKZa
         cj1wN5lGcJEuhZEiYJdA5WQXarIm+OLlkidR2POyAiA/cFDVx/k3AOc38Eb79ZK8ArmT
         wXdR8FyJz5lfLiXB9RBrDz2qU1x9d21rtKRH1n4jdQ/1ISwYaDZi4H0JQ2MLe5yMIGba
         RoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OrvhzzFeEQ614iYpJi4RpAo3OO9GtQhsYPoeao237mM=;
        b=m9WCQM9PqiLqbr/+V1MXGARZr/7KZj3CmEa63wZ53+TMn0UghABF1EaJm9Vh9R/MCJ
         XNrsqgPfgzyVLX9PSmqQ1PWETsISmAy8NIw782E6TLUyg4Y8Xhe9P1UQmX0aXqtrtYgL
         KOyz/04cH/AMFQSkkMYVBoN5BW039GnboGtjjmNFlw383OpGzNTDWqhVYE/QPrHtC2YQ
         jNnwLa7tc3kGIGd2JtkS+HrLmknhKsOPaJEzbj3v9GB+mwxM08R12+z6b65TAWMYULSB
         Im8WchhQHtuLTz0TlEOHtthiNCvI+m8B71bnYugNtI4rZ03ofcNHVl+1SJut7LDlv1Tg
         d/nQ==
X-Gm-Message-State: ACgBeo0FHyYkhqtPK5kKTNahG264amgdmDyfG7Z0xRnuiUgFY3W5hKwC
        zbYzS1MF5W2b4NXnSjZtO3PtcA==
X-Google-Smtp-Source: AA6agR7WaHss0bZgv6umP1AclSIS8GBXrfsMmBcv6nMDeJlOSHhHYvmtqDPFDzr0yr+ojvwvUFrrHw==
X-Received: by 2002:a05:6870:d208:b0:10f:72d:4ee0 with SMTP id g8-20020a056870d20800b0010f072d4ee0mr670869oac.227.1660103261661;
        Tue, 09 Aug 2022 20:47:41 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n2-20020a4ae742000000b00444f26822e5sm454337oov.10.2022.08.09.20.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 20:47:41 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] drm/msm/dp: Implement hpd_notify()
Date:   Tue,  9 Aug 2022 20:50:11 -0700
Message-Id: <20220810035013.3582848-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220810035013.3582848-1-bjorn.andersson@linaro.org>
References: <20220810035013.3582848-1-bjorn.andersson@linaro.org>
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

The DisplayPort controller's hot-plug mechanism is based on pinmuxing a
physical signal no a GPIO pin into the controller. This is not always
possible, either because there aren't dedicated GPIOs available or
because the hot-plug signal is a virtual notification, in cases such as
USB Type-C.

For these cases, by implementing the hpd_notify() callback for the
DisplayPort controller's drm_bridge, a downstream drm_bridge
(next_bridge) can be used to track and signal the connection status
changes.

This makes it possible to use downstream drm_bridges such as
display-connector or any virtual mechanism, as long as they are
implemented as a drm_bridge.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  3 +++
 drivers/gpu/drm/msm/dp/dp_drm.h     |  2 ++
 4 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 699f28f2251e..568295381246 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1303,6 +1303,7 @@ static int dp_display_probe(struct platform_device *pdev)
 	if (!desc)
 		return -EINVAL;
 
+	dp->dp_display.dev = &pdev->dev;
 	dp->pdev = pdev;
 	dp->name = "drm_dp";
 	dp->id = desc->id;
@@ -1765,3 +1766,25 @@ void dp_bridge_mode_set(struct drm_bridge *drm_bridge,
 	dp_display->dp_mode.h_active_low =
 		!!(dp_display->dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
 }
+
+void dp_bridge_hpd_notify(struct drm_bridge *bridge,
+			  enum drm_connector_status status)
+{
+	struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
+	struct msm_dp *dp_display = dp_bridge->dp_display;
+	struct dp_display_private *dp = container_of(dp_display, struct dp_display_private, dp_display);
+
+	/* Without next_bridge interrupts are handled by the DP core directly */
+	if (!dp_display->next_bridge)
+		return;
+
+	if (!dp->core_initialized) {
+		drm_dbg_dp(dp->drm_dev, "not initialized\n");
+		return;
+	}
+
+	if (!dp_display->is_connected && status == connector_status_connected)
+		dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
+	else if (dp_display->is_connected && status == connector_status_disconnected)
+		dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
+}
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index dcedf021f7fe..d7bc537ead31 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -11,6 +11,7 @@
 #include "disp/msm_disp_snapshot.h"
 
 struct msm_dp {
+	struct device *dev;
 	struct drm_device *drm_dev;
 	struct device *codec_dev;
 	struct drm_bridge *bridge;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 6df25f7662e7..875b23910bef 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -68,6 +68,7 @@ static const struct drm_bridge_funcs dp_bridge_ops = {
 	.mode_valid   = dp_bridge_mode_valid,
 	.get_modes    = dp_bridge_get_modes,
 	.detect       = dp_bridge_detect,
+	.hpd_notify   = dp_bridge_hpd_notify,
 };
 
 struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_device *dev,
@@ -138,6 +139,8 @@ struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display, struct dr
 	if (IS_ERR(connector))
 		return connector;
 
+	connector->fwnode = fwnode_handle_get(dev_fwnode(dp_display->dev));
+
 	drm_connector_attach_encoder(connector, encoder);
 
 	return connector;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index 82035dbb0578..79e6b2cf2d25 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -32,5 +32,7 @@ enum drm_mode_status dp_bridge_mode_valid(struct drm_bridge *bridge,
 void dp_bridge_mode_set(struct drm_bridge *drm_bridge,
 			const struct drm_display_mode *mode,
 			const struct drm_display_mode *adjusted_mode);
+void dp_bridge_hpd_notify(struct drm_bridge *bridge,
+			  enum drm_connector_status status);
 
 #endif /* _DP_DRM_H_ */
-- 
2.35.1

