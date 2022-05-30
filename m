Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F255379E7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiE3Laq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiE3Lam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:30:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6E57E1FC
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:30:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j7so4884866pjn.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LR1Tu5dH4Zqx/bEdD15yjr+iCH9O5A3630Rxdr7ufM=;
        b=iq8hfF07jpOTw9vnza7dhu2R3VgXuYuWFbQJXvXUywAg2a7FwiOA9DZqik/AY+Iw9c
         dc/xqzKTnSpkG4Gh/1+wb2Uql6MKGJ0DAAuxrH9DZ4Da2i1MSSRBR+OHp1JrCV9OcEq4
         Ow/85pl2hxvu+EJ2Ie5FMtST8Go1YBa+6Npvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LR1Tu5dH4Zqx/bEdD15yjr+iCH9O5A3630Rxdr7ufM=;
        b=Zj4U7USkrgXo1e68InxL2Ofil1SRGFScbzmH8waK4FfuGO+VelVhaAu2QW+TzhORxq
         nXzbwsc82wWiCY+2mwyvFyrKWY6CqFWAxhYgCqlsk3/M2lnh9+SL0dnChFXmOBKHxxA8
         L6o3PGDilJ16gy8PofXLil1/iB4pO/qLZfRoMeTzCC68IH8ikhm22wpnnl/iQGS2SYi7
         kWCo3JvNousfAJ439GqbbQ6z4Ng3uPYq5VRa1wvxY1nRcsjFcrhELiT3vtvFdWptG3Ip
         Qd4ZyFghfZNa5BptYQdcJcaWGWlRgE/2yj+GuWJiQNWskSoytv9BkoliZbwmHgdZXsVG
         cLhA==
X-Gm-Message-State: AOAM533D3sIdZoEuTnBe0reeVrJqlOnaUAYtne8GNbsRCqArltVlFjEm
        NE64e9qyZ3dPU8cRdoORe96L5A==
X-Google-Smtp-Source: ABdhPJyNeD8LmDCsvC/XVQPkRq4HOHV0lgFLmaOFAz25EFxhZMA8/4iMeqygIHLdjPqRtFlwHfwzuQ==
X-Received: by 2002:a17:902:b688:b0:162:3124:cde2 with SMTP id c8-20020a170902b68800b001623124cde2mr36157868pls.166.1653910239861;
        Mon, 30 May 2022 04:30:39 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ae1c:3d63:abec:1097])
        by smtp.gmail.com with ESMTPSA id o3-20020a654583000000b003fa5b550303sm8384222pgq.68.2022.05.30.04.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:30:39 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
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
Subject: [PATCH 1/2] drm/mediatek: Config orientation property if panel provides it
Date:   Mon, 30 May 2022 19:30:32 +0800
Message-Id: <20220530113033.124072-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
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
This patch is to solve the same problem as [1]
[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220530081910.3947168-2-hsinyi@chromium.org/
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index d9f10a33e6fa..091107f97ccc 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -198,6 +198,7 @@ struct mtk_dsi {
 
 	unsigned long mode_flags;
 	enum mipi_dsi_pixel_format format;
+	enum drm_panel_orientation orientation;
 	unsigned int lanes;
 	struct videomode vm;
 	struct mtk_phy_timing phy_timing;
@@ -822,6 +823,10 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 		ret = PTR_ERR(dsi->connector);
 		goto err_cleanup_encoder;
 	}
+
+	if (dsi->orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
+		drm_connector_set_panel_orientation(dsi->connector, dsi->orientation);
+
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
 	return 0;
@@ -836,6 +841,14 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
 	int ret;
 	struct drm_device *drm = data;
 	struct mtk_dsi *dsi = dev_get_drvdata(dev);
+	struct drm_panel *panel;
+
+	/* Read panel orientation if existed */
+	dsi->orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &panel, NULL);
+	if (!ret && panel && panel->dev) {
+		of_drm_get_panel_orientation(panel->dev->of_node, &dsi->orientation);
+	}
 
 	ret = mtk_dsi_encoder_init(drm, dsi);
 	if (ret)
-- 
2.36.1.124.g0e6072fb45-goog

