Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7604C7821
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbiB1Sl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbiB1Slh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:41:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4263E54BD3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:35:43 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c192so6219079wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XWE8ka0LFITuVWLTsvK0XnLYaX+ahuY1DLqYbhtqPVM=;
        b=fhg7jpYf1EYHHy4sAaAQg8FUpD08rHouaef4QgIbFmDlV/OB0oARBG55IS0Vs6V7RM
         dz1g6KwYdqfXj8/RsQiP30R9Vsy4j0+9+90azseP39z+yyaDaTIR3o0saIcI0j3ONmGp
         /f5z4djXrqFENtGpVcKk6MIwkg81alkL2gPZgrjTjqO6rp0ITjedEQorl6w2nQxqQqia
         7YeF5sP/D2kJomyggm4iB9PAa1WwbwGAKIsgBiJM/WQIg1mPwiUBLbwFKYWz8RORrDrp
         pCQLJArueazRmcCsFyK7FLRFqlLoqTSoPbfR4dL8g6+wY22pXI0ZidCNDoEuP0NpDoga
         rz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XWE8ka0LFITuVWLTsvK0XnLYaX+ahuY1DLqYbhtqPVM=;
        b=R61vif8/Qrlt8CnzRvhZ2Mcjdl43AkkOVb5wCrLdmQRGSOEApPD5c08B4Sfy5AlO75
         BIeIws/ZJjeFQcX3/a1Rp07SvGQWb5aC0o3jipLBzB8UQ/yQZw5aCecyAK2UpnDqPKTl
         0PPfjs/nMqRwHUKWqDECai/ztemy47snMsn5xYsHasQpnoS51cjuAnueIyNLni68wGhY
         ZJeEpHOeZqy5A9Jmj406u0VvYIpJIQU98vlK02/U6iR3y05305/M1JadD6sd1e9CEcqV
         Gerk2xtXqfWRGxKJqtc/rzJ6aXwQC35WM0PvyYLfQf0tRzOaEQ6v2KFDKy7E/oRDxoqF
         DdzA==
X-Gm-Message-State: AOAM5323PFVO0bAgPB3qQ+TRqbGd+qTYGgVtjhwzkiULzrYHW8vgvRa8
        LLRxWKBXa7byFFkinECDBo4=
X-Google-Smtp-Source: ABdhPJwV3VqdHtOu+yvIpbun8KXIm09AgnYoutTtzWN3kkuBLC0rMsfci3Y49igHiesLNf6e99/m3g==
X-Received: by 2002:a1c:544a:0:b0:37f:a9c8:d598 with SMTP id p10-20020a1c544a000000b0037fa9c8d598mr14285948wmi.26.1646073341878;
        Mon, 28 Feb 2022 10:35:41 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id x5-20020adfec05000000b001e58cc95affsm11351387wrn.38.2022.02.28.10.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:35:41 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     andrzej.hajda@intel.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        maxime@cerno.tech, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/bridge: tc358775: switch to devm_drm_of_get_bridge
Date:   Mon, 28 Feb 2022 19:35:37 +0100
Message-Id: <20220228183537.24600-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/bridge/tc358775.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 2c76331b251d..b158e5ad561c 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -649,7 +649,6 @@ static int tc_attach_host(struct tc_data *tc)
 static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
-	struct drm_panel *panel;
 	struct tc_data *tc;
 	int ret;
 
@@ -660,14 +659,8 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	tc->dev = dev;
 	tc->i2c = client;
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, TC358775_LVDS_OUT0,
-					  0, &panel, NULL);
-	if (ret < 0)
-		return ret;
-	if (!panel)
-		return -ENODEV;
-
-	tc->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+	tc->panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node,
+						  TC358775_LVDS_OUT0, 0);
 	if (IS_ERR(tc->panel_bridge))
 		return PTR_ERR(tc->panel_bridge);
 
-- 
2.25.1

