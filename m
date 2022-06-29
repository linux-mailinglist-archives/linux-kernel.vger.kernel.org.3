Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C494560555
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiF2QGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiF2QGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:06:04 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1015BF46
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:06:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 145so1631626pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=notPBC4MnqP3/2b0DoBP3luF+le6LrZ0so+pTM6prWs=;
        b=NlCjvaxetubf24Z+sQZfc332yDLW4QSIKdokM9O2OcMgf3swcWTSFE70+NvWJG6RH6
         5KUa8cDpnS2Hlxm/E0AcW2EQ44MaKor8CzE1Rr8OUrOHZuWX9ucpten1Ll5u54CY07Jf
         iP/Ts5khXRN5mvLnEikY481Wpob2eMYx85b90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=notPBC4MnqP3/2b0DoBP3luF+le6LrZ0so+pTM6prWs=;
        b=jYA1WshXKoV3kYLxgOCzM4m6Jw1I2nevZyF70TBFDsfX9QpKQHpg9TRPphnRMHZWgc
         rXjd2OrGZd12MuEsDL12KCD1dmcoAwX+nwy4AmBuIymZf2med7OaLYC4lc6fcrLQkO6n
         Lcr7XW2NLNX/JCRjFxPk+hN2oivAtrCGBgx2UmeMt5Sp5gqal/LnETZ/9PC3d5pRK8l3
         XM6Gcqv+Qd70sEmDh2arPXB3/MIwp4JPI/vGz+BGp0G1K4quwIby0bsbeF9h4paQyduB
         n0MttvpN2Wczl2lYwrONUAEbzeOb8FMSrqQuct2slGhzrXYRJalDEI/BRbwY3dhCDSiQ
         THng==
X-Gm-Message-State: AJIora+uA88re382s8K5ru/VX0/3Zmy83J7zO/LVowyUP1Lj/OmFZthY
        Z6nH3VHwRKaPnlTu+KUIswT8zA==
X-Google-Smtp-Source: AGRyM1vg6eF7pHecOpH49930sygS1lu8vE8q9/o+9+HVT9Nz4uVBZw2Pt0NdQ0HZB4n2QPKkcQX5Og==
X-Received: by 2002:a05:6a00:22cb:b0:525:ba83:559a with SMTP id f11-20020a056a0022cb00b00525ba83559amr10977364pfj.54.1656518762463;
        Wed, 29 Jun 2022 09:06:02 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:9841:721:7d8b:4502])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902e3d300b00163f8ddf160sm11495350ple.161.2022.06.29.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 09:06:02 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>, Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/bridge: anx7625: Convert to devm_i2c_new_dummy_device()
