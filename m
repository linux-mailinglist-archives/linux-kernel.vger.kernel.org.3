Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A54D4AD254
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348448AbiBHHh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348400AbiBHHhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:37:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027D5C0401F6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 23:37:24 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id qe15so5929048pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 23:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B51vztbAqanx3odcGYslN+f+8QXuSl3IGdZkOcgCEP4=;
        b=B11JIsqRugzE1lPzLbVrLBxQRW5fnSgxLSLKgwr1IROc+g9ZzYhWrC1z2DTdGwYxxc
         zTZC5C6/ehGlzMo1J6qtuwveXNMaFeY7njbnbEiu43w4jwaanMcHAXwYob4oTe4haPpH
         OSqw2rNF9vvlgVMfdSEmvclOIi10EZASOCcpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B51vztbAqanx3odcGYslN+f+8QXuSl3IGdZkOcgCEP4=;
        b=YRHpSibMufYBypd2tUx+l+6ABLy1fDTeK+oD7UcAf3ADWUWQp35JZ0T0MkDta4zzEH
         rUhfVl7RUHkTm5kSlnXJIgAaj8LOanzHAX4DcS8BJjYREXDuIuQhvfr0XoM3SrWU02Gn
         4IvJFRW+HiB6ws8EznbV4rMI+7jb0/orE5ZvIDc7yHzVW/RbS3f1lClqjK7eE1rVrsfV
         D4sTLMbgPeHGE+xOnpxQQwaGEUgeVaJE8eR/mWCEyZciQ3jXswRbfpiGWs33XIXWhRh+
         89yZdF0iiXpgOZQTBqbGL0Qk9+jjBEDannpILaLvVywye9z7LiVsRyrk/SvI8n2i3pHe
         wh8A==
X-Gm-Message-State: AOAM533ie5uMRk3hd2jkrMiA0FvGkaZBN7U4cmdpRJVZ+yZ5QhrB/k6N
        SUq0WS/iOuSL0yMBBz6WQ83wpg==
X-Google-Smtp-Source: ABdhPJxwrTpJBtY7yw1Sd0APOFBVLEGy3Kepc+/jvxRR/t7rzd5FBc9Yf4VRdbT05jYEsKVObL+Oiw==
X-Received: by 2002:a17:902:7609:: with SMTP id k9mr2997567pll.143.1644305843446;
        Mon, 07 Feb 2022 23:37:23 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:7d9a:166e:9d34:ff4f])
        by smtp.gmail.com with ESMTPSA id ip5sm1677243pjb.13.2022.02.07.23.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 23:37:23 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Simon Ser <contact@emersion.fr>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v7 2/3] drm/mediatek: init panel orientation property
Date:   Tue,  8 Feb 2022 15:37:13 +0800
Message-Id: <20220208073714.1540390-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208073714.1540390-1-hsinyi@chromium.org>
References: <20220208073714.1540390-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Init panel orientation property after connector is initialized. Let the
panel driver decides the orientation value later.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 5d90d2eb001935..491bf5b0a2b984 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -965,6 +965,13 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 		ret = PTR_ERR(dsi->connector);
 		goto err_cleanup_encoder;
 	}
+
+	ret = drm_connector_init_panel_orientation_property(dsi->connector);
+	if (ret) {
+		DRM_ERROR("Unable to init panel orientation\n");
+		goto err_cleanup_encoder;
+	}
+
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
 	return 0;
-- 
2.35.0.263.gb82422642f-goog

