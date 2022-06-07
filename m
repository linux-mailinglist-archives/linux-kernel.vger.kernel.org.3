Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFA653F913
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbiFGJGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbiFGJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:06:26 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB3DFD13
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:06:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c14so15244390pgu.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lndmMwy1Xi5onPK/2gR/uuIgcJtx+Xqka0AqhZOCETk=;
        b=nEwqxsOomZ0VyeLUG6ZdtIT5DHvDyUz42wh0TrdWqyIV7DES04zqZT/xTI4m/jl4wJ
         7spZlLhVnaPE9NGehQBm6p/6cay1FPtBmqiYv//gBqWsA0rsYdzGXBPrKChzufa8M3X8
         yHZDSKUIaIuf8HkJxNNZ8scTGDOI7mvF2sKjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lndmMwy1Xi5onPK/2gR/uuIgcJtx+Xqka0AqhZOCETk=;
        b=EYMuA4CQ6KKB8A5+sInD4KbSF4deUKnE4TH6NgYKdvpDn6OKop70bQLw3h5rgjxIGq
         mxOi+2u7Sv3jzC23MnzaoP1F/NGAAVnLjDVwkuTTORqSWCVYBfZawiuRbjouUDNKDVky
         AtxgMV6NNIsYNMHUUr//RTNh2mvqBA4jQTQ20WgMfuggiul6YbDab+Fj5EILq6bQeW6e
         A3FSNX2melABIIA5SKr/CGcTFl8l4zJbWx1RfKn1B8Y5nPbs0x9hGH/+k1iYnroBLeKo
         8ucu9TZ9fVpoybwSl2St6B4tad9b+8ZBcmw55iZYAGemYf8XFLD0RvOjO0wSriDzksyr
         y8qA==
X-Gm-Message-State: AOAM532yoDKB1HJwkkoslSgT0Rb6jRGTg+LGrHBep9c6bLoUmos9Clsp
        vXD22S1gq/nBH7GL75SV6IpptQ==
X-Google-Smtp-Source: ABdhPJy9/p/zRGqxgyYDjGPvzOwSsGPu3zYSpJfyIjbAxG5xTl/4JRnWDwLQuIRLjKB4AcijPvphZQ==
X-Received: by 2002:a63:8641:0:b0:3fd:94e8:a650 with SMTP id x62-20020a638641000000b003fd94e8a650mr11053873pgd.367.1654592783556;
        Tue, 07 Jun 2022 02:06:23 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40b7:55ce:10ee:c7a0])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7947b000000b0051c0fe8fb8csm4507010pfq.95.2022.06.07.02.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:06:23 -0700 (PDT)
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
Subject: [PATCH v5 8/8] drm/mediatek: Config orientation property if panel provides it
Date:   Tue,  7 Jun 2022 17:05:49 +0800
Message-Id: <20220607090549.2345795-9-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607090549.2345795-1-hsinyi@chromium.org>
References: <20220607090549.2345795-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v4->v5:
- use the new function in v5.
- don't use drm_of_find_panel_or_bridge().
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index d9f10a33e6fa..998b1237e193 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -185,6 +185,7 @@ struct mtk_dsi {
 	struct drm_encoder encoder;
 	struct drm_bridge bridge;
 	struct drm_bridge *next_bridge;
+	struct drm_panel *panel;
 	struct drm_connector *connector;
 	struct phy *phy;
 
@@ -822,6 +823,10 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 		ret = PTR_ERR(dsi->connector);
 		goto err_cleanup_encoder;
 	}
+
+	/* Read panel orientation */
+	drm_connector_set_orientation_from_panel(dsi->connector, dsi->panel);
+
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
 	return 0;
@@ -836,6 +841,16 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
 	int ret;
 	struct drm_device *drm = data;
 	struct mtk_dsi *dsi = dev_get_drvdata(dev);
+	struct device_node *panel_node;
+
+	/* Get panel if existed */
+	panel_node = of_graph_get_remote_node(dev->of_node, 0, 0);
+	if (panel_node) {
+		dsi->panel = of_drm_find_panel(panel_node);
+		if (IS_ERR(dsi->panel))
+			dsi->panel = NULL;
+		of_node_put(panel_node);
+	}
 
 	ret = mtk_dsi_encoder_init(drm, dsi);
 	if (ret)
-- 
2.36.1.255.ge46751e96f-goog

