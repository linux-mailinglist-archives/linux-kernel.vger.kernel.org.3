Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF77481610
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 19:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhL2SkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 13:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhL2SkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 13:40:01 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E39C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 10:40:01 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id kk22so20024663qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 10:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YBrfMQBHSFL3SwPa7Nc8DH1A9jwH7Mgo9sxeYlvNd9Y=;
        b=BEv/5Y4SVKKX3QEEMCdR7CZ+MjTuAUdiJRaJg3TbEd2GDZ8pTaYPIBHtnuSPAAYQUK
         PjRBTTBzf3I0XyjNx+hZTAGpbrpf9JcUYPdLbDmblPljuYiARBKd+2/XCUXcWBk/nVz+
         8dLbBNd6iZZiBLPKPrQS2LIIXbiqIEmrCCVHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YBrfMQBHSFL3SwPa7Nc8DH1A9jwH7Mgo9sxeYlvNd9Y=;
        b=AEgoBySsal2AHHTDjRUqsp+pjQAJLCLnaKnNGP3sWA4AhqCLvt1ZnWgDFxG6Il16Fa
         g5isAlMHM8wD5eIxv09q/1fUEtImsiLW18zSbabQzvs06d2HlIilAuS7gZSoupcRkEx0
         eumeVFVKUWWBQC/am+9wxnHrbiBWZ6td5lmPDqFB3x6tQqHRuuGOJMuRKqOZ9ZFhaKO1
         42MENgAo7eNBLhW5TDv1jjFEwSDaYBeJlZI5Va5CZI7yp0/yNHwammXOVyQRCdhJ+NvQ
         EGF9mbGoLgDEARaGLHAyrGunVIloVGo2jtgeSzBi+WCo5ys/4fPwE40ZcXG7m+klLSAV
         YBig==
X-Gm-Message-State: AOAM532K9mpONU5Ikc1JRHlu24raUoqQlwBFV3qMhyDluWU3q4ibntDV
        DdM3uRP1ooFfHVL25VeHfNRIiA==
X-Google-Smtp-Source: ABdhPJwLJKiEU6WeYBu00grxag0IJalt5yCfThPEhv3NPi0FDfPo6yK8gzVJZDdRCvmSz4Ae7gLLcA==
X-Received: by 2002:ad4:4752:: with SMTP id c18mr24170961qvx.96.1640803199453;
        Wed, 29 Dec 2021 10:39:59 -0800 (PST)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:2258:17ef:b383:8855])
        by smtp.gmail.com with ESMTPSA id u11sm19256334qtw.29.2021.12.29.10.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:39:59 -0800 (PST)
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
Date:   Wed, 29 Dec 2021 13:39:50 -0500
Message-Id: <20211229183955.791957-1-markyacoub@chromium.org>
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
index 0ad7157660afa..7cf71705775f0 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1040,6 +1040,13 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 		goto err_cleanup_encoder;
 	}
 
+	// A drm_panel can have its own orientation. If there is no panel, set the
+	// orientation to NORMAL.
+	if (!dsi->panel) {
+		drm_connector_set_panel_orientation(
+			dsi->connector, DRM_MODE_PANEL_ORIENTATION_NORMAL);
+	}
+
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
 	return 0;
-- 
2.34.1.448.ga2b2bfdf31-goog

