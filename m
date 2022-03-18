Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11E24DD62E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiCRIao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiCRIag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:30:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF26924B0B2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:29:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s11so8825034pfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q2qDv8+2Xs33bi39/5/bjWNq0xuzMLMZxKb+gV1x31A=;
        b=eTONqs9Y3piBGOdMGuMMcivDYzwSqMFZNucfhrjl17FHlTN4WIDwk19K4HOLMrk1iG
         Z9JW2BgOFS6i/9zHUZ4edoYzRasX/YYBjOmMTiYZs7tNSG0obMlHx/UiAhEyi5mPC4pm
         v6CMgLmDzK6uqrkCKkhh8Yn/oXduyc8b1UTyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2qDv8+2Xs33bi39/5/bjWNq0xuzMLMZxKb+gV1x31A=;
        b=Rzd8yBmR+T8nQbeCI332D8EZpaH63ZwwGDVtx1lFOSmn7WVr0Se6ufQb1hSwIdvjPC
         BcUv+Hk/XsfdhPLv6265+KY7gRBo6riRHq+0tqiZLA3/4G43c+TGkCu262vAeZk8G3ME
         cRltYsfWqaB4NI6N3LssyZ+PlQKN3CrlpK1gLPCzFPa62WkQp7zCN71VpPfGWPzaJ7mV
         D0JI9YNb23YnkKS9BOuUec8dIG8jpc6BLwlni75EZPxVHxxq3IS2EPQHRfN2Lll+1nkQ
         eZKgjjX/4PbquviCzIJAZxAIgfxU+oYUMSilQ4e+Mf3fOXVcvfokPC6VT6e+gOuKrAt7
         fObQ==
X-Gm-Message-State: AOAM532Tl5QfWSWO8A46LmUJ4ZkY75vrdwNm9oSzFJYdKyZkDLRubUqK
        l0MxXJ4iCVLKUCrcUednHUgMIg==
X-Google-Smtp-Source: ABdhPJwY+UTwJjQ5VdFDo/eVbZpRc9OL3AwGqrGv0hDioITcQk7K+bwpwLu/Vcu5+u/31peEfDYCaQ==
X-Received: by 2002:a05:6a00:1310:b0:4ca:cc46:20c7 with SMTP id j16-20020a056a00131000b004cacc4620c7mr9191847pfu.44.1647592158327;
        Fri, 18 Mar 2022 01:29:18 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:435a:ce78:7223:1e88])
        by smtp.gmail.com with ESMTPSA id q2-20020a056a00084200b004f761a7287dsm9404044pfk.131.2022.03.18.01.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 01:29:18 -0700 (PDT)
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
        Jani Nikula <jani.nikula@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v9 2/4] drm/mediatek: init panel orientation property
Date:   Fri, 18 Mar 2022 15:48:23 +0800
Message-Id: <20220318074825.3359978-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220318074825.3359978-1-hsinyi@chromium.org>
References: <20220318074825.3359978-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index ccb0511b9cd5..0376b33e9651 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -810,6 +810,13 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
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
2.35.1.894.gb6a874cedc-goog

