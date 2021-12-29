Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4040481617
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 19:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhL2SoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 13:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhL2SoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 13:44:24 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE38AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 10:44:23 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id w27so14564053qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 10:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Shoj+Q3yMEhM9mNXjLtdxgk5LZJhKA/O7LXTWfiwLQM=;
        b=jgyyqpkTqrJBnuET9DIU54lJy4W8PO4nKpAL8mj0vtTNJ7L2teQmhIXYbq7PXu/bIP
         aF0tOBxel+clKcr1H23Y8mUqiVHiNuA3XeSKaES7ORtpX9JVc3Cz1vKhgW0vsIL0s3N1
         DfXRXFbSgYCEUFCzF5IigkowIGyEPx9Ac7RdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Shoj+Q3yMEhM9mNXjLtdxgk5LZJhKA/O7LXTWfiwLQM=;
        b=qnBBOJKl3iql3G5QZ17UVuoYO7+rf7tw2YRDzsI2b2IurqI0EB6+a7TzvUI1KaGDQg
         PusCQGlnQ7Yx/dTDdD2lERDyjAFo1nL66pF+2KyeLPKmaA2Ahf2VlhZ0fYZEopOWumAI
         ht80KH0ASC1bM9hUGabfUSlWX7DwVSTLnNhPOuqUhAhTMCxiMlcunM2PtdO4zZDfa3oO
         aENCjthSPkuqlgko5SBVx07rEPcf+c3m+1jBYnvo+KdN6dngKF3JMERg7e4vnzp3r0k6
         lKwf0+6uzbJSHJIpHi3A4oXv3hufErjQASAJ2K5O44OutoEYA5B6Kt0SWDZ42LTd2HzC
         Sg0w==
X-Gm-Message-State: AOAM5330rOwzlGrdwLbVs23l0qlfqJeboIjwzTeUdH7fe8V7Ugs3l5H/
        aJGXueNuvudC1kfBceBQe4ltdA==
X-Google-Smtp-Source: ABdhPJwiO+gX4HKdmMuEU6gcsV2DoE2Pu4VLhKUqPMTz+1itpbMofq19YOFiXpnHdZkSZhR/1fu46w==
X-Received: by 2002:a37:755:: with SMTP id 82mr19397299qkh.89.1640803463092;
        Wed, 29 Dec 2021 10:44:23 -0800 (PST)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:2258:17ef:b383:8855])
        by smtp.gmail.com with ESMTPSA id e7sm19130365qtx.72.2021.12.29.10.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:44:22 -0800 (PST)
From:   Mark Yacoub <markyacoub@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     seanpaul@chromium.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        jason-jh.lin@mediatek.com, tzungbi@google.com,
        Mark Yacoub <markyacoub@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/mediatek: Set default value for Panel Orientation connector prop.
Date:   Wed, 29 Dec 2021 13:44:18 -0500
Message-Id: <20211229184420.793234-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211022172413.195559-1-markyacoub@chromium.org>
References: <20211022172413.195559-1-markyacoub@chromium.org>
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

v1:
Set panel orientation only if DSI panel does not exist.

Tested on Jacuzzi(MTK)
Fixes IGT@kms_properties@get_properties-sanity-{atomic,non-atomic}

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 0ad7157660afa..9d33dd93118e0 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1040,6 +1040,13 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 		goto err_cleanup_encoder;
 	}
 
+	/* A drm_panel can have its own orientation. If there is no panel, set the
+	 * orientation to NORMAL. */
+	if (!dsi->panel) {
+		drm_connector_set_panel_orientation(
+			dsi->connector, DRM_MODE_PANEL_ORIENTATION_NORMAL);
+	}
+
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
 	return 0;
-- 
2.34.1.448.ga2b2bfdf31-goog

