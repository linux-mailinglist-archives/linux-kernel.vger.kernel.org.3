Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D94485A91
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244408AbiAEVXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244390AbiAEVXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:23:40 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014B9C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:23:39 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 131so763217qkk.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 13:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zY0MGgHszlxJMiljmXEEiC1wEzxNY+uDQh+HxW5Uns4=;
        b=cWg7/JPddxtwQJ/HOgH3+oR1fhhnoQiqZH2jvDD93PkRI29IfqGagjO+gqGHJZVHZL
         v858zBw1z4lhms6W8dT4DFgbRNErR6ajZR6b10djp2d2/I0nFi21wGQEL6n4qGadZNoS
         3Lo7j7a8BgtoUBHMLbOI6m/Z2G+dzpcDPSwl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zY0MGgHszlxJMiljmXEEiC1wEzxNY+uDQh+HxW5Uns4=;
        b=ESzQB3ePJ819N7ldra6zqskySy89WluPIM6s2PHz6FQ+lp6AtBV+pnjsuq7QKQRoCn
         wUFuJTkstCEIijYbCqthgLBF4RHmH+mG6zBPcjX0f982JSnFWPYVOtplfXs41c+k1mAp
         d4lbLfjfnRhwYt8mN6wleyNwnYqzPSMYxfJeO7EM7d8qinXVAEMzZTihxu/F9N5Crkf8
         MZQSAvTgXdSCJg+pubs4K6qQ+fZw8Zrcb4aV3XuUquEUecicWopS7Et7eZ/2beZXI9TQ
         WYiBT7zVtSAgSFBigdn/bgyr9uDSUcBMcmbe8E2YJbfwGPfagrGeaAVEF/ZBrznYcXrW
         32xQ==
X-Gm-Message-State: AOAM530wHc4bqOYHQ3DAcoDHQ+F/m4oePh6hF9MYyULJ2rRgsRAs7b+k
        OKLOf6y0/paG8kDlYkW26hzxLQ==
X-Google-Smtp-Source: ABdhPJxEyFhumzU211wdXGQ8UbL2PChXeuyZYivpZy17HeB7BR5gVki7gW29chV6s0DnDIezHae+2w==
X-Received: by 2002:a37:a70d:: with SMTP id q13mr3984850qke.84.1641417818960;
        Wed, 05 Jan 2022 13:23:38 -0800 (PST)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:e210:d796:8522:dada])
        by smtp.gmail.com with ESMTPSA id w63sm32384108qkd.88.2022.01.05.13.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 13:23:38 -0800 (PST)
From:   Mark Yacoub <markyacoub@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     seanpaul@chromium.org, markyacoub@google.com,
        markyacoub@chromium.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        jason-jh.lin@mediatek.com, tzungbi@google.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/mediatek: Set default value for Panel Orientation connector prop.
Date:   Wed,  5 Jan 2022 16:23:27 -0500
Message-Id: <20220105212330.2199045-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211229184420.793234-1-markyacoub@chromium.org>
References: <20211229184420.793234-1-markyacoub@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Why]
Creating the prop uses UNKNOWN as the initial value, which is not a
supported value if the prop is to be supported.

[How]
Set the panel orientation default value to NORMAL right after creating
the prop if no DSI panel exists.
Panels have their own orientations, and panel orientation can't be
overriden once initialized to a value.

v2:
Move to the latest code where struct mtk_dsi{} has no member 'panel'.
v1:
Set panel orientation only if DSI panel does not exist.

Tested on Jacuzzi(MTK)
Fixes IGT@kms_properties@get_properties-sanity-{atomic,non-atomic}

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 5d90d2eb00193..9e1d4e297ca48 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -941,8 +941,10 @@ static const struct mipi_dsi_host_ops mtk_dsi_ops = {
 	.transfer = mtk_dsi_host_transfer,
 };
 
-static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
+static int mtk_dsi_encoder_init(struct device *dev, struct drm_device *drm)
 {
+	struct mtk_dsi *dsi = dev_get_drvdata(dev);
+	struct drm_panel *panel;
 	int ret;
 
 	ret = drm_simple_encoder_init(drm, &dsi->encoder,
@@ -967,6 +969,15 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 	}
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &panel,
+					  &dsi->next_bridge);
+	/* A drm_panel can have its own orientation. If there is no panel, set the
+	 * orientation to NORMAL. */
+	if (ret || !panel) {
+		drm_connector_set_panel_orientation(
+			dsi->connector, DRM_MODE_PANEL_ORIENTATION_NORMAL);
+	}
+
 	return 0;
 
 err_cleanup_encoder:
@@ -976,11 +987,8 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 
 static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
 {
-	int ret;
 	struct drm_device *drm = data;
-	struct mtk_dsi *dsi = dev_get_drvdata(dev);
-
-	ret = mtk_dsi_encoder_init(drm, dsi);
+	int ret = mtk_dsi_encoder_init(dev, drm);
 	if (ret)
 		return ret;
 
-- 
2.34.1.448.ga2b2bfdf31-goog

