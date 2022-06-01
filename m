Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA988539F3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350655AbiFAITV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350608AbiFAITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:19:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9AD8B0B5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:18:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so1347336pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tde+IhIAyMS5phfhjLJ/xUjc9TpTeEZ8Vt0Thw0su/Y=;
        b=AvPaiVerLhPA7bu4ah3qZZGvu6x+scDrnj9QwMVpBGEzH3jZ7jjZctDsthGN2X75vw
         +gqQh9EYZiKEDVg457+bSPZMSAva31GxPBAHUAeqWSP4I5zE+e61zJti+EJ+Q8OnrZ/N
         KigOKjCuq65/FJ5z6+Tj+iW5NfPqCgjMotibk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tde+IhIAyMS5phfhjLJ/xUjc9TpTeEZ8Vt0Thw0su/Y=;
        b=798ffEB4B6kOoOxPiyf6e9UCajSf8WEe3alWdbVGoluTTxk+E87cgLHb9dasuWozlL
         vjrS/xzIMeTUdnM7iyIFCGWZ17zuhZ61D+FttOITEwzVapQC/U+P/tZNJKaRnGlfyLHD
         WxioOgK3c4qvNUbFknQD/7Mlf3MIICkaJC9duaVk2Vt4JhArNq0+WCCsS4tLBB9jbBOE
         vdZr4m2znqKx+yrpfrh4m0m/Yg5QyPmcMWbKMwMf0YI3K8is3s+kPVgMPlBy7Ek0pPby
         Kiy2EiJbLW1nrC0S7PRP5906eQkj+AVfHHcNTkAbGnibX6Jq3Wq2agStmRVMLK/pYGne
         WGRQ==
X-Gm-Message-State: AOAM533dVpXIfpY7Xs1l5BMm4JClsbTZQYzAG4fbWUBMpYIOyKYdvuzY
        fmcJ/BDUoIFwpdqJDeMqjFu7Jg==
X-Google-Smtp-Source: ABdhPJyJZ9Nd5iUhCD6MyJuY2jjn3E+5iA+mGbWJIcSz/UCeJVMvsyFTNMYYQQ2/CExPe30dQ0kFsA==
X-Received: by 2002:a17:90b:1e44:b0:1e2:e772:5f08 with SMTP id pi4-20020a17090b1e4400b001e2e7725f08mr17755299pjb.129.1654071539081;
        Wed, 01 Jun 2022 01:18:59 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b0050dc7628182sm824680pfo.92.2022.06.01.01.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:18:58 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] drm/mediatek: Config orientation property if panel provides it
Date:   Wed,  1 Jun 2022 16:18:23 +0800
Message-Id: <20220601081823.1038797-9-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601081823.1038797-1-hsinyi@chromium.org>
References: <20220601081823.1038797-1-hsinyi@chromium.org>
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

Panel orientation property should be set before drm_dev_register().
Mediatek drm driver calls drm_dev_register() in .bind(). However, most
panels sets orientation property relatively late, mostly in .get_modes()
callback, since this is when they are able to get the connector and
binds the orientation property to it, though the value should be known
when the panel is probed.

Let the drm driver check if the remote end point is a panel and if it
contains the orientation property. If it does, set it before
drm_dev_register() is called.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
The concept is the same as the previous version.
https://patchwork.kernel.org/project/linux-mediatek/patch/20220530113033.124072-1-hsinyi@chromium.org/
The only difference is, it now uses the panel API instead of parsing
orientation from the driver.
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index bd3f5b485085..12836a697f56 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -185,6 +185,7 @@ struct mtk_dsi {
 	struct drm_encoder encoder;
 	struct drm_bridge bridge;
 	struct drm_bridge *next_bridge;
+	struct drm_panel *panel;
 	struct drm_connector *connector;
 	struct phy *phy;
 
@@ -822,6 +823,16 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 		ret = PTR_ERR(dsi->connector);
 		goto err_cleanup_encoder;
 	}
+
+	/* Read panel orientation */
+	if (dsi->panel) {
+		enum drm_panel_orientation orientation;
+
+		orientation = drm_panel_get_orientation(dsi->panel);
+		if (orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
+			drm_connector_set_panel_orientation(dsi->connector, orientation);
+	}
+
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
 	return 0;
@@ -837,6 +848,9 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
 	struct drm_device *drm = data;
 	struct mtk_dsi *dsi = dev_get_drvdata(dev);
 
+	/* Get panel if existed */
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &dsi->panel, NULL);
+
 	ret = mtk_dsi_encoder_init(drm, dsi);
 	if (ret)
 		return ret;
-- 
2.36.1.255.ge46751e96f-goog

