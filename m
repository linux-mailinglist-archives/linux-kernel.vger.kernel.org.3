Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007CC4C7801
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiB1SjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbiB1Sid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:38:33 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56FC4614C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:26:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so16805947wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NM2ZhSOgeRHdN1vkJcDiGjO8C/zSOTco+Z9Yb+OtTAU=;
        b=azouk0SiCDcaOY3VkjJqxF9J1KvwFRFzKYCQ476RROqMAaaYNQ7Llb33rcrRmUkIdI
         se/BkXGpPXRTF01eIwZF9604v1uwjpwIZ0XrECxqeF0RS5SXiPzOTRQ0/CkELjlOxbih
         noyocMKO/JixaYB8L2xbLszjTdmf4GDk8ssD98jnMmxy2WjCYiCi7EjoQRroiSLGRQ44
         IyKnHHQZhtstmV6oZO2PUYqtQgxWXPhbuxvRx0rs/4jlCtJNrlnf2PqmERRVkPs6wHqB
         29qTfYq+TGM8p/ei4G/dkPzUnDwE3Q2KQ+TWUMmlPpFmHvztyQ67qzA8/b+lcccji2kH
         0btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NM2ZhSOgeRHdN1vkJcDiGjO8C/zSOTco+Z9Yb+OtTAU=;
        b=c5WTYvup8Sawr6iDAPoyzbuehWdaTa953bUgtw6MvCaxo45kYxw5YP00ZrvH/4k9oY
         2vA8jDEO/+dUAxj6SBjn9EEklkohg2vcxTeBzTDZw7KveqAzdgE69aY3bs7pAicEQ40G
         Zu5cpLlHMxmH6JBTUNdZyi4jhNQfADKERFgjiOY0bPaYQsjx6yN9W2utIOmy5AdvEf2P
         0DfHsdczX0f+qWaFTcw7BPNTxreuivQsmsM48XpkGkv7p795V0aaVBiCZ3iHnHiY3JKl
         HvQGhAzmaJWUwC6hVLlR3aOuBPYOoLPxdxq2sifs26Kd3gLPFQnaA1bQAyrga2VZwMbi
         sdGQ==
X-Gm-Message-State: AOAM532jBOPTwzkAkk85piCYLvt9cvufVGMYk04vfUJDY9+Yeimvz0WQ
        R2Fz+pSkW8vDrBgoq102qX0=
X-Google-Smtp-Source: ABdhPJxQtBUWZoIjif+v/uhsqfy9wl/Eoo6gd2uZzb0YEfp2Y9hJpppW6JLB/diOkKfjPK3QGN/LBg==
X-Received: by 2002:a05:6000:1866:b0:1ef:8a14:ab6a with SMTP id d6-20020a056000186600b001ef8a14ab6amr8856121wri.12.1646072773210;
        Mon, 28 Feb 2022 10:26:13 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id q11-20020adfcd8b000000b001e320028660sm11099011wrj.92.2022.02.28.10.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:26:12 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     andrzej.hajda@intel.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        maxime@cerno.tech, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/bridge: nxp-ptn3460: switch to devm_drm_of_get_bridge
Date:   Mon, 28 Feb 2022 19:26:00 +0100
Message-Id: <20220228182600.22463-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index e941c1132598..1ab91f4e057b 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -263,7 +263,6 @@ static int ptn3460_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct ptn3460_bridge *ptn_bridge;
 	struct drm_bridge *panel_bridge;
-	struct drm_panel *panel;
 	int ret;
 
 	ptn_bridge = devm_kzalloc(dev, sizeof(*ptn_bridge), GFP_KERNEL);
@@ -271,11 +270,7 @@ static int ptn3460_probe(struct i2c_client *client,
 		return -ENOMEM;
 	}
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &panel, NULL);
-	if (ret)
-		return ret;
-
-	panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 0, 0);
 	if (IS_ERR(panel_bridge))
 		return PTR_ERR(panel_bridge);
 
-- 
2.25.1

