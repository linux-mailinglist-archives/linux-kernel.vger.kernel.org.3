Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829A44DCD16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiCQSAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiCQSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:00:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AC019BE65
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:59:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r7so3580082wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sh7ajWZOEvGP7QGaACeQjOdADbKbBQm2vBjS6fPkwu8=;
        b=O2EWkjBkFX0RVZ4CHcgJ2DN31cS4P3BF6pgRry0OacsqxdAemG9tYwNlAFpFtvsJAA
         ZFoNz0FvTEVXIAi/O6QEUzAcpolAXDAdIklouW6y0IDytbh8NVM0YgRWheUxK/FN6sF2
         vbqLGakIfH5rBFfoQeXX1VnCp1pZuO+PdwNp0CbF4Ol0mgNTYhZAWKkBMI+5EaoNYg/g
         SVzNEyNmQxrJuElmBSxQi98UXMMxogM6CHdCj5+2gIj1Z4qpMZmAXYxF6JPUT3Va+X6s
         kPmnESJQH9nCLjIXyUIS4C/UR1HBGT16vQDjBLkVhZcHDGz661IEXrv57QX/O4JfftXI
         C/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sh7ajWZOEvGP7QGaACeQjOdADbKbBQm2vBjS6fPkwu8=;
        b=FeNerxnXE9K2mraLD3NZR2lwN2Wig0zYERcU6ilxJchhAwZhQty5xp/CeiK+tpm5/R
         mrlday7NjB4d4Kn6h4Wm86yiW2IUWN4j/vFa2jBmvUid02iWkk7FWzUPawRCcbkewFE4
         6oRDQDLtvpIicovzK3SMKFTj9llcTLf5tEKAa/B3sdGjJlBbQGQoeajx1KddFiIus7Pd
         k6L5+byiJZu9uSrELSoeGupEoyA0PtC944V9pKfUTFVuJ41weU67QiyfQrk/tOvpqv/K
         g57iujgo+Hkf+kVn7c0LsYUt1KFxSvyIpcJ92pQskyPH78GKfa7Ll7WIATvtXkhjKkAn
         KNjQ==
X-Gm-Message-State: AOAM531BF4P+cbNPAr5wH65o2QY/uif7UFcFm/Fz898uaf72M2f7frVV
        XoFYXC8QLGhx9t6DD7ixLYA=
X-Google-Smtp-Source: ABdhPJyHh9W6kvftdNRFbnkqJ6vyR9K3NBs4FFINPpETIazOXmmQSWJqwd8wLqHxxWwPFMeLyTAIVg==
X-Received: by 2002:a05:600c:3016:b0:38c:8786:d3b6 with SMTP id j22-20020a05600c301600b0038c8786d3b6mr522228wmh.135.1647539943049;
        Thu, 17 Mar 2022 10:59:03 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id n188-20020a1ca4c5000000b00389c692a3b5sm8035468wme.42.2022.03.17.10.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:59:02 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     victor.liu@oss.nxp.com
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, p.zabel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2] drm/bridge: nwl-dsi: switch to devm_drm_of_get_bridge
Date:   Thu, 17 Mar 2022 18:58:52 +0100
Message-Id: <20220317175852.799432-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The function "drm_of_find_panel_or_bridge" has been deprecated in
favor of "devm_drm_of_get_bridge".

Switch to the new function and reduce boilerplate.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2: (Thanks to Liu Ying)

 - Rebase on top of drm-misc-next
 - Remove drm_of_panel_bridge_remove
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index e34fb09b90b9..de62e3fc6a59 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -912,19 +912,11 @@ static int nwl_dsi_bridge_attach(struct drm_bridge *bridge,
 {
 	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
 	struct drm_bridge *panel_bridge;
-	struct drm_panel *panel;
-	int ret;
-
-	ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &panel,
-					  &panel_bridge);
-	if (ret)
-		return ret;
 
-	if (panel) {
-		panel_bridge = drm_panel_bridge_add(panel);
-		if (IS_ERR(panel_bridge))
-			return PTR_ERR(panel_bridge);
-	}
+	panel_bridge = devm_drm_of_get_bridge(dsi->dev, dsi->dev->of_node,
+					      1, 0);
+	if (IS_ERR(panel_bridge))
+		return PTR_ERR(panel_bridge);
 
 	if (!panel_bridge)
 		return -EPROBE_DEFER;
@@ -932,12 +924,6 @@ static int nwl_dsi_bridge_attach(struct drm_bridge *bridge,
 	return drm_bridge_attach(bridge->encoder, panel_bridge, bridge, flags);
 }
 
-static void nwl_dsi_bridge_detach(struct drm_bridge *bridge)
-{	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
-
-	drm_of_panel_bridge_remove(dsi->dev->of_node, 1, 0);
-}
-
 static u32 *nwl_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 						 struct drm_bridge_state *bridge_state,
 						 struct drm_crtc_state *crtc_state,
@@ -983,7 +969,6 @@ static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
 	.mode_set		= nwl_dsi_bridge_mode_set,
 	.mode_valid		= nwl_dsi_bridge_mode_valid,
 	.attach			= nwl_dsi_bridge_attach,
-	.detach			= nwl_dsi_bridge_detach,
 };
 
 static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
-- 
2.25.1