Date:   Thu, 30 Jun 2022 00:05:47 +0800
Message-Id: <20220629160550.433980-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629160550.433980-1-hsinyi@chromium.org>
References: <20220629160550.433980-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the resource management.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 96 +++++++----------------
 1 file changed, 27 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 3710fa9ee0acd..f89e8151475f7 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2436,82 +2436,44 @@ static const struct drm_bridge_funcs anx7625_bridge_funcs = {
 static int anx7625_register_i2c_dummy_clients(struct anx7625_data *ctx,
 					      struct i2c_client *client)
 {
-	int err = 0;
+	struct device *dev = &ctx->client->dev;
 
-	ctx->i2c.tx_p0_client = i2c_new_dummy_device(client->adapter,
-						     TX_P0_ADDR >> 1);
+	ctx->i2c.tx_p0_client = devm_i2c_new_dummy_device(dev, client->adapter,
+						TX_P0_ADDR >> 1);
 	if (IS_ERR(ctx->i2c.tx_p0_client))
 		return PTR_ERR(ctx->i2c.tx_p0_client);
 
-	ctx->i2c.tx_p1_client = i2c_new_dummy_device(client->adapter,
-						     TX_P1_ADDR >> 1);
-	if (IS_ERR(ctx->i2c.tx_p1_client)) {
-		err = PTR_ERR(ctx->i2c.tx_p1_client);
-		goto free_tx_p0;
-	}
+	ctx->i2c.tx_p1_client = devm_i2c_new_dummy_device(dev, client->adapter,
+						TX_P1_ADDR >> 1);
+	if (IS_ERR(ctx->i2c.tx_p1_client))
+		return PTR_ERR(ctx->i2c.tx_p1_client);
 
-	ctx->i2c.tx_p2_client = i2c_new_dummy_device(client->adapter,
-						     TX_P2_ADDR >> 1);
-	if (IS_ERR(ctx->i2c.tx_p2_client)) {
-		err = PTR_ERR(ctx->i2c.tx_p2_client);
-		goto free_tx_p1;
-	}
+	ctx->i2c.tx_p2_client = devm_i2c_new_dummy_device(dev, client->adapter,
+						TX_P2_ADDR >> 1);
+	if (IS_ERR(ctx->i2c.tx_p2_client))
+		return PTR_ERR(ctx->i2c.tx_p2_client);
 
-	ctx->i2c.rx_p0_client = i2c_new_dummy_device(client->adapter,
-						     RX_P0_ADDR >> 1);
-	if (IS_ERR(ctx->i2c.rx_p0_client)) {
-		err = PTR_ERR(ctx->i2c.rx_p0_client);
-		goto free_tx_p2;
-	}
+	ctx->i2c.rx_p0_client = devm_i2c_new_dummy_device(dev, client->adapter,
+						RX_P0_ADDR >> 1);
+	if (IS_ERR(ctx->i2c.rx_p0_client))
+		return PTR_ERR(ctx->i2c.rx_p0_client);
 
-	ctx->i2c.rx_p1_client = i2c_new_dummy_device(client->adapter,
-						     RX_P1_ADDR >> 1);
-	if (IS_ERR(ctx->i2c.rx_p1_client)) {
-		err = PTR_ERR(ctx->i2c.rx_p1_client);
-		goto free_rx_p0;
-	}
+	ctx->i2c.rx_p1_client = devm_i2c_new_dummy_device(dev, client->adapter,
+						RX_P1_ADDR >> 1);
+	if (IS_ERR(ctx->i2c.rx_p1_client))
+		return PTR_ERR(ctx->i2c.rx_p1_client);
 
-	ctx->i2c.rx_p2_client = i2c_new_dummy_device(client->adapter,
-						     RX_P2_ADDR >> 1);
-	if (IS_ERR(ctx->i2c.rx_p2_client)) {
-		err = PTR_ERR(ctx->i2c.rx_p2_client);
-		goto free_rx_p1;
-	}
+	ctx->i2c.rx_p2_client = devm_i2c_new_dummy_device(dev, client->adapter,
+						RX_P2_ADDR >> 1);
+	if (IS_ERR(ctx->i2c.rx_p2_client))
+		return PTR_ERR(ctx->i2c.rx_p2_client);
 
-	ctx->i2c.tcpc_client = i2c_new_dummy_device(client->adapter,
-						    TCPC_INTERFACE_ADDR >> 1);
-	if (IS_ERR(ctx->i2c.tcpc_client)) {
-		err = PTR_ERR(ctx->i2c.tcpc_client);
-		goto free_rx_p2;
-	}
+	ctx->i2c.tcpc_client = devm_i2c_new_dummy_device(dev, client->adapter,
+						TCPC_INTERFACE_ADDR >> 1);
+	if (IS_ERR(ctx->i2c.tcpc_client))
+		return PTR_ERR(ctx->i2c.tcpc_client);
 
 	return 0;
-
-free_rx_p2:
-	i2c_unregister_device(ctx->i2c.rx_p2_client);
-free_rx_p1:
-	i2c_unregister_device(ctx->i2c.rx_p1_client);
-free_rx_p0:
-	i2c_unregister_device(ctx->i2c.rx_p0_client);
-free_tx_p2:
-	i2c_unregister_device(ctx->i2c.tx_p2_client);
-free_tx_p1:
-	i2c_unregister_device(ctx->i2c.tx_p1_client);
-free_tx_p0:
-	i2c_unregister_device(ctx->i2c.tx_p0_client);
-
-	return err;
-}
-
-static void anx7625_unregister_i2c_dummy_clients(struct anx7625_data *ctx)
-{
-	i2c_unregister_device(ctx->i2c.tx_p0_client);
-	i2c_unregister_device(ctx->i2c.tx_p1_client);
-	i2c_unregister_device(ctx->i2c.tx_p2_client);
-	i2c_unregister_device(ctx->i2c.rx_p0_client);
-	i2c_unregister_device(ctx->i2c.rx_p1_client);
-	i2c_unregister_device(ctx->i2c.rx_p2_client);
-	i2c_unregister_device(ctx->i2c.tcpc_client);
 }
 
 static int __maybe_unused anx7625_runtime_pm_suspend(struct device *dev)
@@ -2723,8 +2685,6 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	if (!platform->pdata.low_power_mode)
 		pm_runtime_put_sync_suspend(&client->dev);
 
-	anx7625_unregister_i2c_dummy_clients(platform);
-
 free_wq:
 	if (platform->workqueue)
 		destroy_workqueue(platform->workqueue);
@@ -2754,8 +2714,6 @@ static int anx7625_i2c_remove(struct i2c_client *client)
 	if (!platform->pdata.low_power_mode)
 		pm_runtime_put_sync_suspend(&client->dev);
 
-	anx7625_unregister_i2c_dummy_clients(platform);
-
 	if (platform->pdata.audio_en)
 		anx7625_unregister_audio(platform);
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

