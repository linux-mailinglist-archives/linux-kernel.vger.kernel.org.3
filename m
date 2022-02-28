Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663EC4C77F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbiB1Sge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbiB1SgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:36:00 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CCF3CA51
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:22:44 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso6626483wmr.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cs4oiNLGrG4rkfQh2GpvzYgFuRxicCeUCStQpjor4rs=;
        b=lGdS45PKQZbJe4/0iQ/CgeECjEa+Rees/Fgu//qqVMmZ9UlBUANNOv4rroTC/YKdDO
         O7+SDuokIis9xQEoxZao9e0nuFtEhyNqpeUDaSqnbXPndFS3l8rYe2h3F1pu17+gYk13
         +LivbegQAAqRZNU99ZbQULZU2Zyh0Hk2pt9ZWF9Jq5g3ku1h9I7rpKCfrzBpYpV7Xi/d
         1VNJzDQN9n8O6POIAA8I8oPL5KX3Lecl2iNfqqf6jCjToSkBwDFUqxSQldEJLZBCUu/k
         KG/QuBg7TuiW10aM/rgorVPrwX55PoFfWpM3mnEwtSHHMO9aLE9PKKbqa1ERM73JEtwr
         wlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cs4oiNLGrG4rkfQh2GpvzYgFuRxicCeUCStQpjor4rs=;
        b=XIluJYwGFOvIYtsv4HkrfLjN9qvSXg98PAWXrlq/CMCK6pqATvc20xtym7Lt/P88bI
         BoAqoF4Ytn7pRIgt5i1DXqaC1Qsy8pEqUkAiwyUpHV1NOTpVEU8BOF3hV5U3BtkOEu9G
         2Zk8yO6o1a8EhGLaAcd5mXU/u+lemmh4Ufbash+8GZqFaA7yuDUIct6WjQrlgVns2QrZ
         jRYheUtYGjyvvlblr9xRStp5Nnl5HOeKTjBggW/8Fhj5UIXeqBjevmdlzH9AqaS5Z2fJ
         mHLhGd+b4+GqINN998IAMEWmLVfQkb3FRCuBhcElydiXI4thERqpwyNe4+RzmG/ziYVG
         6jsg==
X-Gm-Message-State: AOAM531iI4nL+xiiTSX8ikyFYG8av93MHcSuMYtCjTG9nYzD9CzWEvqt
        lRE+W8NLeuck/TAIu24nvlo=
X-Google-Smtp-Source: ABdhPJxKLUxQmWwGxkQvXxCXzjNKHTeoMCKmG+aNO7A5ky9iq2fX9OSCC1SCxPOgCtYF1yvE9OhT9Q==
X-Received: by 2002:a7b:c30d:0:b0:381:4bb9:eede with SMTP id k13-20020a7bc30d000000b003814bb9eedemr9277539wmj.74.1646072563266;
        Mon, 28 Feb 2022 10:22:43 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id i12-20020adfe48c000000b001ef6eab4c81sm10654057wrm.96.2022.02.28.10.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:22:42 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     andrzej.hajda@intel.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        p.zabel@pengutronix.de, maxime@cerno.tech,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/bridge: nwl-dsi: switch to devm_drm_of_get_bridge
Date:   Mon, 28 Feb 2022 19:22:26 +0100
Message-Id: <20220228182226.21888-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/bridge/nwl-dsi.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index af07eeb47ca0..df3be9dd24fb 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -909,19 +909,12 @@ static int nwl_dsi_bridge_attach(struct drm_bridge *bridge,
 {
 	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
 	struct drm_bridge *panel_bridge;
-	struct drm_panel *panel;
-	int ret;
 
-	ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &panel,
-					  &panel_bridge);
-	if (ret)
-		return ret;
+	panel_bridge = devm_drm_of_get_bridge(dsi->dev, dsi->dev->of_node,
+					      1, 0);
+	if (IS_ERR(panel_bridge))
+		return PTR_ERR(panel_bridge);
 
-	if (panel) {
-		panel_bridge = drm_panel_bridge_add(panel);
-		if (IS_ERR(panel_bridge))
-			return PTR_ERR(panel_bridge);
-	}
 	dsi->panel_bridge = panel_bridge;
 
 	if (!dsi->panel_bridge)
-- 
2.25.1

