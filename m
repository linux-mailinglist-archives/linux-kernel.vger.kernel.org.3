Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4B5539BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349468AbiFADkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349462AbiFADkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:40:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A02F694B5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:40:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g184so712148pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5mfO6LDCxvPgKYka8jk5OyHXRXc0q1t4jWcU47/N1fE=;
        b=ZmjqddQ3/TmHRhoFCiYRGDBVmexjqsYn/xpzktYFjtQbhCliZhc2Fo2Kem/7VqXdet
         wx8ZN9pcaCrJxBj1ICSqf3hm2Cha9vh+PIIqXQW2OT6+hpSYeQMEyBbj1abdvp7DP1Uv
         yKuIprZ6YV1f1nI+39tAs0URrBpNXauRUL+iDRG5idR/R0qx2BuRQqWl9VlJdp8Owv6r
         zgesTyoa4BjdC03XSI8eIyz5MVoJQzWPoQjc/So+mLQYHV2OzND0AYd+7x1YGPB3GwBD
         bT2QosR2IrQjlurZrVmpVWpicmDeb8q3UuSrAbzp2KdHFcTwPPrpbYwZL8FiYG25fu3n
         +53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5mfO6LDCxvPgKYka8jk5OyHXRXc0q1t4jWcU47/N1fE=;
        b=GYkhxUmziYpZbUJdNDIeOniU5r/fS6lZB+DAbmZDfwReLST0bMk62SA3Tq7Oc76ni9
         we/CNB46J4c4Xci7zBIpFYNXuOU3HidjO9e+29PSd7CpipglWPot9nS/7AhWBMZYavwZ
         EOKjInwcDEr0t2Y1AAAqM5wL1HynxFzZ24YGgPUSgpy2kOpY36+do4E4PvsiHtsQbq1c
         Tvb53WWpOjS+lda6idK8Qz8i7RMvhUmfzCIE0uDGrGg0A5iaQCTH4gEh0ulrctT+k4Wp
         f3pPSo5yrVXRQ+hYvoSzyP7pt+9vSCRjNv/Lu5bmq+glEBPPdO3Y8reFaWp1FCfHp93O
         +oNA==
X-Gm-Message-State: AOAM531xzI923NoyyvXlp8+r8cmS5tWk14QauOEFu829k2PzgefCx6cV
        61HAw7kFcDjTpSuxiyFFvio=
X-Google-Smtp-Source: ABdhPJycr/phEanwFwmpfw4hc6pHiRMgRyg56Yj4FnBPh+sXAB7aZxKJJxZAr5MysBkhTPDTMd6V+w==
X-Received: by 2002:a63:6901:0:b0:3f9:caa5:cffc with SMTP id e1-20020a636901000000b003f9caa5cffcmr47846682pgc.324.1654054808681;
        Tue, 31 May 2022 20:40:08 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id dw15-20020a17090b094f00b001e0b971196csm2732415pjb.57.2022.05.31.20.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 20:40:08 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH v2 2/2] drm/meson: encoder_hdmi: Fix refcount leak in meson_encoder_hdmi_init
Date:   Wed,  1 Jun 2022 07:39:27 +0400
Message-Id: <20220601033927.47814-3-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601033927.47814-1-linmq006@gmail.com>
References: <20220601033927.47814-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_graph_get_remote_node() returns remote device nodepointer with
refcount incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: e67f6037ae1b ("drm/meson: split out encoder from meson_dw_hdmi")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- call of_node_put() after of_find_device_by_node() and error paths
before of_find_device_by_node();
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 5e306de6f485..0d532e8e8cca 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -365,7 +365,8 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
 	meson_encoder_hdmi->next_bridge = of_drm_find_bridge(remote);
 	if (!meson_encoder_hdmi->next_bridge) {
 		dev_err(priv->dev, "Failed to find HDMI transceiver bridge\n");
-		return -EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
+		goto err_put_node;
 	}
 
 	/* HDMI Encoder Bridge */
@@ -383,7 +384,7 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
 				      DRM_MODE_ENCODER_TMDS);
 	if (ret) {
 		dev_err(priv->dev, "Failed to init HDMI encoder: %d\n", ret);
-		return ret;
+		goto err_put_node;
 	}
 
 	meson_encoder_hdmi->encoder.possible_crtcs = BIT(0);
@@ -393,7 +394,7 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
 				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret) {
 		dev_err(priv->dev, "Failed to attach bridge: %d\n", ret);
-		return ret;
+		goto err_put_node;
 	}
 
 	/* Initialize & attach Bridge Connector */
@@ -401,7 +402,8 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
 							&meson_encoder_hdmi->encoder);
 	if (IS_ERR(meson_encoder_hdmi->connector)) {
 		dev_err(priv->dev, "Unable to create HDMI bridge connector\n");
-		return PTR_ERR(meson_encoder_hdmi->connector);
+		ret = PTR_ERR(meson_encoder_hdmi->connector);
+		goto err_put_node;
 	}
 	drm_connector_attach_encoder(meson_encoder_hdmi->connector,
 				     &meson_encoder_hdmi->encoder);
@@ -428,6 +430,7 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
 	meson_encoder_hdmi->connector->ycbcr_420_allowed = true;
 
 	pdev = of_find_device_by_node(remote);
+	of_node_put(remote);
 	if (pdev) {
 		struct cec_connector_info conn_info;
 		struct cec_notifier *notifier;
@@ -444,4 +447,8 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
 	dev_dbg(priv->dev, "HDMI encoder initialized\n");
 
 	return 0;
+
+err_put_node:
+	of_node_put(remote);
+	return ret;
 }
-- 
2.25.1

